Return-Path: <linux-kernel+bounces-287218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF379524E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF0B1C21639
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4B1C824A;
	Wed, 14 Aug 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hB5dbF5f"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B07346D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723671746; cv=none; b=IOCiDX1Tlwp3JCA+u6Z8fjdBiwhXSSH+epF9srsq5Pd9l3XeV8GTnHDy3sUQYBKMrYKaIK/adm8926/FlZbH1KMRMRaS/sFYWC5RUAomr6mhxNvJYgwPb4DUxv3dcuMY3RvGEOI4Zs2YWWXXHG7uToLL3tfL8BzJrUeC1mPdRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723671746; c=relaxed/simple;
	bh=Eze1YvBlqw+MJZLfh9h6nFHyLnOwPgc0LLqwoNhKx1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfMPxdxsEktqmjh4DyAvpOgWVk5zYaUHx1KFAOkUSihnXrZJTSzPXP9qdKggz5ub3hot0bH5oxRlWf0nHWleCo5L8hhBP2LlsLEUWcwq7YpNcOitUv3icxGRNfxc2+pQy4eEApwr63y8exd7HdqYK++JpnhGpodD+JVX2XM9rRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hB5dbF5f; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Aug 2024 14:42:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723671739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIhfQtAttnBaCpCE+ey5b1+F0FxQnhTmRpcsEUiZYG0=;
	b=hB5dbF5f5HKHT9IkH7wIxVJs4zWWmjrgTJohxAnDR5uve3hQCRMeHNnXF6mcWjjJCA1FSU
	UM2vkmYMyXiIBFRQEBcCzKrxEycYztbmeod0EflCrPTu1bcD1DMN6o5N5Gf1R7tgeQv8ED
	rDhR9sejBHpc4Zs+4henHSjSXJVnyhM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/4] memcg: initiate deprecation of v1 tcp accounting
Message-ID: <n4yebzbpida7q7g4ajgjkp5nefxn3mkxpm2lfvpp27zfe7sydb@gf6gcmfg55rl>
References: <20240814202825.2694077-1-shakeel.butt@linux.dev>
 <20240814202825.2694077-2-shakeel.butt@linux.dev>
 <CABdmKX07o8ywPNoTDL_tM6qn46TXeLbhHoQEtBpFBXJkWdAc7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX07o8ywPNoTDL_tM6qn46TXeLbhHoQEtBpFBXJkWdAc7A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 14, 2024 at 01:59:15PM GMT, T.J. Mercier wrote:
> On Wed, Aug 14, 2024 at 1:28 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Memcg v1 provides opt-in TCP memory accounting feature. However it is
> > mostly unused due to its performance impact on the network traffic. In
> > v2, the TCP memory is accounted in the regular memory usage and is
> > transparent to the users but they can observe the TCP memory usage
> > through memcg stats.
> >
> > Let's initiate the deprecation process of memcg v1's tcp accounting
> > functionality and add warnings to gather if there are any users and if
> > there are, collect how they are using it and plan to provide them better
> > alternative in v2.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++++
> >  mm/memcontrol-v1.c                             | 3 +++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> > index 9cde26d33843..fb6d3e2a6395 100644
> > --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> > +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> > @@ -105,10 +105,18 @@ Brief summary of control files.
> >   memory.kmem.max_usage_in_bytes      show max kernel memory usage recorded
> >
> >   memory.kmem.tcp.limit_in_bytes      set/show hard limit for tcp buf memory
> > +                                     This knob is deprecated and shouldn't be
> > +                                     used.
> >   memory.kmem.tcp.usage_in_bytes      show current tcp buf memory allocation
> > +                                     This knob is deprecated and shouldn't be
> > +                                     used.
> >   memory.kmem.tcp.failcnt             show the number of tcp buf memory usage
> > +                                     This knob is deprecated and shouldn't be
> > +                                     used.
> >                                      hits limits
> 
> Looks like you split the description (that has weird grammar) here.
> 

Thanks for catching. Bad paste line. Will fix.

> >   memory.kmem.tcp.max_usage_in_bytes  show max tcp buf memory usage recorded
> > +                                     This knob is deprecated and shouldn't be
> > +                                     used.
> >  ==================================== ==========================================
> >
> >  1. History
> > diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> > index 9725c731fb21..b8e2ee454eaa 100644
> > --- a/mm/memcontrol-v1.c
> > +++ b/mm/memcontrol-v1.c
> > @@ -2447,6 +2447,9 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
> >                         ret = 0;
> >                         break;
> >                 case _TCP:
> > +                       pr_warn_once("kmem.tcp.limit_in_bytes is deprecated and will be removed. "
> > +                                    "Please report your usecase to linux-mm@kvack.org if you "
> > +                                    "depend on this functionality.\n");
> >                         ret = memcg_update_tcp_max(memcg, nr_pages);
> >                         break;
> >                 }
> > --
> > 2.43.5
> >
> Otherwise LGTM
> Reviewed-by: T.J. Mercier <tjmercier@google.com>

Thanks.

