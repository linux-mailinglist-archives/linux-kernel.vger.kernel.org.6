Return-Path: <linux-kernel+bounces-367572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FFF9A03FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A3F2851DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC03C1B6CE3;
	Wed, 16 Oct 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgB5Fdwb"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80918B473;
	Wed, 16 Oct 2024 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066640; cv=none; b=rtPEcTAQAGK/75FfAuLS+ecvdz6wK/eo6bnVb/HUS08lt7jjxxBGeyAhIZh51Hqla4uo+uTdlLJ00l2O1uG6noO3W/ZyD5JAjBAxxPAf0RCOIkgVssTXOz8uzKaQAwC1v8uOpAqiSVBSpIZNZwddh4bY8Ow5FeGReMGZ9Rc1AsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066640; c=relaxed/simple;
	bh=W7RowBdHT4f+P8dR62eXduVYuqH0YV4BoB3Kz9EFdy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkcG+Hk+wQLbfM4/SbPZu+eId1VgWQgK0O078oSpQguKGhS4EJ1ougJNpUBaL/UcpsUpYKMdNw0X2MDMZYUyh7j/K+f4P3f1TWIwDkTgBMivDr8Z/8xHITqx3axlUwP2MWSM3J8PrkBE5Z8xqqJWJ/XDCM3fY2vV5sfhHC4UExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgB5Fdwb; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3b98d8a7eso16352005ab.3;
        Wed, 16 Oct 2024 01:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729066637; x=1729671437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ7Yl/IADUsYDzfDC27LTc+4OQ90sFAT2PacItaEUAU=;
        b=LgB5FdwbDVc12IsEcHo5BlSJiw/NP9JEiI6UpwVzUx+IBxEw28I7LR0htQ3Xw5lCwT
         Xw6sphkdPizPMCPvx8esxcXLbYN3JV/Blz/SQuu3j9XbjSMMYwY0R+Kzoxl8d+EFFnYS
         Vh3UfChb1/opFnMOViWERlmk/0KkqDpYOOijdWnhNi4o7RcLkY1jcyPC4TckCTfeM7Br
         Q1Avm55dQR7wVqmYICtdMWfKXVuMWgndSGOSHPm/PQGOIvBbT1Xi+GbUjOEbLj1w9LUi
         Os+SicaLKGkGNA1zELUoUxs/nVTav2HTqsllbvrQO/W8+/VxuIHVV1r2hmxIv8xWVjfD
         ZbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066637; x=1729671437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ7Yl/IADUsYDzfDC27LTc+4OQ90sFAT2PacItaEUAU=;
        b=cfTBu25aWdshDQmctGBxaAv5ermn3tov8BXQUGUBbmIeD+kNrta7krDE2mOfgxBXC2
         bnwZa2/xXpwn3LwYDZDZLtEJqGrgP4J7GFEi6gb7SE940cf5EnYDyY+5/FJnAI2P5GY3
         1bKBWH+g7o44W3QWDFsJe2uw1E+HMn3cf7Zy+/KsLyrCWM7UVmP8Qgofspegvotjmw1g
         952D8JPZw0aWWsGNcI7xjYa8Y55ez/bt27qSm+b4WIRIuOj8c55WBPnR3vEs3UX8Rono
         UgVsGCUbl7nAUHlu7L+N2yzEM4hQHxrgLMu1/345gAL/pkjDlIGws1Qo1gYvTP8gbf7k
         a6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCULyJGsTULJDL3a+2bH5vlxzPLDJfrkPFlKUobDuL4FsLsgpTeo7i879B49E6HFusld5FnHfrG9lAv3@vger.kernel.org, AJvYcCWzET/gPRvy7uIdGTQ6t2mgRXaGbxzTlcV6XWEWJlQypiT51oQ/0cT5yUfZjMqYqC5td5mZTf9R9pwtK1Gu@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5ZHKbOwirqMKbBNH+75Rq3AI8s1hzXjqlj+lMcd2P8olMgcl
	cTLn4FuJHKBXPCX0v4PIxn5gNsqh2aAXUuLHS06dIoG93TEs7XoshU++gmwc+HDEe7FpfheBnAA
	YB/0XHmjaUgiaqJw8ylctsbHOpEs=
X-Google-Smtp-Source: AGHT+IGMGwemmX8QKJFS/YeT0BUqntktDJUHCQOSIR3XNqG5e5BuUkFwWEi1dzGtv+YrGwI7DX/vejugt8v79fdr6tI=
X-Received: by 2002:a05:6e02:1d15:b0:3a3:3e17:993f with SMTP id
 e9e14a558f8ab-3a3b5f4411fmr161294395ab.8.1729066636855; Wed, 16 Oct 2024
 01:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1726106381-1138-1-git-send-email-shengjiu.wang@nxp.com>
 <1726106381-1138-2-git-send-email-shengjiu.wang@nxp.com> <Zw9y84AzNwUhUAhJ@dragon>
In-Reply-To: <Zw9y84AzNwUhUAhJ@dragon>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 16 Oct 2024 16:17:04 +0800
Message-ID: <CAA+D8APK+6ErUHXe7c0ooLcm3TLCNgYPeuC4ywgPME_o+TM4+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: imx93-9x9-qsb: Enable sound-wm8962
 sound card
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 4:03=E2=80=AFPM Shawn Guo <shawnguo2@yeah.net> wrot=
e:
>
> On Thu, Sep 12, 2024 at 09:59:39AM +0800, Shengjiu Wang wrote:
> > Add wm8962 sound card which connects to sai3. The connection
> > of SAI3 and wm8962 is controlled by PCAL6524HEAZ module, add
> > gpio-hog for it.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../boot/dts/freescale/imx93-9x9-qsb.dts      | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm=
64/boot/dts/freescale/imx93-9x9-qsb.dts
> > index f8a73612fa05..10f3366b8253 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> > @@ -68,6 +68,15 @@ reg_vref_1v8: regulator-adc-vref {
> >               regulator-max-microvolt =3D <1800000>;
> >       };
> >
> > +     reg_audio_pwr: regulator-audio-pwr {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "audio-pwr";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             gpio =3D <&pcal6524 16 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +     };
> > +
> >       reg_rpi_3v3: regulator-rpi {
> >               compatible =3D "regulator-fixed";
> >               regulator-name =3D "VDD_RPI_3V3";
> > @@ -88,6 +97,22 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
> >               enable-active-high;
> >               off-on-delay-us =3D <12000>;
> >       };
> > +
> > +     sound-wm8962 {
> > +             compatible =3D "fsl,imx-audio-wm8962";
> > +             model =3D "wm8962-audio";
> > +             audio-cpu =3D <&sai3>;
> > +             audio-codec =3D <&wm8962>;
> > +             hp-det-gpio =3D <&pcal6524 4 GPIO_ACTIVE_HIGH>;
> > +             audio-routing =3D
> > +                     "Headphone Jack", "HPOUTL",
> > +                     "Headphone Jack", "HPOUTR",
> > +                     "Ext Spk", "SPKOUTL",
> > +                     "Ext Spk", "SPKOUTR",
> > +                     "AMIC", "MICBIAS",
> > +                     "IN3R", "AMIC",
> > +                     "IN1R", "AMIC";
> > +     };
> >  };
> >
> >  &adc1 {
> > @@ -136,6 +161,28 @@ &lpi2c1 {
> >       pinctrl-0 =3D <&pinctrl_lpi2c1>;
> >       status =3D "okay";
> >
> > +     wm8962: codec@1a {
>
> Can we use audio-codec for node name?

Ok,  will update it.

Best regards
Shengjiu Wang

>
> Shawn
>
> > +             compatible =3D "wlf,wm8962";
> > +             reg =3D <0x1a>;
> > +             clocks =3D <&clk IMX93_CLK_SAI3_GATE>;
> > +             DCVDD-supply =3D <&reg_audio_pwr>;
> > +             DBVDD-supply =3D <&reg_audio_pwr>;
> > +             AVDD-supply =3D <&reg_audio_pwr>;
> > +             CPVDD-supply =3D <&reg_audio_pwr>;
> > +             MICVDD-supply =3D <&reg_audio_pwr>;
> > +             PLLVDD-supply =3D <&reg_audio_pwr>;
> > +             SPKVDD1-supply =3D <&reg_audio_pwr>;
> > +             SPKVDD2-supply =3D <&reg_audio_pwr>;
> > +             gpio-cfg =3D <
> > +                     0x0000 /* 0:Default */
> > +                     0x0000 /* 1:Default */
> > +                     0x0000 /* 2:FN_DMICCLK */
> > +                     0x0000 /* 3:Default */
> > +                     0x0000 /* 4:FN_DMICCDAT */
> > +                     0x0000 /* 5:Default */
> > +             >;
> > +     };
> > +
> >       ptn5110: tcpc@50 {
> >               compatible =3D "nxp,ptn5110", "tcpci";
> >               reg =3D <0x50>;
> > @@ -194,6 +241,12 @@ pcal6524: gpio@22 {
> >               interrupts =3D <26 IRQ_TYPE_LEVEL_LOW>;
> >               pinctrl-names =3D "default";
> >               pinctrl-0 =3D <&pinctrl_pcal6524>;
> > +
> > +             exp-sel-hog {
> > +                     gpio-hog;
> > +                     gpios =3D <22 GPIO_ACTIVE_HIGH>;
> > +                     output-low;
> > +             };
> >       };
> >
> >       pmic@25 {
> > @@ -286,6 +339,17 @@ &mu2 {
> >       status =3D "okay";
> >  };
> >
> > +&sai3 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_sai3>;
> > +     assigned-clocks =3D <&clk IMX93_CLK_SAI3>;
> > +     assigned-clock-parents =3D <&clk IMX93_CLK_AUDIO_PLL>;
> > +     assigned-clock-rates =3D <12288000>;
> > +     fsl,sai-mclk-direction-output;
> > +     fsl,sai-synchronous-rx;
> > +     status =3D "okay";
> > +};
> > +
> >  &usbotg1 {
> >       dr_mode =3D "otg";
> >       hnp-disable;
> > @@ -443,6 +507,16 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07 0x31e
> >               >;
> >       };
> >
> > +     pinctrl_sai3: sai3grp {
> > +             fsl,pins =3D <
> > +                     MX93_PAD_GPIO_IO12__SAI3_RX_SYNC                0=
x31e
> > +                     MX93_PAD_GPIO_IO18__SAI3_RX_BCLK                0=
x31e
> > +                     MX93_PAD_GPIO_IO17__SAI3_MCLK                   0=
x31e
> > +                     MX93_PAD_GPIO_IO19__SAI3_TX_DATA00              0=
x31e
> > +                     MX93_PAD_GPIO_IO20__SAI3_RX_DATA00              0=
x31e
> > +             >;
> > +     };
> > +
> >       pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> >               fsl,pins =3D <
> >                       MX93_PAD_SD2_CD_B__GPIO3_IO00           0x31e
> > --
> > 2.34.1
> >
>

