Return-Path: <linux-kernel+bounces-174288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301058C0C90
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD5B21481
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C92149E0B;
	Thu,  9 May 2024 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h44dSdFj"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FC13D27C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243377; cv=none; b=s9Xm+sS+LOWBxE269vL3REVkjR1wgRpEN5niM/v6eBs/zeCp2pl3eYOIW5hh0UFLDXG+EwB857hiJXsJXFp7CMJiNR5w8vehOmfUNbyct/eFl1TJP2OJLuYFDZ2M/dFyiFKsoSDUIDD3MtM39OR2NheaNmpQkn95+2tQTayZhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243377; c=relaxed/simple;
	bh=IRGjeXM1KNxqqYh4Ik3MFrABRQcli/7ofMMTYRmjaCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUth07tjGBkuvwgSmkL7UBEgHJitxJ8SeP00eSU0yMJRo4OXNFjjeafhr6CUrNNfJGWPcW3g70/YZi8wbPCGWY+InXAGelD9YtEPNhDnao8w0NucW0KNhR5J1a/9GUvdADpuoWpZsKxWDcruQUER8lpecvfhWlRYMDziclOig2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h44dSdFj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59e4136010so133859466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715243374; x=1715848174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hMLp8AiHMhJ0KZlIbzXsouNCXcq5N+tUnfpKJC3oGdU=;
        b=h44dSdFjZEskNhPLk2IPSDa2UPOssm+rQU4yPG7EKBXkfcFEl3X5AHD+rl4+bIaJzk
         ULb77x0hI0e+7VbiJ+a/R2WoPInappvUhh1yakiCpCia9NRSu3aMqOiwyxPEpK6Sas2w
         y3xVi0Sy3RxIN9b7QshjVshncScmFTJcy42YsAcxwuRqNlRh8c/br1P3MOosJYu3SMU7
         A6JiITP75uTQqCZrM+Fn5LZaJeCw/dr3/ZNIhUwt68G1WfSpJDKPGfWec/LfVheX2A7e
         S54phTQN4dSSeL4jwo2t4+ceH9gyEGrF0Aht1/9S6I3PJpjfUCPPesuDdyh1QsI92znh
         LEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715243374; x=1715848174;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMLp8AiHMhJ0KZlIbzXsouNCXcq5N+tUnfpKJC3oGdU=;
        b=SawwsNx1UJUe4NpLR0dFbmhiDTold3oH07FrqmJh/HhN1LXi1PVa6h4qgvK76O2Y1n
         DjsY7i72YH5V7NYDI2lzXL2MbcSFfuttb07ezJY25QNS6LfRTpUN58UIO5DN9FVVPyq1
         kHuX43ggFzhBZsFowzZCoZL41eYUMQI8c8T0EXEx00CAQQJSEH3I3OqGSo8mWquarU0Z
         vP16/SHTj6SZFAk5aYRUwShzDofc+K+f4hzIlCosoSPh07nDiJAN8gEG+Pg8RuRYAPzb
         U9jdI0Q9h0nOKasKU9UJqDkOXSUnpQ8QcpAnPMwCxHWvfNGq+GGOIyBG9JSedKpKlnGZ
         zMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3iUVAqygEEfSxY/+DWAWXG3vGLbKvi3NhwqqvIvgQ6+IMjme8tCq/KF3oKkP9Gmxgzsnm4yePV6fX9rz4hWxBDpjwAhuPFuMOpj1D
X-Gm-Message-State: AOJu0YzTbUMz1PxxgPvH8aNuR8cS4mVdTj5TKozns79aLMwbv72shJKu
	V1ijwI7Nms2lNMxRdNIiPDm3yvkXtlxGU9+MsthAO49+WCIy4nwXVt0tQJsoQQ0=
X-Google-Smtp-Source: AGHT+IG8dT/haVwP+PHSIa+dbvrLvv5s5nmQBqwoDNlyNPTU7oMINb5xzYLfMOCIvdD8UqkNZqeHWg==
X-Received: by 2002:a17:906:714f:b0:a59:ba2b:590e with SMTP id a640c23a62f3a-a59fb9dbcb9mr285672966b.48.1715243374175;
        Thu, 09 May 2024 01:29:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm48748366b.111.2024.05.09.01.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 01:29:33 -0700 (PDT)
Message-ID: <a20479be-a4cf-4fb5-8d37-277d14a93224@linaro.org>
Date: Thu, 9 May 2024 10:29:31 +0200
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
 Guenter Roeck <linux@roeck-us.net>, Conor Dooley <conor@kernel.org>
Cc: Chanh Nguyen <chanh@os.amperecomputing.com>,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
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
 <da94fde6-3286-44eb-a543-c2ac4d11cd32@roeck-us.net>
 <8fb38eb3-bb94-49cc-b5bc-80989d7876b9@amperemail.onmicrosoft.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8fb38eb3-bb94-49cc-b5bc-80989d7876b9@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/05/2024 05:44, Chanh Nguyen wrote:
>>>>>
>>>>
>>>> I am not even sure how to define tach-ch to mean "use the pwm output pin
>>>> associated with this tachometer input channel not as pwm output
>>>> but as tachometer input". That would be a boolean, not a number.
>>>>
>>>
>>> Thank Guenter,
>>>
>>> I reviewed again the "tach-ch" property, which is used in the 
>>> https://elixir.bootlin.com/linux/v6.9-rc6/source/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml#L68 and https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/hwmon/aspeed-g6-pwm-tach.c#L434
>>>
>>> That is something completely different from my purpose.
>>>
>>
>> Based on its definition, tach-ch is associated with fans, and it looks
>> like the .yaml file groups multiple sets of fans into a single
>> fan node.
>>
>> In the simple case that would be
>>      tach-ch = <1>
>> ...
>>      tach-ch = <12>
>>
>> or, if all fans are controlled by a single pwm
>>      tach-ch = <1 2 3 4 5 6 8 9 10 11 12>
>>
>> The existence of tachometer channel 7..12 implies that pwm channel 
>> (tachometer
>> channel - 6) is used as tachometer channel. That should be sufficient to 
>> program
>> the chip for that channel. All you'd have to do is to ensure that pwm 
>> channel
>> "X" is not listed as tachometer channel "X + 6", and program pwm channel 
>> "X - 6"
>> for tachometer channels 7..12 as tachometer channels.
>>
> 
> Hi Guenter,
> 
> I applied the patch [2/3] in my patch series 
> (https://lore.kernel.org/lkml/20240414042246.8681-3-chanh@os.amperecomputing.com/)
> 
> My device tree is configured as below, I would like to configure PWMOUT 
> pins 5 and 6 to become the tachometer input pins.
> 

And what is wrong in described common tach-ch property? I think we
explained it three times and you did not provide any arguments, what's
missing. Instead you say "I want something like this in DTS" which is
not an argument and does not help discussion.

Best regards,
Krzysztof


