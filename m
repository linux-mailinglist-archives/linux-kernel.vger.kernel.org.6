Return-Path: <linux-kernel+bounces-541830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D256AA4C21D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB00D189482E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2681A212B1B;
	Mon,  3 Mar 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+qQv2BB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C81E86E;
	Mon,  3 Mar 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009024; cv=none; b=OKZVkKi8fKG7oyRA0hDU15E9DvRGACaMk5F/8X4kBgYUVLA++D3k4K+Qq41NyLdi/QOFbBYo6wr83syZHDTJ20nx/22izPhbIT1hjdOX0gOrI2+lgWAECB0PbnvgRd37xeXQl7r+AykQD/J9hI8P423ooB/ul55FXiDjHFIpLWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009024; c=relaxed/simple;
	bh=FCDWHLpqYyGBcKEf9TBXuM8o1C7cMkdG3rKrO2RywlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRJjvq7vwb4c2l03Fx8QusBjkGT0ef2VANGw2sUdoj09sFw/fYfnr5zj5sfKRMbZV0LGYqfNyJx/WuL/NxbkuQAdalKQ6LWCGMDWDxW/k7KtqK1ImWq55Fn7IfDprxIpqQCA+pvSxhs0vQssvz46LA8yMiHMjiSR2RVxLK3mmcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+qQv2BB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA90C4CEE9;
	Mon,  3 Mar 2025 13:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741009023;
	bh=FCDWHLpqYyGBcKEf9TBXuM8o1C7cMkdG3rKrO2RywlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l+qQv2BBEyrLPrvo15L+rCaDyUUD6qNSM6qFLuIh7uj+UJVeEkTEuseT6GQb2OkVS
	 pDYs+7uyFiHFYwh6obdlarUUkAQPIikP/IScKGHiS+o7Az7OiGfcWmisRE0PYhIs6F
	 aexgXziF04ZvLtqX4KXhivG2JuM0h/W1RJGokCM9/SrAu1HpqVnFbKW4QYORBHlaXE
	 UzXFb7DD3zv7fngyUUTVdOqzN4DRSCdItHMXFpDvDZDqrlxfMH3OAebd4003uOtSX2
	 OVjKdLPWSQmWuJuevYKA7BqpHxKw87RD/2KQyyzP1zzBPemSKvFVaJHZy3wCpIMBi4
	 huFn+zLo69E7g==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e55ec94962so1165719a12.3;
        Mon, 03 Mar 2025 05:37:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjXKSA//ripRo2U5y9W/xrIC87wUTmMQNvL8CyH0T7g5NMfjGRpo8MyhzO8+lhDdMCdirRRZSblR4tfDgB@vger.kernel.org, AJvYcCXTBWX/xmVwZ0HxjxXro0/i4qIMwyDjTc/GtPtYg1zisrDsKS0D8cKHWKTjRsO54S3Zeqymr3c0Apc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRW+qNZhT1UBqGkKG4hWzAy+sXYdRXPdTTEj9+vM8V4q/TDIi
	MCezPCK9ltHu41eGa5PJt//SyitwBpVGX+0Gq0k4/iNR/K3zmTHIuwXFgf7SuY2CTbZlehcX9sw
	G0Jyg5AGBzIX++54vy+5qocjdLgM=
X-Google-Smtp-Source: AGHT+IHyK+wBxYsR+oHpjE/wdwx7WWfPi6qPUwdApgPy7XgVtJApQ0wUiduoCZOUwzw1d3OuAJQBxz2qiC5GprwxoIo=
X-Received: by 2002:a17:907:d90:b0:ac1:e332:b1ec with SMTP id
 a640c23a62f3a-ac1e332b41dmr193474066b.10.1741009022426; Mon, 03 Mar 2025
 05:37:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303101533.31462-1-zhangtianyang@loongson.cn> <20250303101533.31462-2-zhangtianyang@loongson.cn>
In-Reply-To: <20250303101533.31462-2-zhangtianyang@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 3 Mar 2025 21:36:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5xx7UnM1PpwDEJoq8kw6=uyzuhCiNbokF8tYNx7F1Jeg@mail.gmail.com>
X-Gm-Features: AQ5f1JpzwJnmwp8jqgTL_GUj2GDnrsEtrGwLrXXpA1OC7P5fCJl1eN5T8JpIq-I
Message-ID: <CAAhV-H5xx7UnM1PpwDEJoq8kw6=uyzuhCiNbokF8tYNx7F1Jeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Docs/LoongArch: Add Advanced Extended-Redirect IRQ
 model description
To: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org, si.yanteng@linux.dev, 
	tglx@linutronix.de, jiaxun.yang@flygoat.com, peterz@infradead.org, 
	wangliupu@loongson.cn, lvjianmin@loongson.cn, maobibo@loongson.cn, 
	siyanteng@cqsoftware.com.cn, gaosong@loongson.cn, yangtiezhu@loongson.cn, 
	loongarch@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tianyang,

On Mon, Mar 3, 2025 at 6:15=E2=80=AFPM Tianyang Zhang <zhangtianyang@loongs=
on.cn> wrote:
>
> Introduce the Redirect interrupt controllers.When the redirected interrup=
t
> controller is enabled, the routing target of MSI interrupts is no longer =
a
> specific CPU and vector number, but a specific redirected entry. The actu=
al
> CPU and vector number used are described by the redirected entry.
You call it "redirect interrupt controller", then don't call
"redirected interrupt controller" in other place.

>
> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> ---
>  .../arch/loongarch/irq-chip-model.rst         | 38 +++++++++++++++++++
>  .../zh_CN/arch/loongarch/irq-chip-model.rst   | 37 ++++++++++++++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentat=
ion/arch/loongarch/irq-chip-model.rst
> index a7ecce11e445..45cba22ff181 100644
> --- a/Documentation/arch/loongarch/irq-chip-model.rst
> +++ b/Documentation/arch/loongarch/irq-chip-model.rst
> @@ -181,6 +181,44 @@ go to PCH-PIC/PCH-LPC and gathered by EIOINTC, and t=
hen go to CPUINTC directly::
>               | Devices |
>               +---------+
>
> +Advanced Extended-Redirect IRQ model
Call it as "Advanced Extended IRQ model (with redirection)" and
"=E9=AB=98=E7=BA=A7=E6=89=A9=E5=B1=95IRQ=E6=A8=A1=E5=9E=8B (=E5=B8=A6=E9=87=
=8D=E5=AE=9A=E5=90=91)"

Huacai

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer inter=
rupt go
> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, PCH-MSI interru=
pts go
> +to REDIRECT for remapping it to AVEC, and then go to CPUINTC directly, w=
hile all
> +other devices interrupts go to PCH-PIC/PCH-LPC and gathered by EIOINTC, =
and then
> +go to CPUINTC directly::
> +
> + +-----+     +-----------------------+     +-------+
> + | IPI | --> |        CPUINTC        | <-- | Timer |
> + +-----+     +-----------------------+     +-------+
> +              ^          ^          ^
> +              |          |          |
> +       +---------+ +----------+ +---------+     +-------+
> +       | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
> +       +---------+ +----------+ +---------+     +-------+
> +            ^            ^
> +            |            |
> +            |      +----------+
> +            |      | REDIRECT |
> +            |      +----------+
> +            |            ^
> +            |            |
> +       +---------+  +---------+
> +       | PCH-PIC |  | PCH-MSI |
> +       +---------+  +---------+
> +         ^     ^           ^
> +         |     |           |
> + +---------+ +---------+ +---------+
> + | Devices | | PCH-LPC | | Devices |
> + +---------+ +---------+ +---------+
> +                  ^
> +                  |
> +             +---------+
> +             | Devices |
> +             +---------+
> +
>  ACPI-related definitions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-mod=
el.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> index d4ff80de47b6..d935da47ce3b 100644
> --- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> +++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> @@ -174,6 +174,43 @@ CPU=E4=B8=B2=E5=8F=A3=EF=BC=88UARTs=EF=BC=89=E4=B8=
=AD=E6=96=AD=E5=8F=91=E9=80=81=E5=88=B0LIOINTC=EF=BC=8CPCH-MSI=E4=B8=AD=E6=
=96=AD=E5=8F=91=E9=80=81=E5=88=B0AVECINTC=EF=BC=8C
>               | Devices |
>               +---------+
>
> +=E9=AB=98=E7=BA=A7=E6=89=A9=E5=B1=95-=E9=87=8D=E5=AE=9A=E5=90=91IRQ=E6=
=A8=A1=E5=9E=8B
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=A8=A1=E5=9E=8B=E9=87=8C=E9=9D=A2=EF=BC=8C=
IPI=EF=BC=88Inter-Processor Interrupt=EF=BC=89=E5=92=8CCPU=E6=9C=AC=E5=9C=
=B0=E6=97=B6=E9=92=9F=E4=B8=AD=E6=96=AD=E7=9B=B4=E6=8E=A5=E5=8F=91=E9=80=81=
=E5=88=B0CPUINTC=EF=BC=8C
> +CPU=E4=B8=B2=E5=8F=A3=EF=BC=88UARTs=EF=BC=89=E4=B8=AD=E6=96=AD=E5=8F=91=
=E9=80=81=E5=88=B0LIOINTC=EF=BC=8CPCH-MSI=E4=B8=AD=E6=96=AD=E9=A6=96=E5=85=
=88=E5=8F=91=E9=80=81=E5=88=B0REDIRECT=E6=A8=A1=E5=9D=97,=E5=AE=8C=E6=88=90=
=E9=87=8D=E5=AE=9A=E5=90=91=E5=90=8E=E5=8F=91
> +=E9=80=81=E5=88=B0AVECINTC=EF=BC=8C=E8=80=8C=E5=90=8E=E9=80=9A=E8=BF=87A=
VECINTC=E7=9B=B4=E6=8E=A5=E9=80=81=E8=BE=BECPUINTC=EF=BC=8C=E8=80=8C=E5=85=
=B6=E4=BB=96=E6=89=80=E6=9C=89=E8=AE=BE=E5=A4=87=E7=9A=84=E4=B8=AD=E6=96=AD=
=E5=88=99=E5=88=86=E5=88=AB=E5=8F=91=E9=80=81=E5=88=B0=E6=89=80=E8=BF=9E
> +=E6=8E=A5=E7=9A=84PCH-PIC/PCH-LPC=EF=BC=8C=E7=84=B6=E5=90=8E=E7=94=B1EIO=
INTC=E7=BB=9F=E4=B8=80=E6=94=B6=E9=9B=86=EF=BC=8C=E5=86=8D=E7=9B=B4=E6=8E=
=A5=E5=88=B0=E8=BE=BECPUINTC::
> +
> + +-----+     +-----------------------+     +-------+
> + | IPI | --> |        CPUINTC        | <-- | Timer |
> + +-----+     +-----------------------+     +-------+
> +              ^          ^          ^
> +              |          |          |
> +       +---------+ +----------+ +---------+     +-------+
> +       | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
> +       +---------+ +----------+ +---------+     +-------+
> +            ^            ^
> +            |            |
> +            |      +----------+
> +            |      | REDIRECT |
> +            |      +----------+
> +            |            ^
> +            |            |
> +       +---------+  +---------+
> +       | PCH-PIC |  | PCH-MSI |
> +       +---------+  +---------+
> +         ^     ^           ^
> +         |     |           |
> + +---------+ +---------+ +---------+
> + | Devices | | PCH-LPC | | Devices |
> + +---------+ +---------+ +---------+
> +                  ^
> +                  |
> +             +---------+
> +             | Devices |
> +             +---------+
> +
>  ACPI=E7=9B=B8=E5=85=B3=E7=9A=84=E5=AE=9A=E4=B9=89
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> 2.43.0
>
>

