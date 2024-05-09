Return-Path: <linux-kernel+bounces-174197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0928C0B8B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532382841DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA15F6BFBA;
	Thu,  9 May 2024 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wv+vaHy4"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB70624
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236397; cv=none; b=hQskRXb5Ao7MvlhgT9QAyqVOw5lJBfj51loEJ1OLHzKjSxjJfeQ5X6w0kWAoo6KXTeN9m1N8jrb0vVRR0YZsWVB/4yxwlNkp/wCqFz2rIowciFMi2QyB1WPm7MwqiUsT8jsMBZ5xFLUoTP+MtOn9MGFvYgjeEQrK+5eoJZ5k6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236397; c=relaxed/simple;
	bh=ALQUMWvMvMPXewq2UxuhZ3CMh5beYFyrw94nEcp+/a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH6Yonx0sbrMbRp55ErrXnVdk5Px4VFJU+Fe/VoIzQ5XKdjyVogWFi1ANdEj6BDOZg5jl8Kd6UKJfMhWvtydy/AwQwCAWm+MCB0xnYrfp1XP+Tl0Hw35PxJZDZSV2O+Q2adNn5lICwF48f6bFIanwjfOCia83h+c0jv0hy/cT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wv+vaHy4; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 8 May 2024 23:33:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715236393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UHtr7m6si+trM2Dv317fWhouVoPBtQqoBHj5VW99r0A=;
	b=Wv+vaHy4pFsFYU7gj/FuDvS5+mWemGN38atWuybzD/uHeaBVhzqHleqn2k+R+Q12jHQvTf
	nyMsl1E8GnEBMtm8XvOde/W0Px6jtQF0nvTKt6VxYytOmIh6AWass6MZ2SO0n36ThNP5GO
	1GeheQHHeCsHtv/BuWPCzQSJWr4+A3U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, gthelen@google.coma, rientjes@google.com
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509034138.2207186-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, May 08, 2024 at 08:41:29PM -0700, Roman Gushchin wrote:
> Cgroups v2 have been around for a while and many users have fully adopted them,
> so they never use cgroups v1 features and functionality. Yet they have to "pay"
> for the cgroup v1 support anyway:
> 1) the kernel binary contains useless cgroup v1 code,
> 2) some common structures like task_struct and mem_cgroup have never used
>    cgroup v1-specific members,
> 3) some code paths have additional checks which are not needed.
> 
> Cgroup v1's memory controller has a number of features that are not supported
> by cgroup v2 and their implementation is pretty much self contained.
> Most notably, these features are: soft limit reclaim, oom handling in userspace,
> complicated event notification system, charge migration.
> 
> Cgroup v1-specific code in memcontrol.c is close to 4k lines in size and it's
> intervened with generic and cgroup v2-specific code. It's a burden on
> developers and maintainers.
> 
> This patchset aims to solve these problems by:
> 1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1.c file,
> 2) putting definitions shared by memcontrol.c and memcontrol-v1.c into the
>    mm/internal.h header
> 3) introducing the CONFIG_MEMCG_V1 config option, turned on by default
> 4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set
> 5) putting unused struct memory_cgroup and task_struct members under
>    CONFIG_MEMCG_V1 as well.
> 
> This is an RFC version, which is not 100% polished yet, so but it would be great
> to discuss and agree on the overall approach.
> 
> Some open questions, opinions are appreciated:
> 1) I consider renaming non-static functions in memcontrol-v1.c to have
>    mem_cgroup_v1_ prefix. Is this a good idea?
> 2) Do we want to extend it beyond the memory controller? Should
> 3) Is it better to use a new include/linux/memcontrol-v1.h instead of
>    mm/internal.h? Or mm/memcontrol-v1.h.
> 

Hi Roman,

A very timely and important topic and we should definitely talk about it
during LSFMM as well. I have been thinking about this problem for quite
sometime and I am getting more and more convinced that we should aim to
completely deprecate memcg-v1.

More specifically:

1. What are the memcg-v1 features which have no alternative in memcg-v2
and are blocker for memcg-v1 users? (setting aside the cgroup v2
structual restrictions)

2. What are unused memcg-v1 features which we should start deprecating?

IMO we should systematically start deprecating memcg-v1 features and
start unblocking the users stuck on memcg-v1.

Now regarding the proposal in this series, I think it can be a first
step but should not give an impression that we are done. The only
concern I have is the potential of "out of sight, out of mind" situation
with this change but if we keep the momentum of deprecation of memcg-v1
it should be fine.

I have CCed Greg and David from Google to get their opinion on what
memcg-v1 features are blocker for their memcg-v2 migration and if they
have concern in deprecation of memcg-v1 features.

Anyone else still on memcg-v1, please do provide your input.

thanks,
Shakeel

