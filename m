Return-Path: <linux-kernel+bounces-197780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02C8D6F11
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE0AB242C2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C4D14E2C5;
	Sat,  1 Jun 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sdpuj1Gr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B271CFBE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717232694; cv=none; b=fu2+ii6cMYM1FeElaVZqIlO7U7fYyaeeG9g7GFDlbBt4WbcmsSZ3fMJIaVsX5ppjvl2ndtr2JvS6rjriPua6dnDvUlYJRGoGT1UjmbwD7BwZ04g33VpQ02uPQBzGF9QdiaWHpXsQSe+kuwanh/xEQnRLhTKUTjgVgkAMjD2fAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717232694; c=relaxed/simple;
	bh=icu7jSauroyEPnKWTedHoxoncAQjCOtiv+zPdobF7TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCy33WMQpuV4XD2cLxKca9NLBKz0O+0mL6cM3hOdbKE7WK4XUezZz1zt2nRCL214O1PuBSthUyKSnKkGCBOPsH0P0NWRXVOO+/cGD5WMgbm3YZJDFRYOZ4gygsu3A5jYtbTpou1kM9o1FF55ySQfQPI6nA/7fQGK6hcSNOgepQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Sdpuj1Gr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2628640E016A;
	Sat,  1 Jun 2024 09:04:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h_VhE2OV4rW0; Sat,  1 Jun 2024 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717232686; bh=xP0weqrRl+2BUKV2+HfBB0LCs4RH/ww+KkZzEG1IJ34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sdpuj1Gr3PhGfv8k8dUS8hzzW2IpjOdYFdI4OFmhvHBGFyu51McFtLEO+HxUekbX1
	 v5xYrEyO0vfY2RxuUjZSCdJLYUTtPXVnkLT/dDceHNc+GgEc4yfcGavwpmPiiAhruh
	 pQmbBYZ22RPSQA97/TsKa4+PReLdS71fC0Pc6lIam9OkxjfexXNzCCV5kROCVzuY6H
	 pKGssykUT6jAX7ZY6FwUM4a0HTErkwpcTFb23vO1kUTZXbrDK5ujy0v2ygKk5GIS4t
	 wzOXz9bgtWFWxcS00Q3At3rVKhma6oMcJuHZq0LhsdfWt990QV98bRJ6iLZe/t9QRB
	 IqvMQmQmPlvxksRiE+qFwVKBEHHrBnCtK7ru7mehi0HqfSokD8iuw2ZU8Qk7rQGR5D
	 hp7i8GIY+ToI1ixzHlMvCyhdvbZlrsYugwPL/uuZS0B4GrhZA1FvegTUc7IAqQab4J
	 crF4jo1p9F3ykmRf8XT6csWL1j8QxJCPn/EpI+RcoKdB0lkGTK5rxeJvkGIRxVbcja
	 9aSThpq1s/1BLKhqcoiV+eJH56PIKzkXYQg8mEJQGTDqBAA8D6RR+slgwk2K99Ajeu
	 1qJcKVvDfoH/gK2GH4BF3w5HXin37qMq+Q91960jTtvuWteymxFCRTXqh6+ELW5tGZ
	 ndvlzWu29RIPQ7q76yGf/r44=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFCBE40E02BA;
	Sat,  1 Jun 2024 09:04:41 +0000 (UTC)
Date: Sat, 1 Jun 2024 11:04:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Brian Gerst <brgerst@gmail.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/14] x86/alternative: Convert ALTERNATIVE_3()
Message-ID: <20240601090435.GAZlrkI4xoJigj1tjp@fat_crate.local>
References: <20240531123512.21427-1-bp@kernel.org>
 <20240531123512.21427-11-bp@kernel.org>
 <CAMzpN2i4oJ-Dv0qO46Fd-DxNv5z9=x+vO+8g=47NiiAf8QEJYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMzpN2i4oJ-Dv0qO46Fd-DxNv5z9=x+vO+8g=47NiiAf8QEJYA@mail.gmail.com>

On Fri, May 31, 2024 at 01:00:55PM -0400, Brian Gerst wrote:
> Just add a label at the start of this macro, so it doesn't depend on
> the internal labels of ALTERNATIVE().  Something like:
>     asm volatile("1:" ALTERNATIVE_3(XSAVE, \
>     ...
>      _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
>     ...

Thanks for the cool idea - that use of the asm label outside of the
macro was really nasty but I didn't think of that. Cool.

And yap, it looks good:

------
#APP
# 188 "arch/x86/kernel/fpu/xstate.h" 1
	1: # ALT: oldinstr

<--- the outer label 1:

771:
	# ALT: oldinstr
771:
	# ALT: oldinstr
771:
	.byte 0x48, 0x0f,0xae,0x27
772:
# ALT: padding
.skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90

...

triple-alternative gunk

...

775:
.popsection

xor %edi, %edi	# err
3:
 .pushsection "__ex_table","a"
------

Yap, and boots in the guest.

I'll fold in the below:

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 70903c12a911..2ee0b9c53dcc 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -106,21 +106,17 @@ static inline u64 xfeatures_mask_independent(void)
  * Otherwise, if XSAVEOPT is enabled, XSAVEOPT replaces XSAVE because XSAVEOPT
  * supports modified optimization which is not supported by XSAVE.
  *
- * We use XSAVE as a fallback.
- *
- * The 771 label is defined in the ALTERNATIVE* macros as the address of the
- * original instruction which gets replaced. We need to use it here as the
- * address of the instruction where we might get an exception at.
+ * Use XSAVE as a fallback.
  */
 #define XSTATE_XSAVE(st, lmask, hmask, err)				\
-	asm volatile(ALTERNATIVE_3(XSAVE,				\
+	asm volatile("1: " ALTERNATIVE_3(XSAVE,				\
 				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
 				   XSAVEC,   X86_FEATURE_XSAVEC,	\
 				   XSAVES,   X86_FEATURE_XSAVES)	\
 		     "\n"						\
 		     "xor %[err], %[err]\n"				\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(771b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
+		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
@@ -130,11 +126,11 @@ static inline u64 xfeatures_mask_independent(void)
  * XSAVE area format.
  */
 #define XSTATE_XRESTORE(st, lmask, hmask)				\
-	asm volatile(ALTERNATIVE(XRSTOR,				\
+	asm volatile("1: " ALTERNATIVE(XRSTOR,				\
 				 XRSTORS, X86_FEATURE_XSAVES)		\
 		     "\n"						\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE(771b, 3b, EX_TYPE_FPU_RESTORE)	\
+		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FPU_RESTORE)	\
 		     :							\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

