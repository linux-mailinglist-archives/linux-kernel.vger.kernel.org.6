Return-Path: <linux-kernel+bounces-223404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541DB911267
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A7A1F213F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7CB1BB6B8;
	Thu, 20 Jun 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2CVATap"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58DD1B9ACA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912570; cv=none; b=jMKLq4fhdCR2hjMm07ecTjRnm3V0xCE2RVx+iWZBIccDhvMud8M38+y3p7YX+Zo2hB1bHfUSH3tdJnddaQz9jH1qprXifXox8QZq7WVfWCHBn5KibM7ivZm/MCdHYRyjhyBfLqP0OXsoyCFO13ldfEGII57DjgtW2n9eOJ03gDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912570; c=relaxed/simple;
	bh=eM3wB9NAHkHjYblWTT3AjqGdA3r6nkX4upptgf3Wji0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2Q1Nk/PR3/OHUtKXxryHYg5TapmLZhaK39MkNqzs1gtpaUW5CetfTNTcN+IRE4laXTtgqHf+xJSLCuBL4MybugJpibXJR1KPnPGYJBuh2I06O4VL7k4yHUlzA8Y8ARZPSvYExB080CVznZnuFBIFJ0YoDEr7VZIKREp2+jfieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U2CVATap; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so12871115e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718912566; x=1719517366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hrCX72O0lF3zsVZzlXhFO6wTPnrG9ubeae4olxpTtrI=;
        b=U2CVATap5rvNfPRqW9aRhQd9+BHMUDLFg8l/tkxc5j2ck+SnuKGvg/xDf8Ybl2TITO
         5xcVmlwMEz5sqVDNr6SamC7yrwklTBT0RamcKU1uNCu2wvdjbm7tWXRR9M2wYzxC98Ll
         up6rqKiZJcg82z50EOI6yxSPGrcMAnESQe4vZbor2vmIvQ8FOjZdMPNguiHhApuDxpQU
         bKGopmrGBsCQV2LUqV4xWPfYx+cnnNCzXhIg7qIEVg+7rpuOUAVxMJTAeYrmBayQwtui
         Lxm+P+5qzqBcNcnodxvKFys0Fb3C88oXt74aL+RuLxuS/Uv2oO/t/v2qIzVATEFbxRhn
         dz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718912566; x=1719517366;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrCX72O0lF3zsVZzlXhFO6wTPnrG9ubeae4olxpTtrI=;
        b=XHSu6Jkn8tNrR3Ql2qjho/799hh/eA42wcWzRu9CJ9/c9a4WbaaR2Na2l1qXTqBsMV
         /9kVMu1nGsdFNx5AipHxzxH/+zm1rW2ESlX1th2LdUleqmsNnZRMkYj0iZ+iCX8EjaSP
         dIX6iuaaZP/aN3mmiXMRqUZJp0T3CnxjFsSZSoJcx65JEwE7BjBijCTIhw7hu80/6mlz
         sALCGGrgwXhu77t/XQlXneFipP5rkxRm3wniAPM6Jjx85RqXw9nDPyT9N3J3uqnZ3db0
         VNolNPk98zBhs0moWyc19TyiB71PMrmIkljfiwgg5TccgCHJcPtzaT0AyM3+DcyANlZk
         hqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdTe/FSp2+sCGNb3jDGF9ED9mD9v5VsWaGvmMdSmFUnNN6vLKY4JayGYh2rQ5pksxvTbWOWW16SOtW6o5Pgx1cAUHGPRKN/yzqyHsz
X-Gm-Message-State: AOJu0YxzY9GgVvw8o87dvHvWO+fXhLMqno0WbkE3HnO35ICOSOzOf0F8
	hQ7WzpJzhgJLi4fk168tlb9D27AsmEKye3gzNpa/qJGUBLYtQ7qVhxEVuJHehlp7LLMfzHW/Vj4
	1
X-Google-Smtp-Source: AGHT+IEHdPGaIbU70gbUkpcL4NypQoDbPqSUn57RnyDrQOqJmtjhsalkOytM1Kys8+dbrciRkkFncQ==
X-Received: by 2002:a05:600c:4a14:b0:421:5554:744c with SMTP id 5b1f17b1804b1-4247517550amr49037115e9.11.1718912566079;
        Thu, 20 Jun 2024 12:42:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42481922774sm1674635e9.47.2024.06.20.12.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:42:45 -0700 (PDT)
Message-ID: <97b84ce1-3ed2-48a8-bed4-9a671b61cd6d@linaro.org>
Date: Thu, 20 Jun 2024 21:42:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: Explain lack of child dependency in
 simple-mfd
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240616080659.8777-1-krzysztof.kozlowski@linaro.org>
 <20240620171756.GY3029315@google.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240620171756.GY3029315@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/06/2024 19:17, Lee Jones wrote:
> On Sun, 16 Jun 2024, Krzysztof Kozlowski wrote:
> 
>> Common mistake of usage of 'simple-mfd' compatible is a dependency of
>> children on resources acquired and managed by the parent, e.g. clocks.
>> Extend the simple-mfd documentation to cover this case.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/mfd.txt | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/mfd.txt b/Documentation/devicetree/bindings/mfd/mfd.txt
>> index 336c0495c8a3..98b4340b65f3 100644
>> --- a/Documentation/devicetree/bindings/mfd/mfd.txt
>> +++ b/Documentation/devicetree/bindings/mfd/mfd.txt
>> @@ -18,12 +18,13 @@ A typical MFD can be:
>>  Optional properties:
>>  
>>  - compatible : "simple-mfd" - this signifies that the operating system should
>> -  consider all subnodes of the MFD device as separate devices akin to how
>> -  "simple-bus" indicates when to see subnodes as children for a simple
>> -  memory-mapped bus. For more complex devices, when the nexus driver has to
>> -  probe registers to figure out what child devices exist etc, this should not
>> -  be used. In the latter case the child devices will be determined by the
>> -  operating system.
>> +  consider all subnodes of the MFD device as separate and independent devices
>> +  akin to how "simple-bus" indicates when to see subnodes as children for a
>> +  simple memory-mapped bus. "Independent devices" means that children do not
> 
> I'm not against the change, but I think it can be phased better.
> 
> Quoting the new part and going on to explain what you mean by it doesn't
> flow very well.  Are you able to massage it so it reads a little more
> nicely please?

Does this feels better?

compatible : "simple-mfd" - this signifies that the operating system
should consider all subnodes of the MFD device as separate and
independent devices, so not needing any resources to be provided by the
parent device. Similarly to how "simple-bus" indicates when to see
subnodes as children for a simple memory-mapped bus.

For more complex devices, when the nexus driver has to probe registers
to figure out what child devices exist etc, this should not be used. In
the latter case the child devices will be determined by the operating
system.


Best regards,
Krzysztof


