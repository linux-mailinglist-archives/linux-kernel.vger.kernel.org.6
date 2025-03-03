Return-Path: <linux-kernel+bounces-542125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F174A4C5ED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79F73A2FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2760215057;
	Mon,  3 Mar 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JD+QBAJ9"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A11214A9E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017619; cv=none; b=Zle2QMCMMcUwVrI3CLBMJ8F3VCLrfpwCjfmi9AEPnYJqvYjY0yrtDpVFmS04ycycpLkyR/YNAGdAMNhX63dn8HeANBMXt+SEx7/iBELImhQmWzQDHyn46cy+6Vq7kDUi85z2g8pU7xm/NP95H2f6fpQD2pY1EGF2pS2LUBaEK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017619; c=relaxed/simple;
	bh=7cw5uLdvU24ndiad/lnsfKWJMbG0wouaqcy42Hv9J68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHZkDtT/6nenyLHmqEMMDHwCo4+1HKYLfbwMRzZeOMG0pVlRC0XuH3LqE5oDB1PA9fUHJqs54XQxlearpZlu/1scQOS411oImGVlEO8g/Gh2xPspzELN4Ln92STvnRRCM+nLLwERehrtUyUE+JinVz2UmKVkgmCC+CxdhW2piwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JD+QBAJ9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ba8a87643so94155e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741017613; x=1741622413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vko7cABqIDq4wyQZcCWllQMJuzpSeLgfyvERDjNgnaM=;
        b=JD+QBAJ9JiBcQaDWwEsZ4R8UwLEpuRp0G/mEE+EfyFvV9vPurFC4/qwisGlxGWQ5zB
         ffJHv4XQ+aGeOPY7D1WqOKZ4+YLfkyfgJ5pzqhZvvo8VMi9VIxWDCp1/SImZEYfwRhyN
         1vPnYRLgi7Fv85VjH6bEW0gcGB6w0cR5h5ZeKotLEdTyNn9JwrbtPxHQ8ss80lsSGJbi
         eV5kQidedO22jsnpcXA3DSpNdYVylOXYEu3EKWnLd8Uzq3EZEaw5phRjEhQzUb38hP43
         1OEJvrnAdjAao8aFfC5tFRdo/zAucUnf81rWebD2jzYbggmxuBKtxSG1rks8BLuXl+uj
         DlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017613; x=1741622413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vko7cABqIDq4wyQZcCWllQMJuzpSeLgfyvERDjNgnaM=;
        b=ZsV9BiRwB1w+erfoJGTRDR6p/7AvjFzoXOhGACkPEe8XaWhdKBZKSsvEjQzEciuCxk
         jsEmVGCkVKzOkh0ViX4VALpbeE1Wj9O0xgAf1Y6Z/XOCqfAbnNnqxdcjWNQ6HtAMltx5
         gKkeGUF8xajwR3RHK65WybFxK7wgSJ9TpiyUvgwD8WESYH3V+RqnflhUzR0bhbtsIRX2
         tUiJ4dwcj8Rw37gDsHcTr0TP//AVX0768qUn6btuTpl7PdABIwxJWlwsW1CoAYRLhiOL
         Q31v+2/Hyv3fsYggxIyETTE6MoFa1HtQ4UDhEvGBJC3djMI8n5VSRX0q+M3oH/oJN0MF
         dCdA==
X-Forwarded-Encrypted: i=1; AJvYcCUkLfw5BtPXEj35GzVS47BWvBSzcLDMBu9lpLvmg0BFMFJ/t4Mp0ui8Q03gTyuV/3rh24XN9OdptIezWyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVU4PtJBFwdowcSK99sGowl1joTnzEmgZHUyRWtBSwgLUlk/4H
	+HtR7lEl5CMLP1nJlNnuuyFpDVbbPpSGItUFxh4aEuxGK6jCP91qeVzGU+1q6w==
X-Gm-Gg: ASbGncubENr+OeEitGzedXN16U78AXtFoVJhLCnh3ue8zigUi9wgqY8E3lI8VRZarig
	kEATrI1PE9RiwKvKg2QJ0zv0MnePNBjbbrzRCFBawNpBJyQu6QOEYI2nT+3bwvATf+H1QPCZGXC
	0uuBd8BPRL4KUc59+1w61CnP4+A5fTBI636X+cNJaVjq/amsWfZa3amPYYM1Xz8kcpSNwsSTNoO
	r+W/8w+z0vIcEiRySA6SVdTU6kATX0KEUC68ecQrekPKGSN8tLe2I5w0XrAKgIMSyIygS/IvMk2
	9c4w9jlQ49cQy/5mHD049zm43YsE3fNSHm8W9RtsbxkGzFwr51JZP3Q8anKg8WEizmmfSu1sF3Q
	SB/TM
X-Google-Smtp-Source: AGHT+IGyLIQ4fa7Av3UWVJcXm9EPAuZuYf9YOIbfavxsYUDavvmS7GtHJX/36pPQfOHOTqiDJFYG2w==
X-Received: by 2002:a05:600c:4ec8:b0:439:8f59:2c56 with SMTP id 5b1f17b1804b1-43bb44f1834mr2037135e9.2.1741017613471;
        Mon, 03 Mar 2025 08:00:13 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bca26676esm5183245e9.8.2025.03.03.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:00:12 -0800 (PST)
Date: Mon, 3 Mar 2025 16:00:08 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: Add lockdep assertion for pageblock
 type change
Message-ID: <Z8XSCE8goWnEzRSY@google.com>
References: <20250303-pageblock-lockdep-v2-1-3fc0c37e9532@google.com>
 <4d0f0bca-3096-4fb4-9e8b-d4dcdf7eeb92@redhat.com>
 <Z8W0v0LjuyH8ztTQ@google.com>
 <3e66875e-a4d5-4802-85b3-f873b0aa3b06@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e66875e-a4d5-4802-85b3-f873b0aa3b06@redhat.com>

On Mon, Mar 03, 2025 at 03:06:54PM +0100, David Hildenbrand wrote:
> On 03.03.25 14:55, Brendan Jackman wrote:
> > On Mon, Mar 03, 2025 at 02:11:23PM +0100, David Hildenbrand wrote:
> > > On 03.03.25 13:13, Brendan Jackman wrote:
> > > > Since the migratetype hygiene patches [0], the locking here is
> > > > a bit more formalised.
> > > > 
> > > > For other stuff, it's pretty obvious that it would be protected by the
> > > > zone lock. But it didn't seem totally self-evident that it should
> > > > protect the pageblock type. So it seems particularly helpful to have it
> > > > written in the code.
> > > 
> > > [...]
> > > 
> > > > +
> > > >    u64 max_mem_size = U64_MAX;
> > > >    /* add this memory to iomem resource */
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 579789600a3c7bfb7b0d847d51af702a9d4b139a..1ed21179676d05c66f77f9dbebf88e36bbe402e9 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -417,6 +417,10 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
> > > >    void set_pageblock_migratetype(struct page *page, int migratetype)
> > > >    {
> > > > +	lockdep_assert_once(system_state == SYSTEM_BOOTING ||
> > > > +		in_mem_hotplug() ||
> > > > +		lockdep_is_held(&page_zone(page)->lock));
> > > > +
> > > 
> > > I assume the call chain on the memory hotplug path is mostly
> > > 
> > > move_pfn_range_to_zone()->memmap_init_range()->set_pageblock_migratetype()
> > > 
> > > either when onlining a memory block, or from pagemap_range() while holding
> > > the hotplug lock.
> > > 
> > > But there is also the memmap_init_zone_device()->memmap_init_compound()->__init_zone_device_page()->set_pageblock_migratetype()
> > > one, called from pagemap_range() *without* holding the hotplug lock, and you
> > > assertion would be missing that.
> > > 
> > > I'm not too happy about that assertion in general.
> > 
> > Hmm, thanks for pointing that out.
> > 
> > I guess if we really wanted the assertion the approach would be to
> > replace in_mem_hotplug() with some more fine-grained logic about the
> > state of the pageblock? But that seems like it would require rework
> > that isn't really justified.
> 
> I was wondering if we could just grab the zone lock while initializing, then
> assert that we either hold that or are in boot.

Would that be because you want to avoid creating in_mem_hotplug()? Or
is it more about just simplifying the synchronization in general?

FWIW I don't think the in_mem_hotplug() is really that bad in the
assertion, it feels natural to me that memory hotplug would be an
exception to the locking rules in the same way that startup would be.

> In move_pfn_range_to_zone() it should likely not cause too much harm, and we
> could just grab it around all zone modification stuff.
> 
> memmap_init_zone_device() might take longer and be more problematic.
> 
> But I am not sure why memmap_init_zone_device() would have to set the
> migratetype at all? Because migratetype is a buddy concept, and
> ZONE_DEVICE does not interact with the buddy to that degree.
> 
> The comment in __init_zone_device_page states:
> 
> "Mark the block movable so that blocks are reserved for movable at
> startup. This will force kernel allocations to reserve their blocks
> rather than leaking throughout the address space during boot when
> many long-lived kernel allocations are made."

Uh, yeah I was pretty mystified by that. It would certainly be nice if
we can just get rid of this modification path.

> But that just dates back to 966cf44f637e where we copy-pasted that code.
>
> So I wonder if we could just
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 57933683ed0d1..b95f545846e6e 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1002,19 +1002,11 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>         page->zone_device_data = NULL;
>         /*
> -        * Mark the block movable so that blocks are reserved for
> -        * movable at startup. This will force kernel allocations
> -        * to reserve their blocks rather than leaking throughout
> -        * the address space during boot when many long-lived
> -        * kernel allocations are made.
> -        *
> -        * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
> -        * because this is done early in section_activate()
> +        * Note that we leave pageblock migratetypes uninitialized, because
> +        * they don't apply to ZONE_DEVICE.
>          */
> -       if (pageblock_aligned(pfn)) {
> -               set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> +       if (pageblock_aligned(pfn))
>                 cond_resched();
> -       }
>         /*
>          * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released

memory-model.rst says:

> Since the
> page reference count never drops below 1 the page is never tracked as
> free memory and the page's `struct list_head lru` space is repurposed
> for back referencing to the host device / driver that mapped the memory.

And this code seems to assume that the whole pageblock is part of the
ZONE_DEVICE dance, it would certainly make sense to me...


