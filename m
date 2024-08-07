Return-Path: <linux-kernel+bounces-277221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F8949E27
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD14EB234A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A02182863;
	Wed,  7 Aug 2024 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WQX9WHCf"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6421C27
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000150; cv=none; b=HjjXBaZ/9mUW+QO+6MByp+xMyn73BEBwDGZIojBvT7nLpVW7leEvZD3C81nB3kkBYQqHCsMiZgPSOgeM0kiOWiGkfTSflUw5aCUwby3h5ZCXoYPamlg2vkqZmB43pjn3pwV2iHWWnjQTGDhq+X3rfTcwEg2tH5GPPML5r47q9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000150; c=relaxed/simple;
	bh=VyIwDrc95ewVAv+phM8Nl14gaxj3TMvZVZ7v48/m0go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3J0UOr8ril1IkNUmWG5z1/LNP4BR1+fzhr6cp8veFuHqoOJD1grBecdGdCc2Ygs+PtJwmqZtb6WN8zHnrMd5d24AhlMglkMSukkHox2WI1vW5QLa9Cpq2BBRhQmsbfNmDTpSOiVYVortKvyoOHSzVd0Sv/EIgxQbu7IYZJllH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WQX9WHCf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb5eafd585so120619a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000148; x=1723604948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Qp4aTVmdmWPzcYZIEzPtVlpNUp8xuLNVx6XDmrZgB0=;
        b=WQX9WHCfycv9LXFYlZptJmDhQOeQ+W/dmex0+ex8bovnrkaxpXUz59DE5HhFCY6blR
         svHh4qysVQDv/ONVMmS+UOduiWRXCvKajiBrVs/hN6ghxK+RQjGZo5ognPj8dTavnNW8
         P++UNOkzAEwoijV+5a9G/R0eTlcFx7i1XvsvcxGJQZvIE/bgQqxdL4nwXfuIOno/bwOA
         50sljgLDFctxy1HNylbSJMRYPWtGgroz8olvOxUwq6qfU5GhkjuH7wFNyoypVEn9zX0D
         nQzaKYFRGT3jpwX1A8lLqbny9utv6Wjmir5ecLSGJU5+Acwv12p8k7YkLfJlAhQKgVZ7
         yG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000148; x=1723604948;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qp4aTVmdmWPzcYZIEzPtVlpNUp8xuLNVx6XDmrZgB0=;
        b=eU8yIdJ2ZUuBISVWhBEqAJkHnFY9PhFYbqSyczGIlO7946vc4oQMWepyvABWZoL5M5
         5jMehAjFsXomn3S4LMmbViwUboRK6WZF+z04DnSRhkRHrkHoRFfW1EDgCs6Iv53BhL1j
         LkxBZI68n/B0764GnqniA0g/J3FnbNjjJb7P/zKJ/a0haXlooSvoueitpy7eSAoQC3Cn
         MoaEWH98JQRFvTZDIsANaZXGLkg5b2vfQO90+IXa0TUwhggKwtFQTSd9ZISWMEn+Bt3l
         wKocVdUJknR8R+ljXesPryWtdhSqR47afvJXS27masXVMmDOxxyRwBrFn7R8OHKSSepD
         O7DA==
X-Forwarded-Encrypted: i=1; AJvYcCVfhqd9rMjE+XsfBnSoo0RRGVTF2dTGkBaIn2Z5C5eRE8ZyqIO55rYCperqASakPdALvlISEO8KjnFpctU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyukPYoUS0p33bEUFQro0Vy90RoXzfNmsjh+wQU1E9FGlK7BDTl
	1qufN5X8qCbeyTepgw28RiEkQn1voXY4Q5u44sU+StTS4qvQRtg8CXL8wCmKAns=
X-Google-Smtp-Source: AGHT+IFnE7Hwzq2CjECVQoHPZgfKViKTLbL0xhuI7mAK3wQkcHIP2KqcW5i8UsUC9UPm6Qw0dOYfJg==
X-Received: by 2002:a05:6a20:3945:b0:1c4:c402:8189 with SMTP id adf61e73a8af0-1c69953b0e6mr14544481637.2.1723000147692;
        Tue, 06 Aug 2024 20:09:07 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed15367sm7811965b3a.175.2024.08.06.20.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 20:09:07 -0700 (PDT)
Message-ID: <f6c05526-5ac9-4597-9e80-099ea22fa0ae@bytedance.com>
Date: Wed, 7 Aug 2024 11:08:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] mm: pgtable: make pte_offset_map_nolock()
 return pmdval
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <d101b185eb55438b18faa2029e4303b7453bd5f5.1722861064.git.zhengqi.arch@bytedance.com>
 <0e8e0503-5796-4b61-bb5b-249e285f5d21@redhat.com>
 <39281a4d-d896-46fd-80a5-8cd547d1625f@bytedance.com>
 <0f467510-a0d0-4a98-8517-43813fa4c131@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <0f467510-a0d0-4a98-8517-43813fa4c131@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2024/8/6 22:16, David Hildenbrand wrote:
> On 06.08.24 04:40, Qi Zheng wrote:
>> Hi David,
>>
>> On 2024/8/5 22:43, David Hildenbrand wrote:
>>> On 05.08.24 14:55, Qi Zheng wrote:
>>>> Make pte_offset_map_nolock() return pmdval so that we can recheck the
>>>> *pmd once the lock is taken. This is a preparation for freeing empty
>>>> PTE pages, no functional changes are expected.
>>>
>>> Skimming the patches, only patch #4 updates one of the callsites
>>> (collapse_pte_mapped_thp).
>>
>> In addition, retract_page_tables() and reclaim_pgtables_pmd_entry()
>> also used the pmdval returned by pte_offset_map_nolock().
> 
> Right, and I am questioning if only touching these two is sufficient, 
> and how we can make it clearer when someone actually has to recheck the 
> PMD.
> 
>>
>>>
>>> Wouldn't we have to recheck if the PMD val changed in more cases after
>>> taking the PTL?
>>>
>>> If not, would it make sense to have a separate function that returns the
>>> pmdval and we won't have to update each and every callsite?
>>
>> pte_offset_map_nolock() had already obtained the pmdval previously, just
>> hadn't returned it. And updating those callsite is simple, so I think
>> there may not be a need to add a separate function.
> 
> Let me ask this way: why is retract_page_tables() and 
> reclaim_pgtables_pmd_entry() different to the other ones, and how would 
> someone using pte_offset_map_nolock() know what's to do here?

If we acuqire the PTL (PTE or PMD lock) after calling
pte_offset_map_nolock(), it means we may be modifying the corresponding
pte or pmd entry. In that case, we need to perform a pmd_same() check
after holding the PTL, just like in pte_offset_map_lock(), to prevent
the possibility of the PTE page being reclaimed at that time.

If we call pte_offset_map_nolock() and do not need to acquire the PTL
afterwards, it means we are only reading the PTE page. In this case, the
rcu_read_lock() in pte_offset_map_nolock() will ensure that the PTE page
cannot be reclaimed.

> 
> IIUC, we must check the PMDVAL after taking the PTL in case
> 
> (a) we want to modify the page table to turn pte_none() entries to
>      !pte_none(). Because it could be that the page table was removed and
>      now is all pte_none()
> 
> (b) we want to remove the page table ourselves and want to check if it
>      has already been removed.
> 
> Is that it?

Yes.

> 
> So my thinking is if another function variant can make that clearer.

OK, how about naming it pte_offset_map_before_lock?

Thanks,
Qi

> 

