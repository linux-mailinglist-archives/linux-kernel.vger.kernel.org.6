Return-Path: <linux-kernel+bounces-528651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2E2A41A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B87F3BC7AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B917D2512CE;
	Mon, 24 Feb 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B6nV5yO0"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E22512F9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391415; cv=none; b=LzqaWCfnCG71wAP7/vKP9dnBmnkrNhTjIFB9SkTPW7z7zXn17OSdCuFr1Axew4ew8PlmTRFvJN0ydkxlMb460iP7BB6b2lGamL8PosIefX43On8NDTcCfkDIQRfOD34TsxU1KwrCAa62uFS038wBSQUnupMqzvwkrs3Aaeh7xic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391415; c=relaxed/simple;
	bh=zQ7XsbdFsu3kO/Fh8LY3ZiXsewtZevnUGq0TEwL02BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZre/isPpRjK4WvXyrYhegWMKz6mrlrN0hDjTUDR+NokF1SaNtyAsvGeZMWl38BRMGTF3hwNPABF53jwImBoyKp/ph9wqY5p1vVsvNrBhjGCx8J9+lc+uNzD9Lh+WcB6RB0zWPfpyWF9PPFHhEkBH00cKw1FjV9WQdOi6FElCH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B6nV5yO0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5462a2b9dedso4995769e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740391411; x=1740996211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3m4melpCnWzZDkoEQyxDqJTJzU6ez2FlTtIyhuPHGY=;
        b=B6nV5yO00oNm1Le/q5GGAXymdOWQUt1LglNNHerwG4ua4e7lJ5y4USbilnsEKra/Iv
         fW62q3z6Kda3FRHVLMZ6W6fmPa3AJwG3BCt7NxrlcMNXQ0ddxPigzlTj2HB0yV47UMY1
         aKmDxZXEkQeaHc9ux5R/ruJgo4TndyrmkH11c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391411; x=1740996211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3m4melpCnWzZDkoEQyxDqJTJzU6ez2FlTtIyhuPHGY=;
        b=tZ8dcCYE065THhlgc+Oc3FCzsrGQkHBPgigjfgXZRqIrKudzqgOLnztWxhJLaJDku+
         pVPrHPxpGLveNErVITBhc9Z+Il7Q/kASlSTLRqM6M6VkOe4XUdF4z6EvdK67wC+ll089
         Q3nZuJZURYs4T+jU4E+yAbUzuanjzNBfYfhNIvh5nlbYzbtHWLnRb6VYXnQhXiT14AoB
         ndmUhp2+8BiEMtbNO99ihVvd1LMYQnhaekAJTBErP9t3Flnsj8MmBY9nyZmwKBJV9pum
         co2fqeNCTZ51Up3K/P5JX7fzlqaWXf6JJZzDkEs8bKElQERhJCPvPT6hVrbYyx8KWZsl
         z/2g==
X-Forwarded-Encrypted: i=1; AJvYcCUvLET+OmEd1HDNfVNTaQf4MRkRTDe3S85+SA4+2CzEJx0jvWyfO3a98JMR1INWj8r4HEX6wd35vbjKUMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9VzJS6sTuYQMFeY792V9+cqeKhmPAYYQbllCsCsKRykP9FW+W
	31JJo/tVme1O4TxcwKJhgIOi5Pvbw04AYydK7eYfKprL+U8zNv9ebxgvPvuEK+2JIW4c8IsEriQ
	xrVLYwU1JzlyL2malvnsIOPV90Qk5JXZs3CgFXAJVhZV+6hU=
X-Gm-Gg: ASbGncuE6QNt+fUOxheRDxIqfVIMEhvY7jPq+KfDDe42S6Ob/IshA9PlyQkBveeLpD5
	aqM+yzecXKWiREaivhhfcsh64f73cBls3JlZZkXwnsjScsIHMCRO91keoLVzQ/9HUXnOroM0t86
	wB5WjWKF0zdGLj/0Tv91w50XvRFg7kORxV7cw=
X-Google-Smtp-Source: AGHT+IH+opPQW01wmcpoFizx1l90WyOFRxctvcV9XH9wP9MyBr4k33vvvZ5yfnEZS/CIdmIFOBzQKToLr4utqj99bzA=
X-Received: by 2002:a05:6512:b1f:b0:545:8a1:5377 with SMTP id
 2adb3069b0e04-54839129b32mr3995806e87.2.1740391411500; Mon, 24 Feb 2025
 02:03:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com> <20250220105514.43107-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250220105514.43107-3-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 24 Feb 2025 18:03:20 +0800
X-Gm-Features: AWEUYZlFd5lIJJaJ8GXCoFcPly7FtrF4vnwbpBvHnY7fIIWUD-kvOn2uGY2D4Ss
Message-ID: <CAGXv+5E-mrt2o=b_nxmCdJqX9XbOhWsS+pLzkApS57EKD6kHEA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: mediatek: mt8188: Add MTU3 nodes and
 correctly describe USB
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, pablo.sun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:00=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The MT8188 SoC has three USB controllers, and all of them are behind
> the MTU3 DRD controller.
>
> Add the missing MTU3 nodes, default disabled, for all USB controllers
> and move the related XHCI nodes to be children of their MTU3 DRD to
> correctly describe the SoC.
>
> In order to retain USB functionality on all of the MT8188 and MT8390
> boards, also move the vusb33 supply and enable the relevant MTU3 nodes
> with special attention to the MT8188 Geralt Chromebooks, where it was
> necessary to set the dr_mode of all MTU3 controllers to host to avoid
> interfering with the EC performing DRD on its own.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org> # on MT8188 Ciri

> ---
>  .../boot/dts/mediatek/mt8188-geralt.dtsi      |  18 +++
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 121 ++++++++++++------
>  .../dts/mediatek/mt8390-genio-common.dtsi     |  28 ++++
>  3 files changed, 125 insertions(+), 42 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64=
/boot/dts/mediatek/mt8188-geralt.dtsi
> index b6abecbcfa81..faed5c8bc721 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> @@ -1103,6 +1103,12 @@ &u3phy2 {
>  };
>
>  /* USB detachable base */
> +&ssusb0 {
> +       dr_mode =3D "host";
> +       vusb33-supply =3D <&pp3300_s3>;
> +       status =3D "okay";
> +};
> +
>  &xhci0 {
>         /* controlled by EC */
>         vbus-supply =3D <&pp3300_z1>;
> @@ -1110,6 +1116,12 @@ &xhci0 {
>  };
>
>  /* USB3 hub */
> +&ssusb1 {
> +       dr_mode =3D "host";
> +       vusb33-supply =3D <&pp3300_s3>;
> +       status =3D "okay";
> +};
> +
>  &xhci1 {
>         vusb33-supply =3D <&pp3300_s3>;
>         vbus-supply =3D <&pp5000_usb_vbus>;
> @@ -1117,6 +1129,12 @@ &xhci1 {
>  };
>
>  /* USB BT */
> +&ssusb2 {
> +       dr_mode =3D "host";
> +       vusb33-supply =3D <&pp3300_s3>;
> +       status =3D "okay";
> +};
> +
>  &xhci2 {
>         /* no power supply since MT7921's power is controlled by PCIe */
>         /* MT7921's USB BT has issues with USB2 LPM */
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8188.dtsi
> index d2e1ff7236b1..c226998b7e47 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -1649,6 +1649,38 @@ spi5: spi@11019000 {
>                         status =3D "disabled";
>                 };
>
> +               ssusb1: usb@11201000 {
> +                       compatible =3D "mediatek,mt8188-mtu3", "mediatek,=
mtu3";
> +                       reg =3D <0 0x11201000 0 0x2dff>, <0 0x11203e00 0 =
0x0100>;
> +                       reg-names =3D "mac", "ippc";
> +                       ranges =3D <0 0 0 0x11200000 0 0x3f00>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
> +                       interrupts =3D <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       assigned-clocks =3D <&topckgen CLK_TOP_USB_TOP>;
> +                       assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>;
> +                       clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB_BUS>,
> +                                <&topckgen CLK_TOP_SSUSB_TOP_REF>,
> +                                <&pericfg_ao CLK_PERI_AO_SSUSB_XHCI>;
> +                       clock-names =3D "sys_ck", "ref_ck", "mcu_ck";
> +                       phys =3D <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_=
TYPE_USB3>;
> +                       wakeup-source;
> +                       mediatek,syscon-wakeup =3D <&pericfg 0x468 2>;
> +                       status =3D "disabled";
> +
> +                       xhci1: usb@0 {
> +                               compatible =3D "mediatek,mt8188-xhci", "m=
ediatek,mtk-xhci";
> +                               reg =3D <0 0 0 0x1000>;
> +                               reg-names =3D "mac";
> +                               interrupts =3D <GIC_SPI 129 IRQ_TYPE_LEVE=
L_HIGH 0>;
> +                               assigned-clocks =3D <&topckgen CLK_TOP_SS=
USB_XHCI>;
> +                               assigned-clock-parents =3D <&topckgen CLK=
_TOP_UNIVPLL_D5_D4>;
> +                               clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB=
_XHCI>;
> +                               clock-names =3D "sys_ck";
> +                               status =3D "disabled";
> +                       };
> +               };
> +
>                 eth: ethernet@11021000 {
>                         compatible =3D "mediatek,mt8188-gmac", "mediatek,=
mt8195-gmac",
>                                      "snps,dwmac-5.10a";
> @@ -1746,27 +1778,6 @@ queue3 {
>                         };
>                 };
>
> -               xhci1: usb@11200000 {
> -                       compatible =3D "mediatek,mt8188-xhci", "mediatek,=
mtk-xhci";
> -                       reg =3D <0 0x11200000 0 0x1000>,
> -                             <0 0x11203e00 0 0x0100>;
> -                       reg-names =3D "mac", "ippc";
> -                       interrupts =3D <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0=
>;
> -                       phys =3D <&u2port1 PHY_TYPE_USB2>,
> -                              <&u3port1 PHY_TYPE_USB3>;
> -                       assigned-clocks =3D <&topckgen CLK_TOP_USB_TOP>,
> -                                         <&topckgen CLK_TOP_SSUSB_XHCI>;
> -                       assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>,
> -                                                <&topckgen CLK_TOP_UNIVP=
LL_D5_D4>;
> -                       clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB_BUS>,
> -                                <&topckgen CLK_TOP_SSUSB_TOP_REF>,
> -                                <&pericfg_ao CLK_PERI_AO_SSUSB_XHCI>;
> -                       clock-names =3D "sys_ck", "ref_ck", "mcu_ck";
> -                       mediatek,syscon-wakeup =3D <&pericfg 0x468 2>;
> -                       wakeup-source;
> -                       status =3D "disabled";
> -               };
> -
>                 mmc0: mmc@11230000 {
>                         compatible =3D "mediatek,mt8188-mmc", "mediatek,m=
t8183-mmc";
>                         reg =3D <0 0x11230000 0 0x10000>,
> @@ -1867,42 +1878,68 @@ imp_iic_wrap_c: clock-controller@11283000 {
>                         #clock-cells =3D <1>;
>                 };
>
> -               xhci2: usb@112a0000 {
> -                       compatible =3D "mediatek,mt8188-xhci", "mediatek,=
mtk-xhci";
> -                       reg =3D <0 0x112a0000 0 0x1000>,
> -                             <0 0x112a3e00 0 0x0100>;
> +               ssusb2: usb@112a1000 {
> +                       compatible =3D "mediatek,mt8188-mtu3", "mediatek,=
mtu3";
> +                       reg =3D <0 0x112a1000 0 0x2dff>, <0 0x112a3e00 0 =
0x0100>;
>                         reg-names =3D "mac", "ippc";
> -                       interrupts =3D <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0=
>;
> -                       phys =3D <&u2port2 PHY_TYPE_USB2>;
> -                       assigned-clocks =3D <&topckgen CLK_TOP_SSUSB_XHCI=
_3P>,
> -                                         <&topckgen CLK_TOP_USB_TOP_3P>;
> -                       assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>,
> -                                                <&topckgen CLK_TOP_UNIVP=
LL_D5_D4>;
> +                       ranges =3D <0 0 0 0x112a0000 0 0x3f00>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
> +                       interrupts =3D <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       assigned-clocks =3D <&topckgen CLK_TOP_USB_TOP_3P=
>;
> +                       assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>;
>                         clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>=
,
>                                  <&topckgen CLK_TOP_SSUSB_TOP_P3_REF>,
>                                  <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
>                         clock-names =3D "sys_ck", "ref_ck", "mcu_ck";
> +                       phys =3D <&u2port2 PHY_TYPE_USB2>;
> +                       wakeup-source;
> +                       mediatek,syscon-wakeup =3D <&pericfg 0x470 2>;
>                         status =3D "disabled";
> +
> +                       xhci2: usb@0 {
> +                               compatible =3D "mediatek,mt8188-xhci", "m=
ediatek,mtk-xhci";
> +                               reg =3D <0 0 0 0x1000>;
> +                               reg-names =3D "mac";
> +                               interrupts =3D <GIC_SPI 536 IRQ_TYPE_LEVE=
L_HIGH 0>;
> +                               assigned-clocks =3D <&topckgen CLK_TOP_SS=
USB_XHCI_3P>;
> +                               assigned-clock-parents =3D <&topckgen CLK=
_TOP_UNIVPLL_D5_D4>;
> +                               clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB=
_3P_XHCI>;
> +                               clock-names =3D "sys_ck";
> +                               status =3D "disabled";
> +                       };
>                 };
>
> -               xhci0: usb@112b0000 {
> -                       compatible =3D "mediatek,mt8188-xhci", "mediatek,=
mtk-xhci";
> -                       reg =3D <0 0x112b0000 0 0x1000>,
> -                             <0 0x112b3e00 0 0x0100>;
> +               ssusb0: usb@112b1000 {
> +                       compatible =3D "mediatek,mt8188-mtu3", "mediatek,=
mtu3";
> +                       reg =3D <0 0x112b1000 0 0x2dff>, <0 0x112b3e00 0 =
0x0100>;
>                         reg-names =3D "mac", "ippc";
> -                       interrupts =3D <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0=
>;
> -                       phys =3D <&u2port0 PHY_TYPE_USB2>;
> -                       assigned-clocks =3D <&topckgen CLK_TOP_SSUSB_XHCI=
_2P>,
> -                                         <&topckgen CLK_TOP_USB_TOP_2P>;
> -                       assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>,
> -                                                <&topckgen CLK_TOP_UNIVP=
LL_D5_D4>;
> +                       ranges =3D <0 0 0 0x112b0000 0 0x3f00>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
> +                       interrupts =3D <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       assigned-clocks =3D <&topckgen CLK_TOP_SSUSB_XHCI=
_2P>;
> +                       assigned-clock-parents =3D <&topckgen CLK_TOP_UNI=
VPLL_D5_D4>;
>                         clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>=
,
>                                  <&topckgen CLK_TOP_SSUSB_TOP_P2_REF>,
>                                  <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
>                         clock-names =3D "sys_ck", "ref_ck", "mcu_ck";
> -                       mediatek,syscon-wakeup =3D <&pericfg 0x460 2>;
> +                       phys =3D <&u2port0 PHY_TYPE_USB2>;
>                         wakeup-source;
> +                       mediatek,syscon-wakeup =3D <&pericfg 0x460 2>;
>                         status =3D "disabled";
> +
> +                       xhci0: usb@0 {
> +                               compatible =3D "mediatek,mt8188-xhci", "m=
ediatek,mtk-xhci";
> +                               reg =3D <0 0 0 0x1000>;
> +                               reg-names =3D "mac";
> +                               interrupts =3D <GIC_SPI 533 IRQ_TYPE_LEVE=
L_HIGH 0>;
> +                               assigned-clocks =3D <&topckgen CLK_TOP_US=
B_TOP_2P>;
> +                               assigned-clock-parents =3D <&topckgen CLK=
_TOP_UNIVPLL_D5_D4>;
> +                               clocks =3D <&pericfg_ao CLK_PERI_AO_SSUSB=
_2P_XHCI>;
> +                               clock-names =3D "sys_ck";
> +                               status =3D "disabled";
> +                       };
>                 };
>
>                 pcie: pcie@112f0000 {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch=
/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
> index a37cf102a6e9..fd977daa4185 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
> @@ -1011,13 +1011,25 @@ &u3phy2 {
>         status =3D "okay";
>  };
>
> +&ssusb0 {
> +       dr_mode =3D "host";
> +       vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +       status =3D "okay";
> +};
> +
>  &xhci0 {
>         status =3D "okay";
> +};
> +
> +&ssusb1 {
> +       dr_mode =3D "host";
>         vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +       status =3D "okay";
>  };
>
>  &xhci1 {
>         status =3D "okay";
> +       vdd-supply =3D <&usb_hub_fixed_3v3>;
>         vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
> @@ -1037,6 +1049,22 @@ hub_3_0: hub@2 {
>                 reset-gpios =3D <&pio 7 GPIO_ACTIVE_HIGH>;
>                 vdd-supply =3D <&usb_hub_fixed_3v3>;
>         };
> +
> +       port {
> +               xhci_ss_ep: endpoint {
> +                       remote-endpoint =3D <&typec_con_ss>;
> +               };
> +       };
> +};
> +
> +&ssusb2 {
> +       interrupts-extended =3D <&gic GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>,
> +                             <&pio 220 IRQ_TYPE_LEVEL_HIGH>;
> +       interrupt-names =3D "host", "wakeup";
> +
> +       dr_mode =3D "host";
> +       vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +       status =3D "okay";
>  };
>
>  &xhci2 {
> --
> 2.48.1
>
>

