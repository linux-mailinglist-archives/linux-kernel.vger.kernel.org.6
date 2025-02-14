Return-Path: <linux-kernel+bounces-515611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2801EA366AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6818188DA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2791946DA;
	Fri, 14 Feb 2025 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="h2oPIxc5"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058141519AB;
	Fri, 14 Feb 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739563665; cv=none; b=jNRLghbNO9BeqATvN91gJV7nEgks5A9QeFKTr+JlIP0NxBCTPkRaXT+e7vZHxX741kKHQXnqfvUxZa/VPdYB9BaR2Dq1z5bnTduSSHzySsa0pGNR8pi31Z3ko/LhL4BLU5mkrZ/1QAlp47ubZaUE4/xqy3nWfYnw0nD0q4GUU1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739563665; c=relaxed/simple;
	bh=B2d+rOOv+/s7m+3dS9euJbi0GQRu6QtarU8RuNPfrsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ex1vwJeito1vnvw8Oi1cmSeJEEdoqDMMTqIYAwBgp1uc6UyvIUvqIK9A1MQ7WfRJVSs3j78BuMrJXMPI30SFQzkli3DbtHxusQxkl1Rm0pnovXt9pl74rARacw1bZkjc/0rt8Ejx/X60RiBDWyg1Xp6OMOz2OOXxfJGIwB6X/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=h2oPIxc5; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3gA+i0CmP9DnNBxjfP0Se+gQOkkXX1tuBuCnmXo7jZk=; b=h2oPIxc5LSQ9HrqIpwYraIWK2d
	OVZnGGtUhj1zTYD3LrBiEDjWwkR36EKaperNnbYz9XKgtflB4ct53f7MvAUPjNtySI0+yXdYXgcbY
	g+16clC//0zdgygviKbeJkmU0asTKPLnMGeCNhAP5MKNFGHgJXuqBziRG9q3u+/pHVO+59fNPbZ4n
	eraqJTdMJyI62Zb6EE28ucaE/YHoxiUHijc5KzLiDu2mVn8MjlZCBeQxda/5fqqNO44ps1ppPPDBd
	OTnibedW2U6c6ESyD5jKyBA2I+RuplsWZU26A/ORoPDNb/w1oyRZkZZRlVe9iewvru+SRalFMYpRh
	o1Fw296Q==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tj1y0-00026P-Tb; Fri, 14 Feb 2025 21:07:16 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>,
 Tim Lunn <tim@feathertop.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Stephen Chen <stephen@radxa.com>, Elon Zhang <zhangzj@rock-chips.com>,
 Alexey Charkov <alchark@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
Subject:
 Re: [PATCH v3 2/2] arm64: dts: rockchip: Add Radxa ROCK 4D device tree
Date: Fri, 14 Feb 2025 21:07:15 +0100
Message-ID: <2629121.1xdlsreqCQ@diego>
In-Reply-To: <20250214152119.405803-3-detlev.casanova@collabora.com>
References:
 <20250214152119.405803-1-detlev.casanova@collabora.com>
 <20250214152119.405803-3-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Detlev,

all the style nitpick I'd changed myself, but the cpu-supplies did throw me
off, see below.


Am Freitag, 14. Februar 2025, 16:19:34 MEZ schrieb Detlev Casanova:
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> new file mode 100644
> index 0000000000000..822abb82fae40
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> @@ -0,0 +1,650 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
> + *

empty comment line can probably go away

> +	vcc_12v0_dcin: regulator-vcc-12v0-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_12v0_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc_5v0_sys: regulator-vcc-5v0-sys {

alphabetical sorting, by node-name please, so
regulator-vcc-3v3* comes before regulator-vcc-5v0* etc

Goes for all regulator-* nodes of course.

> +	vcc_3v3_pcie: regulator-vcc-3v3-pcie {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3_pcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <5000>;
> +		vin-supply = <&vcc_5v0_sys>;
> +	};
> +
> +	vcc_5v0_host: regulator-vcc-5v0-host {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_host";
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&vcc_5v0_device>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_host_pwren>;

both of the above, alphabetical sorting of properties please

> +	};
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};

What happened to the supplies of the other cores?
cpu_l1 - cpu_l3 probably need the same reference as above.

Who is powering the cpu_b* cores?


> +&i2c1 {
> +	status = "okay";
> +
> +	pmic@23 {
> +		compatible = "rockchip,rk806";
> +		reg = <0x23>;
> +
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_pins
> +			     &rk806_dvs1_null
> +			     &rk806_dvs2_null
> +			     &rk806_dvs3_null>;
> +
> +		system-power-controller;
> +
> +		vcc1-supply = <&vcc_5v0_sys>;
> +		vcc2-supply = <&vcc_5v0_sys>;
> +		vcc3-supply = <&vcc_5v0_sys>;
> +		vcc4-supply = <&vcc_5v0_sys>;
> +		vcc5-supply = <&vcc_5v0_sys>;
> +		vcc6-supply = <&vcc_5v0_sys>;
> +		vcc7-supply = <&vcc_5v0_sys>;
> +		vcc8-supply = <&vcc_5v0_sys>;
> +		vcc9-supply = <&vcc_5v0_sys>;
> +		vcc10-supply = <&vcc_5v0_sys>;
> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> +		vcc12-supply = <&vcc_5v0_sys>;
> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> +		vcca-supply = <&vcc_5v0_sys>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;

alphabetical sorting ... gpio* farther up please.


> +&uart0 {
> +	pinctrl-0 = <&uart0m0_xfer>;
> +	status = "okay";
> +};
> +
> +&combphy1_psu {
> +	status = "okay";
> +};

phandles also sorted alphabetical please

> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&usb_drd1_dwc3 {
> +	dr_mode = "host";
> +	status = "okay";
> +};

Thanks a lot
Heiko




