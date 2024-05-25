Return-Path: <linux-kernel+bounces-189220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CEE8CED46
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 03:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4B21C20DB6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE01362;
	Sat, 25 May 2024 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FAozuyjN"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB54A47
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716599051; cv=none; b=HsYPCIMtki/jkCV4oGl4grdtXjNlbV/o/yGEB7CTqUwmEnJWy5JONLTFOOxRsKG0fRksZtpygTTfR06mLlwCUoVuuJNT604zSJ0NXilPCnt1sBa0lJ5T6i5iUszK9cVw/S+yBsY4oFVfnRY6u8NvflzPo3klimhoCJK3lAc4phk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716599051; c=relaxed/simple;
	bh=lvkTAPTyFDvlkGlF6NsGpiUvsvIz4Fnfnt3BBqFQB3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdaUaapuJ3vvMcphyga54MrjV7GuOE1Urao5oG1eeI/gBSfzN/Ku3p6oy1GkQrO8C63IvaeWx1h2etI6n+nO5q6+hQ/tqhWfixyNvftS1IPqBcrIDJHCWpghyC1jq/XTNX2eJY5Vlqj8aewBZf7Fnvf27UyF4EOmtPp9Nr8LtlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FAozuyjN; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mhocko@suse.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716599044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ufi9TD8HsXQKxKXjR9qMrAehcd/b8jx9bHHV6cnAIGs=;
	b=FAozuyjNwmDcmvjDO8knfuEz9FRgwtkTtXUahBfGyV5svhvezy3006+ewkyP1JVCbc8I+1
	47Yhcu0cWRsIM5iAce6BYCcFf4UIjDLZjbhxQyVtLAtC09rtRHAgLxLNJ49I948Q6S3Oau
	WTMU0OQKC9LNSqFeskI5hKP6CX++8EE=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 24 May 2024 18:03:58 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 6/9] mm: memcg: move cgroup v1 oom handling code into
 memcontrol-v1.c
Message-ID: <ZlE4_hzesg-d6WNc@P9FQF9L96D>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <20240509034138.2207186-7-roman.gushchin@linux.dev>
 <Zj4gi-vOxLZi2van@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj4gi-vOxLZi2van@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Fri, May 10, 2024 at 03:26:35PM +0200, Michal Hocko wrote:
> On Wed 08-05-24 20:41:35, Roman Gushchin wrote:
> [...]
> > @@ -1747,106 +1623,14 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
> >  
> >  	memcg_memory_event(memcg, MEMCG_OOM);
> >  
> > -	/*
> > -	 * We are in the middle of the charge context here, so we
> > -	 * don't want to block when potentially sitting on a callstack
> > -	 * that holds all kinds of filesystem and mm locks.
> > -	 *
> > -	 * cgroup1 allows disabling the OOM killer and waiting for outside
> > -	 * handling until the charge can succeed; remember the context and put
> > -	 * the task to sleep at the end of the page fault when all locks are
> > -	 * released.
> > -	 *
> > -	 * On the other hand, in-kernel OOM killer allows for an async victim
> > -	 * memory reclaim (oom_reaper) and that means that we are not solely
> > -	 * relying on the oom victim to make a forward progress and we can
> > -	 * invoke the oom killer here.
> > -	 *
> > -	 * Please note that mem_cgroup_out_of_memory might fail to find a
> > -	 * victim and then we have to bail out from the charge path.
> > -	 */
> > -	if (READ_ONCE(memcg->oom_kill_disable)) {
> > -		if (current->in_user_fault) {
> > -			css_get(&memcg->css);
> > -			current->memcg_in_oom = memcg;
> > -			current->memcg_oom_gfp_mask = mask;
> > -			current->memcg_oom_order = order;
> > -		}
> > +	if (!mem_cgroup_v1_oom_prepare(memcg, mask, order, &locked))
> >  		return false;
> > -	}
> > -
> > -	mem_cgroup_mark_under_oom(memcg);
> > -
> > -	locked = mem_cgroup_oom_trylock(memcg);
> 
> This really confused me because this looks like the oom locking is
> removed for v2 but this is not the case because
> mem_cgroup_v1_oom_prepare is not really v1 only code - in other words
> this is not going to be just return false for CONFIG_MEMCG_V1=n.
> 
> It makes sense to move the userspace oom handling out to the v1 file. I
> would keep mem_cgroup_mark_under_oom here.

Hm, I don't see any usages of memcg->under_oom outside of v1-specific
context. I probably miss something, can you, please, clarify?

> I am not sure about the oom
> locking thing because I think we can make it v1 only. For v2 I guess we
> can go without this locking as the oom path is already locked and it
> implements overkilling prevention (oom_evaluate_task) as it walks all
> processes in the oom hierarchy.

It's a good point and not obvious if we really need anything of this on v2.
I guess no, but will think a bit more.

Thank you!

