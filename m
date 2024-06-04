Return-Path: <linux-kernel+bounces-200621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F918FB27B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850EF1F25FFD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E54146010;
	Tue,  4 Jun 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUkxx1rS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C644144D1E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505040; cv=none; b=QptZKKWlolwKW4DIqaDWHjwsNxw2PjaqHMeILOsDPGEZ5GO7PW/HXzEjS7dq8HQuy11qlryHKjnA0vmVVLZiH2P4jH+r+mUfUtJZxOJo7zVfK8WXpcjklhFnG3hrA+ujLA2xxUXC8csdxT7jROvPl+vakSX4SuxjY0NDblIYinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505040; c=relaxed/simple;
	bh=lS6YuUMmLtcwBksv5K6E8cLhLtBCWtRmxX8rHhWTd0s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mODVKF3nwdWKdcVAzKgGJD90sLALYn9q0vg9F66yDE8Np6Nx1IAHMmTxXO8Rz1Ht4t6xSmfeqUXVqsxCsfSGcUh3yIvfooYGyKNcUMCAMafZq9PErvqtQqWs1Mgr80+4MsP3dlvqt/pPYq6PbmS+sWThgpYGaZYw1nr+MRkfuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUkxx1rS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717505037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EhCfiVXPEvR/+5TViwRD3SJ00fC3/I6EnddHHFID5P0=;
	b=IUkxx1rSFR5lO9y3vr2k0WdRrS7zmMZNRsS6k5eQ3ILmJgSehSbhJ0Ylgq3j1ASsgV+UOe
	54ZoTYAv4JlY3+syT/hqGey9wseNX9NnCaoS0obI4abqKY7crMEOD3tRSRYty17uNHe8R6
	4qkEOOCsjqPAsKL9/68uwLHQpWodFSo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-UUFHEERiOCeY1VVD0ciUDQ-1; Tue, 04 Jun 2024 08:43:53 -0400
X-MC-Unique: UUFHEERiOCeY1VVD0ciUDQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42133728a50so32174265e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505032; x=1718109832;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EhCfiVXPEvR/+5TViwRD3SJ00fC3/I6EnddHHFID5P0=;
        b=RpkD7TyLKzMBx3tkzzA2i7v6RhCSZiECJbaISIm5WyfxN51B9Uc9dzAtmPIOhfL41i
         DyKNFatiG0ns5wLOqWAKzkrky87f6LclOTamZirp/syQ1Y9NUoZG6RepAhh7sPWmkzzf
         Nkfczqhm191ghielSWBmdrLq19jVqPdCRCkrH/pWqjh0F1J5xPatIDuXLXD9Vx9k+HbB
         dIT6kxf8qvNoL7zNFr+iMraBrrHc8N72wEZVFJgbBYPGuq/VUc+OnbOQWtA/WnYV/OT4
         G74YKx33lF4VoOaauGfTH/3kqg3Ws//0mwwprPhQHWSpSB3b31kEUYDCFcmxdvZ1FmYn
         pZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVduZ1V46H2xXOXxhajHGWc4bbhq4NbH+uhXDGfQ5A6vXpgXnb6lqUXHhJXZPJBv9n7Tf4k/DnJDPqVw5XDbhzQOVc7NMiYGgFc3U3
X-Gm-Message-State: AOJu0YwcecBtYJlSGHJ2vRFC3fZZNgSEObKK3/wKfLK9XkIRhNzFtOZ8
	Z+z7OfMJw7xZTKp9SEFHNdtHvjglIecD9xpGjhu9nbOPUw7PJthsKWphT33UejN5H/hTOEZqXu4
	ELPw23jpcczruYM+v3lVtsBuE3xIZPLt6xCZP/wcwP4RNuTwiYa27lQsManQfww==
X-Received: by 2002:a05:600c:365a:b0:421:2dae:24c4 with SMTP id 5b1f17b1804b1-4212e0a5317mr123938365e9.25.1717505032642;
        Tue, 04 Jun 2024 05:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbbe2T2u/1oVTqF789zLlbtQnA88Sd8d4fqMqY61SSsc/ot/w/Vh5KT0KCHSFvcCQ7fbC6Cg==
X-Received: by 2002:a05:600c:365a:b0:421:2dae:24c4 with SMTP id 5b1f17b1804b1-4212e0a5317mr123938075e9.25.1717505032159;
        Tue, 04 Jun 2024 05:43:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212f9b9ef1sm142213095e9.9.2024.06.04.05.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:43:51 -0700 (PDT)
Message-ID: <f26a6ac2-48a9-4bae-89b9-a3f9b97ae9dc@redhat.com>
Date: Tue, 4 Jun 2024 14:43:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: clear pte for folios that are zero filled
From: David Hildenbrand <david@redhat.com>
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, willy@infradead.org, yosryahmed@google.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240604105950.1134192-1-usamaarif642@gmail.com>
 <20240604105950.1134192-2-usamaarif642@gmail.com>
 <6b1485b6-c2a1-45b8-8afe-7b211689070b@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6b1485b6-c2a1-45b8-8afe-7b211689070b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 14:30, David Hildenbrand wrote:
> On 04.06.24 12:58, Usama Arif wrote:
>> Approximately 10-20% of pages to be swapped out are zero pages [1].
>> Rather than reading/writing these pages to flash resulting
>> in increased I/O and flash wear, the pte can be cleared for those
>> addresses at unmap time while shrinking folio list. When this
>> causes a page fault, do_pte_missing will take care of this page.
>> With this patch, NVMe writes in Meta server fleet decreased
>> by almost 10% with conventional swap setup (zswap disabled).
>>
>> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>    include/linux/rmap.h |   1 +
>>    mm/rmap.c            | 163 ++++++++++++++++++++++---------------------
>>    mm/vmscan.c          |  89 ++++++++++++++++-------
>>    3 files changed, 150 insertions(+), 103 deletions(-)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index bb53e5920b88..b36db1e886e4 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -100,6 +100,7 @@ enum ttu_flags {
>>    					 * do a final flush if necessary */
>>    	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
>>    					 * caller holds it */
>> +	TTU_ZERO_FOLIO		= 0x100,/* zero folio */
>>    };
>>    
>>    #ifdef CONFIG_MMU
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 52357d79917c..d98f70876327 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1819,96 +1819,101 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>    			 */
>>    			dec_mm_counter(mm, mm_counter(folio));
>>    		} else if (folio_test_anon(folio)) {
>> -			swp_entry_t entry = page_swap_entry(subpage);
>> -			pte_t swp_pte;
>> -			/*
>> -			 * Store the swap location in the pte.
>> -			 * See handle_pte_fault() ...
>> -			 */
>> -			if (unlikely(folio_test_swapbacked(folio) !=
>> -					folio_test_swapcache(folio))) {
>> +			if (flags & TTU_ZERO_FOLIO) {
>> +				pte_clear(mm, address, pvmw.pte);
>> +				dec_mm_counter(mm, MM_ANONPAGES);
> 
> Is there an easy way to reduce the code churn and highlight the added code?
> 
> Like
> 
> } else if (folio_test_anon(folio) && (flags & TTU_ZERO_FOLIO)) {
> 
> } else if (folio_test_anon(folio)) {
> 
> 
> 
> Also to concerns that I want to spell out:
> 
> (a) what stops the page from getting modified in the meantime? The CPU
>       can write it until the TLB was flushed.
> 
> (b) do you properly handle if the page is pinned (or just got pinned)
>       and we must not discard it?

Oh, and I forgot, are you handling userfaultd as expected? IIRC there 
are some really nasty side-effects with userfaultfd even when 
userfaultfd is currently not registered for a VMA [1].

[1] 
https://lore.kernel.org/linux-mm/3a4b1027-df6e-31b8-b0de-ff202828228d@redhat.com/

What should work is replacing all-zero anonymous pages by the shared 
zeropage iff the anonymous page is not pinned and we synchronize against 
GUP fast. Well, and we handle possible concurrent writes accordingly.

KSM does essentially that when told to de-duplicate the shared zeropage, 
and I was thinking a while ago if we would want a zeropage-only KSM 
version that doesn't need stable tress and all that, but only 
deduplicates zero-filled pages into the shared zeropage in a safe way.

-- 
Cheers,

David / dhildenb


