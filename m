Return-Path: <linux-kernel+bounces-544729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD76A4E49A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C817F18862B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7B25F976;
	Tue,  4 Mar 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1OYlQ5W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102925D551
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102434; cv=none; b=jZnE64YQBGt9tj3zsaC3ik6dL9MxJlNZS0bAQwqrWo6AY2v528MbJCbcORNjgtX/6jf6mW2E5QhEO24QpFe1bPRVNOijtD22aGMfugDmphbwcrR+TAO+UfdPtYOo0DBAexcP+t798pQxnAjg57FTF5xm8tPxV/DBIqp+gsjZhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102434; c=relaxed/simple;
	bh=Q2k3ww5ab+KTlyT+I/PhaznrIACSRlKw+mvfKBhY5g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7CYnuR46a0c7OsYkNCZwVEH5TehSrv0MZhRnw3Nh3BUPG5oRKRVpUSwxG4cEOcUQNgoigvM6c8f/YJhqPbJmOcFaw8FisJCPKsqrWoOW22qWKMkuchVNV4fNPFVO6E34wMH/Elyy1crEkqn3I4E1jIMH1Jza/36CyanS6nv3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1OYlQ5W; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741102433; x=1772638433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q2k3ww5ab+KTlyT+I/PhaznrIACSRlKw+mvfKBhY5g8=;
  b=k1OYlQ5W0ZeAGN7NFur/D6gpjtFpfGvKIcIsNQTl5ObjTTx3Mfh7GCjw
   1ZO+VMSufOF7X9rBgKt/ur+jZCRxqSIMiKUXY8euOrgnM+LXG0TL6WQ93
   YmMwjn++9NrMtwSb6GZt33fDJWnzUF0INZXncj/Fln2pMMpP1sJSbsGuC
   OuaYKzlntP8dMcLrAZOJPctyFRgxmUU8WuoDVq3YtsKSEhOiFWZnboez3
   F0UILVZyjBjlP/PHj7uBkXmcBTGLei+QJdvoD3qgj95IRjcks6KUGv9x3
   QjtugIsS0dQYmzHvJIfibx1e6gHvBeNOwPzxy7Lw2/7QTGPtjZaPmZCv1
   g==;
X-CSE-ConnectionGUID: 9s9YH5lvRA2lygDdJVDJpg==
X-CSE-MsgGUID: 7gN29WQITPKgTG4eVw/TUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53429613"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="53429613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:33:52 -0800
X-CSE-ConnectionGUID: qC0XRROISmWUx8utm6j9ww==
X-CSE-MsgGUID: 9gzo6HUITBKlRaF9/SKNdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118411687"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 04 Mar 2025 07:33:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5209018F; Tue, 04 Mar 2025 17:33:49 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH, REBASED] x86/runtime-const: Add RUNTIME_CONST_PTR assembly macro
Date: Tue,  4 Mar 2025 17:33:42 +0200
Message-ID: <20250304153342.2016569-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an assembly macro to refer runtime cost. It hides linker magic and
makes assembly more readable.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/runtime-const.h | 13 +++++++++++++
 arch/x86/lib/getuser.S               |  7 ++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 6652ebddfd02..8d983cfd06ea 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,6 +2,18 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H
 
+#ifdef __ASSEMBLY__
+
+.macro RUNTIME_CONST_PTR sym reg
+	movq	$0x0123456789abcdef, %\reg
+	1:
+	.pushsection runtime_ptr_\sym, "a"
+	.long	1b - 8 - .
+	.popsection
+.endm
+
+#else /* __ASSEMBLY__ */
+
 #define runtime_const_ptr(sym) ({				\
 	typeof(sym) __ret;					\
 	asm_inline("mov %1,%0\n1:\n"				\
@@ -58,4 +70,5 @@ static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	}
 }
 
+#endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 71d8e7da4fc5..9d5654b8a72a 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -35,16 +35,13 @@
 #include <asm/thread_info.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/runtime-const.h>
 
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
 .macro check_range size:req
 .if IS_ENABLED(CONFIG_X86_64)
-	movq $0x0123456789abcdef,%rdx
-  1:
-  .pushsection runtime_ptr_USER_PTR_MAX,"a"
-	.long 1b - 8 - .
-  .popsection
+	RUNTIME_CONST_PTR USER_PTR_MAX, rdx
 	cmp %rdx, %rax
 	cmova %rdx, %rax
 .else
-- 
2.47.2


