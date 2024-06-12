Return-Path: <linux-kernel+bounces-211048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D3904C86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB551C22AED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11069770EA;
	Wed, 12 Jun 2024 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX/WqQcs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C03C17C9;
	Wed, 12 Jun 2024 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176590; cv=none; b=jw29j+0cQKJlJgxxVdnar0r3B8aa/V8I1DgvWFVTVYrG24VzbEVorWFiLARreLFFEa2sDQcTjHfBMvsFy35FK9pXoX9l0M0DuKHlLpbPltcwu9cpMhc2w+sTOB4jHMUH5J970RMcNMhfbl4kFSDvHb2jvJaBtiMqfUHRFAeasTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176590; c=relaxed/simple;
	bh=QCzJfT4L5WEPzzEaVyLWPwHcQFBrPimMK0vS8lZHEU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCybNVJ0DQItLID7TEPf1uhbegXTq3HTJa0tfd92IRrPluz7BIzmhDLJwWtJ+sqIquypsQqemkPx1VXszFZFbO+jpsaY4CTiTMz57bQPrMG6Ut1jj+CISBhVaGULwiEgLFST1fGQt98ZMYvrn+q0g2L8G56Cf3plj03rxds7Te4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX/WqQcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA79C3277B;
	Wed, 12 Jun 2024 07:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718176589;
	bh=QCzJfT4L5WEPzzEaVyLWPwHcQFBrPimMK0vS8lZHEU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NX/WqQcsiMpcxRh22NWefcxfcyRvVmsiI/5CW05evHeQ4nhZuAEj4zWQgxzzw4ypX
	 O97WyMfWvHuNKQ+qI4H7lVBjpx4+sh3f4hYcvCIxqVbd/kSRrcFRngSONAJmfwLN3W
	 j8BYYKdj9RfO6x5hXg+9Q2JbZWkI2RJd/z4s0rJeosINNFSX16cVvJbpVsXp9qQLn+
	 NEq07toZ1thpvYQ1Ckp582sCOTi/upJAJuaLEHNTzhz18ZWMh1gGL2tfhko9ypHNcW
	 GDO4/eJsA02ce+EsVvCNsiRk88pSKlvtSsJKdjiC+Y/lRNzeFo692pc+ZonvOgouD3
	 v32V0YOyliOnw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6efe62f583so171927266b.3;
        Wed, 12 Jun 2024 00:16:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh/MIjz2b1OcnFhSLaJdAYR6VIpvxPCx4JItDMY3uG+NjFNhX6v71ROpyLItZMuDKCr2fLRRZ7RgKaIqAtfA1FILkEGqaG1x2hTMBvVk/4ijML+VxwaAM4VuhXXNlHi21vOV+JH0pw
X-Gm-Message-State: AOJu0Yw06Kl/FebqDUp2G19zmws5i3XsJzSI53C4+E3N11dXvi1eDo5W
	BzhJmerzKbai90vIfm1mEV9ImTbmVdi/T6HNtES5eB05w065uTAZnCcXhOSnx7Sr5sjgTAgpfxG
	UTLmNT7poI67IIZhsvkSNCdJbPvA=
X-Google-Smtp-Source: AGHT+IF/WPIgoWfe8gKw39gmVo4YfRd0wByy17LJSyVT/aHMWfynrQAAjcIijApw1r/NwOprprwjPjlqDZfHpAhnVmo=
X-Received: by 2002:a17:907:6d1f:b0:a6f:4971:7d0d with SMTP id
 a640c23a62f3a-a6f49717e05mr50006166b.55.1718176588211; Wed, 12 Jun 2024
 00:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604125015.18678-1-zhangtianyang@loongson.cn>
In-Reply-To: <20240604125015.18678-1-zhangtianyang@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 12 Jun 2024 15:15:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H704OFWf87v4TaEzNDRPOXZYPMTgZnuWtvbE4CzPjYH3g@mail.gmail.com>
Message-ID: <CAAhV-H704OFWf87v4TaEzNDRPOXZYPMTgZnuWtvbE4CzPjYH3g@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] docs: Add advanced extended IRQ model description
To: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn, 
	loongarch@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tianyang,

On Tue, Jun 4, 2024 at 8:50=E2=80=AFPM Tianyang Zhang <zhangtianyang@loongs=
on.cn> wrote:
>
> From 3C6000, Loongarch began to support advanced extended
> interrupt mode, in which each CPU has an independent interrupt
> vector number.This will enhance the architecture's ability
> to support modern devices
>
> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> ---
>  .../arch/loongarch/irq-chip-model.rst         | 33 +++++++++++++++++
>  .../zh_CN/arch/loongarch/irq-chip-model.rst   | 37 +++++++++++++++++--
>  2 files changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentat=
ion/arch/loongarch/irq-chip-model.rst
> index 7988f4192363..4fb24077b23b 100644
> --- a/Documentation/arch/loongarch/irq-chip-model.rst
> +++ b/Documentation/arch/loongarch/irq-chip-model.rst
> @@ -85,6 +85,39 @@ to CPUINTC directly::
>      | Devices |
>      +---------+
>
> +Advanced Extended IRQ model
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer inter=
rupt go
> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, MSI interrupts =
go to AVEC,
> +and then go to CPUINTC, Other devices interrupts go to PCH-PIC/PCH-LPC a=
nd gathered
> +by EIOINTC, and then go to CPUINTC directly::
> +
> + +-----+     +--------------------------+     +-------+
> + | IPI | --> |           CPUINTC        | <-- | Timer |
> + +-----+     +--------------------------+     +-------+
> +              ^        ^             ^
> +              |        |             |
> +      +--------+  +---------+ +---------+     +-------+
> +      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
> +      +--------+  +---------+ +---------+     +-------+
> +           ^            ^
> +           |            |
> +         +---------+  +---------+
> +         |   MSI   |  | PCH-PIC |
> +         +---------+  +---------+
Please change MSI to PCH-MSI, because it is called pch-msi the both
the in driver name and in other figures of this document.

Huacai

> +            ^          ^       ^
> +            |          |       |
> +    +---------+ +---------+ +---------+
> +    | Devices | | PCH-LPC | | Devices |
> +    +---------+ +---------+ +---------+
> +                     ^
> +                     |
> +                +---------+
> +                | Devices |
> +                +---------+
> +
> +
>  ACPI-related definitions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-mod=
el.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> index f1e9ab18206c..cadf38589059 100644
> --- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> +++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> @@ -9,9 +9,8 @@
>  LoongArch=E7=9A=84IRQ=E8=8A=AF=E7=89=87=E6=A8=A1=E5=9E=8B=EF=BC=88=E5=B1=
=82=E7=BA=A7=E5=85=B3=E7=B3=BB=EF=BC=89
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -=E7=9B=AE=E5=89=8D=EF=BC=8C=E5=9F=BA=E4=BA=8ELoongArch=E7=9A=84=E5=A4=84=
=E7=90=86=E5=99=A8=EF=BC=88=E5=A6=82=E9=BE=99=E8=8A=AF3A5000=EF=BC=89=E5=8F=
=AA=E8=83=BD=E4=B8=8ELS7A=E8=8A=AF=E7=89=87=E7=BB=84=E9=85=8D=E5=90=88=E5=
=B7=A5=E4=BD=9C=E3=80=82LoongArch=E8=AE=A1=E7=AE=97=E6=9C=BA
> -=E4=B8=AD=E7=9A=84=E4=B8=AD=E6=96=AD=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=88=
=E5=8D=B3IRQ=E8=8A=AF=E7=89=87=EF=BC=89=E5=8C=85=E6=8B=ACCPUINTC=EF=BC=88CP=
U Core Interrupt Controller=EF=BC=89=E3=80=81LIOINTC=EF=BC=88
> -Legacy I/O Interrupt Controller=EF=BC=89=E3=80=81EIOINTC=EF=BC=88Extende=
d I/O Interrupt Controller=EF=BC=89=E3=80=81
> +LoongArch=E8=AE=A1=E7=AE=97=E6=9C=BA=E4=B8=AD=E7=9A=84=E4=B8=AD=E6=96=AD=
=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=88=E5=8D=B3IRQ=E8=8A=AF=E7=89=87=EF=BC=89=
=E5=8C=85=E6=8B=ACCPUINTC=EF=BC=88CPU Core Interrupt Controller=EF=BC=89=E3=
=80=81
> +LIOINTC=EF=BC=88Legacy I/O Interrupt Controller=EF=BC=89=E3=80=81EIOINTC=
=EF=BC=88Extended I/O Interrupt Controller=EF=BC=89=E3=80=81
>  HTVECINTC=EF=BC=88Hyper-Transport Vector Interrupt Controller=EF=BC=89=
=E3=80=81PCH-PIC=EF=BC=88LS7A=E8=8A=AF=E7=89=87=E7=BB=84=E7=9A=84=E4=B8=BB=
=E4=B8=AD
>  =E6=96=AD=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=89=E3=80=81PCH-LPC=EF=BC=88LS=
7A=E8=8A=AF=E7=89=87=E7=BB=84=E7=9A=84LPC=E4=B8=AD=E6=96=AD=E6=8E=A7=E5=88=
=B6=E5=99=A8=EF=BC=89=E5=92=8CPCH-MSI=EF=BC=88MSI=E4=B8=AD=E6=96=AD=E6=8E=
=A7=E5=88=B6=E5=99=A8=EF=BC=89=E3=80=82
>
> @@ -87,6 +86,38 @@ PCH-LPC/PCH-MSI=EF=BC=8C=E7=84=B6=E5=90=8E=E8=A2=ABEIO=
INTC=E7=BB=9F=E4=B8=80=E6=94=B6=E9=9B=86=EF=BC=8C=E5=86=8D=E7=9B=B4=E6=8E=
=A5=E5=88=B0=E8=BE=BECPUINTC::
>      | Devices |
>      +---------+
>
> +=E9=AB=98=E7=BA=A7=E6=89=A9=E5=B1=95IRQ=E6=A8=A1=E5=9E=8B
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=A8=A1=E5=9E=8B=E9=87=8C=E9=9D=A2=EF=BC=8C=
IPI=EF=BC=88Inter-Processor Interrupt=EF=BC=89=E5=92=8CCPU=E6=9C=AC=E5=9C=
=B0=E6=97=B6=E9=92=9F=E4=B8=AD=E6=96=AD=E7=9B=B4=E6=8E=A5=E5=8F=91=E9=80=81=
=E5=88=B0CPUINTC=EF=BC=8C
> +CPU=E4=B8=B2=E5=8F=A3=EF=BC=88UARTs=EF=BC=89=E4=B8=AD=E6=96=AD=E5=8F=91=
=E9=80=81=E5=88=B0LIOINTC=EF=BC=8CMSI=E4=B8=AD=E6=96=AD=E5=8F=91=E9=80=81=
=E5=88=B0AVEC=EF=BC=8C=E8=80=8C=E5=90=8E=E9=80=9A=E8=BF=87AVEC=E9=80=81=E8=
=BE=BECPUINTC=EF=BC=8C=E8=80=8C
> +=E5=85=B6=E4=BB=96=E6=89=80=E6=9C=89=E8=AE=BE=E5=A4=87=E7=9A=84=E4=B8=AD=
=E6=96=AD=E5=88=99=E5=88=86=E5=88=AB=E5=8F=91=E9=80=81=E5=88=B0=E6=89=80=E8=
=BF=9E=E6=8E=A5=E7=9A=84PCH-PIC/PCH-LPC=EF=BC=8C=E7=84=B6=E5=90=8E=E7=94=B1=
EIOINTC=E7=BB=9F=E4=B8=80=E6=94=B6=E9=9B=86=EF=BC=8C=E5=86=8D=E7=9B=B4
> +=E6=8E=A5=E5=88=B0=E8=BE=BECPUINTC::
> +
> + +-----+     +--------------------------+     +-------+
> + | IPI | --> |           CPUINTC        | <-- | Timer |
> + +-----+     +--------------------------+     +-------+
> +              ^        ^             ^
> +              |        |             |
> +      +--------+  +---------+ +---------+     +-------+
> +      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
> +      +--------+  +---------+ +---------+     +-------+
> +              ^        ^
> +              |        |
> +      +---------+  +-------------+
> +      |   MSI   |  |   PCH-PIC   |
> +      +---------+  +-------------+
> +            ^          ^       ^
> +            |          |       |
> +    +---------+ +---------+ +---------+
> +    | Devices | | PCH-LPC | | Devices |
> +    +---------+ +---------+ +---------+
> +                     ^
> +                     |
> +                +---------+
> +                | Devices |
> +                +---------+
> +
>  ACPI=E7=9B=B8=E5=85=B3=E7=9A=84=E5=AE=9A=E4=B9=89
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> 2.20.1
>

