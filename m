Return-Path: <linux-kernel+bounces-253156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073B2931D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06C3281F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C3B142659;
	Mon, 15 Jul 2024 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOe2yyUG"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA622626;
	Mon, 15 Jul 2024 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721085568; cv=none; b=rHzydMxm+pmhm1qfmqakeC+bTDd8px2QrxqoMUuDetVdtznevrqIGXdQcFxKs3cZG+BBrzYVwWnYP2Is0fwS2Bp85jxT8sqIZ9nnGbGpoYyuOoj9MSeT1Rfupi2tty8yyZvWSRbsisutYe0nn2hV7eiXHRTbOwbyKHQKvvJxSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721085568; c=relaxed/simple;
	bh=WgRWYlMAiazzRfYsvU+qoobGVpdNYHrfBmXP1jZZfFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gc2Q0ELV4yVtNVPnENZNbaEStRUldCK68Ko8Bj4NSibFJeadzX4ErXe5qYHI/P84wb1NuvcqFA45noaNIXDuwZcDVeGBF62Gawo2pq3CY6QL2TlC+L4Le1mahh62ryPJ4Fo/tBR2kXVvYi5ffEtK0Bf040w1dSkorvg1kYOU6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOe2yyUG; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d853e31de8so2796704b6e.2;
        Mon, 15 Jul 2024 16:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721085566; x=1721690366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Qh2Gh0eRUqnXUoQU2z1hxdkdPwhK18g3R02BveegPk=;
        b=dOe2yyUGpOhW0wn/3wIZi/uIRYGgZnCu+I1YiN7+t+sRmQjUTjSJ+yx/QK46lmsgG+
         q8M4BWofO0K6lNR1AkJZrCOVvFgIErPYfOcLI4Q48OutaJJG3cniy0hB3hrLVIRfENON
         ODD19o2LY+Dib1Ja2kJBGQ1SoUlwE98Y5cfp3V/sO32f+u8yJmF69b1bAnn7UQlximEK
         gfSZRXmOVPF4or6YKg5cZh8wu3qi08VtRBdcGCqmJI/DXyMQjIeBDifRXYSyetqT8uLt
         7Cvnv8XFTkmzBeQjACMI6JCP3pkA0/u0bbMGMmnVZSccXHsXwDFovMVUA3c2l8wBFUSF
         5ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721085566; x=1721690366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qh2Gh0eRUqnXUoQU2z1hxdkdPwhK18g3R02BveegPk=;
        b=woKICfKbY+7wDd0ycCmJokBQXq/yjafsaQl1Nn3Z95JuySx5TOZ7viJsMs9XuFo2kY
         yWfV44b4DlJ0CgfwEwgTKNTWoiC/UbA+XeEwlU1t0m4KrA77Tmzm4FUPpbcQBX89ivfT
         H5fgO/aKtrzW2Sl4MkwryP9zjYr6bd+JSFjAQ/hhXQ1dbZgc6gtH/5vsIohk86hgxG84
         A9P+kHbsM25GYuMVUnPhCfX1d1F9NSejR8dcJoK/3Y4YM/irfPM25R8S4wrdFl4fKeCQ
         4RkXg1lOPKXFYCiRSbYhPX3z5xazzEPPzmicOtKzcBQqVMJA30qHGbSTavYO8byezsQf
         8JXg==
X-Forwarded-Encrypted: i=1; AJvYcCXeNNGthA2MUX0u0M/jujdOVH/j3VP9DBo092fbxlzgMbtS0fXMTglHZ3GMnwLogkxkOSspk5lE+FzvZItI0uMgVp3aGpb8aTUnBqdKYq3BEW8B37U47DDRD38FEJBy8rLIirdIlhtunw==
X-Gm-Message-State: AOJu0YzqVieYsEYRf3I2P/s1JsoMPepxHcESb74+qPD8VIYpQi5jScVl
	CLv1ng56kds3ZgNPxeCEbc1f7zSAzVhmWH2p9xP8pQsBJGRHxRtOjWWMjQ==
X-Google-Smtp-Source: AGHT+IEzjAcIhmBBg6RPiEqq69prSZnrqcrDvu2ja9NmiSv6qWkuD6aDU7NWoePCqpNFH8JhRtAfRA==
X-Received: by 2002:a05:6808:3088:b0:3da:82e9:ea9b with SMTP id 5614622812f47-3dac7c12e9bmr717175b6e.43.1721085565717;
        Mon, 15 Jul 2024 16:19:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a160c6382esm240979985a.87.2024.07.15.16.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 16:19:25 -0700 (PDT)
Message-ID: <f178aa92-d91c-406d-9fea-1021bfb99f55@gmail.com>
Date: Mon, 15 Jul 2024 16:19:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: bcm283x: Fix hdmi hpd-gpio pin
To: Florian Klink <flokli@flokli.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
References: <20240715230311.685641-1-flokli@flokli.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240715230311.685641-1-flokli@flokli.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+Stefan,

On 7/15/24 16:03, Florian Klink wrote:
> HDMI_HPD_N_1V8 is connected to GPIO pin 0, not 1.
> 
> This fixes HDMI hotplug/output detection.
> 
> See https://datasheets.raspberrypi.com/cm/cm3-schematics.pdf
> 
> Signed-off-by: Florian Klink <flokli@flokli.de>

Assuming Stefan is OK wit the change, I will apply this along with a:

Fixes: a54fe8a6cf66 ("ARM: dts: add Raspberry Pi Compute Module 3 and IO 
board")

> ---
>   arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
> index 72d26d130efa..85f54fa595aa 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
> +++ b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
> @@ -77,7 +77,7 @@ &gpio {
>   };
>   
>   &hdmi {
> -	hpd-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
> +	hpd-gpios = <&expgpio 0 GPIO_ACTIVE_LOW>;
>   	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
>   	status = "okay";
>   };

-- 
Florian


