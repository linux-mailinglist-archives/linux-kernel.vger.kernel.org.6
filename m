Return-Path: <linux-kernel+bounces-222670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B691058D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234C81F20597
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB3C1ACE6C;
	Thu, 20 Jun 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BT4JQ9hx"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0298E8175E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889146; cv=none; b=H179wfBw7iqY3G5ekdVtLHXw+aDvFDSq87Uqh+CZ++d9DJriBWesKKK9ekT6qNB9kuyNnLOyNgzVQAOlXUqRanBYDlHdj9a2dWcBVGto9g+sazjUjq48u9xKjPaWkO9Px6zM+akwZd4iTUTF9SOE2tYj1fa67TYwTxr3KiWfzAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889146; c=relaxed/simple;
	bh=gdjBTQWDEVOBtX8NqQJCIxboAlgw5kMxXI/nszQmTdI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQHM4FLKIP7DRW90smtIobXQ90WypP1Eq1uDl70k49b41uuVh794t5qvKaspw0/94Fwuhls5+b2j1i0/bqclvKMV5x72nGrZywkgvArvsMkjpA8+ynSI9tVoVW4hfYVcHEuD8+6a7CHuad0giHg6oPOJ9VusuyqATJsyiRMXn1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BT4JQ9hx; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6D95041288
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718889143;
	bh=cBEqkA9XFFNYFCNoxH+x9nm8QNcAohLnExcrRCNI8yQ=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BT4JQ9hxJDZZWrQaaUcQa5JyluDNeKyi3qmN6Timu7HGPXg6savt64Vv2/AQ4TIbc
	 L18ScdR/8kb9r3zxRQS3nObzI+ndnJm2qciyzOubEIuPX6SdJX5l/pbK884vVf/gUE
	 YERGi1D0hDEWryBZnRuopaaOoHgtJHjjQvC76UohREVkDbkzowFF2QheGfmySusVs5
	 cUN3k7K2EfFPE3xMij7VJxyzcbH2+epCKhGWKx7DMLTFUhpmqo5y2ESWrWJOsWkk28
	 PCmrxVr+3NDzDWD9wTvzKuo0V0AgyuJyYQ/q4kEeyRiITiQBE8ezwo3kD7ay/dVu4b
	 9RAKHPGxu7EyA==
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-79551410d15so111613985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718889140; x=1719493940;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cBEqkA9XFFNYFCNoxH+x9nm8QNcAohLnExcrRCNI8yQ=;
        b=tkxQ8WgiOIkAxj9/Cq1dOKDKpABJxF9nKNPjqsZh4fFYeLVWKOiDVf/sfCRK5FNbF3
         RSv69ffyFT0s4OVtwe2C4N7TgmVZjLzVK5T8kW3LmzRfb2vdzNhFutnXtkwvyyXlO4tp
         KI7xY3oOJfNoeu3kOEwExPOW/ryMohsrHsuklW0sekpdppywf0D/7S6YoSFOX6n68j/u
         tal9fxcB7WOJJGAmCk6kZ7JRfDPAz6UOfkXy8LN+jky5+GszxMpg+19BpVkastegHd+X
         Yc/o3mrfmszl9f285vvf96HO3NpjfHITPkVYN55KtHVVObg7l+0j2lqTh7zyaN3eCv5a
         KPxA==
X-Forwarded-Encrypted: i=1; AJvYcCX46WHjtY6hYvhzzVYZyWQ/KBbATSgbIBiZL2YT7fjdKA++5x6BwdMmCN8GdvkIVeX+e04lqi1nsVc0OvF/HYZTrXpXNqyDdeNsMfyG
X-Gm-Message-State: AOJu0Ywwgnk1mggcgWkE4j9sqNlojPnof2BlF9FgADvlkIX3/ZlIsONg
	3TuE8sdof2UPIJbZGX9MLr3o2pTbH4N83T+voYu2ZX+0ul+wL7RsH0ievYIpud1WjhqTMS0nj2r
	K6dfzS+nlABNQ3djLUNuElFjV+T/QRkbItr0rA7lI9nKW6cuPoVgHpB3umDjXQKHEzMMCKwvsUY
	PsgY7rRpKi5Qa1z9JB4E0QtCUwDIUFCWAPCe1IM1BScjZKnd6Ta1ls
X-Received: by 2002:ac8:588f:0:b0:43e:26c1:1244 with SMTP id d75a77b69052e-444a7ac0548mr57767831cf.50.1718888532597;
        Thu, 20 Jun 2024 06:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6eCTjNnfu3F3ib5NWq3b3KdavDTGolKno6eVMzl+GyjWyJmaYOBj8Y4jy7Y1eGgGWaRGa2dTIwgT8Nu1YTM8=
X-Received: by 2002:ac8:588f:0:b0:43e:26c1:1244 with SMTP id
 d75a77b69052e-444a7ac0548mr57767431cf.50.1718888532107; Thu, 20 Jun 2024
 06:02:12 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Jun 2024 08:02:11 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAAhSdy1pesbdTfWnFURMJRcy2ujjX+cXtt-cfLDj2CQf2Ua_gw@mail.gmail.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com> <CAJM55Z9hGKo4784N3s3DhWw=nMRKZKcmvZ58x7uVBghExhoc9A@mail.gmail.com>
 <CAK9=C2WP2+gKScUFuoE9782gjSfnDtcLAw01eCwram3LMAStBg@mail.gmail.com>
 <CAJM55Z8ti-ePT0t714h1Za9X3Ns3=Fw0pCu3NZ=7eT76JU_p5g@mail.gmail.com> <CAAhSdy1pesbdTfWnFURMJRcy2ujjX+cXtt-cfLDj2CQf2Ua_gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 20 Jun 2024 08:02:11 -0500
Message-ID: <CAJM55Z_=94+aMv=ywhih44eF0pR2WXiyx3FcrwRaX6tZto4gpQ@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Anup Patel <anup@brainfault.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Anup Patel wrote:
> On Wed, Jun 19, 2024 at 11:16=E2=80=AFPM Emil Renner Berthing
> <emil.renner.berthing@canonical.com> wrote:
> >
> > Anup Patel wrote:
> > > On Tue, Jun 18, 2024 at 7:00=E2=80=AFPM Emil Renner Berthing
> > > <emil.renner.berthing@canonical.com> wrote:
> > > >
> > > > Anup Patel wrote:
> > > > > The PLIC driver does not require very early initialization so con=
vert
> > > > > it into a platform driver.
> > > > >
> > > > > After conversion, the PLIC driver is probed after CPUs are brough=
t-up
> > > > > so setup cpuhp state after context handler of all online CPUs are
> > > > > initialized otherwise PLIC driver crashes for platforms with mult=
iple
> > > > > PLIC instances.
> > > > >
> > > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > >
> > > > Hi Anup,
> > > >
> > > > Sorry for the late reply to the mailing list, but ever since 6.9 wh=
ere this was
> > > > applied my Allwinner D1 based boards no longer boot. This is the lo=
g of my
> > > > LicheeRV Dock booting plain 6.10-rc4, locking up and then rebooting=
 due to the
> > > > the watchdog timing out:
> > > >
> > > > https://pastebin.com/raw/nsbzgEKW
> > > >
> > > > On 6.10-rc4 I can bring the same board to boot by reverting this pa=
tch and all
> > > > patches building on it. Eg.:
> > > >
> > > >   git revert e306a894bd51 a7fb69ffd7ce abb720579490 \
> > > >              956521064780 a15587277a24 6c725f33d67b \
> > > >              b68d0ff529a9 25d862e183d4 8ec99b033147
> > >
> > > Does your board boot with only SBI timer driver enabled ?
> >
> > I'm not 100% sure this is what you mean, but with this change I can dis=
able
> > CONFIG_SUN4I_TIMER:
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index f51bb24bc84c..0143545348eb 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -39,7 +39,6 @@ config ARCH_SUNXI
> >         bool "Allwinner sun20i SoCs"
> >         depends on MMU && !XIP_KERNEL
> >         select ERRATA_THEAD
> > -       select SUN4I_TIMER
> >         help
> >           This enables support for Allwinner sun20i platform hardware,
> >           including boards based on the D1 and D1s SoCs.
> >
> >
> > But unfortunately the board still doesn't boot:
> > https://pastebin.com/raw/AwRxcfeu
>
> I think we should enable debug prints in DD core and see
> which device is not getting probed due to lack of a provider.
>
> Just add "#define DEBUG" at the top in drivers/base/core.c
> and boot again with "loglevel=3D8" kernel parameter (along with
> the above change).

With the above changes this is what I get:
https://pastebin.com/raw/JfRrEahT

/Emil

