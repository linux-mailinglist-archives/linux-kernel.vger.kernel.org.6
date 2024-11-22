Return-Path: <linux-kernel+bounces-418712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E889D649B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36444160EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0512916DEA2;
	Fri, 22 Nov 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zbIUk29z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191725FDA7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303986; cv=none; b=ZPYnJcp/GYW+dKKGRvAdTaDdTu6RvbUmg2Hb/W42ws+ummy55+vx/ktkVbXOE1V+C0J00l2D82Z23DCMg0OCT54LFoUaThNF6cV/+9RZjYC2p/oYydYibqXKuM0Bw1ZUX3RwKG4GvAESZSYUWMeXZa+xCfe+ZMxaEXWFooL1fkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303986; c=relaxed/simple;
	bh=eHac7wXBP2nc6zd7pqCySoysfJLluSSENwrXxc+0s6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=acV7ETlGfzOyuPtWOx+k51aQCz7/qXnmCH1BzAnXu7nymLQEuj7XFAc1LGScwiQUMeja0ARaOXpRcvYce4hktfGRWeUurdeQrnhR3yl1xebtj9udOPgn3o4UUiypOU9m9ovq7ZXnRqm8NKrngUh5x4KytbV203VBCC4rzt8iv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zbIUk29z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53B5C4CECE;
	Fri, 22 Nov 2024 19:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732303985;
	bh=eHac7wXBP2nc6zd7pqCySoysfJLluSSENwrXxc+0s6k=;
	h=From:To:Cc:Subject:Date:From;
	b=zbIUk29zX6CxKgff59w+8QPou/gMczfUXqAlFdWsxsxXjx3Kkj1bvE/YBvE/ofJTg
	 TCbq508sy450hp+Im7pQFy3Y4sCdb6qfuQqm5rlp7xFRYnKtgn0y6gyren9Sq0obqm
	 f+mItZ51+qwDmW5un4RmsZwm9LdWcN2ksp2yI2Tw=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] futex: improve user space accesses
Date: Fri, 22 Nov 2024 11:33:05 -0800
Message-ID: <20241122193305.7316-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.47.0.293.g502c15559b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Josh Poimboeuf reports that he got a "will-it-scale.per_process_ops 1.9%
improvement" report for his patch that changed __get_user() to use
pointer masking instead of the explicit speculation barrier.  However,
that patch doesn't actually work in the general case, because some (very
bad) architecture-specific code actually depends on __get_user() also
working on kernel addresses.

A profile showed that the offending __get_user() was the futex code,
which really should be fixed up to not use that horrid legacy case.
Rewrite futex_get_value_locked() to use the modern user acccess helpers,
and inline it so that the compiler not only avoids the function call for
a few instructions, but can do CSE on the address masking.

It also turns out the x86 futex functions have unnecessary barriers in
other places, so let's fix those up too.

Link: https://lore.kernel.org/all/20241115230653.hfvzyf3aqqntgp63@jpoimboe/
Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/futex.h |  8 +++--
 kernel/futex/core.c          | 22 --------------
 kernel/futex/futex.h         | 59 ++++++++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 99d345b686fa..6e2458088800 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -48,7 +48,9 @@ do {								\
 static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		u32 __user *uaddr)
 {
-	if (!user_access_begin(uaddr, sizeof(u32)))
+	if (can_do_masked_user_access())
+		uaddr = masked_user_access_begin(uaddr);
+	else if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 
 	switch (op) {
@@ -84,7 +86,9 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 {
 	int ret = 0;
 
-	if (!user_access_begin(uaddr, sizeof(u32)))
+	if (can_do_masked_user_access())
+		uaddr = masked_user_access_begin(uaddr);
+	else if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 	asm volatile("\n"
 		"1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 326bfe6549d7..9833fdb63e39 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -451,28 +451,6 @@ struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb, union futex_key *
 	return NULL;
 }
 
-int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32 uval, u32 newval)
-{
-	int ret;
-
-	pagefault_disable();
-	ret = futex_atomic_cmpxchg_inatomic(curval, uaddr, uval, newval);
-	pagefault_enable();
-
-	return ret;
-}
-
-int futex_get_value_locked(u32 *dest, u32 __user *from)
-{
-	int ret;
-
-	pagefault_disable();
-	ret = __get_user(*dest, from);
-	pagefault_enable();
-
-	return ret ? -EFAULT : 0;
-}
-
 /**
  * wait_for_owner_exiting - Block until the owner has exited
  * @ret: owner's current futex lock status
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 8b195d06f4e8..323572014b32 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -6,6 +6,7 @@
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
 #include <linux/compat.h>
+#include <linux/uaccess.h>
 
 #ifdef CONFIG_PREEMPT_RT
 #include <linux/rcuwait.h>
@@ -225,10 +226,64 @@ extern bool __futex_wake_mark(struct futex_q *q);
 extern void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q);
 
 extern int fault_in_user_writeable(u32 __user *uaddr);
-extern int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32 uval, u32 newval);
-extern int futex_get_value_locked(u32 *dest, u32 __user *from);
 extern struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb, union futex_key *key);
 
+static inline int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32 uval, u32 newval)
+{
+	int ret;
+
+	pagefault_disable();
+	ret = futex_atomic_cmpxchg_inatomic(curval, uaddr, uval, newval);
+	pagefault_enable();
+
+	return ret;
+}
+
+/*
+ * This does a plain atomic user space read, and the user pointer has
+ * already been verified earlier by get_futex_key() to be both aligned
+ * and actually in user space, just like futex_atomic_cmpxchg_inatomic().
+ *
+ * We still want to avoid any speculation, and while __get_user() is
+ * the traditional model for this, it's actually slower then doing
+ * this manually these days.
+ *
+ * We could just have a per-architecture special function for it,
+ * the same way we do futex_atomic_cmpxchg_inatomic(), but rather
+ * than force everybody to do that, write it out long-hand using
+ * the low-level user-access infrastructure.
+ *
+ * This looks a bit overkill, but generally just results in a couple
+ * of instructions.
+ */
+static __always_inline int futex_read_inatomic(u32 *dest, u32 __user *from)
+{
+	u32 val;
+
+	if (can_do_masked_user_access())
+		from = masked_user_access_begin(from);
+	else if (!user_read_access_begin(from, sizeof(*from)))
+		return -EFAULT;
+	unsafe_get_user(val, from, Efault);
+	user_access_end();
+	*dest = val;
+	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+static inline int futex_get_value_locked(u32 *dest, u32 __user *from)
+{
+	int ret;
+
+	pagefault_disable();
+	ret = futex_read_inatomic(dest, from);
+	pagefault_enable();
+
+	return ret;
+}
+
 extern void __futex_unqueue(struct futex_q *q);
 extern void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb);
 extern int futex_unqueue(struct futex_q *q);
-- 
2.47.0.293.g502c15559b


