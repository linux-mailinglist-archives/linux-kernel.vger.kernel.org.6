Return-Path: <linux-kernel+bounces-396659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B810A9BD032
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7740228363F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742311D27B1;
	Tue,  5 Nov 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ad259eEh"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83849224FA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819783; cv=none; b=TfrBi9Rw68fl2MfJy0QsNHKkzVMorb+eBSQNho2qaxH1OgSrLajfDf93PvaHhr6fr+zCwh4zPPGsaeKFZmdkD6v2jR/khYH0bMbfxAxOBJqFhgr9Re7nYbd0DC0s8IWTg31W7by+0bU0BdymRHI7nSZmJDXFhC3ee2HHS9vz0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819783; c=relaxed/simple;
	bh=y2h+1OKoYJn4CzVjLxEOsxF6HG641x9GVVa1RcAT6Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WprPq42xNkdDckqULytHnFR0BaKqzPUjEVS5QvAXTmGbmQfKI+GJzAjKWC2PfsfkyF7FTTszINc/8QouDHtAJVonzCIJP/maLuTMc8kgFRoVWJl/N4V9Typ80xp2exoSKD1fe6J6Axym4WHzMQnbXkSGBq+L9dvfZojbQhzfrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ad259eEh; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cc03b649f2so39150776d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730819780; x=1731424580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsHvyzwRf5/kTw6CpaYrJy4qdW947vGUGh6/HpaFcVs=;
        b=ad259eEhhd+LIKRCknjmlpNnSLXscQPZX3FLPSLrArCzdOn1Cudx7QnlLDnD8gg8hR
         geWUHhYZEnAlgoFJ+16JaEa6LgIuwO+mBsBuq9O5e3UH6/X1cbolL/+iAis5D0G3l8XX
         MI1xNfvA76tCcaw7GOfG4okhinJJlaHHKHIwOYAA9ssYtKQ7eYWpZ8/bE/2XVJpmKWu7
         u6sN4uiewF5vPn4qt1Q5AV0vmrgvNGcCOD8aYL7lBlSbbOYwQg+y491DHZAamPt4Qg9I
         cjlR8bHbF6F02DLF6kD3kFaVCcTqK4FCN6zUvdWrewHTmYT++zri8Cj9DaZMIw9xVXCf
         Cr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730819780; x=1731424580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsHvyzwRf5/kTw6CpaYrJy4qdW947vGUGh6/HpaFcVs=;
        b=QFUxIrH20juTOc7kpMb31vFeyD+ZEdtIRQvbRpQsZeucshlKhC2pltP5vEURde7AVl
         VWjj7Eag3HVJPjKmD90+y+Vde9+2cAP8qsX0ZfLkV0Sry3a6Dqj+Mi7Z3j1HPULficcl
         zLq2Uk7rL03b2ZynP3UlZOwYJiKpr0HG4HnRthi+QnbGZmQ9dQiWzVEpr3jkfElmjk9b
         DjP+4XLiMvIjLWqfkKfbNXcYnIxXTJumSYrWOXeXPCbvd9fejeOO7YdCXbO42mNpZzKF
         LGPT1iam4Wc/MaWO9IMGFxogdluXfpFjYDCYQSC37ctSxBWLHsVCjrcqcMzWNFytbSbp
         FpXw==
X-Forwarded-Encrypted: i=1; AJvYcCXrg4lraJX31n9Rg5gwhVJGi1x3XhoUZwWyGe97OSNTmsZUVFnP66tGl38EhslWoK01AVDgS65pTZ4ajO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTy9O40wQ/tkstOj5xawh/E6Ye+6D5vw4UDVvVhm/pRaUOR8e5
	iJxy0IbEsROWytvtnSPaSh7/D3uPw/vUgS0WqJUqdWZlSxNp+tO5S1EaF6AEER8=
X-Google-Smtp-Source: AGHT+IHzbmk+6Nhdx/Q+cCNji2tD4RIJAp+WTiu6+n2i5b2IanzdzzHP/MHl1OYO5jysNjrrfAy67Q==
X-Received: by 2002:a05:6214:285:b0:6d3:5681:977e with SMTP id 6a1803df08f44-6d3568199e7mr223219806d6.51.1730819780226;
        Tue, 05 Nov 2024 07:16:20 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415a703sm60937326d6.85.2024.11.05.07.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:16:19 -0800 (PST)
Date: Tue, 5 Nov 2024 10:16:10 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, david@redhat.com, nphamcs@gmail.com,
	nehagholkar@meta.com, abhishekd@meta.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
Message-ID: <Zyo2uvFJKdExcQfH@PC2K9PVX.TheFacebook.com>
References: <20240803094715.23900-1-gourry@gourry.net>
 <875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com>
 <87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZykOqYJpgL4lw7mw@PC2K9PVX.TheFacebook.com>
 <87jzdi782s.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzdi782s.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Tue, Nov 05, 2024 at 10:00:59AM +0800, Huang, Ying wrote:
> Hi, Gregory,
> 
> Gregory Price <gourry@gourry.net> writes:
> 
> > My observations between these 3 proposals:
> >
> > - The page-lock state is complex while trying interpose in mark_folio_accessed,
> >   meaning inline promotion inside that interface is a non-starter.
> >
> >   We found one deadlock during task exit due to the PTL being held. 
> >
> >   This worries me more generally, but we did find some success changing certain
> >   calls to mark_folio_accessed to mark_folio_accessed_and_promote - rather than
> >   modifying mark_folio_accessed. This ends up changing code in similar places
> >   to your hook - but catches a more conditions that mark a page accessed.
> >
> > - For Keith's proposal, promotions via LRU requires memory pressure on the lower
> >   tier to cause a shrink and therefore promotions. I'm not well versed in LRU
> >   LRU sematics, but it seems we could try proactive reclaim here.
> >   
> >   Doing promote-reclaim and demote/swap/evict reclaim on the same triggers
> >   seems counter-intuitive.
> 
> IIUC, in TPP paper (https://arxiv.org/abs/2206.02878), a similar method
> is proposed for page promoting.  I guess that it works together with
> proactive reclaiming.
> 

Each process is responsible for doing page table scanning for numa hint faults
and producing a promotion.  Since the structure used there is the page tables
themselves, there isn't an existing recording mechanism for us to piggy-back on
to defer migrations to later.

> > - Doing promotions inline with access creates overhead.  I've seen some research
> >   suggesting 60us+ per migration - so aggressiveness could harm performance.
> >
> >   Doing it async would alleviate inline access overheads - but it could also make
> >   promotion pointless if time-to-promote is to far from liveliness of the pages.
> 
> Async promotion needs to deal with the resource (CPU/memory) charging
> too.  You do some work for a task, so you need to charge the consumed
> resource for the task.
> 

This is a good point, and would heavily complicate things. Simple is better,
let's avoid that.

> > - Doing async-promotion may also require something like PG_PROMOTABLE (as proposed
> >   by Keith's patch), which will obviously be a very contentious topic.
> 
> Some additional data structure can be used to record pages.
> 

I have an idea inspired by these three sets, i'll bumble my way through a prototype.

> > Reading more into the code surrounding this and other migration logic, I also
> > think we should explore an optimization to mempolicy that tries to aggressively
> > keep certain classes of memory on the local node (RX memory and stack
> > for example).
> >
> > Other areas of reclaim try to actively prevent demoting this type of memory, so we
> > should try not to allocate it there in the first place.
> 
> We have already used DRAM first allocation policy.  So, we need to
> measure its effect firstly.
> 

Yes, but also as the weighted interleave patch set demonstrated, it can be beneficial
to change this to distribute allocations from the outset - however, distributing all
allocations lead to less reliable performance than just distributing the heap.

Another topic for another thread.
~Gregory

