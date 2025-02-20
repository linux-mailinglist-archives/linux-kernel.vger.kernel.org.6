Return-Path: <linux-kernel+bounces-523353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC0AA3D56E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B44B1888D51
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426C1EE006;
	Thu, 20 Feb 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S0PgP5/o"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AA1EBFF9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045148; cv=none; b=EgRMw9zQxTxIVxG3ZuxrQPJKDKtZuthCNful65TjvPoYXWxZT0xlHeANe93RcvTigMADEiMRaLHwuGYtvq3udVEd6dv/gpiz/blWTsLGjN3t9V87Mc2pBDCWn/AFb1Beh+TqKRNku0jsSzIPB3or0KIiH5pVbEmCWWHiML+1w0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045148; c=relaxed/simple;
	bh=Avox+9aYAAKMeIOQ9gNoIDG7HYxbANJiD1j9EPevwQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJFau7oZ7e+ixd/DaO3xuZ0hPAKreNweShZ0b5hJ3hcKpnmdtETGIcP/b1WWlcgydtTFxgb8eyo0rcn4KSK8rekWwXJ7m4hbZvmXr/Kr5nApd9XHqwxvKrldn22FCSDAUDSyspx15VyFftg3BMAwAJDFtjdwoWMlofZsWEooA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S0PgP5/o; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5461a485aa2so718507e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740045144; x=1740649944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE4jG7N6H3Izke338DenNbafdjP4bLAo7XRV2ASpmTA=;
        b=S0PgP5/otRmyRqofhofSHr5OiirVfK1jsyodoXEQ4hm/9axwqhP+kGYjV9252AeMzZ
         BnmjSVqMl7grWK9B1YBAeQ111+76FvbytEFxi/XtQVMXH8tNK7Yjv+2MOBSKwl7YXVUy
         ll4YHNCuEU9xFgjVm0om5S2bow18ihRFVCXBQFv0YbH/m9Fy05la7+E51ts6A75KmZYk
         MflRDGMKcr19PfLh79SRWaUI9SJCJLgd84pD4nsCgCLY+4XD5Yo3mwOz53MSXQURn5gK
         Lrr/en/A1OBjXN6wVA5nVT0la+kHhlSbbTKphS+lu6O2jSjVcuROBYORP7h6xoyCWIz1
         CL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045144; x=1740649944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE4jG7N6H3Izke338DenNbafdjP4bLAo7XRV2ASpmTA=;
        b=iAMFEmioR49U8L4CKzR7GCuWdFliZoZiv8MMoCjqO0D8rYxmTJoA//ANcJViojTtkw
         aiatoX/ucYmNxNR67rUjXIp0CzWgA4VoR+s3kFIPIu1LtKWFG6OqxT67gsPzUL0MbIE9
         r5dsqr2ww7CExtHRCGO9LlmwTMg6Edn/AOND+YpPgw5NXLgKYJY08snm8iIEM2wPXo49
         pHDkp3Y1Xlf2iBlxGiUGcfEdPdIWvlr9a8j5nZ2lZUGxUNGhay+6aF3Cs7Shy4E9rIhd
         2K6gAXLccNTQxxiWgFrQ63Chvp2W/m6oslVvw0rJpwHwGg0EbRDjaeauOFAJXP7Dn2sR
         JK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPY10RvsdCAfJdfIwGY6pPheCT0n5JAK3pyta6FkxMalF/rRD0EOQ5/Dr8TuIbUaNL+PIpM3hqJZXYPv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNB7W9rpCTGsNqy2vLHnlAmG04p6CLMLtBYCPre3l1yKzNHPQc
	rnCtp2uXkUe9LwYgCjdrWTUB+T1ESJnPpvKnw8uA5P3dgUPiGndCsSpsflcGW5oQiusUp8QpDgi
	X5E8F1FKrl+C56vNqoCsMeC2BgaJGoM7D8KTd9Q==
X-Gm-Gg: ASbGncu0nt7YDjstpZ9gWODm9SUD/7oz4APBH95Y8vYPmT71CGdGLsHYmmOlgzjVsm4
	TlsG1VDPq0A/jKB/ehn7V9ZKNlZVaLRxmOz2G78B58nzRgR5+6IapMDta1b8HjGODKfxPKWFySx
	XUEeHy35Wog3TKTgMwMPuMhpK3G0tk7g==
X-Google-Smtp-Source: AGHT+IGr8YvHEETsNyvTWOQRFut/UUXdenIoZDJncYUJi3iUiyBB5rGYcnt+ccguPMxQB11np4EyftCfzIKctruTiaQ=
X-Received: by 2002:a05:6512:3052:b0:542:9757:d5df with SMTP id
 2adb3069b0e04-5462eee68d1mr2494309e87.21.1740045144302; Thu, 20 Feb 2025
 01:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218090203.43137-1-marco.crivellari@suse.com>
 <20250218090203.43137-2-marco.crivellari@suse.com> <Z7R2GqWOufd8l6NZ@alpha.franken.de>
 <CAAhV-H7ygGqCYyQf_tvFrgEBR6uva35auGP9yhxQFqw4mpQBwA@mail.gmail.com>
 <Z7SQNhL0FYGkX0Ng@alpha.franken.de> <alpine.DEB.2.21.2502181447490.65342@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2502181447490.65342@angie.orcam.me.uk>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 20 Feb 2025 10:52:13 +0100
X-Gm-Features: AWEUYZn22_LXgOCkEjqLvRN9aQTb8m1zBAPf5m_hMLKPPZMKxzotLtaTM-ZcKss
Message-ID: <CAAofZF6VppnQZXMj59o=QDCMbw9GV=6sMRoNWnpWn+mBpE0egg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] MIPS: Fix idle VS timer enqueue
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the late reply.

> Umm, there's the commit description to document justification for such
>changes made and it's not the reviewer's duty to chase every such detail
>that has been omitted from a submission.
>
 >FAOD this is a request to include this detail in v3.

How does it sound integrate the v3 commit message with:

CONFIG_CPU_MICROMIPS has been removed along with the nop instructions.
There, NOPs are 2 byte in size, so change the code with 3 _ssnop which are
always 4 byte and remove the ifdef. Added ehb to make sure the hazard
is always cleared.

something more accurate to suggest?

Thank you

On Tue, Feb 18, 2025 at 4:23=E2=80=AFPM Maciej W. Rozycki <macro@orcam.me.u=
k> wrote:
>
> On Tue, 18 Feb 2025, Thomas Bogendoerfer wrote:
>
> > > > > diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> > > > > index a572ce36a24f..9747b216648f 100644
> > > > > --- a/arch/mips/kernel/genex.S
> > > > > +++ b/arch/mips/kernel/genex.S
> > > > > @@ -104,25 +104,27 @@ handle_vcei:
> > > > >
> > > > >       __FINIT
> > > > >
> > > > > -     .align  5       /* 32 byte rollback region */
> > > > > +     .align  5
> > > > >  LEAF(__r4k_wait)
> > > > >       .set    push
> > > > >       .set    noreorder
> > > > > -     /* start of rollback region */
> > > > > -     LONG_L  t0, TI_FLAGS($28)
> > > > > -     nop
> > > > > -     andi    t0, _TIF_NEED_RESCHED
> > > > > -     bnez    t0, 1f
> > > > > -      nop
> > > > > -     nop
> > > > > -     nop
> > > > > -#ifdef CONFIG_CPU_MICROMIPS
> > > > > -     nop
> > > > > -     nop
> > > > > -     nop
> > > > > -     nop
> > > > > -#endif
> > > >
> > > > My quick search didnn't find the reason for the extra NOPs on MICRO=
MIPS, but
> > > > they are here for a purpose. I might still need them...
> > > The original code needs #ifdef CONFIG_CPU_MICROMIPS because nop in
> > > MICROMIPS is 2 bytes, so need another four nop to align. But _ssnop i=
s
> > > always 4 bytes, so we can remove #ifdefs.
> >
> > ic
>
>  This was wrong anyway (and I had arguments about it with people back in
> the time, but it was a hopeless battle).  Instead `.align ...' or an
> equivalent pseudo-op (`.balign', etc.) should have been used, removing th=
e
> fragility of this piece or the need for CONFIG_CPU_MICROMIPS conditional.
> Here and in other places.
>
> > > > > +     _ssnop
> > > > > +     _ssnop
> > > > > +     _ssnop
> > > >
> > > > instead of handcoded hazard nops, use __irq_enable_hazard for that
> > > No, I don't think so, this region should make sure be 32 bytes on eac=
h
> > > platform, but __irq_enable_hazard is not consistent, 3 _ssnop is the
> > > fallback implementation but available for all MIPS.
> >
> > you are right for most cases, but there is one case
> >
> > #elif (defined(CONFIG_CPU_MIPSR1) && !defined(CONFIG_MIPS_ALCHEMY)) || =
\
> >         defined(CONFIG_CPU_BMIPS)
> >
> > which uses
> >
> > #define __irq_enable_hazard                                            =
 \
> >         ___ssnop;                                                      =
 \
> >         ___ssnop;                                                      =
 \
> >         ___ssnop;                                                      =
 \
> >         ___ehb
> >
> > if MIPSR1 || BMIPS needs "rollback" handler 3 ssnnop would be wrong as
> > irq enable hazard.
>
>  Indeed, EHB must always be included, because for R2+ CPUs SSNOP doesn't
> clear the hazard (it never clears, but with earlier CPUs it just stalls
> the pipeline long enough for the hazard to eventually clear by itself).
>
> > > > But I doubt this works, because the wait instruction is not aligned=
 to
> > > > a 32 byte boundary, but the code assuemes this, IMHO.
> > > Why? After this patch we only use 4 byte instructions.
> >
> > I've should have looked at the compiled output, sorry for the noise
>
>  Umm, there's the commit description to document justification for such
> changes made and it's not the reviewer's duty to chase every such detail
> that has been omitted from a submission.
>
>  FAOD this is a request to include this detail in v3.
>
> > Still this construct feels rather fragile.
>
>  I think `.align', etc. can still be used to ensure enough space has been
> consumed and if you want to make a code sequence's size check, then a
> piece such as:
>
> 0:
>         nop
>         nop
>         nop
>         nop
> 1:
>         .ifne   1b - 0b - 32
>         .error  "code consistency verification failure"
>         .endif
>
> should do even where alignment does not matter.  And you could possibly d=
o
> smarter stuff with `.rept' if (1b - 0b) turns out below rather than above
> the threshold required, but I'm leaving it as an exercise for the reader.
>
>   Maciej



--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

