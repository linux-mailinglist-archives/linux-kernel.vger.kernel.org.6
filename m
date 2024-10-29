Return-Path: <linux-kernel+bounces-386166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060BA9B3FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936BE2834BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF807130A7D;
	Tue, 29 Oct 2024 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSr+gpm7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAF74E09
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730166998; cv=none; b=CqBPgAJJF11b8teI1aAVxhGj3DTYuEx1wwqgSZL8N1OCJnZmpxDu+Bk59jHcYkvbylLeweK4GaiV9bCOu1ReNbmEWWRgVz8e26QeseVOVEoiW9dSz/F+DLbkULG+l/bgAgxX5W9sVmT3jvk0yxu9AtKUkAoYGCK4u9L1L1IiCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730166998; c=relaxed/simple;
	bh=ShKRJi9mJBJXWguLrtPuEJjUJyfAsPmcAibtmIEOQO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PF9BYM283qKbgyYCiDO1W7g5j5Vx69Z35bfrpShwb4rebZv4nUi7J42gnmffjjBdIEgxMmuxxL1+OHMwhIbqPZ4M/pb0sp14wN74UYdyQvpKPdw7QZTd+0XpF4kGd6U8pJNL1fH/TQn48EtVLg7SmwBHTPByzMQjTHkKWs8K9bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSr+gpm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3516CC4CECD;
	Tue, 29 Oct 2024 01:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730166997;
	bh=ShKRJi9mJBJXWguLrtPuEJjUJyfAsPmcAibtmIEOQO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSr+gpm7MdHVwqQbEDhdHQNjCS6PDXg7RsA6vbfcZ0da+Z2j6mO3IMFt2lpXgGpo+
	 z3L2qLDgooiXW3IubLxenWWI3QQYVhnXlwzXII+j54gb74ludg2PqnaiNXeRPbZz5H
	 C3hqFJ4HS9yy8aUUpqkFAOLyNQ512aF5hs/xIjKw2g/vr8yoelLIoRLeWhMrKdBXQe
	 RBjfryVchA2ZFhm0MJFVCl9KIIrmV6Qu03l65FAPhkFbUJNKx4yHRPQn82EmkCYdIn
	 d7+n62u9QJdmmAYNZbSkeklIP22DXp1wbYv7A26Fu/eLN32SA3tAYUnDzTXnR9c8Yn
	 dd3Vm/zhkTVEg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 1/6] x86/uaccess: Avoid barrier_nospec() in 64-bit copy_from_user()
Date: Mon, 28 Oct 2024 18:56:14 -0700
Message-ID: <5b887fe4c580214900e21f6c61095adf9a142735.1730166635.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730166635.git.jpoimboe@kernel.org>
References: <cover.1730166635.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The barrier_nospec() in 64-bit copy_from_user() is slow.  Instead use
pointer masking to force the user pointer to all 1's if the access_ok()
mispredicted true for an invalid address.

The kernel test robot reports a 2.6% improvement in the per_thread_ops
benchmark (see link below).

To avoid regressing powerpc and 32-bit x86, move their barrier_nospec()
calls to their respective raw_copy_from_user() implementations so
there's no functional change there.

Note that for safety on some AMD CPUs, this relies on recent commit
86e6b1547b3d ("x86: fix user address masking non-canonical speculation
issue").

Link: https://lore.kernel.org/202410281344.d02c72a2-oliver.sang@intel.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/powerpc/include/asm/uaccess.h | 2 ++
 arch/x86/include/asm/uaccess_32.h  | 1 +
 arch/x86/include/asm/uaccess_64.h  | 1 +
 include/linux/uaccess.h            | 6 ------
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 4f5a46a77fa2..12abb8bf5eda 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -7,6 +7,7 @@
 #include <asm/extable.h>
 #include <asm/kup.h>
 #include <asm/asm-compat.h>
+#include <asm/barrier.h>
 
 #ifdef __powerpc64__
 /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
@@ -341,6 +342,7 @@ static inline unsigned long raw_copy_from_user(void *to,
 {
 	unsigned long ret;
 
+	barrier_nospec();
 	allow_read_from_user(from, n);
 	ret = __copy_tofrom_user((__force void __user *)to, from, n);
 	prevent_read_from_user(from, n);
diff --git a/arch/x86/include/asm/uaccess_32.h b/arch/x86/include/asm/uaccess_32.h
index 40379a1adbb8..8393ba104b2c 100644
--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -23,6 +23,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 static __always_inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	barrier_nospec();
 	return __copy_user_ll(to, (__force const void *)from, n);
 }
 
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index b0a887209400..7ce84090f0ec 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -138,6 +138,7 @@ copy_user_generic(void *to, const void *from, unsigned long len)
 static __always_inline __must_check unsigned long
 raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
 {
+	src = mask_user_address(src);
 	return copy_user_generic(dst, (__force void *)src, size);
 }
 
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 39c7cf82b0c2..dda9725a9559 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -160,12 +160,6 @@ _inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 	unsigned long res = n;
 	might_fault();
 	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
-		/*
-		 * Ensure that bad access_ok() speculation will not
-		 * lead to nasty side effects *after* the copy is
-		 * finished:
-		 */
-		barrier_nospec();
 		instrument_copy_from_user_before(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 		instrument_copy_from_user_after(to, from, n, res);
-- 
2.47.0


