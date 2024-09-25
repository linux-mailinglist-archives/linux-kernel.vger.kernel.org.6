Return-Path: <linux-kernel+bounces-337838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D164984F90
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD34B210AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A5013210D;
	Wed, 25 Sep 2024 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMYqjfGl"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D2130499
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727225281; cv=none; b=jk/z2hb6CViqukb2o4mFw7DPLA25Sm9QrpTR2GCz6Lzwp4Y+IeJEmqZbgRAYrPeh5MJS/9wEtWUlOgjka7gO7WL1WL7QNPaNQ5h7qm5EefeSvsvkV9DzRNpdHLPkg7pZZEaT+WnRqw9/W7tPavHFsqbqxahp8pjKQqEdb/j4YC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727225281; c=relaxed/simple;
	bh=SkSjZzKgIZ3N5jrqA/um6cNpJ5EvXeWuGC6WHw+yilw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTQYojwn7YObHkSuZcaEOyzed6YmFbpxhkrpomXAeFpqp8byQ45a1OMttkMBFhgm4sF7eyUKTYctiqNDcaqnhfEd1TBlNcv4bzZ/1SR3F4aNYBFNb8IRMDtVYx3PbXyQSAnUjk/ktpf/JS/6kJgXdFDCvP8M8BO/AG/SevRA62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMYqjfGl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d3cde1103so547913766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727225278; x=1727830078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RjroumTRg3WK06LaJJH4au3JX5ri1QDATDl4+eAVQeI=;
        b=YMYqjfGlgvYBWe7iKBQsW27qiaAyrwF6r1DNfPi2ClLL2WerJjmNaBVoZQmpILFLGt
         8WP76A+9OfFApQ0YPAYrDWsbKk5+oLp9TP9nVA58hu5CTeO6KgfZrGpVY9u6FgkNj8tL
         O9OK2yWU1yJ+QEEU4zovtAaie5MHzTKcKDh0M+T0BlzTko1Y1PQNe/hB1p3LFLIuk2UB
         GniqElaRS4U0KxUE9mhFEu5J4MAWTL9p6REltdBaPZ29q6N7SP6dAuphgj11VM1QqEM/
         72Cy3eqhkc3zUYADqxoAJWgygQsUy5lrUjwREoag0ezFff60VE45JDX2ctNfx3J1qPik
         fx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727225278; x=1727830078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjroumTRg3WK06LaJJH4au3JX5ri1QDATDl4+eAVQeI=;
        b=okqJuGbOjs3oA0MUQXwaOKEsEcgnFEqT3UVXZmXSduFxB24bXXnF6UWZseHAtDfcs0
         A9xhmAeGE/fcnsK3pOfr9TZTg4BTzljaLjelgHcNuHRLGrtVrTnTv7rhIoAustR1HgQ0
         hjcE0xtXThFs1ufVqBjXiCQlsq1M91D2w3G013Bol/fu4fJRUv40uUCtcxUezudDpEnC
         SACFghiDoqL27AnczhA1H7iYb1L0xGg1UQZ3p6ljIEHbiHhlqDXQLJb9PZbvnvgNSNOD
         0tfhbUgiGlhJiuH0q/DrdNEXFCPAnwMvvVLZa6eT+hDBX0XNARkF8tL1mhy4L3Mkntm0
         8EZA==
X-Gm-Message-State: AOJu0YzUBB+4x0SOmuB27N056WulBmX2eDztfwjhEXZDJNqi+BX2x+c7
	Y/366T61kmRs0QL/9AM+WNNm0Mwl3w13FzN3xCZZgB7+EFq8/x5bBCOEZ2pYeysoOQcNk+ZIwIf
	KSITv00ckMUI3f9ZT/ZeUHuRwF+yr/7mTHt6i
X-Google-Smtp-Source: AGHT+IFT1+XkDNXM0wUC5d0XbRCPwF92i2hsvdolML0qEbL8TkBgdfFoCvKcGyfkRdHe21DiOC4IfCDXtE7rS5Jl/A4=
X-Received: by 2002:a17:906:6a03:b0:a86:820e:2ac6 with SMTP id
 a640c23a62f3a-a93a037e463mr100424366b.22.1727225277451; Tue, 24 Sep 2024
 17:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-6-kanchana.p.sridhar@intel.com> <CAJD7tkacF3hCXiZHy7_+E7xmdojnsUewDeP=BsamcZReHxCTtg@mail.gmail.com>
 <SJ0PR11MB567887AF292EC178BEF1CF43C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB567887AF292EC178BEF1CF43C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 17:47:21 -0700
Message-ID: <CAJD7tkbCB9iqRc1Y0287rZjQnJaV41DxN+GzZJFkqxM1FM8R4w@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm: zswap: Compress and store a specific page in a folio.
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> >
> > > +{
> > > +       swp_entry_t swp = folio->swap;
> > > +       int type = swp_type(swp);
> > > +       pgoff_t offset = swp_offset(swp) + index;
> > > +       struct page *page = folio_page(folio, index);
> > > +       struct xarray *tree = swap_zswap_tree(swp);
> > > +       struct zswap_entry *entry;
> > > +
> > > +       if (objcg)
> > > +               obj_cgroup_get(objcg);
> > > +
> > > +       if (zswap_check_limits())
> > > +               goto reject;
> > > +
> > > +       /* allocate entry */
> > > +       entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> > > +       if (!entry) {
> > > +               zswap_reject_kmemcache_fail++;
> > > +               goto reject;
> > > +       }
> > > +
> > > +       /* if entry is successfully added, it keeps the reference */
> > > +       if (!zswap_pool_get(pool))
> > > +               goto freepage;
> >
> > I think we can batch this for all pages in zswap_store(), maybe first
> > add zswap_pool_get_many().
> >
> > I am also wondering if it would be better to batch the limit checking
> > and allocating the entries, to front load any failures before we start
> > compression. Not sure if that's overall better though.
> >
> > To batch allocate entries we will have to also allocate an array to
> > hold them. To batch the limit checking we will have to either allow
> > going further over limit for mTHPs, or check if there is enough
> > clearance to allow for compressing all the pages. Using the
> > uncompressed size will lead to false negatives though, so maybe we can
> > start tracking the average compression ratio for better limit
> > checking.
> >
> > Nhat, Johannes, any thoughts here? I need someone to tell me if I am
> > overthinking this :)
>
> These are all good points. I suppose I was thinking along the same lines
> of what Nhat mentioned in an earlier comment. I was trying the
> incremental zswap_pool_get() and limit checks and shrinker invocations
> in case of (all) error conditions to allow different concurrent stores to make
> progress, without favoring only one process's mTHP store. I was thinking
> this would have minimal impact on the process(es) that see the zswap
> limit being exceeded, and that this would be better than preemptively
> checking for the entire mTHP and failing (this could also complicate things
> where no one makes progress because multiple processes run the batch
> checks and fail, when realistically one/many could have triggered
> the shrinker before erroring out, and at least one could have made
> progress).

On the other hand, if we allow concurrent mTHP swapouts to do limit
checks incrementally, they may all fail at the last page. While if
they all do limit checks beforehand, one of them can proceed.

I think we need to agree on a higher-level strategy for limit
checking, both global and per-memcg. The per-memcg limit should be
stricter though, so we may end up having different policies.

>
> Would appreciate your perspectives on how this should be handled,
> and will implement a solution in v8 accordingly.
>
> Thanks,
> Kanchana
>
> >
> > > +
> > > +       entry->pool = pool;
> > > +
> > > +       if (!zswap_compress(page, entry))
> > > +               goto put_pool;
> > > +
> > > +       entry->swpentry = swp_entry(type, offset);
> > > +       entry->objcg = objcg;
> > > +       entry->referenced = true;
> > > +
> > > +       if (!zswap_store_entry(tree, entry))
> > > +               goto store_failed;
> > > +
> > > +       if (objcg) {
> > > +               obj_cgroup_charge_zswap(objcg, entry->length);
> > > +               count_objcg_event(objcg, ZSWPOUT);
> > > +       }
> > > +
> > > +       /*
> > > +        * We finish initializing the entry while it's already in xarray.
> > > +        * This is safe because:
> > > +        *
> > > +        * 1. Concurrent stores and invalidations are excluded by folio lock.
> > > +        *
> > > +        * 2. Writeback is excluded by the entry not being on the LRU yet.
> > > +        *    The publishing order matters to prevent writeback from seeing
> > > +        *    an incoherent entry.
> > > +        */
> > > +       if (entry->length) {
> > > +               INIT_LIST_HEAD(&entry->lru);
> > > +               zswap_lru_add(&zswap_list_lru, entry);
> > > +       }
> > > +
> > > +       /* update stats */
> > > +       atomic_inc(&zswap_stored_pages);
> > > +       count_vm_event(ZSWPOUT);
> >
> > We should probably also batch updating the stats. It actually seems
> > like now we don't handle rolling them back upon failure.
>
> Good point! I assume you are referring only to the "ZSWPOUT" vm event stats
> updates and not the "zswap_stored_pages" (since latter is used in limit checking)?

I actually meant both. Do we rollback changes to zswap_stored_pages
when some stores succeed and some of them fail?

I think it's more correct and efficient to update the atomic once
after all the pages are successfully compressed and stored.

