Return-Path: <linux-kernel+bounces-383481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CFA9B1C58
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 08:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA5BBB2138E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 07:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5C53BBC5;
	Sun, 27 Oct 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yVsLxzSv"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E2BF9E6
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730012841; cv=none; b=U9IzAo9SG7QtSArKpWAKgYEepmygPNd2iMnviGO/iwrVnvxdyhPs8xZCNAdlYhrJPgJErDe8ssVJnKZMOjc1Gf52AK6PYr2izUAspB2a9XUYdWYYsjwdAGk0yWanTSujEv4dOnmaujoNomJECBzyfumy4eEv4aLCRfK7YcxLEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730012841; c=relaxed/simple;
	bh=uva9FIkQ2TMI2QwDwhR/o+ZHNtNcoerut7QeZjoI4lE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jQYFe+0ZOVUxMHZgmy5IyR6DyTouT1DaD0tcaqm2UvfJYIQMrM3Zxb3knTI4eFv0my34yArzevDbi08hKzLjG0lHjtasLtjsSN49vaOq2prFdnAGKInTSPU/qCCJyruZ/ILGgpLGYcWkqApV6/TdE1RKXAr71pssm50d0fZ14Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yVsLxzSv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c693b68f5so33984045ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730012837; x=1730617637; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=535OYr/jfByeF7vb/lMoiQddbcFE/G2VH6IgzW9mzWc=;
        b=yVsLxzSvC9t5FvTD+XupG9IpJLSKLlCVQ8LrZfzEBZPYB5aEKTj7spXJCWcfY437wU
         6lhgvpCngAgv9vUKBGUfzFc7zvqL3oNdPakKqocw+gWQfVbx4KwcBuw0ijusNa3ZNbyS
         9HQ+r510aW4hwqkix6z7l/dKiArKGLC/8DJ6Fe59U0QuobkXUWdP41WGiQITlJmIlWhL
         KwtX/vKIvm8aEmc0oRq9tCgd76CogoWKj8SAQVSBhHLFN9raUx2/OvbMWJWefOljC5fJ
         KgB7fcZtb6hMKPgBPEVXiWg2mCubsjqyRfV/p5yRKQ2l/ewGjDgx5q18neSBfEH780kY
         Tg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730012837; x=1730617637;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=535OYr/jfByeF7vb/lMoiQddbcFE/G2VH6IgzW9mzWc=;
        b=wfIGaw3psxnjUZXZ9Gojb1lfAxKTuOMM+YHZHOf+XaGHqdcvU0LLqfm0sRhwQUsT45
         vvJfgidlFgfR68stvlqSVjTQOj4Os+OuXCXfbBW5zIk+WrLB2dXRxyLeG+u5AdR393Pr
         lZCjKu+HfSmXkgrat1jUrv/x0LBKkYXwR3P/FrljTReJe8ROGjXOCKYlW+pfaAUJsWbX
         HrMUClT9Mzi5RA+X1GZheh0GayYSMUAIFC6DN+HVDwyqh83gcyaBMZ3tzEclxZR7QO1s
         vn4HpJ6W75ntWHBEagb8LYVl+XLayAvBNllDHT7Wdh/eiI0b5glLn+xWemXKAOAPikRt
         TGUw==
X-Forwarded-Encrypted: i=1; AJvYcCXoTGGYV13TtlzBhjmZeoHy6dBdzZj2y9wuZeUW2TjHWljjTML4eGgNmd/+qi7t0A3+9+GSWtQSrp3aGkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZLnehn5MOcB0fqGG2Wm3Jgfz3x9YbeMokYQmncVXucrTjFz8
	nMV5zca7cZmtyXQ+QmWE+sQ9XYI/sm9thM/+DUlqdxjT3QTWCN/5Yyn0+0n91w==
X-Google-Smtp-Source: AGHT+IGp5PwV0sZMbauMxRAnVyP54+XoSNxzgw9sbiX0/XSDbvqYOBUw+X4L/CR3bX48lMn9XXrgpw==
X-Received: by 2002:a17:902:f686:b0:20b:8ef3:67a with SMTP id d9443c01a7336-210c68744a1mr73244095ad.7.1730012836834;
        Sun, 27 Oct 2024 00:07:16 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf72006sm32151825ad.108.2024.10.27.00.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 00:07:16 -0700 (PDT)
Date: Sun, 27 Oct 2024 00:07:14 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>, 
    Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix 2/2] mm/thp: fix deferred split unqueue naming
 and locking
In-Reply-To: <a5a37ff4-3017-4950-b625-d82871139ebc@redhat.com>
Message-ID: <3f4fc787-c1d4-4d29-355e-d5ae0737e55c@google.com>
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com> <7dc6b280-cd87-acd1-1124-e512e3d2217d@google.com> <a5a37ff4-3017-4950-b625-d82871139ebc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Oct 2024, David Hildenbrand wrote:
> On 24.10.24 06:13, Hugh Dickins wrote:
> > Recent changes are putting more pressure on THP deferred split queues:
> > under load revealing long-standing races, causing list_del corruptions,
> > "Bad page state"s and worse (I keep BUGs in both of those, so usually
> > don't get to see how badly they end up without).  The relevant recent
> > changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
> > improved swap allocation, and underused THP splitting.
> > 
> > Before fixing locking: rename misleading folio_undo_large_rmappable(),
> > which does not undo large_rmappable, to folio_unqueue_deferred_split(),
> > which is what it does.  
> 
> Yes please. I stumbled into that myself recently -- leftover from previous
> rework.
> 
> It would have been reasonable to move that into a separate (follow-up?) patch.

I was expecting someone to ask for a breakup: I plead, as the one who
will try some backports, to keep this all in one to make that job easier.

I doubt I'll go back further than 6.6 LTS.  Porting this patch is easy,
the hard part is gathering together the little bits and pieces it also
needs to be good (I'm thinking of folio migration freezing anon to 0
in particular, that will lead to others).

> > The 87eaceb3faa5 commit did have the code to move from one deferred list
> > to another (but was not conscious of its unsafety while refcount non-0);
> > but that was removed by 5.6 commit fac0516b5534 ("mm: thp: don't need
> > care deferred split queue in memcg charge move path"), which argued that
> > the existence of a PMD mapping guarantees that the THP cannot be on a
> > deferred list.  
> 
> I recall this can happen, not sure on 5.6 though: assume we have an anon THP
> with 1 PMD mapping and a single PTE mapping for simplicity.
> 
> Assume we want to migrate that folio and first remove the PMD mapping, then
> the PTE mapping. After removing the PMD mapping, we add it to the deferred
> split queue (single PTE mapped).
> 
> Now assume migration fails and we remove migration entries -> remap.
> 
> We now have a PMD-mapped THP on the deferred split queue.
> 
> (again, I might be wrong but that's from memory without digging into the code)

I believe you're right, thank you for doing the heavy thinking for me.
Then I came up with 5.8's 5503fbf2b0b8 ("khugepaged: allow to
collapse PTE-mapped compound pages") introducing another way.

It looks to me like there is a case for backporting this patch,
but not a very strong case: worth some effort, but not too much -
I've not heard of the predicted issues in practice.

> 
> 
> > I'm not sure if that was true at the time (swapcache
> > remapped?), but it's clearly not true since 6.12 commit dafff3f4c850
> > ("mm: split underused THPs").
> 
> We only remap PTEs from the swapcache, never PMDs.

Right, thanks.

> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3626,19 +3646,6 @@ void deferred_split_folio(struct folio *folio, bool
> > partially_mapped)
> >    if (!partially_mapped && !split_underused_thp)
> >     return;
> >   -	/*
> > -	 * The try_to_unmap() in page reclaim path might reach here too,
> > -	 * this may cause a race condition to corrupt deferred split queue.
> > -	 * And, if page reclaim is already handling the same folio, it is
> > -	 * unnecessary to handle it again in shrinker.
> > -	 *
> > -	 * Check the swapcache flag to determine if the folio is being
> > -	 * handled by page reclaim since THP swap would add the folio into
> > -	 * swap cache before calling try_to_unmap().
> > -	 */
> > -	if (folio_test_swapcache(folio))
> > -		return;
> > -
> >    spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >    if (partially_mapped) {
> >   		if (!folio_test_partially_mapped(folio)) {

I'm changing this part in v2: keeping the return on swapcache, updating
the comment to say it's no longer essential, but a likely optimization.

I noticed the stats for deferred split were very different when I made
this change, largely because I'm doing a lot of unrealistic swapping
no doubt, but I don't want to take the risk of changing behaviour
when all we're trying to fix is list corruption.

> > diff --git a/mm/internal.h b/mm/internal.h
> > index 93083bbeeefa..16c1f3cd599e 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -639,11 +639,11 @@ static inline void folio_set_order(struct folio
> > *folio, unsigned int order)
> >   #endif
> >   }
> >   
> > -void __folio_undo_large_rmappable(struct folio *folio);
> > -static inline void folio_undo_large_rmappable(struct folio *folio)
> > +bool __folio_unqueue_deferred_split(struct folio *folio);
> > +static inline bool folio_unqueue_deferred_split(struct folio *folio)
> >   {
> >    if (folio_order(folio) <= 1 || !folio_test_large_rmappable(folio))
> 
> The rmappable check here is still confusing for me. I assume we want to
> exclude hugetlb or others that reuse the field for other purposes ...

Yes, I believe that is what it's about.  Somewhere else excludes hugetlb
explicitly instead.  I know Matthew would have liked to find a better name
than "large_rmappable" (aren't hugetlb folios large and rmappable?), but
nobody suggested a better.

You've reminded me to worry about how hugetlb pages get through
free_tail_page_prepare()'s case 2 check for list_empty(_deferred_list).
Ah, there's an INIT_LIST_HEAD(&folio->_deferred_list) in mm/hugetlb.c,
before freeing a hugetlb folio.  (The kind of detail which may be
different in backports.)

> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 4b21a368b4e2..57f64b5d0004 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2681,7 +2681,9 @@ void free_unref_folios(struct folio_batch *folios)
> >     unsigned long pfn = folio_pfn(folio);
> >     unsigned int order = folio_order(folio);
> >   -		folio_undo_large_rmappable(folio);
> > +		if (mem_cgroup_disabled())
> > +			folio_unqueue_deferred_split(folio);
> > +
> 
> Is it worth adding a comment here where we take care of ths with memcg
> enabled?

I've confessed to Yang Shi that I got this wrong: so in v2 there is
not even a line to add such a comment on (but comment in commit message).

> 
> It's complicated stuff, nothing jumped at me, but it's late here so my brain
> is not fully functional ...

Even your not fully functional brain is so much quicker than mine:
many thanks for applying it.

Hugh

