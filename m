Return-Path: <linux-kernel+bounces-225268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F1F912E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17912B27220
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42C3D388;
	Fri, 21 Jun 2024 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKCX/54O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDD16CD0A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000902; cv=none; b=R9mbqAaw1XdwzXTLZCts7EOXXeouv9aYNWC/FpDM8tKLyGryls7UW9/7hiPYgq833qnqSs6CZFprQ0wcvUQJDaNMO4ZuBYizhPU42W5DMUoZOekwu9dzk84a2TgP8bj1TnX9ddRWFAcfb4wz/9A1jia1BsdqREXO7/zklN0pgcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000902; c=relaxed/simple;
	bh=rMZSn8cUJo1yPVC/GqX+xcpEPkkZZT212ZSR0ppg1KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud4y9Rs9pv052w7Cb5Pu72yF+g7u4ip7MVtt5gDKI2Jxa+kweedDZ7JwFaOo4hp0T90/qnu/tyoxmtLqJ8vkuVutEGDLSdRPdFBzel4O6jJUn+3kI5zUxvZP/LdyBbeVh8DwVjeEt1Yo2ndD5Ht3rW0VqcMRIudoXz0snhZ1Le0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKCX/54O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719000898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t+zyp+sB3fwcRVLHHFDvGgh5lksSxCllhB7Q851QcgY=;
	b=QKCX/54OwAzRcHyrKA3rhRqtWiPPm7kC2r53cgDgjXxjhg+SltGjckTRr6uEr3yIuJEFV5
	knnpNnCUh0H/hfhkrxrOzWEe06tu+xliJQJmbOVDBiiKfzzNvGqFWvGA37SdaI985vwzNY
	K7eCfYeTkTxOhWwHmoY0UZzVye0SBeo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-5jELh2vHPoGAnTQhzF0PvQ-1; Fri, 21 Jun 2024 16:14:57 -0400
X-MC-Unique: 5jELh2vHPoGAnTQhzF0PvQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4229a964745so15695905e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719000896; x=1719605696;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t+zyp+sB3fwcRVLHHFDvGgh5lksSxCllhB7Q851QcgY=;
        b=MteWo0GEPOIBy+pJGeaQAe3yWo6kRSSGQDrzDJ+AnvGnibLe3FGuySp/U11HviRVpY
         bc6jZSHfE6XVysfxBVtodF23Kfip7Vk3g8Kq8YFpq5u4PETK13j5BJUZM360Wlz2IoBp
         gLhmHmyjy7KmXdHvzRFwqHIdP/lk2eBUhrPxjhipCsPsPBQn0HsqKcTNC23Eg5OTds2Y
         6mjZsuE7hMQNO+0rAGQLhhJY9rcLBWeQeP0sljgU83XSt74MjeO/NtU1Tq4MIyUVF+NN
         2HsLInfjuaMNjptZd8vn5ilxH6MaVv7m5k3TvhsXIIYG9i7EbbZNHqKJK2/uV4+wo+oG
         HmMw==
X-Forwarded-Encrypted: i=1; AJvYcCW7FhBQoFp5CSSbnl6qWaVAYnCFboRzmXano7vrfZromaV24fmdv0h4ZahAfJh7jCQldGH95p8gq5dJFzljtYZFjs6v5LnQJGM4X5m5
X-Gm-Message-State: AOJu0YxWgN6tI5t/Jn0w2QN19UcNj8DPkFOxZbIVnLHhkKHmbYZPys1u
	aPyIslGD6mG48qBehRIABzIracNAsl2r7xM/F877lyuAvhylimJ2h/Ra/D9RLk+QhASak192cZ5
	L0R69MjXnDxbJjQZJOf2UYQoBJVliaMhUjbOnk/ZBWCNFPY9HwJcrxwubQ3BC3A==
X-Received: by 2002:a05:600c:5107:b0:422:760c:e8b3 with SMTP id 5b1f17b1804b1-42475297483mr71501165e9.26.1719000896083;
        Fri, 21 Jun 2024 13:14:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjM55IDVL09mHfUnLTvWqN7dJdstJ2XFkyJ5HRO892gEN7GYpPs6WxTy59w50Zy5wB6/YBaw==
X-Received: by 2002:a05:600c:5107:b0:422:760c:e8b3 with SMTP id 5b1f17b1804b1-42475297483mr71501015e9.26.1719000895493;
        Fri, 21 Jun 2024 13:14:55 -0700 (PDT)
Received: from [192.168.3.141] (p4ff2358f.dip0.t-ipconnect.de. [79.242.53.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b634asm78893615e9.1.2024.06.21.13.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 13:14:55 -0700 (PDT)
Message-ID: <7a0999c5-e202-4da6-8e9c-f605dcc67243@redhat.com>
Date: Fri, 21 Jun 2024 22:14:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
To: Donet Tom <donettom@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
 <4474a212-7fc0-46b8-9f5b-bae878970b6b@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4474a212-7fc0-46b8-9f5b-bae878970b6b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.06.24 19:47, Donet Tom wrote:
> 
> On 6/21/24 02:59, David Hildenbrand wrote:
>> Currently we always take a folio reference even if migration will not
>> even be tried or isolation failed, requiring us to grab+drop an additional
>> reference.
>>
>> Further, we end up calling folio_likely_mapped_shared() while the folio
>> might have already been unmapped, because after we dropped the PTL, that
>> can easily happen. We want to stop touching mapcounts and friends from
>> such context, and only call folio_likely_mapped_shared() while the folio
>> is still mapped: mapcount information is pretty much stale and unreliable
>> otherwise.
>>
>> So let's move checks into numamigrate_isolate_folio(), rename that
>> function to migrate_misplaced_folio_prepare(), and call that function
>> from callsites where we call migrate_misplaced_folio(), but still with
>> the PTL held.
>>
>> We can now stop taking temporary folio references, and really only take
>> a reference if folio isolation succeeded. Doing the
>> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
>> to how we handle MADV_PAGEOUT.
>>
>> While at it, combine the folio_is_file_lru() checks.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    include/linux/migrate.h |  7 ++++
>>    mm/huge_memory.c        |  8 ++--
>>    mm/memory.c             |  9 +++--
>>    mm/migrate.c            | 81 +++++++++++++++++++----------------------
>>    4 files changed, 55 insertions(+), 50 deletions(-)
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index f9d92482d117..644be30b69c8 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -139,9 +139,16 @@ const struct movable_operations *page_movable_ops(struct page *page)
>>    }
>>    
>>    #ifdef CONFIG_NUMA_BALANCING
>> +int migrate_misplaced_folio_prepare(struct folio *folio,
>> +		struct vm_area_struct *vma, int node);
>>    int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>>    			   int node);
>>    #else
>> +static inline int migrate_misplaced_folio_prepare(struct folio *folio,
>> +		struct vm_area_struct *vma, int node)
>> +{
>> +	return -EAGAIN; /* can't migrate now */
>> +}
>>    static inline int migrate_misplaced_folio(struct folio *folio,
>>    					 struct vm_area_struct *vma, int node)
>>    {
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index fc27dabcd8e3..4b2817bb2c7d 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>    	if (node_is_toptier(nid))
>>    		last_cpupid = folio_last_cpupid(folio);
>>    	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>> -	if (target_nid == NUMA_NO_NODE) {
>> -		folio_put(folio);
>> +	if (target_nid == NUMA_NO_NODE)
>> +		goto out_map;
>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> +		flags |= TNF_MIGRATE_FAIL;
>>    		goto out_map;
>>    	}
>> -
>> +	/* The folio is isolated and isolation code holds a folio reference. */
>>    	spin_unlock(vmf->ptl);
>>    	writable = false;
>>    
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 118660de5bcc..4fd1ecfced4d 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5207,8 +5207,6 @@ int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>>    {
>>    	struct vm_area_struct *vma = vmf->vma;
>>    
>> -	folio_get(folio);
>> -
>>    	/* Record the current PID acceesing VMA */
>>    	vma_set_access_pid_bit(vma);
>>    
>> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>    	else
>>    		last_cpupid = folio_last_cpupid(folio);
>>    	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
>> -	if (target_nid == NUMA_NO_NODE) {
>> -		folio_put(folio);
>> +	if (target_nid == NUMA_NO_NODE)
>> +		goto out_map;
>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> +		flags |= TNF_MIGRATE_FAIL;
>>    		goto out_map;
>>    	}
>> +	/* The folio is isolated and isolation code holds a folio reference. */
>>    	pte_unmap_unlock(vmf->pte, vmf->ptl);
>>    	writable = false;
>>    	ignore_writable = true;
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 0307b54879a0..27f070f64f27 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2530,9 +2530,37 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
>>    	return __folio_alloc_node(gfp, order, nid);
>>    }
>>    
>> -static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
>> +/*
>> + * Prepare for calling migrate_misplaced_folio() by isolating the folio if
>> + * permitted. Must be called with the PTL still held.
>> + */
>> +int migrate_misplaced_folio_prepare(struct folio *folio,
>> +		struct vm_area_struct *vma, int node)
>>    {
>>    	int nr_pages = folio_nr_pages(folio);
>> +	pg_data_t *pgdat = NODE_DATA(node);
>> +
>> +	if (folio_is_file_lru(folio)) {
>> +		/*
>> +		 * Do not migrate file folios that are mapped in multiple
>> +		 * processes with execute permissions as they are probably
>> +		 * shared libraries.
>> +		 *
>> +		 * See folio_likely_mapped_shared() on possible imprecision
>> +		 * when we cannot easily detect if a folio is shared.
>> +		 */
>> +		if ((vma->vm_flags & VM_EXEC) &&
>> +		    folio_likely_mapped_shared(folio))
>> +			return -EACCES;
>> +
>> +		/*
>> +		 * Do not migrate dirty folios as not all filesystems can move
>> +		 * dirty folios in MIGRATE_ASYNC mode which is a waste of
>> +		 * cycles.
>> +		 */
>> +		if (folio_test_dirty(folio))
>> +			return -EAGAIN;
>> +	}
>>    
>>    	/* Avoid migrating to a node that is nearly full */
>>    	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
>> @@ -2550,65 +2578,37 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
>>    		 * further.
>>    		 */
>>    		if (z < 0)
>> -			return 0;
>> +			return -EAGAIN;
>>    
>>    		wakeup_kswapd(pgdat->node_zones + z, 0,
>>    			      folio_order(folio), ZONE_MOVABLE);
>> -		return 0;
>> +		return -EAGAIN;
>>    	}
>>    
>>    	if (!folio_isolate_lru(folio))
>> -		return 0;
>> +		return -EAGAIN;
>>    
>>    	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
>>    			    nr_pages);
>> -
>> -	/*
>> -	 * Isolating the folio has taken another reference, so the
>> -	 * caller's reference can be safely dropped without the folio
>> -	 * disappearing underneath us during migration.
>> -	 */
>> -	folio_put(folio);
>> -	return 1;
>> +	return 0;
>>    }
>>    
>>    /*
>>     * Attempt to migrate a misplaced folio to the specified destination
>> - * node. Caller is expected to have an elevated reference count on
>> - * the folio that will be dropped by this function before returning.
>> + * node. Caller is expected to have isolated the folio by calling
>> + * migrate_misplaced_folio_prepare(), which will result in an
>> + * elevated reference count on the folio. This function will un-isolate the
>> + * folio, dereferencing the folio before returning.
>>     */
>>    int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>>    			    int node)
>>    {
>>    	pg_data_t *pgdat = NODE_DATA(node);
>> -	int isolated;
>>    	int nr_remaining;
>>    	unsigned int nr_succeeded;
>>    	LIST_HEAD(migratepages);
>>    	int nr_pages = folio_nr_pages(folio);
>>    
>> -	/*
>> -	 * Don't migrate file folios that are mapped in multiple processes
>> -	 * with execute permissions as they are probably shared libraries.
>> -	 *
>> -	 * See folio_likely_mapped_shared() on possible imprecision when we
>> -	 * cannot easily detect if a folio is shared.
>> -	 */
>> -	if (folio_likely_mapped_shared(folio) && folio_is_file_lru(folio) &&
>> -	    (vma->vm_flags & VM_EXEC))
>> -		goto out;
>> -
>> -	/*
>> -	 * Also do not migrate dirty folios as not all filesystems can move
>> -	 * dirty folios in MIGRATE_ASYNC mode which is a waste of cycles.
>> -	 */
>> -	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
>> -		goto out;
>> -
>> -	isolated = numamigrate_isolate_folio(pgdat, folio);
>> -	if (!isolated)
>> -		goto out;
>> -
>>    	list_add(&folio->lru, &migratepages);
>>    	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
>>    				     NULL, node, MIGRATE_ASYNC,
>> @@ -2620,7 +2620,6 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>>    					folio_is_file_lru(folio), -nr_pages);
>>    			folio_putback_lru(folio);
>>    		}
>> -		isolated = 0;
>>    	}
>>    	if (nr_succeeded) {
>>    		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
>> @@ -2629,11 +2628,7 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>>    					    nr_succeeded);
>>    	}
>>    	BUG_ON(!list_empty(&migratepages));
>> -	return isolated ? 0 : -EAGAIN;
>> -
>> -out:
>> -	folio_put(folio);
>> -	return -EAGAIN;
>> +	return nr_remaining ? -EAGAIN : 0;
>>    }
>>    #endif /* CONFIG_NUMA_BALANCING */
>>    #endif /* CONFIG_NUMA */
> 
> Hi David,
> 
> I have tested these patches on my system. My system has 2 DRAM nodes and
> 1 PMEM node.
> I tested page migration between DRAM nodes and page promotion from PMEM
> to DRAM.
> Both are working fine.
> 
> below are the results.
> 
> Migration results
> =============
> numa_pte_updates 18977
> numa_huge_pte_updates 0
> numa_hint_faults 18504
> numa_hint_faults_local 2116
> numa_pages_migrated 16388
> 
> 
> 
> Promotion Results
> ===============
> nr_sec_page_table_pages 0
> nr_iommu_pages 0
> nr_swapcached 0
> pgpromote_success 16386
> pgpromote_candidate 0
> 
> 
> Tested-by: Donet Tom <donettom@linux.ibm.com>

Oh, what a pleasant surprise, thanks a bunch of the fast testing!

-- 
Cheers,

David / dhildenb


