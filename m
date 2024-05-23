Return-Path: <linux-kernel+bounces-187008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566638CCBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5881F21A62
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC99D83CD2;
	Thu, 23 May 2024 05:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fCHx5jGf"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA439AF9
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716442489; cv=none; b=Q5uh/8evAWoQWHZvIE6hv/FZOvKEidfekr26ojZyYoDEnqJrO1yS9p102IS2Rk1JkWCEtcNkW4pA8NTp+UfUBO1b/zkJSW+xMJALdOdP5MVRcEffhmD3aqK8bKx2lNLiKBvW5sWyaAskwuner6ZZA+hHKloPlD5KLkxy9v3+jxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716442489; c=relaxed/simple;
	bh=0bvFLgpRChs3my1ASPJUQCsC+t0BhA8vLmMRSw0BWlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOseMB0D8k2qQu1RuZkNy1GEBygPxzmjHfzfSGhPxOKJO4CnTsNYoZQd+EdOmFTpgvhszSfete/o56CD9CbbZkcy3ybzQIxLZ+xv2VczGyHK/tAEm8uYizr2yjfBneOyGI7v9d9D50U0JP/MWY6tiOStlpGnv53Jx3V2JM2GTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fCHx5jGf; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716442484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCNNrN2ieh0YNX+YK2n+Te1/2f1bAXoL3EIWFMUSa3w=;
	b=fCHx5jGf40pCBUFth/qkjaUbtaVClmPKnhgJ9jSTtjKEL1aYXE8IJpb3sSXzAmBHJZUlt9
	FtXnKSyHvqD6xjbjFeGZio95MXFY+VyBWTosPbjwlnMnzScwqb7e23zTpOZoEotOQQWvEM
	Ufd3ASj4deKGuQ4DP019lrCcG0Q5vLs=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: fengwei.yin@intel.com
X-Envelope-To: oliver.sang@intel.com
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Wed, 22 May 2024 22:34:38 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com, oliver.sang@intel.com, 
	kernel-team@meta.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: rearrage fields of mem_cgroup_per_node
Message-ID: <m4ixafl5ajnr6tgkjwead3bmgglqqcpfwsgqijb6mlz2rfgjtu@yi3jwlnfpqpx>
References: <20240523034824.1255719-1-shakeel.butt@linux.dev>
 <CAJD7tkaaEn+2G46taRD1V1W=okBfZtPPOFFyj5A+MVfGzqPDqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaaEn+2G46taRD1V1W=okBfZtPPOFFyj5A+MVfGzqPDqw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 22, 2024 at 09:35:57PM -0700, Yosry Ahmed wrote:
> On Wed, May 22, 2024 at 8:48 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
[...]
> >
> >  struct mem_cgroup_per_node {
> > -       struct lruvec           lruvec;
> > +       /* Keep the read-only fields at the start */
> > +       struct mem_cgroup       *memcg;         /* Back pointer, we cannot */
> > +                                               /* use container_of        */
> >
> >         struct lruvec_stats_percpu __percpu     *lruvec_stats_percpu;
> >         struct lruvec_stats                     *lruvec_stats;
> > -
> > -       unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> > -
> > -       struct mem_cgroup_reclaim_iter  iter;
> > -
> >         struct shrinker_info __rcu      *shrinker_info;
> >
> > +       /* memcg-v1 only stuff in middle */
> > +
> >         struct rb_node          tree_node;      /* RB tree node */
> >         unsigned long           usage_in_excess;/* Set to the value by which */
> >                                                 /* the soft limit is exceeded*/
> >         bool                    on_tree;
> > -       struct mem_cgroup       *memcg;         /* Back pointer, we cannot */
> > -                                               /* use container_of        */
> 
> Do we need CACHELINE_PADDING() here (or maybe make struct lruvec
> cache-aligned) to make sure the false cacheline sharing doesn't happen
> again with the fields below, or is the idea that the fields that get
> read in hot paths (memcg, lruvec_stats_percpu, lruvec_stats) are far
> at the top, and the memcg v1 elements in the middle act as a buffer?
> 
> IOW, is sharing between the fields below and memcg v1 fields okay
> because they are not read in the hot path? If yes, I believe it's
> worth a comment. It can be easily missed if the memcg v1 soft limit is
> removed later for example.
> 

For 6.10, I wanted to keep the change simple and yes, the memcg v1 stuff
as a buffer between the pointers and lruvec/lru_zone_size fields. For
6.11 or later kernels, I am planning to use some asserts to make sure
these fields don't share a cacheline, so later when we remove the
v1-only stuff, the asserts will make sure we keep the separate cacheline
property intact.


