Return-Path: <linux-kernel+bounces-194428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C78D3C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E0528627D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3641836E5;
	Wed, 29 May 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b16dWyMa"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E2E576;
	Wed, 29 May 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999612; cv=none; b=Ck6X2DX05th7l9X0LYfnwEO1aCXO79w2BqKZNOy2FjxwcPas/yX2jutGerSyWrdRfBwXEt+4OnTZlOPsmgvW9Y8naQXBGMnnJqzeF2Krxn9jkJE2DE3KIZl0zTPRWNuY7yVYxCwh7AjrGF2qCelRpUvT250WWAQPTYhMQA9h/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999612; c=relaxed/simple;
	bh=6zNVaT7pBxjmTO3i2MBilBBPp1dfMBnZrrUBcWnT56w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDrt1ji5Og0JtZv6uv39DPP6xvSOU0Kk9ep+qeF3Csq2jjcVScGlsU8eX39nnDpvvFo6LSerF/t+9Pmgn7es9XiSLyCdRUgtgmN1nvAU8SW+R2Bxjncu7EE6PK6gbgN3mlscWhqzanNQ/Z8vIPCuA2UAW+drwgU1UcFUsje2PDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b16dWyMa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f850ff30c0so1835613b3a.0;
        Wed, 29 May 2024 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716999610; x=1717604410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7DIlpIcV63xQIC+uFrCIfv9uIn22GwHRD2QMx2fQXbw=;
        b=b16dWyMalzxX47xCfv5iP8Xfp5grg9hM/WJjNgBgh9bW/iuAXPCLJ9dpIuW2Q6WuQv
         740a2bGF3sEZVpyk19hPiUmzaz2Ko1H0pKioBxLjAN915f5DpkidHmmSjer+0N0mDBZW
         yx9Pg7C8FADxp9RF9ju336m8BgFjNTfSiZjxkhaF6DGRX1VA0fYoC5cD8TBrqlDmnnCX
         PGhPk+FQ57XLkyY16/GtsKP67WE0FwoAFVMB7j+LtEdHHF84wRSyWriVqeTapHTeXbzn
         RjaRS/XEzjFNGoTD7npSVoVyThAifUC395rOVQmRNwe8Ikwz+hGS5K0LqK9nL0lLF0uD
         rarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716999610; x=1717604410;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DIlpIcV63xQIC+uFrCIfv9uIn22GwHRD2QMx2fQXbw=;
        b=UgcZxE7dFI42I/CvMMXjS3zNxMANXKMmhbtuc54pjuI2M2aNZ+Ve+lElwvtOSiOBwt
         FYa1m7r8m2DrnPsILQEv8WkXQFGNBsZbRyTXAIs7Id7pGi1wDTTAf94CJ1lXRT7PdGuF
         TwCZBDpseWoNtyduYs2nbpps0OBKj8PFzSN+5wjiZy5BDBoOk2IG9JIaqGh9C22YGxoV
         V1VAolY8oUGX/PJ8zXcO5cNwtpJK4ImwApRpjBEeDMx0FXVmsqPcuoOTX/8EtYaKqcVC
         kX+eMHbsl+7kqPJNlJVlBqVhxMi/+8OwfMmX/PQlSToeiEPxNu7CtJB7Tho2nlLKf/sk
         LvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCd+2BydkSazKuaOgvsFSLMFZRS5B4mk5SQdUKboWXx76ofQEi2fGMYK/PXNkRqKHSJVYMP1+ZTbYRIKoDz0yQQ3H/65vO2/OQTirKhbQ0C3UAw/YG9srUQEZlLy9PvC64FF3reCOcrNOJySwNsY0YYaFFe/ItmKFbeBJ68I0rgiUUiCgb
X-Gm-Message-State: AOJu0YzPii6eRaM5xFon8EKwZkTZriOWuSrMvdyIf/sahhqEKnw5/UMb
	6quEwBCv9CU/BpFjhfAZUpZeut7/HJt2LX7XbwvktGJdGxbHjggMOP/KDA==
X-Google-Smtp-Source: AGHT+IGObym2lzqymUsTK/krTJ9/MpXIkhFV1Nv+K3Beojwf7DIXXaqkvHSlqxJFg/VG8UX+2ANNkQ==
X-Received: by 2002:a05:6a21:8193:b0:1af:ac96:f4bf with SMTP id adf61e73a8af0-1b212d1e48cmr15208604637.15.1716999610215;
        Wed, 29 May 2024 09:20:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822198a7e3sm9311534a12.34.2024.05.29.09.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 09:20:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f41480c8-f149-4826-aa28-549a504df181@roeck-us.net>
Date: Wed, 29 May 2024 09:20:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ti,ina2xx: Add
 ti,alert-polarity property
To: Conor Dooley <conor@kernel.org>, Amna Waseem <Amna.Waseem@axis.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com>
 <20240529-apol-ina2xx-fix-v2-1-ee2d76142de2@axis.com>
 <20240529-untangled-occultist-5c9804aa9c8f@spud>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240529-untangled-occultist-5c9804aa9c8f@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 09:17, Conor Dooley wrote:
> On Wed, May 29, 2024 at 11:47:44AM +0200, Amna Waseem wrote:
>> Add a property to the binding to configure the Alert Polarity.
>> Alert pin is asserted based on the value of Alert Polarity bit of
>> Mask/Enable register. It is by default 0 which means Alert pin is
>> configured to be active low open collector. Value of 1 maps to
>> Inverted (active high open collector).
>>
>> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
>> ---
>>   Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>> index df86c2c92037..5a16d2d94587 100644
>> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>> @@ -66,6 +66,14 @@ properties:
>>       description: phandle to the regulator that provides the VS supply typically
>>         in range from 2.7 V to 5.5 V.
>>   
>> +  ti,alert-polarity:
>> +    description: Alert polarity bit value of Mask/Enable register. Alert pin is
>> +      asserted based on the value of Alert polarity Bit. Default value is Normal
>> +      (0 which maps to active-low open collector). The other value is Inverted
>> +      (1 which maps to active-high open collector).
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
> 
> There's no need for this to have a value, it's sufficient to be a flag
> of "ti,alert-active-high". Present would mean active-high and absent
> active-low. This has the added benefit the devicetree node being
> understandable to a reader.
> 

Agreed, makes sense. Even better, at the same time simplifies the code.

Guenter



