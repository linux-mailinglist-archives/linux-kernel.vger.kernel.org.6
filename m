Return-Path: <linux-kernel+bounces-386168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2559B3FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E6F1F23044
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB2187849;
	Tue, 29 Oct 2024 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idHj/cGY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7521714DF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730166999; cv=none; b=pG+EICWuRWxUNBN+YQFBRFZdA1sU0J9b2Bwf8qFyV7ji5UR8cxW1T48wWyaYRaLblJ3D3U+eXxFP9RVHooA4B8JQhBVucoSeoA+K1YS8ctpNOHMgoz+OcyMUR/O72eJXNBUzp5zWP41xnw6wyOPtwRKs5GkmQpAJk2NjgfAg4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730166999; c=relaxed/simple;
	bh=9rAK2frXr102qAp2BxkbEMrPlcwloGU9JexTUWLRWdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7dgVDcP9KLi74Bzaat8PNMHVSeH+JbmbHtd/9x1sZQRzUgiUb9wj6zUtQJgnCFvdKb7nx4JV+gZ+Rv2QO6usIrEyZzaaKmue07D/vJWb4XmV4o7JeQ0+sjmSLuDrSV3cYInePeXJwLfnuzmOhMDBWuToz1e2JrdadGBrAvh4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idHj/cGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B512EC4CEEA;
	Tue, 29 Oct 2024 01:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730166999;
	bh=9rAK2frXr102qAp2BxkbEMrPlcwloGU9JexTUWLRWdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idHj/cGYvZmY39VLR4VVUqKkiqy6kvzvZH4FIxdWPrCXtEM8XkhEBWtz0W5vUjmcY
	 Uz7OsUN4oOijkx+PlGoDF7atcx1MhS+kXwGQ7y6mntpPB8xZMZnJ+rNbRaIeB2kaa6
	 4BLj0AfzgiecryPuzJehIRehKDq9smwxIQxpSasBkYh4YHbN0mfzUgzRevi8YCSAgt
	 E1Fxa4uPv8fcd9vuYnzljzzk6A4uXXCpSBNamPPouBwGH5fPh6zckII8kjApbMxF5E
	 nRKe8pFkbrMkTTRO8g9u3z530B5CpnSBbckZ6UYsHHmeJdiKfAnuf9zjeKbopUxkJa
	 LDFX/7CcQfPpA==
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
Subject: [PATCH v3 3/6] x86/uaccess: Avoid barrier_nospec() in 32-bit copy_from_user()
Date: Mon, 28 Oct 2024 18:56:16 -0700
Message-ID: <5abde43491039b577294b0b94877f3a1db1235d7.1730166635.git.jpoimboe@kernel.org>
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

The barrier_nospec() in 32-bit copy_from_user() is slow.  Instead use
pointer masking to force the user pointer to all 1's if a previous
access_ok() mispredicted true for an invalid address.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/uaccess.h    | 34 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/uaccess_32.h |  2 +-
 arch/x86/include/asm/uaccess_64.h | 29 +-------------------------
 3 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..e7ac97d42bc2 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -15,6 +15,40 @@
 #include <asm/smap.h>
 #include <asm/extable.h>
 #include <asm/tlbflush.h>
+#include <asm/runtime-const.h>
+
+#ifdef CONFIG_X86_64
+/*
+ * Virtual variable: there's no actual backing store for this,
+ * it can purely be used as 'runtime_const_ptr(USER_PTR_MAX)'
+ */
+extern unsigned long USER_PTR_MAX;
+# define USER_PTR_MAX_CONST runtime_const_ptr(USER_PTR_MAX)
+#else
+# define USER_PTR_MAX_CONST TASK_SIZE_MAX-1
+#endif
+
+/*
+ * Masking the user address is an alternative to a conditional
+ * user_access_begin that can avoid the fencing. This only works
+ * for dense accesses starting at the address.
+ */
+static inline void __user *mask_user_address(const void __user *ptr)
+{
+	unsigned long mask;
+	asm("cmp %1,%0\n\t"
+	    "sbb %0,%0"
+		:"=r" (mask)
+		:"r" (ptr),
+		 "0" (USER_PTR_MAX_CONST));
+	return (__force void __user *)(mask | (__force unsigned long)ptr);
+}
+
+#define masked_user_access_begin(x) ({				\
+	__auto_type __masked_ptr = (x);				\
+	__masked_ptr = mask_user_address(__masked_ptr);		\
+	__uaccess_begin(); __masked_ptr; })
+
 
 #ifdef CONFIG_X86_32
 # include <asm/uaccess_32.h>
diff --git a/arch/x86/include/asm/uaccess_32.h b/arch/x86/include/asm/uaccess_32.h
index 8393ba104b2c..6ec2d73f8bba 100644
--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -23,7 +23,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 static __always_inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	barrier_nospec();
+	from = mask_user_address(from);
 	return __copy_user_ll(to, (__force const void *)from, n);
 }
 
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 7ce84090f0ec..dfb78154ac26 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -12,13 +12,6 @@
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
 #include <asm/percpu.h>
-#include <asm/runtime-const.h>
-
-/*
- * Virtual variable: there's no actual backing store for this,
- * it can purely be used as 'runtime_const_ptr(USER_PTR_MAX)'
- */
-extern unsigned long USER_PTR_MAX;
 
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -54,27 +47,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
 #endif
 
 #define valid_user_address(x) \
-	((__force unsigned long)(x) <= runtime_const_ptr(USER_PTR_MAX))
-
-/*
- * Masking the user address is an alternative to a conditional
- * user_access_begin that can avoid the fencing. This only works
- * for dense accesses starting at the address.
- */
-static inline void __user *mask_user_address(const void __user *ptr)
-{
-	unsigned long mask;
-	asm("cmp %1,%0\n\t"
-	    "sbb %0,%0"
-		:"=r" (mask)
-		:"r" (ptr),
-		 "0" (runtime_const_ptr(USER_PTR_MAX)));
-	return (__force void __user *)(mask | (__force unsigned long)ptr);
-}
-#define masked_user_access_begin(x) ({				\
-	__auto_type __masked_ptr = (x);				\
-	__masked_ptr = mask_user_address(__masked_ptr);		\
-	__uaccess_begin(); __masked_ptr; })
+	((__force unsigned long)(x) <= USER_PTR_MAX_CONST)
 
 /*
  * User pointers can have tag bits on x86-64.  This scheme tolerates
-- 
2.47.0


