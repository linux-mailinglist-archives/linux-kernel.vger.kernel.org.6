Return-Path: <linux-kernel+bounces-530095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BCAA42ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03F63A7EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614AD1D959B;
	Mon, 24 Feb 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3cm3Inz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F01C8601
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431878; cv=none; b=Q2ATgGHOkkQBA0Kszh4kad86+xK0zoaqrehAI4LxWevYDHdaZN8PtWt29NhOJpY6C5Xm0s1Qax9T3I14R1vSv2cwO5wmPyW33leWXsNee4KtBv+zkWPaIUoCCt7wOiPvHWHnAXFgeztkMtWhMrAygB7LY/OPW8jPmOCj5IMn9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431878; c=relaxed/simple;
	bh=GVIyCVAC1uYQBZ7YvMgFAfuCk2SCyHk+Rx5O1L7KI4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWqjDXOuvjdFd40OxLv/brMweL7UyrZXnVQSr5yrxJORUWulvR55ao9SAjbnUCvdHEPG/9CNWhlEkX3iY0emJo+56KJvCTYWEETsyJKuXxV7levlk9nZHzcWxmqrrNN3qzESzSZ7YOy1Dd3Wh/DhpavccNj1CyDZ6i2Z2yhkCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3cm3Inz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740431875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+pfaFYnZrGg4aP81g3fvxtKUOG+gZ00codvuI9HyJP4=;
	b=c3cm3Inzgsr8oTu1cCFtNOA68R1D/3SHPzuFwdHfHZCgBWWtNui9mUxmKnjmWWV4mIs8iI
	AxYKz7eQz23LUtuSQiYGMLlZuy380rnG71b8khHvbR3p4m2XRIu0DRfaV0kL7zZW1xAYwv
	P0j2Te0ZRrg/WbGmEp/W/Sx7+uWIWEI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-brgNnhP5Moa3tKAutC7OzQ-1; Mon, 24 Feb 2025 16:17:50 -0500
X-MC-Unique: brgNnhP5Moa3tKAutC7OzQ-1
X-Mimecast-MFC-AGG-ID: brgNnhP5Moa3tKAutC7OzQ_1740431869
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f3bac2944so2162992f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431869; x=1741036669;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+pfaFYnZrGg4aP81g3fvxtKUOG+gZ00codvuI9HyJP4=;
        b=Ml9Sx/rEaTK7Q4wKI91LIrdbXRAAO0H2oJDIZ1JlqJr4EUT2feC2GmYQz1ag1GjU7/
         0Fr2YJRjHK0TP5obTA5Ap0KcwfwPc5qI33YkzsUPQhz+RlGpMlFwRrDvOXVzc4lo4+rD
         jyaoLF67V8Xi5ZLmk6cPn2Tpb90J9MUDPJxQOEaBDeb2Y/ooBPTTaD+Zoc4/m7sgrnSg
         MXYbBQexRVx0mLB2Qrpr9aKqEuuIAKelrBpovHYi6+AoS+/vTmdCbFFW4wK7NW4/EEIz
         6mkHO0oNQO0C5bAwvn1ygi/ufiEy2clXQ49GFcWjkl4WB1UjsFHEMi6tsN+KJJ79jS3+
         Jv8A==
X-Forwarded-Encrypted: i=1; AJvYcCXOpmfg8s0Oai5FRiinnIRDCDoStAivUEVkgMuwTgOucUCRPQOWdWEjkt0ve+kWshKr+kIVk7vHsldy+nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXezDXAGVssvYnUpBhny0mTnPPj/NpMIPIaRxARdLEHMeUFjif
	KQ5PkumET6I/2f03hjrue7ec1g3Z7lP79bZrGGuFFZufyoIF2y6YEaLUMpm7USFXEhVKcEUm5Qa
	/XQC9j0TKu9H7FC3SFw3aSiJN5vt4WkAX72DxYxBgiQ1HauMlKLXsjvcsHvegQw==
X-Gm-Gg: ASbGncsLGXmBcYUehN8Bhb67K5NjTtdg/UCjSTH5L/QE6yTBIBzHNTZ7LIlNfci471Z
	eIQUPaM8PITtt0dCeTz579hMasK5otZcKwVU+aEGAgA5tZbcdDPx79iB+GeX6uPJTcjF7xhmJwC
	pe8/WEuGBu0LcQKFmESHa+Ihz1As+De21wCryyFgi7fCfV7iz2Sfy5uIwIBkds/XcsAfQrlTvX1
	cbIQ2Au0Q/+e7ehn2eAFPwmjIwhGxseO1MkekVn0HU+BPqGV9C+dSu7azV93/UEVyEvCIPKdqE7
	lgI1f7cq4D66Rx7tjOOACCQVul0h2z+jBy9dMwLz7pE9lH6RZnLYXWeK2bzOgArfUBlTsDkjBr1
	WgMmbo1BqNQWiXKJWts4TDpbafVOFrfj+yAJ7ZAr71BY=
X-Received: by 2002:a05:6000:186c:b0:38d:eaee:3b32 with SMTP id ffacd0b85a97d-38f6e977bb1mr11433797f8f.26.1740431868849;
        Mon, 24 Feb 2025 13:17:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG33QLU4MJ0xSM0Xmwfzw/OZoX0OLRfIElZNAkzclFnmmRRtf6dMGVpb0BdzzxB/d4Ljuls4Q==
X-Received: by 2002:a05:6000:186c:b0:38d:eaee:3b32 with SMTP id ffacd0b85a97d-38f6e977bb1mr11433771f8f.26.1740431868431;
        Mon, 24 Feb 2025 13:17:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cb08sm150988f8f.29.2025.02.24.13.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 13:17:48 -0800 (PST)
Message-ID: <cca2a98f-b6bc-44d6-a34d-c840f34dfd11@redhat.com>
Date: Mon, 24 Feb 2025 22:17:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] fs/proc/task_mmu: remove per-page mapcount
 dependency for smaps/smaps_rollup (CONFIG_NO_PAGE_MAPCOUNT)
To: Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-20-david@redhat.com>
 <D80Z3H6NZARU.1HP5EKXOJ68QH@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D80Z3H6NZARU.1HP5EKXOJ68QH@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 21:53, Zi Yan wrote:
> On Mon Feb 24, 2025 at 11:56 AM EST, David Hildenbrand wrote:
>> Let's implement an alternative when per-page mapcounts in large folios are
>> no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>>
>> When computing the output for smaps / smaps_rollups, in particular when
>> calculating the USS (Unique Set Size) and the PSS (Proportional Set Size),
>> we still rely on per-page mapcounts.
>>
>> To determine private vs. shared, we'll use folio_likely_mapped_shared(),
>> similar to how we handle PM_MMAP_EXCLUSIVE. Similarly, we might now
>> under-estimate the USS and count pages towards "shared" that are
>> actually "private" ("exclusively mapped").
>>
>> When calculating the PSS, we'll now also use the average per-page
>> mapcount for large folios: this can result in both, an over-estimation
>> and an under-estimation of the PSS. The difference is not expected to
>> matter much in practice, but we'll have to learn as we go.
>>
>> We can now provide folio_precise_page_mapcount() only with
>> CONFIG_PAGE_MAPCOUNT, and remove one of the last users of per-page
>> mapcounts when CONFIG_NO_PAGE_MAPCOUNT is enabled.
>>
>> Document the new behavior.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   Documentation/filesystems/proc.rst | 13 +++++++++++++
>>   fs/proc/internal.h                 |  8 ++++++++
>>   fs/proc/task_mmu.c                 | 17 +++++++++++++++--
>>   3 files changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>> index 1aa190017f796..57d55274a1f42 100644
>> --- a/Documentation/filesystems/proc.rst
>> +++ b/Documentation/filesystems/proc.rst
>> @@ -506,6 +506,19 @@ Note that even a page which is part of a MAP_SHARED mapping, but has only
>>   a single pte mapped, i.e.  is currently used by only one process, is accounted
>>   as private and not as shared.
>>   
>> +Note that in some kernel configurations, all pages part of a larger allocation
>> +(e.g., THP) might be considered "shared" if the large allocation is
>> +considered "shared": if not all pages are exclusive to the same process.
>> +Further, some kernel configurations might consider larger allocations "shared",
>> +if they were at one point considered "shared", even if they would now be
>> +considered "exclusive".
>> +
>> +Some kernel configurations do not track the precise number of times a page part
>> +of a larger allocation is mapped. In this case, when calculating the PSS, the
>> +average number of mappings per page in this larger allocation might be used
>> +as an approximation for the number of mappings of a page. The PSS calculation
>> +will be imprecise in this case.
>> +
>>   "Referenced" indicates the amount of memory currently marked as referenced or
>>   accessed.
>>   
>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>> index 16aa1fd260771..70205425a2daa 100644
>> --- a/fs/proc/internal.h
>> +++ b/fs/proc/internal.h
>> @@ -143,6 +143,7 @@ unsigned name_to_int(const struct qstr *qstr);
>>   /* Worst case buffer size needed for holding an integer. */
>>   #define PROC_NUMBUF 13
>>   
>> +#ifdef CONFIG_PAGE_MAPCOUNT
>>   /**
>>    * folio_precise_page_mapcount() - Number of mappings of this folio page.
>>    * @folio: The folio.
>> @@ -173,6 +174,13 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
>>   
>>   	return mapcount;
>>   }
>> +#else /* !CONFIG_PAGE_MAPCOUNT */
>> +static inline int folio_precise_page_mapcount(struct folio *folio,
>> +		struct page *page)
>> +{
>> +	BUILD_BUG();
>> +}
>> +#endif /* CONFIG_PAGE_MAPCOUNT */
>>   
>>   /**
>>    * folio_average_page_mapcount() - Average number of mappings per page in this
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index d7ee842367f0f..7ca0bc3bf417d 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -707,6 +707,8 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>   	struct folio *folio = page_folio(page);
>>   	int i, nr = compound ? compound_nr(page) : 1;
>>   	unsigned long size = nr * PAGE_SIZE;
>> +	bool exclusive;
>> +	int mapcount;
>>   
>>   	/*
>>   	 * First accumulate quantities that depend only on |size| and the type
>> @@ -747,18 +749,29 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>   				      dirty, locked, present);
>>   		return;
>>   	}
>> +
>> +	if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
>> +		mapcount = folio_average_page_mapcount(folio);
> 
> This seems inconsistent with how folio_average_page_mapcount() is used
> in patch 16 and 18.

It only looks that way. Note that the code below only does

>>   		if (mapcount >= 2)
>>   			pss /= mapcount;

Having it as 0 or 1 doesn't matter in that regard.

Thanks!

-- 
Cheers,

David / dhildenb


