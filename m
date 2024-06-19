Return-Path: <linux-kernel+bounces-221351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F290F24B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3161F244D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9D914F9FD;
	Wed, 19 Jun 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aqBlvTrM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9434514A615
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811391; cv=none; b=YPfv0IlKLCy8UEXmLAz+E5SXMcn8Y6soMD6OjqyANomcmkYufFEjhmiEBW9aAYqfP5vFyGZZ8ydJOkinHl51jMx5xEh8DYi2S6gY8Ca6FgHcFVMJaFS1pO5YmcjE1LynukIERBEpcfB8tvTkAETEvXo3PvZfNh6CBcOQ97NzGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811391; c=relaxed/simple;
	bh=h6MgagA99h9M17VDUn3raqNdhywE/8ih/YaQJdAXwhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gce6qVuB5HpGVxftDGuIo3WvxJGKfTJXgDJYo3q7QmVlDjIET9S9kGN7iCI+vKxPdE7yi8JiSbQcT0lXDQJSrSGpTacVlzBb4DlZNjbfLMrJrDs13UACfdD/vEX2HZbl5IvlToIy3uhq0RnQqUswV/fcPKROL260c3oY1Xu7huY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aqBlvTrM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1C7D940E021A;
	Wed, 19 Jun 2024 15:36:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id T6R-gzp3PD7w; Wed, 19 Jun 2024 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718811381; bh=Dp9c3VbgKlI0JLzOI5wg5M39BAK9rpGebv+GuBJFzvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqBlvTrMZqQDv3OPr+LjdaMa4ankmtjjkRbLTXEVjPOs9Ebko1x2tSIcsSgrBzBWo
	 9Orc3PGZlpnaQe1UpLx3fMNPU/oKD0b41+JF7be/pED9SV/n/Tw4xs0Fj/kIdLbuUZ
	 7wK4UvQhx/NOM5lsxmw1QJW7/v8VUO1KXPhMULdT4kF1Gbx6cALNZT+rmMWXeut5Vz
	 DE1/WHHb6x24tROORjf62PWSX5ykK173V7zK6oCP4jnyjZ/xwts36sDBOljwTBwXKL
	 G5rCCPc+rDh7wrqXN6JoC3CnPhGCX1s6gAgH8p/lRN7Z6Tx/dirq8YSR3QVcnoTy4L
	 P3MnyGlrBIA0R+I60w1i6EjUh8OZthC6Sh4cjS7oAAEDDVRnZAUerYAhMFmGRhgbL5
	 CCWXS3eUIxUvxjmGTy3CtCM9fF8zcIChu+GbxaoogulKR0QFb5QV1ksY0mgyGcjBqD
	 FE1YvtanYBVEcC+rK87Qk1FTpl0p7f2RQViD9wX89kXpIy1cyssF3B1gWIRWRgMWuI
	 BT8q5vBSKPtd/ADVaQVgk6zW8yxOgDRJk5gMxwG89msZQAiy0J0I3mQf0uj9VRXRrK
	 JzVTUbfp1VgaPW1K6Il6uU7gktsNqMvq1Qgb2VgGeVjPaF4OaTpjfnAjdCrvN++d5B
	 GgWmNiWqYsIMAFbXgZo2/1Dk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A430540E0177;
	Wed, 19 Jun 2024 15:36:12 +0000 (UTC)
Date: Wed, 19 Jun 2024 17:36:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [GIT PULL] x86 fixes
Message-ID: <20240619153606.GDZnL65ui-X_bFxYtD@fat_crate.local>
References: <Zm1NIOnj0NR3U8om@gmail.com>
 <CAHk-=whYb2L_atsRk9pBiFiVLGe5wNZLHhRinA69yu6FiKvDsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whYb2L_atsRk9pBiFiVLGe5wNZLHhRinA69yu6FiKvDsw@mail.gmail.com>

On Sat, Jun 15, 2024 at 11:36:33AM -0700, Linus Torvalds wrote:
> Something ENTIRELY UNTESTED like this, IOW.
> 
> I did check that it seemed to generate sane code on both 32-bit and
> 64-bit, but no _actual_ testing.

Hohumm, looks ok to me. And running it a bit with selftests looks good too.

I productized it like this:

---
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 14:54:23 +0200
Subject: [PATCH] x86/uaccess: Improve the 8-byte getuser() case

Streamline the 8-byte case and drop the special handling. Use a macro
which hides the exception handling.

No functional changes.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/lib/getuser.S | 69 ++++++++++++------------------------------
 1 file changed, 20 insertions(+), 49 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index a1cb3a4e6742..a314622aa093 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -44,21 +44,23 @@
 	or %rdx, %rax
 .else
 	cmp $TASK_SIZE_MAX-\size+1, %eax
-.if \size != 8
 	jae .Lbad_get_user
-.else
-	jae .Lbad_get_user_8
-.endif
 	sbb %edx, %edx		/* array_index_mask_nospec() */
 	and %edx, %eax
 .endif
 .endm
 
+.macro UACCESS op src dst
+1:	\op \src,\dst
+	_ASM_EXTABLE_UA(1b, __get_user_handle_exception)
+.endm
+
+
 	.text
 SYM_FUNC_START(__get_user_1)
 	check_range size=1
 	ASM_STAC
-1:	movzbl (%_ASM_AX),%edx
+	UACCESS movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -68,7 +70,7 @@ EXPORT_SYMBOL(__get_user_1)
 SYM_FUNC_START(__get_user_2)
 	check_range size=2
 	ASM_STAC
-2:	movzwl (%_ASM_AX),%edx
+	UACCESS movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -78,7 +80,7 @@ EXPORT_SYMBOL(__get_user_2)
 SYM_FUNC_START(__get_user_4)
 	check_range size=4
 	ASM_STAC
-3:	movl (%_ASM_AX),%edx
+	UACCESS movl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -89,10 +91,11 @@ SYM_FUNC_START(__get_user_8)
 	check_range size=8
 	ASM_STAC
 #ifdef CONFIG_X86_64
-4:	movq (%_ASM_AX),%rdx
+	UACCESS movq (%_ASM_AX),%rdx
 #else
-4:	movl (%_ASM_AX),%edx
-5:	movl 4(%_ASM_AX),%ecx
+	xor %ecx,%ecx
+	UACCESS movl (%_ASM_AX),%edx
+	UACCESS movl 4(%_ASM_AX),%ecx
 #endif
 	xor %eax,%eax
 	ASM_CLAC
@@ -104,7 +107,7 @@ EXPORT_SYMBOL(__get_user_8)
 SYM_FUNC_START(__get_user_nocheck_1)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
-6:	movzbl (%_ASM_AX),%edx
+	UACCESS movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -114,7 +117,7 @@ EXPORT_SYMBOL(__get_user_nocheck_1)
 SYM_FUNC_START(__get_user_nocheck_2)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
-7:	movzwl (%_ASM_AX),%edx
+	UACCESS movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -124,7 +127,7 @@ EXPORT_SYMBOL(__get_user_nocheck_2)
 SYM_FUNC_START(__get_user_nocheck_4)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
-8:	movl (%_ASM_AX),%edx
+	UACCESS movl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -135,10 +138,11 @@ SYM_FUNC_START(__get_user_nocheck_8)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 #ifdef CONFIG_X86_64
-9:	movq (%_ASM_AX),%rdx
+	UACCESS movq (%_ASM_AX),%rdx
 #else
-9:	movl (%_ASM_AX),%edx
-10:	movl 4(%_ASM_AX),%ecx
+	xor %ecx,%ecx
+	UACCESS movl (%_ASM_AX),%edx
+	UACCESS movl 4(%_ASM_AX),%ecx
 #endif
 	xor %eax,%eax
 	ASM_CLAC
@@ -154,36 +158,3 @@ SYM_CODE_START_LOCAL(__get_user_handle_exception)
 	mov $(-EFAULT),%_ASM_AX
 	RET
 SYM_CODE_END(__get_user_handle_exception)
-
-#ifdef CONFIG_X86_32
-SYM_CODE_START_LOCAL(__get_user_8_handle_exception)
-	ASM_CLAC
-.Lbad_get_user_8:
-	xor %edx,%edx
-	xor %ecx,%ecx
-	mov $(-EFAULT),%_ASM_AX
-	RET
-SYM_CODE_END(__get_user_8_handle_exception)
-#endif
-
-/* get_user */
-	_ASM_EXTABLE_UA(1b, __get_user_handle_exception)
-	_ASM_EXTABLE_UA(2b, __get_user_handle_exception)
-	_ASM_EXTABLE_UA(3b, __get_user_handle_exception)
-#ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(4b, __get_user_handle_exception)
-#else
-	_ASM_EXTABLE_UA(4b, __get_user_8_handle_exception)
-	_ASM_EXTABLE_UA(5b, __get_user_8_handle_exception)
-#endif
-
-/* __get_user */
-	_ASM_EXTABLE_UA(6b, __get_user_handle_exception)
-	_ASM_EXTABLE_UA(7b, __get_user_handle_exception)
-	_ASM_EXTABLE_UA(8b, __get_user_handle_exception)
-#ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(9b, __get_user_handle_exception)
-#else
-	_ASM_EXTABLE_UA(9b, __get_user_8_handle_exception)
-	_ASM_EXTABLE_UA(10b, __get_user_8_handle_exception)
-#endif
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

