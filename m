Return-Path: <linux-kernel+bounces-343615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF783989D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D910B2163A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B93A183063;
	Mon, 30 Sep 2024 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2IddKr4"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AFA17E01C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686524; cv=none; b=EAB7/f3G/lsq/SNKoe4XrYXMqVD2cQ2nC/uTdhQIKUHO9zmegjtGapuQN39BKww3fdHb4RSHeNwdXWKV7igO/hY8zsCgTw3Dij4gAGftDqwUwm29h9jTfSNT6x47A9DdH+T1uGr/ASNMeIp+oXSEdjSU6G72PI1MuW0+NShiawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686524; c=relaxed/simple;
	bh=Sc0whwRYzUxHFiiKA/Byp9+TYn/ZBK0ajmkeKMsqwEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/cJ91YLXP6EvGpMQ2LTlUgcAf7puAAwQwy6gIXm7D01XXMhlrdVrR9NfgBjHPCYwaX+P1lVbBoJ8MhstDqujlyUDg1uBlOYJtiL+tdHiSN4pMwGhG54gph8ftMr+38Ltb4jaIFgGOrd7ffdpLWKtEMzLB7SBClp+aOCtLJ6/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x2IddKr4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d43657255so646092166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727686521; x=1728291321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUlj16IZIlE/BnsrhQgqo6rfm+qX/DDN32OWCmaTHPo=;
        b=x2IddKr4Z4xcdeO9sQbz3KfXg8PfKyhuN31cByp8W7VfVQsHtpUfqI+C7Zm0hhdLIB
         1+mpo9gA/ECDxIOM7hiDFWaH6L9PhfP59cWLram9DOW0cjqo1RsLfCwHJCt8c5hDPEA1
         O8Dr9YErbe3AY/5zXKXm0h0QDKLvinfYgzGlqPKQ9hDSZPBxDwhzymjqAkTodEza0WZp
         /jICOmpIwUYBwUECMrkkUyhw8cchcLFlKZS5fL35TWc5W74ex+jODbGiU2S4kLkogj+m
         EAD1Tzi8cB/lwYbqdNA/978O/6s6dFnNn6aUn2s6kDiTrDhLHhkuE9yRzy8vEtWki8Q4
         K6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686521; x=1728291321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUlj16IZIlE/BnsrhQgqo6rfm+qX/DDN32OWCmaTHPo=;
        b=XoYDyspKACSx3GJjQLQD0y4ocqaqiqIhq7Ml2AagpB/+n4gmA+xB82w46S+syJhSJl
         OR19HpmNYbxpk3vuKiJV7XhTwEGg/qw6Kysn+0WFLBV0IjTOxPcsshPQm9wPJXCRuBxA
         fTpRn9xsWOyMcjWhz/xDzvPkIDx2rpeBM2pcV+1ZFgdjjVifFCn5X6V9UFTySQTj7SSX
         KCDWE2msRgNPnwO8iSMrIe10K8JITs9EHd+mXQLxWr9ctr3PXqhZGgB4BYNy4kX2EgbR
         VZ3LxWuGK4JS77kfDsZM7aSlnjjaWpdmq+4A2qO9M9vKr8KEmsFYzuM7LVSiG3Hbi9Wd
         VZUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnsub08DRaEQJEU8uT8I5HnwhWaFgnWnOYwL8uTJx3kA4jj57smt2EBE+FYNm6nNuK/h9vnhfeV4KuD20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83Somk5hZUo87uNOVrkRowpBD/KZJHlKP3VTGrvu2yHRjyhU1
	1b96Ysw6phMGGuZKM7r4HlNrlcYOuLsqKhwVza9oi1GluZctiCaCMccuKA5UV5g=
X-Google-Smtp-Source: AGHT+IFgvE/PliHY6TjajbPHmCe35TGmXquD6tqKuayO2zMJA/3GTARoVqGeboOAWokff0EVeBn8bg==
X-Received: by 2002:a17:907:74b:b0:a86:7e7f:69ab with SMTP id a640c23a62f3a-a93c49087f3mr1182345666b.15.1727686520863;
        Mon, 30 Sep 2024 01:55:20 -0700 (PDT)
Received: from [192.168.0.15] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2997f50sm492236566b.198.2024.09.30.01.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 01:55:20 -0700 (PDT)
Message-ID: <c1539cce-92eb-43fc-9267-f6e002611bbb@linaro.org>
Date: Mon, 30 Sep 2024 09:55:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Depeng Shao
 <quic_depengs@quicinc.com>, rfoss@kernel.org, todor.too@gmail.com,
 mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-8-quic_depengs@quicinc.com>
 <9ed92660-5f42-4a1a-9261-b8800133972a@linaro.org>
 <ed012367-1bfd-4eef-931b-37e1ac839176@quicinc.com>
 <65e5796a-8b8d-44f0-aef4-e420083b9d52@kernel.org>
 <87419076-c355-4eb9-8bf4-a9f2064e3c0a@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <87419076-c355-4eb9-8bf4-a9f2064e3c0a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/09/2024 09:46, Vladimir Zapolskiy wrote:
> Hello Krzysztof,
> 
> On 9/30/24 10:16, Krzysztof Kozlowski wrote:
>> On 25/09/2024 17:13, Depeng Shao wrote:
>>> Hi Vladimir,
>>>
>>> On 9/6/2024 11:56 PM, Vladimir Zapolskiy wrote:
>>>
>>>>> +            compatible = "qcom,sm8550-camss";
>>>>> +
>>>>> +            reg = <0 0x0acb7000 0 0xd00>,
>>>>> +                  <0 0x0acb9000 0 0xd00>,
>>>>> +                  <0 0x0acbb000 0 0xd00>,
>>>>> +                  <0 0x0acca000 0 0xa00>,
>>>>> +                  <0 0x0acce000 0 0xa00>,
>>>>> +                  <0 0x0acb6000 0 0x1000>,
>>>>> +                  <0 0x0ace4000 0 0x2000>,
>>>>> +                  <0 0x0ace6000 0 0x2000>,
>>>>> +                  <0 0x0ace8000 0 0x2000>,
>>>>> +                  <0 0x0acea000 0 0x2000>,
>>>>> +                  <0 0x0acec000 0 0x2000>,
>>>>> +                  <0 0x0acee000 0 0x2000>,
>>>>> +                  <0 0x0acf0000 0 0x2000>,
>>>>> +                  <0 0x0acf2000 0 0x2000>,
>>>>> +                  <0 0x0ac62000 0 0xf000>,
>>>>> +                  <0 0x0ac71000 0 0xf000>,
>>>>> +                  <0 0x0ac80000 0 0xf000>,
>>>>> +                  <0 0x0accb000 0 0x2800>,
>>>>> +                  <0 0x0accf000 0 0x2800>;
>>>>
>>>> Please sort the list above in numerical order, this will change 
>>>> positions
>>>> of "vfe_lite0", "vfe_lite1" etc.
>>>>
>>>> Another note, since it's not possible to map less than a page, so I 
>>>> believe
>>>> it might make sense to align all sizes to 0x1000.
>>>>
>>>
>>> Sure, I previously sorted by the alphabetical order of reg_name.
>>> I will update it based on your suggestion. And will also make sure the
>>> align all sizes to 0x1000.
>>
>> If I understood correctly, you want to change the order from existing
>> devices, so no. You are supposed to keep the same order, as much as
>> possible.
> 
> Please elaborate, what do you mean here by the "existing evices"?
> 
> The list is not sorted by reg values, I ask to sort the list by reg values.
> 
> -- 
> Best wishes,
> Vladimir

We always sort by address:

                 camss: camss@ac5a000 {
                         compatible = "qcom,sc8280xp-camss";

                         reg = <0 0x0ac5a000 0 0x2000>,
                               <0 0x0ac5c000 0 0x2000>,
                               <0 0x0ac65000 0 0x2000>,
                               <0 0x0ac67000 0 0x2000>,
                               <0 0x0acaf000 0 0x4000>,
                               <0 0x0acb3000 0 0x1000>,
                               <0 0x0acb6000 0 0x4000>,
                               <0 0x0acba000 0 0x1000>,
                               <0 0x0acbd000 0 0x4000>,
                               <0 0x0acc1000 0 0x1000>,
                               <0 0x0acc4000 0 0x4000>,
                               <0 0x0acc8000 0 0x1000>,
                               <0 0x0accb000 0 0x4000>,
                               <0 0x0accf000 0 0x1000>,
                               <0 0x0acd2000 0 0x4000>,
                               <0 0x0acd6000 0 0x1000>,
                               <0 0x0acd9000 0 0x4000>,
                               <0 0x0acdd000 0 0x1000>,
                               <0 0x0ace0000 0 0x4000>,
                               <0 0x0ace4000 0 0x1000>;
                         reg-names = "csiphy2",
                                     "csiphy3",
                                     "csiphy0",
                                     "csiphy1",
                                     "vfe0",
                                     "csid0",
                                     "vfe1",
                                     "csid1",
                                     "vfe2",
                                     "csid2",
                                     "vfe_lite0",
                                     "csid0_lite",
                                     "vfe_lite1",
                                     "csid1_lite",
                                     "vfe_lite2",
                                     "csid2_lite",
                                     "vfe_lite3",
                                     "csid3_lite",
                                     "vfe3",
                                     "csid3";

This is the way.

---
bod

