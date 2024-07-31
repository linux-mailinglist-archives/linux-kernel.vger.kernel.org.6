Return-Path: <linux-kernel+bounces-269459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA06943302
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12D31C20C05
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9822E1C0DD4;
	Wed, 31 Jul 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFyq2wxZ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9341BC081;
	Wed, 31 Jul 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438874; cv=none; b=I+YFEhO+TMUjHw/AoO2r8zkAckWmT16bUCgOD6PC7Q5dwQ56xQ4OBZJnoKawZM+gn39NQ2Hs7zpPb9IP2K+rKr9CPcTiGYClJd1wzomNj43++X9/WS6OITtsu+IZzRkRJ7dKeS3/ZikXTg8HQu4ppKL85RnCbJdIfIXivhAvztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438874; c=relaxed/simple;
	bh=Vcto3szIghaeTVlj8KeAKJvc0CUFFzBQJzF4EWspM2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT0h4gyq8Brrx7Sx8UoSNl7rQAGMCstUhvFZLYXv1kaog5O/+1qymk1mfAIcTjBLVs5EwjFpg0NFdObe7G1LPVxPw/y36+EdoQCKvTRdsGdpOIVSOpNTZSrpTwrYnCt2uo+zrPuNHj/ho1cOgkj7x5M2ISmESbqzq8gGwrk7whw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFyq2wxZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so4248070b3a.3;
        Wed, 31 Jul 2024 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722438872; x=1723043672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GQESAh5v8TLqvpjfGuDOPF3CiayVAeKgE2izkK/fl10=;
        b=dFyq2wxZP9F8vR+mSO3/scWIdEo+KO00d2V53M48blAxXDUbnxbSN+urJhUCAtA/sp
         jiPS2Je4y3jUeTsJDaHKR7ZxT5H0RgP9BRNGrDcFKenjdlc3g620FbiK/HWssM5m9IfP
         MSUvW0x9fT7VzSNdGnBxkGU38gQJaxHJ5x+CWEMKMvYXBPrZ8aJ4NRTM8vczP9waqeUa
         KeTUlWwGKFiqEQ+6IpLTWyIn5eLzW9KGotUJoGxin0sDIC/BdMzUaG7ocEJuXVL7SVYC
         jTd3ShVAKCmPfVeAcLl+yMl8V+SVHUY6rJHAShFZ0MOE1mstOpKRrbJvQKgwjM6jVRVm
         jENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438872; x=1723043672;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQESAh5v8TLqvpjfGuDOPF3CiayVAeKgE2izkK/fl10=;
        b=hTWfFZ9qJu/plCuY6luQVNZCcG2b+Dr1V7WKiu2lXmmXUnVIWgC3Bd/xd8brHjBW3Q
         O9N0wrKvSYyfXmmzNcwU6Ws2NSFeyQg1l9iYQtnWUOwSvY5VnV/zgjgtvUzfPAdKymv8
         y4mbZrIFOJFWH/gRUQ99iL9j6MN40mNlaCRFwNVo6KkqW+pxdj4HxRNdSY4Z9PImkE7Q
         Ecl2kndpv77YlwUt+GXRGHWLZ133AMvjnBKz34w+Qkr22Vu+V/btnZpBYRt5i6meCcIv
         eQ00W8hY33766F6DrBz/aqrR5Trdo8fHELSwtBR227ovfevOyghy+5AzYyRJJymSRMo5
         Q3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSJTEWl2KdkvaJKD21fqai29iwIaLvHoSB4Go5JrpEJMhL6V/RBTqBEMHRSMh+99e5NatWrKVgfSrzNJt5kJ9WP7Jne/af5YpN85wv6HX19Ebi3bfZMDHwFVXP9L01SnBl/IakyFfW1w==
X-Gm-Message-State: AOJu0Yz+w+0tzPruIBDmnhxzukwM1byBN4NrttzulPhz2E2SVu5764jA
	F8j6SLiF6KcONSO6nVA0+X855uL5SPvtH8wFLaOvmsBTeXTdgzlc
X-Google-Smtp-Source: AGHT+IG0JAUaEWaLbsWRwMvti9oENtdZdaMyGbtcv665ZYl/uXcSE+7CDlI2GS3jT1x9PK4ZkrezOw==
X-Received: by 2002:a05:6a20:431f:b0:1be:c86e:7a4d with SMTP id adf61e73a8af0-1c4a1512bdemr14841240637.53.1722438871578;
        Wed, 31 Jul 2024 08:14:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e31e4sm10080550b3a.29.2024.07.31.08.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 08:14:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <47f60f74-27fc-4b69-b4ad-9d035c6732ea@roeck-us.net>
Date: Wed, 31 Jul 2024 08:14:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: arm: versatile-ab: Fix duplicate clock node
 name
To: "Rob Herring (Arm)" <robh@kernel.org>, soc@kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240730210030.2150467-2-robh@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240730210030.2150467-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 14:00, Rob Herring (Arm) wrote:
> Commit 04f08ef291d4 ("arm/arm64: dts: arm: Use generic clock and
> regulator nodenames") renamed nodes and created 2 "clock-24000000" nodes
> (at different paths). The kernel can't handle these duplicate names
> even though they are at different paths. Fix this by renaming one of
> the nodes to "clock-pclk". This name is aligned with other Arm boards
> (those didn't have a known frequency to use in the node name).
> 
> Fixes: 04f08ef291d4 ("arm/arm64: dts: arm: Use generic clock and regulator nodenames")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Arnd, I imagine you can take this directly.
> 
>   arch/arm/boot/dts/arm/versatile-ab.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/arm/versatile-ab.dts b/arch/arm/boot/dts/arm/versatile-ab.dts
> index 6fe6b49f5d8e..635ab9268899 100644
> --- a/arch/arm/boot/dts/arm/versatile-ab.dts
> +++ b/arch/arm/boot/dts/arm/versatile-ab.dts
> @@ -157,7 +157,7 @@ timclk: clock-1000000 {
>   			clocks = <&xtal24mhz>;
>   		};
>   
> -		pclk: clock-24000000 {
> +		pclk: clock-pclk {
>   			#clock-cells = <0>;
>   			compatible = "fixed-factor-clock";
>   			clock-div = <1>;


