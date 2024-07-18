Return-Path: <linux-kernel+bounces-256082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF609348C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729FC1C211F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430576056;
	Thu, 18 Jul 2024 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKBZ5CYN"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B02CCA3;
	Thu, 18 Jul 2024 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287622; cv=none; b=EAJ6jT4JJ4uE24mWsQYaFT2FDYoC0OoBl+yZ+1ZK7EXYHvK1/9S4fDjciHppQ51K4OIRCQO2+axtb1YTceOamXLhv/T+usgekeTC0ejnzR42hOTVz17uTW7plXh4r7IDRRWk3AAFzyvrYYXQddlR8eM5zxDiusB2El6euGf5cV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287622; c=relaxed/simple;
	bh=GIsncHVy76pTxeEgDEjyoILkmmFXZxoE2s5n3GlSYPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EG4KIILakfjFicVZfo/gbdKGgZYGQXRiN3ZO5aoXVrT5gvde0IrPAZCCPsFizbBwEXlZuatB++0giN++dM+V+z7lUa54ZHZG2KFCOFc+EuQwFUapS0VKaq+6FwQW0UifY3ivZYte8PtqatvV+1glScXzjLqs3BP4y6zZIkV+xh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKBZ5CYN; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d31ef2c73cso246090eaf.3;
        Thu, 18 Jul 2024 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721287620; x=1721892420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WSvSUpNQZRp2YKhgVtO8QG42U2eOtSDdmhMTp/cDq/E=;
        b=EKBZ5CYNHs/oix7VpCnC5sJt+oSPnD7zB1Ed5ESJgbZB+uIFOfRtDUoyQJ/iTpv41e
         YDTNUfb1ZcTR6WWK07IqPAJdcHUFbmUnacqyjey+3hjuTK/5JVoPLsUc+GT9hhNAHlu5
         x43gJ7XEp66DzOSe/sHiUfBTEW5z985waVtPD10VOXLBJlLTuP6hplmPu3HjrIRuV9WF
         LquEDBkOvYEw39z+E2RBoSfxMV+4MnJK441MbdMt7/UpenTwuclpQ9d6M0SNNukmy5TO
         a0s7AC0I1e1vO1sUdTBXkZ2KWLud5fZagfb2XWYM/C2Zxx39zXIqSZ8AfuN4WhoRtqHg
         nxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721287620; x=1721892420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSvSUpNQZRp2YKhgVtO8QG42U2eOtSDdmhMTp/cDq/E=;
        b=rVciAbEHcEtrYmTbR4qwRZQ6/6xff2SlP7mY0eDHhFc9w0GuSXzZDrBgfo8kD53n/U
         LIzNcEqXhA1Nol6We0btc8htEVAxL/hjIsxW+blkfVs+KyIUA4W9ZG25vxkhbO+TTSHr
         BS/rKh12+FLFm7DW3lNn+pT28LYjZKNEA9dE5w6bAQimUdo86eJ2uyh5YkvaAZBNatFT
         zemb3Ki/cEem1ODmZRKqzygfb35248kxj6YkB7seN7zaf8840SM4s+7Kr+fuqHgcejPN
         Az4XR7Xntcg2SfwA6U4ueUwz593noo3Z9KVqpFJBMDiRXIVu5XJsRV0recDQf6FMeFeT
         eS5w==
X-Forwarded-Encrypted: i=1; AJvYcCW6BojyzLYFdBuyAD+Es4IopHoqfE3If0OFZOovPjF82PMxztknNiGHFq7uOjdeLPiyRHY5ySQ7Po5Li15sI3s+2BYRNnkFmA4SMwFpopo2ZRcc4zmwRTvKmLsv/MjCvSuTNRb26f25xZ/tKcCYHe+BNXr4iqqeLthz/jNUhOeLIWhoeA==
X-Gm-Message-State: AOJu0YzVEH0QQn65UM7XHn6/HieOmTlFWilH3nNsVUkCFz8LIaOFREzo
	byRp/khU7K92XyadxMvRpgBJFtx/1SuU9DEjo/t79Qa0bIQx+fm76TJL6krH+H29zJZ0YTFUvOv
	6256A27Pb0jYvOXM6wRniK9H8hzY=
X-Google-Smtp-Source: AGHT+IHAWI3Xg3mDtfREDUCxHyoF4gTS2b1DQd8tHuhgBypbHELjTsim3tbP/m0LxVCn39FYamneM1MkEQiw2eIcPmQ=
X-Received: by 2002:a05:6820:2017:b0:5c6:4807:2d1f with SMTP id
 006d021491bc7-5d41d3b833dmr5554884eaf.8.1721287620137; Thu, 18 Jul 2024
 00:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715110251.261844-1-heiko@sntech.de> <20240715110251.261844-4-heiko@sntech.de>
In-Reply-To: <20240715110251.261844-4-heiko@sntech.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 18 Jul 2024 12:56:43 +0530
Message-ID: <CANAwSgS_ZaEkt5-kKud9OwdN4za+xvW5SoBr34EmOdU2OQJWnw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: fix the pcie refclock
 oscillator on Rock 5 ITX
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Heiko,

On Mon, 15 Jul 2024 at 16:35, Heiko Stuebner <heiko@sntech.de> wrote:
>
> The Rock 5 ITX uses two PCIe controllers to drive both a M.2 slot and its
> SATA controller with 2 lanes each. The supply for the refclk oscillator is
> the same that supplies the M.2 slot, but the SATA controller port is
> supplied by a different rail.
>
> This leads to the effect that if the PCIe30x4 controller for the M.2
> probes first, everything works normally. But if the PCIe30x2 controller
> that is connected to the SATA controller probes first, it will hang on
> the first DBI read as nothing will have enabled the refclock before.
>

I just checked the rk3588-rock-5-itx.dts in the linux-next.
You have not enabled sata0 and sata2, which might be the problem
for the SATA controller not getting initialized.

Thanks
-Anand

> Fix this by describing the clock generator with its supplies so that
> both controllers can reference it as needed.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 38 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> index d0b922b8d67e8..37bc53f2796fc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> @@ -72,6 +72,15 @@ hdd-led2 {
>                 };
>         };
>
> +       /* Unnamed voltage oscillator: 100MHz,3.3V,3225 */
> +       pcie30_port0_refclk: pcie30_port1_refclk: pcie-voltage-oscillator {
> +               compatible = "voltage-oscillator";
> +               #clock-cells = <0>;
> +               clock-frequency = <100000000>;
> +               clock-output-names = "pcie30_refclk";
> +               vdd-supply = <&vcc3v3_pi6c_05>;
> +       };
> +
>         fan0: pwm-fan {
>                 compatible = "pwm-fan";
>                 #cooling-cells = <2>;
> @@ -146,13 +155,14 @@ vcc3v3_lan: vcc3v3_lan_phy2: regulator-vcc3v3-lan {
>                 vin-supply = <&vcc_3v3_s3>;
>         };
>
> -       vcc3v3_mkey: regulator-vcc3v3-mkey {
> +       /* The PCIE30x4_PWREN_H controls two regulators */
> +       vcc3v3_mkey: vcc3v3_pi6c_05: regulator-vcc3v3-pi6c-05 {
>                 compatible = "regulator-fixed";
>                 enable-active-high;
>                 gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pcie30x4_pwren_h>;
> -               regulator-name = "vcc3v3_mkey";
> +               regulator-name = "vcc3v3_pi6c_05";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
>                 startup-delay-us = <5000>;
> @@ -513,6 +523,18 @@ &pcie30phy {
>
>  /* ASMedia ASM1164 Sata controller */
>  &pcie3x2 {
> +       /*
> +        * The board has a "pcie_refclk" oscillator that needs enabling,
> +        * so add it to the list of clocks.
> +        */
> +       clocks = <&cru ACLK_PCIE_2L_MSTR>, <&cru ACLK_PCIE_2L_SLV>,
> +                <&cru ACLK_PCIE_2L_DBI>, <&cru PCLK_PCIE_2L>,
> +                <&cru CLK_PCIE_AUX1>, <&cru CLK_PCIE2L_PIPE>,
> +                <&pcie30_port1_refclk>;
> +       clock-names = "aclk_mst", "aclk_slv",
> +                     "aclk_dbi", "pclk",
> +                     "aux", "pipe",
> +                     "ref";
>         pinctrl-names = "default";
>         pinctrl-0 = <&pcie30x2_perstn_m1_l>;
>         reset-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> @@ -522,6 +544,18 @@ &pcie3x2 {
>
>  /* M.2 M.key */
>  &pcie3x4 {
> +       /*
> +        * The board has a "pcie_refclk" oscillator that needs enabling,
> +        * so add it to the list of clocks.
> +        */
> +       clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> +                <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> +                <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>,
> +                <&pcie30_port0_refclk>;
> +       clock-names = "aclk_mst", "aclk_slv",
> +                     "aclk_dbi", "pclk",
> +                     "aux", "pipe",
> +                     "ref";
>         num-lanes = <2>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&pcie30x4_perstn_m1_l>;
> --
> 2.39.2
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

