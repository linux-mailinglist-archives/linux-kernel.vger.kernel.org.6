Return-Path: <linux-kernel+bounces-356390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDBB996059
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9661C23817
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB65D17BB0F;
	Wed,  9 Oct 2024 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYUDis1c"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8F1362;
	Wed,  9 Oct 2024 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457836; cv=none; b=mZ+AJqXphhdawxWhDjBSkU+V54BR/ewvN1cJGCv2dRSO2Vzgj97z3jZFZFgwCvMYf+qqbZnRHXAd+f5YEoEPqCkU5bSe1Ba9Snq+4Dr4TvFJU+yHlaliH3jGLqroC8SZI8V2u+BtqFMvTeV4S/2WjpViuhCfZaCYAAliuUxL06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457836; c=relaxed/simple;
	bh=378j02AjdJZcYvP0BCMcrpUqd1qmoGsNIP/1Xg4ZgO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX25sMCROOuYG6GNQ+iQX/QFt9LXXDKoRShV293E198shXxYarSiGMiQn+D5EgGR0vRb7SzpkXLawmOC6RGQAvrEHVqiviH3d81fx5eTra35Otqk2X3N4U3RJ5emZhKVr0JvWsKqlryprp5v2Bn8FTfOgyktlknyPkHLKu7+jwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYUDis1c; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71debacf27bso381210b3a.2;
        Wed, 09 Oct 2024 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728457834; x=1729062634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sA8Y4eO9DcSC+vvwrFGajiYdfHlpHkYXHi8cuKJox4c=;
        b=ZYUDis1c/y+hzKpoXPXfKs5/q8J/SDMoXwBOG54gVdeD/urqgWptKbyLP6aGNDGSrY
         dmLlejWuvMii+xSmln0bsjdeOe2drYdJFzZO6/QqFq/4rQ3rG3Pb4OyOOmNyWbYbfaGw
         F/rzFa5eeQ5eV/M54L7hkx2Rl1GebjaXuBdxtYcFvetgalsYtbMLbtI9g4yWzG7nIuYS
         IhxbqGs4jNt+IAhBhcNjmCy7tQUAiRwfkPjJYHzGjZ4DtY6Az2uv5rWzsTyEum1OJLSw
         ibmYMcLnJWyXCyrBJpU4mVJH2L8LooK+Z6e0B614HNUaQJ695/Ovy17+EvG2JzC+SorG
         M/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728457834; x=1729062634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sA8Y4eO9DcSC+vvwrFGajiYdfHlpHkYXHi8cuKJox4c=;
        b=pIStoi8CnnmlnlC+V2fwvJkX46BcqCX/1bCa3p2O2CoE428DARvjU3aHvpmqsayjAt
         aClFcxjZ6wilsv854UsB963qZVqevtclZn+PHXYCOdd+qrzlVlTMqGk614HmzevhQ8yX
         QmwPickZVO7UXY5FZuVNCeBqXU9MIvEKs9D0Ln0aH3X2aHCIukW/ezxehnsbTQ4eP+MR
         j0xxjTZa9FyiskRLQU1IDHtjkWd9zPGXBCDRSYLtpc/9GE+1q1Oq1HQ6C8hxNCBNJviq
         ci5g4Z3Ck+tIbn0T5S6fA1yNafkkrLkjR257nXZ/tudhJwNuFL9wLp7ydJpSUFk24W/x
         EiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFdx8FUgSH6HqjihO9WTXy1B/qHlDVblnyVhAH8HGBohYTSfNdifdW6UqlEdyZm9jy4aLyEhWK5obq@vger.kernel.org, AJvYcCWl5GeZCgxgesZNnR4exD4McHVcYijW7WKEmuYJ47HXZ4ms8alQRzmCyn3v+UHA1Nr21CH8ULB9D0IZPWHq@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPugPP41oipbtRWU1r9ObZObQe+ofdciU92y1sic9L2gy8iX+
	Z6phAN8g5HfYb6+iF8+5b20fKI3H08gV4NlsWCc3CP71gVbjrzS+
X-Google-Smtp-Source: AGHT+IGjE88HafuAoQFV3trG2JzG5OQbr90aV7B+X/5s9VONZ08F7MICUKjVTHucGreZK18x0dC4MA==
X-Received: by 2002:a05:6a00:1310:b0:717:9443:9c70 with SMTP id d2e1a72fcca58-71e1db67245mr995726b3a.2.1728457834041;
        Wed, 09 Oct 2024 00:10:34 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d66319sm7160068b3a.156.2024.10.09.00.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 00:10:33 -0700 (PDT)
Message-ID: <e1bbcaa7-bac6-4288-9c5c-ae5a292e1d1f@gmail.com>
Date: Wed, 9 Oct 2024 15:10:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] phy: rockchip: inno-usb2: convert clock management
 to bulk
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com, frank.wang@rock-chips.com
References: <20240929061025.3704-1-frawang.cn@gmail.com>
 <jx55slsincpzq6mugfsyc6qpbku2555azj7lithwggo733ggnb@rkqsxpsyoaw7>
 <13fe91e1-2471-4a59-9581-628ce7773fdc@gmail.com>
 <ac325385-cb3e-4002-b100-de73eb5a9ac7@kernel.org>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <ac325385-cb3e-4002-b100-de73eb5a9ac7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2024/10/8 22:35, Krzysztof Kozlowski wrote:
> On 08/10/2024 05:07, Frank Wang wrote:
>>>> +	}
>>>> +
>>>> +	if (!IS_ERR(refclk)) {
>>>> +		clk_name = __clk_get_name(refclk);
>>>>    		init.parent_names = &clk_name;
>>>>    		init.num_parents = 1;
>>>>    	} else {
>>>> @@ -1406,18 +1424,29 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>>>>    	if (IS_ERR(rphy->phy_reset))
>>>>    		return PTR_ERR(rphy->phy_reset);
>>>>    
>>>> -	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
>>>> -	if (IS_ERR(rphy->clk)) {
>>>> -		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
>>>> +	ret = devm_clk_bulk_get_all(dev, &rphy->clks);
>>>> +	if (ret == -EPROBE_DEFER) {
>>> This does not make much sense. Why would you proceed on other critical
>>> errors?
>>>
>>> You want to use optional variant, I guess?
>> Yes, the clock properties are optional.
> And? So are you going to use optional variant of clk get or not? Is it
> appropriate? Are you going to improve it?

Using devm_clk_bulk_get_all() not only get clk_bulk_data, but also can 
get num_clks.
The clocks numbers (num_clks) are used for search the ref_clk in 
rockchip_usb2phy_clk480m_register().

However, right now, the optional variant of clk_*_optional functions can 
not get num_clks, or must know num_clks, then can get clk_bulk_data.


Best regards,
Frank

> Best regards,
> Krzysztof
>


