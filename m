Return-Path: <linux-kernel+bounces-517235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8557A37E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334463AED16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC951A7AF7;
	Mon, 17 Feb 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="A37KpkAN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9191A76D4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783442; cv=none; b=J9V0vQj7P1l+8OLKitXY1KJU6v3k6fUPxkHMP78oqA2y+ZMiaz6N6nb2j5LD1QlhigQhoLNQJncsNafFDR58NWlvZvkpce+ZcjKszccuVpE2pP/TPFRae48L8jTbu95jihykAuRlxoZqQET8JZhBs3gt9nZj9kbOxwESlSF+CRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783442; c=relaxed/simple;
	bh=gti27IHeX1Dn0PmJ9EmmFS9iD76hwWW0DoREF9bQbzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqE/fHkcdV6O2MsN0hca6q8WUi9AKZMtVvP73ttI7vAzpZKm5ifVCQfFZbUjfgM3s8QY+qwZGvvwR+86UpmPTzZnNqmeL+kRWzQF8vsd3aLmesm1kEwZ9YbM1hcGoL4dTPMZnPzYjWDBdObe28lFz1g2PZuWWUmkgnqn0oZCxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=A37KpkAN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso5425527a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739783439; x=1740388239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuVc/9e1Yj/sPI8+yIxKHV0o19gCf//rneJUR1cMCGw=;
        b=A37KpkANdVail02PQiX7EWBLC1Mmc+Ye9pvLdQVKEWcjGp/AJXVahPo+No00e8xAiQ
         8E/kcyy6MqO6N/EzPjD22wZO8ROgn0tEXpnBYPOeJMD8K0L1qFQX2Oywgdt+vmApvPJv
         J72FGZGbzBY6DasHPbhNFv90Angg1dVkAQHQRYdLkXAUNNWfFlzV1VCVPOj1j5pPsocV
         qMY3w9Zej6sPqjfn0oNyA43koJOl8Sf1Fvg35p+99SiGXLir485/DuDURnXAOkcVBYw4
         YEl7FL7avmlAdNWN11K0tKq6XSW5kQVux+TwjwQu02ZgbwuruMUe8Ad6FJecl+5k+aTP
         06kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783439; x=1740388239;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuVc/9e1Yj/sPI8+yIxKHV0o19gCf//rneJUR1cMCGw=;
        b=gXmWhxT755m7mWowayHGk+fwOgUt02UPAYs9NHZQNhqOEhY/LI1WuaeYDnpRPUP86D
         zxSercAq+xelaHBnS8yMhWDnph5442jB/GruxeXAFTKEOYhasepLHnNIch+JV9HPGzBY
         g+DteXJmZmNkZKODo57czAWJ7b7EXYPa1KJMWwk9UbwFDj/qUf98wBqxdFzo6L0rsqZE
         t0KXNMPJUVLlWWO8QKHjPWOeFDKjzklaaGTLPLpWDQj/fKVYGKoctIBsEPcStJlx+PrG
         1n01ZBAqWaInoNiw6hT/YWoutblTAozDrVMSjVr/+pml64+7YNpJBcG9MkJDWbP6QNkY
         i5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZrfHcyhiQwM5NChnmWTrcugRIyQcVWDhZ5ggHGMzD297AA+dTaIG/v2eW3OhgdWF/gI4xhxFTD7H8qbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98y0G6eFYryvZaDp67Fo++QDaPt+Y8JKBkgOgbOtDoENAThVH
	c12xDsYuTTz+ZNsxvf7g0lkm5DAChWR0J7o/5hm7em1rtm1RJB0zfz/7yAsiQtE=
X-Gm-Gg: ASbGncsTCaMVOHPMZV/9zPXsjhbIVudi6LzfKux7Lgnd8WP0erFfYlIpfaZwals/WUL
	yMzp+WYR7pznHIsNbIBgilr31a4gr5NONT2HlFnHTqu6qwImGawTyCvgVV0Dq++L5c9fRKa8o2p
	40okrtQnjLQ6gul71xZrKkQYnXi/643v598c9KLlps50AkGxbLNVztH60aU34EPaY6bQpKz1+Ud
	UXeiyVPjEoxMZ5CCw1DULgSmMZ2mL57P9oqayVKL/DGATAjrTLuM09vjWpTl1Ua6MHBN6PscIDD
	bcjrbpZf6gAX9Hwhlhci5hY=
X-Google-Smtp-Source: AGHT+IH9wIn/oFp0HQ5Ml9Fr0/i0O7BRhz9FvkPajM9aPkSSBQ0mED5a3gvKqPWrNLKiBiFNMqW84Q==
X-Received: by 2002:a05:6402:4609:b0:5dc:1f35:552 with SMTP id 4fb4d7f45d1cf-5e0360441d1mr7250545a12.1.1739783439236;
        Mon, 17 Feb 2025 01:10:39 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4ed9sm6835151a12.10.2025.02.17.01.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:10:38 -0800 (PST)
Message-ID: <e01ed1d6-32e5-4e0d-a4f3-01acde843b5a@tuxon.dev>
Date: Mon, 17 Feb 2025 11:10:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] ARM: dts: microchip: sam9x60: Add OTPC node
To: Alexander Dahl <ada@thorsis.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20250210164506.495747-1-ada@thorsis.com>
 <20250211065304.5019-1-ada@thorsis.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250211065304.5019-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11.02.2025 08:53, Alexander Dahl wrote:
> The One-Time Programmable (OTP) Memory Controller (OTPC) is the secure
> interface between the system and the OTP memory.  It also features the
> Unique Product ID (UID) registers containing a unique serial number.
> 
> See datasheet (DS60001579G) sections "7. Memories" and "23. OTP Memory
> Controller (OTPC)" for reference.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
> 
> Notes:
>     v2:
>     - squashed with patch adding the clock properties
> 
>  arch/arm/boot/dts/microchip/sam9x60.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> index 1724b79967a17..af859f0b83a0f 100644
> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/clock/microchip,sam9x60-pmc.h>
>  #include <dt-bindings/mfd/at91-usart.h>
>  #include <dt-bindings/mfd/atmel-flexcom.h>
> +#include <dt-bindings/nvmem/microchip,sama7g5-otpc.h>

This is not needed, atm.

>  
>  / {
>  	#address-cells = <1>;
> @@ -157,6 +158,15 @@ sdmmc1: sdio-host@90000000 {
>  			status = "disabled";
>  		};
>  
> +		otpc: efuse@eff00000 {
> +			compatible = "microchip,sam9x60-otpc", "syscon";
> +			reg = <0xeff00000 0xec>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			clocks = <&pmc PMC_TYPE_CORE SAM9X60_PMC_MAIN_RC>, <&pmc PMC_TYPE_PERIPHERAL 46>;
> +			clock-names = "main_rc_osc", "otpc_clk";
> +		};
> +
>  		apb {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;


