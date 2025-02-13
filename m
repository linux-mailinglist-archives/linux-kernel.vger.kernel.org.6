Return-Path: <linux-kernel+bounces-512492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74793A339FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24093A4FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919AE20C009;
	Thu, 13 Feb 2025 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T+QBgBtj"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED62054EE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435447; cv=none; b=VCBN1r4kQtFYyDWvJ9zLTVymGDy+xqHfobzHY0dGxRcMU+a3Nf9tXyqXCaE7Zh/2Kidm49W2OxKQ422G+aNtWPwr98BMCtceSx3T4/5Xz5SXzxx4c25BfCGV16QhhYRAwXpdxbMYR6PjbqpZnDobkfM5ZXo96Z4vWM/HUU0htwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435447; c=relaxed/simple;
	bh=yVyXip6qwmE1k0De5I/LF6Pjyh8674Af4I42FomQeV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HylavZfu5h5I6bIOmNjASRUB8oXYW6XuxJuEVwozt8SMb2obKIF9BodfIP4naGqyxpLioJZt0IlZirUh/Ct3gHKQhFyZW6AkqmII0Pc+/FhNAY89OPvbvgXgXVUQ7lwmZy1fHbT9B1izFXOxQEXjzBxsTOz/tvyZOQ8Yc9UrPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T+QBgBtj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaecf50578eso133008366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739435443; x=1740040243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OTJXiPdRvtiBBp8e+x5n2i2CDc/LvduVGRkWa7Iyto=;
        b=T+QBgBtjCHvKUV+kA9m1KbX7frJPnYEnFiOv88BJ4Ogq1DTf1Wqwxc5mRee3tvrUzI
         AftQNJIEgA4UDykK01Y82iOR5t4gJlWMScSi9IKtfijLscekzoB+ZGZaB7SOHw/+Eq3o
         4c/HIQioSOO++u0eTbjGxUwebhJ7+ghCTPDsO/mirYiuV/KC8KuvOxjWiPYVlhWlPVWH
         BLWRxxacVOr3h0qvP9dwVe7gQCtbKiYC3O8mn6HOwi55pEbpwWtZlFOIGg+TaPGiRwXZ
         75oJFKhXkwFTz/YfyDvKoJfk5swu3hqVosJmg1xIEJrvGOD3xyct0QfT9fzJ8h9XFcEh
         riBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435443; x=1740040243;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OTJXiPdRvtiBBp8e+x5n2i2CDc/LvduVGRkWa7Iyto=;
        b=kdcoWCUq966kZrnBkjScH2DTeVeuAXfzVAOr1saRDDvD65v3ipBHUaty5KBYWbcDa+
         P6phaJNBvIJ+avspueKXkwYbnPz2ydprI7aGuUVSbDWeBVV4rYi8zr1iBnzoXrfap+CQ
         RNNeSfyejHGCGozD8IpP4B4w5uv+d2HyRIOb9ZA1DUMgcaRTKGiNuCULN/GzRrTcIAkr
         KjVwTL3UCHzxny++jbByyFatATef1/o4D+TC5Pz8orMjs1FlBR7gkeCAwS7SHzYZwXJu
         E8zdQeotARlM9PoIMikPxcECxXzIS1wO3wDPEntjU0QEgOMuvrDvhDIcTG7m6S9bVUg2
         bGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe2XN/roaVEwXzgQG5WZ8nc6ISuPw9XfYgLjqM88bgnWLujX6xOZEZ69E7oHPWIBHxO5h+fBSVAjweL2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSJ3iQNC5/KPO1eILP9eENFfikHX1u2OjWOHeXTEirdPb9pA6
	mKgsiDyar/SH01NsBCG9xkGGgM2fCEz6vi2sxC1EUmpgKgjSRQRPZbFODnXTnc0=
X-Gm-Gg: ASbGncvGYH1673+gEkAOrL9wR4mZDY+ML7KWd9yf2rq69BCUpfhlac7835uss7pQYX3
	8G1nLGPMPNndPwQmTfqIKz03UKbFUP39aBNvGuq3EAaxUOpTQtH5psunYZT37PuelTyaTouUMWd
	cl4fvNOYADRQ6N/Akmc7P8U6lcnsPONPFJixMSMJHn3FR3xZitZ93r/07u3xt4kilJCj90o8UTQ
	UHI4Wn3ThjMbI4f//LLeC3MobEwp0bMU/TrLOjPKAqbHVzQoL1Bofp1J7qscMLdRvNqLq4VoqML
	b+71f879ST4+NB/q8Uc73NQE
X-Google-Smtp-Source: AGHT+IGRpE3mvXYi07r5eKrsPU6jDtGUtF130PrHSlSd+nAQxiAUlBKaWgcX6BHCBayFoA8d6GoHcg==
X-Received: by 2002:a17:907:724c:b0:ab7:d10b:e1de with SMTP id a640c23a62f3a-ab7f339c868mr555099266b.13.1739435443116;
        Thu, 13 Feb 2025 00:30:43 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece288e38sm753543a12.79.2025.02.13.00.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 00:30:41 -0800 (PST)
Message-ID: <83a59afc-ce67-4461-bb63-d8b8078a1198@tuxon.dev>
Date: Thu, 13 Feb 2025 10:30:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] ARM: dts: microchip: add shutdown controller and
 rtt timer
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <709f5268da63c123cc4eee9e47875324df81c454.1739221064.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <709f5268da63c123cc4eee9e47875324df81c454.1739221064.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 10.02.2025 23:13, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add shutdown controller and rtt timer to support shutdown and wake up.

Also, split it in 2 patches:

1/ add rtt timer
2/ Enable shdwc

> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../boot/dts/microchip/at91-sama7d65_curiosity.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> index 0f86360fb733a..d1d0b06fbfc43 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> @@ -77,6 +77,11 @@ pinctrl_uart6_default: uart6-default {
>  	};
>  };
>  
> +&rtt {
> +	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +	status = "disabled";

Any reason for keeping this node disabled?

> +};
> +
>  &sdmmc1 {
>  	bus-width = <4>;
>  	pinctrl-names = "default";
> @@ -84,6 +89,15 @@ &sdmmc1 {
>  	status = "okay";
>  };
>  
> +&shdwc {
> +	debounce-delay-us = <976>;
> +	status = "okay";
> +
> +	input@0 {
> +		reg = <0>;
> +	};
> +};
> +
>  &slow_xtal {
>  	clock-frequency = <32768>;
>  };


