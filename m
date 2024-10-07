Return-Path: <linux-kernel+bounces-353469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAF1992E42
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B64B1C231E3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3B1D6DCE;
	Mon,  7 Oct 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="h+7LboR+"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610161D6DDA;
	Mon,  7 Oct 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309885; cv=none; b=WSC6PP+oXQ4i5XDwzJXwkxaG8IKtYnw3zwM8s9vJ2t+5eNAldAmbhv04e3EKkWSjbf/Cf5RQ/fqZvSaRFis9pwHu+rtJ2xNPGQmaOVgxJ/aaeWff2+1tlq9TTeJ4A3UBlTHGgkDG/8adgcJORgBTlFvbmdSpSxpOaDAEGW87oms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309885; c=relaxed/simple;
	bh=T1P99bugCBcO2okWQtwTvyA2FgpgJplLYyHmUJfl0zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvmcTST5Zx3ort/el1vcW0uhgBIAE3Ppp4Mzm6M4eHiLl3YC0nYrLI7VigS2UCYKVXu+QIunICFjBkQGXB2gkM5U3VqYMdm6Qn18yYFVeMX8xXmIDUrX1KcaG3mflwSA4WC96f1GRKI7X5Xac+SD+CkCxtHFeP6T/KBapOEqioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=h+7LboR+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DzguuGqpgpDEWTK10Pwmg4Td55x7gkXzdoaaK8vp4B0=; b=h+7LboR+xFiMm7PhXGimd0RLed
	d9KeCZHCCsGJLq3O0N5MZ9OnGbU/97ZuaCcd0lmNjw6mzbzpQjj6C+Dor8o5yEuG/eyV2LI/WFlkH
	jvhDnBz13sD+DbtD3wSuzj6ErfBWg7HrypsglrgcSiyRhWV+ylydeIOAoipMDIYhtnmpb/1ZAY/H3
	0gFVuUS/DzbfOmqJqLWaRZeEoLe8N49gdwDuA5LQ+Vj389/M9obU7XOGp8GoAf2JGCZigp96X4bI5
	S5iz/jNFcgzEuhtXZ+O/uzlUNx6B6YNAJ2u13QWTyHZbk7Wor7rPJJnqkN1X2pKRyhcDy7oOSQYeW
	jV3Wznhw==;
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sxoLe-0000sG-Gr; Mon, 07 Oct 2024 16:04:30 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Diederik de Haas <didi.debian@cknow.org>
Cc: Diederik de Haas <didi.debian@cknow.org>,
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 4/4] arm64: dts: rockchip: Fix reset-gpios prop on brcm BT nodes
Date: Mon, 07 Oct 2024 16:04:29 +0200
Message-ID: <12534438.O9o76ZdvQC@diego>
In-Reply-To: <20241007105657.6203-6-didi.debian@cknow.org>
References:
 <20241007105657.6203-2-didi.debian@cknow.org>
 <20241007105657.6203-6-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey :-) ,

Am Montag, 7. Oktober 2024, 12:28:19 CEST schrieb Diederik de Haas:
> Except for some compatibles, the "brcm,bluetooth.yaml" binding doesn't
> allow the 'reset-gpios' property, so replace the invalid ones with the
> 'shutdown-gpios' property.

this probably needs more explanation in the commit message, because
by name I'd expect reset and shutdown being different functionalities.

But for these cases, things should be good, simply because when looking
at the bt_enable_h pinctrl, that pin really provides the shutdown
functionality.


Heiko


> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> index 7381bb751852..100a2774bbb5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> @@ -686,9 +686,9 @@ bluetooth {
>  		clock-names = "lpo";
>  		device-wakeup-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
>  		host-wakeup-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
> -		reset-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
>  		pinctrl-0 = <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
>  		pinctrl-names = "default";
> +		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
>  		vbat-supply = <&vcc_wl>;
>  		vddio-supply = <&vcca_1v8_pmu>;
>  	};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
> index d09e6542e236..3e0cbfff96d8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
> @@ -402,9 +402,9 @@ bluetooth {
>  		clock-names = "lpo";
>  		device-wakeup-gpios = <&gpio2 RK_PB2 GPIO_ACTIVE_HIGH>;
>  		host-wakeup-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		reset-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&bt_host_wake_h &bt_reg_on_h &bt_wake_host_h>;
> +		shutdown-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
>  		vbat-supply = <&vcc_3v3>;
>  		vddio-supply = <&vcc_1v8>;
>  	};
> 





