Return-Path: <linux-kernel+bounces-242148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB4928445
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23031C22C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EDB145FED;
	Fri,  5 Jul 2024 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjC9UMzd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2913B5A9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169949; cv=none; b=h+VrS1oETtUk5Q9oWy5rUrCD43P0lFOHF7ZxYg8lxhSD6p5SOvMDWpsWEkWtLQo7LmeGRlPfmCfG/obwXuGoUFzq+c9IeHU5xcPfrPnEhCHsLYVx0R1jYebAreA9QLrtUa/NE2YkTDf3jsROmaVLxswOGa8ZUwAh9rqHk2U+HCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169949; c=relaxed/simple;
	bh=Mf1E0bJe6D34VDHfsekjMcHcFt1bGM0AesoF0vghplg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmCn8sRweLuEMcY+z13fae4BCgluARYvzAa2tO8w/a9uOVyH7WRlPOfazZq/o4K7xkBeS7WuUYfhnCeAk1ZQ3ax0Iyln76N6lEiCOmh+gPSPykaHlXbnsT6Re3IbO7OmYiMdq5y9XfvBZmjxuQpTEzBAujwXtBtb0s1jVgSpNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjC9UMzd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720169947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ynx6wgANHF6xng2dJQISpo0Kqzb6hlq28TB2397xxYw=;
	b=PjC9UMzd4CIKDEtXW8DU6q9H2jMV85QGOWty1esJC4nuRlBshSJc81RwdtA1OqvIP8Uf4q
	V7sgjv8uCF88yX0IGQMIh0SnyWPmWQHOWa0iQgGRTBLqMM22R0h7o7NDLtkoIEifumrG8J
	97gkpU+ru3M7N2HYs/GdQAiudPMpTno=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-pZcXC8mfOSKhmYeugQbNnw-1; Fri, 05 Jul 2024 04:59:05 -0400
X-MC-Unique: pZcXC8mfOSKhmYeugQbNnw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52ea4178bafso701677e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 01:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720169944; x=1720774744;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynx6wgANHF6xng2dJQISpo0Kqzb6hlq28TB2397xxYw=;
        b=QXbOM8h1V3Psc4YMSsGtx2qBZ4JDM63UZRxz3ecURz0EFEYt3yEPWUk5qOI+1ckVRe
         WP05fZADO6bGbMPqk33loexS5bYjkdhSzE5CIYJvB3l9eAw+ep4laRRmIX6Sql+Ksg4g
         jeHK3YRt7hxuBtk9u8WtOk09XOITpPMt7ZtAlfnbm1UjMFs04JOIXUMEqNhTPHG2/wz7
         Jkt4x0TVZYZ+PFd8RGvGA03sM06dn7ddIwWCMxHhG7RXlB7Zx8xDoE9mHu0yGXwrORr9
         H5SBwWcdFQtDiwzQKAHTkOBRkRSrl84Ur6ukcBfCr8qnztd510fgKrNCdsJA3unXZVJt
         6tSg==
X-Forwarded-Encrypted: i=1; AJvYcCWS3agWFcxV0uljzoNXCbN+wX0olZMBC6BomkJBkufehFAospKE1vOwSZpgJcTaUmtRKICvSZPNLEz6CfdvIL5OLMw+So9+m760LGHR
X-Gm-Message-State: AOJu0YxMQ64KZy8eTaS/TyqaoaRvELMYxSxd7um6tfI2vnwb7cK/KIIu
	PcNWiIKGXxt4w4WjoAUWmVSFcGuX5ipkXAHAccuevOILjV1Ggqdct+WlvkxjA+nXGK9lLOJZq8i
	8854NpR8fcee07FyvM6iQ2KYmGb4Og47NjK+tWKrZ+XpsaYWkwqnd2KRYWKJgxg==
X-Received: by 2002:ac2:5227:0:b0:52c:9d31:3f25 with SMTP id 2adb3069b0e04-52ea06c8ba0mr2596356e87.43.1720169944146;
        Fri, 05 Jul 2024 01:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4wtNKCyJUxyKgRpeaDjhaf3qr+qwyUGYEqLpPHVMlL/r7z32HWRl15S5kMSb3IdJWPGOQ0Q==
X-Received: by 2002:ac2:5227:0:b0:52c:9d31:3f25 with SMTP id 2adb3069b0e04-52ea06c8ba0mr2596340e87.43.1720169943726;
        Fri, 05 Jul 2024 01:59:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:b500:3ed7:a1c7:447e:2279? (p200300cbc702b5003ed7a1c7447e2279.dip0.t-ipconnect.de. [2003:cb:c702:b500:3ed7:a1c7:447e:2279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42651531f1fsm17678905e9.0.2024.07.05.01.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 01:59:03 -0700 (PDT)
Message-ID: <32f04739-0cd0-4a9e-9419-c5a13c333c28@redhat.com>
Date: Fri, 5 Jul 2024 10:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] add mTHP support for anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hughd@google.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <ZobtTmzj0AmNXcav@casper.infradead.org>
 <27beaa0e-697e-4e30-9ac6-5de22228aec1@redhat.com>
 <6d4c0191-18a9-4c8f-8814-d4775557383e@redhat.com>
 <Zob8xI-LWe9H_iJs@casper.infradead.org>
 <e08b8245-bc8c-4a18-a1e0-53a139258826@linux.alibaba.com>
 <e826368d-499a-483b-8991-8c25aff88f00@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e826368d-499a-483b-8991-8c25aff88f00@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.07.24 10:45, Ryan Roberts wrote:
> On 05/07/2024 06:47, Baolin Wang wrote:
>>
>>
>> On 2024/7/5 03:49, Matthew Wilcox wrote:
>>> On Thu, Jul 04, 2024 at 09:19:10PM +0200, David Hildenbrand wrote:
>>>> On 04.07.24 21:03, David Hildenbrand wrote:
>>>>>> shmem has two uses:
>>>>>>
>>>>>>      - MAP_ANONYMOUS | MAP_SHARED (this patch set)
>>>>>>      - tmpfs
>>>>>>
>>>>>> For the second use case we don't want controls *at all*, we want the
>>>>>> same heiristics used for all other filesystems to apply to tmpfs.
>>>>>
>>>>> As discussed in the MM meeting, Hugh had a different opinion on that.
>>>>
>>>> FWIW, I just recalled that I wrote a quick summary:
>>>>
>>>> https://lkml.kernel.org/r/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com
>>>>
>>>> I believe the meetings are recorded as well, but never looked at recordings.
>>>
>>> That's not what I understood Hugh to mean.  To me, it seemed that Hugh
>>> was expressing an opinion on using shmem as shmem, not as using it as
>>> tmpfs.
>>>
>>> If I misunderstood Hugh, well, I still disagree.  We should not have
>>> separate controls for this.  tmpfs is just not that special.
> 
> I wasn't at the meeting that's being referred to, but I thought we previously
> agreed that tmpfs *is* special because in some configurations its not backed by
> swap so is locked in ram?

There are multiple things to that, like:

* Machines only having limited/no swap configured
* tmpfs can be configured to never go to swap
* memfd/tmpfs files getting used purely for mmap(): there is no real
   difference to MAP_ANON|MAP_SHARE besides the processes we share that
   memory with.

Especially when it comes to memory waste concerns and access behavior in 
some cases, tmpfs behaved much more like anonymous memory. But there are 
for sure other use cases where tmpfs is not that special.

My opinion is that we need to let people configure orders (if you feel 
like it, configure all), but *select* the order to allocate based on 
readahead information -- in contrast to anonymous memory where we start 
at the highest order and don't have readahead information available.

Maybe we need different "order allcoation" logic for read/write vs. 
fault, not sure.

But I don't maintain that code, so I can only give stupid suggestions 
and repeat what I understood from the meeting with Hugh and Kirill :)

-- 
Cheers,

David / dhildenb


