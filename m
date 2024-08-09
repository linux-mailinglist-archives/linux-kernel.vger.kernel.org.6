Return-Path: <linux-kernel+bounces-280424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A573094CA50
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A161F226AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA9916D33C;
	Fri,  9 Aug 2024 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aTcpD1Xh"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341316D306
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723184108; cv=none; b=QXicVGG2g03ePSwfLtXo0b0SnsaXUFsj3cI7NxJVLPjRj4r2lvdMKT+fCMamluRtpT9i7AtbXPrhb+o1v6/e9S3WAoBUyxMTnCsqDJnZDqi+yU4lyEWqjk3n6H121XjGQP1NQNub+cC5vRUI8EfOnnOdK8/c5XkEZibhA7gTeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723184108; c=relaxed/simple;
	bh=3SkT6eUaGXULYT8HjMToBBp/o+Af4193MeaW7kUSvRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAZO3JdaM9ci3vbiduBBtCaFPLMSPf6jd0YtB85t0ZUDsRTs/ziy9PBAV+yCu4DI8TDjW/zoruy6E9qYyqgdBYFo3ULVzllf0c1bVg+hPOZE+H/89R3R34M17lQJTrrmNc2C91pi+v/52lFQcgaQpjJ9U2yJI1GkWzI7V+Ql24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aTcpD1Xh; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so2251561a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1723184105; x=1723788905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mmo7vCSxtWZSUKBq5QA7U8m3yyWxTBrT8d+vUprsRtU=;
        b=aTcpD1XhK8cieHrKOqHdHD6Rb4gujfRLaQv5GCkWOOGBfhNct1RGjOZkIZqhykOJQX
         MLaCsWLO6txktOCmRQFxq/QGZfiAqGsTLCu2HCET/LOg5NX0x89hWPbpGPTL2Ouksxzy
         osEQMy1QyNm+tn4YRFsk7xRmAIiP4w1f3wxsakDbhh08T3I89/s9henC92ZHfyDYsViv
         ICtNALTATP/PCYSK138mGjOA1TfXxHUvDGb9IDVp5VDxDn/uEId1gFlJsDQUU9iOR0SN
         WRhkllltf75UL+xclIOWNoFw5cb/OVLmRZHObybnwVuov6/svAxS0iJcm0nHYzzNVGzT
         cyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723184105; x=1723788905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmo7vCSxtWZSUKBq5QA7U8m3yyWxTBrT8d+vUprsRtU=;
        b=Cp8oVsEFKwZu/OtkLm4v4vL1cWYE80ZXpSYDQ/xdVQuPnhOH9pebJPxRF53CKNNB+4
         P+0NpwAvg9GHahemyG4geEZlESgCUIlJaV3ilBQqdTEz6UHIdnflR1jRo45eCmhuonb4
         s4zshQGJ5wqAZpTVpAwjm38X9i/+r/Kozx9am5Li+2WQ7Fb0VMx+EFmJPdC9Y19ZNhoV
         HE0DVoChNLXPc6//7q0eO3K3iGM8P5CvOkhNXKTBefb3keR7YlXsGPrGkrAmv9Pe+qFO
         6FfltUR2wcNiRa+BqkEE4EZeN8FVK1wAdIGC4exMYO3WsBchnIRjHRL4irlcTrP1yUwD
         qdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUflzj6cTCxAuJcAqKKqJg1fItpPVZJNXnA77HF72z9lc6fmsqBDwuxcff9giJNAZcKnI9+JR56NCNbSYCgU4lSAAuPEuSRcTtTCLtc
X-Gm-Message-State: AOJu0YyDZr+zkiNxmv9R/mjJ84wfFYht19lxOJR2gcvaBUuE2WSO80JI
	qCFWeoMPHi4i2Qz7b+AsAjrvPvlQbYBDYMmpPOx35HbKXxj+uXtR3j3ugDIJ8cU=
X-Google-Smtp-Source: AGHT+IF8i6+WlvJMTlwDRi/ONJBvYLchB60INeIHYhAB+fRORUMHsbgzjq6cXCYdLorWHI62kPbVLQ==
X-Received: by 2002:a05:6402:2551:b0:5b9:3eaf:5bc with SMTP id 4fb4d7f45d1cf-5bd0a52a794mr351200a12.10.1723184104842;
        Thu, 08 Aug 2024 23:15:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bcd9d08dcbsm250237a12.71.2024.08.08.23.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 23:15:04 -0700 (PDT)
Message-ID: <13fa9b3f-7124-4851-a1e3-7ea93ac7ba48@tuxon.dev>
Date: Fri, 9 Aug 2024 09:15:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Move i2c address/size to
 dtsi
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240528153109.439407-1-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240528153109.439407-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28.05.2024 18:31, Alexander Dahl wrote:
> These properties are common for all i2c subnodes, and marked as
> 'required' in atmel/microchip i2c bindings.  Allows to add i2c device
> nodes (like an rtc for example) in other .dts files including
> sam9x60.dtsi without requiring to repeat these properties for each i2c
> device again and again.
> 
> Found on a custom board after adding this in .dts:
> 
>     &flx5 {
>             atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
>             status = "okay";
> 
>             i2c5: i2c@600 {
>                     pinctrl-0 = <&pinctrl_flx5_default>;
>                     status = "okay";
> 
>                     pcf8523: rtc@68 {
>                             compatible = "nxp,pcf8523";
>                             reg = <0x68>;
>                     };
>             };
>     };
> 
> … which created a warning like this:
> 
>     […]:236.4-17: Warning (reg_format): 
> /ahb/apb/flexcom@f0004000/i2c@600/rtc@68:reg: property has invalid 
> length (4 bytes) (#address-cells == 2, #size-cells == 1)
>     […]: Warning (pci_device_reg): Failed prerequisite 'reg_format'
>     […]: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>     […]: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
>     
> […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: 
> Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect 
> #address-cells for I2C bus also defined at […]:228.16-238.4
>     
> […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: 
> Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect 
> #size-cells for I2C bus also defined at […]:228.16-238.4
>     […]: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>     […]: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
>     […]: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>     […]:234.19-237.5: Warning (avoid_default_addr_size): 
> /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default 
> #address-cells value
>     […]:234.19-237.5: Warning (avoid_default_addr_size): 
> /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #size-cells
>  value
>     […]: Warning (avoid_unnecessary_addr_size): Failed prerequisite 
> 'avoid_default_addr_size'
>     […]: Warning (unique_unit_address): Failed prerequisite 
> 'avoid_default_addr_size'
> 
> This probably should have been done with commit 84f23f3284d5 ("ARM: dts:
> at91: sam9x60: move flexcom definitions") already, where those
> address-cells and size-cells properties were left in the board .dts
> files instead of moving them to the dtsi.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>


Applied to at91-dt, thanks!

Please note that I've adjusted the commit message to reflect that the props
you've adjusted are not required anymore in the validation schema.

Thank you,
Claudiu Beznea

