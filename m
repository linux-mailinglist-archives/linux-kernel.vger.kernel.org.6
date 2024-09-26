Return-Path: <linux-kernel+bounces-341114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDFE987B78
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E711C2173D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07A61B0105;
	Thu, 26 Sep 2024 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BRjO8ktC"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2A143C4C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391776; cv=none; b=S51sRIDKyaWAaAK0MayuzNz9+Xg1manIES5b9WS7lBkBlRbQ40XXau5IR+MSv5WilRkj+IfF/yVulkSmAOwVUORRRAz9Nl6N49hpR5fQX3pECW3aq/liefOdUSMvQbQ6kL2PVwbtGSJQG5ZOCq6PBoB1v/36nDlccUcSjEB5mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391776; c=relaxed/simple;
	bh=oM59e6kr162a9a2uhU9XEojF6kxpM2IMYzqPQD7xs5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYRIUxQTCtGPQOsCEDOg9ciqSSdcbJkFz1T88oyiQHU9h2eyMwlY26dud4gV5w8SY6ZWl4ButJzN2BwnCB8yi4I7ajh9ovpil1FUOuZZGKBkEetb8gxASxjFDWPQZOQ+bPVzGiwZylnS1aeJUj5UiCUARcTwAXAjbI8rUoaEMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BRjO8ktC; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e23b300bf9so9710167b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727391774; x=1727996574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l++ZOmowKHw8XyXDDkEXLL9vXkRtvvkj5VB0cxq2xZk=;
        b=BRjO8ktCpKV8OvePNZ1Tfm1I++mMCuzU1v5CNoGXFx0SFtdDifOlcZcEcRFvK/rJ4V
         YHiIbJh+RLDbsrhneDY64cMmOHA10co5Bs9fQkmFsDk9kyRVhyqwyA77dTFDXC4ovqq6
         2fa4vDpp3BPK1IZTb4muG8TWHpjCdiAcdEMog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727391774; x=1727996574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l++ZOmowKHw8XyXDDkEXLL9vXkRtvvkj5VB0cxq2xZk=;
        b=kRRb6z4fga4oRJL/I9F0uPDnRvpeIoULQrmfpggvLh3NyCq8D+mhXxBuSaMHRVFst6
         mbnKwIk0qU5MTbp4AFaeW/3YrwSA4AXcsWeA67PMVkLRSAwqcBQbtcOV6znai0lZkCmJ
         nYD6PAazy9fLYNy3HJsglU1aPycHmo3su7/Zq+LhIc8kR/eTDwEX8xAbfefzppr+VrO8
         JzRrkWIIN3BL0IqMfs8KtpXI8FBGlTeZyJCEo8b/jTZ9M+DcYt+lcRmTwBB9nd0kryy/
         NQs0afR0qQnh100/5itAC3g2P2UEdzQx6Tf/ZvwOHgzr+y+F8QE7QkgxSRlAwXfr/Cnk
         n6BA==
X-Forwarded-Encrypted: i=1; AJvYcCV7S0zt3VthA7HTEJktyzQcnFXH+ITjHLBd4aT2t82uJ7nMBh6iUI6C6UQ4b0DAM8yAlW9YGJ3AWkWa4RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPRVirR+qsrmst5TxeMoe3Rh3ICNb2RHMPDj8mQhmeNyM9VP6
	kIfk/9oFnOHEq199TKB2S8+8pZdKhzaJTZc8G4LFA4OCwLzTI4OTywYuIz9WelDCmWtJxmYRwax
	2ypaRA28mNunk+5D3LXDMawBc7CL6YAPYZq6b
X-Google-Smtp-Source: AGHT+IHvR0iPjqZka/TBZbcQc4sKK1GUE3B8UbLiK9wUGx6AXR3PAOEAsvGzErlfJJhebhQbh6Ajaz7zXKrEw/n/UGk=
X-Received: by 2002:a05:690c:6303:b0:6b0:52a6:6515 with SMTP id
 00721157ae682-6e2474d1f72mr12375437b3.6.1727391773882; Thu, 26 Sep 2024
 16:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925080353.2362879-1-jakiela@google.com> <20240925080353.2362879-2-jakiela@google.com>
 <bbf023c7-f08b-4f9d-8770-08e63074fb4c@collabora.com>
In-Reply-To: <bbf023c7-f08b-4f9d-8770-08e63074fb4c@collabora.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Thu, 26 Sep 2024 16:02:27 -0700
Message-ID: <CAJMQK-g4BdJPPU59s4X3yuAU+Gy-hTm9bCnSHFfDEbtKv6Xr1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mediate: Introduce MT8186
 Chinchou/Chinchou360 Chromebooks
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?Q?Albert_Jakie=C5=82a?= <jakiela@google.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	wenst@chromium.org, rafal@milecki.pl, nfraprado@collabora.com, 
	macpaul.lin@mediatek.com, sean.wang@mediatek.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:27=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 25/09/24 10:03, Albert Jakie=C5=82a ha scritto:
> > The MT8186 Chinchou/Chinchou360, also known as the Asus Chromebook
> > CZ12/CZ11 Flip, is a clamshell or convertible device with touchscreen,
> > stylus and extra buttons.
> >
> > Signed-off-by: Albert Jakie=C5=82a <jakiela@google.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/Makefile         |   3 +
> >   .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
> >   .../mediatek/mt8186-corsola-chinchou-sku1.dts |  34 ++
> >   .../mt8186-corsola-chinchou-sku16.dts         |  28 ++
> >   .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 445 +++++++++++++++++=
+
> >   5 files changed, 528 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinch=
ou-sku0.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinch=
ou-sku1.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinch=
ou-sku16.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinch=
ou.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dt=
s/mediatek/Makefile
> > index 8fd7b2bb7a15..0db7770e8907 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -55,6 +55,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kodama-=
sku32.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku0.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku176.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-pumpkin.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-chinchou-sku0.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-chinchou-sku1.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-chinchou-sku16.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-magneton-sku393216.dt=
b
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-magneton-sku393217.dt=
b
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-magneton-sku393218.dt=
b
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.=
dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
> > new file mode 100644
> > index 000000000000..29dd92318da1
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
> > @@ -0,0 +1,18 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2023 Google LLC
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt8186-corsola-chinchou.dtsi"
> > +
> > +/ {
> > +     model =3D "Google chinchou sku0 board";
> > +     compatible =3D "google,chinchou-sku0", "google,chinchou-sku2",
> > +                     "google,chinchou-sku4", "google,chinchou-sku5",
> > +                     "google,chinchou", "mediatek,mt8186";
> > +};
> > +
> > +&gpio_keys {
> > +     status =3D "disabled";
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.=
dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
> > new file mode 100644
> > index 000000000000..8ba31f81d9ad
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2023 Google LLC
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt8186-corsola-chinchou.dtsi"
> > +
> > +/ {
> > +     model =3D "Google chinchou sku1/sku17 board";
> > +     compatible =3D "google,chinchou-sku1", "google,chinchou-sku17",
> > +                     "google,chinchou-sku3", "google,chinchou-sku6",
> > +                     "google,chinchou-sku7", "google,chinchou-sku20",
> > +                     "google,chinchou-sku22", "google,chinchou-sku23",
> > +                     "mediatek,mt8186";
> > +};
> > +
> > +&i2c1 {
> > +     i2c-scl-internal-delay-ns =3D <10000>;
> > +
> > +     touchscreen: touchscreen@41 {
> > +             compatible =3D "ilitek,ili2901";
> > +             reg =3D <0x41>;
> > +             interrupts-extended =3D <&pio 12 IRQ_TYPE_LEVEL_LOW>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&touchscreen_pins>;
> > +             reset-gpios =3D <&pio 60 GPIO_ACTIVE_LOW>;
> > +             vccio-supply =3D <&pp1800_tchscr_report_disable>;
> > +     };
> > +};
> > +
> > +&gpio_keys {
> > +     status =3D "disabled";
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16=
.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
> > new file mode 100644
> > index 000000000000..d3378d7ad096
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2023 Google LLC
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt8186-corsola-chinchou.dtsi"
> > +
> > +/ {
> > +     model =3D "Google chinchou sku16/sku2147483647 board";
> > +     compatible =3D "google,chinchou-sku16", "google,chinchou-sku18",
> > +                     "google,chinchou-sku19", "google,chinchou-sku21",
> > +                     "google,chinchou-sku2147483647", "mediatek,mt8186=
";
> > +};
> > +
> > +&i2c1 {
> > +     i2c-scl-internal-delay-ns =3D <10000>;
> > +
> > +     touchscreen: touchscreen@41 {
> > +             compatible =3D "ilitek,ili2901";
> > +             reg =3D <0x41>;
> > +             interrupts-extended =3D <&pio 12 IRQ_TYPE_LEVEL_LOW>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&touchscreen_pins>;
> > +             reset-gpios =3D <&pio 60 GPIO_ACTIVE_LOW>;
> > +             vccio-supply =3D <&pp1800_tchscr_report_disable>;
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi =
b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
> > new file mode 100644
> > index 000000000000..c77cc43f8442
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
>
> ..snip..
>
> > +
> > +&mmc1_pins_default {
> > +     pins-clk {
> > +             drive-strength =3D <MTK_DRIVE_8mA>;
>
> Please stop using the meaningless MTK_DRIVE_(x)mA macro.
>
> drive-strength =3D <8>; is enough :-)
>
> Cheers,
> Angelo
>
> > +     };
> > +
> > +     pins-cmd-dat {
> > +             drive-strength =3D <MTK_DRIVE_8mA>;
> > +     };
> > +};
> > +
> > +&mmc1_pins_uhs {
> > +     pins-clk {
> > +             drive-strength =3D <MTK_DRIVE_8mA>;
> > +     };
> > +
> > +     pins-cmd-dat {
> > +             drive-strength =3D <MTK_DRIVE_8mA>;
> > +     };
> > +};
> > +
> > +&sound {
> > +     status =3D "okay";
> > +
> > +     compatible =3D "mediatek,mt8186-mt6366-rt5650-sound";
>
> You don't need to change this compatible, as the only thing that changes =
in the
> actual driver are the dapm_routes. I implemented support for that nice da=
i-link
> (standard, kind of) graph so that we stop getting a thousand compatibles =
for no
> reason other than routing :-)
>
> This should work with (99.9% confident it will, but please test):
>
>         model =3D "mt8186_rt5650";
>         status =3D "okay";
>
> > +     mediatek,adsp =3D <&adsp>;
>
> This property is already set in the node that you're inheriting from
> mt8186-corsola.dtsi, please drop.
>
> > +
> > +     audio-routing =3D
> > +             "Headphone", "HPOL",
> > +             "Headphone", "HPOR",
> > +             "HDMI1", "TX";
> > +
> > +     hs-playback-dai-link {
> > +             codec {
> > +                     sound-dai =3D <&rt5650>;
> > +             };
> > +     };
> > +
> > +     hs-capture-dai-link {
> > +             codec {
> > +                     sound-dai =3D <&rt5650>;
> > +             };
> > +     };
> > +
> > +     spk-share-dai-link {
> > +     };
>
> Empty nodes are meaningless (and you're inheriting this dai link from
> mt8186-corsola.dtsi as well). Drop.
>
> > +
> > +     spk-hdmi-playback-dai-link {
> > +             codec {
> > +                     sound-dai =3D <&it6505dptx>;
> > +             };
> > +     };
> > +};
> > +
> > +&wifi_enable_pin {
> > +     pins-wifi-enable {
> > +             pinmux =3D <PINMUX_GPIO51__FUNC_GPIO51>;
> > +     };
> > +};
> > +
> > +&wifi_pwrseq {
> > +     reset-gpios =3D <&pio 51 GPIO_ACTIVE_LOW>;
> > +};
> > +
>
> ..snip..
>
> > +
> > +&pen_insert {
> > +     wakeup-event-action =3D <EV_ACT_ANY>;
>
> Why is this set to EV_ACT_ANY on Chinchou but not on the other Corsola de=
vices?
> Is there any specific reason?

Default it's set to EV_ACT_DEASSERTED. Some OEMs want to wake up on
both assert and deassert.

>
> Cheers,
> Angelo
>

