Return-Path: <linux-kernel+bounces-233999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC56891C093
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832E51F21DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98D1BF334;
	Fri, 28 Jun 2024 14:12:24 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFB1BE85F;
	Fri, 28 Jun 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583944; cv=none; b=r9MqDbKSK8E3QuaFABVMwuk6qJT8CvgAUOucg5rh1uXzJbhq+zwFsyH6BiEqy5UxUJGUit53hISanMjar5WxyPNKjGlpR8KAW0OcjEpbNC9DMWgH1X4JyRTCdGwIX7VhThGt0LKL+jPmRSpHvM35iwC37ODaM49Kgin5JUjSb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583944; c=relaxed/simple;
	bh=fKfdTDLYO+Yg/On4eBGPkV3waHz9C5hERwkRHyo5Sa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eA555hCC8JN/e0RH0qed9JL/IR5zEVMgXTahZ+1xQwhUyFFARpgzZ6ORjvOZ4PEq8MV1fNOk6nVFpzBHQhiPYgnV3exk2hk6v8F7GCuMJVeHEoPvdV0SD2k7zuS/c0YB1+RKbX/uexmCCNTZrwaOgejN3iG4ONKrC+jpqlZ97cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sNCKg-0007ly-SZ; Fri, 28 Jun 2024 16:12:10 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Chukun Pan <amadeus@jmu.edu.cn>
Subject:
 Re: [PATCH 1/5] arm64: dts: rockchip: fix regulator and supply for Lunzn
 Fastrhino R6xS
Date: Fri, 28 Jun 2024 16:12:10 +0200
Message-ID: <3302842.44csPzL39Z@diego>
In-Reply-To: <20240628140104.551760-1-amadeus@jmu.edu.cn>
References: <20240628140104.551760-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Freitag, 28. Juni 2024, 16:01:00 CEST schrieb Chukun Pan:
> Make the regulator name and supply the same as those marked by schematics.
> 
> Fixes: c79dab407afd ("arm64: dts: rockchip: Add Lunzn Fastrhino R66S")
> Fixes: b9f8ca655d80 ("arm64: dts: rockchip: Add Lunzn Fastrhino R68S")
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

this needs to be split more please. Separate commits with more verbose
commit messages for:

- regulator renames
- the pmu-io-domain changes - why is moving vccio3-supply moving to
  the boards
- fixing usb regulators - vcc5v0_usb_host probably because that regulator
  does  not exist at all?


> ---
>  .../dts/rockchip/rk3568-fastrhino-r66s.dts    |  4 +++
>  .../dts/rockchip/rk3568-fastrhino-r66s.dtsi   | 28 +++++++------------
>  .../dts/rockchip/rk3568-fastrhino-r68s.dts    |  4 +++
>  3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> index 58ab7e9971db..b5e67990dd0f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> @@ -11,6 +11,10 @@ aliases {
>  	};
>  };
>  
> +&pmu_io_domains {
> +	vccio3-supply = <&vccio_sd>;
> +};
> +
>  &sdmmc0 {
>  	bus-width = <4>;
>  	cap-mmc-highspeed;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
> index 89e84e3a9262..82577eba31eb 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
> @@ -39,9 +39,9 @@ status_led: led-status {
>  		};
>  	};
>  
> -	dc_12v: dc-12v-regulator {
> +	vcc12v_dcin: vcc12v-dcin-regulator {
>  		compatible = "regulator-fixed";
> -		regulator-name = "dc_12v";
> +		regulator-name = "vcc12v_dcin";
>  		regulator-always-on;
>  		regulator-boot-on;
>  		regulator-min-microvolt = <12000000>;
> @@ -65,7 +65,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
>  		regulator-boot-on;
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&dc_12v>;
> +		vin-supply = <&vcc12v_dcin>;
>  	};
>  
>  	vcc5v0_sys: vcc5v0-sys-regulator {
> @@ -75,16 +75,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
>  		regulator-boot-on;
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usb_host";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
>  	};
>  
>  	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
> @@ -94,8 +85,9 @@ vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&vcc5v0_usb_otg_en>;
>  		regulator-name = "vcc5v0_usb_otg";
> -		regulator-always-on;
> -		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
>  	};
>  };
>  
> @@ -405,8 +397,8 @@ vcc5v0_usb_otg_en: vcc5v0-usb-otg-en {
>  &pmu_io_domains {
>  	pmuio1-supply = <&vcc3v3_pmu>;
>  	pmuio2-supply = <&vcc3v3_pmu>;
> -	vccio1-supply = <&vccio_acodec>;
> -	vccio3-supply = <&vccio_sd>;
> +	vccio1-supply = <&vcc_3v3>;
> +	vccio2-supply = <&vcc_1v8>;
>  	vccio4-supply = <&vcc_1v8>;
>  	vccio5-supply = <&vcc_3v3>;
>  	vccio6-supply = <&vcc_1v8>;
> @@ -460,7 +452,7 @@ &usb2phy0 {
>  };
>  
>  &usb2phy0_host {
> -	phy-supply = <&vcc5v0_usb_host>;
> +	phy-supply = <&vcc5v0_sys>;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
> index e1fe5e442689..a3339186e89c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
> @@ -102,6 +102,10 @@ eth_phy1_reset_pin: eth-phy1-reset-pin {
>  	};
>  };
>  
> +&pmu_io_domains {
> +	vccio3-supply = <&vcc_3v3>;
> +};
> +
>  &sdhci {
>  	bus-width = <8>;
>  	max-frequency = <200000000>;
> 





