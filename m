Return-Path: <linux-kernel+bounces-273909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195EA946F78
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42872816E6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE4959147;
	Sun,  4 Aug 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9bqMHcK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990CA934
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722783974; cv=none; b=rk5u6KdeckWIb6bvrgL8znq3mkJihI00K2JeZ6++VEiSfIo86iGMctUpXDjaRRttX2ePlnRZpA7XFH7utDZZwtV5tCrBJktWSmS+Ud+pz6rzyC6FJ/8ogPYpDt6oSLYxCyeBLhgs4Kq5/SKdyoNfVenQ8kWyx88y8L3gzH2abE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722783974; c=relaxed/simple;
	bh=BdhIlGwADfl7fNRHvU4/c2Josu1FQUkZqG9Bf9FedAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vjr7cH2fVxHJ3nSo+QBUnP3i7CpnCiZSvmFo2UDOPV9QSzZMABRsA8/s0Dhga6nIR5mFYm+Ij5JiLcZ6GshbXk9Em/lUgk2LV8q3UxUbhGdHvoa12HVJM7f5L3CPhhq4SXu4APoZ6ssO5pxRiXWm5F1IbKtZxkq4PUhzomQFWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9bqMHcK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722783971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SvbvcFjU58ktq+KRI5iYfFYfuh6LM7bmOviBHt03oLI=;
	b=Q9bqMHcKQ3vGFx4oo0ujLHiRdYIOGlyLmr4NbSFznzuupBzaSInM70xwWxWDxEE9wSnzmd
	MD7bxuZj+offm4sJSpsg9Kt1PmwhZVegZxa6WfdDl2LItJJ1vasIB4EBScol9lK+T5GKKe
	1D1Qyq6JHOqvpFFs36nKEJggZXKUlgM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-CbdNhNWhNp-PQDjoxBUR_Q-1; Sun, 04 Aug 2024 11:06:10 -0400
X-MC-Unique: CbdNhNWhNp-PQDjoxBUR_Q-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b7b1d79bacso22267736d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 08:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722783969; x=1723388769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvbvcFjU58ktq+KRI5iYfFYfuh6LM7bmOviBHt03oLI=;
        b=qZ9uxp6FGEwSw+Z5lNs1Pwo3PS4Gtw6uOIdtCu1elgX69DAtHcNSQfdgp7hkqXltAK
         0UDNSyn6ENi16QtjXPmBGRv4vD6uUUPAiUB7KnmlXiGw3GyxXBzkRPGzQyd81455IQ0X
         5L6KaXOR0Ri0FE9g9UeH5hr7vN/rY2LkHg3kdGGcFQ4JypZwj6Yt+eNVI+aLIeyaxZTn
         kWTg7SEvvguwvjzDHICjdlx6z0oRUzk+Zr7jeW0KK3+eTdJGBiRoMq3swdD+7tC7UrLo
         WtU+NR4rZ2OvKpL+WIoxBOuJSrImkgEUOLlYf7h3GliXE4ribHNnN9Sj3ioecofRdqjA
         LMhg==
X-Forwarded-Encrypted: i=1; AJvYcCWZYAtqHycZn9zt2PlN9/LZrLre19haxI7Xrc+b58shXZL+XR8ZCa/F3vhQ7xW0TpE8xXidLsDGIxkQEDjcLycWnxPpQS+pIbhnZRTj
X-Gm-Message-State: AOJu0YyVVLS++UTat14xGKtpmBIApkm3NjOFk0AczGCD9kUI/ZFFpWbD
	rP3fBzZss3JkaQAT970WeFdCwlzRkeV73c6v9uMmsx86xxavb+Qi3ISVJ6NvpYxO70NE0pJJoO+
	Jz1cSfrtO/kEz08OXiAG0YXPsGaZYkL+22vnqlbYADTCQU3YO2Ol1RHgVcUVAXw==
X-Received: by 2002:ad4:4ee1:0:b0:6b7:b2fb:7dcd with SMTP id 6a1803df08f44-6bb98408bc3mr68328506d6.8.1722783969507;
        Sun, 04 Aug 2024 08:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAHSZ75g6qzRAE6XgtCfAsaJachILokCvd/ttfnqNGQLClyVvD5fN6U4DiFXAwrTwReCdoYA==
X-Received: by 2002:ad4:4ee1:0:b0:6b7:b2fb:7dcd with SMTP id 6a1803df08f44-6bb98408bc3mr68328306d6.8.1722783969070;
        Sun, 04 Aug 2024 08:06:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c797741sm26466216d6.44.2024.08.04.08.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 08:06:08 -0700 (PDT)
Date: Sun, 4 Aug 2024 11:06:06 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>, Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>, x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@redhat.com>,
	Alex Thorlton <athorlton@sgi.com>
Subject: Re: [PATCH v3 2/8] mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES
Message-ID: <Zq-Y3qs5_PZW04bt@x1n>
References: <20240715192142.3241557-1-peterx@redhat.com>
 <20240715192142.3241557-3-peterx@redhat.com>
 <added2d0-b8be-4108-82ca-1367a388d0b1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <added2d0-b8be-4108-82ca-1367a388d0b1@redhat.com>

On Wed, Jul 31, 2024 at 02:18:26PM +0200, David Hildenbrand wrote:
> On 15.07.24 21:21, Peter Xu wrote:
> > In 2013, commit 72403b4a0fbd ("mm: numa: return the number of base pages
> > altered by protection changes") introduced "numa_huge_pte_updates" vmstat
> > entry, trying to capture how many huge ptes (in reality, PMD thps at that
> > time) are marked by NUMA balancing.
> > 
> > This patch proposes to remove it for some reasons.
> > 
> > Firstly, the name is misleading. We can have more than one way to have a
> > "huge pte" at least nowadays, and that's also the major goal of this patch,
> > where it paves way for PUD handling in change protection code paths.
> > 
> > PUDs are coming not only for dax (which has already came and yet broken..),
> > but also for pfnmaps and hugetlb pages.  The name will simply stop making
> > sense when PUD will start to be involved in mprotect() world.
> > 
> > It'll also make it not reasonable either if we boost the counter for both
> > pmd/puds.  In short, current accounting won't be right when PUD comes, so
> > the scheme was only suitable at that point in time where PUD wasn't even
> > possible.
> > 
> > Secondly, the accounting was simply not right from the start as long as it
> > was also affected by other call sites besides NUMA.  mprotect() is one,
> > while userfaultfd-wp also leverages change protection path to modify
> > pgtables.  If it wants to do right it needs to check the caller but it
> > never did; at least mprotect() should be there even in 2013.
> > 
> > It gives me the impression that nobody is seriously using this field, and
> > it's also impossible to be serious.
> 
> It's weird and the implementation is ugly. The intention really was to only
> consider MM_CP_PROT_NUMA, but that apparently is not the case.
> 
> hugetlb/mprotect/... should have never been accounted.
> 
> [...]
> 
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 73d791d1caad..53656227f70d 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1313,7 +1313,6 @@ const char * const vmstat_text[] = {
> >   #ifdef CONFIG_NUMA_BALANCING
> >   	"numa_pte_updates",
> > -	"numa_huge_pte_updates",
> >   	"numa_hint_faults",
> >   	"numa_hint_faults_local",
> >   	"numa_pages_migrated",
> 
> It's a user-visible update. I assume most tools should be prepared for this
> stat missing (just like handling !CONFIG_NUMA_BALANCING).
> 
> Apparently it's documented [1][2] for some distros:

Yes, and AFAIU, [2] is a document to explain an issue relevant to numa
balancing, and I'd highly doubt [2] referenced [1] here; even the order of
the parameters are the same to be listed.

> 
> "The amount of transparent huge pages that were marked for NUMA hinting
> faults. In combination with numa_pte_updates the total address space that
> was marked can be calculated."
> 
> And now I realize that change_prot_numa() would account these PMD updates as
> well in numa_pte_updates and I am confused about the SUSE documentation: "In
> combination with numa_pte_updates" doesn't really apply, right?
> 
> At this point I don't know what's right or wrong.

Me neither, even without PUD involvement.

Talking about numa_pte_updates, hugetlb_change_protection() returns "number
of huge ptes", so one 2M hugetlb page is accounted once; while comparing to
the generic THP (change_protection_range()) it's HPAGE_PUD_NR.  It'll make
more sense to me if it sticks with PAGE_SIZE.  So all these counters look a
bit confusing.

> 
> If we'd want to fix it instead, the right thing to do would be doing the
> accounting only with MM_CP_PROT_NUMA. But then, numa_pte_updates is also
> wrongly updated I believe :(

Right.

I don't have a reason to change numa_pte_updates semantics yet so far, but
here there's the problem where numa_huge_pte_updates can be ambiguous when
there is even PUD involved.

In general, I don't know how I should treat this counter in PUD path even
if NUMA isn't involved in dax yet; it can be soon involved if we move on
with using this same path for hugetlb, or when 1G thp can be possible (with
Yu Zhao's TAO?).

One other thing I can do is I drop this patch, ignore NUMA_HUGE_PTE_UPDATES
in PUD dax processing for now.  It'll work for this series, but it'll still
be a problem later.  I figured maybe we should simply drop it from now.

Thanks,

> 
> 
> [1] https://documentation.suse.com/de-de/sles/12-SP5/html/SLES-all/cha-tuning-numactl.html
> [2] https://support.oracle.com/knowledge/Oracle%20Linux%20and%20Virtualization/2749259_1.html
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Peter Xu


