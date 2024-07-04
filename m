Return-Path: <linux-kernel+bounces-241653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06084927DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB72B23CC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8B13958F;
	Thu,  4 Jul 2024 19:12:18 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2D54660;
	Thu,  4 Jul 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120338; cv=none; b=t2lmfwFJJQZAl4UwH5fURsPzMYJhQNOOh68ojoEfQoo1+6dLwYiXZOCWlgfFecI+Wr927Av2PshoqyFQCWOwqATmZkOfm6ybZJAMjqbMbWBestq10kFLZnwKNN2n1202prkhEUJlTiFEAPW0NhXpgCMEBW/FInGWlMF29daOWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120338; c=relaxed/simple;
	bh=M6/LlRP2nHP5mIfhhKoIGQGpaZOEBl6b/oqLipJ1cOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVcYNbPT/5Srx988+2U+9eM3sA9Tv2dQQsEl0cunS1A7cjaw1cI/1JYSAKQWCBAIR6PAuugFZGqea4RuXPUdzkiJYi2k7pfL+URYc+JzHILe80lBmHiyxSfr9uja/J8sFmr7fosgkGAfsUzujh+xU+10EHudFmZst00luA1VSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPRsJ-0005zp-Ho; Thu, 04 Jul 2024 21:12:11 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Chukun Pan <amadeus@jmu.edu.cn>
Subject:
 Re: [PATCH v2 7/9] arm64: dts: rockchip: use generic Ethernet PHY reset
 bindings for Lunzn Fastrhino R68S
Date: Thu, 04 Jul 2024 21:12:10 +0200
Message-ID: <2210411.C4sosBPzcN@diego>
In-Reply-To: <20240630150010.55729-8-amadeus@jmu.edu.cn>
References:
 <20240630150010.55729-1-amadeus@jmu.edu.cn>
 <20240630150010.55729-8-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Sonntag, 30. Juni 2024, 17:00:08 CEST schrieb Chukun Pan:
> Replace the deprecated snps,reset-xxx bindings to the generic Ethernet
> PHY reset GPIO bindings. Also updates the delays based on the vendor
> recommendations.
> 
> Fixes: b9f8ca655d80 ("arm64: dts: rockchip: Add Lunzn Fastrhino R68S")
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  .../boot/dts/rockchip/rk3568-fastrhino-r68s.dts    | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
> index ce2a5e1ccefc..02d966d218fd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
> @@ -39,10 +39,6 @@ &gmac0_tx_bus2
>  		     &gmac0_rx_bus2
>  		     &gmac0_rgmii_clk
>  		     &gmac0_rgmii_bus>;
> -	snps,reset-gpio = <&gpio1 RK_PB0 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	/* Reset time is 15ms, 50ms for rtl8211f */
> -	snps,reset-delays-us = <0 15000 50000>;
>  	tx_delay = <0x3c>;
>  	rx_delay = <0x2f>;
>  	status = "okay";
> @@ -61,10 +57,6 @@ &gmac1m1_tx_bus2
>  		     &gmac1m1_rx_bus2
>  		     &gmac1m1_rgmii_clk
>  		     &gmac1m1_rgmii_bus>;
> -	snps,reset-gpio = <&gpio1 RK_PB1 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	/* Reset time is 15ms, 50ms for rtl8211f */
> -	snps,reset-delays-us = <0 15000 50000>;
>  	tx_delay = <0x4f>;
>  	rx_delay = <0x26>;
>  	status = "okay";
> @@ -76,6 +68,9 @@ rgmii_phy0: ethernet-phy@1 {
>  		reg = <0x1>;
>  		pinctrl-0 = <&eth_phy0_reset_pin>;
>  		pinctrl-names = "default";
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;

what's the reason behind the changed timings?

The original comment stated,
	/* Reset time is 15ms, 50ms for rtl8211f */
so that timing change needs an explanation please :-)

Thanks
Heiko

> +		reset-gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_LOW>;
>  	};
>  };
>  
> @@ -85,6 +80,9 @@ rgmii_phy1: ethernet-phy@1 {
>  		reg = <0x1>;
>  		pinctrl-0 = <&eth_phy1_reset_pin>;
>  		pinctrl-names = "default";
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio1 RK_PB1 GPIO_ACTIVE_LOW>;
>  	};
>  };
>  
> 





