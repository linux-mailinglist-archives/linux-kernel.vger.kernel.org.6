Return-Path: <linux-kernel+bounces-552560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158E2A57B48
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D1616C39C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30181DE2AA;
	Sat,  8 Mar 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYFHH0LJ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3F17C77;
	Sat,  8 Mar 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445644; cv=none; b=M3QX1RyFycyVC0wyddT/anoy/qXD752u6R+r75xmmQx0argJNGMiJ1fwuO76jyX9TjdUHVTc2Rx0iSTZtPNXlk+q+eAJe7Jb3rSBGTnbbsNPiS8dVvgRNvPthQ2miNRFhRGouaYtLf5mdDrwgKBLiZZ59d4eMlqKMchGNnWmzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445644; c=relaxed/simple;
	bh=QBwQ8twtndtJEIY4YU0hJ5zZuI4VjHC06S9DrSkJeWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2RD4JuoINOOiGDGTiTzYvsT4Rck8jt0ITdHSdHUP2QflAEBNrzMp83YozU3KUc/1y/5P8JZIv2vNCLeq12ltuBrtFpceF0xah0gPV68d4BA5UnbbUUn5bqtQvZh+JmUd/6OS8cZn+WPG4fgwkoWhYxAkWKZ2E0S8O2rdXYkMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYFHH0LJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54954fa61c9so3333345e87.1;
        Sat, 08 Mar 2025 06:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741445641; x=1742050441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Keyp5UqooSuCZNdvM6L5386ygoD++VE/io10zX0U4b4=;
        b=SYFHH0LJ67K8eZSW2r/eBv/PG0Yu5X7b4x/xkVhzD7Lry1WSso0EGihFf2N7ftojDt
         T1Qor7fvl5DG4XQ1j8KOedY7nYC64uR+alh0oSq8O1MKNxFaH1W4LsEN7E8M5ilTrwEr
         6zEEXlRR8WhPH8O1UErOk9mIJHd1EGTvPJ1r3BWFCuWm3Br+MV1anB+ql+C+bRDUEfPF
         MJZ3rpqs5qULR+wi3frsjrmqxvozrAsgF6gkn+HL3N93HB1gXAKC6n+66eJ1NDi9QnGk
         ydQzJ2Ybzg6PI7lhdJOGpgVPi5kvzfMjePGJs3Pvm0jsvYV6s1hzPiKyYSZc2DryaT4Q
         9DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741445641; x=1742050441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Keyp5UqooSuCZNdvM6L5386ygoD++VE/io10zX0U4b4=;
        b=Q1hH78+zhG61Ew+C5+24GNWnjwf2ff1/1GKaTA/n0BiKJt5vtfAPbVw98oBsJOiCqa
         SxaElyg6zuM5xflc8MfALFcHTLezkc3YPzm7vN7oE5acNPI7/bXu83oLKwwQ+sRbQP0m
         IVIQlFsWiyaUImysbZoTszx+NXldAwiNUSzSIcaMgjydVkVQuONe7lPEmnlvMnnjJD6q
         NJq8YtQF5PiCNXmtQDhzuWERbxKBQODP8FWVA+w189132ngzQw2CePhr1Gipb96AljXn
         wqT8PXZ261BkIt1VouBuxbfWYxH96HKsN4KYiPYfePAmhkM86j8rVlidpIUZ6h/s+9lR
         Uddg==
X-Forwarded-Encrypted: i=1; AJvYcCVPIlS9EqthCtQceCSiZmEY8HJaXHfq/VLAcI+SWE7DE54VZHydE9eQHZC1C5CSlOAckHtXvIAp/U0GuM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb4fcqUPxr2fZ8iLSjPDsru/lemkxx99ADKu3CPpIdHKl9lU6j
	TlTvSdShCNSP3rgRUjfpzoADoGNWQb5NTot16XgYIk5dq3PGtvVV
X-Gm-Gg: ASbGncuUwLL8nkrAV4K4GpHgHOsLg28FZHAHBqDxdt49dD4ajIuVupm9HX8yG7UzwOH
	v4gB6cd04X/WtTRN5OeVcx/SBDi3/L6tcUhr4rOazhzsEBuDBYGtHbDWTo2sfQ9IJdUUlYWmupO
	n0qDpC5tQtq4JeQA5Vn4uNJcIBTw4umD4CV2lsb9KgoDiyeyfHYLUymJj0q8Uq+sZDQ0m41V487
	unyU5MXEzyj9b+CzM23tMAidqdD7cpzMUBMhrzD9ys9CLqiv6cyOw4TKiQi9VWK7sqmjUWNIqkt
	/vJovm6xPE6fJ1z7TnMIViv9A8N9PvGpEc9mAl3mCDnu29B64WKMiTVcW4FHtpsDru9q/w==
X-Google-Smtp-Source: AGHT+IFdMQ6igpHYoU+OFcqiUCRXxji/FOXpGlAvF0Doh5wY4O8NygnwUp3CThZfRGttQjNw6hi+jQ==
X-Received: by 2002:a05:6512:3d27:b0:549:8fc0:bc30 with SMTP id 2adb3069b0e04-54990e2bbcdmr2520218e87.2.1741445640251;
        Sat, 08 Mar 2025 06:54:00 -0800 (PST)
Received: from [192.168.3.116] ([78.56.129.233])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd128sm831788e87.152.2025.03.08.06.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 06:53:59 -0800 (PST)
Message-ID: <d1c600f1-a874-4bb8-8b9f-22a3414edfcc@gmail.com>
Date: Sat, 8 Mar 2025 16:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240626230319.1425316-1-jonas@kwiboo.se>
 <20240626230319.1425316-3-jonas@kwiboo.se>
Content-Language: en-US
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
In-Reply-To: <20240626230319.1425316-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/24 2:03 AM, Jonas Karlman wrote:

> The Xunlong Orange Pi 3B is a single-board computer based on the
> Rockchip RK3566 SoC.
...> +
> +&gmac1 {
> +	phy-handle = <&rgmii_phy1>;
> +	status = "okay";
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;

Jonas, were you able to test V1.1 board's Ethernet?

Whenever I start the board - Ethernet initialization fails with:
```
[   21.140055] rk_gmac-dwmac fe010000.ethernet eth0: __stmmac_open: 
Cannot attach to PHY (error: -19)
```

But if reset is performed inside gmac - initialization succeeds.

Eg. patch:
```
--- 
linux-6.12.17.orig/arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1.dts
+++ linux-6.12.17/arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1.dts
@@ -16,14 +16,14 @@
  &gmac1 {
  	phy-handle = <&rgmii_phy1>;
  	status = "okay";
+	snps,reset-gpio = <&gpio3 RK_PC2 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 50000 200000>;
  };

  &mdio1 {
  	rgmii_phy1: ethernet-phy@1 {
  		compatible = "ethernet-phy-ieee802.3-c22";
  		reg = <1>;
-		reset-assert-us = <20000>;
-		reset-deassert-us = <50000>;
-		reset-gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_LOW>;
  	};
  };
```
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <50000>;
> +		reset-gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_LOW>;
> +	};
> +};


Arturas Moskvinas

