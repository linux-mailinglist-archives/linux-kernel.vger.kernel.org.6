Return-Path: <linux-kernel+bounces-368050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3AF9A0AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C535B29DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C5208D7A;
	Wed, 16 Oct 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="dKgbQGTn"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6BC208970
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082877; cv=none; b=JzFSpDqG9mONSGciIG/fEOrVmkzAsQ6pwg4aMyj2VrO8CVrf54tAfrxfMp6BltgNwFZPfdpQef3m5vOY36tAoAVUmhngoz4zqCysg22zJvm+rvmKeXQZs3tj6ho6J59w9zwvbK1jxNZ8PYPUDDK+jVXLmkibh5IT5bQ8NI+6SX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082877; c=relaxed/simple;
	bh=g51coeeDVq27OXnjABdvj8baLUmBO75MzrKxgaB9n70=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VLzadH/6Jput4mq8ajp1IHsGbl/tu9vtqGjvsonlD8IW7TqpmIXPmlfEB6mqaKGaH4AxofhsNAUjLC8RdcdU+hUtJpfyYdX3E31cJAqMGknsiYwaqcHjetnP/WNsu9lm650Lfo6i7QS8SHTDpi1/cRLSor/ZTCGtPN/jGjNnQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=dKgbQGTn; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b12a02596aso197855385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1729082874; x=1729687674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TC7OenCi6BcmKhaUOKIWjRKNFWfW4OciD6p4bX/XIcI=;
        b=dKgbQGTnPzCcyG2QUPZqCe6/4EgqZGuToImWx8Mk6lD3nfNws7RiAg291352sORHCu
         1aGz1qa8NPlSZ21OQ5Fbx8yD+RGZPu3TxV8IAXAgqEujuaMTIrZscTTXqQMfNg48fcS4
         lPPcZFzbvonEc8imBC+o6FXcpT9fkKbAj7BHoxBeo0lld4O0uu+1w5jcDDaNvo80kAPo
         9atHi24rhkafca122z1TsZ955w3WHm0QTtPvpZeIzXkFnL+va96f/W0Em0JgEm82+kcM
         vqDEOkp+c3Y/zpcCkZPOGSx7jBb9P87NGcMIPh3NxWMQg5S/7y4ffih0VNea3C3fep5I
         03Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082874; x=1729687674;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TC7OenCi6BcmKhaUOKIWjRKNFWfW4OciD6p4bX/XIcI=;
        b=qo0j3Hg5WjBZueXqfoSjRLbbvoQK6BD2P/2ig40ZNvSdJD6YumfHC5hL1r3BIxYTNL
         bHf9TJeGIC/FR7w47jLu6aLKi4UtwvZRoD58wUVhotKvyiKb4IfGMCnQFcu8ZTGtHkvB
         gFq/Ni1J+NYCClQwJYK5pA2r8tVOVPXtCdZDqmq2AOlDIEIy+2V/OxTO4+3asl8/YYgn
         OCHMSqfmMJzSmRdmbQwTka5u82rJZluT+Inv89tLSj1K3BqQvjnrg7xbVcXC60B5eUKw
         6ScE5AUXOoyDl3X9DBJ//oB4Vt11JzmS0LCfA/alinMPNtB4fr9FOScJ+oVUapJor8qs
         VV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVR7NeKsnwUSlM0r+HH9eAUwztZ0XMO0dlmen3qHBCoYp9CCRwYhS7PCotgmYX/wwYIw/13SS7/tk45CFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHiKQJrF3nkHq+nN+/AS5znp+5qgFBHmXPqP00V72QubmPtSz
	jmjGdVMCIVo9xcof4Fz+S73OUjzwVrjncToym30114Xn6UQK2k5N8w89p7HX0+FajrsC8S8zoav
	JjiI=
X-Google-Smtp-Source: AGHT+IE0f7DKjeAf362gR4xxSMpdGgpWn0MOdABboL55FWebwTaQAdvc/lcntp68K3qPqHE6C3++Dg==
X-Received: by 2002:a05:620a:2684:b0:7b1:3bcf:cbc3 with SMTP id af79cd13be357-7b1417fa39cmr456626185a.35.1729082874291;
        Wed, 16 Oct 2024 05:47:54 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0e22dfsm17283211cf.35.2024.10.16.05.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 05:47:53 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] rtc: pm8xxx: implement qcom,no-alarm flag for
 non-HLOS owned alarm
To: Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241015004945.3676-1-jonathan@marek.ca>
 <20241015004945.3676-2-jonathan@marek.ca>
 <Zw9gZkLPMB9ZBQlh@hovoldconsulting.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <682acd15-58c5-6bdf-f913-0940a2733451@marek.ca>
Date: Wed, 16 Oct 2024 08:44:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zw9gZkLPMB9ZBQlh@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/16/24 2:42 AM, Johan Hovold wrote:
> On Mon, Oct 14, 2024 at 08:47:26PM -0400, Jonathan Marek wrote:
>> Qualcomm x1e80100 firmware sets the ownership of the RTC alarm to ADSP.
>> Thus writing to RTC alarm registers and receiving alarm interrupts is not
>> possible.
>>
>> Add a qcom,no-alarm flag to support RTC on this platform.
> 
> An alternative may be to drop the alarm interrupt from DT and use that
> as an indicator.
> 

That wouldn't be right, the registers/interrupt still exist and should 
be described in DT.

(if you have firmware that allows access to the alarm, now you only have 
to delete the qcom,no-alarm property in your dts to use it)

>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   drivers/rtc/rtc-pm8xxx.c | 44 +++++++++++++++++++++++++++-------------
>>   1 file changed, 30 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
>> index c32fba550c8e0..1e78939625622 100644
>> --- a/drivers/rtc/rtc-pm8xxx.c
>> +++ b/drivers/rtc/rtc-pm8xxx.c
>> @@ -61,6 +61,7 @@ struct pm8xxx_rtc {
>>   	struct rtc_device *rtc;
>>   	struct regmap *regmap;
>>   	bool allow_set_time;
>> +	bool no_alarm;
> 
> How about inverting this one and naming it has_alarm or similar to avoid
> the double negation in your conditionals (!no_alarm)?
> 

My reasoning is that the DT flag has to be negative, and its better to 
use the same name as the DT flag, but inverting it is OK.

>>   	int alarm_irq;
>>   	const struct pm8xxx_rtc_regs *regs;
>>   	struct device *dev;
>> @@ -473,9 +474,14 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>>   	if (!rtc_dd->regmap)
>>   		return -ENXIO;
>>   
>> -	rtc_dd->alarm_irq = platform_get_irq(pdev, 0);
>> -	if (rtc_dd->alarm_irq < 0)
>> -		return -ENXIO;
>> +	rtc_dd->no_alarm = of_property_read_bool(pdev->dev.of_node,
>> +						 "qcom,no-alarm");
>> +
> 
> Stray newline.
> 

That's not a stray newline?

>> +	if (!rtc_dd->no_alarm) {
>> +		rtc_dd->alarm_irq = platform_get_irq(pdev, 0);
>> +		if (rtc_dd->alarm_irq < 0)
>> +			return -ENXIO;
>> +	}
>>   
>>   	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
>>   						      "allow-set-time");
>> @@ -503,7 +509,8 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, rtc_dd);
>>   
>> -	device_init_wakeup(&pdev->dev, 1);
>> +	if (!rtc_dd->no_alarm)
>> +		device_init_wakeup(&pdev->dev, 1);
>>   
>>   	rtc_dd->rtc = devm_rtc_allocate_device(&pdev->dev);
>>   	if (IS_ERR(rtc_dd->rtc))
>> @@ -512,27 +519,36 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>>   	rtc_dd->rtc->ops = &pm8xxx_rtc_ops;
>>   	rtc_dd->rtc->range_max = U32_MAX;
>>   
>> -	rc = devm_request_any_context_irq(&pdev->dev, rtc_dd->alarm_irq,
>> -					  pm8xxx_alarm_trigger,
>> -					  IRQF_TRIGGER_RISING,
>> -					  "pm8xxx_rtc_alarm", rtc_dd);
>> -	if (rc < 0)
>> -		return rc;
>> +	if (!rtc_dd->no_alarm) {
>> +		rc = devm_request_any_context_irq(&pdev->dev, rtc_dd->alarm_irq,
>> +						  pm8xxx_alarm_trigger,
>> +						  IRQF_TRIGGER_RISING,
>> +						  "pm8xxx_rtc_alarm", rtc_dd);
>> +		if (rc < 0)
>> +			return rc;
>> +	}
>>   
>>   	rc = devm_rtc_register_device(rtc_dd->rtc);
>>   	if (rc)
>>   		return rc;
>>   
>> -	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
>> -	if (rc)
>> -		return rc;
>> +	if (!rtc_dd->no_alarm) {
>> +		rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
>> +		if (rc)
>> +			return rc;
>> +	} else {
>> +		clear_bit(RTC_FEATURE_ALARM, rtc_dd->rtc->features);
> 
> I assume that you should be clearing the feature bit before registering
> the RTC.
> 

Right, it just needs to be after devm_rtc_allocate_device, not 
devm_rtc_register_device.

>> +	}
>>   
>>   	return 0;
>>   }
> 
> Johan
> 

