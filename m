Return-Path: <linux-kernel+bounces-286723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA587951E40
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC472B276D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB221B3F31;
	Wed, 14 Aug 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK+MkyoB"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0341B3F0F;
	Wed, 14 Aug 2024 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648303; cv=none; b=BPavFdM76pKeB98/YFgfQJxyG9zAJ+SZP5nhO8aqktRxKtaaesc6gJnreyx6g6sVxOUXxKloDUUuetVrnozCT3x+0YasRwWeNGtGVyhxPspxY1Nbe7YybxO1N/6VXrAPXSwrEqNDIFXIawXDV9VkA0Ssr0MxsGzlosnFwTCtCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648303; c=relaxed/simple;
	bh=UTi5yJk+be5vzw2V+1L9ihJompsgnOrfhodGHxSWBuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zzw85p1xLY2GVlFxX1oudJ9hKBkl2oVwhKr0V88dGIBIx/1ENDL5PFhdnNW5xB8XS42h1rOmqyW2B9RdL9KS7pAye7e98BUM1eqjJLA08TzvW028S1cX9QfiR++QOqN9mzs9MUrk+nRUEbD0Z+klZtkQE0ErVBtkTC5Jlj99hDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK+MkyoB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ef9714673so142161e87.0;
        Wed, 14 Aug 2024 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723648300; x=1724253100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a508zITcdXXJHqgdSiMoAzBDjp50etBJSbsbDMrAgKs=;
        b=YK+MkyoBS75/GvqNxaMvl9Kmj5l8iGvKp3ZkvH0MrB3i/mEldmDirk/Ypzod8SxphR
         h5yd9qJa1JmwlN5bwsEK2febEZ1ioQxCRuvj9G2WAbt7Nk1FXOlXAnvgYXUYDv00bT60
         uBFG/0ah7CaXR8pqMDVmue+oW3rALo+6zehlnriFMwGn5NCRuzVP2eZjlYthrCdFJFM9
         xFZUYDef5We5oZhq8grp51xBHKmUTgTkREqAqCKJWpZywpWT5q81YK49gZRRcGV0BmBL
         i/TtHnUmL1c7iphjczG6mv4sFgh1R9Jhd8sMozFj/09//qTGMn5V9pS0pYK24nb46Lrx
         NiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648300; x=1724253100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a508zITcdXXJHqgdSiMoAzBDjp50etBJSbsbDMrAgKs=;
        b=NJzQDfzQYVjKUTl/q0UmJ/Ofd74T2rJAL/q0kWe79ejR04wxAfjfuQwL1fA4xFwe6w
         jaAiQvbYybAnK/qmTVRYW4BEEG3GW5aOqh4RibVeCxaNamBTIF8JhVFHVdiBwZy9NbIS
         mMytwgDSyF8+gFYrSSDgAWLJ/+4PPNFlP7mHHtZVIGbQsHKfbCOxs/B4va99ZztbkTek
         RiegZfh0e+owHZYHklJ0uyj2H9INPWJ/75tyS+3o9sXuDk+60UnLjmS5RNlFF/YX4jX9
         yvEbExtOwQaRLv1U6cqlgnAgiOAQHzApFHjym/ikAN2paKi7RmOmtuYMgjUs552fqyiG
         rwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9RBTtUOB9wO0/89U7NzLrsHubv8wmDYvmMPp9nnapYK6d2IwzG4uWabcm/1qWz9l/R8x89iWkpn8sNKLeZx1B8sxte3hMCIhO5Zadupd0EzxhOxvuY/9owHvrWbWItQGe9rSfHaXm1g==
X-Gm-Message-State: AOJu0YybSGN2dBDLv9LTA72W5qkTUwI715oC1ygEQeMjwLumLM/7V0KF
	K6SDhdXwpiWPQknM4L3FMTyJ7I3pXhBzJ4K98cMg4HpZlyu/5M4Eg83FRtA8IcCWbQi1sZexuJP
	sje9qVWQTSXXW0NRAA7RAZwBXGpY=
X-Google-Smtp-Source: AGHT+IEkalpy4J/4ThucGar4tRofe8svzxrirl0NvGmTXrh3aGYHuMuoOW484XvutIwQ2/wKa0zyvSudWUdA3tEKOSY=
X-Received: by 2002:a05:6512:1111:b0:530:baaa:edf1 with SMTP id
 2adb3069b0e04-532eda5b30cmr1282647e87.2.1723648299492; Wed, 14 Aug 2024
 08:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814144957.93183-1-tarang.raval@siliconsignals.io>
In-Reply-To: <20240814144957.93183-1-tarang.raval@siliconsignals.io>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 14 Aug 2024 12:11:28 -0300
Message-ID: <CAOMZO5CQNHHCUF+i3d710haMUyESeesp4nEs2_E74f1tmzuMZA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: shawnguo@kernel.org, krzk+dt@kernel.org, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tarang,

On Wed, Aug 14, 2024 at 11:51=E2=80=AFAM Tarang Raval
<tarang.raval@siliconsignals.io> wrote:
>
> This adds the following peripherals support for the Emtop i.MX8M Mini Bas=
eboard
>         * Wi-Fi
>         * Audio
>         * SD card
>         * RTC
>         * CAN bus
>         * USB OTG
>
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
> ---
>  .../dts/freescale/imx8mm-emtop-baseboard.dts  | 347 ++++++++++++++++++
>  .../boot/dts/freescale/imx8mm-emtop-som.dtsi  |   1 +
>  2 files changed, 348 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/a=
rch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> index 7d2cb74c64ee..5ce8f21a0b1b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> @@ -11,6 +11,129 @@ / {
>         model =3D "Emtop Embedded Solutions i.MX8M Mini Baseboard V1";
>         compatible =3D "ees,imx8mm-emtop-baseboard", "ees,imx8mm-emtop-so=
m",
>                 "fsl,imx8mm";
> +
> +       extcon_usb: extcon_usb1otg {

extcon_usb: extcon-usb1otg {

> +               compatible =3D "linux,extcon-usb-gpio";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_extcon_usb>;
> +               id-gpio =3D <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +               enable-gpio =3D <&gpio1 12 GPIO_ACTIVE_LOW>;
> +       };
> +
> +       modem_reset: modem-reset {
> +               compatible =3D "gpio-reset";

This is not a valid compatible string.

> +       regulators {
> +               compatible =3D "simple-bus";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;

Please remove this 'regulators' container and describe the regulators direc=
tly.

> +               reg_audio: regulator-audio-vdd {

reg_audio: regulator-audio {

> +                       compatible =3D "regulator-fixed";
> +                       regulator-name =3D "wm8904_supply";
> +                       regulator-min-microvolt =3D <1800000>;
> +                       regulator-max-microvolt =3D <1800000>;
> +                       regulator-always-on;
> +               };
> +
> +               reg_wifi_vmmc: regulator@1 {

This will trigger warnings...

reg_wifi_vmmc: regulator-wifi-vmmc {

> +                       compatible =3D "regulator-fixed";
> +                       regulator-name =3D "vmmc";
> +                       regulator-min-microvolt =3D <3300000>;
> +                       regulator-max-microvolt =3D <3300000>;
> +                       gpio =3D <&gpio2 10 GPIO_ACTIVE_HIGH>;
> +                       off-on-delay =3D <20000>;
> +                       startup-delay-us =3D <100>;
> +                       enable-active-high;

Move the enable-active-high right after the gpio.

>  &fec1 {
> @@ -40,7 +163,130 @@ vddio: vddio-regulator {
>         };
>  };
>
> +&i2c3 {
> +       clock-frequency =3D <100000>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_i2c3>;
> +       status =3D "okay";
> +
> +       rx8025: rtc@32 {
> +               compatible =3D "rx8025";
> +               reg =3D <0x32>;
> +       };
> +
> +       wm8904: wm8904@1a {

Node name should be generic

audio-code@1a {

> +&usdhc1 {
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +       pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
> +       pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
> +       bus-width =3D <4>;
> +       vmmc-supply =3D <&reg_wifi_vmmc>;
> +       pm-ignore-notify;

This property does not exist upstream. Please remove it.

> +/* USBOTG */
> +&usbotg1 {
> +        dr_mode =3D "otg";
> +        extcon =3D <&extcon_usb>;
> +        picophy,pre-emp-curr-control =3D <3>;
> +        picophy,dc-vol-level-adjust =3D <7>;

These two properties do not exist upstream. Remove them.

> +       pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK                 0=
x196
> +                       MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD                 0=
x1d6
> +                       MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0             0=
x1d6
> +                       MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1             0=
x1d6
> +                       MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2             0=
x1d6
> +                       MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3             0=
x1d6
> +               >;
> +       };
> +       pinctrl_usdhc1_gpio: usdhc1grpgpio {

pinctrl_usdhc1_gpio: usdhc1gpiogrp {

> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi b/arch/a=
rm64/boot/dts/freescale/imx8mm-emtop-som.dtsi
> index 67d22d3768aa..9b188075921c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi
> @@ -182,6 +182,7 @@ pinctrl_gpio_led: emtop-gpio-led-grp {
>                 fsl,pins =3D <
>                         MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16             =
       0x19
>                         MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29                 =
       0x19
> +                       MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15               =
       0x19    /* canbus_reset */

Adding a CAN transceiver reset GPIO into the gpio-led group looks strange.

