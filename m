Return-Path: <linux-kernel+bounces-239700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49637926430
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32F61F2430B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C927817C213;
	Wed,  3 Jul 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="PTYYHWSH"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225233CE8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018905; cv=none; b=o99jxin3QAu/ttK7CvhaOy2RPgYJlupUUlYAgdtaSvr4tyMfVUp79iGUAtn7WK6DlsFAJBQY3dfdDIGUf0vkqY8gQ48QdEyrC3Je72/u34cod4MMt6ezr/NAd/v9urOnWgkq8zWWOUW4tE0aNeZGj3FQoxcKrlOCHjMrox0KNSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018905; c=relaxed/simple;
	bh=rl9eyC1/MJPguKp99TFdTk2qJHS1Oiy1Cuy+nGrM9+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPtPyTJTqtgNngw9R6NA4B/KaN1aqeLX2c9rE57XS0VjY6KdjSY2Y/lcwKoYsk8S1nbCXXkA3m4NNkFkakKJwNeWoGR/Ap2vWw7dK2DrbucvwIaApjEV6yw1SiajUYFFYDzlW/Zh1kfVaT261lYxWz+dWC8K/CGDFs3TYLTHSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=PTYYHWSH; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-37636c38d6aso24287195ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1720018903; x=1720623703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMRUfX0BK5RBjLAn5mop5AxUgXep4kIReWk5vXaWLb0=;
        b=PTYYHWSH+T2g6X0xMRL/HkdHOAz+hzJsL13QA+0TaNx+qIKWjYLqSUP/Z78BBnaQ5l
         81VeRX0ItG/RU76aHHu9mHsYeE0glNmsTZmACOgkYIj3vUMyjZvDvczoWIYwW+DNHTK0
         x5dDfFBfcKuMsF08XcY2f85bk3iMfg+M/AMoajv2RoE2G3phQtBVIvDHPccIZuoZso0d
         dHSShYrh6dhbYZh7uh74l7ctwt64qsg+PAfWGnqyqGyqqUAJS0bdfFfKhRgGMV91T28/
         LdmiuNo0pP80L+OS29xpJ0D88wAmxt3Hog8xBZJqc2D0t1MzEijZ1Znwmsd1a1aUFolL
         /CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720018903; x=1720623703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMRUfX0BK5RBjLAn5mop5AxUgXep4kIReWk5vXaWLb0=;
        b=scjxLXKORyeHHjDEQAw8CIE8tyuEd0j/CbYPygTrvhPGePOerl8ka7n7EI1YdebWGI
         Cj8H9Z4AHx3XoZJTAyObx8hV51mMq6FUuDMgmQXjC9NBc6m/oWpjoITQe6Z4LdQFthzD
         U9Mwi03kX3meQ6UQtXwQy6N8T/sCpIWiJfxfrGbnbOPKqIFHunkZ3JapENl2eijO89AA
         48Uurd0aax6Mno2bG5TM7FW3/IxWQq6fAZ78S1tCMwPrbd5pOhTpBDnDB9PZOVPImjBY
         iay9wgMU/ilQ5HNmEATjIWwnZT52OuQv5Sw1FwmcPEE6jfgxZy48xc5xKPBRbI86a015
         yf1w==
X-Forwarded-Encrypted: i=1; AJvYcCXpl2iktAa9L79MD4WRGjxhVRWg9EfQQHYZ2Ism8f1d4sqEwT+A1rYzokpV8+jfwfjXsx6DnS7GEudVEot8qwuvX/Z/BduD8bWdf4Eo
X-Gm-Message-State: AOJu0Yyok2cSFMsuTAI0Ti9rCsGK6/s1Txt80vznZAxk7tIItT3PqECp
	RRRZeZ0wk6r2K3XCmx/vapl06b0paBIP5zz2OW4NzUyHjeCb1pyGmNif77WCe3WjIp4rD7XcQ1w
	kg89DzhIyqJfAbU/LlOwr3IxkaGqE8b63MOndfA==
X-Google-Smtp-Source: AGHT+IETCrkwSv5xSicIihR2RzWpeOpdhkDXVmmb5uw1WCus4A9jiedPBfm0YhdKSAsHd7Q858BqR4nVhY2tCwDWajA=
X-Received: by 2002:a05:6e02:180a:b0:382:8ae4:d292 with SMTP id
 e9e14a558f8ab-3828ae4d428mr15645585ab.13.1720018903058; Wed, 03 Jul 2024
 08:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703072659.1427616-1-namcao@linutronix.de>
 <CAAhSdy0ZGD-p0iBVPqHF0RKTwvAAMWwYZ0ufioRrO75JzSh1qQ@mail.gmail.com> <20240703123327.CvOiP2Jb@linutronix.de>
In-Reply-To: <20240703123327.CvOiP2Jb@linutronix.de>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Jul 2024 20:31:31 +0530
Message-ID: <CAAhSdy3gZHnSwovxypY5vP438TNPj8h+miqtyBKhEUAdWj=htQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Fix plic_set_affinity() only enables
 1 cpu
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, b.spranger@linutronix.de, 
	Christoph Hellwig <hch@lst.de>, Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 6:03=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrote=
:
>
> On Wed, Jul 03, 2024 at 05:28:23PM +0530, Anup Patel wrote:
> > On Wed, Jul 3, 2024 at 12:57=E2=80=AFPM Nam Cao <namcao@linutronix.de> =
wrote:
> > >
> > > plic_set_affinity() only enables interrupt for the first possible CPU=
 in
> > > the mask. The point is to prevent all CPUs trying to claim an interru=
pt,
> > > but only one CPU succeeds and the other CPUs wasted some clock cycles=
 for
> > > nothing.
> > >
> > > However, there are two problems with that:
> > > 1. Users cannot enable interrupt on multiple CPUs (for example, to mi=
nimize
> > > interrupt latency).
> >
> > Well, you are assuming that multiple CPUs are always idle or available
> > to process interrupts. In other words, if the system is loaded running
> > some workload on each CPU then performance on multiple CPUs
> > will degrade since multiple CPUs will wastefully try to claim interrupt=
.
> >
> > In reality, we can't make such assumptions and it is better to target a
> > particular CPU for processing interrupts (just like various other inter=
rupt
> > controllers). For balancing interrupt processing load, we have software
> > irq balancers running in user-space (or kernel space) which do a
> > reasonably fine job of picking appropriate CPU for interrupt processing=
.
>
> Then we should leave the job of distributing interrupts to those tools,
> right? Not all use cases want minimally wasted CPU cycles. For example, i=
f
> a particular interrupt does not arrive very often, but when it does, it
> needs to be handled fast; in this example, clearly enabling this interrup=
t
> for all CPUs is superior.

This is a very specific case which you are trying to optimize and in the
process hurting performance in many other cases. There are many high
speed IOs (network, storage, etc) where rate of interrupt is high so for
such IO your patch will degrade performance on multiple CPUs.

>
> But I am sure there are users who don't use something like irqbalance and
> just let the system do the default behavior. So I see your point of not
> wasting CPU cycles. So, how about we keep this patch, but also add a
> "default policy" which evenly distributes the interrupts to individually
> CPUs (best effort only). Something like the un-tested patch below?

I would suggest dropping this patch and for the sake of distributing
interrupts at boot time we can have the below change.

>
> Best regards,
> Nam
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index f30bdb94ceeb..953f375835b0 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -312,7 +312,7 @@ static int plic_irqdomain_map(struct irq_domain *d, u=
nsigned int irq,
>         irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
>                             handle_fasteoi_irq, NULL, NULL);
>         irq_set_noprobe(irq);
> -       irq_set_affinity(irq, &priv->lmask);
> +       irq_set_affinity(irq, cpumask_of(cpumask_any_distribute(&priv->lm=
ask)));
>         return 0;
>  }
>

Regards,
Anup

