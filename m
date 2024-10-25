Return-Path: <linux-kernel+bounces-382144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA09B0A07
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF14B2168A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683918660A;
	Fri, 25 Oct 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYF1Mz8D"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616821A4D0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874085; cv=none; b=lLv6IGIjnDLsxk50UXOL+yvYsQmKcJV4LKWVtonIho1Ss53gPUq7x+K/AQ5s93pB1xf/MNaZHWclopABJ20m5BWzEvu2+BUFYA5D5cxtPL7Yidi4ePUl2TkLnLY4YUiyWVbiIPk9I9rLApHhvLnzNHdP1JpDdri356RrN6dXARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874085; c=relaxed/simple;
	bh=iVgTNuQrNSgFz6uuf8x3IMCi9W2Qazvc9733i17OGJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiyiaaRJKMKG2dUYqCb+EM1+6B9CRiBf9JrWEOLkF2Ejq2F78NJrBmai4uaAqZWedUDGTdmGB3eAWDjr+7+8RE/ne5PoSKD8Wpash72HTd0d2CbNUge/UrTrXrhUNQHNkeRarSgqbDSXb8dSsObbqfi5MSf5xBgDyxEmJp/BrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYF1Mz8D; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso3558877a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729874081; x=1730478881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ac17hdVh+onN5kuR/AiipcbAnn1S6E1bEALkkLK7RY=;
        b=CYF1Mz8D2V05ZgsR/IC0CmcK+LtZD4gT/vyNuc0wjYimyq27HkJSMrezrheaAGZ62g
         D6yO05EaVd7iondFJjqpE3ieO80N6uxTtx4Van2S2bIF8eaUSkZxMsnqMJSRixZYRHEt
         UN67srpZiutIQ0M3rBv3vJPE9prqndTMAOn+m92aDWd3JQq+62vFs5JF+RXN1n+s/XDx
         Zcis1iNYwxPIBT2v6KPYn2npQ+ZySdL1NA/dTRgED1v1KxulTWloGG9i/aLCGwbkBudM
         j3LbFQj5BahgWwD7J5ap5reSxxCQqwfmYV1yfCS044hWOsU9YFi5M/pZwoOhMg4tOdCt
         QUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874081; x=1730478881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ac17hdVh+onN5kuR/AiipcbAnn1S6E1bEALkkLK7RY=;
        b=UDjIdRgLfFGw2nmTeLGVw11brmpZ+cxbReCKXim+ILIrUIWx0xWtwQXsUruZwD8/Ld
         KYJxuchB14li+6a2NicRs5/j2PtFeC/z9y1x9EJGAobFclKpq9OB94S7Z76rTMLvjxb5
         dIpXf4NKSaoi9v4xFMk/5ByI+mAI/HITIvYHwGWcMWxa3QHU1jxTGUjGKWpWEC1pGHdi
         Axg1kBmmgfbELfzTL9PW1GQN5Gkv9HSSWb+4b7lAg+8Y1mGgN1s45TGXQiVMEy0bSmJI
         pMFU+8Cp7Ua4PcKvGo3Xj845ZaxVEEBwBM7cLQ7EjKUiXhjDJ/SrI3HqHVSJSUAWcOCw
         MIBA==
X-Forwarded-Encrypted: i=1; AJvYcCUBct613fN2HQu9pT+mjmdWietKegXVgMCUFU2XWJd0KPDWRICvdx4TVD97Haj6aQ/J/MBWXDuRSIuLlpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZd7e7TxowoQeB6O1BZ+Po4Wo3v6BWos5nEphMmRNimNYAp68C
	W8FjO2erkEKGFrrDz2ObqvS6+/RxVnHdfh9gbhmCHwHjHYqfzNRxVgJftBl1TR0KL3BJB8qyl8y
	Mjlr6Fg6c+afE7dCeq98is9Qc/FY=
X-Google-Smtp-Source: AGHT+IHyZlYXlehUxpbIqwguKr8w+asAHNQiFzjOlt0wLqYi5e6BjSpS3oEJ4PG4NomTOLnyJIZxdzocOgL7HHoWQYo=
X-Received: by 2002:a05:6402:42d6:b0:5cb:be69:1444 with SMTP id
 4fb4d7f45d1cf-5cbbf1d07b1mr164408a12.9.1729874080758; Fri, 25 Oct 2024
 09:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
 <7dc6b280-cd87-acd1-1124-e512e3d2217d@google.com> <CAHbLzkoRHcC33vj7iajw_JXVig7yghJRGaTpaHXaxhoni76yPw@mail.gmail.com>
 <b3e88e26-5bda-50fc-cc55-a62b4b2a4e24@google.com>
In-Reply-To: <b3e88e26-5bda-50fc-cc55-a62b4b2a4e24@google.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 25 Oct 2024 09:34:29 -0700
Message-ID: <CAHbLzkqjO6X_k91xFFRG+5FLkzxvc0UKsUomW0_oYMv68TCHQg@mail.gmail.com>
Subject: Re: [PATCH hotfix 2/2] mm/thp: fix deferred split unqueue naming and locking
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Usama Arif <usamaarif642@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Nhat Pham <nphamcs@gmail.com>, Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 11:57=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> On Thu, 24 Oct 2024, Yang Shi wrote:
> > On Wed, Oct 23, 2024 at 9:13=E2=80=AFPM Hugh Dickins <hughd@google.com>=
 wrote:
> > >
> > > That goes back to 5.4 commit 87eaceb3faa5 ("mm: thp: make deferred sp=
lit
> > > shrinker memcg aware"): which included a check on swapcache before ad=
ding
> > > to deferred queue (which can now be removed), but no check on deferre=
d
> > > queue before adding THP to swapcache (maybe other circumstances preve=
nted
> > > it at that time, but not now).
> >
> > If I remember correctly, THP just can be added to deferred list when
> > there is no PMD map before mTHP swapout, so shrink_page_list() did
> > check THP's compound_mapcount (called _entire_mapcount now) before
> > adding it to swap cache.
> >
> > Now the code just checked whether the large folio is on deferred list o=
r not.
>
> I've continued to find it hard to think about, hard to be convinced by
> that sequence of checks, without an actual explicit _deferred_list check.

You meant the swap cache check? I was trying to recall the reason. If
I remember correctly (sorry, memory is still vague), if the THP was
PMD-mapped and PTE-mapped by two processes, the THP may be added to
swap cache since just compound_mapcount was checked. Then
try_to_unmap() in shrink_page_list() may add it to deferred list if
PMD mapping was unmapped first. The potential list corruption fixed by
you now may be triggered.

But this was based on the assumption that there can't be PMD-mapped
THP on deferred list. If this happens (as David's migration fail
example), the swap cache check should be not enough. This case was
overlooked.

>
> David has brilliantly come up with the failed THP migration example;
> and I think now perhaps 5.8's 5503fbf2b0b8 ("khugepaged: allow to
> collapse PTE-mapped compound pages") introduced another way?
>
> But I certainly need to reword that wagging finger pointing to your
> commit: these are much more exceptional cases than I was thinking there.
>
> I have this evening tried running swapping load on 5.10 and 6.6 and 6.11,
> each with just a BUG_ON(!list_empty(the deferred list)) before resetting
> memcg in mem_cgroup_swapout() - it would of course be much easier to hit
> such a BUG_ON() than for the consequent wrong locking to be so unlucky
> as to actually result in list corruption.
>
> None of those BUG_ONs hit; though I was only running each for 1.5 hour,
> and looking at vmstats at the end, see the were really not exercising
> deferred split very much at all.  I'd been hoping for an immediate hit
> (as on 6.12-rc) to confirm my doubt, but no.  That doesn't *prove* you're
> right, but (excepting David's and my weird cases) I bet you are right.

Maybe it just happened rarely and was hard to hit. But still
theoretically possible. Your fix is more reliable.

>
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 4b21a368b4e2..57f64b5d0004 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -2681,7 +2681,9 @@ void free_unref_folios(struct folio_batch *foli=
os)
> > >                 unsigned long pfn =3D folio_pfn(folio);
> > >                 unsigned int order =3D folio_order(folio);
> > >
> > > -               folio_undo_large_rmappable(folio);
> > > +               if (mem_cgroup_disabled())
> > > +                       folio_unqueue_deferred_split(folio);
> >
> > This looks confusing. It looks all callsites of free_unref_folios()
> > have folio_unqueue_deferred_split() and memcg uncharge called before
> > it. If there is any problem, memcg uncharge should catch it. Did I
> > miss something?
>
> I don't understand what you're suggesting there.  But David remarked
> on it too, so it seems that I do need at least to add some comment.
>
> I'd better re-examine the memcg/non-memcg forking paths again: but by
> strange coincidence (or suggestion?), I'm suddenly now too tired here,
> precisely where David stopped too.  I'll have to come back to this
> tomorrow, sorry.

I perhaps misunderstood this code. Just feel free to correct me if it
doesn't make sense to you. But, yes, some comments are definitely
welcome and helpful for understanding the code and review.

>
> Hugh

