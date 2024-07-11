Return-Path: <linux-kernel+bounces-249357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EF592EA89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBCCB21B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705F167265;
	Thu, 11 Jul 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJcwOYmo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826815AD99;
	Thu, 11 Jul 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707614; cv=none; b=PBWuUAT+1jqGWLnJ2Pzf5xii/0ES+lH/t9JWH4PW8TzX91BC4wuoBI1RuEwUyvPE7NH+8GJV6sMcrP+OQerNIY6nmmXBn26tyZ/oDFOggm7NZeUciLh9Rajyt8Z5OOgimqw6RHMwbVPSKXSsSnT+p0BiVpptfV0rvCeaZF0mCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707614; c=relaxed/simple;
	bh=/VstGtV+katcjRzUb0Jru+O6vxW9u7IvFm83js3uw3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj6g0INOtk48gS0MPEK5mFjpkTRE2pdKelykVTJwRwhCFYgByjOvV6zBdYOohsQ6RFwLKIpiRgpcI3Y2jTZbQvzA+lRB+YkMwGFSXubfHrK74Xzdfh9jr7BlZ/0wQttMHOGeMFNXMDab532Ib2kmqo4mp6NRpD2Qq0KeeC9sW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJcwOYmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393CEC4AF07;
	Thu, 11 Jul 2024 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720707614;
	bh=/VstGtV+katcjRzUb0Jru+O6vxW9u7IvFm83js3uw3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vJcwOYmoolGfg+xrhiOj/Bwvsa4Rw4RlmbK66NDCTgsDnaqS4259wWDNRltsFvJJU
	 brxQtfc9Q513Xm43hZy/QRv6Zk1q7apIu4xko3U+V7uPbVjj3OKXAnSq47ZN4SVue2
	 XfhQWtTVALMCig3tt3IbTCbvmMUx78JPeeU2xUMfB/vtb+dckrHbtzjYh2sVbb7nkK
	 /UBss9AYOvMzCjwsje1syhYUrgNEiH3awy8ZlC53Np63wHpTNBIL5ssI14bIi/j7oY
	 WFaL0VLCoPp7OWdINwjaea1L+DshjHxZECJ210qRQTEv1vXS+2poLgoUJpBmsGte6K
	 0tWqrNS7MsOhQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1051360so7886391fa.0;
        Thu, 11 Jul 2024 07:20:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsftutfRPQ70BBhK+s875bITOXA/1C6hCpJTO1bLtCrRep1yC1GeTxUji0gNkOv1Bz3lJun86LEpRPE2X3x6mCFDE9+ZFG0fD7UauRWtdL2W0kEwdvdj0rTYXNAxnOzE9fsCo48ZgI+g==
X-Gm-Message-State: AOJu0Yyw9nD5PiUap6rco4565LLZNnK+iAPjwRYkc8PoAdTh2O59lRhQ
	HNSs3DxaycD7t05hpjuNajBXxY46GpaJ3Jw2QW8LkYHIJ6wQJLiPOWhBRZfO2CsfuHTUqEkc4rU
	fVS8d0GuNWmxuinneDZAsKUJO7Q==
X-Google-Smtp-Source: AGHT+IE0CAYjyGnb5JatMHqj5ndbAwxzfnxdyxt2dr39gp4FD8KncQturA2vW4998XBh3dHYzOnJmewDL3lOw+gAh4U=
X-Received: by 2002:a05:6512:54c:b0:524:43b2:d326 with SMTP id
 2adb3069b0e04-52eb99a273amr5209274e87.37.1720707612501; Thu, 11 Jul 2024
 07:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-b4-upstream-j742s2-v1-1-8b9e41c18f91@ti.com>
In-Reply-To: <20240711-b4-upstream-j742s2-v1-1-8b9e41c18f91@ti.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Jul 2024 08:19:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJABHM9StutsYPjArjhnQ5vVyYK-ASd62iO6+jNBZVqig@mail.gmail.com>
Message-ID: <CAL_JsqJABHM9StutsYPjArjhnQ5vVyYK-ASd62iO6+jNBZVqig@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: Introduce J742S2 SoC and EVM
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Udit Kumar <u-kumar1@ti.com>, 
	Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:26=E2=80=AFPM Manorit Chawdhry <m-chawdhry@ti.co=
m> wrote:
>
> This series add the Linux support for our new family of device J742S2.
> This device is a subset of J784S4 and shares the same memory map and
> thus the nodes are being reused from J784S4 to avoid duplication.
>
> Here are some of the salient features of the J742S2 automotive grade
> application processor:
>
> The J742S2 SoC belongs to the K3 Multicore SoC architecture platform,
> providing advanced system integration in automotive, ADAS and industrial
> applications requiring AI at the network edge. This SoC extends the K3
> Jacinto 7 family of SoCs with focus on raising performance and
> integration while providing interfaces, memory architecture and compute
> performance for multi-sensor, high concurrency applications.
>
> Some highlights of this SoC are:
> * Up to Four Arm=C2=AE Cortex=C2=AE-A72 microprocessor subsystem at up to=
 2.0GHz,
>   3 C7x floating point vector DSPs with Up to Two Deep-learning matrix
>   multiply accelerator (MMAv2),
> * 3D GPU: Automotive grade IMG BXS-4-64 MC1
> * Vision Processing Accelerator (VPAC) with image signal processor and
>   Depth and Motion Processing Accelerator (DMPAC)
> * Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and
>   one DPI interface.
> * Integrated gigabit ethernet switch, up to 4 ports ,two ports
>   support 10Gb USXGMII; One 4 lane PCIe-GEN3 controllers, USB3.0
>   Dual-role device subsystems, Up to 20 MCANs, among other peripherals.
>
> ( Refer Table 2-1 for Device comparison with J7AHP )
>
> Link: https://www.ti.com/lit/pdf/spruje3 (TRM)
> Link: https://www.ti.com/lit/ug/sprujd8/sprujd8.pdf (EVM user guide)
> Link: https://www.ti.com/lit/zip/SPAC001 (Schematics)
> ---
> The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
> Support and re-uses most of the stuff from the superset device J784s4.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile            |  3 ++
>  arch/arm64/boot/dts/ti/k3-j742s2-evm.dts   | 22 ++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi | 47 ++++++++++++++++++++++++=
++++++
>  arch/arm64/boot/dts/ti/k3-j742s2.dtsi      | 18 ++++++++++++
>  4 files changed, 90 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Mak=
efile
> index e20b27ddf901..4d0688c5cff7 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -119,6 +119,9 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-j784s4-evm-pcie0-pcie1-=
ep.dtbo
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j784s4-evm-quad-port-eth-exp1.dtbo
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
>
> +# Boards with J742S2 SoC
> +dtb-$(CONFIG_ARCH_K3) +=3D k3-j742s2-evm.dtb
> +
>  # Build time test only, enabled by CONFIG_OF_ALL_DTBS
>  k3-am625-beagleplay-csi2-ov5640-dtbs :=3D k3-am625-beagleplay.dtb \
>         k3-am625-beagleplay-csi2-ov5640.dtbo
> diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts b/arch/arm64/boot/d=
ts/ti/k3-j742s2-evm.dts
> new file mode 100644
> index 000000000000..98088ccfd76d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.co=
m/
> + *
> + * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001
> + */
> +
> +#include "k3-j784s4-evm.dts"
> +#include "k3-j742s2.dtsi"

The structure of this is weird and fragile. You delete nodes in
k3-j742s2.dtsi which are defined indirectly (I assume) by
k3-j784s4-evm.dts. When there's a 2nd board for this SoC, you are
going to have to duplicate everything here. k3-j742s2.dtsi should
include k3-j742s4.dtsi. And then you may need a common EVM board .dtsi
to share.

Rob

