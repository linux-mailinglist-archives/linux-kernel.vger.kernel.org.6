Return-Path: <linux-kernel+bounces-314238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A8096B053
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EF31C21106
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A001783CC7;
	Wed,  4 Sep 2024 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPUTKyIT"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1356282866
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426471; cv=none; b=CxsQNpweazWw6GGDdj7yuqYBdRiFV8EuAd+JQMVJuftVfE5qls/ZgrSKSL65k2+OaMXrwsRNGhOUVFWkAQ+L2QYLA17+jjI6OqzLqY/RbmmALeIveM2A69AAbjVJ6brhRNdLdpWMPfOvuZdHnFgcQHbe/69OWWYaxXjgfDs4WYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426471; c=relaxed/simple;
	bh=E3SgS0llTnNLgcBy/jdYtH24qp5/TeZA1tvIcdhQ1l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBzyLD8HieSzX/lSgGqLvPrCb3gmUqIetpNDbKPkas2vFcJFKSvfTX6Hz3PhrAr8NKg/3zs5O5q9QqeQ2OEnk/gqa055FQd2SP/tEyoljpq2XSmmfSzsc6yHpexfhsjrdMS/aIqdNwDaGqmKYm2hVYMq/xbhzcHszbMdlR/1+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPUTKyIT; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5334879ba28so8431869e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 22:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725426468; x=1726031268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VEKTychXIGeJQrvQK+3MyXkD6os2xuP0kilGLrMUOg=;
        b=UPUTKyITj5YDo0ixwwqS0FL5ur2O2KODl2nvHkOqLTM1MSFa93YrdphWUx5Eqgsju3
         Lz8sFZpA9T9wmLme9TpgAb6CXYbf9MKbjf62qpf5EHdRaPm4m/kUx+WCdO7OvuGFRL1H
         osYCHbVy2aojjw9z9O9MCJoEJfiIWhs3d/J4Ce8F2ldbbr/heHwWK5u1XB35R+BrpILC
         xKNcb15GY7xHmIRqYMqNtc3kEJbdaNSOkTiWlePrO5SL2ieCN/nmWQUJJoKSaKDDg4cO
         oaHPn52IlIjsmsXXeVEWww1AYvP0RKI97YOS4zkoW/JCP8y/v7SuoPYRzRUGXY8WlqkR
         F1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426468; x=1726031268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VEKTychXIGeJQrvQK+3MyXkD6os2xuP0kilGLrMUOg=;
        b=G9IupBIZNxGBHLHAthTOcFyQ3IAoNc3pMaNtxEFvC2XoqYIK7tQ41PUeWz3meNlQO3
         x/SvVL/LzwJVVQQOvjIpakHrD2z0abNoMW8u2C/X5S7K/Som0h+FlpCMv6uMNYAhoQ1d
         OPBEeb+IyfjZ2tPrN5+YBPoLE5oIfUeN0gJRN+Kwlt7Tb7Gt5Ltn59/AvC5S5Y0TvN3N
         TEdD1K69AyXcvGLBOVZJF2Kpk1O9CLa2Z0LPVeW6Ll1zhNXkBmeONUPxqjSkyubvkqgV
         HW7QQnj4BqOU0RZAs8oWoJ8EJQ1H1iNNlX4/6Xm6evCWbWCk4jNHLv/JHIGJzjD1wJJq
         u18Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCfDVQm7Hc2p/zDuOqHUbB2xxv3HyhDZDA/FC/TxL8YE5uhBKMXF4qlmfZpbJGFnha5wUOKwsY3OxdWKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJkgZdMRdplU6mhlPS+BhZZ9s+voe3XHxcCcZIgPum9Gp0gF4
	3z1usOPcoMbrBXVsdj9P9gtsf9Vi3XxEl6A7v32EkIrc0as9UEMv
X-Google-Smtp-Source: AGHT+IFEufPrtEOIsfIHrZP9wNoA5RUffqnBOD7tN5G+I1ii3z1JK1NU5TmnfU4Kyyik14+xOiUzeA==
X-Received: by 2002:a05:6512:128b:b0:52c:86d7:fa62 with SMTP id 2adb3069b0e04-53546b0bb24mr10947999e87.23.1725426467002;
        Tue, 03 Sep 2024 22:07:47 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535698a6729sm3947e87.221.2024.09.03.22.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 22:07:45 -0700 (PDT)
Message-ID: <71414d3b-dc0c-4b33-a4df-16ef9cea1380@gmail.com>
Date: Wed, 4 Sep 2024 08:07:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mfd: bd96801: Add ERRB IRQ
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1724655894.git.mazziesaccount@gmail.com>
 <05b576f3eef81a21cb9b4bcebee4873b7aafb4af.1724655894.git.mazziesaccount@gmail.com>
 <20240830072822.GS6858@google.com>
 <dbdfbcd1-3f18-4ca5-9d4c-3c35bb3dee48@gmail.com>
 <20240903143718.GX6858@google.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240903143718.GX6858@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 17:37, Lee Jones wrote:
> On Fri, 30 Aug 2024, Matti Vaittinen wrote:
> 
>> On 8/30/24 10:28, Lee Jones wrote:
>>> On Mon, 26 Aug 2024, Matti Vaittinen wrote:
>>>
>>>> The ROHM BD96801 "scalable PMIC" provides two physical IRQs. The ERRB
>>>> handling can in many cases be omitted because it is used to inform fatal
>>>> IRQs, which usually kill the power from the SOC.
>>>>
>>>> There may however be use-cases where the SOC has a 'back-up' emergency
>>>> power source which allows some very short time of operation to try to
>>>> gracefully shut down sensitive hardware. Furthermore, it is possible the
>>>> processor controlling the PMIC is not powered by the PMIC. In such cases
>>>> handling the ERRB IRQs may be beneficial.
>>>>
>>>> Add support for ERRB IRQs.
>>
>> Thanks for the review Lee! :)
>>
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> ---
>>>> Revision history:
>>>> New series (only ERRB addition)
>>>> v1:
>>>> 	- use devm allocation for regulator_res
>>>> 	- use goto skip_errb instead of an if (errb)
>>>> 	- constify immutable structs
>>>>
>>>> Old series (All BD96801 functionality + irqdomain and regmap changes)
>>>> v2 => v3:
>>>> 	- No changes
>>>> v1 => v2:
>>>> 	- New patch
>>>>
>>>> mfd: constify structs
>>>> ---
>>>>    static int bd96801_i2c_probe(struct i2c_client *i2c)
>>>>    {
>>>> -	struct regmap_irq_chip_data *intb_irq_data;
>>>> +	int i, ret, intb_irq, errb_irq, num_regu_irqs, num_intb, num_errb = 0;
>>>> +	int wdg_irq_no;
>>>
>>> Nit: Not sure why the smaller data elements have been placed at the top.
>>
>> Because some people have told me it's easier for them to read the local
>> variable declarations when the code is formatted to "reverse xmas-tree"
>> -style. I suppose I've tried to follow that here.
>>
>>> They were better down where they were.
>>
>> My old personal preference has just been to have 'simple' integer types
>> first, then structs, and the pointers last. I don't think having xmas-tree
>> (reversed or not) plays a role in my code-reading ability...
>>
>> I won't re-spin the series just for this, if this is just a 'nit'. I will
>> try to remember the comment if I need to rebase / respin this later though
>> :)
> 
> Please leave them were they are.

I suppose this is a request to leave them where they are in-tree code 
now - not to leave them where they are in this patch :) I'll re-spin 
this anyways for the print below. So, I might as well revert the local 
variable formatting here :)

>>>> +	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
>>>> +	struct irq_domain *intb_domain, *errb_domain;
>>>> +	struct resource wdg_irq;
>>>>    	const struct fwnode_handle *fwnode;
>>>> -	struct irq_domain *intb_domain;
>>>> +	struct resource *regulator_res;
>>>>    	struct regmap *regmap;
>>>> -	int ret, intb_irq;
>>>>    	fwnode = dev_fwnode(&i2c->dev);
>>>>    	if (!fwnode)
>>>> @@ -213,6 +364,23 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
>>>>    	if (intb_irq < 0)
>>>>    		return dev_err_probe(&i2c->dev, intb_irq, "INTB IRQ not configured\n");
>>>> +	num_intb =  ARRAY_SIZE(regulator_intb_irqs);
>>>> +
>>>> +	/* ERRB may be omitted if processor is powered by the PMIC */
>>>> +	errb_irq = fwnode_irq_get_byname(fwnode, "errb");
>>>> +	if (errb_irq < 0)
>>>> +		errb_irq = 0;
>>>> +
>>>> +	if (errb_irq)
>>>> +		num_errb = ARRAY_SIZE(regulator_errb_irqs);
>>>> +
>>>> +	num_regu_irqs = num_intb + num_errb;
>>>> +
>>>> +	regulator_res = devm_kcalloc(&i2c->dev, num_regu_irqs,
>>>> +				     sizeof(*regulator_res), GFP_KERNEL);
>>>> +	if (!regulator_res)
>>>> +		return -ENOMEM;
>>>> +
>>>>    	regmap = devm_regmap_init_i2c(i2c, &bd96801_regmap_config);
>>>>    	if (IS_ERR(regmap))
>>>>    		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
>>>> @@ -226,16 +394,54 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
>>>>    				       IRQF_ONESHOT, 0, &bd96801_irq_chip_intb,
>>>>    				       &intb_irq_data);
>>>>    	if (ret)
>>>> -		return dev_err_probe(&i2c->dev, ret, "Failed to add INTB IRQ chip\n");
>>>> +		return dev_err_probe(&i2c->dev, ret, "Failed to add INTB irq_chip\n");
> 
> Kernel logs are user facing.  The previous message was better.
> 
> Please drop this change.

Good catch. This has been an unintended change. Not sure where this 
originated from.


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


