Return-Path: <linux-kernel+bounces-541171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71BDA4B987
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57B2188CD1B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F401EF084;
	Mon,  3 Mar 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dggZQvV3"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086E4645
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991102; cv=none; b=fN6OvPLoFI+BaiIxU0doETleknHwbR2zsZfwh76V7ynjxQaKHtttCfSgpYldt3g89TkZUJBJwdMXbH62BkwVul7TVSbI9Og6HSd2zbDI1R6zO+1AZX2UBiKTjU/ajX0bNRwygk7VxSwtL6PQQgeOSVw1SXWhApoB+pQa+dSQ0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991102; c=relaxed/simple;
	bh=j0Zg6zDwqBJl9XRcUP62Tk9aOlk8S3geXSs4RyGKrkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tABI6OZqPQJcWQACoWxai4sAkyEexlfsO62sxX/YvVwETr4Fqz8Z9dhFGoRRLn31KZ/b15nU7LMSU4rJJfWNCR/6PE8gvIVcjl82L1J+4a3fI6qFkIBQ9KB0dJs6iX4KogAi4tIXmWcc0A+GsQ5EfOvtMaD3h6w4Lf5AysYxJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dggZQvV3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e51e3274f1so3211980a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740991098; x=1741595898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQk2xNROAbUunePjjPQL+I4XS/ltDuWUPTvnmWm1qXc=;
        b=dggZQvV3pT2mlupd9scXXjjeaKW6dnYwVRpyX5bXi8C+fazQrFgxcKRaZ1GP7EsV3R
         QAcgVrrVwjWjo/ouhwB5xK2n7kwTsTx1yANfZxNTv4kSz2J/31NABhpYoejrS/iGl0e1
         PVf/N+2SLCyZ6USM+yqxZ1vvDNwkeZf2TscMZqnbgB+ZBIQ4SpHAF4lVMQizEhRLBvCT
         NUFDZiXW1CxdS4YSavSW58fpDUGvqHZeB3ONrHgnW6xFrkHVbU3O/TKB6KYozc0nfouz
         mcaHGK4c2HAbG08jlAwoiL8Wbze+zDmkFvvriQCQVSRZZzS45vTfK3owwOBtjenpSful
         Hxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991098; x=1741595898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQk2xNROAbUunePjjPQL+I4XS/ltDuWUPTvnmWm1qXc=;
        b=u8q1Hz3dchmJRUUbU10urIBc21mVqULdTv3tTXRjZHq+iRcsKYCU6euXV+GkHFGQ0j
         /qHJBpvb6ddO11+u/95fThl2Pq0LNO0NjZjOqlMGET9JU3FORGkRgUPNLru1R7GwFinu
         aPE9IOrojOWq8u2PZKk0Ifph73kwTnufW7OIPybT6Jp1dyaWNY5YYtrqfQWkzYr7sY/a
         eHi1rFvGq+NyGHZYMAvLfPMZnNqem99U6P9GMdFVIx6LciAaibq7EXnGaRRO/aS0vY3v
         k3zcKX3ZHp/yAmNWkbWaUsdtrApigDBF3Dmb8eWMrme/vRWrSQmUOer3jiULRN6Domc2
         RbwA==
X-Forwarded-Encrypted: i=1; AJvYcCXNlXzMHnuvq15taDLUmBcPK4/ZRb+oK6wAfLn5+gkNOqcA5R/B7ZQQ6KYxKYDvQAnub+J0AvQdl5F5mwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwosQgem9TtNuQnh3okGyYtsh+ju0r10sRnjkdVLONci4fbAf/Z
	Mhm6RN5bgYTrm0WBWP5rAoRItl9S8Sp52u0IWx/ey/kVy7l4d4WU8rPAM/0jJPA=
X-Gm-Gg: ASbGnctsL4AV1u7/GWPkafExTxL51GeP+5IAmJ5h2VEBv9LGVnLyZcw73oM8dcZtbBg
	8iliik+9DxlJgQO21eGGzGnsigpYXhzPGqgBjz2sWH21eqV5bIh4dn6yDkx5yxdyN2auUOsiJuC
	vZcd5FOxCJAId7fXfjhqYk1VxuWjB3Tk43FOue+smndVwUsG+gCCelWvDdEqLOtcUy0Q6eohAwf
	QAS8XT9aFSqqwzYEwW+3STWfBrhNjPE3w4W+FK5W7LUeXe6B1BjJETT/45I2M0yxUYPFe0ERZoI
	DmnmQ97kNXWXXp4yr38L5SUlE8m5pOLmOOMMFlCM1IJQxwvFrUlDA3HA
X-Google-Smtp-Source: AGHT+IFVwVDJq2GzOlT/TEj1tNqLe6aqacbfxkkGcxDDEFi9TNJRnV4PSA6nZiqQzltKffqId4/sKg==
X-Received: by 2002:a17:906:7308:b0:ac1:df33:25b9 with SMTP id a640c23a62f3a-ac1df33268amr85643966b.40.1740991098316;
        Mon, 03 Mar 2025 00:38:18 -0800 (PST)
Received: from [192.168.50.159] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1aec8164sm718325666b.172.2025.03.03.00.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:38:17 -0800 (PST)
Message-ID: <6d762706-27b5-4b0b-bcab-ae96a831c03a@tuxon.dev>
Date: Mon, 3 Mar 2025 10:38:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/21] ARM: dts: microchip: sama7d65: Add RTT and GPBR
 Support for sama7d65 SoC
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <6a1c058edee3fe1459dcb3a93a0a789a9ffff5f3.1740671156.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <6a1c058edee3fe1459dcb3a93a0a789a9ffff5f3.1740671156.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/25 17:52, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add RTT support for SAMA7D65 SoC. The GPBR is added so the SoC is able
> to store the RTT time data.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   arch/arm/boot/dts/microchip/sama7d65.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> index b0a676623100..aadeea132289 100644
> --- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> @@ -120,6 +120,13 @@ shdwc: poweroff@e001d200 {
>   			status = "disabled";
>   		};
>   
> +		rtt: rtc@e001d300 {
> +			compatible = "microchip,sama7d65-rtt", "atmel,at91sam9260-rtt";
> +			reg = <0xe001d300 0x30>;
> +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk32k 0>;
> +		};
> +
>   		clk32k: clock-controller@e001d500 {
>   			compatible = "microchip,sama7d65-sckc", "microchip,sam9x60-sckc";
>   			reg = <0xe001d500 0x4>;
> @@ -132,6 +139,11 @@ chipid@e0020000 {
>   			reg = <0xe0020000 0x8>;
>   		};
>   
> +		gpbr: gpbr@e001d700 {
> +			compatible = "microchip,sama7d65-gpbr", "syscon";
> +			reg = <0xe001d700 0x48>;
> +		};

This node should be before chipid one to have them sorted by node address.

> +
>   		dma2: dma-controller@e1200000 {
>   			compatible = "microchip,sama7d65-dma", "microchip,sama7g5-dma";
>   			reg = <0xe1200000 0x1000>;


