Return-Path: <linux-kernel+bounces-445096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2DC9F1134
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8E11883CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC141E3765;
	Fri, 13 Dec 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="M8RybsNq"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A71E32CB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104648; cv=none; b=tvcJ0CSfpJl3/7sxc4fAhSWKGHgtELFq8u0VW5pvMYdWU4o3DPBwLUXyUqPFX/6gpHIRBdZKGJ8is+XFENKxOceZxNQRlrOoWJHbulzywuQ5ma76LibpknEb1RgzxN6rIp+UwIkrm3dkoPLhbZzR7RqUGwmP2jKCpgpusorIFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104648; c=relaxed/simple;
	bh=yUqHq0lbebJEoW8xZlmwhDVjB4dI3bj/g8P3DfRDrxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVqYNzK6Hgdsk/jIks5gKbQmCzdPWUui8OvkRDYzfmNz0+FxTk/2CwJJ/zhRCufZljTERNC/bBq0ukEaRCyXg+q3oi0pqU/+aOpGR2qO6an0CJnqB2fQdMGMBxcpLX2MNk+JKkpC/GCAuDtrFsBmacjDDnJl+DUKXiJU4bs/pf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=M8RybsNq; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5401ab97206so1916399e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734104644; x=1734709444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0ijAsgfcCAkYLFOhSL209z2mytAy3LE8Gke6LPHkUA=;
        b=M8RybsNq+TaxS4BFZnOOqwVqUE4ByeZJ6WrYnaorK84GhUrNCMgnmfL1c+ubAr5DNz
         kgoBNhB7igIgAHXxHC8S7BeK5kbQa6/SQD+aj7yOslpX/hdCBxrw0EDFIHGrfYJSOb5Y
         e/iRi6vcru6lNe2ZEnon685C84Igz2DmmwLcalgGsV1kD03DWyrbQUQ2AhFWhEmPdorq
         hhDWgQ6zZ9yk48qQ7+zMGAVej0jJRNvt7yY3SpSVhgJU+2x+rmqmFwq9/oiQMjHGetoQ
         8WLkLQqEQEb9Lzp37Em61nk94Cm91K5M1n7pCvRbTzRdAxeE9/5mfYNc5kFaeMV2gKTn
         xCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734104644; x=1734709444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0ijAsgfcCAkYLFOhSL209z2mytAy3LE8Gke6LPHkUA=;
        b=qjlMOcFmL3UKGHqoClC4fwA9HvZM+dJQJag+ggwcjxtXQnnkOkz7TAoC7zHQ94u3s5
         KRvn9Bdiwtg1PS5xzJTdq+j723J+TOyTyHi4LWs2Qb2mWzzb/y1ZFD5Fnpe6GTdnI26q
         dsVsRztURs5Ub8/VeP+Ur5k+pFSni+rv6FX3q2LwC5T12aIL9Whx/dUNEbGbVLH2FStD
         owjHeP20DJTcrCGq8aErPZbi/XgvmyjeLbH478sAK08BS5Yz2dZshv/faBSrVlELsg7K
         UnGfF5eigzqxDuESQHoI+oWYth2WtDcDZe2RTfeZEip96YTW2abqnU+k0Ua2enAtTaoi
         L6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWx2bTBKVHx82OqDrUD5yxlEcwGBwVs/tu1JFWC59YGSgAY+Svr/jKoZaMj+A1PFhnsF1e7FVJhBBFyL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykclhzU/KFgAw0kGUzZd1Uq9qqPaB0Uj4LVFU4HE+1vkZY18bn
	n+jWaCgErmKmSGkZfxFGKLTVuTBryBRpVAwcPHVTG6As4ObNNshpx0qr7YE1C26GySJKhyxjFXx
	CMK+1iGSDZwZJn4EBJfr5ZKZg7vasbPefj2zVKA==
X-Gm-Gg: ASbGnct23ol+jS6qg5YBBLVeR/gf7WTOdzxhoR5oDDaYTd0A6uYE4bkj6tC1ijk2OHS
	gShCrhtNErTP5qvkjIYLk3e57crBJnM3qRycggKY=
X-Google-Smtp-Source: AGHT+IFTUSDlblXeHlfVDe8niGAxTlpQ6jMgiT9dHwTwMbW1zIwAk0PUlMzR2hff1vm/DrjTiJgiQiYP2mI3M++ExsU=
X-Received: by 2002:a05:6512:39cc:b0:540:2f59:7561 with SMTP id
 2adb3069b0e04-54099b699d2mr968768e87.50.1734104644176; Fri, 13 Dec 2024
 07:44:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208150711.297624-1-apatel@ventanamicro.com>
 <20241208150711.297624-2-apatel@ventanamicro.com> <875xnuq6dc.ffs@tglx>
 <CAK9=C2VqU2mdLL-R20bdgvDHi0WcuNyUSqRo7Pztsu-8X1wVvw@mail.gmail.com>
 <87r06gq2di.ffs@tglx> <CAK9=C2XEhtB00y6WTMaO0X=7K820T_BSCLA5bw6hJbfvQAD+Pw@mail.gmail.com>
 <877c84ade6.ffs@tglx>
In-Reply-To: <877c84ade6.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 13 Dec 2024 21:13:52 +0530
Message-ID: <CAK9=C2Xyqk1WRHTXa_74s1uWuuMP5d=RBpnoSREvuF=C3OWW_A@mail.gmail.com>
Subject: Re: [PATCH 1/4] irqchip/riscv-imsic: Handle non-atomic MSI updates
 for device
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 1:21=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Dec 12 2024 at 22:11, Anup Patel wrote:
> >> --- a/kernel/irq/chip.c
> >> +++ b/kernel/irq/chip.c
> >> @@ -47,6 +47,13 @@ int irq_set_chip(unsigned int irq, const
> >>                 return -EINVAL;
> >>
> >>         desc->irq_data.chip =3D (struct irq_chip *)(chip ?: &no_irq_ch=
ip);
> >> +
> >> +       if (IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS) && chip) =
{
> >> +               if (chip->flags & IRQCHIP_MOVE_DEFERRED)
> >> +                       irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
> >> +               else
> >> +                       irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
> >> +       }
> >
> > We need similar changes in irq_domain_set_hwirq_and_chip()
> > because we use IRQ_DOMAIN_HIERARCHY in RISC-V.
>
> Grr, you are right. Let me add that to the base patch.
>
> >>         irq_put_desc_unlock(desc, flags);
> >>         /*
> >>          * For !CONFIG_SPARSE_IRQ make the irq show up in
> >> @@ -1114,16 +1121,21 @@ void irq_modify_status(unsigned int irq,
> >>         trigger =3D irqd_get_trigger_type(&desc->irq_data);
> >>
> >>         irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
> >> -                  IRQD_TRIGGER_MASK | IRQD_LEVEL | IRQD_MOVE_PCNTXT);
> >> +                  IRQD_TRIGGER_MASK | IRQD_LEVEL);
> >>         if (irq_settings_has_no_balance_set(desc))
> >>                 irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
> >>         if (irq_settings_is_per_cpu(desc))
> >>                 irqd_set(&desc->irq_data, IRQD_PER_CPU);
> >> -       if (irq_settings_can_move_pcntxt(desc))
> >> -               irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
> >>         if (irq_settings_is_level(desc))
> >>                 irqd_set(&desc->irq_data, IRQD_LEVEL);
> >>
> >> +       /* Keep this around until x86 is converted over */
> >> +       if (!IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS)) {
> >> +               irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
> >> +               if (irq_settings_can_move_pcntxt(desc))
> >> +                       irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
> >> +       }
> >> +
> >
> > These changes in irq_modify_status() need to be dropped to support
> > the above changes in irq_domain_set_hwirq_and_chip().
>
> Why? With CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS enabled this hunk is
> compiled out. So nothing is modifying PCNTXT here. That's the whole
> point.
>

Understood, please ignore my previous comment.

I was using irq_set_status_flags() in irq_domain_set_hwirq_and_chip()
which did not work because irq_modify_status() did not modify PCNTXT.

Regards,
Anup

