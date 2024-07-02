Return-Path: <linux-kernel+bounces-238399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271589249F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458A41C22857
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C01205E06;
	Tue,  2 Jul 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbS7Ctm8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CECF1CB313
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955776; cv=none; b=IYyb9Wtha4wjSZkb0mySDcy3P5918w22wYjjvPOryJhmMFlKtJnLeY4aM9QZjMVwXA6SqmgqDj6N0npr7iQinBOJnq+BiImTaTkSGAjufu8O8MFlXYs3qefZTVdoWgt0VJQSOQ3RWWiCb6cxkQEdH3Uxh7a6tbOd6zahxF2NWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955776; c=relaxed/simple;
	bh=T0xOxWQmQ0M5BwRngyU2Pe6auuZ2b+92QIRabO3jThQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQDVMLNEScqE+zHVGLkxyZLYyFfmJq/NhEvd9E4Drh91bxEVr5yKBQhDPauCki06xNgFDvve5dxGPdd9jB4lVyGpo68JjlAY2qtoV0i+uMlRBrDM0HK04nUvqPNQa70o4Uo8BG+YL81lUMXF3hCJaoqF29JXw6umkAOErLkS1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbS7Ctm8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719955774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4mCmg+qmVlxt8KGYANypMXJmATlagY6xqqMFOlfIAZU=;
	b=LbS7Ctm8cE0I1FxtHaiTLPpGG81heIuUifa9BuaipcrMI9he1Elu8NGzTYNnm1ZlC2xMvS
	BKzhZ59Sn1FzRsqv81q/94dMvBL+6KeOht7fTsX6yVhWljbEyp2Xe2L610Pdd0cq6RvOQn
	vibw8jKY8AsL3MbUQ18f8AhngUpHrOM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-6z26B3K9Nhyi17kYtS6uSA-1; Tue, 02 Jul 2024 17:29:32 -0400
X-MC-Unique: 6z26B3K9Nhyi17kYtS6uSA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36248c176c4so2986666f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955771; x=1720560571;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4mCmg+qmVlxt8KGYANypMXJmATlagY6xqqMFOlfIAZU=;
        b=o4wUE1kMxyuxxCYAe/0ZFVV0oLwFTW8iXSi9e/1WD8+I2pKQl7BLSa9hCiF3OxdvE5
         kjOLAmWtETZJ79C8SPiRXsLzz7s4JVau122Akzh6jHxCwAc4S4N0Hh67DpGgVX2WoqnU
         gPnnmsmsUCO+lIpfNktvUaML4DjftR6pWeNLl6c3tejkiWD/zfibXxbFg9SjOGTvBNuQ
         GX12RlZznSOqoTWD9/9m6NuC7msflAg6H4/6uZHrCUpKMMlEvqHTViAbd2SJf0EVooxM
         wOBcsl30m9rCP9akqPk3eoPgLKFFnpZzIvExEgk3gIuoNBLVtza/Ur8WfLv7Ao1Cm/UP
         HGmw==
X-Forwarded-Encrypted: i=1; AJvYcCUnKFg2Jxw/6sU86i0wQWDST9FOSDNDLCm0YhIsIe2UVW4Td8CTEQXSJaIquoihL4oXILPJtRIIddwgurE/IGXb7kQARNR425HvUTzk
X-Gm-Message-State: AOJu0Yz5SpZnkNOoR3Ay75BeuoXEWgghFUO6T7qz/FosYd+jmt+mB4D9
	jAb2U+K3mNO/7CKQ5vK7NeDVRyhUreVNvwNY9p29zT6DfteXAarlBW1DRvKgti6njv94koDUA7Y
	ynqkilfQuDubya5YWwzQ0GeEZ85Vxs92Eyl8EZG0c0JoFZYNKMJCeJfGTdstCSg==
X-Received: by 2002:a05:6000:1fae:b0:367:4384:a572 with SMTP id ffacd0b85a97d-36775697661mr7176110f8f.9.1719955771560;
        Tue, 02 Jul 2024 14:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9ScqTr6M4sltWSpFd0RC76ILUPS4EHOuXHNAKI5cBu3xOmcFKVkST7kkIVFpkrb41PxzcUA==
X-Received: by 2002:a05:6000:1fae:b0:367:4384:a572 with SMTP id ffacd0b85a97d-36775697661mr7176098f8f.9.1719955771014;
        Tue, 02 Jul 2024 14:29:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36792881856sm174630f8f.6.2024.07.02.14.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 14:29:30 -0700 (PDT)
Message-ID: <15f16b06-e129-49af-ae11-62ff6615d229@redhat.com>
Date: Tue, 2 Jul 2024 23:29:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix khugepaged activation policy
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lance Yang <ioworker0@gmail.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240702144617.2291480-1-ryan.roberts@arm.com>
 <c877a136-4294-4f00-b0ac-7194fe170452@redhat.com>
 <ed5042af-b12f-4a36-a2e7-9d8983141099@arm.com>
 <686d3f32-45b0-4dd5-8954-e75748b9c946@redhat.com>
 <46fb005b-30e4-4340-b1e2-8789833f952c@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <46fb005b-30e4-4340-b1e2-8789833f952c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.07.24 18:33, Ryan Roberts wrote:
> On 02/07/2024 16:38, David Hildenbrand wrote:
>> On 02.07.24 17:29, Ryan Roberts wrote:
>>> On 02/07/2024 15:57, David Hildenbrand wrote:
>>>> On 02.07.24 16:46, Ryan Roberts wrote:
>>>>> Since the introduction of mTHP, the docuementation has stated that
>>>>> khugepaged would be enabled when any mTHP size is enabled, and disabled
>>>>> when all mTHP sizes are disabled. There are 2 problems with this; 1.
>>>>> this is not what was implemented by the code and 2. this is not the
>>>>> desirable behavior.
>>>>>
>>>>> Desirable behavior is for khugepaged to be enabled when any PMD-sized
>>>>> THP is enabled, anon or file. (Note that file THP is still controlled by
>>>>> the top-level control so we must always consider that, as well as the
>>>>> PMD-size mTHP control for anon). khugepaged only supports collapsing to
>>>>> PMD-sized THP so there is no value in enabling it when PMD-sized THP is
>>>>> disabled. So let's change the code and documentation to reflect this
>>>>> policy.
>>>>>
>>>>> Further, per-size enabled control modification events were not
>>>>> previously forwarded to khugepaged to give it an opportunity to start or
>>>>> stop. Consequently the following was resulting in khugepaged eroneously
>>>>> not being activated:
>>>>>
>>>>>      echo never > /sys/kernel/mm/transparent_hugepage/enabled
>>>>>      echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
>>>>> Closes:
>>>>> https://lore.kernel.org/linux-mm/7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com/
>>>>> Cc: stable@vger.kernel.org
>>>>> ---
>>>>>
>>>>> Hi All,
>>>>>
>>>>> Applies on top of today's mm-unstable (9bb8753acdd8). No regressions
>>>>> observed in
>>>>> mm selftests.
>>>>>
>>>>> When fixing this I also noticed that khugepaged doesn't get (and never has
>>>>> been)
>>>>> activated/deactivated by `shmem_enabled=`. I'm not sure if khugepaged knows how
>>>>> to collapse shmem - perhaps it should be activated in this case?
>>>>>
>>>>
>>>> Call me confused.
>>>>
>>>> khugepaged_scan_mm_slot() and madvise_collapse() only all
>>>> hpage_collapse_scan_file() with ... IS_ENABLED(CONFIG_SHMEM) ?
>>>
>>> Looks like khugepaged_scan_mm_slot() was converted from:
>>>
>>>     if (shmem_file(vma->vm_file)) {
>>>
>>> to:
>>>
>>>     if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
> 
> CONFIG_READ_ONLY_THP_FOR_FS depends on CONFIG_SHMEM in Kconfig, so I think this is all correct/safe. Although I'm not really sure what the need for the dependency is.


Right. It's likely some historical artifact ...

[...]

> 
> I'll do a v2 with this addition if you agree?
> 
> static inline bool hugepage_pmd_enabled(void)
> {
> 	/*
> 	 * We cover both the anon and the file-backed case here; for
> 	 * file-backed, we must return true if globally enabled, regardless of
> 	 * the anon pmd size control status.
> 	 */
> 	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && hugepage_global_enabled()) ||
> 	       test_bit(PMD_ORDER, &huge_anon_orders_always) ||
> 	       test_bit(PMD_ORDER, &huge_anon_orders_madvise) ||
> 	       (test_bit(PMD_ORDER, &huge_anon_orders_inherit) && hugepage_global_enabled());
> }
> 

I think this looks good :)

>>>
>>> But back to my original question, I think hugepage_pmd_enabled() should also be
>>> explicitly checking the appropriate shmem_enabled controls and ORing in the
>>> result? Otherwise in a situation where only shmem is THP enabled (and file/anon
>>> THP is disabled) khugepaged won't run.
>>
>> I think so.
> 
> I'll do this part as a separate change since it's fixing a separate bug.

Makes sense.

> 
>>
>>>
>>>>
>>>> The thp_vma_allowable_order() check tests if we are allowed to collapse a
>>>> PMD_ORDER in that VMA.
>>>
>>> I don't follow the relevance of this statement.
>>
>> On whatever VMA we indicate true, we will try to collapse in khugepaged.
>> Regarding the question, what khugepaged will try to collapse.
> 
> Oh I see. Yes agreed. But we don't have a VMA when enabling/disabling khugepaged. We just want to know "are there vmas for which khugepaged would attempt to collapse to PMD size?"

Yes, only to give you a pointer on which VMAs khugepaged will be willing 
to work with.

-- 
Cheers,

David / dhildenb


