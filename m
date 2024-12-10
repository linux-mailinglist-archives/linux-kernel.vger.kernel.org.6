Return-Path: <linux-kernel+bounces-439500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F87A9EB020
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE68E162888
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA1B19CC3E;
	Tue, 10 Dec 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwHC7XwT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300F19924F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831189; cv=none; b=WOKfGODpERVJ2OLqpyK3LUXHEVHM/ZB+diFLA6s29Mjx9iLLfZACiJkcl1S/cTHypyM6+p4zt+wmtVXkeSSFU11wzsLcWlsN8wseEtNmnarKuZ0+OjixOwyKCFYMrjbhp8K6uJ031RLB8Zz+5zRNGiaHmiZKKYovRgSDmsE0H94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831189; c=relaxed/simple;
	bh=rZw17ONKqwfwAwT/QFFXCbDsNJHfxGqGB02+N+1X/ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkQ+Ofh/4jIHFyxHp56bitYrt3Xu2mMS1kZsy/+xvadYwahHHSG8wRBVsIhdVMU92INd4j8u5JdrSkDt1dqZNWTry9h9253wfCW3SdrCoHw1yWEI1mpBHXgDiLiwL6vCtsqLlogPFWIQrwvENU/D7iy0iaQDhznCv6e36ofYI2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwHC7XwT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733831188; x=1765367188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rZw17ONKqwfwAwT/QFFXCbDsNJHfxGqGB02+N+1X/ZE=;
  b=HwHC7XwTWIQ9E8MFHJvBTCbQSMPCNLjCxMgF03TfvXDhb9UTWP521HMS
   ucbeuwUTKoHxaNkA7RLlRrTX6DIbw5+iB0tqTP5Daaq5bLp4fwHEB1FYq
   wLcNLmpIS1rOO+tQjnuKkDfRzrhuPuF6M5YVMeP5m7ioexosrYDs7bTqK
   Y9sjJtgWnIqgw5h9c+7z9RZiqdOZxSfF+VnHWmlgzyUJ/75g8u26VJEtn
   KCy+aqoC7QhHJdKs+xHv3jqefkri1SuEJwRFTdX5Zx/YwhL3Bkny+Zo20
   S/T4rVfc2iKzr3cwo/+WzwxwIt3DRFXxpbsH3tOYMOcQyAmZig2m+QKuR
   w==;
X-CSE-ConnectionGUID: wa5mi+DCRyecLDl3i/ZaDA==
X-CSE-MsgGUID: 3FI6aQAJTb+DO7/29hY+lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34415774"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="34415774"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 03:46:27 -0800
X-CSE-ConnectionGUID: uikAWupUQ0Ku0qF4+AWW4g==
X-CSE-MsgGUID: kNBF7HhQRamqkRFDO7LY+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95856576"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 10 Dec 2024 03:46:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1485121C; Tue, 10 Dec 2024 13:46:23 +0200 (EET)
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
Subject: [PATCH] x86/runtime-const: Add RUNTIME_CONST_PTR assembly macro
Date: Tue, 10 Dec 2024 13:46:12 +0200
Message-ID: <20241210114612.1707990-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
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
index 4357ec2a0bfc..49ddb563e9e3 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -34,16 +34,13 @@
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
 	cmp %rax, %rdx
 	sbb %rdx, %rdx
 	or %rdx, %rax
-- 
2.45.2


