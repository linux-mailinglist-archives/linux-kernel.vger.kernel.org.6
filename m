Return-Path: <linux-kernel+bounces-305990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2499637B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079291F232C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E7A1C2BD;
	Thu, 29 Aug 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="EHzUVjXR"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EDB17C67
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894877; cv=none; b=QSKdCFNPHPRT9N1TUXlLfxg0rpBw9vHdYokYtTz8PASp8SiqOLoMyRmZZFJLHSI9yPZYIdMZoQ70jc1+o5YBH4fTR2vh0K29kGLry2rUI7oYE3IUHmfhoZik+d/rGu+6vELD6ME/cKbCrRjjoli0Xg3psVTEcb66x9j1MG15z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894877; c=relaxed/simple;
	bh=GUZM8uLuE41q6tI68jkKOyS9GmYbNfFMmloMLde9LFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUodKoB1XgE73DZaluDBIrFf9/e9Nq+m68MBsFwTusMgoOsJRGrgRh0l7Qby2Wak0NL0X2KJGDw8BNC1SuDYIl76rYeseGUO51wQjTawxGYlHmUvsWa/4BUf6jAmRM+Hni4/KoCcOKOJdmehspFURBw1k6s2ca5kkli5+b85dZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=EHzUVjXR; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-829e3fbcb87so7893639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1724894874; x=1725499674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z2ltsMeAdIU7/qac+g/g3A2roE0rPMyXwX1I4UzlRdg=;
        b=EHzUVjXRGLrcAusBY0L4dLlYmaNvNs4lMwSbXb9BDyzfaHLD6t9K5aSpM0zH5C3ZiS
         X8pLH970iGS8Imafv90X00TEiEsJNhsuSOtpKSGdqVpxCxkD5XlLQA1B12Zj57XiRNXs
         ayp1PXHD4jK82GHSsXLNJd5Fp+WXRXt/2Bt8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724894874; x=1725499674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2ltsMeAdIU7/qac+g/g3A2roE0rPMyXwX1I4UzlRdg=;
        b=UJAZ/X54IFYPK2pjSxE7+5ewybbfUd+BxFxqOsA7q9yI89ALW5NTpvknHahnwRYayX
         oZVlSMWrtzpTARYLgomRySfJvAbweNBilWo8deJagtzsuO5rAjSwkBHr8QVWLEq9iUnN
         tE8WGiK9SSJendscXnqUW/bmfFylitXWzyplPrpOyZeyQ6XKOIHKSY/77Fen3qpwTQfl
         G8lOOGCy8m2yrzMEgRPUkRFuMXZDrpo/DCU7l0cxtNs6XIUTNtLq7b5ox6y8QWqfyCQF
         9SblQ0JDoK7kR0sZGftAxGBjwKqPAvNv1TWPRApUQSVKiYe2ZaClMz8p9itpCdrjvkmt
         61Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUuqaOgoU9AXd6VWw3OcM0XRKd3a3/Q0thuBepQzkarPsqcad41aUR/ZFqNHCbWOxdBVQBd/BJVmzQqey8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVm3uZKDPy0rnyoMgN8X/3NcBQ2oMze4+3vgXT6pKG0S65HBv
	SOb+buoGL4byqLcXshT3lfwnKZa75/thZ525TtjIqZR4KpKKDA0rJDxQoGBN4A==
X-Google-Smtp-Source: AGHT+IEDLfTIeaQKWnTzXneYGyMW4PuIFW+b238YvF7ACyqJm+E0LALDPyMgU9TUld1KP0Bz15vbhg==
X-Received: by 2002:a05:6602:2c83:b0:825:1f11:5996 with SMTP id ca18e2360f4ac-82a1107228fmr201756639f.13.1724894873978;
        Wed, 28 Aug 2024 18:27:53 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-82a1a411e84sm4774339f.12.2024.08.28.18.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 18:27:53 -0700 (PDT)
Message-ID: <5622e611-ce5d-4d0b-852f-759616f9452c@ieee.org>
Date: Wed, 28 Aug 2024 20:27:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: ipa: make use of dev_err_cast_probe()
To: Simon Horman <horms@kernel.org>, Yuesong Li <liyuesong@vivo.com>,
 Hongbo Li <lihongbo22@huawei.com>
Cc: elder@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240828160728.GR1368797@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240828160728.GR1368797@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 11:07 AM, Simon Horman wrote:
> On Wed, Aug 28, 2024 at 04:41:15PM +0800, Yuesong Li wrote:
>> Using dev_err_cast_probe() to simplify the code.
>>
>> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
>> ---
>>   drivers/net/ipa/ipa_power.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
>> index 65fd14da0f86..248bcc0b661e 100644
>> --- a/drivers/net/ipa/ipa_power.c
>> +++ b/drivers/net/ipa/ipa_power.c
>> @@ -243,9 +243,8 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
>>   
>>   	clk = clk_get(dev, "core");
>>   	if (IS_ERR(clk)) {
>> -		dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
>> -
>> -		return ERR_CAST(clk);
>> +		return dev_err_cast_probe(dev, clk,
>> +				"error getting core clock\n");
>>   	}
>>   
>>   	ret = clk_set_rate(clk, data->core_clock_rate);
> 
> Hi,
> 
> There are lot of clean-up patches floating around at this time.
> And I'm unsure if you are both on the same team or not, but in
> any case it would be nice if there was some co-ordination.
> Because here we have two different versions of the same patch.
> Which, from a maintainer and reviewer pov is awkward.

I just noticed this (looking at the patch from Hongbo Li).

> In principle the change(s) look(s) fine to me. But there are some minor
> problems.
> 
> 1. For the patch above, it should be explicitly targeted at net-next.
>     (Or net if it was a bug fix, which it is not.)
> 
>     Not a huge problem, as this is the default. But please keep this in mind
>     for future posts.
> 
> 	Subject: [PATCH vX net-next]: ...
> 
> 2. For the patch above, the {} should be dropped, as in the patch below.

Agreed.

> 3. For both patches. The dev_err_cast_probe should be line wrapped,
>     and the indentation should align with the opening (.
> 
> 		return dev_err_cast_probe(dev, clk,
> 					  "error getting core clock\n");
> 
> I'd like to ask you to please negotiate amongst yourselves and
> post _just one_ v2 which addresses the minor problems highlighted above.

Thank you Simon, you are correct and I appreciate your proposed
solution.  I'll await a followup patch (perhaps jointly signed
off?)

					-Alex

> Thanks!
> 
> On Wed, Aug 28, 2024 at 08:15:51PM +0800, Hongbo Li wrote:
>> Using dev_err_cast_probe() to simplify the code.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   drivers/net/ipa/ipa_power.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
>> index 65fd14da0f86..c572da9e9bc4 100644
>> --- a/drivers/net/ipa/ipa_power.c
>> +++ b/drivers/net/ipa/ipa_power.c
>> @@ -242,11 +242,8 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
>>   	int ret;
>>   
>>   	clk = clk_get(dev, "core");
>> -	if (IS_ERR(clk)) {
>> -		dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
>> -
>> -		return ERR_CAST(clk);
>> -	}
>> +	if (IS_ERR(clk))
>> +		return dev_err_cast_probe(dev, clk, "error getting core clock\n");
>>   
>>   	ret = clk_set_rate(clk, data->core_clock_rate);
>>   	if (ret) {
> 


