Return-Path: <linux-kernel+bounces-370653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E29A3024
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF34B23038
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBC31D86CD;
	Thu, 17 Oct 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMzCg3kq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766661D7E28
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202130; cv=none; b=fWqAWgcKCwDI2CsZBkK5V2lB1EmIdlE1bVYLqESEc3ToAijloWYld9EHEJKFmh12Cpwq7n1cbBNDAbL885nqveXNcKh0UQgNGI0lw3DXGUAGwmv/f9F1pwQPQlaDHxB0jvvJ06vxhjQambteIwucJ1CONwGjavoOS4c8Jg7G730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202130; c=relaxed/simple;
	bh=NMUERTfe8IitvLeucMcKK8QffKkIIRs7lelNieDdT8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ssofy8Jb/RCf8NK3SCPNpjBoXUAY0ytjyYszEFPW3BWjmbJQosRvMWuQblFHp2fo4ybvvGDPR/iA5XThstc8rkIdBcElwRHfq9M5FAb4+HpMpJEPRKX/PfQWcUMrYAgFo5UqjjNPq6fmh2TXeVFY8iiHSjRduwUxRWPggOtw/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMzCg3kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A02EC4CED4;
	Thu, 17 Oct 2024 21:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202129;
	bh=NMUERTfe8IitvLeucMcKK8QffKkIIRs7lelNieDdT8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMzCg3kqxX5332ygSUeJINGDmjiYNVsMfc7/7dzsAm06HCcjkVGMntsgcp+IjM/hL
	 RWPWigIMfoZYM/d8HrkVmaWzOWlxpmFWU+0rbXuGpt/rbahjspkRqroToOQK7omUQ0
	 CWgPseIrIFd1H+4fxrsVmrG/4XMCBQKu/BjkSyy9/H784GkUvxWYX+1c7y4jtYw8xz
	 S1ZgR2yDDjpu2629dLL8w54cSK2EIS4rdxvQ4vQO/Hksj4o5MokUFoSuMrhT91SS8v
	 oMDBzwzfliCdS/84MB41FTSlPz99wiwk7WJV0Z3ZdtGpx+p7eqbS+1o5RAP8MuGZ47
	 OnD3DSEsxO3fg==
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
Subject: [PATCH v2 4/6] x86/uaccess: Add user pointer masking to __put_user()
Date: Thu, 17 Oct 2024 14:55:23 -0700
Message-ID: <fee7ce8f16355ad8e8be4fae8a10ea49a6e25d69.1729201904.git.jpoimboe@kernel.org>
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

Add user pointer masking to __put_user() to mitigate Spectre v1.

A write in a mispredicted access_ok() branch to a user-controlled kernel
address can populate the rest of the affected cache line with kernel
data.

This makes its behavior identical to put_user(), so converge their
implementations.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/lib/putuser.S | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index cb137e0286be..1b122261b7aa 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -87,7 +87,26 @@ SYM_FUNC_START(__put_user_8)
 SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
-/* .. and the same for __put_user, just without the range checks */
+#ifdef CONFIG_X86_64
+
+/*
+ * On x86-64, put_user() does address masking rather than a conditional
+ * bounds check so there's no functional difference with __put_user().
+ */
+SYM_FUNC_ALIAS(__put_user_nocheck_1, __put_user_1);
+EXPORT_SYMBOL(__put_user_nocheck_1);
+
+SYM_FUNC_ALIAS(__put_user_nocheck_2, __put_user_2);
+EXPORT_SYMBOL(__put_user_nocheck_2);
+
+SYM_FUNC_ALIAS(__put_user_nocheck_4, __put_user_4);
+EXPORT_SYMBOL(__put_user_nocheck_4);
+
+SYM_FUNC_ALIAS(__put_user_nocheck_8, __put_user_8);
+EXPORT_SYMBOL(__put_user_nocheck_8);
+
+#else /* CONFIG_X86_32 */
+
 SYM_FUNC_START(__put_user_nocheck_1)
 	ASM_STAC
 6:	movb %al,(%_ASM_CX)
@@ -118,15 +137,15 @@ EXPORT_SYMBOL(__put_user_nocheck_4)
 SYM_FUNC_START(__put_user_nocheck_8)
 	ASM_STAC
 9:	mov %_ASM_AX,(%_ASM_CX)
-#ifdef CONFIG_X86_32
 10:	movl %edx,4(%_ASM_CX)
-#endif
 	xor %ecx,%ecx
 	ASM_CLAC
 	RET
 SYM_FUNC_END(__put_user_nocheck_8)
 EXPORT_SYMBOL(__put_user_nocheck_8)
 
+#endif /* CONFIG_X86_32 */
+
 SYM_CODE_START_LOCAL(__put_user_handle_exception)
 	ASM_CLAC
 .Lbad_put_user:
@@ -140,11 +159,9 @@ SYM_CODE_END(__put_user_handle_exception)
 	_ASM_EXTABLE_UA(4b, __put_user_handle_exception)
 #ifdef CONFIG_X86_32
 	_ASM_EXTABLE_UA(5b, __put_user_handle_exception)
-#endif
 	_ASM_EXTABLE_UA(6b, __put_user_handle_exception)
 	_ASM_EXTABLE_UA(7b, __put_user_handle_exception)
 	_ASM_EXTABLE_UA(8b, __put_user_handle_exception)
 	_ASM_EXTABLE_UA(9b, __put_user_handle_exception)
-#ifdef CONFIG_X86_32
 	_ASM_EXTABLE_UA(10b, __put_user_handle_exception)
 #endif
-- 
2.47.0


