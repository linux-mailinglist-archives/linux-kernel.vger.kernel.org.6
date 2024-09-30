Return-Path: <linux-kernel+bounces-343602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70635989D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D38DB23C95
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB0D17AE1C;
	Mon, 30 Sep 2024 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ox4HGyed"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA817B433
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686021; cv=none; b=bx1FNEV+jYG0u1q9RU4MHw3JznTuM0BrKf9IWejvF+foVMYLtZ5DPyAwGWqPVtMS/vACEU7nWdgedMUhUGylrqjj1EeaK8IY9xfVM1doIlj98gaKD+EW9j42ALugDsX7zYx59QTQc8Pf5k5+jtjQjVWxpGnzttDcjz1ajqzpwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686021; c=relaxed/simple;
	bh=zBOaCIiplMCpZGY0jjaPb2V+UzWItcf34o6TiHwy4Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpHpk3YehqYjLXbdj7Ua4Ej1LozdD8rSeYC1JMD5xNKyRYfmvQHL1NTVc4/dOrdwskN7zqDBS6nJnCYpHoBjCZeHa8IKbSqdtjikdfQZifK7MZw9PockDFxMfbi3cV1OeOjYNJLO1GAGP+g/hcMd9UVTqZ8+/i24MJmB0H3FOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ox4HGyed; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5389ef4c28eso375981e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727686018; x=1728290818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtMzIEmSeHrSindSP0Zy7HyY0VWOBIsMj6Cl6nDXOFs=;
        b=ox4HGyedgXHYRfLJYqEK9TThNNLbTYZWQi3L/R9XLvECCnVmiQtQnZ73Ce00j/Jiql
         4Ab6pfsqj12TT/BSF2gAWAku2A8tkKEoHyza/xAJT1I07tuONC98qiN6A9bMthebXEv6
         u8ypPoiZDLn7+A+CVrDu6nzz25FzXQPhezbFW7tMKBmuQrHUAU2jPRBkyoqTy0nX0yvJ
         N0cclosyuED+5BVPe12pFtOGuKGQtr264LznXtPm8VILGN29H1QXOlZBvtSXdx24AqR4
         UfxibCxaY2NPIdAhBk9TV+87Prc4wPQykVahNchiBeZF+MXZwFNBn1zLB6tRVMnl1jyg
         QqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686018; x=1728290818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtMzIEmSeHrSindSP0Zy7HyY0VWOBIsMj6Cl6nDXOFs=;
        b=Xe2VjxTHzxDFS/T5AWqdWCiknosEWlji7zIVgLJY9+1AmHdH8oyoLxuQBWkW7Buv/e
         vpku9dlHQvN7+BMJv8N+vxVOdZBz3CXmVHCnP77r6dyUR2C3Tz8wx1Dub0MP4cc0ktHu
         sDQDZGQQA5WikMAnf7B6UJ/erjOUEn+LDd4YA9+mGFPFM/zfrE8EDZsKWS6/nSOGyFkE
         6/gFNZBf/usDsRnxdYDbo7J0Wrp8qwLGdVkkgAuo07zQKhWAc5gztJuN6IA2dNSlBZme
         IoCDVe3GBvXnXhlawt8kcEKUuIkbOA88WX4JtnlKXp6cvvRmcMdjpq+DqFGqcc7PTISE
         iV9w==
X-Forwarded-Encrypted: i=1; AJvYcCVYexaQm3dKJXX80Kd3VlGKDXHZSOkpbQNWxsA63UEy7W+koQBE0nXPElooWauoZ1nWztRxnMTKrlax+rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kdVpDgalK6Ux5NIrjt3x8SAJeSgBvmMN/oDgU9//gDYGlOdG
	A0ibdrkYcaDYt4rFmQzjgsafzVyj3PS8NKS67JhbF5hVcDYSuFfLBW9nlYx63ro=
X-Google-Smtp-Source: AGHT+IFD+QksQwqwWe9YMhvYeWxUxYvljx6Exd041dtgf4st8hShEVFT0rzEYhFQU/g1Q5R2XdhGfA==
X-Received: by 2002:a05:6512:3190:b0:535:4144:f9d3 with SMTP id 2adb3069b0e04-5398c31aa74mr864994e87.11.1727686018222;
        Mon, 30 Sep 2024 01:46:58 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a0439110sm1164327e87.184.2024.09.30.01.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 01:46:56 -0700 (PDT)
Message-ID: <87419076-c355-4eb9-8bf4-a9f2064e3c0a@linaro.org>
Date: Mon, 30 Sep 2024 11:46:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-8-quic_depengs@quicinc.com>
 <9ed92660-5f42-4a1a-9261-b8800133972a@linaro.org>
 <ed012367-1bfd-4eef-931b-37e1ac839176@quicinc.com>
 <65e5796a-8b8d-44f0-aef4-e420083b9d52@kernel.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <65e5796a-8b8d-44f0-aef4-e420083b9d52@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Krzysztof,

On 9/30/24 10:16, Krzysztof Kozlowski wrote:
> On 25/09/2024 17:13, Depeng Shao wrote:
>> Hi Vladimir,
>>
>> On 9/6/2024 11:56 PM, Vladimir Zapolskiy wrote:
>>
>>>> +            compatible = "qcom,sm8550-camss";
>>>> +
>>>> +            reg = <0 0x0acb7000 0 0xd00>,
>>>> +                  <0 0x0acb9000 0 0xd00>,
>>>> +                  <0 0x0acbb000 0 0xd00>,
>>>> +                  <0 0x0acca000 0 0xa00>,
>>>> +                  <0 0x0acce000 0 0xa00>,
>>>> +                  <0 0x0acb6000 0 0x1000>,
>>>> +                  <0 0x0ace4000 0 0x2000>,
>>>> +                  <0 0x0ace6000 0 0x2000>,
>>>> +                  <0 0x0ace8000 0 0x2000>,
>>>> +                  <0 0x0acea000 0 0x2000>,
>>>> +                  <0 0x0acec000 0 0x2000>,
>>>> +                  <0 0x0acee000 0 0x2000>,
>>>> +                  <0 0x0acf0000 0 0x2000>,
>>>> +                  <0 0x0acf2000 0 0x2000>,
>>>> +                  <0 0x0ac62000 0 0xf000>,
>>>> +                  <0 0x0ac71000 0 0xf000>,
>>>> +                  <0 0x0ac80000 0 0xf000>,
>>>> +                  <0 0x0accb000 0 0x2800>,
>>>> +                  <0 0x0accf000 0 0x2800>;
>>>
>>> Please sort the list above in numerical order, this will change positions
>>> of "vfe_lite0", "vfe_lite1" etc.
>>>
>>> Another note, since it's not possible to map less than a page, so I believe
>>> it might make sense to align all sizes to 0x1000.
>>>
>>
>> Sure, I previously sorted by the alphabetical order of reg_name.
>> I will update it based on your suggestion. And will also make sure the
>> align all sizes to 0x1000.
> 
> If I understood correctly, you want to change the order from existing
> devices, so no. You are supposed to keep the same order, as much as
> possible.

Please elaborate, what do you mean here by the "existing evices"?

The list is not sorted by reg values, I ask to sort the list by reg values.

--
Best wishes,
Vladimir

