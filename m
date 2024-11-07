Return-Path: <linux-kernel+bounces-399421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D962B9BFEBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B47B21A51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF1195B18;
	Thu,  7 Nov 2024 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zj5zB8pl"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54552192590
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730962746; cv=none; b=QNI02o4KSF9NgRlQC5uowugqhG3RtCg9rZzZxFGcuNK0NNUXxg2zL755SMCX2qHuCRGcnBc+AZa2ONGjCL6rxwgi5BW7lbyRxvRH7RytGH3TUlDkOK8WjnkCfzsjWnWefsZFS3uEaBtcXzMTjdf0ESQHdYxpQbo0wooXK40P6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730962746; c=relaxed/simple;
	bh=vQZTYMYvqksOScm3WlYZlLYYUUgQUvzesgn+HsAureM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+ARWotLByj6eELTAXXDVH1IVdDIE/mv2VKQ0ee41VjT7uqtXp1TbjEj4FhZedcL0K/qO4R8I6AjqOSA2UWXpujO8dcoNYtcl4J49a4qXXNgyvpbWC2Tl1C72hOy55wDv+dTnJrTATEYKZLdYcklSlaocVqu+HqWjvKZ1DPFa0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zj5zB8pl; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fc7b58d4dso233085241.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 22:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730962743; x=1731567543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V02Q+hBZd7IKoOvbggj5lIvd5lTBVFB0kCkzN1VjvB0=;
        b=Zj5zB8plxzy1Zxvh8kEAxQq4knKn0OaWS86wyM6VR/s6eMPX2Qw+qsW/T+tRyHIGTo
         bnleivoOVMJYwpGXb0Lc0LpynHltC0MwflD5Rg7KslGiUuVELrBfHimuhLWC7Ntec3LG
         D0/8Z14CtYzWSL0dnfGSNLa4yX6IsomE0KFQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730962743; x=1731567543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V02Q+hBZd7IKoOvbggj5lIvd5lTBVFB0kCkzN1VjvB0=;
        b=gQcyXjXGDKtBk4T1EoCPlM7up7atwD0wsW1JT4CvXg8ZZE0W9bqdEYguWdaCi2Tyu8
         1MT2YakzqQWVPepts3kjL7pg4To0KrZCkYckqEZQieaXU0fMWKhKV2XBNPtdFms4auwp
         EkGpe7sNwomdVIkzGtVjKcqY0LQEIa1i0STDKZb8bMMA5WFV5usJm53G6cz5rcg+GdoV
         NeWqmFUX0tkxXZVRFTx1VJyqcx9apbDE3bGWC/LzdaXyR7KegzJWYnl7ph42370Zh/fZ
         w1oMqZqTC0JYhXH601MzY9oKHTfmK551L2rzvJihkxij4Wrbt1baIwAR4f3AX163eZ7H
         ehLA==
X-Forwarded-Encrypted: i=1; AJvYcCVX/w8Dip+6ab1A3Kj8vQ/a35WU9RymjtCjCDbFRIqiPhNfl1l2CtjY0MCu1YytQczylkoDM7h5L7dd9Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyovReCNTZASP916o7FtvReZYTHeXE0w2ZlygRvZQnDYxQffEIi
	4DZpHbruwiV7Zifh82bKwIsmkZW2GeYNoA6Md9CPXLLHfXX1494CjPM2WsSPs39roAYE+C3ph0E
	=
X-Google-Smtp-Source: AGHT+IFdwbz0JUk8uT3Qecq0w49pwZ8DlFJSmy/Hdt5UFP2geGdwJ5u1RBs+P9CSkPKYyGHqlAQ9Kw==
X-Received: by 2002:a05:6102:3a06:b0:4a4:87f8:f423 with SMTP id ada2fe7eead31-4aada14ec8amr45964137.12.1730962742692;
        Wed, 06 Nov 2024 22:59:02 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4aa9efeed0asm145563137.26.2024.11.06.22.59.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 22:59:02 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50d3d2d0775so267474e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 22:59:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxrtYf9NP3kU8a+imUsjHIaTEH1P3lQ02o5C3piHa3tUghxb6E9w5WAkfxnT58HSk5Wl//HzTWyNhda0M=@vger.kernel.org
X-Received: by 2002:a05:6102:c0d:b0:4a4:9363:b84c with SMTP id
 ada2fe7eead31-4aada0603aemr55330137.6.1730962741133; Wed, 06 Nov 2024
 22:59:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105093222.4055774-1-fshao@chromium.org> <20241105093222.4055774-3-fshao@chromium.org>
 <b66dbf9e-b35b-482c-9eb7-112ef1f398d6@collabora.com>
In-Reply-To: <b66dbf9e-b35b-482c-9eb7-112ef1f398d6@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 7 Nov 2024 14:58:25 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngozo11g1vF2jnHjTLcNmP8tOMsQhK+LR0QWqoeXwSJjg@mail.gmail.com>
Message-ID: <CAC=S1ngozo11g1vF2jnHjTLcNmP8tOMsQhK+LR0QWqoeXwSJjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Introduce MT8188 Geralt
 platform based Ciri
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 9:19=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 05/11/24 10:30, Fei Shao ha scritto:
> > Introduce MT8188-based Chromebook Ciri, also known commercially as
> > Lenovo Chromebook Duet (11", 9).
> >
> > Ciri is a detachable device based on the Geralt design, where Geralt is
> > the codename for the MT8188 platform. Ciri offers 8 SKUs to accommodate
> > different combinations of second-source components, including:
> > - audio codecs (RT5682S and ES8326)
> > - speaker amps (TAS2563 and MAX98390)
> > - MIPI-DSI panels (BOE nv110wum-l60 and IVO t109nw41)
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
> > Changes in v2:
> > - remove invalid or undocumented properties
> >      e.g. mediatek,dai-link, maxim,dsm_param_name etc.
> > - remove touchscreen as the driver is not yet accepted in upstream
> > - update sound DAI link node name to match the binding
> > - add missing pinctrls in audio codec nodes
> >
> >   arch/arm64/boot/dts/mediatek/Makefile         |    8 +
> >   .../dts/mediatek/mt8188-geralt-ciri-sku0.dts  |   11 +
> >   .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |   60 +
> >   .../dts/mediatek/mt8188-geralt-ciri-sku2.dts  |   56 +
> >   .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |   15 +
> >   .../dts/mediatek/mt8188-geralt-ciri-sku4.dts  |   43 +
> >   .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |   73 +
> >   .../dts/mediatek/mt8188-geralt-ciri-sku6.dts  |   69 +
> >   .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |   47 +
> >   .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |  397 +++++
> >   .../boot/dts/mediatek/mt8188-geralt.dtsi      | 1492 ++++++++++++++++=
+
> >   11 files changed, 2271 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sk=
u0.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sk=
u1.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sk=
u2.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sk=
u3.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sk=
u4.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sk=
u5.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sk=
u6.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sk=
u7.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dt=
si
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> >
[...]

> > diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi b/arc=
h/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
> > new file mode 100644
> > index 000000000000..62c8a37a4c3d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
> > @@ -0,0 +1,397 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2023 Google LLC
> > + */
> > +/dts-v1/;
> > +#include "mt8188-geralt.dtsi"
> > +
> > +/delete-node/ &pp3300_edp_disp;
> > +
> > +&aud_etdm_hp_on {
> > +     pins-mclk {
> > +             pinmux =3D <PINMUX_GPIO114__FUNC_O_I2SO2_MCK>;
> > +     };
> > +};
> > +
> > +&aud_etdm_hp_off {
> > +     pins-mclk {
> > +             pinmux =3D <PINMUX_GPIO114__FUNC_B_GPIO114>;
> > +             bias-pull-down;
> > +             input-enable;
> > +     };
> > +};
> > +
> > +&aud_etdm_spk_on {
> > +     pins-bus {
> > +             drive-strength =3D <8>;
> > +     };
> > +};
> > +
> > +/* Ciri's TDP design target is 90 degrees */
>
> ...and there's only Ciri in this submission, so move that to -geralt.dtsi

In response to the "there's only Ciri, so move to / don't declare
unused stuff in -geralt.dtsi" and similar comments - I'll adjust each
of the mentioned lines.

My intention was to clearly describe the differences between Ciri and
the proto hardware, but I understand and also agree with your point
that these deltas should be introduced only when a real product
utilizes them.
I will follow this approach in the next revision.

>
> > +&cpu_little0_alert0 {
> > +     temperature =3D <90000>;
> > +     hysteresis =3D <2000>;
> > +     type =3D "passive";
> > +};
> > +
> > +&cpu_little1_alert0 {
> > +     temperature =3D <90000>;
> > +     hysteresis =3D <2000>;
> > +     type =3D "passive";
> > +};
> > +
> > +&cpu_little2_alert0 {
> > +     temperature =3D <90000>;
> > +     hysteresis =3D <2000>;
> > +     type =3D "passive";
> > +};
> > +
> > +&cpu_little3_alert0 {
> > +     temperature =3D <90000>;
> > +     hysteresis =3D <2000>;
> > +     type =3D "passive";
> > +};
> > +
> > +&cpu_big0_alert0 {
> > +     temperature =3D <90000>;
> > +     hysteresis =3D <2000>;
> > +     type =3D "passive";
> > +};
> > +
> > +&cpu_big1_alert0 {
> > +     temperature =3D <90000>;
> > +     hysteresis =3D <2000>;
> > +     type =3D "passive";
> > +};
> > +
> > +&dp_intf0 {
> > +     /delete-node/ port;
>
> Just don't add dp_intf0 if there's none, instead of removing the port her=
e.
>
> > +};
> > +
> > +&dsi_panel {
> > +     compatible =3D "boe,nv110wum-l60", "himax,hx83102";
>
> Move this to each SKU dts file.

Will do.

>
> > +};
> > +
> > +&edp_tx {
> > +     /delete-node/ ports;
> > +     /delete-node/ aux-bus;
> > +};
> > +
> > +&i2c0 {
> > +     /delete-node/ audio-codec@1a;
> > +     /delete-node/ amplifier@3a;
> > +     /delete-node/ amplifier@3b;
>
> No board ever uses those three nodes, because it's all Ciri and nothing e=
lse.
> Just never declare these in -geralt.dtsi and never delete them here.
>
> > +
> > +     rt5682s: audio-codec@1a {
> > +             compatible =3D "realtek,rt5682s";
> > +             reg =3D <0x1a>;
> > +             interrupts-extended =3D <&pio 108 IRQ_TYPE_EDGE_BOTH>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&audio_codec_pins>;
> > +             #sound-dai-cells =3D <1>;
> > +
> > +             AVDD-supply =3D <&mt6359_vio18_ldo_reg>;
> > +             DBVDD-supply =3D <&mt6359_vio18_ldo_reg>;
> > +             LDO1-IN-supply =3D <&mt6359_vio18_ldo_reg>;
> > +             MICVDD-supply =3D <&pp3300_s3>;
> > +             realtek,jd-src =3D <1>;
> > +     };
> > +};
> > +
> > +&i2c2 {
> > +     status =3D "disabled";
>
> ...and if there's no i2c2, just don't add it to -geralt.dtsi in the first=
 place...
> but I believe that you just wanted to avoid probing the device that you d=
eclared
> in -geralt.dtsi on this bus, so you can either remove the nodes for all o=
f the
> unused i2c busses in your board designs, or you can keep them but remove =
all of
> the devices that aren't actually there.
>
> It's your choice in the end, but disabling this here doesn't make much se=
nse imo.

I think I'll follow the latter to describe the pinctrl and clock
frequency of the i2c buses, so future board DT (if any) can just focus
on declaring the devices on the bus.

>
> > +};
> > +
> > +&i2c_tunnel {
> > +     /delete-node/ sbs-battery@b;
>
> Since nothing ever uses sbs-battery@b, just remove sbs-battery@b entirely
> from -geralt.dtsi instead of deleting it here.
>
> Non-Ciri boards, if any, will define the @b one if necessary in their own
> dts/dtsi file(s).
>
> > +
> > +     battery: sbs-battery@f {
> > +             compatible =3D "sbs,sbs-battery";
> > +             reg =3D <0xf>;
> > +             sbs,i2c-retry-count =3D <2>;
> > +             sbs,poll-retry-count =3D <1>;
> > +     };
> > +};
> > +
> > +&max98390_38 {
> > +     sound-name-prefix =3D "Front Right";
>
> Move to -geralt.dtsi
>
> > +};
> > +
> > +&max98390_39 {
> > +     sound-name-prefix =3D "Front Left";
>
> ditto
>
> > +};
> > +
> > +&mipi_tx_config0 {
> > +     drive-strength-microamp =3D <5200>;
> > +};
> > +
> > +&mmc1 {
> > +     status =3D "disabled";
>
> Why are you configuring mmc1 in -geralt.dtsi if no board uses it at all?

This is for the SD cards, though Ciri didn't adopt that in the end...
I'll remove it.

>
> > +};
> > +
> > +&mt6359_vm18_ldo_reg {
> > +     regulator-min-microvolt =3D <1800000>;
> > +     regulator-max-microvolt =3D <1900000>;
> > +     regulator-microvolt-offset =3D <100000>;
> > +};
> > +
> > +&sound {
> > +     compatible =3D "mediatek,mt8188-rt5682s";
> > +     model =3D "mt8188_m98390_5682";
> > +
> > +     audio-routing =3D
> > +             "ETDM1_OUT", "ETDM_SPK_PIN",
> > +             "ETDM2_OUT", "ETDM_HP_PIN",
> > +             "ETDM1_IN", "ETDM_SPK_PIN",
> > +             "ETDM2_IN", "ETDM_HP_PIN",
> > +             "ADDA Capture", "MTKAIF_PIN",
> > +             "Headphone Jack", "HPOL",
> > +             "Headphone Jack", "HPOR",
> > +             "IN1P", "Headset Mic",
> > +             "Left Spk", "Front Left BE_OUT",
> > +             "Right Spk", "Front Right BE_OUT";
>
> Please move compatible, model and audio-routing to SKU0 (and also copy th=
at to
> SKU3): as you're continuously overriding it in all other SKUs, having it =
here
> can only confuse people...

I agree. I'll update it.

>
> > +     status =3D "okay";
> > +
> > +     dai-link-0 {
> > +             dai-format =3D "i2s";
>
> ...and move dai-format to -geralt.dtsi.
>
> > +     };
> > +
> > +     dai-link-1 {
> > +             dai-format =3D "i2s";
> > +             codec {
> > +                     sound-dai =3D <&max98390_38>,
> > +                                 <&max98390_39>;
> > +             };
> > +     };
> > +
> > +     dai-link-2 {
> > +             codec {
> > +                     sound-dai =3D <&rt5682s 0>;
> > +             };
> > +     };
> > +
> > +     dai-link-3 {
> > +             codec {
> > +                     sound-dai =3D <&rt5682s 0>;
> > +             };
> > +     };
> > +};
> > +
> > +&spi1 {
> > +     pinctrl-names =3D "default", "sleep";
> > +     pinctrl-0 =3D <&spi1_pins_default>;
> > +     pinctrl-1 =3D <&spi1_pins_sleep>;
>
> Also move this to -geralt.dtsi, it's even the same pins...!
> P.S.: Of course, move the spi1_pins_sleep to -geralt.dtsi as well.
>
> > +     num-cs =3D <1>;
> > +     #address-cells =3D <1>;
> > +     #size-cells =3D <0>;
>
> ...address and size cells, but no children nodes?

Oh because the Himax touchscreen was removed in v2... I'll drop them.

>
> > +};
> > +
> > +&pio {
>
> ..snip..
>
> > +
> > +     touchscreen_rst: touchscreen-rst-pins {
> > +             pins-tchscr-rst {
> > +                     pinmux =3D <PINMUX_GPIO5__FUNC_B_GPIO5>;
> > +                     output-high;
> > +             };
> > +     };
>
> touchscreen_rst is unused - either use it or remove it.

Will do.

>
> > +
> > +     spi1_pins_default: spi1-default-pins {
> > +             pins-bus {
> > +                     pinmux =3D <PINMUX_GPIO75__FUNC_O_SPIM1_CSB>,
> > +                              <PINMUX_GPIO76__FUNC_O_SPIM1_CLK>,
> > +                              <PINMUX_GPIO77__FUNC_B0_SPIM1_MOSI>,
> > +                              <PINMUX_GPIO78__FUNC_B0_SPIM1_MISO>;
> > +                     bias-disable;
> > +                     drive-strength =3D <10>;
> > +             };
> > +     };
> > +
> > +     spi1_pins_sleep: spi1-sleep-pins {
> > +             pins-bus {
> > +                     pinmux =3D <PINMUX_GPIO75__FUNC_B_GPIO75>,
> > +                              <PINMUX_GPIO76__FUNC_B_GPIO76>,
> > +                              <PINMUX_GPIO77__FUNC_B_GPIO77>,
> > +                              <PINMUX_GPIO78__FUNC_B_GPIO78>;
> > +                     bias-pull-down;
> > +                     input-enable;
> > +             };
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm=
64/boot/dts/mediatek/mt8188-geralt.dtsi
> > new file mode 100644
> > index 000000000000..0d33ae82f0eb
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> > @@ -0,0 +1,1492 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2022 MediaTek Inc.
> > + */
> > +/dts-v1/;
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include "mt8188.dtsi"
> > +#include "mt6359.dtsi"
> > +
> > +/ {
> > +     aliases {
> > +             i2c0 =3D &i2c0;
> > +             i2c1 =3D &i2c1;
> > +             i2c2 =3D &i2c2;
> > +             i2c3 =3D &i2c3;
> > +             i2c4 =3D &i2c4;
> > +             i2c5 =3D &i2c5;
> > +             i2c6 =3D &i2c6;
> > +             mmc0 =3D &mmc0;
> > +             mmc1 =3D &mmc1;
> > +             serial0 =3D &uart0;
> > +     };
> > +
> > +     backlight_lcd0: backlight-lcd0 {
> > +             compatible =3D "pwm-backlight";
> > +             brightness-levels =3D <0 1023>;
> > +             default-brightness-level =3D <576>;
> > +             enable-gpios =3D <&pio 1 GPIO_ACTIVE_HIGH>;
> > +             num-interpolated-steps =3D <1023>;
> > +             power-supply =3D <&ppvar_sys>;
> > +             pwms =3D <&disp_pwm0 0 500000>;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +
> > +     dmic-codec {
> > +             compatible =3D "dmic-codec";
> > +             num-channels =3D <2>;
> > +             wakeup-delay-ms =3D <100>;
> > +     };
> > +
> > +     memory@40000000 {
> > +             device_type =3D "memory";
>
>                 /* The size will be filled in by the bootloader */
>                 reg =3D <0 0x40000000 0 0>;

Acknowledged.

>
>
> > +             reg =3D <0 0x40000000 0 0x80000000>;
> > +     };
> > +
>
> ..snip..
>
> > +
> > +&disp_dsi0 {
> > +     #address-cells =3D <1>;
> > +     #size-cells =3D <0>;
> > +     status =3D "okay";
> > +
> > +     dsi_panel: panel@0 {
> > +             compatible =3D "boe,tv110c9m-ll3";
>
> Remove the compatible string, then add a comment (93 cols, it's ok in one=
 line):
>
> /* Compatible string for different panels can be found in each device dts=
 */

Acknowledged.

>
> > +             reg =3D <0>;
> > +             enable-gpios =3D <&pio 25 GPIO_ACTIVE_HIGH>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&mipi_dsi_pins>;
> > +
> > +             backlight =3D <&backlight_lcd0>;
> > +             avdd-supply =3D <&ppvar_mipi_disp_avdd>;
> > +             avee-supply =3D <&ppvar_mipi_disp_avee>;
> > +             pp1800-supply =3D <&mt6359_vm18_ldo_reg>;
> > +             rotation =3D <270>;
> > +
> > +             status =3D "okay";
> > +
> > +             port {
> > +                     dsi_panel_in: endpoint {
> > +                             remote-endpoint =3D <&dsi_out>;
> > +                     };
> > +             };
> > +     };
> > +
> > +     port {
> > +             dsi_out: endpoint {
> > +                     remote-endpoint =3D <&dsi_panel_in>;
> > +             };
> > +     };
> > +};
> > +
> > +&disp_pwm0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&disp_pwm0_pins>;
> > +     status =3D "okay";
> > +};
> > +
> > +&disp_pwm1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&disp_pwm1_pins>;
> > +};
> > +
> > +&dp_intf0 {
> > +     port {
> > +             dp_intf0_out: endpoint {
> > +                     remote-endpoint =3D <&edp_in>;
> > +             };
> > +     };
> > +};
> > +
> > +&dp_intf1 {
> > +     status =3D "okay";
> > +
> > +     port {
> > +             dp_intf1_out: endpoint {
> > +                     remote-endpoint =3D <&dptx_in>;
> > +             };
> > +     };
> > +};
> > +
> > +&dp_tx {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&dp_tx_hpd>;
> > +     #sound-dai-cells =3D <0>;
> > +     status =3D "okay";
> > +
> > +     ports {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             port@0 {
> > +                     reg =3D <0>;
> > +                     dptx_in: endpoint {
> > +                             remote-endpoint =3D <&dp_intf1_out>;
> > +                     };
> > +             };
> > +
> > +             port@1 {
> > +                     reg =3D <1>;
> > +                     dptx_out: endpoint {
> > +                             data-lanes =3D <0 1 2 3>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&edp_tx {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&edp_tx_hpd>;
> > +
> > +     ports {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             port@0 {
> > +                     reg =3D <0>;
> > +                     edp_in: endpoint {
> > +                             remote-endpoint =3D <&dp_intf0_out>;
> > +                     };
> > +             };
> > +
> > +             port@1 {
> > +                     reg =3D <1>;
> > +                     edp_out: endpoint {
> > +                             data-lanes =3D <0 1 2 3>;
> > +                             remote-endpoint =3D <&edp_panel_in>;
> > +                     };
> > +             };
> > +     };
> > +
> > +     /*
> > +      * Geralt also supports eDP OLED panels, which control panel
> > +      * brightness via the AUX channel and don't require PWM pin
> > +      * control.
> > +      * This is an auxiliary panel path for hardware layout
> > +      * validation and demonstration, so it's disabled by default.
> > +      * Boards adopting MIPI-DSI panels may not have this path.
> > +      **/
>
> There's no board using this: please remove edp_tx entirely, as this is
> only adding lines to this device tree for no useful reason.
>
> If a board with that appears, you can reintroduce this here, or if it is
> a single board, you can add that in the board dts.

Acknowledged.

>
> > +     aux-bus {
> > +             edp_panel: panel {
> > +                     compatible =3D "lg,lp120up1";
> > +                     pinctrl-names =3D "default";
> > +                     pinctrl-0 =3D <&edp_bl_en>;
> > +                     power-supply =3D <&pp3300_edp_disp>;
> > +                     status =3D "disabled";
> > +
> > +                     port {
> > +                             edp_panel_in: endpoint {
> > +                                     remote-endpoint =3D <&edp_out>;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
>
> ..snip..
> > +     edp_bl_en: edp-bl-en-pins {
> > +             pins-ap-disp-bklten {
> > +                     pinmux =3D <PINMUX_GPIO1__FUNC_B_GPIO1>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     edp_disp_en: edp-disp-en-pins {
> > +             pins-en-pp3300-edp-disp {
> > +                     pinmux =3D <PINMUX_GPIO27__FUNC_B_GPIO27>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     edp_tx_hpd: edp-tx-hpd-pins {
> > +             pins-dp-tx-hpd {
> > +                     pinmux =3D <PINMUX_GPIO17__FUNC_I0_EDP_TX_HPD>;
> > +             };
> > +     };
>
> After removing the always disabled edp nodes, you can also remove these p=
ins
> as they are then unused.

Will do.

>
> > +
> > +     gsc_int: gsc-int-pins {
> > +             pins-gsc-ap-int-odl {
> > +                     pinmux =3D <PINMUX_GPIO0__FUNC_B_GPIO0>;
> > +                     input-enable;
> > +             };
> > +     };
> > +
>
> ..snip..
>
> > +&pmic {
> > +     interrupts-extended =3D <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > +&scp {
>
> Is this SCP-dual or SCP?
> I see SCP, but I also see a SCP-Dual memory region... what's going on her=
e?
>
> Of course, the SCP-Dual won't work if you don't override the compatible s=
tring...

To clarify, the second SCP core is used for MIPI camera in downstream,
and I deliberately only describe the first SCP core here since the MTK
camera ISP driver isn't in upstream at the moment.
I had a fixup patch for removing the scp-dual reserved memory region,
but likely it was missing during the rebase... let me check again if
it can be removed, just in case there's firmware protecting the region
and the kernel shouldn't access it.

>
> > +     firmware-name =3D "mediatek/mt8188/scp.img";
> > +     memory-region =3D <&scp_mem>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&scp_pins>;
> > +     status =3D "okay";
> > +
> > +     cros-ec-rpmsg {
> > +             compatible =3D "google,cros-ec-rpmsg";
> > +             mediatek,rpmsg-name =3D "cros-ec-rpmsg";
> > +     };
> > +};
> > +
> > +&sound {
> > +     compatible =3D "mediatek,mt8188-nau8825";
> > +     model =3D "mt8188_m98390_8825";
> > +     pinctrl-names =3D "aud_etdm_hp_on",
> > +                     "aud_etdm_hp_off",
> > +                     "aud_etdm_spk_on",
> > +                     "aud_etdm_spk_off",
> > +                     "aud_mtkaif_on",
> > +                     "aud_mtkaif_off";
>
>         pinctrl-names =3D "aud_etdm_hp_on", "aud_etdm_hp_off",
>                         "aud_etdm_spk_on", "aud_etdm_spk_off",
>                         "aud_mtkaif_on", "aud_mtkaif_off";

Acked.

>
> > +     pinctrl-0 =3D <&aud_etdm_hp_on>;
> > +     pinctrl-1 =3D <&aud_etdm_hp_off>;
> > +     pinctrl-2 =3D <&aud_etdm_spk_on>;
> > +     pinctrl-3 =3D <&aud_etdm_spk_off>;
> > +     pinctrl-4 =3D <&aud_mtkaif_on>;
> > +     pinctrl-5 =3D <&aud_mtkaif_off>;
>
> Add a comment:
>
>         /* The audio-routing is defined in each board dts */
>
> > +     audio-routing =3D "ETDM1_OUT", "ETDM_SPK_PIN",
> > +                     "ETDM2_OUT", "ETDM_HP_PIN",
> > +                     "ETDM1_IN", "ETDM_SPK_PIN",
> > +                     "ETDM2_IN", "ETDM_HP_PIN",
> > +                     "ADDA Capture", "MTKAIF_PIN",
> > +                     "Headphone Jack", "HPOL",
> > +                     "Headphone Jack", "HPOR",
> > +                     "MIC", "Headset Mic",
> > +                     "Left Spk", "Front Left BE_OUT",
> > +                     "Right Spk", "Front Right BE_OUT",
> > +                     "Rear Left Spk", "Rear Left BE_OUT",
> > +                     "Rear Right Spk", "Rear Right BE_OUT";
> > +
>
> ...and remove the audio-routing from this dtsi; it's anyway being
> overridden by the -ciri.dtsi devicetree...

Acknowledged, and thanks for all the feedback here.

Regards,
Fei

>
> > +     mediatek,adsp =3D <&adsp>;
> > +
> > +     status =3D "okay";
> > +
> > +     dai-link-0 {
> > +             link-name =3D "ETDM1_IN_BE";
> > +             dai-format =3D "dsp_b";
> > +             mediatek,clk-provider =3D "cpu";
> > +     };
> > +
> > +     dai-link-1 {
> > +             link-name =3D "ETDM1_OUT_BE";
> > +             dai-format =3D "dsp_b";
> > +             mediatek,clk-provider =3D "cpu";
> > +
> > +             codec {
> > +                     sound-dai =3D <&max98390_38>,
> > +                                 <&max98390_39>,
> > +                                 <&max98390_3a>,
> > +                                 <&max98390_3b>;
> > +             };
> > +     };
> > +
> > +     dai-link-2 {
> > +             link-name =3D "ETDM2_IN_BE";
> > +             mediatek,clk-provider =3D "cpu";
> > +
> > +             codec {
> > +                     sound-dai =3D <&nau8825>;
> > +             };
> > +     };
> > +
> > +     dai-link-3 {
> > +             link-name =3D "ETDM2_OUT_BE";
> > +             mediatek,clk-provider =3D "cpu";
> > +
> > +             codec {
> > +                     sound-dai =3D <&nau8825>;
> > +             };
> > +     };
> > +
> > +     dai-link-4 {
> > +             link-name =3D "DPTX_BE";
> > +
> > +             codec {
> > +                     sound-dai =3D <&dp_tx>;
> > +             };
> > +     };
> > +};
> > +
>
> Cheers,
> Angelo
>

