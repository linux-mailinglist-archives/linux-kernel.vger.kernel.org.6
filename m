Return-Path: <linux-kernel+bounces-354427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 924D4993D57
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E20AB2293E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5233986;
	Tue,  8 Oct 2024 03:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeL3rWCn"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2416D25779;
	Tue,  8 Oct 2024 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356836; cv=none; b=Z60NQ20SRcxlqnUFUzVj3aB8xQxoNVJQLvfxFAOYX9ALk4l8NCMlCj09sukfHKi9LnDZ1dBo/qtp12pZw2U8Mrlv5doKwD0nXy+sTXzXbuAYycn8zMW4E9Y/eVrliucBlEXIRIiaM7Tku0IYDI65xNZzc1II46nrtH+TOo9+cRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356836; c=relaxed/simple;
	bh=gCowcvLZ856q3VqIFCDmSkug+EjHf/oYYLE+2weGyaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mD6fNemYI2lN62kYnq0TFSJqGcQauifhqP0bQ/t52usTRCrXMf/KHyznIuPlXosk1eMAdCUYQNNXvJLvJ1wwhDBqQpf9c81dnsneLn2FfloHpj10R7sbem4r5EjRDZSDjRmqk7n4J0Z0+X7nJuAQUDu7qR8+7jhK3it+oteT3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeL3rWCn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0ad414718so585571a91.2;
        Mon, 07 Oct 2024 20:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728356834; x=1728961634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iUEZcciJrrtCxrQ9GRGdW8hIdm0bQGx8cBqztK/kqVE=;
        b=DeL3rWCnVmKwT39tqHSabVW3wFTfKSiDgAZtf+tteRgYnYTbsvFZzCcCNhZ8DcDFg6
         wa2a7puAqFE9Gz5fni23+DqohzvwX4qI60iLO00TOQNJ5ruCxJqutcicRXs5lXGS2+zs
         v3dkmMFXMma7hrMtPQS8+wS+uRuKDR8Rd79/dEk8F4Yyu06Gh5cmmjDiXxRhm06gHcb+
         7hDVfGHau4J5v5BATmsnFPZDk0rLYRJIK889x5dP9UlTlZxKezmP30cNrhiOGID7H5O4
         czK5w03VVzenNA7TGpoLts/ck/LxpnK6m5TSBwuvmd0HVBEBdjcd5FZphOUz2l8LWA9A
         RxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356834; x=1728961634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUEZcciJrrtCxrQ9GRGdW8hIdm0bQGx8cBqztK/kqVE=;
        b=Qwv9GAiQfWoJeon9T1+cYflBuiem75uOKWDGno9cvtOKAAKJzwrUvrM1IJQXJVtrDU
         ZU6UfkXtvu/zBY081p+1mJKtl4p/zmd0iyX5/oRC2eamdfYo+d8ovOugIOFG3wjqhPFh
         5gOajlApYyVVU49RxD/L0PUarK39p5r+T+zR0wx8hdDqIucqsElnWBRY3m/uJoV2M09j
         h1aBOqVPIXDZ4Y6EiIw5YEqcYU92scSXVFq3QAD/SXBM2iad/VFD6BQJZ6tUWWoin0Je
         6nPYu3pqD1ubYfRrzntNjxpLj4VLUUG6VBYREFCSgJrmvvFwaMdWhm9B+nQDcb+cdIHF
         a/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKg30YUqedY67qrEhd93XSTnuxXQXLbAerjT6nipY60Txe2loPM2mNRI0uuylBJWLN7M9Nz2m9olGr@vger.kernel.org, AJvYcCWU5SiWqpN6ofGXu9YKf7SlPnXxMBMbfUmkjwar7nwyH58NgVejD8DwjUnxFdVB+2sLBiWft0ZVJ3V1pX4T@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjrK5fBRBIxmB51c5q9yQNcQlJu/FVd3aVx5SgL0og6cv+q0+
	RpRmyiik7Ap4ZcuYYwTak0+2L31BbAH7SD5g6SaU59VzLKooCFS9
X-Google-Smtp-Source: AGHT+IHI3PrHh1lJM0vzHu+NddQsCN10C7/Uq91IKP/BCHMuma6y//FuC0alSdAYUJMdSIanFBdlPw==
X-Received: by 2002:a17:90a:d083:b0:2db:60b:9be5 with SMTP id 98e67ed59e1d1-2e1e63b35f2mr6898844a91.8.1728356834284;
        Mon, 07 Oct 2024 20:07:14 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e866583esm8018015a91.37.2024.10.07.20.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 20:07:13 -0700 (PDT)
Message-ID: <13fe91e1-2471-4a59-9581-628ce7773fdc@gmail.com>
Date: Tue, 8 Oct 2024 11:07:09 +0800
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
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <jx55slsincpzq6mugfsyc6qpbku2555azj7lithwggo733ggnb@rkqsxpsyoaw7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,
On 2024/9/30 3:38, Krzysztof Kozlowski wrote:
> On Sun, Sep 29, 2024 at 02:10:23PM +0800, Frank Wang wrote:
>> From: Frank Wang <frank.wang@rock-chips.com>
>>
>> Since some Rockchip SoCs (e.g RK3576) have more than one clock,
>> this converts the clock management from single to bulk method to
>> make the driver more flexible.
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>> Changelog:
>> v4:
>>   - a new patch split from the [PATCH v3 2/2], suggestions from Heiko.
>>
>> v1-v3:
>>   - none
>>
>>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 43 ++++++++++++++++---
>>   1 file changed, 36 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> index 4f71373ae6e1..ad3e65dc6aa4 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> @@ -229,9 +229,10 @@ struct rockchip_usb2phy_port {
>>    * @dev: pointer to device.
>>    * @grf: General Register Files regmap.
>>    * @usbgrf: USB General Register Files regmap.
>> - * @clk: clock struct of phy input clk.
>> + * @clks: array of phy input clocks.
>>    * @clk480m: clock struct of phy output clk.
>>    * @clk480m_hw: clock struct of phy output clk management.
>> + * @num_clks: number of phy input clocks.
>>    * @phy_reset: phy reset control.
>>    * @chg_state: states involved in USB charger detection.
>>    * @chg_type: USB charger types.
>> @@ -246,9 +247,10 @@ struct rockchip_usb2phy {
>>   	struct device	*dev;
>>   	struct regmap	*grf;
>>   	struct regmap	*usbgrf;
>> -	struct clk	*clk;
>> +	struct clk_bulk_data	*clks;
>>   	struct clk	*clk480m;
>>   	struct clk_hw	clk480m_hw;
>> +	int			num_clks;
>>   	struct reset_control	*phy_reset;
>>   	enum usb_chg_state	chg_state;
>>   	enum power_supply_type	chg_type;
>> @@ -310,6 +312,13 @@ static int rockchip_usb2phy_reset(struct rockchip_usb2phy *rphy)
>>   	return 0;
>>   }
>>   
>> +static void rockchip_usb2phy_clk_bulk_disable(void *data)
>> +{
>> +	struct rockchip_usb2phy *rphy = data;
>> +
>> +	clk_bulk_disable_unprepare(rphy->num_clks, rphy->clks);
>> +}
>> +
>>   static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
>>   {
>>   	struct rockchip_usb2phy *rphy =
>> @@ -376,7 +385,9 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
>>   {
>>   	struct device_node *node = rphy->dev->of_node;
>>   	struct clk_init_data init;
>> +	struct clk *refclk = NULL;
>>   	const char *clk_name;
>> +	int i;
>>   	int ret = 0;
>>   
>>   	init.flags = 0;
>> @@ -386,8 +397,15 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
>>   	/* optional override of the clockname */
>>   	of_property_read_string(node, "clock-output-names", &init.name);
>>   
>> -	if (rphy->clk) {
>> -		clk_name = __clk_get_name(rphy->clk);
>> +	for (i = 0; i < rphy->num_clks; i++) {
>> +		if (!strncmp(rphy->clks[i].id, "phyclk", 6)) {
>> +			refclk = rphy->clks[i].clk;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!IS_ERR(refclk)) {
>> +		clk_name = __clk_get_name(refclk);
>>   		init.parent_names = &clk_name;
>>   		init.num_parents = 1;
>>   	} else {
>> @@ -1406,18 +1424,29 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>>   	if (IS_ERR(rphy->phy_reset))
>>   		return PTR_ERR(rphy->phy_reset);
>>   
>> -	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
>> -	if (IS_ERR(rphy->clk)) {
>> -		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
>> +	ret = devm_clk_bulk_get_all(dev, &rphy->clks);
>> +	if (ret == -EPROBE_DEFER) {
> This does not make much sense. Why would you proceed on other critical
> errors?
>
> You want to use optional variant, I guess?

Yes, the clock properties are optional.


Best regards,
Frank

> Best regards,
> Krzysztof
>


