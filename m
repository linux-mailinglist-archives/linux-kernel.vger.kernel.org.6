Return-Path: <linux-kernel+bounces-306900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5845B964530
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010171F218EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70D1B3B23;
	Thu, 29 Aug 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6dUNveu"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF461B3B12;
	Thu, 29 Aug 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935344; cv=none; b=i4Qin79UGEt/nC5z+XCWSbmJhZiFz4huSu6YKFcMkRD8qYqUllEAnV17MUgqrfw2EH+i4ru+t5XqWR5ZpPxAqeCG2PUX9Mhb13GDrWia6r1OJTBy+an5L9EJ6FFncxE8Yr1V+Ung1pvQ3N5bOwbxM3DN0WysPNNZrM3bKLwj9Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935344; c=relaxed/simple;
	bh=fJCxyhxNqlg7fPYahoS6M91isT/nrzxyUAToqzxJUqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSrZ29p32MtzL8ENaEjd22BS1V4gBw8yeXEQyKSWeKbNxuctxUcsKmBf5VUyIeej9WCV3wckIdcZLNxIQXPlacduubz1Sc2Dt7Qj3qzNiQOJkJfl93l0bI6nPTsLfLGQlcKwDjk9xvOSMzvUqdLtKfpX53BYXmnD2nlwRBNRt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6dUNveu; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5df96759e37so400646eaf.2;
        Thu, 29 Aug 2024 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724935342; x=1725540142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62etMwhikCbx83EitXMM1DAsh2sGaPLi6taYdPEKe7E=;
        b=l6dUNveuVjjuGJ3P+ofRLfDYLnboo9md8ltcfOIBr3Qc210sey1dT1zlz6JGiSiEie
         D6ZUIHX90Iz2eQKuR7BOjZMsOeG42FWSqYwNt+jb/OXGFeohFhvQtX+k3HFL1p8sPT7V
         YyCfrGPEeUwXbBKsu7x9/94KKPI7hMbS2bC5xsdHQQc9gUKhDz9ukm8AM1qAtpUcopWJ
         c1Sum4xYPc5SQAOC0HER23CLJ5Qy6yoCb6Fmlsu/MzjnuWYVQPB//hcjrfDNRc7x3OCN
         AwGbCG/FrV9AuWEY0auUKHayaITj0uGcC8l9sxU6WHODb4Zh//ocmDRf23r/k0Rt+gi1
         9cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935342; x=1725540142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62etMwhikCbx83EitXMM1DAsh2sGaPLi6taYdPEKe7E=;
        b=j5LUdxT0F8t7ZYoemdOsuZnZQhXF5/EmD2pCSYfA3CGBvaD6Pjhi/1627FDGzbwajz
         845vLXL8eIMuvaW9L/CZxZtflx0L6vWuxx9fwlrM72YOPCxUp5ZxI6HlY7kXwwEl6QzH
         jflmEkYTb2H9KqhvAjRcBwedJPdXPuHElYSU6FnyqmAsldHNo5A5jSRcsh9EIylPrQ+I
         kSXqmUwKPTEyxyOYzXpJ1I1/5ERaJcVRF+sUyHNFsQTiC7SuLJOoRhGK8rAWSi1DKb9h
         yVFlGge1TEO0vZSUzoy5deTc9aeWdcS6+rVks9wYkFV5U6iQlXyRSRj6dOA+S4oKn5Ov
         pJCA==
X-Forwarded-Encrypted: i=1; AJvYcCUYHc270zijXueXh4g9h98/oJo0jBzN9xQeiAWKkb99isaTBJcjaHUqxNvRZEMo2ayYq6bpiZFtAZq8GN5d@vger.kernel.org, AJvYcCXMbLKf/5j06Fb3POO4Dg9v3COO8ryxJOB/g21a4awR8H4rCkL35oYAci6+RWLEsA/A4vH4WMaat2eD@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7lthcYfRmM5N98NWWSLyzTrkS4qKtAL9k0OLPm9MKBXRsAR3
	L7q2JsC/Kpb+qNIZRiDjocOOm6R3buYmMGpwY32soaE+CDbR0GBJ
X-Google-Smtp-Source: AGHT+IEC4G47OYreiCTOBKoMPPw17Y2kBfXKxe7jza2SnX9wgdDOFnMWs0MrB73Y0piQMsh49UXzkw==
X-Received: by 2002:a05:6358:7204:b0:1b3:94cc:6526 with SMTP id e5c5f4694b2df-1b603be2acbmr321852055d.2.1724935342301;
        Thu, 29 Aug 2024 05:42:22 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575c4acsm1045391b3a.195.2024.08.29.05.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:42:21 -0700 (PDT)
Message-ID: <5035c3ed-7089-4136-87b4-102e973c1787@gmail.com>
Date: Thu, 29 Aug 2024 20:42:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: apple,aic: Document A7-A11 compatibles
Content-Language: en-MW
To: Krzysztof Kozlowski <krzk@kernel.org>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht
References: <20240829092610.89731-1-towinchenmi@gmail.com>
 <20240829092610.89731-2-towinchenmi@gmail.com>
 <e3d9a629-6fcc-4fd8-b44f-47efdda5f494@kernel.org>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <e3d9a629-6fcc-4fd8-b44f-47efdda5f494@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/8/2024 19:44, Krzysztof Kozlowski wrote:
> On 29/08/2024 11:03, Nick Chan wrote:
>> Document the compatibles for Apple A7-A11 SoCs.
>>
>> There are three feature levels:
>> - A7-A10: No fast IPI
>> - A11: fast IPI, global only
>> - M1: fast IPI with local and global support
>>
>> Each feature level is an extension of the previous. For example, M1 will
>> also work with the A7 feature level.
> 
> It's hard for me to map above to compatibles. Extend the commit msg to
> include names used in the bindings.
Acked. Will be in v2. A description of the feature levels will also be
added to
the description of AIC.

> 
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  .../bindings/interrupt-controller/apple,aic.yaml  | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>> index 698588e9aa86..28e09b933087 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>> @@ -36,9 +36,18 @@ allOf:
>>  
>>  properties:
>>    compatible:
>> -    items:
>> -      - const: apple,t8103-aic
>> -      - const: apple,aic
>> +    oneOf:
>> +      - const: apple,s5l8960x-aic
> 
> Which one is this?
> 
>> +      - items:
>> +          - enum:
>> +              - apple,s8000-aic
>> +              - apple,t7000-aic
>> +              - apple,t8010-aic
>> +          - const: apple,s5l8960x-aic
>> +      - items:
>> +          - const: apple,t8103-aic
>> +          - const: apple,t8015-aic
> 
> Why are you changing all existing devices? Test your change, you would
> see here errors.
This part is a bit of a mess from when A11 was supposed to get the M1
compatible. However, now that A11 is found out to be different from M1,
in v2 all of A7-M1 will get its own
SoC-specific compatible, in addition to the "apple,aic" generic
fallback. (you should have already seen the changes in the improper
"resend")

> 
> 
> 
> Best regards,
> Krzysztof
> 

Nick Chan

