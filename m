Return-Path: <linux-kernel+bounces-181370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A58C7B20
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B4FB2250D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD41156661;
	Thu, 16 May 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eLrUvCuf"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC7143C4A
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880597; cv=none; b=q7fHYuBOesBg1e16LBX7iyTxEKd83/i6zwUeHltQwntbYLkYwxKBnOAJ3xFtZFzPEJ+eXeopJ1MAojFWhLNP8sbczrRzz2VvhnwLGHToN3vP9jWbxITPJog0J5VSPfB5nF0BeBh2rRPpknFInIj9P6Whn+qoUrOa832smhOsN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880597; c=relaxed/simple;
	bh=YRe922F5kBFg7Q+FnGAO5HQTlaMqAOGy07hYcnX/Q0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6sHuATXwVOHdni2obWr32sN8wo8hpeFudulec9pgqOn5dKxCROJrVJa4qXcteVlED268diVhZpsl04TGTZqmpjaIvtQ7/wQ84cK1l0jFOtAja7UjkFeWQaAYrAILZyseSL5F+7VwAzQuvvLTQX5T2nWql5AOBKJYTLKpucZSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eLrUvCuf; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: laoar.shao@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715880592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1Ad8wbyCbk3kKGBKcpXTU8AdgHoqIGVPzQYX8PLizs=;
	b=eLrUvCufwzLQuwwbHvc/0nhjDcf/K6eDhic6LXQF/RYZ8bm4MupdjcPbTVUCqiampwbM/p
	utQ6oy1GMNyiKBrrehBJuCfM7+AMCjdN1v2xppd3mma7bFKBFN9dh9c0w/pGTsG5xNHW7I
	gneYaTqgPR4LYsL4ABdZ3R0BS9+QEwA=
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: gthelen@google.coma
X-Envelope-To: rientjes@google.com
Date: Thu, 16 May 2024 10:29:47 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gthelen@google.coma,
	rientjes@google.com
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <ZkZCizXXqVlkIoze@P9FQF9L96D>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
 <CALOAHbC0AATe5iMAm84Y_obOs4ePZYEW3X2a2OmjTCt_A3xXMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbC0AATe5iMAm84Y_obOs4ePZYEW3X2a2OmjTCt_A3xXMQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 16, 2024 at 11:35:57AM +0800, Yafang Shao wrote:
> On Thu, May 9, 2024 at 2:33 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Wed, May 08, 2024 at 08:41:29PM -0700, Roman Gushchin wrote:
> > > Cgroups v2 have been around for a while and many users have fully adopted them,
> > > so they never use cgroups v1 features and functionality. Yet they have to "pay"
> > > for the cgroup v1 support anyway:
> > > 1) the kernel binary contains useless cgroup v1 code,
> > > 2) some common structures like task_struct and mem_cgroup have never used
> > >    cgroup v1-specific members,
> > > 3) some code paths have additional checks which are not needed.
> > >
> > > Cgroup v1's memory controller has a number of features that are not supported
> > > by cgroup v2 and their implementation is pretty much self contained.
> > > Most notably, these features are: soft limit reclaim, oom handling in userspace,
> > > complicated event notification system, charge migration.
> > >
> > > Cgroup v1-specific code in memcontrol.c is close to 4k lines in size and it's
> > > intervened with generic and cgroup v2-specific code. It's a burden on
> > > developers and maintainers.
> > >
> > > This patchset aims to solve these problems by:
> > > 1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1.c file,
> > > 2) putting definitions shared by memcontrol.c and memcontrol-v1.c into the
> > >    mm/internal.h header
> > > 3) introducing the CONFIG_MEMCG_V1 config option, turned on by default
> > > 4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set
> > > 5) putting unused struct memory_cgroup and task_struct members under
> > >    CONFIG_MEMCG_V1 as well.
> > >
> > > This is an RFC version, which is not 100% polished yet, so but it would be great
> > > to discuss and agree on the overall approach.
> > >
> > > Some open questions, opinions are appreciated:
> > > 1) I consider renaming non-static functions in memcontrol-v1.c to have
> > >    mem_cgroup_v1_ prefix. Is this a good idea?
> > > 2) Do we want to extend it beyond the memory controller? Should
> > > 3) Is it better to use a new include/linux/memcontrol-v1.h instead of
> > >    mm/internal.h? Or mm/memcontrol-v1.h.
> > >
> >
> > Hi Roman,
> >
> > A very timely and important topic and we should definitely talk about it
> > during LSFMM as well. I have been thinking about this problem for quite
> > sometime and I am getting more and more convinced that we should aim to
> > completely deprecate memcg-v1.
> >
> > More specifically:
> >
> > 1. What are the memcg-v1 features which have no alternative in memcg-v2
> > and are blocker for memcg-v1 users? (setting aside the cgroup v2
> > structual restrictions)
> >
> > 2. What are unused memcg-v1 features which we should start deprecating?
> >
> > IMO we should systematically start deprecating memcg-v1 features and
> > start unblocking the users stuck on memcg-v1.
> >
> > Now regarding the proposal in this series, I think it can be a first
> > step but should not give an impression that we are done. The only
> > concern I have is the potential of "out of sight, out of mind" situation
> > with this change but if we keep the momentum of deprecation of memcg-v1
> > it should be fine.
> >
> > I have CCed Greg and David from Google to get their opinion on what
> > memcg-v1 features are blocker for their memcg-v2 migration and if they
> > have concern in deprecation of memcg-v1 features.
> >
> > Anyone else still on memcg-v1, please do provide your input.
> 
> Hi Shakeel,
> 
> Hopefully I'm not too late.  We are currently using memcg v1.
> 
> One specific feature we rely on in v1 is skmem accounting. In v1, we
> account for TCP memory usage without charging it to memcg v1, which is
> useful for monitoring the TCP memory usage generated by tasks running
> in a container. However, in memcg v2, monitoring TCP memory requires
> charging it to the container, which can easily cause OOM issues. It
> would be better if we could monitor skmem usage without charging it in
> the memcg v2, allowing us to account for it without the risk of
> triggering OOM conditions.

Hi Yafang,

the data itself is available on cgroup v2 in memory.stat:sock, however
you're right, it's charged on pair with other types of memory. It was
one of the main principles of cgroup v2's memory controller, so I don't
think it can be changed.

So the feature you need is not skmem accounting, but something quite
opposite :)

The question I have here: what makes socket memory different here?

Is it something specific to your setup (e.g. you mostly use memory.max
to protect against memory leaks in the userspace code, but socket memory
spikes are always caused by external traffic and are legit) or we have
more fundamental problems with the socket memory handling, e.g. we can't
effectively reclaim it under the memory pressure?

In the first case you can maintain a ~2-lines non-upstream patch which will
disable the charging while maintaining statistics - it's not a perfect, but
likely the best option here. In the second case we need collectively fix it
for cgroup v2.

Thanks!

