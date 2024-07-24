Return-Path: <linux-kernel+bounces-261588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685293B972
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4231C21810
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540ED13C67E;
	Wed, 24 Jul 2024 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BoqNk3s8"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B826281
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721863928; cv=none; b=CgffcRKzN5Xnf3Xy6aaLsyXwFWIwlxpd+Ug9C1hKaDiFMmYOvARl19nA1EOak1ymyh2UKOfHawtnbx66902vY52ubXCIm3V37eDwPjSQuiLs45a5dhlkOwjQ+n9Q79zuPawvbBKcG3vVaA5zezxxlvNTnd5iTNN2Qmj5QA4AHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721863928; c=relaxed/simple;
	bh=+m9uh+MCn/yJ4tm5LMhUaicrTyuIFYcnbQQfbwS/cEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN5BoU/yJ8aV3dc+9KtaEEAcYo0JafxPbblX7RiBj1FdJrLqA8OtceTnxKJohwQUQ2eIta85I7Qvj/SoHEn/kLpb9U3XgJO8gP02B6l0jyrFblWSIwvpxcsSIJ5qTCtIlz3Cd9sWqwNIBfQOQBUYscdMtgvLjtjqUJLxPgeF5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BoqNk3s8; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 23:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721863923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqINtMpqerirwytDRn2yUhT9tOOj5Ldg0qn/p88A8pU=;
	b=BoqNk3s8xNDnNwtcI8X8LcVtoz6mTiPxTiIKroFIi+KNWFThNcrlxYhmxLs3cdp/EMiytO
	1K1QoPWIKxDsGh0bcwLH3Vd0K32iyy7kmQ5NkgH8Xdl+KHv81w0mO3GaEAyLC7tzNmy9Hq
	lx7sujOZvALnyGWF/cAxS9WCmhpnMSM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 1/5] mm: memcg: don't call propagate_protected_usage()
 needlessly
Message-ID: <ZqGO7jtUCM2tG_QZ@google.com>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-2-roman.gushchin@linux.dev>
 <CAJD7tkYOgYMKp+u97wm6biA+C_2BR-B2hy6zi=cVqHovUxLTRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYOgYMKp+u97wm6biA+C_2BR-B2hy6zi=cVqHovUxLTRA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 04:13:17PM -0700, Yosry Ahmed wrote:
> On Wed, Jul 24, 2024 at 1:21 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > Memory protection (min/low) requires a constant tracking of
> > protected memory usage. propagate_protected_usage() is called
> > on each page counters update and does a number of operations
> > even in cases when the actual memory protection functionality
> > is not supported (e.g. hugetlb cgroups or memcg swap counters).
> >
> > It's obviously inefficient and leads to a waste of CPU cycles.
> > It can be addressed by calling propagate_protected_usage() only
> > for the counters which do support memory guarantees. As of now
> > it's only memcg->memory - the unified memory memcg counter.
> >
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >  include/linux/page_counter.h |  8 +++++++-
> >  mm/hugetlb_cgroup.c          |  4 ++--
> >  mm/memcontrol.c              | 16 ++++++++--------
> >  mm/page_counter.c            | 16 +++++++++++++---
> >  4 files changed, 30 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> > index 860f313182e7..b31fd5b208aa 100644
> > --- a/include/linux/page_counter.h
> > +++ b/include/linux/page_counter.h
> > @@ -32,6 +32,7 @@ struct page_counter {
> >         /* Keep all the read most fields in a separete cacheline. */
> >         CACHELINE_PADDING(_pad2_);
> >
> > +       bool protection_support;
> >         unsigned long min;
> >         unsigned long low;
> >         unsigned long high;
> > @@ -45,12 +46,17 @@ struct page_counter {
> >  #define PAGE_COUNTER_MAX (LONG_MAX / PAGE_SIZE)
> >  #endif
> >
> > +/*
> > + * Protection is supported only for the first counter (with id 0).
> > + */
> >  static inline void page_counter_init(struct page_counter *counter,
> > -                                    struct page_counter *parent)
> > +                                    struct page_counter *parent,
> > +                                    bool protection_support)
> 
> Would it be better to make this an internal helper (e.g.
> __page_counter_init()), and add another API function that passes in
> protection_support=true, for example:
> 
> static inline void page_counter_init_protected(..)
> {
>        __page_counter_init(.., true);
> }
> 
> This will get rid of the naked booleans at the callsites of
> page_counter_init(), which are more difficult to interpret. It will
> also reduce the diff as we only need to change the page_counter_init()
> calls of memcg->memory.
> 
> WDYT?

No strong opinion here. There are basically 2 call sites and I don't expect
this number to grow, so not sure if it makes sense to add 2 new helpers.

Another option I thought about is to leave page_counter_init() as it is
and add a separate function to enable the protection tracking.

Thanks!

