Return-Path: <linux-kernel+bounces-386169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B069B3FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E77028350A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2051F19067A;
	Tue, 29 Oct 2024 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/i3rg0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72218CBFE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167000; cv=none; b=r7J0b3PXiihIlz8ZjCeIGKcF8CvYpPbij87BGGF7J4kig9+z/cPJ6IOIE4xwAWmz3sdK92LAgbpBiT0IOhK6nxuFtwGtJB8aXyyjPDbODuad+/KYLED7ADiRZz9ptz9gVY5F8Z4Mmwefj+wTzbEE0JiQ24GjzCt9fqxkX/hWCso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167000; c=relaxed/simple;
	bh=QREw5gInShg8RlBYBO/KbmEW/aIWpa9O4n4WwbznW28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYVv9JdqTYqvXoX9Dca93SIxsaPWgCsVPXxRin1KMijP7pdDG9mPnTUQ9G0nrPPLg4ibF34zLP+aVReqhvBf3rVPgHVQ34tgfuQnk0/p1fTVzD8rWrtbOJIQlYvYZ40blNtXtSIJ60vyYbBebrsXUnNXTHE4w88kFzaiPy5u0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/i3rg0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773E1C4CEED;
	Tue, 29 Oct 2024 01:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730167000;
	bh=QREw5gInShg8RlBYBO/KbmEW/aIWpa9O4n4WwbznW28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/i3rg0+GcboI8N2njvDewhf3Lx5tOneAJUvhe41ZjYhpb3nvfEGe6J3McphwC/wh
	 bXu7gyst9fK9MmRzhBOwhUEQrC6FOuzH6CnEuN8wQSqFWo2/WRywMbL+VzO/FRGbLW
	 ruB6Rjg1NFeygp1gYm7/HQlDhoFVS/XpgBROvm6Do1otTwtq8YuaZxpd0subXgDJz3
	 11hyZ4dzXXR0XUdgzdSSqCWzENIO6taqHERFvTQ/J6twLdZqbzaZcj5NxQsetiRRMj
	 yWKT9T/MdJ7VfBPmNVGTY+WcV56uJuL7FEOpFa6d3BwaSk6y2OBZmcUPD8+Yn327At
	 5QxKLc3K+1nEQ==
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
Subject: [PATCH v3 4/6] x86/uaccess: Convert 32-bit get_user() to unconditional pointer masking
Date: Mon, 28 Oct 2024 18:56:17 -0700
Message-ID: <088fc8f27c278791f3af29f94e09278b5fa07bea.1730166635.git.jpoimboe@kernel.org>
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

Convert the 32-bit get_user() implementations to use the new
unconditional masking scheme for consistency with 64-bit.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/lib/getuser.S | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 998d5be6b794..5bce27670baa 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -37,22 +37,19 @@
 
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
-.macro check_range size:req
+.macro mask_user_address size:req
 .if IS_ENABLED(CONFIG_X86_64)
 	movq $0x0123456789abcdef,%rdx
   1:
   .pushsection runtime_ptr_USER_PTR_MAX,"a"
 	.long 1b - 8 - .
   .popsection
-	cmp %rax, %rdx
-	sbb %rdx, %rdx
-	or %rdx, %rax
 .else
-	cmp $TASK_SIZE_MAX-\size+1, %eax
-	jae .Lbad_get_user
-	sbb %edx, %edx		/* array_index_mask_nospec() */
-	and %edx, %eax
+	mov $TASK_SIZE_MAX-\size, %edx
 .endif
+	cmp %_ASM_AX, %_ASM_DX
+	sbb %_ASM_DX, %_ASM_DX
+	or  %_ASM_DX, %_ASM_AX
 .endm
 
 .macro UACCESS op src dst
@@ -63,7 +60,7 @@
 
 	.text
 SYM_FUNC_START(__get_user_1)
-	check_range size=1
+	mask_user_address size=1
 	ASM_STAC
 	UACCESS movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -73,7 +70,7 @@ SYM_FUNC_END(__get_user_1)
 EXPORT_SYMBOL(__get_user_1)
 
 SYM_FUNC_START(__get_user_2)
-	check_range size=2
+	mask_user_address size=2
 	ASM_STAC
 	UACCESS movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -83,7 +80,7 @@ SYM_FUNC_END(__get_user_2)
 EXPORT_SYMBOL(__get_user_2)
 
 SYM_FUNC_START(__get_user_4)
-	check_range size=4
+	mask_user_address size=4
 	ASM_STAC
 	UACCESS movl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -93,14 +90,12 @@ SYM_FUNC_END(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
 
 SYM_FUNC_START(__get_user_8)
-#ifndef CONFIG_X86_64
-	xor %ecx,%ecx
-#endif
-	check_range size=8
+	mask_user_address size=8
 	ASM_STAC
 #ifdef CONFIG_X86_64
 	UACCESS movq (%_ASM_AX),%rdx
 #else
+	xor %ecx,%ecx
 	UACCESS movl (%_ASM_AX),%edx
 	UACCESS movl 4(%_ASM_AX),%ecx
 #endif
@@ -113,7 +108,7 @@ EXPORT_SYMBOL(__get_user_8)
 /* .. and the same for __get_user, just without the range checks */
 SYM_FUNC_START(__get_user_nocheck_1)
 #ifdef CONFIG_X86_64
-	check_range size=1
+	mask_user_address size=1
 #else
 	ASM_BARRIER_NOSPEC
 #endif
@@ -127,7 +122,7 @@ EXPORT_SYMBOL(__get_user_nocheck_1)
 
 SYM_FUNC_START(__get_user_nocheck_2)
 #ifdef CONFIG_X86_64
-	check_range size=2
+	mask_user_address size=2
 #else
 	ASM_BARRIER_NOSPEC
 #endif
@@ -141,7 +136,7 @@ EXPORT_SYMBOL(__get_user_nocheck_2)
 
 SYM_FUNC_START(__get_user_nocheck_4)
 #ifdef CONFIG_X86_64
-	check_range size=4
+	mask_user_address size=4
 #else
 	ASM_BARRIER_NOSPEC
 #endif
@@ -155,7 +150,7 @@ EXPORT_SYMBOL(__get_user_nocheck_4)
 
 SYM_FUNC_START(__get_user_nocheck_8)
 #ifdef CONFIG_X86_64
-	check_range size=8
+	mask_user_address size=8
 #else
 	ASM_BARRIER_NOSPEC
 #endif
-- 
2.47.0


