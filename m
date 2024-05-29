Return-Path: <linux-kernel+bounces-193689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836A8D3088
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6611F2A46D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF28C17B427;
	Wed, 29 May 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jyqzYE5g"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BF168C3B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970001; cv=none; b=Wz4cR1owuJQEhVSxYplKfCVHWhstQdp98jJJJYOY43BnIItzhvP96f9skQsr46NGG/URa+nxI7/0xq+gSjPRJrv89JR4EOo19HuMj1wH9FtRpBDrZz8dVziKuDAFOsePbpUVa3ImfI7UyJ0ZaK5BSQxH0RPsmhKXfyuHmfTcE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970001; c=relaxed/simple;
	bh=KMlPyALNcmol9ih45kPl4G8oK06PC8+I1ZcxbqQgksk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMXoXk0QhVfSbAuiO+6dA7anv7xGCevPeMWuRvbv72mMpuoLCqKgkIqvZ6whj7U+qkXgZwAsps1NGH8p1e+77zbTqSdJAUnBhr8prJ8oy7i6XFY9sfMMToeA9GtgRCM84K2prDiuEqKj7wggT+i/2ZLGs3ZptIAWFT7yX4DlyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jyqzYE5g; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5295e488248so2125120e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716969996; x=1717574796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTSiUFlqkmvNoNz/S7kke8O9CZuW/PMI0ZvnUNNmSrw=;
        b=jyqzYE5gww42Yz4DxhZPJGl9ge2GiCEkrWohgCYApBgnPglM7282o2xeQsQ3ETTgiP
         RxNSfBIRNZg9kZfuUqNYtV02NMYHgSX0J4gmIn9ig9nx3Z3kbdYZ6deSQvzzTVj48fr1
         Vl2XqmmBdOed1i5PlgHZX4/JUWIvKd7RTuObUgSgv+4e1ekCgChWMKptOcpQSF98ufeI
         8DYYAzAj7vBBkr5WEqTtMK/f64NYz+eaU8wIHXQhr1CLmzW3UxfKjue2YtbAZYIxen70
         wUfGjMZrqa1FVY/9myHsapCFM2SILae/VV/ly38QspFmZjX0y6VAY0f37oheortT1SFd
         kXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716969996; x=1717574796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTSiUFlqkmvNoNz/S7kke8O9CZuW/PMI0ZvnUNNmSrw=;
        b=bPjGRxno+nh8oPkB5f+27qnaHIsyRBIOmMdBPnog0n0Xl+F9w4SAf1FSt/iF/Pa4tI
         E76rk2JqUZefXdNjxQEY0jx51fi/JV/WOvmHb4RRfJeMJBTl5vX9OZaZ2HWGuBq4zjUk
         lQsVeOJW7/H55nwpzQQZOuovtuP7drj3kdiqa2aglqyYvWPrrRR862xx3Nrmtz81dUtb
         XUfYLImXZZWK66kkZBolbuRX+zHpqDie8dWiA2xHJBFS/YrrcvtB/vyItWdhtPW8u3sK
         ozol/TVfejKTryGKy6PxBxjOaaDESJRSRBQnERb0J/6tpG3dY3CaGRrjycECHocgyoVl
         C3Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUCFLJ5hghPq/RNCJ4WIJwaubWUx0PoXMPM+3zSKCzqkyuko711DlganWebHH8n0dzTHzVqd/xhGZwHzlcZMLx5mTsMc30ohdNqzHed
X-Gm-Message-State: AOJu0YzFfAEf8IqS4eb8W8u8rlzActDXDYudmqHZeCV16WwaE1XR3gob
	npjxxhHsOFNJHMs5mlQsXr68QsRwi9RcXYjjxjh+j9kjsfrvpC2mcvClLIstf5c=
X-Google-Smtp-Source: AGHT+IH/SwMX52gxKBB8D0lQdRpnYx4BvSNc36lN8ZNxmso71kU/Y0Tqv6DyKinhb/feekEPcZl6QQ==
X-Received: by 2002:ac2:4206:0:b0:528:5301:bae4 with SMTP id 2adb3069b0e04-52964ca7358mr9020474e87.35.1716969996000;
        Wed, 29 May 2024 01:06:36 -0700 (PDT)
Received: from [10.1.5.19] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f163a8sm201920345e9.13.2024.05.29.01.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 01:06:35 -0700 (PDT)
Message-ID: <0b737c86-25bd-4bc6-b1c1-1011e15bccfa@baylibre.com>
Date: Wed, 29 May 2024 10:06:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] dt-bindings: thermal: Add a property to select the
 aggregation type
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, rafael@kernel.org,
 daniel.lezcano@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240524143150.610949-1-abailon@baylibre.com>
 <20240524143150.610949-5-abailon@baylibre.com>
 <824a9871-1fd4-4b92-a3b5-e57a126dac53@linaro.org>
Content-Language: en-US
From: Alexandre Bailon <abailon@baylibre.com>
In-Reply-To: <824a9871-1fd4-4b92-a3b5-e57a126dac53@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/27/24 08:55, Krzysztof Kozlowski wrote:
> On 24/05/2024 16:31, Alexandre Bailon wrote:
>> This adds a new property named "aggregation" that could be used to
>> select the aggregation type when there are multiple sensors assigned
>> to a thermal zone.
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>   .../devicetree/bindings/thermal/thermal-zones.yaml        | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> index fa7a72e2ba44..e6e4b46773e3 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> @@ -111,6 +111,14 @@ patternProperties:
>>             coefficients are ordered and are matched with sensors by means of the
>>             sensor ID. Additional coefficients are interpreted as constant offset.
>>   
>> +      aggregation:
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        enum:
>> +          - avg
>> +          - max
>> +        description:
>> +          Aggregation type to use compute a temperature from multiple sensors.
> 
> Hm, why exactly this is a property of hardware? Why on one board you
> would like to average and on other use max? I can only think of a case
> that some sensors give inaccurate data. Otherwise it is OS policyIn the case of Mediatek SoC, we only need max temperature.
I am not really sure if there is really an use case for the average.
Maybe I should drop average if no-one has a use case for it.

Best Regards,
Alexandre
> 
> Best regards,
> Krzysztof
> 

