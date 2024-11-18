Return-Path: <linux-kernel+bounces-412566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C89D0ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BB1282051
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF96154C12;
	Mon, 18 Nov 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="F+so/XrY"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183013D245
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917986; cv=none; b=IrKKAkQPRFDy5w/u2biKZftALrfUNzuiIpiEgp2l9ke9kmn41hSRttDXgjviELALMpHbGiiNfhTeFboMlMbcv+Tno2W9/v7k6HRcGlN3MKwQviXVMvZUoPxXwlwxs4U16GWIqxNAsihiCvHdaf4KKRDVRmPk4KuyNJD4DiGc2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917986; c=relaxed/simple;
	bh=Plje8BKVK0YNuT7USNWc4KuYKEcITXfI2++SmD4fYiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LG4aj/uTl+hAoP30Oi412v5NN2k2MHcbvF+hqm56/x3KjBrYcLUAv7moS8I35kF8Bt8IyBxdZcPdptAKzaVI9hwEYtc7kr8L2GrjAuXlTCfscX3Pct+7/zIX4uUqDaKVXHLL8KxjHP1KHGXXYMvdZQUpjvAaCcnp87BTC1oO9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=F+so/XrY; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so35572431fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 00:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731917983; x=1732522783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL7DR0MIchN4jc3101S2uCnxiU21n65mb2bnlMUb1eI=;
        b=F+so/XrYq/+Qya0RhH5gbskM/iTubrPryMbp/mo7I2X4FcY+ktxn3NOyAvEXiNT6pp
         ergm++zaX7l9Pp6b9XXcdob/p+Za75dgFs1SAnczLgMgKdx8rMbx4PtqUEvxM97GM4r2
         DOX0D4Xz7xylGjbfeJoUvZfWRY1GwzE+3JBYm3DH4Xzh5ru3U9Ox0Cm0Beat3GHrNTPa
         sPoRj7WIBJ42Pn/lb3Fbp776+yHPq27Ydmt7KIc5pAdtNiPuxP55o944AdwB18WXNDg3
         l5bSW4F0vtTw5Z04+s6cdpeHYGlZXK3/6GaQ3EZXIbYW55d07WK2UQhdxZo6Qe50nIdx
         UGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731917983; x=1732522783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL7DR0MIchN4jc3101S2uCnxiU21n65mb2bnlMUb1eI=;
        b=TdB8on0fk9WOBR9HRHpaPwkUncEIitOt48L3Toft4TZWXwj4pLMX0aPkfymO3cqr7/
         bEmPTlvGJmFCo6eeBD+oKnZ4DWRL3omMkQ44NrPvMG1teo9fBeERQld55LwbMeAAF3KH
         tcN5v9JRSdPU4IdSa9zWZX9HXnJi7y2QRvXxjWxR8pRgumAlq5MayLBa6InLMgrX+cMr
         2oLjtRa/iXyWorxTgml/nj4CdbAekRtfoPOzzP2rqqiPBtXMBMyZLeeIf+Qnx0sObb+a
         l8RP1vqOKf5bWZZMOey28S8RcbsQkqTY+sDVTbZ9ETD9ooV0ql6IIsm3sR9/x4UuT9rZ
         FY+w==
X-Forwarded-Encrypted: i=1; AJvYcCUBv11J0qJo1ghTAWFGQXb8vDF668uBBXQOj4S0cPVOLvYzlKFH++iAOE2NLLyAv+g+AkqsosH/mOhaKgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhe4RZGpUAtA2tYabYh6wZVvHKW2FQqv5NcOSLN1OBIvozbWR7
	5Y5+u33YYwp9vnbmsz0wQeA0fKglLDkDcXXkRHCO639Iv6aa5d+fRbNIZUvjaUbdnzTIiGMDJ2o
	yP8TPpbsky9sftGpFqgUhLVl14rvmVb6sJbkoXA==
X-Google-Smtp-Source: AGHT+IFXxdjAQMxTzCz3q+UeUM/d1USw2cxgN6NHZjIuS69HTBTqTrNdF+5KD3y49qtYeM/ku7bbpPeQGQ/qf4pmM7A=
X-Received: by 2002:a2e:a9a9:0:b0:2fb:3ca8:efcd with SMTP id
 38308e7fff4ca-2ff6062afebmr44153871fa.12.1731917982723; Mon, 18 Nov 2024
 00:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114200133.3069460-1-samuel.holland@sifive.com>
 <CAK9=C2UyfmHqtYYK-WeSRk3=6bjs5nzDmw9ntudbCnPOYxLtXg@mail.gmail.com> <1bce34c6-c2d0-4b2b-a8f9-7bc8737702b1@sifive.com>
In-Reply-To: <1bce34c6-c2d0-4b2b-a8f9-7bc8737702b1@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 18 Nov 2024 13:49:31 +0530
Message-ID: <CAK9=C2UUq=k9JHrO9zeiPhdmakyzigm9ToQFM2S90bQs31=98w@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-aplic: Fix crash when MSI domain is missing
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 9:27=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2024-11-15 9:42 AM, Anup Patel wrote:
> > On Fri, Nov 15, 2024 at 1:31=E2=80=AFAM Samuel Holland
> > <samuel.holland@sifive.com> wrote:
> >>
> >> If the APLIC driver is probed before the IMSIC driver, the parent MSI
> >> domain will be missing, which causes a NULL pointer dereference in
> >> msi_create_device_irq_domain(). Avoid this by deferring probe until th=
e
> >> parent MSI domain is available. Use dev_err_probe() to avoid printing =
an
> >> error message when returning -EPROBE_DEFER.
> >
> > The -EPROBE_DEFER is not needed because we expect that platforms to
> > use "msi-parent" DT property in APLIC DT node which in-turn allows Linu=
x
> > DD framework to re-order probing based on fw_devlink dependencies. The
> > APLIC DT bindings mandates that any of "interrupt-extended" or "msi-par=
ent"
> > DT properties MUST be present.
> >
> > Can you elaborate a bit more on how you are hitting this issue ?
>
> I agree that fw_devlink should help avoid the situation where we need to =
return
> -EPROBE_DEFER, but the kernel must still not crash even if fw_devlink is
> disabled (which is a perfectly valid thing to do: "fw_devlink=3Doff" on t=
he kernel
> command line) or if fw_devlink fails to come up with the ideal probe orde=
r.
> fw_devlink is an optimization. It should not be relied on for correctness=
. In my
> specific case, fw_devlink got the order wrong due to some false dependenc=
y
> cycles, which I sent a patch for separately[1].

The RISC-V kernel is heavily dependent on fw_devlink based probe ordering
and more upcoming drivers are going to increase this dependency.
For example, we also have RISC-V IOMMU driver that needs to be probed
after IMSIC since it can use MSIs.

I think we should ensure that fw_devlink can't be disabled/turned-off for t=
he
RISC-V kernel. If this is not possible then we should have very verbose
boot-time warning when fw_devlink is disabled/turned-off.

Your other "interrupt-parent" related fix [1] looks fine to me.

Regards,
Anup

>
> Regards,
> Samuel
>
> [1]:
> https://lore.kernel.org/lkml/20241114195652.3068725-1-samuel.holland@sifi=
ve.com/
>
> >> Fixes: ca8df97fe679 ("irqchip/riscv-aplic: Add support for MSI-mode")
> >> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >> ---
> >>
> >>  drivers/irqchip/irq-riscv-aplic-main.c | 3 ++-
> >>  drivers/irqchip/irq-riscv-aplic-msi.c  | 3 +++
> >>  2 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/=
irq-riscv-aplic-main.c
> >> index 900e72541db9..93e7c51f944a 100644
> >> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> >> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> >> @@ -207,7 +207,8 @@ static int aplic_probe(struct platform_device *pde=
v)
> >>         else
> >>                 rc =3D aplic_direct_setup(dev, regs);
> >>         if (rc)
> >> -               dev_err(dev, "failed to setup APLIC in %s mode\n", msi=
_mode ? "MSI" : "direct");
> >> +               dev_err_probe(dev, rc, "failed to setup APLIC in %s mo=
de\n",
> >> +                             msi_mode ? "MSI" : "direct");
> >>
> >>  #ifdef CONFIG_ACPI
> >>         if (!acpi_disabled)
> >> diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/i=
rq-riscv-aplic-msi.c
> >> index 945bff28265c..fb8d1838609f 100644
> >> --- a/drivers/irqchip/irq-riscv-aplic-msi.c
> >> +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> >> @@ -266,6 +266,9 @@ int aplic_msi_setup(struct device *dev, void __iom=
em *regs)
> >>                         if (msi_domain)
> >>                                 dev_set_msi_domain(dev, msi_domain);
> >>                 }
> >> +
> >> +               if (!dev_get_msi_domain(dev))
> >> +                       return -EPROBE_DEFER;
> >>         }
> >>
> >>         if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &ap=
lic_msi_template,
> >> --
> >> 2.45.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
>

