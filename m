Return-Path: <linux-kernel+bounces-517082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB84A37BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22AA188D952
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA941885B4;
	Mon, 17 Feb 2025 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mloevqol"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34133183098
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775953; cv=none; b=oMOIFHK/RjJP/cgfASEZ5E9F36VryUl6WTp9bRMb4RshdwJJ5mbXcSho2CV6jnOAZ6CLH6eZvYNosPruuwMP7m5tYklTWbooGce8rwKIxthKNI03R1LHJv0P0ukGXXV6C6NdNcl1SUlnA96Lju65CITVJXTvYL5XIpXW8Ysd0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775953; c=relaxed/simple;
	bh=Q917az6uxMlj1UneckNovGmKwgFGSq/pCHX6IXoK7jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkgCm2FKHSt8StAJRyt1MBEyOdZBynZb6WocOexGW5C4naot0RhQU+yoV04m6R8Bg4rOhJtWlVrJazpUPVd+AM/bU6sXKADBFuYcWMEVkzOu5+0cFALloOcu4kegJ1dCa8hRCY0P2pqBT4RyYPed5VvzFoEYF26XC2IqBZQp3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=mloevqol; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaeec07b705so606038766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739775949; x=1740380749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDTAaNjPvymL+5POOcQD3DHgYRwOtZyMkyZgmLHZc7Y=;
        b=mloevqolSJwdXaqJAwAkwf9aq5HwulUkyRGmvcByCgRcQNdAqB25banoZzngUBNmIW
         pZ5GRdLfTpUc3I0pl2BEduP+qXG8bu2Z4oTw+p+5zGplMSlOIkmu4XZhsrwfZz2sJY0P
         OmiLV7XahCKOV0wwYWRqE0C6T9Nt8TDGqf/AfxFrHgECFZIijDQQj6BVFboGjLQJQYhn
         BRdgNC7+xLFH0EekXsjO7UAFGYwg8CEiAjb2njJzrd9Q/4l0ffzvY1aXoZjsEi7JOXka
         Wq6G0LTW4J3WxQMENMYa5OfI0lLdoE2iBsIygV/jo6gWjJh+nTvtzyXzxKd/L2gReQBH
         UZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739775949; x=1740380749;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDTAaNjPvymL+5POOcQD3DHgYRwOtZyMkyZgmLHZc7Y=;
        b=FUFSAGEixWBMDw7OVvhJNjwlubaATvvt2iPRkD+blr0QfZBW0QTYsH7xXThxVZ5Ju6
         fAyzVMS8i2cyf7tO1CUsEFVYuwSCUdq17+drYFX6m7ITjp8ZhPfxSc1UzykD+Bui0wJH
         BuCYxD6HYmu1hfU6mP6SPXvicJVL5+oD5iM99OUQMex6AM/pt8BYDqZdzfEre8XPb771
         CrvyL/iiaOA0E7oSkj48Kj35fsa5kCKNw/W6fJ1veKjA3EHmH97sZqBgCR+O+dvu8RNt
         53h/ThclcraHfBaVc7IhZ9SziyCEA8ps8kOHacCLXZX+CYYSbrhueuaufshm/zNV6GKe
         kSng==
X-Forwarded-Encrypted: i=1; AJvYcCU8mvucrpOK1g0Kp4s1M/B92ju3rnrEqAtnZBxyOwPezwZ4l1BLmAzPvwBn2RUv/+2e++qbeNoWvmMscfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LWtGNuUQbIytP7dW+BhEUoIxKMQMPDjKrwtSSbJmchhA/xpv
	Bn2Mc1TT4nvn0yTF8sFLAvRcpQhTxBB1Yx6qGjOSUG6ZBRJYIQrX7fuGHbKXecE=
X-Gm-Gg: ASbGncsomZmAgeIQFWuTrVeKM6XeEXsLRCw/maTf9rlNpMcn85QvbDSwAQFt/IVeh9p
	DqZi/9ZbwoYL/kDZ4Fy9k+0KMLp24kz6xmAnx5FTFuD+7Ob8Y8of7C9OyjPBANhIjrcjsrnbb6u
	jE9V7Bpl6qLv8liz8I50Zbxl5eVHOqB9vvFmsVfPh3w6QfqOe30uVOzTiYpC2/+Y3cD4WpGIQQW
	zIu766IvTZ11PvfDh6pnVNcKw9xKBs1+OWgQ2humm6ESpJokOZTInGF3ZrtaMfRdONRLf/9ne04
	Ri84yOG8LjwjHyByVpYd4fU=
X-Google-Smtp-Source: AGHT+IE/V6kFksjmU9jpYeXFzBYu7bIgsDyXTPfFPUEcs+l8eg8Sk2rnVz8ksJX5C4iCTediHir1+g==
X-Received: by 2002:a17:906:c154:b0:ab6:db3e:2649 with SMTP id a640c23a62f3a-abb70a95729mr814742466b.14.1739775949500;
        Sun, 16 Feb 2025 23:05:49 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376326sm827729466b.87.2025.02.16.23.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:05:49 -0800 (PST)
Message-ID: <c04fc470-5ac7-4cef-98ef-5f06c3315ce4@tuxon.dev>
Date: Mon, 17 Feb 2025 09:05:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: Move address/size-cells properties
 to SoC dtsi
To: Alexander Dahl <ada@thorsis.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Peter Rosin <peda@axentia.se>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250204165205.2375940-1-ada@thorsis.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250204165205.2375940-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Alexander,


On 04.02.2025 18:52, Alexander Dahl wrote:
> Avoids warnings with board dts files enabling ethernet-controller node
> together with phy child node(s).
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  arch/arm/boot/dts/microchip/at91-dvk_su60_somc.dtsi    | 4 ----
>  arch/arm/boot/dts/microchip/at91-sam9_l9260.dts        | 2 --
>  arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts | 2 --
>  arch/arm/boot/dts/microchip/at91-sam9x60ek.dts         | 2 --
>  arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi    | 2 --
>  arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi  | 2 --
>  arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts    | 2 --
>  arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts  | 2 --
>  arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts  | 4 ----
>  arch/arm/boot/dts/microchip/at91-sama7g5ek.dts         | 4 ----
>  arch/arm/boot/dts/microchip/at91-tse850-3.dts          | 3 ---
>  arch/arm/boot/dts/microchip/at91-vinco.dts             | 3 ---
>  arch/arm/boot/dts/microchip/at91rm9200.dtsi            | 2 ++
>  arch/arm/boot/dts/microchip/at91sam9260.dtsi           | 2 ++
>  arch/arm/boot/dts/microchip/at91sam9263.dtsi           | 2 ++
>  arch/arm/boot/dts/microchip/at91sam9g45.dtsi           | 2 ++
>  arch/arm/boot/dts/microchip/at91sam9x5_macb0.dtsi      | 2 ++
>  arch/arm/boot/dts/microchip/at91sam9x5_macb1.dtsi      | 2 ++
>  arch/arm/boot/dts/microchip/sam9x60.dtsi               | 4 ++++
>  arch/arm/boot/dts/microchip/sam9x7.dtsi                | 2 ++
>  arch/arm/boot/dts/microchip/sama5d2.dtsi               | 2 ++
>  arch/arm/boot/dts/microchip/sama5d3_emac.dtsi          | 2 ++
>  arch/arm/boot/dts/microchip/sama5d3_gmac.dtsi          | 2 ++
>  arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi        | 2 --
>  arch/arm/boot/dts/microchip/sama5d3xmb_cmp.dtsi        | 2 --
>  arch/arm/boot/dts/microchip/sama5d3xmb_emac.dtsi       | 2 --
>  arch/arm/boot/dts/microchip/sama5d3xmb_gmac.dtsi       | 2 --
>  arch/arm/boot/dts/microchip/sama7g5.dtsi               | 4 ++++
>  28 files changed, 28 insertions(+), 40 deletions(-)
> 

There are some other warnings triggered by these changes:

  DTC [C] arch/arm/boot/dts/microchip/at91sam9m10g45ek.dtb
../arch/arm/boot/dts/microchip/at91rm9200.dtsi:213.29-225.6: Warning
(avoid_unnecessary_addr_size): /ahb/apb/ethernet@fffbc000: unnecessary
#address-cells/#size-cells without "ranges", "dma-ranges" or child "reg"
property
/home/claudiu/repos/linux-microchip/build-arm32/arch/arm/boot/dts/microchip/at91rm9200ek.dtb:
ethernet-phy: 'reg' is a required property
../arch/arm/boot/dts/microchip/sama5d3_gmac.dtsi:66.29-77.6: Warning
(avoid_unnecessary_addr_size): /ahb/apb/ethernet@f0028000: unnecessary
#address-cells/#size-cells without "ranges", "dma-ranges" or child "reg"
property
  also defined at
../arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts:50.8-58.3
../arch/arm/boot/dts/microchip/sama5d2.dtsi:382.29-393.6: Warning
(avoid_unnecessary_addr_size): /ahb/apb/ethernet@f8008000: unnecessary
#address-cells/#size-cells without "ranges", "dma-ranges" or child "reg"
property

Thank you,
Claudiu

