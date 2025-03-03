Return-Path: <linux-kernel+bounces-545307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F3A4EB80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7749B17AE4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E822836BE;
	Tue,  4 Mar 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+qQv2BB"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666F2836A6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111867; cv=pass; b=jgY7eXLIA6+5cJhKAHlLXxW1jw0oU6FjdWdayhxedZj7H1EfreP/YwheZKE1yQZrZ34qds7uW+uLk2xVK2tpGaVpjyJuylOEpJI+RVMNe2TtazZXXcSnstFiO18qdeaClgix6qL4PoKorBQUhTZATMqT0URTc6akmHmy4xnu95k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111867; c=relaxed/simple;
	bh=FCDWHLpqYyGBcKEf9TBXuM8o1C7cMkdG3rKrO2RywlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9pZ4LC3RdNngAEI12eX2mxNKYwKnMUIC9/TxtJURN1IeKTOTQ6cMMN3ygF2WaFz7Vtt4KUpEEj/PWZGoCtmpwRkVCsnnwg7lzgi1lAlHQGXJ1xiyWqGdFvLUJOAg2vCg1/7Fs3bZpA/+z3naGfR8tZr06saJU6kKhShreRz1Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+qQv2BB; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id E9ABF408951F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:11:03 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l+qQv2BB
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fqP54N2zG0Rc
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:34:09 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 29AC242728; Tue,  4 Mar 2025 18:34:08 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+qQv2BB
X-Envelope-From: <linux-kernel+bounces-541830-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+qQv2BB
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 7DC1541FDA
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:37:24 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 328012DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:37:24 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3B5163013
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB91212B14;
	Mon,  3 Mar 2025 13:37:07 +0000 (UTC)
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
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fqP54N2zG0Rc
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716565.74856@fZYJ8Ba8lu5eb7wkh4ZxaQ
X-ITU-MailScanner-SpamCheck: not spam

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


