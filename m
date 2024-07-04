Return-Path: <linux-kernel+bounces-241339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE5A9279EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE571C24BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116E31B1202;
	Thu,  4 Jul 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEa1c5Ou"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983D1AC252
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106618; cv=none; b=YlwQBzTAjbegG5UfYweHlhyRSapTuKljQc6tf/V+795x3vzSOJkx8erzs7aHQxuLPKWSpmPiscDKCED0QS01stPBZZTdaOHawg9MSVgLkWg4YLih2MbTeUIcxdY3GLooRNVjLih4s72FKRPNqHodZa8i8BexgojF+uHqd3BeM8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106618; c=relaxed/simple;
	bh=eFmVF0Fp3Y6Vy+GNUeRbkNyRQilUq7bFkpSNHKz7MBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9ZJqRA84DfYX4+OJkzC529l9pj8jQutPH+AHYoi2M25ixuBt52Afzqx3uLwZrb+Qz/PWPi3SSZh8KiLTZZ7q+o3bwHCIzHPdOx18A1Us1bmKnUMt827FcCxf+7Oq3bqLtkP/ZgQl5Lre555lqyEUxJIR7cO2bDeQiVlV2bK39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEa1c5Ou; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720106615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ciNpI4biZuLDpCsmTQeZWiRYi6l4tqxyig75r9C5Nhc=;
	b=VEa1c5OucsbrjqSZ6Ts23XZA6+OzWeq6bvigrQWxq8w7cr8R+374GwayyK3SvQJdm0nvOH
	rDqMXQKeA7iNMWn7rT1ElzIZVIL0MPSl3UzKYP7aVPwpgCMJCeOYFbC5vO/z04t4LkAFLS
	rh6htBwFxY7DpuRFjsg8y0eEnJFllX0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-bv5jkShAPgWV_pG15IZuOQ-1; Thu, 04 Jul 2024 11:23:33 -0400
X-MC-Unique: bv5jkShAPgWV_pG15IZuOQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee8e0dab26so7922641fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106612; x=1720711412;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ciNpI4biZuLDpCsmTQeZWiRYi6l4tqxyig75r9C5Nhc=;
        b=VVZRPGfCzYw6Ef++8TBOCVeXjlr7KsKawj4J8j2rsyKezqe2Df9KHpPPcnzSVnJvNy
         WytRY94S+4AcChJUK2hHJLBts9wd2VNIXg6TM2O7a0//+bGXYfB9gE4tDd6bQM7x6KmB
         yKOGAd6SUibzseKyThR0357tokhU1nqVz4BSukVUs5pF1ciVy86aQJMgcsIzF0yl1qCA
         9FG7OdbHPDelBSnlVo0deLczQKNz1Ipl2dan0WKn6WiNBxkEGgmtDL+uDUg7Kms8yVBj
         kRc9A4PXsjGtRhmBHtTUXVVo/PR15ABxC5Z4+QHWt/0pSjb1yQEy9WcP1qcIKsj1uT1U
         0sNg==
X-Forwarded-Encrypted: i=1; AJvYcCV1hCER0+DZ69GmSprnKffBPyh5k9uURzyNG2XCONHTbZsnvHsGieefLbffLEqLUIrC8IIpiAgGp5bh5R/zzHv9QBvwsLWgxoHHSzwW
X-Gm-Message-State: AOJu0YzwHUxhnXNNrS2d1CaGkEH+TruOHMhQPhGPPWGXIOIztn05i1Z6
	QObeJ4MVU1zrWivnmnQy8WmrJsRppRA3nfptRcoaZVyGtG4RiKazaCOmJQhx/73E8pga9eN60i1
	Q1reRraLdlSBm+KMdonxE6umdoNDRb1y1rHBAjN63TdfuFxhsEPSgpnTtfm/C+Q5IykO5vQ==
X-Received: by 2002:a2e:b1c4:0:b0:2ee:896d:2408 with SMTP id 38308e7fff4ca-2ee8ee001c6mr13627161fa.37.1720106612352;
        Thu, 04 Jul 2024 08:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ92AVhPvt7IGMw05PPOJd/errJXQT56kku3/y2KcQeSVDaRGnMAMRUnocazvAmAO3gqCcYQ==
X-Received: by 2002:a2e:b1c4:0:b0:2ee:896d:2408 with SMTP id 38308e7fff4ca-2ee8ee001c6mr13626971fa.37.1720106611896;
        Thu, 04 Jul 2024 08:23:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:8600:f05d:97b6:fb98:2bc1? (p200300cbc7158600f05d97b6fb982bc1.dip0.t-ipconnect.de. [2003:cb:c715:8600:f05d:97b6:fb98:2bc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a25b5edsm28247945e9.37.2024.07.04.08.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 08:23:31 -0700 (PDT)
Message-ID: <84d4e799-90da-487e-adba-6174096283b5@redhat.com>
Date: Thu, 4 Jul 2024 17:23:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
To: Peter Xu <peterx@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
 SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com> <Zoax9nwi5qmgTQR4@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zoax9nwi5qmgTQR4@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.24 16:30, Peter Xu wrote:
> Hey, David,
> 

Hi!

> On Thu, Jul 04, 2024 at 12:44:38PM +0200, David Hildenbrand wrote:
>> There are roughly two categories of page table walkers we have:
>>
>> 1) We actually only want to walk present folios (to be precise, page
>>     ranges of folios). We should look into moving away from the walk the
>>     page walker API where possible, and have something better that
>>     directly gives us the folio (page ranges). Any PTE batching would be
>>     done internally.
>>
>> 2) We want to deal with non-present folios as well (swp entries and all
>>     kinds of other stuff). We should maybe implement our custom page
>>     table walker and move away from walk_page_range(). We are not walking
>>     "pages" after all but everything else included :)
>>
>> Then, there is a subset of 1) where we only want to walk to a single address
>> (a single folio). I'm working on that right now to get rid of follow_page()
>> and some (IIRC 3: KSM an daemon) walk_page_range() users. Hugetlb will still
>> remain a bit special, but I'm afraid we cannot hide that completely.
> 
> Maybe you are talking about the generic concept of "page table walker", not
> walk_page_range() explicitly?
> 
> I'd agree if it's about the generic concept. For example, follow_page()
> definitely is tailored for getting the page/folio.  But just to mention
> Oscar's series is only working on the page_walk API itself.  What I see so
> far is most of the walk_page API users aren't described above - most of
> them do not fall into category 1) at all, if any. And they either need to
> fetch something from the pgtable where having the folio isn't enough, or
> modify the pgtable for different reasons.

Right, but having 1) does not imply that we won't be having access to 
the page table entry in an abstracted form, the folio is simply the 
primary source of information that these users care about. 2) is an 
extension of 1), but walking+exposing all (or most) other page table 
entries as well in some form, which is certainly harder to get right.

Taking a look at some examples:

* madvise_cold_or_pageout_pte_range() only cares about present folios.
* madvise_free_pte_range() only cares about present folios.
* break_ksm_ops() only cares about present folios.
* mlock_walk_ops() only cares about present folios.
* damon_mkold_ops() only cares about present folios.
* damon_young_ops() only cares about present folios.

There are certainly other page_walk API users that are more involved and 
need to do way more magic, which fall into category 2). In particular 
things like swapin_walk_ops(), hmm_walk_ops() and most 
fs/proc/task_mmu.c. Likely there are plenty of them.


Taking a look at vmscan.c/walk_mm(), I'm not sure how much benefit there 
even is left in using walk_page_range() :)

> 
> A generic pgtable walker looks still wanted at some point, but it can be
> too involved to be introduced together with this "remove hugetlb_entry"
> effort.

My thinking was if "remove hugetlb_entry" cannot wait for "remove 
page_walk", because we found a reasonable way to do it better and 
convert the individual users. Maybe it can't.

I've not given up hope that we can end up with something better and 
clearer than the current page_walk API :)

> 
> To me, that future work is not yet about "get the folio, ignore the
> pgtable", but about how to abstract different layers of pgtables, so the
> caller may get a generic concept of "one pgtable entry" with the level/size
> information attached, and process it at a single place / hook, and perhaps
> hopefully even work with a device pgtable, as long as it's a radix tree.

To me 2) is an extension of 1). My thinking is that we can start with 1) 
without having to are about all details of 2). If we have to make it as 
generic that we can walk any page table layout out there in this world, 
I'm not so sure.

-- 
Cheers,

David / dhildenb


