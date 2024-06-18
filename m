Return-Path: <linux-kernel+bounces-218955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A190C826
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057B0288EED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC441D5434;
	Tue, 18 Jun 2024 09:37:18 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3015747E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703438; cv=none; b=RflDKzpsGuKZkXVzIPR1f4OiGKJ3FrUnrUyUkqJroW9y4hxRCz4KRErjLhnGh5Pr+PYFL/IhkwvOd5LvRJJkJiEHWEYRypgxeiYByqYZObZjcDj4811UVidCGWgtx196YFV5UgnUtts3nuWFLTt0csykEHBv4GTXSD49C9lrAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703438; c=relaxed/simple;
	bh=JtXo8pDjK/tq6OQrzC0zsd0wxSvh75EE92PF8+P5QaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mda1R2WfFbi4izvzcmPCxE01rcGNtHcZpHmROYLjW14aZsfjtsmT7JKVPQ692i55tgz1HlljoPW9LNdfqpzy0ycwF9dB9HEYybBC8NeuCw7tFmMxz11r1B8m39LkvBgJw35ZzeZvKqGxhAKofgZchkFt2R/r3QqOMkJsdNUbFhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz10t1718703288tudiii
X-QQ-Originating-IP: 24/5geplR+rievJGK0OhwNv2ND6azFg7OpJbguRyHhU=
Received: from HX01040082.powercore.com.cn ( [14.19.157.182])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Jun 2024 17:34:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14723788730099599002
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	masahiroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fixed duplicate copying in the early boot.
Date: Tue, 18 Jun 2024 17:34:39 +0800
Message-Id: <20240618093439.16982-1-jinglin.wen@shingroup.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87le336c6k.fsf@mail.lhotse>
References: <87le336c6k.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-2

Hi Michael Ellerman,=0D
=0D
Michael Ellerman <mpe@ellerman.id.au> writes:=0D
> Jinglin Wen <jinglin.wen@shingroup.cn> writes:=0D
> > According to the code logic, when the kernel is loaded to address 0,=0D
> > no copying operation should be performed, but it is currently being=0D
> > done.=0D
> >=0D
> > This patch fixes the issue where the kernel code was incorrectly=0D
> > duplicated to address 0 when booting from address 0.=0D
> >=0D
> > Signed-off-by: Jinglin Wen <jinglin.wen@shingroup.cn>=0D
> > ---=0D
> >  arch/powerpc/kernel/head_64.S | 4 +++-=0D
> >  1 file changed, 3 insertions(+), 1 deletion(-)=0D
> =0D
> Thanks for the improved change log.=0D
> =0D
> The subject could probably still be clearer, maybe:=0D
>   Fix unnecessary copy to 0 when kernel is booted at address 0=0D
=0D
Thanks for your feedback, I will revise my subject.=0D
=0D
> =0D
> Looks like this was introduced by:=0D
> =0D
>   Fixes: b270bebd34e3 ("powerpc/64s: Run at the kernel virtual address ea=
rlier in boot")=0D
>   Cc: stable@vger.kernel.org # v6.4+=0D
> =0D
> Let me know if you think otherwise.=0D
> =0D
> Just out of interest, how are you hitting this bug? AFAIK none of our=0D
> "normal" boot loaders will load the kernel at 0. =0D
> =0D
> > diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_6=
4.S=0D
> > index 4690c219bfa4..6c73551bdc50 100644=0D
> > --- a/arch/powerpc/kernel/head_64.S=0D
> > +++ b/arch/powerpc/kernel/head_64.S=0D
> > @@ -647,7 +647,9 @@ __after_prom_start:=0D
> >   * Note: This process overwrites the OF exception vectors.=0D
> >   */=0D
> >  	LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET)=0D
> > -	mr.	r4,r26			/* In some cases the loader may  */=0D
> > +	tophys(r4,r26)=0D
> > +	cmplwi	cr0,r4,0	/* runtime base addr is zero */=0D
> > +	mr	r4,r26			/* In some cases the loader may */=0D
> >  	beq	9f			/* have already put us at zero */=0D
> 	=0D
> That is a pretty minimal fix, but I think the code would be clearer if=0D
> we just compared the source and destination addresses.=0D
> =0D
> Something like the diff below. Can you confirm that works for you.=0D
> =0D
> cheers=0D
> =0D
=0D
As for how I discovered this bug, we use zImage.epapr for emulation, which =
=0D
loads vmlinux.bin at address 0. When vmlinux.bin is relatively large, I =0D
found that the boot time of Linux 6.6 is much slower compared to Linux 5.10=
.108. =0D
I discovered this issue while comparing the code between the two versions.=
=0D
=0D
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.=
S=0D
> index 4690c219bfa4..6ad1435303f9 100644=0D
> --- a/arch/powerpc/kernel/head_64.S=0D
> +++ b/arch/powerpc/kernel/head_64.S=0D
> @@ -647,8 +647,9 @@ __after_prom_start:=0D
>   * Note: This process overwrites the OF exception vectors.=0D
>   */=0D
>  	LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET)=0D
> -	mr.	r4,r26			/* In some cases the loader may  */=0D
> -	beq	9f			/* have already put us at zero */=0D
> +	mr	r4, r26			// Load the source address into r4=0D
> +	cmpld	cr0, r3, r4		// Check if source =3D=3D dest=0D
> +	beq	9f			// If so skip the copy=0D
>  	li	r6,0x100		/* Start offset, the first 0x100 */=0D
>  					/* bytes were copied earlier.	 */=0D
=0D
Indeed, your code looks much clearer. I will make the following modificatio=
ns =0D
based on your code:=0D
=0D
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S=
=0D
index 4690c219bfa4..751181dfb897 100644=0D
--- a/arch/powerpc/kernel/head_64.S=0D
+++ b/arch/powerpc/kernel/head_64.S=0D
@@ -647,8 +647,9 @@ __after_prom_start:=0D
  * Note: This process overwrites the OF exception vectors.=0D
  */=0D
        LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET)=0D
-       mr.     r4,r26                  /* In some cases the loader may  */=
=0D
-       beq     9f                      /* have already put us at zero */=0D
+       mr      r4,r26                  /* Load the virtual source address =
into r4 */=0D
+       cmpd    r3,r4           /* Check if source =3D=3D dest */=0D
+       beq     9f                      /* If so skip the copy  */=0D
        li      r6,0x100                /* Start offset, the first 0x100 */=
=0D
                                        /* bytes were copied earlier.    */=
 =0D
=0D
Thanks,=0D
=0D
Jinglin Wen=0D

