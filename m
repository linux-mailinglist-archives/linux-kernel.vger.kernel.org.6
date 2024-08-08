Return-Path: <linux-kernel+bounces-279089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D91994B8CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E42A2885EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C583D189914;
	Thu,  8 Aug 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YclAaaN2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01221189F33
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105038; cv=none; b=Nl5Rpd3iQhvYIbGrwPgAfCPVG1dSVEgfWR2rimEl1inH8Qv7RKADOh0Y9fvNd0b6cLGnOK4a9+48WrNYwHXYWgaqbsY7SKVq6CSdA592nJFYt4U/ar15ZFYMIuYsx8pVLB+Mei0AbXPFWl1nxpiKqeMvcMjlNfpYSI1XOKqBHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105038; c=relaxed/simple;
	bh=8xb2+WQ0qR60BekqpOQJe0U4Kljjrd8W0lqUhTiEzPg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=awsPsYgYGTtPLZkWafumojcXiuOUVE8brM3slLrmqhIHt3C20np0XYAZWN4W1Nmv7u7IaxECfEuz5v6+D5zFaGlWh3ZMyu6ZyWX9rNcaETTN79e2ScpMA6GUQvJFfbc7KY5PQuEIkUTKhf3PZ/F/mX06rBNHpOSM3EX1GSu+A2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YclAaaN2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723105035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wo5SL6PdQv0EChIPcTGld1lNiuq5jjFsRy4X5tXC3gg=;
	b=YclAaaN2bhL93PXrd7V5dRYqlo+VwobytwAJQjeUIrNiTuBudM2pp8Bp5GfcNs8NLdOYMs
	QSFLsaEzZaKI0+hKUpTu//CUgho3aK1PV9DNmRQi5RMbR7hRWvn9WEaMvqGBFcKhc8x2ZC
	SXnfsSFcnutoipmGaGPjIz2dpiNvpng=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-NOTdUCmkOSG4lqa6Lshk1Q-1; Thu, 08 Aug 2024 04:17:14 -0400
X-MC-Unique: NOTdUCmkOSG4lqa6Lshk1Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef23ec8dcfso5741381fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 01:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723105033; x=1723709833;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wo5SL6PdQv0EChIPcTGld1lNiuq5jjFsRy4X5tXC3gg=;
        b=SS5NizbqYi0lnMKRJgT8aPFIrXasmqYy1IY2ycFSTqRRPT4FEZVYUnLOA2SqNwXct+
         cNJ+2jPnQ4UGLa6p+MY0ONObcIz5aiZBOi2es0GXnP/y+l1vMja2bpkZpKMGqmBbzDOx
         J/zSzOqT4EQsO0Eoh898EauImCHRB2x93N5XwbxiNxo+hwxrsEHbUgQUaLW2+4kVdnNU
         4bb4pwO9E6k1FJMJ/gzfT9Ap4lWKN4wKSZA3zvGdNrX+NY3UhAAw+llPq+ETj5ZCKZzx
         LHnspaTrtubLVQvDgBXzik5iHLK9Gv4O6c2KVq6BziW7RJigvHwvQYW3E1lrxkWORT9C
         ONhw==
X-Forwarded-Encrypted: i=1; AJvYcCUeKqF9rlHa3bnT6hmBxFcslzIc3uPzgYemWOApitmm8A5wP37NILRirgO5k8/2gfuxy9yRvSUh4V+E1XMWrZfMry+Ur6LmY8X2/6nw
X-Gm-Message-State: AOJu0Ywtic2ryEKAG3tyeABwlETFM36htFD8xwAmke9Zu6ypqfFR8jZ4
	D4xOYRROPj6bs9dpx8diyZiUvglbsAzMlEq4FizMYiUEUuOFbQ6QnlgSAwhuxutpwED7H2fUCuT
	rzYSlXlOYkLP/efOtWVUVpfbuLR95nGPMU6Fhj6wPZLGyfkBt7gCRnvCQqn+XUUeSSXKcsA==
X-Received: by 2002:a2e:9b4b:0:b0:2ef:2d4d:af76 with SMTP id 38308e7fff4ca-2f19de7b862mr7238691fa.43.1723105032433;
        Thu, 08 Aug 2024 01:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaCBXJ8te7qAAfH4sJ5E95MCULEjnE1GhohDNVTXcuXCfdn+avyx5hgxSA2X0GFmc+ZkBJ+Q==
X-Received: by 2002:a2e:9b4b:0:b0:2ef:2d4d:af76 with SMTP id 38308e7fff4ca-2f19de7b862mr7238351fa.43.1723105031803;
        Thu, 08 Aug 2024 01:17:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c739083sm9738815e9.18.2024.08.08.01.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 01:17:11 -0700 (PDT)
Message-ID: <41b49313-5804-46ba-9e1d-358b079274cd@redhat.com>
Date: Thu, 8 Aug 2024 10:17:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
From: David Hildenbrand <david@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
 chrisl@kernel.org, hanchuanhua@oppo.com, ioworker0@gmail.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 ziy@nvidia.com
References: <20240808010457.228753-2-21cnbao@gmail.com>
 <20240808070847.285075-1-21cnbao@gmail.com>
 <b17133e5-4f25-47d5-b6db-412ae96db8c3@redhat.com>
 <14128caf-f7dc-41c0-ab63-c8d434c35f76@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <14128caf-f7dc-41c0-ab63-c8d434c35f76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.08.24 10:08, David Hildenbrand wrote:
> On 08.08.24 10:03, David Hildenbrand wrote:
>> On 08.08.24 09:08, Barry Song wrote:
>>> On Thu, Aug 8, 2024 at 1:05 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> When a new anonymous mTHP is added to the rmap, we increase the count.
>>>> We reduce the count whenever an mTHP is completely unmapped.
>>>>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>> ---
>>>>     Documentation/admin-guide/mm/transhuge.rst |  5 +++++
>>>>     include/linux/huge_mm.h                    | 15 +++++++++++++--
>>>>     mm/huge_memory.c                           |  2 ++
>>>>     mm/rmap.c                                  |  3 +++
>>>>     4 files changed, 23 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>>> index 058485daf186..715f181543f6 100644
>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>> @@ -527,6 +527,11 @@ split_deferred
>>>>             it would free up some memory. Pages on split queue are going to
>>>>             be split under memory pressure, if splitting is possible.
>>>>
>>>> +anon_num
>>>> +       the number of anon huge pages we have in the whole system.
>>>> +       These huge pages could be still entirely mapped and have partially
>>>> +       unmapped and unused subpages.
>>>> +
>>>>     As the system ages, allocating huge pages may be expensive as the
>>>>     system uses memory compaction to copy data around memory to free a
>>>>     huge page for use. There are some counters in ``/proc/vmstat`` to help
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index e25d9ebfdf89..294c348fe3cc 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -281,6 +281,7 @@ enum mthp_stat_item {
>>>>            MTHP_STAT_SPLIT,
>>>>            MTHP_STAT_SPLIT_FAILED,
>>>>            MTHP_STAT_SPLIT_DEFERRED,
>>>> +       MTHP_STAT_NR_ANON,
>>>>            __MTHP_STAT_COUNT
>>>>     };
>>>>
>>>> @@ -291,14 +292,24 @@ struct mthp_stat {
>>>>     #ifdef CONFIG_SYSFS
>>>>     DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
>>>>
>>>> -static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>>>> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
>>>>     {
>>>>            if (order <= 0 || order > PMD_ORDER)
>>>>                    return;
>>>>
>>>> -       this_cpu_inc(mthp_stats.stats[order][item]);
>>>> +       this_cpu_add(mthp_stats.stats[order][item], delta);
>>>> +}
>>>> +
>>>> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>>>> +{
>>>> +       mod_mthp_stat(order, item, 1);
>>>>     }
>>>> +
>>>>     #else
>>>> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
>>>> +{
>>>> +}
>>>> +
>>>>     static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>>>>     {
>>>>     }
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 697fcf89f975..b6bc2a3791e3 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -578,6 +578,7 @@ DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
>>>>     DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>>>>     DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>>>>     DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>>>> +DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);
>>>>
>>>>     static struct attribute *stats_attrs[] = {
>>>>            &anon_fault_alloc_attr.attr,
>>>> @@ -591,6 +592,7 @@ static struct attribute *stats_attrs[] = {
>>>>            &split_attr.attr,
>>>>            &split_failed_attr.attr,
>>>>            &split_deferred_attr.attr,
>>>> +       &anon_num_attr.attr,
>>>>            NULL,
>>>>     };
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 901950200957..2b722f26224c 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>>            }
>>>>
>>>>            __folio_mod_stat(folio, nr, nr_pmdmapped);
>>>> +       mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>>>>     }
>>>>
>>>>     static __always_inline void __folio_add_file_rmap(struct folio *folio,
>>>> @@ -1582,6 +1583,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>>                list_empty(&folio->_deferred_list))
>>>>                    deferred_split_folio(folio);
>>>>            __folio_mod_stat(folio, -nr, -nr_pmdmapped);
>>>> +       if (folio_test_anon(folio) && !atomic_read(mapped))
>>>
>>> could have a risk here two processes unmap at the same time, so
>>> they both get zero on atomic_read(mapped)? should read the value
>>> of atomic_dec_return() instead to confirm we are the last one
>>> doing unmap?
>>
>> I would appreciate if we leave the rmap out here.
>>
>> Can't we handle that when actually freeing the folio? folio_test_anon()
>> is sticky until freed.
> 
> To be clearer: we increment the counter when we set a folio anon, which
> should indeed only happen in folio_add_new_anon_rmap(). We'll have to
> ignore hugetlb here where we do it in hugetlb_add_new_anon_rmap().
> 
> Then, when we free an anon folio we decrement the counter. (hugetlb
> should clear the anon flag when an anon folio gets freed back to its
> allocator -- likely that is already done).
> 

Sorry that I am talking to myself: I'm wondering if we also have to 
adjust the counter when splitting a large folio to multiple 
smaller-but-still-large folios.

-- 
Cheers,

David / dhildenb


