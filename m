Return-Path: <linux-kernel+bounces-572844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2624BA6CF4D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47BC16A735
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C94A08;
	Sun, 23 Mar 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="szM2LWex"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BD17E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742733822; cv=none; b=MKxfR7GpLZ2NDma8wizVLVg6wDPSU3u8Gf8GZXW4LcS8Z7thLe1a4ESLZCRDFDBc2eA1V8y0y/MHRuZzWYwRZf7mb5R6rgfL2SW66UbpnnSqvvBJ7yumOMMNt3E1sRNMdfWX9YpG+KWEGTC3FjNRlOdc6esuyIY62fgfKHSI//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742733822; c=relaxed/simple;
	bh=8vrJCFYp3iTu+qpakxuqyLIEyiq47afnqskKzlP7VzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t61KpzvvKPfGd2yWOPLxmaTHTfMMWA+2XOmhwErvpN1nsHZZRuIrLApaW2PKmREAR527MmB0C5X0sl10Ldfx+pLFFLIA87J3elRcHtE12IpzhhXdzDsZlBHUwXJzRFX63bjDhnBCM5hfXQizkoyKSvA1tFkCuxiS3bH3HfAblhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=szM2LWex; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso29581665ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742733819; x=1743338619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auvkrCebWlfLIq+WFlOGHfpcgpD7BRjIeM5t/8b9kKY=;
        b=szM2LWexRRUAMVALFLvZErKJWgmxAThmhy3DMVABtBEe2kC2ZCo5yFQ2cERW7L82B8
         FCbINvzcdQWU5p+fPkpDRRxgluezh45Iam9XpgicUGiWGsoeZ/goZUTUTeOazhXaYSis
         uCf8nfAicrEJbx7oRKG/vx8koIH5cYgItSL1PoRBPWDI9+bwhJeF8NCED5KMDUkPHhe3
         fUVulRFWYBMYe8VQOMTfDpyCLRww6GZnbmvc7Ik9Erfwr/wzdR2RbScFktILo/QIry7H
         2Nivj5KxzcR9nrZQ9eQZuhUVftNiyrmNHh5jYc6p40qHicfEpmrmg/cC8o7oD4LuwGkl
         NHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742733819; x=1743338619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auvkrCebWlfLIq+WFlOGHfpcgpD7BRjIeM5t/8b9kKY=;
        b=FYjz7NfLSrDB7pqBsfBeCfiTkF0p34iKmqT6H9f4pSERcb+YIjfhN/a19YDaiwONO8
         dsP+0yL8Rz4GBgYOqi9AElnQa2ZScc6fWmLkhY+v9Qd2RtvWQrf5sKErZRRcJqYWauQL
         XsXhIfpI1Igt+RzjUv/RNyFMfsiZv08shkS34g2+M0zVI9I/o8JfD4HU1l/YxawO1jah
         UeOuwIJS2NnMDdCZW9f+yvCrancC/REU3l9TYivaezW6NleQMd7+tCTyq4cl5D8updcv
         gDx9rI///LYb8LJ+BN3WVXjso8uDyjDpYefm2N4RCgKdkO0qiFgfuzYnjv2gu+aiOVt/
         7zag==
X-Forwarded-Encrypted: i=1; AJvYcCVGg+thvzDGMnNOVOjypw3Dn8+RAXtXqyFgaLUbu3NqY//pd5O8tVQco5XgpVyXt8+CzAB/wbNWv61uO8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnIBc4sUC/fp/2KvpIliogC+A3sfAnjgQ2jZqnighhz+aW19J
	Frgr2vmQFZ3Ik8Z3+vx/7HenfWoP1H1Y/8G690qTjLlo6KOImuRHYCdbB5TR/pg=
X-Gm-Gg: ASbGnctD5BpGD/p2iq5K4cdj/ij/VPkc+pA5+nMPZ+eHaUN2dbUltolTZLYDoCTUbP+
	UX2mvKe3RBlqHwAEY/l1dlZ1M9tYuC9KLsccvot//r6Fgkw+qLGkjHjIqUyjIfanT/lQFukaOGN
	D/TfhQivY9YobAl6BDyKY6JNpzEgd19zD/N+Y8qPydeJJllJp5UMvSymCU8ZGz1iIZw6LkPbmMX
	jUDMIx1vgeayc+dSmeBKquwDskcsJ+ZldkOqny+Tn0c9noxwyVlScydxcW1/tNPSwy3MMbRix2N
	eK7bxzWKhu4vTFl+fJFGjE5seefTMZWQ1bEEev0a+jsWiMeUxiKlVaITwbh9PF2C9FdUHks5cg0
	3baetUyIEEDn+pAnxTw==
X-Google-Smtp-Source: AGHT+IHolVv/Y+bMPZ2b/V2gn+ZThy3WoAK0T+kaAaNK/SglD6p7yqAB145gRj2gAA/nXYWA0+d5Bg==
X-Received: by 2002:a05:6e02:2590:b0:3d3:fdcc:8fb0 with SMTP id e9e14a558f8ab-3d596190946mr105924855ab.20.1742733818442;
        Sun, 23 Mar 2025 05:43:38 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbe82f7fsm1330224173.83.2025.03.23.05.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 05:43:38 -0700 (PDT)
Message-ID: <45526855-17b2-4de4-8e12-6320b7d84c8e@riscstar.com>
Date: Sun, 23 Mar 2025 07:43:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/7] clk: spacemit: define struct k1_ccu_data
To: Yixun Lan <dlan@gentoo.org>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heylenay@4d2.org,
 guodong@riscstar.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, spacemit@lists.linux.dev, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-3-elder@riscstar.com> <20250322155034-GYB11633@gentoo>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250322155034-GYB11633@gentoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/25 10:50 AM, Yixun Lan wrote:
> Hi Alex:
> 
> this patch change relate to clock only, so how about let's fold
> it into clk patches (which now has not been merged), so we make
> the code right at first place? cause some moving around and renaming

No I don't want to do that.

The clock patches are Haylen's and the are getting closer to
acceptance.  Let's not confuse things by adding a bunch of new
functionality.  Get those patches in, and mine can follow not
too long after that.

					-Alex
> 
> On 10:18 Fri 21 Mar     , Alex Elder wrote:
>> Define a new structure type to be used for describing the OF match data.
>> Rather than using the array of spacemit_ccu_clk structures for match
>> data, we use this structure instead.
>>
>> Move the definition of the spacemit_ccu_clk structure closer to the top
>> of the source file, and add the new structure definition below it.
>>
>> Shorten the name of spacemit_ccu_register() to be k1_ccu_register().
> any good reason to change this? it make the code style inconsistent,
> do you just change it for shorten function, or want it to be more k1
> specific, so next SoC - e.g maybe k2? will introduce another function?
> 
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/clk/spacemit/ccu-k1.c | 58 ++++++++++++++++++++++++++---------
>>   1 file changed, 43 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
>> index 44db48ae71313..f7367271396a0 100644
>> --- a/drivers/clk/spacemit/ccu-k1.c
>> +++ b/drivers/clk/spacemit/ccu-k1.c
>> @@ -129,6 +129,15 @@
>>   #define APMU_EMAC0_CLK_RES_CTRL		0x3e4
>>   #define APMU_EMAC1_CLK_RES_CTRL		0x3ec
>>   
>> +struct spacemit_ccu_clk {
>> +	int id;
>> +	struct clk_hw *hw;
>> +};
>> +
>> +struct k1_ccu_data {
>> +	struct spacemit_ccu_clk *clk;		/* array with sentinel */
>> +};
>> +
>>   /*	APBS clocks start	*/
>>   
>>   /* Frequency of pll{1,2} should not be updated at runtime */
>> @@ -1359,11 +1368,6 @@ static CCU_GATE_DEFINE(emmc_bus_clk, CCU_PARENT_HW(pmua_aclk),
>>   		       0);
>>   /*	APMU clocks end		*/
>>   
>> -struct spacemit_ccu_clk {
>> -	int id;
>> -	struct clk_hw *hw;
>> -};
>> -
>>   static struct spacemit_ccu_clk k1_ccu_apbs_clks[] = {
>>   	{ CLK_PLL1,		&pll1.common.hw },
>>   	{ CLK_PLL2,		&pll2.common.hw },
>> @@ -1403,6 +1407,10 @@ static struct spacemit_ccu_clk k1_ccu_apbs_clks[] = {
>>   	{ 0,			NULL },
>>   };
>>   
>> +static const struct k1_ccu_data k1_ccu_apbs_data = {
>> +	.clk		= k1_ccu_apbs_clks,
>> +};
>> +
>>   static struct spacemit_ccu_clk k1_ccu_mpmu_clks[] = {
>>   	{ CLK_PLL1_307P2,	&pll1_d8_307p2.common.hw },
>>   	{ CLK_PLL1_76P8,	&pll1_d32_76p8.common.hw },
>> @@ -1440,6 +1448,10 @@ static struct spacemit_ccu_clk k1_ccu_mpmu_clks[] = {
>>   	{ 0,			NULL },
>>   };
>>   
>> +static const struct k1_ccu_data k1_ccu_mpmu_data = {
>> +	.clk		= k1_ccu_mpmu_clks,
>> +};
>> +
>>   static struct spacemit_ccu_clk k1_ccu_apbc_clks[] = {
>>   	{ CLK_UART0,		&uart0_clk.common.hw },
>>   	{ CLK_UART2,		&uart2_clk.common.hw },
>> @@ -1544,6 +1556,10 @@ static struct spacemit_ccu_clk k1_ccu_apbc_clks[] = {
>>   	{ 0,			NULL },
>>   };
>>   
>> +static const struct k1_ccu_data k1_ccu_apbc_data = {
>> +	.clk		= k1_ccu_apbc_clks,
>> +};
>> +
>>   static struct spacemit_ccu_clk k1_ccu_apmu_clks[] = {
>>   	{ CLK_CCI550,		&cci550_clk.common.hw },
>>   	{ CLK_CPU_C0_HI,	&cpu_c0_hi_clk.common.hw },
>> @@ -1610,9 +1626,13 @@ static struct spacemit_ccu_clk k1_ccu_apmu_clks[] = {
>>   	{ 0,			NULL },
>>   };
>>   
>> -static int spacemit_ccu_register(struct device *dev,
>> -				 struct regmap *regmap, struct regmap *lock_regmap,
>> -				 const struct spacemit_ccu_clk *clks)
>> +static const struct k1_ccu_data k1_ccu_apmu_data = {
>> +	.clk		= k1_ccu_apmu_clks,
>> +};
>> +
>> +static int k1_ccu_register(struct device *dev, struct regmap *regmap,
>> +			   struct regmap *lock_regmap,
>> +			   struct spacemit_ccu_clk *clks)
>>   {
>>   	const struct spacemit_ccu_clk *clk;
>>   	int i, ret, max_id = 0;
>> @@ -1648,15 +1668,24 @@ static int spacemit_ccu_register(struct device *dev,
>>   
>>   	clk_data->num = max_id + 1;
>>   
>> -	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
>> +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
>> +	if (ret)
>> +		dev_err(dev, "error %d adding clock hardware provider\n", ret);
>> +
>> +	return ret;
> I'd use "return 0;", nothing different, just explicitly short
> 
> ok, I can understand this change ease debug procedure once there is problem.
> (but I'm fine with either way, failure should rarely happen & will
> identify early)
> 
>>   }
>>   
>>   static int k1_ccu_probe(struct platform_device *pdev)
>>   {
>>   	struct regmap *base_regmap, *lock_regmap = NULL;
>>   	struct device *dev = &pdev->dev;
>> +	const struct k1_ccu_data *data;
>>   	int ret;
>>   
>> +	data = of_device_get_match_data(dev);
>> +	if (!data)
>> +		return -EINVAL;
>> +
>>   	base_regmap = device_node_to_regmap(dev->of_node);
>>   	if (IS_ERR(base_regmap))
>>   		return dev_err_probe(dev, PTR_ERR(base_regmap),
>> @@ -1677,8 +1706,7 @@ static int k1_ccu_probe(struct platform_device *pdev)
>>   					     "failed to get lock regmap\n");
>>   	}
>>   
>> -	ret = spacemit_ccu_register(dev, base_regmap, lock_regmap,
>> -				    of_device_get_match_data(dev));
>> +	ret = k1_ccu_register(dev, base_regmap, lock_regmap, data->clk);
>>   	if (ret)
>>   		return dev_err_probe(dev, ret, "failed to register clocks\n");
>>   
>> @@ -1688,19 +1716,19 @@ static int k1_ccu_probe(struct platform_device *pdev)
>>   static const struct of_device_id of_k1_ccu_match[] = {
>>   	{
>>   		.compatible	= "spacemit,k1-pll",
>> -		.data		= k1_ccu_apbs_clks,
>> +		.data		= &k1_ccu_apbs_data,
>>   	},
>>   	{
>>   		.compatible	= "spacemit,k1-syscon-mpmu",
>> -		.data		= k1_ccu_mpmu_clks,
>> +		.data		= &k1_ccu_mpmu_data,
>>   	},
>>   	{
>>   		.compatible	= "spacemit,k1-syscon-apbc",
>> -		.data		= k1_ccu_apbc_clks,
>> +		.data		= &k1_ccu_apbc_data,
>>   	},
>>   	{
>>   		.compatible	= "spacemit,k1-syscon-apmu",
>> -		.data		= k1_ccu_apmu_clks,
>> +		.data		= &k1_ccu_apmu_data,
>>   	},
>>   	{ }
> 	{ /* sentinel */ }
>>   };
>> -- 
>> 2.43.0
>>
> 


