Return-Path: <linux-kernel+bounces-551059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40EA567A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3BE189559D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A4218E9B;
	Fri,  7 Mar 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAx0mt9E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D94154423;
	Fri,  7 Mar 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349747; cv=none; b=QsZJrRwfTzs5C6mitJaELJi8haTEdQt9qebjJO1lF1UOda53PmcY+EqKwoPEmhGu75DOnGUgiBpyGnMjYHd2ECaB8UwGZ3RyfeOmpWbKZxAwW3pDdGoUpEOSXpsfJeEqIvXFPpZzblyKd/T4b8HQJJx/Kd/jwcwTHqh8ZnyKWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349747; c=relaxed/simple;
	bh=NUTcwqh7MCASvD4w+bVQSfE4QAqRs9qXkw2IdgX9WCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8x9u1Camdco44KBLvzt0xYauHEhr7s2dM+EpijZ1m0pJfQZMczZAnGJjm56/S7QqRYJafqOSXrGfkKhuicjvZgLly95k9MKqMaxxwO3i4AgRwlszAKHWsXIXm0rSPbDOCAm9d1vfQQLQvVe6DD9BfTJO6ba0PefCZGvqPtwPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAx0mt9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29EEC4CEE7;
	Fri,  7 Mar 2025 12:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741349745;
	bh=NUTcwqh7MCASvD4w+bVQSfE4QAqRs9qXkw2IdgX9WCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QAx0mt9ExXV5hggC/+MxyKsU0jZkRktXz8OxehcXJcyZh1o9vlwub2+ig0vt8jec8
	 6rX7tSL86uv0pL/9c0VGRLHTGQCZfVYmZiDh0X2BlXgelBaTEbZ3hSxrx1IcvwFnMK
	 1nSe1gYdRrv9XNyYQbVSqGQoatlGFpMe5EZc8RhKKX+60N5XNcTJjw2Fr8yBcMDJZp
	 EGOQ5whrZM/v+0HjQuttTXVzlYlmExawYdtRZdVnKK5ca86eWkFjSWp/+CLcvU+K09
	 77IW07Nz8NRLKfrsgJpeEIIMvoemRxShTvz3HFKdb1/vsq72NfxIYqbVo6hH+KIuT2
	 5tmnZYgwZ3XQg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e4f88ea298so3121356a12.2;
        Fri, 07 Mar 2025 04:15:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/87uVx9drFAQanRM/k/DrR/25mK1PUhiMcUGgS7ACt7EempumLUmeBiglKuH0tRvkBH7kp50NLvxr@vger.kernel.org, AJvYcCUyQ/ykTE/HULmjiofxCH2jss+mnlKXTVrVw003xhPWfsjCpPZD7KMOsQ2yAUibOgpg61lXuDGKYM0AHLbz@vger.kernel.org
X-Gm-Message-State: AOJu0YyP3NgplXBwmPMCXUPbQJKjOAFHSeM1zyCxbZI5jL7Myd31l9Ij
	SPk3vuaPdIc5UbiXvBdR2HDktgZP1VpuujpaoGRfsrkah3QeUuLvYo2OBl+TlP/hO0xWAcl6UTO
	PSM2HlT/IMEqqpbcasNkE0SsXvw==
X-Google-Smtp-Source: AGHT+IGVdHSFZn3+WiSlThdpTVs0r4OoYpx/U2Lbt6NNoKziKPQIgxGTCb1pgFt4bob2aUbhXriG1Al/+sIfqRUQvOM=
X-Received: by 2002:a17:907:2d92:b0:ac1:fab4:a83 with SMTP id
 a640c23a62f3a-ac252b5a837mr346883966b.25.1741349744102; Fri, 07 Mar 2025
 04:15:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218185452.600797-1-vaishnav.a@ti.com> <20250218185452.600797-6-vaishnav.a@ti.com>
In-Reply-To: <20250218185452.600797-6-vaishnav.a@ti.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 7 Mar 2025 06:15:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLxHKdQujWdSkGe6_cUftdgNgJ2PyVZR41A_LJ241_D3g@mail.gmail.com>
X-Gm-Features: AQ5f1JomHAua_qKY6p65rhjGZzmCsboNe30YpEDs67TH3wT0hxy-QRQycqLiaFA
Message-ID: <CAL_JsqLxHKdQujWdSkGe6_cUftdgNgJ2PyVZR41A_LJ241_D3g@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: ti: k3-j722s-evm: Add overlay for TEVI OV5640
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	jai.luthra@linux.dev, y-abhilashchandra@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 12:55=E2=80=AFPM Vaishnav Achath <vaishnav.a@ti.com=
> wrote:
>
> TechNexion TEVI OV5640 camera is a 5MP camera that can be used with
> J722S EVM through the 22-pin CSI-RX connector. Add a reference overlay
> for quad TEVI OV5640 modules on J722S EVM.
>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   4 +
>  .../k3-j722s-evm-csi2-quad-tevi-ov5640.dtso   | 319 ++++++++++++++++++
>  2 files changed, 323 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-tevi-ov=
5640.dtso
>
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Mak=
efile
> index 9ae0917e5763..0370392abda8 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -120,6 +120,7 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-j721s2-evm-pcie1-ep.dtb=
o
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am67a-beagley-ai.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j722s-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
> +dtb-$(CONFIG_ARCH_K3) +=3D k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
>
>  # Boards with J784s4 SoC
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am69-sk.dtb
> @@ -212,6 +213,8 @@ k3-j721s2-evm-pcie1-ep-dtbs :=3D k3-j721s2-common-pro=
c-board.dtb \
>         k3-j721s2-evm-pcie1-ep.dtbo
>  k3-j722s-evm-csi2-quad-rpi-cam-imx219-dtbs :=3D k3-j722s-evm.dtb \
>         k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
> +k3-j722s-evm-csi2-quad-tevi-ov5640-dtbs :=3D k3-j722s-evm.dtb \
> +       k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
>  k3-j784s4-evm-pcie0-pcie1-ep-dtbs :=3D k3-j784s4-evm.dtb \
>         k3-j784s4-evm-pcie0-pcie1-ep.dtbo
>  k3-j784s4-evm-quad-port-eth-exp1-dtbs :=3D k3-j784s4-evm.dtb \
> @@ -247,6 +250,7 @@ dtb- +=3D k3-am625-beagleplay-csi2-ov5640.dtb \
>         k3-j721e-sk-csi2-dual-imx219.dtb \
>         k3-j721s2-evm-pcie1-ep.dtb \
>         k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtb \
> +       k3-j722s-evm-csi2-quad-tevi-ov5640.dtb \
>         k3-j784s4-evm-pcie0-pcie1-ep.dtb \
>         k3-j784s4-evm-quad-port-eth-exp1.dtb \
>         k3-j784s4-evm-usxgmii-exp1-exp2.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-tevi-ov5640.dt=
so b/arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-tevi-ov5640.dtso
> new file mode 100644
> index 000000000000..f33f50465a07
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-tevi-ov5640.dtso
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * 4 x TEVI OV5640 MIPI Camera module on RPI camera connector.
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.co=
m/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +       clk_ov5640_fixed: ov5640-xclk {

clock-24000000 for the node name.

> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <24000000>;
> +       };
> +};
> +
> +
> +&main_pmx0 {
> +       cam0_reset_pins_default: cam0-reset-pins-default {

Doesn't match the schema. Please test your changes:

pinctrl@f4000: 'cam0-reset-pins-default', 'cam1-reset-pins-default',
'cam2-reset-pins-default', 'cam3-reset-pins-default' do not match any
of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'

> +               pinctrl-single,pins =3D <
> +                       J722S_IOPAD(0x03c, PIN_OUTPUT, 7)
> +               >;
> +       };
> +
> +       cam1_reset_pins_default: cam1-reset-pins-default {
> +               pinctrl-single,pins =3D <
> +                       J722S_IOPAD(0x044, PIN_OUTPUT, 7)
> +               >;
> +       };
> +
> +       cam2_reset_pins_default: cam2-reset-pins-default {
> +               pinctrl-single,pins =3D <
> +                       J722S_IOPAD(0x04c, PIN_OUTPUT, 7)
> +               >;
> +       };
> +
> +       cam3_reset_pins_default: cam3-reset-pins-default {
> +               pinctrl-single,pins =3D <
> +                       J722S_IOPAD(0x054, PIN_OUTPUT, 7)
> +               >;
> +       };
> +};
> +
> +&exp1 {
> +       p06-hog{
> +               /* P06 - CSI01_MUX_SEL_2 */
> +               gpio-hog;
> +               gpios =3D <6 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name =3D "CSI01_MUX_SEL_2";
> +       };
> +
> +       p07-hog{
> +               /* P01 - CSI23_MUX_SEL_2 */
> +               gpio-hog;
> +               gpios =3D <7 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name =3D "CSI23_MUX_SEL_2";
> +       };
> +};
> +
> +&main_gpio0 {
> +       p15-hog {
> +               /* P15 - CSI2_CAMERA_GPIO1 */
> +               gpio-hog;
> +               gpios =3D <15 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name =3D "CSI2_CAMERA_GPIO1";
> +       };
> +
> +       p17-hog {
> +               /* P17 - CSI2_CAMERA_GPIO2 */
> +               gpio-hog;
> +               gpios =3D <17 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name =3D "CSI2_CAMERA_GPIO2";
> +       };
> +
> +       p19-hog {
> +               /* P19 - CSI2_CAMERA_GPIO3 */
> +               gpio-hog;
> +               gpios =3D <19 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name =3D "CSI2_CAMERA_GPIO3";
> +       };
> +
> +       p21-hog {
> +               /* P21 - CSI2_CAMERA_GPIO4 */
> +               gpio-hog;
> +               gpios =3D <21 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name =3D "CSI2_CAMERA_GPIO4";
> +       };
> +};
> +
> +&pca9543_0 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +
> +       i2c-alias-pool =3D /bits/ 16 <0x3c 0x3d>;
> +
> +       i2c@0 {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               reg =3D <0>;
> +
> +               ov5640_0: camera@3c {
> +                       compatible =3D "ovti,ov5640";
> +                       reg =3D <0x3c>;
> +                       clocks =3D <&clk_ov5640_fixed>;
> +                       clock-names =3D "xclk";
> +
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&cam0_reset_pins_default>;
> +
> +                       port {
> +                               csi2_cam0: endpoint {
> +                                       remote-endpoint =3D <&csi2rx0_in_=
sensor>;
> +                                       clock-lanes =3D <0>;
> +                                       data-lanes =3D <1 2>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       i2c@1 {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               reg =3D <1>;
> +
> +               ov5640_1: camera@3c {
> +                       compatible =3D "ovti,ov5640";
> +                       reg =3D <0x3c>;
> +                       clocks =3D <&clk_ov5640_fixed>;
> +                       clock-names =3D "xclk";
> +
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&cam1_reset_pins_default>;
> +
> +                       port {
> +                               csi2_cam1: endpoint {
> +                                       remote-endpoint =3D <&csi2rx1_in_=
sensor>;
> +                                       clock-lanes =3D <0>;
> +                                       data-lanes =3D <1 2>;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&pca9543_1 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +
> +       i2c-alias-pool =3D /bits/ 16 <0x3c 0x3d>;
> +
> +       i2c@0 {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               reg =3D <0>;
> +
> +               ov5640_2: camera@3c {
> +                       compatible =3D "ovti,ov5640";
> +                       reg =3D <0x3c>;
> +                       clocks =3D <&clk_ov5640_fixed>;
> +                       clock-names =3D "xclk";
> +
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&cam2_reset_pins_default>;
> +
> +                       port {
> +                               csi2_cam2: endpoint {
> +                                       remote-endpoint =3D <&csi2rx2_in_=
sensor>;
> +                                       clock-lanes =3D <0>;
> +                                       data-lanes =3D <1 2>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       i2c@1 {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               reg =3D <1>;
> +
> +               ov5640_3: camera@3c {
> +                       compatible =3D "ovti,ov5640";
> +                       reg =3D <0x3c>;
> +                       clocks =3D <&clk_ov5640_fixed>;
> +                       clock-names =3D "xclk";
> +
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&cam3_reset_pins_default>;
> +
> +                       port {
> +                               csi2_cam3: endpoint {
> +                                       remote-endpoint =3D <&csi2rx3_in_=
sensor>;
> +                                       clock-lanes =3D <0>;
> +                                       data-lanes =3D <1 2>;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&cdns_csi2rx0 {
> +       ports {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               csi0_port0: port@0 {
> +                       reg =3D <0>;
> +                       status =3D "okay";
> +
> +                       csi2rx0_in_sensor: endpoint {
> +                               remote-endpoint =3D <&csi2_cam0>;
> +                               bus-type =3D <4>; /* CSI2 DPHY */
> +                               clock-lanes =3D <0>;
> +                               data-lanes =3D <1 2>;
> +                       };
> +               };
> +       };
> +};
> +
> +&cdns_csi2rx1 {
> +       ports {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               csi1_port0: port@0 {
> +                       reg =3D <0>;
> +                       status =3D "okay";
> +
> +                       csi2rx1_in_sensor: endpoint {
> +                               remote-endpoint =3D <&csi2_cam1>;
> +                               bus-type =3D <4>; /* CSI2 DPHY */
> +                               clock-lanes =3D <0>;
> +                               data-lanes =3D <1 2>;
> +                       };
> +               };
> +       };
> +};
> +
> +&cdns_csi2rx2 {
> +       ports {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               csi2_port0: port@0 {
> +                       reg =3D <0>;
> +                       status =3D "okay";
> +
> +                       csi2rx2_in_sensor: endpoint {
> +                               remote-endpoint =3D <&csi2_cam2>;
> +                               bus-type =3D <4>; /* CSI2 DPHY */
> +                               clock-lanes =3D <0>;
> +                               data-lanes =3D <1 2>;
> +                       };
> +               };
> +       };
> +};
> +
> +&cdns_csi2rx3 {
> +       ports {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               csi3_port0: port@0 {
> +                       reg =3D <0>;
> +                       status =3D "okay";
> +
> +                       csi2rx3_in_sensor: endpoint {
> +                               remote-endpoint =3D <&csi2_cam3>;
> +                               bus-type =3D <4>; /* CSI2 DPHY */
> +                               clock-lanes =3D <0>;
> +                               data-lanes =3D <1 2>;
> +                       };
> +               };
> +       };
> +};
> +
> +&ti_csi2rx0 {
> +       status =3D "okay";
> +};
> +
> +&dphy0 {
> +       status =3D "okay";
> +};
> +
> +&ti_csi2rx1 {
> +       status =3D "okay";
> +};
> +
> +&dphy1 {
> +       status =3D "okay";
> +};
> +
> +
> +&ti_csi2rx2 {
> +       status =3D "okay";
> +};
> +
> +&dphy2 {
> +       status =3D "okay";
> +};
> +
> +
> +&ti_csi2rx3 {
> +       status =3D "okay";
> +};
> +
> +&dphy3 {
> +       status =3D "okay";
> +};
> --
> 2.34.1
>

