Return-Path: <linux-kernel+bounces-562138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FFBA61D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B293B7DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4958619883C;
	Fri, 14 Mar 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="AN1LgvBQ"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A431A3174
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985453; cv=none; b=QCDFlJLhOpt+9I/BNa7580GktjmIzTRJo5y5Pg8G59CcYC9W6RVh/wKkt09hqQlSjokfxFP8DlRxtRlQdwWFtw2kMwyMYghPzntHF3Gjj02ra8b6RVfDH/VSe7bVoNY3Itf7LIOOlnlIedbu01qZ3D3EoOaemxqVAp3lDv/s4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985453; c=relaxed/simple;
	bh=OyBphf3NAhksgQB5RnA27WO/14cKv9vxi7ynKu5FSH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXlP8/yKfUHqi2FLUSfvVnNvZazg+T/RaDGCqlCrV9ah/JneXMl7UU80T1sd5zWk1KFEl1YtB3TZCuZWOTc0ZsJbw0MqNhQyTPXYJ+GKpIg/JUmNSnuPpsXYWYfMlP34avKe4B0aUIcF3dLy9CKjJStllkzki0ypCb8AXwZbU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=AN1LgvBQ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8fc176825so22049636d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741985448; x=1742590248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeJkrQMKnmgGuWlzUVswi1M50jx4VyvPalYZQEj1LzY=;
        b=AN1LgvBQmBVchvxTsb3RVUF9eERcDFe6GbkC38QjJhrEX8t1NmRW6WD1MugB0WAMgC
         gFuqaxHnfajhUY5Aeix/aIbVG8rVtOUk2T8+vlkxpWAdnWXv1Kaik02ZJzpkb46eakL3
         DERb9lTZbDxcEZuR6i2r6/5CbZijay/GFBdJ+4HfHryHdj4r/RZauh3QEf/504WPrCO5
         0Xs4kTfoXSCx6llKlSj6mHYFK+UoOulGmHa6JvJOVveHqpxGtRJd0UhTcC0F46D/E48p
         IaoWDtANdmLXI0muUupftHbVd1EPVmUTWvQvnfsa9wIPyH6vAZQM9n5C6SkyQ41Fpxsw
         3E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741985448; x=1742590248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeJkrQMKnmgGuWlzUVswi1M50jx4VyvPalYZQEj1LzY=;
        b=jz+ArhahLzqQDdnB3Y9ViGUcUppAE2YHJ5D60cjgdLlPT9Qc9sVOKEYVtX5dj/a4MY
         TWc7U+DYQ+GwDpHkwd0tNJVI8gC6BRsDbctxIsLu6dVsn1Py2DDY7yFKE3bHLQET1gk6
         xbGxI6ulXH8HIPLK4OVBQiM9dFHjxqg6jowwCXm2xCWULRb2OFHAABbNDbS3J3mlopVg
         uDyq2x8G4SqPBQZBVy+oE0ZmCoDBSN46IBOojY/MUE7IXcAcMDH5GUmpumdZNZ/fW/BF
         J4h/abfYE0XeyFwl7NhLt5DwZd4TNHL145cvUSxEZM3013Nt8Yq5g0MJV9eivhXgN8/9
         V8dw==
X-Forwarded-Encrypted: i=1; AJvYcCXTjnmgIm8emOt1MZ7qQlLPTswsEeSae/R2bdkbx25rKbUYPrS6HdJtZtI58wXulosgFaB/zLHC6Z0wbwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZ/MXJ71IsulyFbNCJyw8lQWhmrjEjIAq6sm/j8Erf8Q0J/qc
	gywZ7TqST/ki710Pd1skPSpAKxxVwmxQZK4cg2T8VLPxxE8BbY8Cz+A3Pbr3db3D+Z+bU1whITE
	U
X-Gm-Gg: ASbGnctzzNYxRy6ZsW4y6zVJqOmYkJtqwzDbr3dC3PocxrCy7rOVUQIwvn9Owc9hScg
	1mp5T5tj2VwPj3psMoZNxT1G+wOwCTNu/ymg0IsCMWlKu9WVrNs5yge/Y4l+RXG+/EH/KTAA3Ax
	9AgvEqPzYLlTbQaRgHjVQoo6rbCXYgMgx0QPCoR/o0sEeUrJslgxOWX0PZEx/XJkh0KrAcvJmj0
	xzIgMeYmuaw71ZlPnXg0hKgc6HrxEYWuNq4EpnSia6gmLIjAxe9w29vHv+9/bZYYKHBQC10jUUy
	QiqDqy4xp8ze+potd74BEmJKJ3SGlxKY1g9X7YzTK0Z5fG/JXTdSjQ==
X-Google-Smtp-Source: AGHT+IECgL1wQzCyBNnCzlROoBSiV7GxzROiHPD7f+dACdXSfLXj4tyVcgKbaRblB7SP1DYL5EtEZg==
X-Received: by 2002:a0c:eb82:0:b0:6e8:feae:929c with SMTP id 6a1803df08f44-6eaeaa63b4bmr53287326d6.21.1741985448447;
        Fri, 14 Mar 2025 13:50:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade209cd9sm28003296d6.14.2025.03.14.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:50:47 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:50:39 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: page_alloc: defrag_mode
Message-ID: <20250314205039.GC1316033@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
 <20250313210647.1314586-4-hannes@cmpxchg.org>
 <E0358860-624D-4C9F-84E8-4887EE4DD8D4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E0358860-624D-4C9F-84E8-4887EE4DD8D4@nvidia.com>

On Fri, Mar 14, 2025 at 02:54:03PM -0400, Zi Yan wrote:
> On 13 Mar 2025, at 17:05, Johannes Weiner wrote:
> 
> > The page allocator groups requests by migratetype to stave off
> > fragmentation. However, in practice this is routinely defeated by the
> > fact that it gives up *before* invoking reclaim and compaction - which
> > may well produce suitable pages. As a result, fragmentation of
> > physical memory is a common ongoing process in many load scenarios.
> >
> > Fragmentation deteriorates compaction's ability to produce huge
> > pages. Depending on the lifetime of the fragmenting allocations, those
> > effects can be long-lasting or even permanent, requiring drastic
> > measures like forcible idle states or even reboots as the only
> > reliable ways to recover the address space for THP production.
> >
> > In a kernel build test with supplemental THP pressure, the THP
> > allocation rate steadily declines over 15 runs:
> >
> >     thp_fault_alloc
> >     61988
> >     56474
> >     57258
> >     50187
> >     52388
> >     55409
> >     52925
> >     47648
> >     43669
> >     40621
> >     36077
> >     41721
> >     36685
> >     34641
> >     33215
> >
> > This is a hurdle in adopting THP in any environment where hosts are
> > shared between multiple overlapping workloads (cloud environments),
> > and rarely experience true idle periods. To make THP a reliable and
> > predictable optimization, there needs to be a stronger guarantee to
> > avoid such fragmentation.
> >
> > Introduce defrag_mode. When enabled, reclaim/compaction is invoked to
> > its full extent *before* falling back. Specifically, ALLOC_NOFRAGMENT
> > is enforced on the allocator fastpath and the reclaiming slowpath.
> >
> > For now, fallbacks are permitted to avert OOMs. There is a plan to add
> > defrag_mode=2 to prefer OOMs over fragmentation, but this requires
> > additional prep work in compaction and the reserve management to make
> > it ready for all possible allocation contexts.
> >
> > The following test results are from a kernel build with periodic
> > bursts of THP allocations, over 15 runs:
> >
> >                                         vanilla    defrag_mode=1
> > @claimer[unmovable]:                        189              103
> > @claimer[movable]:                           92              103
> > @claimer[reclaimable]:                      207               61
> > @pollute[unmovable from movable]:            25                0
> > @pollute[unmovable from reclaimable]:        28                0
> > @pollute[movable from unmovable]:         38835                0
> > @pollute[movable from reclaimable]:      147136                0
> > @pollute[reclaimable from unmovable]:       178                0
> > @pollute[reclaimable from movable]:          33                0
> > @steal[unmovable from movable]:              11                0
> > @steal[unmovable from reclaimable]:           5                0
> > @steal[reclaimable from unmovable]:         107                0
> > @steal[reclaimable from movable]:            90                0
> > @steal[movable from reclaimable]:           354                0
> > @steal[movable from unmovable]:             130                0
> >
> > Both types of polluting fallbacks are eliminated in this workload.
> >
> > Interestingly, whole block conversions are reduced as well. This is
> > because once a block is claimed for a type, its empty space remains
> > available for future allocations, instead of being padded with
> > fallbacks; this allows the native type to group up instead of
> > spreading out to new blocks. The assumption in the allocator has been
> > that pollution from movable allocations is less harmful than from
> > other types, since they can be reclaimed or migrated out should the
> > space be needed. However, since fallbacks occur *before*
> > reclaim/compaction is invoked, movable pollution will still cause
> > non-movable allocations to spread out and claim more blocks.
> >
> > Without fragmentation, THP rates hold steady with defrag_mode=1:
> >
> >     thp_fault_alloc
> >     32478
> >     20725
> >     45045
> >     32130
> >     14018
> >     21711
> >     40791
> >     29134
> >     34458
> >     45381
> >     28305
> >     17265
> >     22584
> >     28454
> >     30850
> >
> > While the downward trend is eliminated, the keen reader will of course
> > notice that the baseline rate is much smaller than the vanilla
> > kernel's to begin with. This is due to deficiencies in how reclaim and
> > compaction are currently driven: ALLOC_NOFRAGMENT increases the extent
> > to which smaller allocations are competing with THPs for pageblocks,
> > while making no effort themselves to reclaim or compact beyond their
> > own request size. This effect already exists with the current usage of
> > ALLOC_NOFRAGMENT, but is amplified by defrag_mode insisting on whole
> > block stealing much more strongly.
> >
> > Subsequent patches will address defrag_mode reclaim strategy to raise
> > the THP success baseline above the vanilla kernel.
> 
> All makes sense to me. But is there a better name than defrag_mode?
> It sounds very similar to /sys/kernel/mm/transparent_hugepage/defrag.
> Or it actually means the THP defrag mode?

Thanks for taking a look!

I'm not set on defrag_mode, but I also couldn't think of anything
better.

The proximity to the THP flag name strikes me as beneficial, since
it's an established term for "try harder to make huge pages".

Suggestions welcome :)

> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst |  9 +++++++++
> >  mm/page_alloc.c                         | 27 +++++++++++++++++++++++--
> >  2 files changed, 34 insertions(+), 2 deletions(-)
> >
> 
> When I am checking ALLOC_NOFRAGMENT, I find that in get_page_from_freelist(),
> ALLOC_NOFRAGMENT is removed when allocation goes into a remote node. I wonder
> if this could reduce the anti-fragmentation effort for NUMA systems. Basically,
> falling back to a remote node for allocation would fragment the remote node,
> even the remote node is trying hard to not fragment itself. Have you tested
> on a NUMA system?

There is this hunk in the patch:

@@ -3480,7 +3486,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				continue;
 		}
 
-		if (no_fallback && nr_online_nodes > 1 &&
+		if (no_fallback && !defrag_mode && nr_online_nodes > 1 &&
 		    zone != zonelist_zone(ac->preferred_zoneref)) {
 			int local_nid;
 
So it shouldn't clear the flag when spilling into the next node.

Am I missing something?

