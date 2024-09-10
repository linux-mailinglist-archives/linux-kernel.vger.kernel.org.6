Return-Path: <linux-kernel+bounces-322669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B606A972C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640032863A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB43E17D35C;
	Tue, 10 Sep 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Z0+ZSNu+"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8014A4C3;
	Tue, 10 Sep 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956552; cv=none; b=bLM23ChUnZMwy1QkDsPS+SO9q8ARWKUOXvGxsH+E9KgKUQrUnuPYDVZaK6TX6ZD5y2b4xSScLJsOtnYJigniEjKyad3Y10xXYbdnULTT7PsQmpHbgT8yz9U8BJre2wjf51s4XnBnsZMrb1X4cklyMSaQw/fr4NXD7x4xT+Ra4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956552; c=relaxed/simple;
	bh=brbbBZUTXWY+39+PQXYFm1z/YKNb5IjgjWNxs8n4dzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IINDwCMqhRNwKP7whKQRvv/XFc6RayS5r16TDX20ZMWOxpRGlOixCcaplfpRgz9HwXdrHZfOwkd/MIMtX2N6Tj6G0m0ZBE/M9JM11Wp4Dy9Yklbo7jA9CnQNGUceRHhBLsCWp46FQ8wbt0mUn7MnXzNNLSmA+1lh/W3zgK33u+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Z0+ZSNu+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mLX/DIBoOrfBorbkFkl8rvdIrIaBgzNT/RjG578VqDk=; b=Z0+ZSNu+CH1kpCtu+Ofb0YDimB
	hiNZN+0yRUXHgourSZWIgvLn5gaa5kepVpkm3pSRA1fpmFgfQeXI18AcVaGO3jLAfYF5IwCmnVv00
	R/mM8Di9BDh62z3NsPkgB8I9rTKh4MqCZIM/g6ODKkPOXEO7NKRTPfpB/+l1mh/xYUUq/rJwqdedK
	jn712slwdtBP7WiYJVRTnNrjOnPaElxswEZdyfEhDiiOnY/2p/IeC4ysCgn4dsW7p40dhP83xziua
	IahisU2HQd/3FRn/mJ8BKycXTPRyDwLeQc24PIj6Biyix5IRdgbc0Tv2OPwlbhJqP535OMW7smks+
	Sex0uiWw==;
Received: from i53875a02.versanet.de ([83.135.90.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1snw8R-000245-IZ; Tue, 10 Sep 2024 10:22:03 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 macromorgan@hotmail.com, jonas@kwiboo.se, tim@feathertop.org,
 knaerzche@gmail.com, efectn@protonmail.com, andyshrk@163.com,
 jagan@edgeble.ai, dsimic@manjaro.org, megi@xff.cz,
 sebastian.reichel@collabora.com, alchark@gmail.com,
 boris.brezillon@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject:
 Re: [PATCH v1 2/2] arm64: dts: rockchip: Add support for rk3588s evb1 board
Date: Tue, 10 Sep 2024 10:24:25 +0200
Message-ID: <1778254.M3retTD8dW@diego>
In-Reply-To: <20240910030951.3670653-3-damon.ding@rock-chips.com>
References:
 <20240910030951.3670653-1-damon.ding@rock-chips.com>
 <20240910030951.3670653-3-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 10. September 2024, 05:09:51 CEST schrieb Damon Ding:
> Specification:
> - Rockchip RK3588S
> - RK806-2x2pcs + DiscretePower
> - eMMC5.1 + SPI Flash
> - Micro SD Card3.0
> - 1 x Typec3.0 + 2 x USB2 HOST
> - 1 x 1Lane PCIE2.0 Connector(RC Mode)
> - Headphone output
> - Array Key(MENU/VOL+/VOP-/ESC), Reset, Power on/off Key
> - 6 x SARADC
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---

[...]

> +	analog-sound {
> +		compatible = "simple-audio-card";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hp_detect>;
> +		simple-audio-card,name = "RK3588 EVB1 Audio";
> +		simple-audio-card,aux-devs = <&amp_headphone>, <&amp_speaker>;
> +		simple-audio-card,bitclock-master = <&masterdai>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&masterdai>;
> +		simple-audio-card,hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
> +		simple-audio-card,mclk-fs = <256>;
> +		simple-audio-card,pin-switches = "Headphones", "Speaker";
> +		simple-audio-card,routing =
> +			"Speaker Amplifier INL", "LOUT2",
> +			"Speaker Amplifier INR", "ROUT2",
> +			"Speaker", "Speaker Amplifier OUTL",
> +			"Speaker", "Speaker Amplifier OUTR",
> +			"Headphones Amplifier INL", "LOUT1",
> +			"Headphones Amplifier INR", "ROUT1",
> +			"Headphones", "Headphones Amplifier OUTL",
> +			"Headphones", "Headphones Amplifier OUTR",
> +			"LINPUT1", "Onboard Microphone",
> +			"RINPUT1", "Onboard Microphone",
> +			"LINPUT2", "Microphone Jack",
> +			"RINPUT2", "Microphone Jack";
> +		simple-audio-card,widgets =
> +			"Microphone", "Microphone Jack",
> +			"Microphone", "Onboard Microphone",
> +			"Headphone", "Headphones",
> +			"Speaker", "Speaker";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s0_8ch>;
> +		};
> +
> +		masterdai: simple-audio-card,codec {
> +			sound-dai = <&es8388>;
> +			system-clock-frequency = <12288000>;
> +		};
> +	};
> +
> +	amp_headphone: headphone-amplifier {
> +		compatible = "simple-audio-amplifier";
> +		enable-gpios = <&gpio4 RK_PA4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&headphone_amplifier_en>;
> +		sound-name-prefix = "Headphones Amplifier";
> +	};
> +
> +	amp_speaker: speaker-amplifier {
> +		compatible = "simple-audio-amplifier";
> +		enable-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&speaker_amplifier_en>;
> +		sound-name-prefix = "Speaker Amplifier";
> +	};
> +
> +	backlight: backlight {

please sort nodes by node name ... so "backlight" after "analog-sound"

> +		compatible = "pwm-backlight";
> +		power-supply = <&vcc3v3_lcd_edp>;
> +		pwms = <&pwm12 0 25000 0>;
> +	};
> +
> +	combophy_avdd0v85: combophy-avdd0v85-regulator {

generally the naming convention for regulator nodes now is
regulator-* ... so regulator-combophy-avdd0v85 here
and similar for others below.


Heiko



