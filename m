Return-Path: <linux-kernel+bounces-169032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 405918BC1AE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD65281A09
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C004374F9;
	Sun,  5 May 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvc51CfI"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2E1D52C;
	Sun,  5 May 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714923645; cv=none; b=WAjfmmp7GJ6i0F0JXu6TG0Hb6s5vu2GQZn3zLMhmmQJ+cKOQXyqik0t/TFvF7df4mzcZjd3xNtIraVZqScCQHUECG6LgF3IvLzbPol+99AY+Ln8O3cSUYAt+ei8Zc2SOlb7zqVsPj9UfbokniJhgaABMjUVsIR1n3vwnh9Dk5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714923645; c=relaxed/simple;
	bh=VuGl7/KcBiX0f8OmxjJSQR7xNFs5a6L48y8V57OfLVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKpulsGxrQO7iFkfSBPQKzIJhW+lmNsiGZbUQpip+dYMnMSpjLDSeAlTn4LIAX2O6eUyuTSCivqSxGWRPfDaP+cGH56hGDWwNRJ4tfGR0j8P/O7w6w2MsieEdlahEe/bWec901OKs7rEg/xJHHTQB9vVhticr4wL3o1ye60q1IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvc51CfI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso3528465ad.1;
        Sun, 05 May 2024 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714923643; x=1715528443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eE0CVTbql2E3iQeGGrq8uHBHFqZSfYMMKZoAncXEzm0=;
        b=bvc51CfIqgNH8QcEcGoWrpYGdEQIiuz2k4qT5z48fRUfLG+uC5AP+ztQUA/mYiOTWh
         AjvvT1C4H3ZxLUe92ifIOZnYV/QnbHh7nNiBmDeA6MBwfUqxaNII90Q7q1uvmLlzCEIn
         ZDdyXO9PJXa2Ruf296wairdHSyUiXz2aDqekdA88dg0ADkiq7Fl0oXOMxOGFPFYecswO
         EagaQyy/fjp2dDo/UqueL5N7ngjE2rqRQK4AgiJOZIiTKJzM1e5pUIZpUpx4SMwq3gOu
         0tSq4SAPPdtfheue0odUV2bcSPTfLO1CzrpRYaLtJkyql391vChSboEUITx/Se/nQsMV
         JVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714923643; x=1715528443;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eE0CVTbql2E3iQeGGrq8uHBHFqZSfYMMKZoAncXEzm0=;
        b=V2Mxkr0kBnprwnGuP33iG2OTi9AH5TU8Xbyx+ZvdkYIeUqIWNGf3iRnXZuqi54E3q8
         xgbalKJjVaQCq8lVHwYMCS6/a59w5tEKLMOxi3wFxAfjs9SRXa4qqK9TnBAdvvTOCooz
         bkY1kIyT4dY/pK1gNexZR/l3KxJyFnV/VP/9UMvfOs2ZmnErSY2YFXDOjam3xSiaR3kA
         1Lhe+vuvbdBNOTJw/nSgVQRZSPKGw/TOTVgQVR23Tj5yiFmFSKo2shWjB/+fGpYTxrEI
         7b/aMY1iFkdpFdWamGkzhObRoTx2oO3Gk8vGl9v0P3pH20GyOMe0d/Ztcr2m0Em9OpOx
         wSGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUejdSGeN4x2jzr1vExaPGeivAERbY2aaqVG2DobGpp121HrMl+/u/KB+UFp9HeSgP8XZkmR1wF8oBETzzLgPXfnXN0KDEvpzedVyFQgXIJ3sZd4EJIm1dSt6e1XKLmPnxwBhc0Wpgn7Fn2zIeIl3n5wUGwoTvIhTGa+NM3AT772TMKqItp
X-Gm-Message-State: AOJu0Yz4aLr7GTyilIyK6wagIIhu56FE+wTJuYXw+Z7du8unuvoxKAY+
	UkgPw7ghGZg5h59EgeqvDNK6gYNIUUZkhc/hyiXLnrBy3zIH+DKA
X-Google-Smtp-Source: AGHT+IEVj05uGSFLeQzz9q+zFFq13zIHwnGgmO7cy/Fr+Gjd1mEai0HodHzIQpt10b8ZFlWIIwEs+g==
X-Received: by 2002:a17:902:d345:b0:1eb:75de:2a5b with SMTP id l5-20020a170902d34500b001eb75de2a5bmr8138282plk.62.1714923642784;
        Sun, 05 May 2024 08:40:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001ead176d324sm6619971plf.200.2024.05.05.08.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 08:40:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <da94fde6-3286-44eb-a543-c2ac4d11cd32@roeck-us.net>
Date: Sun, 5 May 2024 08:40:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: max31790: Add
 maxim,pwmout-pin-as-tach-input property
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
 Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chanh Nguyen <chanh@os.amperecomputing.com>, Jean Delvare
 <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>,
 Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240414042246.8681-1-chanh@os.amperecomputing.com>
 <20240414042246.8681-4-chanh@os.amperecomputing.com>
 <13b195e6-cbbd-4f74-a6fa-d874cb4aaa45@linaro.org>
 <065243cc-09cf-4087-8842-bd4394fb324f@amperemail.onmicrosoft.com>
 <d549cf2b-a7fa-4644-8fcb-3c420503ee01@amperemail.onmicrosoft.com>
 <20240423-gallantly-slurp-24adbfbd6f09@spud>
 <ab5cfd8c-0e88-4194-a77e-5ffbb6890319@amperemail.onmicrosoft.com>
 <396b47f5-9604-44ab-881f-94d0664bcab8@roeck-us.net>
 <0dcc8788-604a-49c1-8c6b-fdbfa9192039@amperemail.onmicrosoft.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0dcc8788-604a-49c1-8c6b-fdbfa9192039@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/24 03:08, Chanh Nguyen wrote:
> 
> 
> On 25/04/2024 21:05, Guenter Roeck wrote:
>> On 4/25/24 03:33, Chanh Nguyen wrote:
>>>
>>>
>>> On 24/04/2024 00:02, Conor Dooley wrote:
>>>> [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
>>>>
>>>
>>
>> The quote doesn't make much sense.
>>
>>> Sorry Conor, there may be confusion here. I mean the mapping of the PWM output to the TACH input, which is on the MAX31790, and it is not sure a common feature on all fan controllers.
>>>
>>
>> I think the term "mapping" is a bit confusing here.
>>
>> tach-ch, as I understand it, is supposed to associate a tachometer input
>> with a pwm output, meaning the fan speed measured with the tachometer input
>> is expected to change if the pwm output changes.
>>
>> On MAX31790, it is possible to configure a pwm output pin as tachometer input pin.
>> That is something completely different. Also, the association is fixed.
>> If the first pwm channel is used as tachometer channel, it would show up as 7th
>> tachometer channel. If the 6th pwm channel is configured to be used as tachometer
>> input, it would show up as 12th tachometer channel.
>>
>> Overall, the total number of channels on MAX31790 is always 12. 6 of them
>> are always tachometer inputs, the others can be configured to either be a
>> pwm output or a tachometer input.
> 
> Thank you, Guenter, for your explanation. That is also my understanding of the MAX31790 feature.
> 
> So, I think we should introduce a vendor property to configure the pwm output pins to become tachometer input pins. We shouldn't use the tach-ch property. Because they are completely different, I think.
> 
> What's your idea ? Please help share me, Guenter
> 
> 
>>
>> pwm outputs on MAX31790 are always tied to the matching tachometer inputs
>> (pwm1 <--> tach1 etc) and can not be reconfigured, meaning tach-ch for
>> channel X would always be X.
>>
>>> I would like to open a discussion about whether we should use the tach-ch property on the fan-common.yaml
>>>
>>> I'm looking forward to hearing comments from everyone. For me, both tach-ch and vendor property are good.
>>>
>>
>> I am not even sure how to define tach-ch to mean "use the pwm output pin
>> associated with this tachometer input channel not as pwm output
>> but as tachometer input". That would be a boolean, not a number.
>>
> 
> Thank Guenter,
> 
> I reviewed again the "tach-ch" property, which is used in the https://elixir.bootlin.com/linux/v6.9-rc6/source/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml#L68 and https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/hwmon/aspeed-g6-pwm-tach.c#L434
> 
> That is something completely different from my purpose.
> 

Based on its definition, tach-ch is associated with fans, and it looks
like the .yaml file groups multiple sets of fans into a single
fan node.

In the simple case that would be
	tach-ch = <1>
..
	tach-ch = <12>

or, if all fans are controlled by a single pwm
	tach-ch = <1 2 3 4 5 6 8 9 10 11 12>

The existence of tachometer channel 7..12 implies that pwm channel (tachometer
channel - 6) is used as tachometer channel. That should be sufficient to program
the chip for that channel. All you'd have to do is to ensure that pwm channel
"X" is not listed as tachometer channel "X + 6", and program pwm channel "X - 6"
for tachometer channels 7..12 as tachometer channels.

Hope this helps,
Guenter


