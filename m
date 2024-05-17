Return-Path: <linux-kernel+bounces-182321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 264278C89AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1176285CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F2312F599;
	Fri, 17 May 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzBo1aay"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACE12F589
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961465; cv=none; b=aPob1TM/SUEEGub+HR2tAds6Dy3WD2oDHPuLrPweJspqI50ZtuDGBAoI5eroVLBBn/VzE+rk3ZghWckwycA3mS1lHXPOJ00TGYGWC/bNaA/8KPjqFIqg89nIaVdN2LpFDhflNbIQsII0ijKhqmcNLD99Ralzklal1VNgme2nhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961465; c=relaxed/simple;
	bh=vGaP4OQs9RTIkBSpLO052GxLkmQMWMMGZg6r+zY5HdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2qCOyKiKt5UMgc7WC8wN705CQSY2ntzpr1Pq31h4ebZZM7mc7dZCvI3ykVknEkc8r9b9paayXDZXPi9lnLR0nkVoGZ6F1YsS6geqhQeait+HWd2uyY4HPDK6/NaGVylcuJdqfZ9zbxSjTGqmbzPhk81F1UJVY/KMwpKhfydGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzBo1aay; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee12baa01cso14192495ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715961463; x=1716566263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji4taWv2GeHDiPPeAx4iqOWvCg0h0yzw4dxXrAX3PVk=;
        b=OzBo1aayzSn4ZJtSoJGIee0ikG+4g859QqkMGpplqj8oZJ53Ng1KAg97W+T374V+vD
         5IGhO2GTbg/sWGXcJCq3HLiQ3I8f9F5LNEKmR4UE/6nrVjbhLO7CJlSuo+wrY/2Ie1eA
         Fe2iD8sN6CR32IIvuEasz0QEkiO6MYOEYR9Wlbwql6bM0Wv71E2qtdvBI49op3VXu6Qg
         5VtQVcZVSdg/J3yIVxSaYVcOniFkJEGPa5l3VVrrLnOy/7qxMMF3hjL6dvfPDET9APqH
         IqWQntS+SkpardAZMAEGv2qf45qwhvQdhUcMzIZlNgUBlwByvJDygcLqEE4F9jxr5pXK
         36bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715961463; x=1716566263;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji4taWv2GeHDiPPeAx4iqOWvCg0h0yzw4dxXrAX3PVk=;
        b=Bwv61IwNT2Zbz87+r3vaMNC1xRYtQVzrrx6Wzwk0UtWfn8QH3pnWLw13k8m1wPlt01
         FKWAgOBLYlul/3e31UI1HdfGM92eB52H11NSym7R0G5wNLdWhLvM4edubcd8Ay+J4Z8k
         l0swxjndJakjBeu38h/wcKDQRhoTT/uP7ei8RSmv2U/RZZ9mhbaTE2OQHDk83ulWFbIw
         P3AEf4o6+Gcu7/wEY4UsNJ2irAtQaBMUNIUeM8v8YNn1mYWomuRNCGdJe7xyTdO0Q8KS
         P280Pv9yrfVPeR2gRBbnc+GRh+0SnO6wsGaThrTZD6GgwApl2PV2IE6fb71keoLmTBAZ
         VMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTN4zmZZ8d9zj0n5TObDLM6pbDZzdzY8TOZWP/wCDUmkxjHKwP7LSY0zZEnq7WTwI7Pugrg/VtogdY3AneVeVPwpx/L78lcP093PIc
X-Gm-Message-State: AOJu0YxKDJxbWO3UtgIwTxiuQo3iXwWW3ZIghbyJZp+ugYE+KT6L04WG
	NoX3oZY9OmlNP4CHW1joZKy/7U5Xq0wNuQl3jQmE400C6BFwFwFm
X-Google-Smtp-Source: AGHT+IEsW79Ws3cpc46S5ZDHy2wFokIe8Q5qdUpq8WKHFXpN7EYAr00PAvSTiYv3HMwwnNZxrx9FNg==
X-Received: by 2002:a05:6a21:2d8b:b0:1af:f6b9:e3e4 with SMTP id adf61e73a8af0-1aff6b9e5e8mr18378028637.12.1715961463440;
        Fri, 17 May 2024 08:57:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2fe07sm14861708b3a.216.2024.05.17.08.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 08:57:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <863a0601-6e64-40b5-a204-bc20216d514c@roeck-us.net>
Date: Fri, 17 May 2024 08:57:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] regmap: kunit: Run sparse cache tests at non-zero
 register addresses
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
References: <20240408144600.230848-1-rf@opensource.cirrus.com>
 <20240408144600.230848-5-rf@opensource.cirrus.com>
 <5c1daddb-d8b3-420a-839f-208e0a6e168b@roeck-us.net>
 <c5f8c1cf-c575-4619-bfca-e89e9c439017@opensource.cirrus.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c5f8c1cf-c575-4619-bfca-e89e9c439017@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/17/24 08:44, Richard Fitzgerald wrote:
> On 16/05/2024 20:53, Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Apr 08, 2024 at 03:45:53PM +0100, Richard Fitzgerald wrote:
>>> Run the cache_drop() and cache_present() tests at blocks of addresses
>>> that don't start at zero.
>>>
>>> This adds a from_reg parameter to struct regmap_test_param. This is
>>> used to set the base address of the register defaults created by
>>> gen_regmap().
>>>
>>> Extra entries are added to sparse_cache_types_list[] to test at non-zero
>>> from_reg values. The cache_drop() and cache_present() tests are updated
>>> to test at the given offset.
>>>
>>> The aim here is to add test cases to cache_drop() for the bug fixed by
>>> commit 00bb549d7d63 ("regmap: maple: Fix cache corruption in
>>> regcache_maple_drop()")
>>>
>>> But the same parameter table is used by the cache_present() test so
>>> let's also update that to use from_reg.
>>>
>>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>>
>> With this patch in mainline, I get lots of errors such as
>>
>> [   23.494308] =============================================================================
>> [   23.496391] BUG kmalloc-64 (Tainted: G                 N): kmalloc Redzone overwritten
>>
> 
> Fix sent:
> https://lore.kernel.org/lkml/20240517144703.1200995-1-rf@opensource.cirrus.com/T/#u
> 

I noticed. Thanks a lot for the quick turnaround. Currently testing.

Thanks,
Guenter


