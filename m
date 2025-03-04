Return-Path: <linux-kernel+bounces-545096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120CAA4EAF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F3C3B2CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6998E259C86;
	Tue,  4 Mar 2025 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPziMNPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA585255231;
	Tue,  4 Mar 2025 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107806; cv=none; b=hpOu9W7zIJoHhxUrdju/aT1KacPUCoVLR1YIKGoe6oCTmhcAgT5rX8heeDXuU5b8GhjpOZC7Z/dubvtFtWYMPf8h/7lz6P9hKoUzPH2Skz/0Uztb4UiyjmSusWyjXW7pUPNaELpU+1R0+88tmC8FxebB3YGnTrmdcZ3/YG3hocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107806; c=relaxed/simple;
	bh=TKQ7m1KW0EDUZSOKBSYQtrQAfX8pph1vCn+eyQcex7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4/vqeI7saZ/Dndbicdv/4E/ZPeEJ2pkqLP9pG9mmmZi1ae2PF9lAyC0mpNcRMhRCgTDX3KeCbnhEUzdki92jmaWJ2LCo4a7zptP2saXvlMsIDy6yxuxwQXYfa+Ja8032/VVmLjZntgpWsieuUdriYxsY6wBnH8g6qmYZquFwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPziMNPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94039C4CEE8;
	Tue,  4 Mar 2025 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741107806;
	bh=TKQ7m1KW0EDUZSOKBSYQtrQAfX8pph1vCn+eyQcex7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qPziMNPPTpV7AZGdUSJ2pYZHvFof/rb0iJAdl6k+BJQLENzl9F/vV7Df+y7sKupaA
	 a1zn3SDLQlTwb6tDEv2Ba4iq/jBLIkd3vheLWpE4K02jvvC4wt0MlF6PYyMe9ROVn1
	 x9z4RcJuQRLw7GvPpsiqtCq61JrxalqOx6TtjqXV9zoORnT7JiF/HHCGNaZVcGOlBh
	 /xy671WTBi974k8LS2Fdha1r42iqIcI58w5KS/S4bdLcP0mXU+P3P5G2SdI4JWBoKj
	 e9DDkNQX8asdnyKuZTcAmKPblEs0ipfwxhH2B09QZ/pFaTuaoapSRIgAl7+ZXwGjcx
	 ZpgP+490ep10g==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e53b3fa7daso4343474a12.2;
        Tue, 04 Mar 2025 09:03:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXgYhFF5LGlUwOp9WDs+5JLWN28ieOy3FPZRUlFFrqcCk3z3HjvamAgIfFT9ATj1I/VrA2DZn1OIoA@vger.kernel.org, AJvYcCXB7UMjFeDHtGtqRBzTiW0nsEfO/UuQn2NzIaJHqX8Ubn9TVlPpHV6/UgusM0av/DqBHGQ2L1uYS6ctfaZt@vger.kernel.org
X-Gm-Message-State: AOJu0YxsYo1yWmtWduq+NpBVgU8iV0OX2Fjgq4cz4s6U9GUE0aa5kIHa
	jxh8Vg+UwuZDKr8iAAa/1j55Y9xAoSXv3r1gwSKgGd4ZVKENa97qFjM9FwyDqvn938E8snvlgKa
	n4LnBi1jcqTdIYCi2gL7J0PmpjA==
X-Google-Smtp-Source: AGHT+IGsfY6fqe2YQl8Oj3jQOJXYsrLKdp1WEPofGDKrpvMKW/z4zof5UMwhD4wjXSR+/W1s+f5P1D2nlfXqLF0F4Ms=
X-Received: by 2002:a17:907:d1a:b0:abf:d4a9:a0a5 with SMTP id
 a640c23a62f3a-abfd4a9b8fbmr946630666b.45.1741107804893; Tue, 04 Mar 2025
 09:03:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226124245.9856-1-s-vadapalli@ti.com> <20250226124245.9856-2-s-vadapalli@ti.com>
In-Reply-To: <20250226124245.9856-2-s-vadapalli@ti.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Mar 2025 11:03:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKDMecB3dD2oU2MJo-_8G66K-mVTfNKWUBuL-=_tWpjtw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo_MMcNezVZGplk__qmIGqhWMGwQvZlfARIVI6FBgde0NxdeBDApYXXBNM
Message-ID: <CAL_JsqKDMecB3dD2oU2MJo-_8G66K-mVTfNKWUBuL-=_tWpjtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: ti: k3-j721e-evm: Add overlay for PCIe
 NTB functionality
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 6:43=E2=80=AFAM Siddharth Vadapalli <s-vadapalli@ti=
.com> wrote:
>
> PCIe NTB (Non-Transparent-Bridge) allows connecting the memory of
> multiple PCIe Hosts (Root-Complex). The number of such hosts is
> determined by the number of PCIe instances configured for NTB operation
> on the device which intends to enable NTB functionality. Add a device-tre=
e
> overlay to configure PCIE0 and PCIE1 instances of PCIe on J721E EVM for N=
TB
> operation. This shall allow connecting the memory of two PCIe Hosts via
> PCIE0 and PCIE1 on J721E EVM.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>
> v1:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/2025020209363=
6.2699064-2-s-vadapalli@ti.com/
> Changes since v1:
> - s/epf_bus/epf-bus since node names shouldn't contain underscores.
>
> Regards,
> Siddharth.
>
>  arch/arm64/boot/dts/ti/Makefile               |  4 +
>  .../boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso    | 91 +++++++++++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso
>
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Mak=
efile
> index 8a4bdf87e2d4..1097ab30f5a9 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -102,6 +102,7 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-beagleboneai64.dt=
b
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-common-proc-board-infotainment.dtbo
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-evm-gesi-exp-board.dtbo
> +dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-evm-pcie-ntb.dtbo
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-evm-pcie0-ep.dtbo
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-evm-pcie1-ep.dtbo
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-sk.dtb
> @@ -201,6 +202,8 @@ k3-j7200-evm-pcie1-ep-dtbs :=3D k3-j7200-common-proc-=
board.dtb \
>         k3-j7200-evm-pcie1-ep.dtbo
>  k3-j721e-common-proc-board-infotainment-dtbs :=3D k3-j721e-common-proc-b=
oard.dtb \
>         k3-j721e-common-proc-board-infotainment.dtbo
> +k3-j721e-evm-pcie-ntb-dtbs :=3D k3-j721e-common-proc-board.dtb \
> +       k3-j721e-evm-pcie-ntb.dtbo
>  k3-j721e-evm-pcie0-ep-dtbs :=3D k3-j721e-common-proc-board.dtb \
>         k3-j721e-evm-pcie0-ep.dtbo
>  k3-j721e-evm-pcie1-ep-dtbs :=3D k3-j721e-common-proc-board.dtb \
> @@ -239,6 +242,7 @@ dtb- +=3D k3-am625-beagleplay-csi2-ov5640.dtb \
>         k3-am69-sk-pcie0-ep.dtb \
>         k3-j7200-evm-pcie1-ep.dtb \
>         k3-j721e-common-proc-board-infotainment.dtb \
> +       k3-j721e-evm-pcie-ntb.dtb \
>         k3-j721e-evm-pcie0-ep.dtb \
>         k3-j721e-evm-pcie1-ep.dtb \
>         k3-j721e-sk-csi2-dual-imx219.dtb \
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso b/arch/arm=
64/boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso
> new file mode 100644
> index 000000000000..9b6b3e153e91
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/**
> + * DT Overlay for enabling NTB functionality using PCIE0 and PCIE1 insta=
nces of
> + * PCIe on the J7 common processor board.
> + *
> + * J7 Common Processor Board Product Link: https://www.ti.com/tool/J721E=
XCPXEVM
> + *
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.co=
m/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +       epf-bus {
> +               compatible =3D "pci-epf-bus";

There is no such binding upstream nor one pending. This needs to be dropped=
.

Rob

