Return-Path: <linux-kernel+bounces-540601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170EA4B2BE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BFF188B06B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734AF1E9907;
	Sun,  2 Mar 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZUpOoDb"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963CC1DDC11
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740930970; cv=none; b=VvbCiGkZ4AdDIZnNxZQu0G935V6qiGYv0q8slX0kaei49eCCDvyaqciwYcn4ivQHemOaLi4QPC/+Itsi8az04QyncEtN4TvEmQWZbzxmFBj1tPz3PBY6cihQcCE0sn40o0iu4XtpFEto+i6OHTZeDvaLmwndN6StMW16ckVwP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740930970; c=relaxed/simple;
	bh=H8X4S94pGAKOquO0l2C2cojT9a6H8qXbxIRVykkPpQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MA9yFZpyenl6L4VnpU6HEijI3DqOpQQJZnM3IiTLKREzdrq50a6fFAmAGPnBY/23LqEkzTv7vuFE5HLFMKa6+1IAu3O5FhOfDgMbLpZKWRCPKbPzUSPadDcSbES1rqpZq9wpi6jXQd1VQ7w9QlVQrm+1Ii3fwdjKVsBdU61Cwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UZUpOoDb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43996e95114so24660095e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740930967; x=1741535767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlpIq9SPuf0qn1v2edQTVWT/w0C8xiNzl1ulEaeBlbw=;
        b=UZUpOoDb5Gn07chugCDy61oyPhAXj+3aVWWz/P8n/a+3wmU7w8Ow7A/nLLBFIMYldj
         xChVIE9nn0t5vErEFtSSInvFUsmCQpkh2ec999UvziRRX7D71OZThHffUUrvgk/+Kfar
         I2Q3yNqPW8Q/8xKQJJYHfVIwlYu7byiRnS3bQCqKBBE4D0Jvry+u6RISiNXWuVsejqT5
         6b3zkqazt4zylqtfeV/8gUVzujq/VNZosSFPc5vPg6TxpjX59iLwKnpz9z7pGLRA78lC
         lPThFrvZP88RMv1ql2mlCVfeECd4aHCUi9ne6YGaNmE+gb48zIVptKtwOgFPSR+w2ol0
         2tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740930967; x=1741535767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlpIq9SPuf0qn1v2edQTVWT/w0C8xiNzl1ulEaeBlbw=;
        b=NKlJ66n/N4YuQ4L95IkmjvE48dsMumEseMkMsMRddvX1xK4iKCEiYlz7ktlzywqPLb
         ab0+cZo+j26eMIqJgdpOJiy9hNjLAennKVcZpyhjppVahs9uTljit5U2opbpLyvqYx2A
         34dUORbhrHC/fQWHzCKDw5U9/FE9Y52eF4atVSkpE0ekfo1AvNd9E6PBfKyQsbzWTgvk
         xjlTeXPNqkHHsVp8qKNIFyQ4NuinQb/oiuovMXjxhPj8Bx1+BtzWgkHBKtaAdyQi1UUz
         PGwf3OyNidLi7aXr8z42ovPas9G6txSIIZtl82DK09gaBvWL+gb+nPFRlcp0ZKsNHS3W
         huPw==
X-Forwarded-Encrypted: i=1; AJvYcCXtOFtTqYnpb1wwHS0txAyAavXFlEw4tT6X8zud99hux35rXnT6eKVbamhrPzXJfS4yPEVh5Qxeb97qRR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3OsEf5BN/ZZAYb2NBo+Ws+2ZzDEbRac9xY0/IJ6EZ/BIIdQm
	bDFinorHipmL4iwmxQwLd5HeRAnTN8z0OhcQ/DkknvbfSojQ77+YRfIMu+Vf2Cw=
X-Gm-Gg: ASbGnctMTW7rKEa/qqLXPMF3sAXvIfvH/CfF9nP3V6OpHJ6LxRa236pz3jiG/1NMbYB
	VU5nuC6s8CteY2DZbtRc6dBhqN71RE9jmMabNls4l84+dN89EvkLu7kbRKDO/xuBvA4v59A6vWA
	WBRce8s83gBKasBmKUKa71CNbF4fTSu1kGSB6cK5xc9NoZY1/rl2sAZTSC2XKEUeE8iaSUTlXMP
	VxjlMf99mmX+QQztX/zE8yvT6KuAghYZXaWdklAk0sIxDhJ2aoR2+vgpdDtIWXjUKOwXsSyqzrL
	p2ZHNnQn9XClYguqNCQYQ6fDJEj4qfTagSGzZWALgqgUGIqysZwT9OTnXPgdJTXD3yeuyZp9rn4
	Z7GsLc2m6cw==
X-Google-Smtp-Source: AGHT+IHhDgttzslV/5SoS5Hp8trBu+m77gcArllf4u4+s29M07vSbx2XO1Tt/k0SG6UzXxJv1kT95A==
X-Received: by 2002:a05:600c:2292:b0:43b:c0fa:f9ce with SMTP id 5b1f17b1804b1-43bc0fafff1mr5402165e9.14.1740930966691;
        Sun, 02 Mar 2025 07:56:06 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f839asm127814985e9.2.2025.03.02.07.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 07:56:06 -0800 (PST)
Message-ID: <19109672-2856-457f-b1f6-305abc6c4434@linaro.org>
Date: Sun, 2 Mar 2025 15:56:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] venus driver fixes to avoid possible OOB read
 access
To: Vedang Nagar <quic_vnagar@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250215-venus-security-fixes-v2-0-cfc7e4b87168@quicinc.com>
 <c3b27e55-f627-417c-bb62-3189f248fb99@linaro.org>
 <7bf1aeaa-e1bd-412b-90fc-eda30b5f5b37@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <7bf1aeaa-e1bd-412b-90fc-eda30b5f5b37@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2025 11:58, Vedang Nagar wrote:
>>
>> The basic question : what is the lifetime of the data from RX 
>> interrupt to consumption by another system agent, DSP, userspace, 
>> whatever ?
> As mentioned in [1], With the regular firmware, after RX interrupt the 
> data can be considered as valid until next interrupt is raised, but with 
> the rouge firmware, data can get invalid during the second read and our 
> intention is to avoid out of bound access read because of such issues.

This is definitely the part I don't compute.

1. RX interrupt
2. Frame#0 Some amount of time data is always valid
3. RX interrupt - new data
4. Frame#1 new data delivered into a buffer

Are you describing a case between RX interrupts 1-3 or a case after 1-4?

Why do we need to write code for rouge firmware anyway ?

And the real question - if the data can be invalidated in the 1-3 window 
above when is the safe time to snapshot that data ?

We seem to have alot of submissions to deal with 'rouge' firmware 
without I think properly describing the problem of the _expected_ data 
lifetime.

So

a) What is the expected data lifetime of an RX buffer between one
    RX IRQ and the next ?
    I hope the answer to this is - APSS owns the buffer.
    This is BTW usually the case in these types of asymmetric setups
    with a flag or some other kind of semaphore that indicates which
    side of the data-exchange owns the buffer.

b) In this rouge - buggy - firmware case what is the scope of the
    potential race condition ?

    What I'd really like to know here is why we have to seemingly
    memcpy() again and again in seemingly incongrous and not
    immediately obvious places in the code.

    Would we not be better advised to do a memcpy() of the entire
    RX frame in the RX IRQ handler path if as you appear to me
    suggesting - the firmware can "race" with the APSS
    i.e. the data-buffer ownership flag either doesn't work
    or isn't respected by one side in the data-exchange.

Can we please have a detailed description of the race condition here ?

I don't doubt the new memcpy() makes sense to you but without this 
detailed understanding of the underlying problem its virtually 
impossible to debate the appropriate remediation - perhaps this patch 
you've submitted - or some other solution.

Sorry to dig into my trench here but, way more detail is needed.

> [1]: https://lore.kernel.org/lkml/4cfc1fe1-2fab-4256-9ce2- 
> b4a0aad1069e@linaro.org/T/#m5f1737b16e68f8b8fc1d75517356b6566d0ec619
>>
>> Why is it in this small specific window that the data can change but 
>> not later ? What is the mechanism the data can change and how do the 
>> changes you propose here address the data lifetime problem ?
> Currently this issue has been discovered by external researchers at this 
> point, but if any such OOB issue is discovered at later point as well 
> then we shall fix them as well.

Right but, I'm looking for a detailed description of the problem.

Can you describe from RX interrupt again what the expected data lifetime 
of the RX frame is, which I hope we agree is until the next RX interrupt 
associated with a given buffer with an ownership flag shared between 
firmware and APSS - and then under what circumstances that "software 
contract" is being violated.

> Also, with rougue firmware we cannot fix the data lifetime problem in my 
> opinion, but atleast we can fix the out of bound issues.
>>
>> Without that context, I don't believe it is really possible to 
>> validate an additional memcpy() here and there in the code as fixing 
>> anything.
> There is no additional memcpy() now in the v2 patch, but as part of the 
> fix, we are just trying to retain the length of the packet which was 
> being read in the first memcpy() to avoid the OOB read access.

I can't make a suggestion because - personally speaking I still don't 
quite understand the data-race you are describing.

I get that you say the firmware is breaking the contract but, without 
more detail on _how_ it breaks that contract I don't think it's really 
possible to validate your fix here, fixes anything.

---
bod

