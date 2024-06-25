Return-Path: <linux-kernel+bounces-229595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86991712D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E711F1C225C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93117C9F7;
	Tue, 25 Jun 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwNYU9rG"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04913C9A2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344278; cv=none; b=VvT2ILuV5S+HYIHORnol3LJrMv+aW4YervRNB1LqT84Zs9CZ7/1pa4FBuozM1D+pzEfWvpGMmIkPFMdvKnYsuGnnL78ZxpDnMzoisNRsXLUz7tgFtSstBzBoadPks3Z/td2IsLpSjRy6iARLZf2YhbYe95oonR7o52WZdDjLuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344278; c=relaxed/simple;
	bh=IPpSDnv0Otuph5TmIXknyBcqkkHgzod1VBBj40XXcUQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=el4Zni8JLvvCaU+A8I+qrgUA7chpDuYgSDhzoEbL5tyeOmilKJYLWWl2iVKBg8C7EPb9/8n9B2AsaZ7JB/9pNQ38dXod9zuZ3GrDzdU74oJ1/UoRwZIa6fZgQ+P3nDml7cjHIn/pYNFk2SJCJCGCHoqGbqetqEJrf/sjO5Lwn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bwNYU9rG; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e02da9b2db7so5573554276.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719344275; x=1719949075; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJMwDI5sIIM5SROlRDuokl000wjQ1EBy0CMyjOqTGuU=;
        b=bwNYU9rGJSk/YFvlrDv/jgVEzDfuK9S9UwVc35G7OX9aWP03z5x7Ns8BuoIT51dti9
         j6F5vA3bPGvrluFlg+j5c5G2liXsMNPItKKAH1nvcRPnXlyoV9LNeHCoCWWePePWg/PD
         QsdaoKMqINycvEJeMKBgtY7QnCYI7lOAsVyPacxQqlD43pUIG2PJohksvh09CmQx0p2T
         rgthVBnCMWjX/RScD7YGCNpcq5K2dNPXebDHh+Qn2libXhPbi/xHMV39pLxK8g7LJMZn
         JlxT1AiRkZGcZbqIn9ey3wUXuG7cM3aumGFtaJbi836vl0tLZjMNGCU7ep0vm3MYlYSE
         6+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719344275; x=1719949075;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJMwDI5sIIM5SROlRDuokl000wjQ1EBy0CMyjOqTGuU=;
        b=Y8fb7G9lX2d8bnTvUORWmL7AIdP/yOuhqfOlLZ8pCAKk0m137pcicaQthHXQnbGwVC
         yNHzUBy4qStYrwPqZrciDIA+4ynUlXa5RaAp+iNY6KyyQr4M8YI3tdo4HcOikLhdawmI
         b2nn/BzYNMWD4pCXHD68qrmNyi7yIdXd+wA363EIHYAuu/HD0dSJoRDKE1MwhEGuKz+q
         vQc5EShsWgOlYLzn89Tg7H4vQoEhgoK3CpaNT2s84CE8cBfcWdQGStBuljHQzU3/jc51
         lgT2ADamoJ6B3EXJ+SsUK9VLH+fxXUcmc8jNVQqwBnao9KaGpECrai514G4iyG0CPmmW
         c7qw==
X-Forwarded-Encrypted: i=1; AJvYcCVWoUghtdQBf2U0G/y47dWs8oS9KnnoI5Mo9TQsgknE6t6CRZrsjiMFgyDhLUTGf4gXAW+Gqe83UqnuBtyJx/2p/MiT1ARP99gQbBkZ
X-Gm-Message-State: AOJu0YzS0B0B+MWwdbKraL0iFHu50lGrnw+xATqFvfmbWfX/3NhirVbu
	qbIv8XjS/7CP+4yobTQqc1WDLxXFZMLqPhabvmJTd5AHnpDecYXeUIeRIIfE/iW6+XF0L5AA/qV
	E1A==
X-Google-Smtp-Source: AGHT+IFxm9yualsjwylRAQRma05qLWD/BuSSgSFXHa94JcuXlHJdYS6kJjvdKSG92faY67NQAEVpDQ==
X-Received: by 2002:a5b:852:0:b0:e02:b82c:f1ce with SMTP id 3f1490d57ef6-e0303f2ae69mr8583867276.8.1719344273713;
        Tue, 25 Jun 2024 12:37:53 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e032327f82csm591570276.32.2024.06.25.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:37:52 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:37:41 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Barry Song <21cnbao@gmail.com>, baolin.wang@linux.alibaba.com, 
    chrisl@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    mhocko@suse.com, ryan.roberts@arm.com, shy828301@gmail.com, 
    surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
    ying.huang@intel.com, yosryahmed@google.com, yuanshuai@oppo.com, 
    yuzhao@google.com
Subject: Re: [PATCH mm-unstable] mm: folio_add_new_anon_rmap() careful
 __folio_set_swapbacked()
In-Reply-To: <0a41d5fc-d1a1-4b1b-873e-a701b20bbcb3@redhat.com>
Message-ID: <f7c74073-f19a-0f59-3801-a20d319bc0ea@google.com>
References: <f3599b1d-8323-0dc5-e9e0-fdb3cfc3dd5a@google.com> <0a41d5fc-d1a1-4b1b-873e-a701b20bbcb3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Jun 2024, David Hildenbrand wrote:
> On 25.06.24 07:00, Hugh Dickins wrote:
> > Commit "mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)==
> > false" has extended folio_add_new_anon_rmap() to use on non-exclusive
> > folios, already visible to others in swap cache and on LRU.
> > 
> > That renders its non-atomic __folio_set_swapbacked() unsafe: it risks
> > overwriting concurrent atomic operations on folio->flags, losing bits
> > added or restoring bits cleared.  Since it's only used in this risky
> > way when folio_test_locked and !folio_test_anon, many such races are
> > excluded; but, for example, isolations by folio_test_clear_lru() are
> > vulnerable, and setting or clearing active.
> > 
> > It could just use the atomic folio_set_swapbacked(); but this function
> > does try to avoid atomics where it can, so use a branch instead: just
> > avoid setting swapbacked when it is already set, that is good enough.
> > (Swapbacked is normally stable once set: lazyfree can undo it, but
> > only later, when found anon in a page table.)
> > 
> > This fixes a lot of instability under compaction and swapping loads:
> > assorted "Bad page"s, VM_BUG_ON_FOLIO()s, apparently even page double
> > frees - though I've not worked out what races could lead to the latter.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >   mm/rmap.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index df1a43295c85..5394c1178bf1 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1408,7 +1408,9 @@ void folio_add_new_anon_rmap(struct folio *folio,
> > struct vm_area_struct *vma,
> >    VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> >    VM_BUG_ON_VMA(address < vma->vm_start ||
> >   			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> > -	__folio_set_swapbacked(folio);
> > +
> > +	if (!folio_test_swapbacked(folio))
> > +		__folio_set_swapbacked(folio);
> >    __folio_set_anon(folio, vma, address, exclusive);
> >   
> >    if (likely(!folio_test_large(folio))) {
> 
> LGTM.
> 
> I'll point out that it's sufficient for a PFN walker to do a tryget + trylock
> to cause trouble.

That surprises me.  I thought a racer's tryget was irrelevant (touching
a different field) and its trylock not a problem, since "we" hold the
folio lock throughout.  If my mental model is too naive there, please
explain in more detail: we all need to understand this better.

> 
> Fortunately isolate_movable_page() will check __folio_test_movable() before
> doing the trylock.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks,
Hugh

