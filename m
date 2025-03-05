Return-Path: <linux-kernel+bounces-546989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4579A50185
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DB4170CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA5624BBE3;
	Wed,  5 Mar 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eJc/Sc6p"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C7155751
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184026; cv=none; b=T3pAZSdsMr9h1PhUnVemqP9encZkSAskdhv0Ms5kc66MVwtzDjlPNL64cQ9eDYK5T7xKnPUu+P+VM2dYMe+A9h/7VvRBrqJ2KTXerOnHqE+v7qX7ncIzDEJUEMSo4HJRygrwirECP8zKSr0i5eVKcQdi66CxffiSY3iV572LD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184026; c=relaxed/simple;
	bh=lHKiefljl7DH+tUfGhwa7pLds/9sQ5Yo0kTU/bByKv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRR6dkP/7vx3Y3vquNW3BEiq6k8P+D9WQcxv8mLssnacACnrMIcareE8vobzOq7G+2QRU8E64g2FUbmsFX57AzWVmBuu8yiAGK1K68L0MHTi95Ab8F/f/t2qaWeLnF2YFkoVQiAk0YBbXNSMeDMvxDuAYfIjKTzCOGbkWk4HcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eJc/Sc6p; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so7614005e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741184023; x=1741788823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBirxCg1dxG61rZUJuSZgeRwc1WUli3vFI9Cbs1+kZM=;
        b=eJc/Sc6pHOZ0E6RwEtAlXsdyXtml/OXRJu/CeA1BsADbWy06Nwa9jDwtOj2i1Qhnoe
         iwkkS1Ovdt8LpQqY7w+2xG/X6gQ/WIJDRTS+Swhg7DPeMdJ352YZWdK5LMiKVuAUzvAB
         dQU8HWkrAJBDJC3iCT3PYarSig4iq1dYw3PyEZhF9RDrnAwoXpzX2kiPAtrVxQcb2mih
         vX8kzfxgQRF9KblSCZllhxjhEvLtkr4xxLwRV+sBGmUf4Q4S+4rt5ODtrxEji3zR/Ino
         ZTTyIbURCLBfBw0MzizFR67DRH8ztfKsJCxAThJZ1uxkR7JtSoTMfmnyv4O1oBBKEMYS
         v4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184023; x=1741788823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBirxCg1dxG61rZUJuSZgeRwc1WUli3vFI9Cbs1+kZM=;
        b=rndtp7Kj5/Fpwm6ebhaD5NgWJoLaWdmyxAzxevwW32E6YWr4CB3o/bSboBMZLSV701
         /GUENfGnnmXiYKph9+NshRd5wcMwLTiH83ep4yPK/YVGeZxpTpe2+lvka4lOg9Owr8Hm
         hHsGfD+jjDRIsJos6okaZxfRlLocoZ5qb5UDQWuFf2XLVN1VJ5GZiwqoBSegjKXl7EOa
         CN0iTFcjXebCP+H0HSj8pwzcdaL0dfdJcFxISUYrY/W1Rvz1qYidxVttbKC/5+OgOr/O
         9yCqFl8+BW8dff+LzCE2PQRMQCXCAbiUYhPan05y2XYzXUDQVuPgw1TqRN9dn3CB4w4X
         6wCg==
X-Forwarded-Encrypted: i=1; AJvYcCUQIwKPDAsN+9Tp5Eyk+EueVdaG4RYYXtUORSVEUNAqMwxJ8LlaWnlNbVTjWLKuVzpjVRX1IjaAu5Ozgsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMCHbIT+Tb14pkFbmDB326nbiip6RdzVeo+SBPbsjKYO5AvOog
	xHY9Rc+1z+njcUJnR8wBeEbrATZLE9q3MzRAmc1bbknXhiGJFqG3IQ1A7Z3ISusDe27+GTYAbTY
	uO8OSHBjpH46BD5/9F1KwOTiYe7n4MyJnAPlRfw==
X-Gm-Gg: ASbGnctMt2EcY2LnZW1XhbAvh3bfdw5eKKYZUHYfvTngy3JKn3RUFvWEwksM2v5Y/WL
	7B+iMD+O2tsiClVOimD3z20kyfVj1+ikT3R9FC7qIabMeU1YgSrS9YoE6FR9bXWKdyuaHG5wok8
	eCtEsXePxdco1QtWL/xurmYPc/W+mUJyR+Qmq7OkW5OATDNSbF2MHB7qPOiWg=
X-Google-Smtp-Source: AGHT+IGt7ETpCTKRtBu9oEgGRtJDbUlwiox1K2bFo8Re017cicskr5/YVLidQCDOd8SbCFw1+MiTywsDM63Balfm85w=
X-Received: by 2002:a05:6512:33d0:b0:545:291:7ee0 with SMTP id
 2adb3069b0e04-5497d37af36mr1207712e87.34.1741184022729; Wed, 05 Mar 2025
 06:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228100509.91121-1-marco.crivellari@suse.com>
 <20250228100509.91121-2-marco.crivellari@suse.com> <alpine.DEB.2.21.2503020042100.12637@angie.orcam.me.uk>
 <CAAhV-H5ptAzHTPAr1bxrgByZrnFmMK8zJ68Z++RwC=NHWjqZmw@mail.gmail.com>
In-Reply-To: <CAAhV-H5ptAzHTPAr1bxrgByZrnFmMK8zJ68Z++RwC=NHWjqZmw@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 5 Mar 2025 15:13:31 +0100
X-Gm-Features: AQ5f1JraAPtmByej4UDecZdWkOIG-sEatMupm9_n5BBs7VmkfNNGDmVyP3Gxq5g
Message-ID: <CAAofZF4HAczyRmuRe-JmQ2wcZatevLwGTOMLf1V1okGbj7q5Wg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] MIPS: Fix idle VS timer enqueue
To: Huacai Chen <chenhuacai@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

> +     /* Enable Interrput */
>                        ^^
> Typo here; also please capitalise sentences and use full stops.

Sorry, I probably forgot to run checkpatch this time.

>If this is a problem, then the current local_irq_enable() is also
>wrong for all MIPS III hardware, because this patch uses the same
>instruction sequence of local_irq_enable().

This is the doubt I have indeed.
Quoting from the manual (about M4K):

"The Spacing column shown in Table 2.6 and Table 2.7 indicates the
number of unrelated instructions (such as NOPs or SSNOPs) that,
prior to the capabilities of Release 2, would need to be placed
between the producer and consumer of the hazard in order to ensure
that the effects of the first instruction are seen by the second instructio=
n."

The "Spacing column" value is 3, indeed.

"With the hazard elimination instructions available in Release 2, the
preferred method to eliminate hazards is to place one of the
instructions listed in Table 2.8 between the producer and consumer of the
hazard. Execution hazards can be removed by using the EHB [...]"

Not sure if I'm missing something here.

Thanks (to everyone)!

On Mon, Mar 3, 2025 at 9:13=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> Hi, Maciej,
>
> On Sun, Mar 2, 2025 at 8:54=E2=80=AFAM Maciej W. Rozycki <macro@orcam.me.=
uk> wrote:
> >
> > On Fri, 28 Feb 2025, Marco Crivellari wrote:
> >
> > > diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> > > index a572ce36a24f..474738d9124e 100644
> > > --- a/arch/mips/kernel/genex.S
> > > +++ b/arch/mips/kernel/genex.S
> > > @@ -104,27 +104,30 @@ handle_vcei:
> > >
> > >       __FINIT
> > >
> > > -     .align  5       /* 32 byte rollback region */
> > > +     .align  5
> > >  LEAF(__r4k_wait)
> > >       .set    push
> > >       .set    noreorder
> > > -     /* start of rollback region */
> > > -     LONG_L  t0, TI_FLAGS($28)
> > > -     nop
> > > -     andi    t0, _TIF_NEED_RESCHED
> > > -     bnez    t0, 1f
> > > -      nop
> > > -     nop
> > > -     nop
> > > -#ifdef CONFIG_CPU_MICROMIPS
> > > -     nop
> > > -     nop
> > > -     nop
> > > -     nop
> > > -#endif
> > > +     /* start of idle interrupt region */
> > > +     MFC0    t0, CP0_STATUS
> > > +     /* Enable Interrput */
> >                         ^^
> >  Typo here; also please capitalise sentences and use full stops.
> >
> > > +     ori     t0, 0x1f
> >
> >  No time for a thorough review here as I'm heading for a holiday right
> > away, but I can see you still have a coprocessor move hazard here with
> > MIPS III hardware.  The incoming value of $t0 to ORI is not what MFC0 h=
as
> > obtained.  It's the value from before MFC0.
> If this is a problem, then the current local_irq_enable() is also
> wrong for all MIPS III hardware, because this patch uses the same
> instruction sequence of local_irq_enable().
>
>
> Huacai
>
> >
> > > +     xori    t0, 0x1e
> >
> >  And then it's only this XORI that sees the output from MFC0 (though
> > there's actually a race between the two competing writes to $t0), so
> > effectively you clobber the CP0.Status register...
> >
> > > +     MTC0    t0, CP0_STATUS
> >
> >  ... here.  You need to schedule your instructions differently.  But do
> > you need `.set noreorder' in the first place?  Can you maybe find a way=
 to
> > avoid it, making all the hazard avoidance stuff much easier?
> >
> >   Maciej



--

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

