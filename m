Return-Path: <linux-kernel+bounces-308373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C3965C25
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6321F24348
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4E16DC3C;
	Fri, 30 Aug 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLy6Eel/"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2B13635E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008066; cv=none; b=pZk+sKW+Gxlp995VBsxRZsmAFDkSPcTMbcmsADfVx+2J4M/imACwVGDV7wvZg1FNPXwgTATRCw5KbbP/GTgGVHOR2hmp/Lo9zUA30VvoCkEvxX5BlxVlaUtIvubLx5RfzCo/FYzDjqhaLhzPKVYI3dRiU/iqRhfxGtorggN0GXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008066; c=relaxed/simple;
	bh=celhm0wtDwYC+SIHagOCjLlx2XJ1ZUOaB1ot7WqEnMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMDgnNQsu5xXqndb9VSLoGaNGyhMhdma1y4kqzo5ijQxHov/UDPUh6OInNQKZL41f7HlDoGZ5J+9e8OUMI78g4+ZKP7BuiJLRmPFXpMTNi0IdcwX0kNFDX9r6UOsfElxxwzuWpOm2zKeneUUgRpfwZKzrNjkCLhEE29+ll/3wQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLy6Eel/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53343bf5eddso1973304e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725008063; x=1725612863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WrWhU9ourC9aWMQqphiza9x/e0EYakuWRjxzFyXTHg=;
        b=gLy6Eel/e8778gQ46qFwcsFptSKSlcjwBq4+66vUnqNzOkeeCMBMnnkp9Tdbsuil/v
         nSl3zeEEHYbcEyrYYjfj1rWRYVHVanLUsPla+Gq6qZGVTE7/3xNsox4oM5mihMyAc4uW
         mIoZJjLODb+B8wwQQ1EThsPRGJ7iemsD7TuGQUkiW797Cc4ObJOMTKd2vICP01jruhX7
         SXmrefBH+NEHOvneA6sbkZRVwxGefhnFN5DG8P+6UgvWzoU2IvnSz1cDOSCwRvt3GuAT
         7ijsIoSRkzEEufN7LRpDXEOYW0Rsxr0Ndu+t01yQC/0GPgow2NtLs7ESECjacyGeQFGF
         EdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725008063; x=1725612863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WrWhU9ourC9aWMQqphiza9x/e0EYakuWRjxzFyXTHg=;
        b=HaiGhV6yUn4pfDVtR9UTFohr+GTPAbV3mdsHvKPXWqYNvQHpCLg1R88U3PqoVwH5sC
         rvhQypLutvMae1wj9lVqdMi/vn8pP7166znwY2RwionUIMim7s1fcHS0zyDLg89yRlUs
         RrAHRnsRCpqm0f67g3L6ozI7RdQN+4PhITfvFXxx+spRiuppn3Y2n8/fU/7BsCXEZJVM
         0SrnLE/tlK16Jmcqk7vNcxMA5IeutIHShuGFcFBohbhhxVYzFmZGdbC/hooVkvLL5wvi
         PNCHvIuyOLA0SYRjmIoEan+RwG0ezIBXoJAlobVHc6gbx81ji13RdfJjKLxYz0/uh1oM
         HdhA==
X-Forwarded-Encrypted: i=1; AJvYcCVUXiNmaqBlu/UhbLciOirmnK3m2jv3D/VEkupGCTpFkqBgGr8VzCQlNtczh9LJHDU5iwAW31zrrYhghAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMHQd06E0JMvnvZIDzCLwqd/WABpEKe6oe0d2PVe8B2I0HWjT5
	nOxxUD8RtD0JMdgWn5r5jcv94ZTs5vAKb9iuGuvYTZuQbn9zUv9BNzLDtg==
X-Google-Smtp-Source: AGHT+IH+UhqaBMnC79CAG4HW73DfTDqR+Ko2xSjeWOuRQnPh4n6KEja2QSNCJP8rpBSbT5KA46vFHQ==
X-Received: by 2002:a05:6512:1383:b0:52f:c148:f5e4 with SMTP id 2adb3069b0e04-53546b3687dmr1045674e87.21.1725008062355;
        Fri, 30 Aug 2024 01:54:22 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac13fsm486539e87.94.2024.08.30.01.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:54:21 -0700 (PDT)
Message-ID: <dbdfbcd1-3f18-4ca5-9d4c-3c35bb3dee48@gmail.com>
Date: Fri, 30 Aug 2024 11:54:20 +0300
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
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240830072822.GS6858@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 10:28, Lee Jones wrote:
> On Mon, 26 Aug 2024, Matti Vaittinen wrote:
> 
>> The ROHM BD96801 "scalable PMIC" provides two physical IRQs. The ERRB
>> handling can in many cases be omitted because it is used to inform fatal
>> IRQs, which usually kill the power from the SOC.
>>
>> There may however be use-cases where the SOC has a 'back-up' emergency
>> power source which allows some very short time of operation to try to
>> gracefully shut down sensitive hardware. Furthermore, it is possible the
>> processor controlling the PMIC is not powered by the PMIC. In such cases
>> handling the ERRB IRQs may be beneficial.
>>
>> Add support for ERRB IRQs.

Thanks for the review Lee! :)

>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Revision history:
>> New series (only ERRB addition)
>> v1:
>> 	- use devm allocation for regulator_res
>> 	- use goto skip_errb instead of an if (errb)
>> 	- constify immutable structs
>>
>> Old series (All BD96801 functionality + irqdomain and regmap changes)
>> v2 => v3:
>> 	- No changes
>> v1 => v2:
>> 	- New patch
>>
>> mfd: constify structs
>> ---
>>   
>>   static int bd96801_i2c_probe(struct i2c_client *i2c)
>>   {
>> -	struct regmap_irq_chip_data *intb_irq_data;
>> +	int i, ret, intb_irq, errb_irq, num_regu_irqs, num_intb, num_errb = 0;
>> +	int wdg_irq_no;
> 
> Nit: Not sure why the smaller data elements have been placed at the top.

Because some people have told me it's easier for them to read the local 
variable declarations when the code is formatted to "reverse xmas-tree" 
-style. I suppose I've tried to follow that here.

> They were better down where they were.

My old personal preference has just been to have 'simple' integer types 
first, then structs, and the pointers last. I don't think having 
xmas-tree (reversed or not) plays a role in my code-reading ability...

I won't re-spin the series just for this, if this is just a 'nit'. I 
will try to remember the comment if I need to rebase / respin this later 
though :)

>> +	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
>> +	struct irq_domain *intb_domain, *errb_domain;
>> +	struct resource wdg_irq;
>>   	const struct fwnode_handle *fwnode;
>> -	struct irq_domain *intb_domain;
>> +	struct resource *regulator_res;
>>   	struct regmap *regmap;
>> -	int ret, intb_irq;
>>   
>>   	fwnode = dev_fwnode(&i2c->dev);
>>   	if (!fwnode)
>> @@ -213,6 +364,23 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
>>   	if (intb_irq < 0)
>>   		return dev_err_probe(&i2c->dev, intb_irq, "INTB IRQ not configured\n");
>>   
>> +	num_intb =  ARRAY_SIZE(regulator_intb_irqs);
>> +
>> +	/* ERRB may be omitted if processor is powered by the PMIC */
>> +	errb_irq = fwnode_irq_get_byname(fwnode, "errb");
>> +	if (errb_irq < 0)
>> +		errb_irq = 0;
>> +
>> +	if (errb_irq)
>> +		num_errb = ARRAY_SIZE(regulator_errb_irqs);
>> +
>> +	num_regu_irqs = num_intb + num_errb;
>> +
>> +	regulator_res = devm_kcalloc(&i2c->dev, num_regu_irqs,
>> +				     sizeof(*regulator_res), GFP_KERNEL);
>> +	if (!regulator_res)
>> +		return -ENOMEM;
>> +
>>   	regmap = devm_regmap_init_i2c(i2c, &bd96801_regmap_config);
>>   	if (IS_ERR(regmap))
>>   		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
>> @@ -226,16 +394,54 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
>>   				       IRQF_ONESHOT, 0, &bd96801_irq_chip_intb,
>>   				       &intb_irq_data);
>>   	if (ret)
>> -		return dev_err_probe(&i2c->dev, ret, "Failed to add INTB IRQ chip\n");
>> +		return dev_err_probe(&i2c->dev, ret, "Failed to add INTB irq_chip\n");
>>   
>>   	intb_domain = regmap_irq_get_domain(intb_irq_data);
>>   
>> -	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
>> -				   bd96801_cells,
>> -				   ARRAY_SIZE(bd96801_cells), NULL, 0,
>> -				   intb_domain);
>> +	/*
>> +	 * MFD core code is built to handle only one IRQ domain. BD96801
>> +	 * has two domains so we do IRQ mapping here and provide the
>> +	 * already mapped IRQ numbers to sub-devices.
>> +	 */
> 
> Do one or more of the subdevices consume both domains?

I believe the regulators consume both.

> If not, why not call devm_mfd_add_devices() twice?

Thanks for this suggestion :) It didn't occur to me I could do that. 
Well, here I need both domains for regulators so it probably wouldn't 
work - but maybe I will remember this is a viable option for future 
designs! Thanks!

> 
>> +	for (i = 0; i < num_intb; i++) {
>> +		struct resource *res = &regulator_res[i];
>> +
>> +		*res = regulator_intb_irqs[i];
>> +		res->start = res->end = irq_create_mapping(intb_domain,
>> +							    res->start);
>> +	}
>> +
>> +	wdg_irq_no = irq_create_mapping(intb_domain, BD96801_WDT_ERR_STAT);
>> +	wdg_irq = DEFINE_RES_IRQ_NAMED(wdg_irq_no, "bd96801-wdg");
>> +	bd96801_cells[WDG_CELL].resources = &wdg_irq;
>> +	bd96801_cells[WDG_CELL].num_resources = 1;
>> +
>> +	if (!num_errb)
>> +		goto skip_errb;
>> +
>> +	ret = devm_regmap_add_irq_chip(&i2c->dev, regmap, errb_irq, IRQF_ONESHOT,
>> +				       0, &bd96801_irq_chip_errb, &errb_irq_data);
>> +	if (ret)
>> +		return dev_err_probe(&i2c->dev, ret,
>> +				     "Failed to add ERRB (%d) irq_chip\n", errb_irq);
>> +
>> +	errb_domain = regmap_irq_get_domain(errb_irq_data);
>> +
>> +	for (i = 0; i < num_errb; i++) {
>> +		struct resource *res = &regulator_res[num_intb + i];
>> +
>> +		*res = regulator_errb_irqs[i];
>> +		res->start = res->end = irq_create_mapping(errb_domain, res->start);
>> +	}
>> +
>> +skip_errb:
>> +	bd96801_cells[REGULATOR_CELL].resources = regulator_res;
>> +	bd96801_cells[REGULATOR_CELL].num_resources = num_regu_irqs;
>> +
>> +	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, bd96801_cells,
>> +				   ARRAY_SIZE(bd96801_cells), NULL, 0, NULL);
>>   	if (ret)
>> -		dev_err(&i2c->dev, "Failed to create subdevices\n");
>> +		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
>>   
>>   	return ret;
>>   }

Yours,
	-- Matti



