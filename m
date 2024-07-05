Return-Path: <linux-kernel+bounces-242501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD69288F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D724BB219D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E2C14A616;
	Fri,  5 Jul 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JJcHS+pp"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06861E867;
	Fri,  5 Jul 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183791; cv=none; b=mMS0eaLzNr8RbnlxO+RdOxlpsrn/CxEgFZCOndJ1RLWUoXi0UIc54hopw6kh8BVRLXEnIvlt1DqNFsz9KCpaqJ2nCQZCfSWsqDiPv4bWzrZlN737hO6lbQ/S6x/Hi8dcNtxPeYCZHiBfYlVztCu4+w51vP0h0CSmjZsQhqCEE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183791; c=relaxed/simple;
	bh=D4tjuDbhWgyOTIWHN/OgVNFB7Aucn44YcNtzcZ384EA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ronulOSJ7PQlb2ym6C8t6GTZPt5CQnL4xDJxeZW/k417zU6gaEsWopILnDI1vcPulfN8ykqeGxr640AS+m/o7VuLmzjPhQ4lTojpajUQ6ThgP6fcH3BzGxZxv16uPFGKJ8ajBv7NfM6i84DlCUltVwVLGkqTfs9zLPwGoiPoEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JJcHS+pp; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D852AFF802;
	Fri,  5 Jul 2024 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720183782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw/k0lzZ2dQGrpiFuHsnrurwkGYwwFuaLcGW35wbvbs=;
	b=JJcHS+ppkqtOM4SsJIsRd/WOiZkwnWGNA1mWxYW9ey1k9Cf/5/wbfWSSTZkwXuGuUbORfm
	8SQbX9L2hoi0coBOkY+Pwn5IKUAfqm8FZQfDUvsO1OpMP9lDM9WI5FTmTIOcFUX0Sx6dWq
	thXVfKcnhL9D0erS+XXYF2yLvDFlb31/LgEXDyLqrpJXXujGFWMnYjJEAtKEtgmnXD2UMY
	FXR0zvrGdnanpjli6dE6/xwctHD06OCcA81NqNkeKCHRsIZylVmss2g9WKrwgrnmIMLiL2
	9MuNdD8XZyhlNTX/rW8pAPI6NYMDOeKFJA7UfkDPUr2JX2mpghQ0pzZuzVwRmg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
 <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: armada-3720: align LED node name with
 bindings
In-Reply-To: <20240701150340.560243-2-krzysztof.kozlowski@linaro.org>
References: <20240701150340.560243-1-krzysztof.kozlowski@linaro.org>
 <20240701150340.560243-2-krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 14:49:41 +0200
Message-ID: <875xtkj95m.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Bindings expect the LED node names to follow certain pattern, see
> dtbs_check warnings:
>
>   armada-3720-gl-mv1000.dtb: leds: 'power', 'vpn', 'wan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> index 07c14bf04b83..56930f2ce481 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> @@ -57,17 +57,17 @@ switch {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		vpn {
> +		led-vpn {
>  			label = "green:vpn";
>  			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
>  		};
>  
> -		wan {
> +		led-wan {
>  			label = "green:wan";
>  			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
>  		};
>  
> -		led_power: power {
> +		led_power: led-power {
>  			label = "green:power";
>  			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
>  			default-state = "on";
> -- 
> 2.43.0

