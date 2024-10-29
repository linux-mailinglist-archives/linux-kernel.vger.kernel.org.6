Return-Path: <linux-kernel+bounces-386170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7369B3FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD231C2195C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7A191F6A;
	Tue, 29 Oct 2024 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vP6NtVLO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F218E764
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167001; cv=none; b=H2mStgPZT1TAMP0FGy50VZ8J4BczVS5mvxhLIHNjsIQY/PJpaPrEDQb0UhTsBUq50AEiKmbyj4L5MfznKPrSiLQ7kkppTsm1nR1HJi0MUnuviCQw2YFYLvbVOpxYbxN9Yo2mPQGRV1Mec6JQk4JeruJBuukmViboz2khGc8ahNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167001; c=relaxed/simple;
	bh=IE8lVpfvQw2PdSSBXAG4ZavNEB/AEx7acTSv9OtsKdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7vEX9dOK0EAkhSDMMka+j8AdJWQHN4QwAYbS14RO/NVkvV6RQ/vB0quBQdDVaVW+F9Ljqzhxejy2GMM5yyDQjigjaVxdg1Kym5P3GtUeDDT4Sme/GZXJSIOaopdaEwBn48zJexm58SHQnfAmLliH80HdPSx0s9aShLhQm2BRwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vP6NtVLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7E1C4CEE9;
	Tue, 29 Oct 2024 01:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730167000;
	bh=IE8lVpfvQw2PdSSBXAG4ZavNEB/AEx7acTSv9OtsKdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vP6NtVLOF5MSVKXfLbiGaQ7rBrz+nwyn8OXmIPidSHqN94Ang0Ey0IFWTqlQK1Y0v
	 V1YUzspWLwVcW+caX08qDq9t+paQGzRtumCwpcxsaU4+P0U+u7Q5y5Phy8Q3imUW8m
	 zxIW5wlVIcBdkGg52Rk3zm/U6tVT4iD9LMDOtGItWX+1MBjIT9VgEkGjLW6DajtVe/
	 7xXxdQ78h4plFwmfB1nMdTs/1fryGbDiMkZ3EduhzgoHB5FruTbTRfgGGFQgm946dh
	 0dsmcqJ37mPTRF42IIebnKYp8XbTcyzaWb882nZlhGRmM0OHPvG0B59kJVNh/rqpK7
	 1tYWuy5PrYXRg==
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
Subject: [PATCH v3 5/6] x86/uaccess: Avoid barrier_nospec() in 32-bit __get_user()
Date: Mon, 28 Oct 2024 18:56:18 -0700
Message-ID: <967768924bd5295c231b6bfd37e3cbf85dad3cb2.1730166635.git.jpoimboe@kernel.org>
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

The barrier_nospec() in 34-bit __get_user() is slow.  Instead use
pointer masking to force the user pointer to all 1's if the access_ok()
mispredicted true for an invalid address.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/lib/getuser.S | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 5bce27670baa..7da4fc75eba9 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -35,8 +35,6 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 
-#define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
-
 .macro mask_user_address size:req
 .if IS_ENABLED(CONFIG_X86_64)
 	movq $0x0123456789abcdef,%rdx
@@ -107,11 +105,7 @@ EXPORT_SYMBOL(__get_user_8)
 
 /* .. and the same for __get_user, just without the range checks */
 SYM_FUNC_START(__get_user_nocheck_1)
-#ifdef CONFIG_X86_64
 	mask_user_address size=1
-#else
-	ASM_BARRIER_NOSPEC
-#endif
 	ASM_STAC
 	UACCESS movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -121,11 +115,7 @@ SYM_FUNC_END(__get_user_nocheck_1)
 EXPORT_SYMBOL(__get_user_nocheck_1)
 
 SYM_FUNC_START(__get_user_nocheck_2)
-#ifdef CONFIG_X86_64
 	mask_user_address size=2
-#else
-	ASM_BARRIER_NOSPEC
-#endif
 	ASM_STAC
 	UACCESS movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -135,11 +125,7 @@ SYM_FUNC_END(__get_user_nocheck_2)
 EXPORT_SYMBOL(__get_user_nocheck_2)
 
 SYM_FUNC_START(__get_user_nocheck_4)
-#ifdef CONFIG_X86_64
 	mask_user_address size=4
-#else
-	ASM_BARRIER_NOSPEC
-#endif
 	ASM_STAC
 	UACCESS movl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -149,11 +135,7 @@ SYM_FUNC_END(__get_user_nocheck_4)
 EXPORT_SYMBOL(__get_user_nocheck_4)
 
 SYM_FUNC_START(__get_user_nocheck_8)
-#ifdef CONFIG_X86_64
 	mask_user_address size=8
-#else
-	ASM_BARRIER_NOSPEC
-#endif
 	ASM_STAC
 #ifdef CONFIG_X86_64
 	UACCESS movq (%_ASM_AX),%rdx
-- 
2.47.0


