Return-Path: <linux-kernel+bounces-279064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E2394B87F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01452866CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B839188CDB;
	Thu,  8 Aug 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSyNaMMb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066413CA8A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104246; cv=none; b=a0I04WT4Wu+NRn2osDwnLk/5HGyPmCGIVpeUdOvqA52NGZmSEMV4pEFk/AtBbWVOmGMb2fG14peYkiF/4KJLVU92GHI0gTNRwMPYt/ahDEDHBb9jncbKvbAR0Y5tCFxHIjkLKuEABNRE5Hk+VNdPhVjkYeST3600IWYnWI85ddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104246; c=relaxed/simple;
	bh=t813CkLd8LZI8WxJoXYI53iXplLA7F3pteQJuXHznnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBSbaPEvoEueC4oSFIXgHBX7pPedHQtsDWQjTtaVj+EUbT8L6WWqbVyiezIO00T3Amgm8Y5C3WGrSASDnDEp4HouU37TYkxg1SHQ6By4MNzvmZeGtOgfywJqGtBYbTT7Ji84UOeW3a0cczFqz/147UtgaAxC+ZXoi+ehdt/RD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSyNaMMb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723104243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WXWgWTAA3ZTWNnnnPEpI6veUckpswaf1XFwku77tnKo=;
	b=HSyNaMMbmhA4MlLfoLf8uNC4pj16k1x0f3A9IjozR70lGtz+Ukxw2hetcJZeWaKW/ckPX6
	7ivbkJGQR6lOokTPHFBTgeEawrwRKMhf/zmYoky1TqMr8eDTFto5TvSUCpc14xD0yjtIZv
	0bkzY8A2oCEQuiq/fC1qLJTayLIPDFk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-C-iW9DEHNUeP_bfVLoyjsw-1; Thu, 08 Aug 2024 04:04:01 -0400
X-MC-Unique: C-iW9DEHNUeP_bfVLoyjsw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428076fef5dso4744625e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 01:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723104240; x=1723709040;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WXWgWTAA3ZTWNnnnPEpI6veUckpswaf1XFwku77tnKo=;
        b=nCbu845n29s0q2Yto7kICUkC9S4OTNqZ0x46OtUVkkD/3FLcg3AtW+V5ANiuo90wiW
         h3/0Zk5B2kSWoQT9FonK1RfSiIyA9uhl2ZD7fj4y/W2iui5rdj9rUGt4l6LHOZUHUaPO
         bRHNPYz19+1HfkWH+nSSKvzBpX8kXElmX10ypHyvhozMujiNdX7hk3bSKTMjRNrP0v8m
         G7H82BaJY/tA+f5tDzt0giHBEornUI8qg97qNBMaUOoVwns6hL8CMEaq3rRCwAJpXNkP
         93oR8ddwe08vuvj2EBGOON5Gbv4nsPMN7QPAw2cMpsJQs/r+xvSDn8wgesMNoDJf+k1m
         5N7w==
X-Forwarded-Encrypted: i=1; AJvYcCWQql9SpYLi9QUGHtiOlaUkhOLLS25iS6sjacYy36BAW++nY87NWfieIM+4UlXg4NFSKV3IoZIbBrPyo+RQUeUugSIP+MBJZQs4NTuw
X-Gm-Message-State: AOJu0Yy2LQUIsOMN9/7GpCeHDRFxwaVm81wOPtc3ZhVmhn+vaSPs99XO
	rpH334kjaGqE2RcFvD9M/3WS2ezVDZpUww+aiQzoRr0/tv9ASHxbHMhFl7KyGxvNvZrK8530mL+
	dQ0WyksQIFPnaOVs101YFjyAWyYo9RXE/5bALo1KVzyyC0+llgdeLlogP374zRw==
X-Received: by 2002:a05:600c:c87:b0:426:593c:935f with SMTP id 5b1f17b1804b1-4290aee03e6mr7430265e9.1.1723104240252;
        Thu, 08 Aug 2024 01:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJVQuhZjJ/h1x8buoYmyxYhhOPFnmkrVCewbZeZQ3wJhGgNQFrp05xaiwy9WyiQ6D7j8Flnw==
X-Received: by 2002:a05:600c:c87:b0:426:593c:935f with SMTP id 5b1f17b1804b1-4290aee03e6mr7429975e9.1.1723104239755;
        Thu, 08 Aug 2024 01:03:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72d551sm9595525e9.2.2024.08.08.01.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 01:03:59 -0700 (PDT)
Message-ID: <b17133e5-4f25-47d5-b6db-412ae96db8c3@redhat.com>
Date: Thu, 8 Aug 2024 10:03:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
 chrisl@kernel.org, hanchuanhua@oppo.com, ioworker0@gmail.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 ziy@nvidia.com
References: <20240808010457.228753-2-21cnbao@gmail.com>
 <20240808070847.285075-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240808070847.285075-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.08.24 09:08, Barry Song wrote:
> On Thu, Aug 8, 2024 at 1:05 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> When a new anonymous mTHP is added to the rmap, we increase the count.
>> We reduce the count whenever an mTHP is completely unmapped.
>>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>   Documentation/admin-guide/mm/transhuge.rst |  5 +++++
>>   include/linux/huge_mm.h                    | 15 +++++++++++++--
>>   mm/huge_memory.c                           |  2 ++
>>   mm/rmap.c                                  |  3 +++
>>   4 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index 058485daf186..715f181543f6 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -527,6 +527,11 @@ split_deferred
>>           it would free up some memory. Pages on split queue are going to
>>           be split under memory pressure, if splitting is possible.
>>
>> +anon_num
>> +       the number of anon huge pages we have in the whole system.
>> +       These huge pages could be still entirely mapped and have partially
>> +       unmapped and unused subpages.
>> +
>>   As the system ages, allocating huge pages may be expensive as the
>>   system uses memory compaction to copy data around memory to free a
>>   huge page for use. There are some counters in ``/proc/vmstat`` to help
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index e25d9ebfdf89..294c348fe3cc 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -281,6 +281,7 @@ enum mthp_stat_item {
>>          MTHP_STAT_SPLIT,
>>          MTHP_STAT_SPLIT_FAILED,
>>          MTHP_STAT_SPLIT_DEFERRED,
>> +       MTHP_STAT_NR_ANON,
>>          __MTHP_STAT_COUNT
>>   };
>>
>> @@ -291,14 +292,24 @@ struct mthp_stat {
>>   #ifdef CONFIG_SYSFS
>>   DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
>>
>> -static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
>>   {
>>          if (order <= 0 || order > PMD_ORDER)
>>                  return;
>>
>> -       this_cpu_inc(mthp_stats.stats[order][item]);
>> +       this_cpu_add(mthp_stats.stats[order][item], delta);
>> +}
>> +
>> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>> +{
>> +       mod_mthp_stat(order, item, 1);
>>   }
>> +
>>   #else
>> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
>> +{
>> +}
>> +
>>   static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>>   {
>>   }
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 697fcf89f975..b6bc2a3791e3 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -578,6 +578,7 @@ DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
>>   DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>>   DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>>   DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>> +DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);
>>
>>   static struct attribute *stats_attrs[] = {
>>          &anon_fault_alloc_attr.attr,
>> @@ -591,6 +592,7 @@ static struct attribute *stats_attrs[] = {
>>          &split_attr.attr,
>>          &split_failed_attr.attr,
>>          &split_deferred_attr.attr,
>> +       &anon_num_attr.attr,
>>          NULL,
>>   };
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 901950200957..2b722f26224c 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>          }
>>
>>          __folio_mod_stat(folio, nr, nr_pmdmapped);
>> +       mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>>   }
>>
>>   static __always_inline void __folio_add_file_rmap(struct folio *folio,
>> @@ -1582,6 +1583,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>              list_empty(&folio->_deferred_list))
>>                  deferred_split_folio(folio);
>>          __folio_mod_stat(folio, -nr, -nr_pmdmapped);
>> +       if (folio_test_anon(folio) && !atomic_read(mapped))
> 
> could have a risk here two processes unmap at the same time, so
> they both get zero on atomic_read(mapped)? should read the value
> of atomic_dec_return() instead to confirm we are the last one
> doing unmap?

I would appreciate if we leave the rmap out here.

Can't we handle that when actually freeing the folio? folio_test_anon() 
is sticky until freed.

-- 
Cheers,

David / dhildenb


