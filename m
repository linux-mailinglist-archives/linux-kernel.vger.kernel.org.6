Return-Path: <linux-kernel+bounces-370652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D239A3021
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30674B233EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F51D7E33;
	Thu, 17 Oct 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwSRDs6W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71B1D7999
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202129; cv=none; b=CbIIlJ6ucvmR5+NsGgrVaj+6mwAW7ZQEf3xKYbIajzEiGxKRkHhFFbnpKchECvww13GeZNWAL02eStyYefBYmvX6YJEVL0QoQ2vvq0TGplb78T/EDPSok5+tTthzgU2lFpYvb6/aG3sR+ejvbjOjUHW5GDgmK7t7IKZp5tRtd5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202129; c=relaxed/simple;
	bh=+NVAfBL5XC4O3/+bvmSlB+aCF1KvxK5rqTMlDvFps8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVnyMhoUpsXQBWMfSasx7VwUFgR2R/u6PJs8c3Zm5RwZGs5P99XAvD2R+e4v1jpm5njm/KB1I60zIRo/uDlPwl4A1Qb0bxPzmuCJLrYdPkT0vZblLS82gtrK1V19OXcaMkmc7Dw97awbHJzrx/uDNWOC/UDT4Ob51bBCVBVQrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwSRDs6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E136DC4CED0;
	Thu, 17 Oct 2024 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202129;
	bh=+NVAfBL5XC4O3/+bvmSlB+aCF1KvxK5rqTMlDvFps8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwSRDs6W96PHO2LRpbnWJ0OAi+5QM78NCMgPnwsZ6OZ0V7sPQULC5WebYPZVd5d3l
	 FEbxM2R0ClBXjbJm5zZ85m/WdRyqIGWUpJG/xqyxJHWhKORX+n8iGN4M6qwy7uf8s1
	 /YDH9Ssdat0h9Zn+uKLHRCPkjKL0FtvgGVq0TvnDjm2Uy1Qpqp4d7T5E6kHkevZe2g
	 E72VfcMW9JI8XGhLsRfh/X5RIhe9aMYhRvjmDchnYZg2OEwwYPL0YBiLJKd8BTVkBm
	 r84u32waSE4V6iFBM1gjUKQTZ6gCjonbVPlRHOtWM6g8iJpjGXgSOKuqqbdAWwXPP6
	 vbrG1Orde5mXw==
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
Subject: [PATCH v2 3/6] x86/uaccess: Rearrange putuser.S
Date: Thu, 17 Oct 2024 14:55:22 -0700
Message-ID: <7818233ecd726628a3eb9cbb5ed0ba831e69af4b.1729201904.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729201904.git.jpoimboe@kernel.org>
References: <cover.1729201904.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate __put_user_*() from __put_user_nocheck_*() to make the layout
similar to getuser.S.  This will also make it easier to do a subsequent
change.  No functional changes.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/lib/putuser.S | 67 ++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 09b7e37934ab..cb137e0286be 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -54,59 +54,32 @@ SYM_FUNC_START(__put_user_1)
 SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
-SYM_FUNC_START(__put_user_nocheck_1)
-	ASM_STAC
-2:	movb %al,(%_ASM_CX)
-	xor %ecx,%ecx
-	ASM_CLAC
-	RET
-SYM_FUNC_END(__put_user_nocheck_1)
-EXPORT_SYMBOL(__put_user_nocheck_1)
-
 SYM_FUNC_START(__put_user_2)
 	check_range size=2
 	ASM_STAC
-3:	movw %ax,(%_ASM_CX)
+2:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
 	ASM_CLAC
 	RET
 SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
-SYM_FUNC_START(__put_user_nocheck_2)
-	ASM_STAC
-4:	movw %ax,(%_ASM_CX)
-	xor %ecx,%ecx
-	ASM_CLAC
-	RET
-SYM_FUNC_END(__put_user_nocheck_2)
-EXPORT_SYMBOL(__put_user_nocheck_2)
-
 SYM_FUNC_START(__put_user_4)
 	check_range size=4
 	ASM_STAC
-5:	movl %eax,(%_ASM_CX)
+3:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
 	ASM_CLAC
 	RET
 SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
-SYM_FUNC_START(__put_user_nocheck_4)
-	ASM_STAC
-6:	movl %eax,(%_ASM_CX)
-	xor %ecx,%ecx
-	ASM_CLAC
-	RET
-SYM_FUNC_END(__put_user_nocheck_4)
-EXPORT_SYMBOL(__put_user_nocheck_4)
-
 SYM_FUNC_START(__put_user_8)
 	check_range size=8
 	ASM_STAC
-7:	mov %_ASM_AX,(%_ASM_CX)
+4:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
-8:	movl %edx,4(%_ASM_CX)
+5:	movl %edx,4(%_ASM_CX)
 #endif
 	xor %ecx,%ecx
 	ASM_CLAC
@@ -114,6 +87,34 @@ SYM_FUNC_START(__put_user_8)
 SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
+/* .. and the same for __put_user, just without the range checks */
+SYM_FUNC_START(__put_user_nocheck_1)
+	ASM_STAC
+6:	movb %al,(%_ASM_CX)
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_1)
+EXPORT_SYMBOL(__put_user_nocheck_1)
+
+SYM_FUNC_START(__put_user_nocheck_2)
+	ASM_STAC
+7:	movw %ax,(%_ASM_CX)
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_2)
+EXPORT_SYMBOL(__put_user_nocheck_2)
+
+SYM_FUNC_START(__put_user_nocheck_4)
+	ASM_STAC
+8:	movl %eax,(%_ASM_CX)
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_4)
+EXPORT_SYMBOL(__put_user_nocheck_4)
+
 SYM_FUNC_START(__put_user_nocheck_8)
 	ASM_STAC
 9:	mov %_ASM_AX,(%_ASM_CX)
@@ -137,11 +138,13 @@ SYM_CODE_END(__put_user_handle_exception)
 	_ASM_EXTABLE_UA(2b, __put_user_handle_exception)
 	_ASM_EXTABLE_UA(3b, __put_user_handle_exception)
 	_ASM_EXTABLE_UA(4b, __put_user_handle_exception)
+#ifdef CONFIG_X86_32
 	_ASM_EXTABLE_UA(5b, __put_user_handle_exception)
+#endif
 	_ASM_EXTABLE_UA(6b, __put_user_handle_exception)
 	_ASM_EXTABLE_UA(7b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(8b, __put_user_handle_exception)
 	_ASM_EXTABLE_UA(9b, __put_user_handle_exception)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE_UA(8b, __put_user_handle_exception)
 	_ASM_EXTABLE_UA(10b, __put_user_handle_exception)
 #endif
-- 
2.47.0


