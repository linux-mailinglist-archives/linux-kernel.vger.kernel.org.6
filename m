Return-Path: <linux-kernel+bounces-182755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF298C8F54
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 04:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B00B1C210C6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2A8523A;
	Sat, 18 May 2024 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wfcvzPI/"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF211A2C10
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715998449; cv=none; b=KsmRJZ+ZI5wTynNd+Bxdo2MDT3sgPKbl28WLzURhtGJpV1rd6mqBUm90h7rZTIAzmNgWr/t0KKBVqTz/tsjYiWAt7QbEulTiqDjX6mtHiQ1DH3Hge5fQD0VL7+3Syu8lvnf+BkXBk27Tse3J0ndj+QA6/swCmrE9j6jngKDC1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715998449; c=relaxed/simple;
	bh=O2FlHEaDKpdQJDmYsNnH+SCEMrIIW2A1KJnxe77FPOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qID7ag4kDC3eHfxHdqXwQ6qIdCNofEUOmMO7qzu2cETboy7wCpUIFFipfd1VyDQnf2sZv0UKIla1MoHbccTzCnzCaklF0AuFYOa/Y5GVJOBbHoPbroGxYyEliciOr7TOhCMcrnp+8pRvUabf0o3jd48FLrqKK7HRMHVF845fA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wfcvzPI/; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: laoar.shao@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715998444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRbwA1yNn6JplEQ4dkgS+9BdCRcYLVNbMuhVOlY4LmM=;
	b=wfcvzPI/xu/du6+vB0e/EXvBDTT5x7Q9UKaunIJEO4vzoOEDD/D4bEHSp5BbqRy2qHganP
	mKYgOwmIIyvHWPpYP3Bv6J1klt/SL/XlAT/wYzUkyF7A50BpFsk4bnjFQBh2qlRIf5FpTd
	NefIKiQU1Xi5wjh5lie5SGCc3NhlkxM=
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
Date: Fri, 17 May 2024 19:13:58 -0700
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
Message-ID: <ZkgO5qkLAyW0T3a5@P9FQF9L96D>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
 <CALOAHbC0AATe5iMAm84Y_obOs4ePZYEW3X2a2OmjTCt_A3xXMQ@mail.gmail.com>
 <ZkZCizXXqVlkIoze@P9FQF9L96D>
 <CALOAHbCqO6_kVJHLu9=vZVme2vhm7N70UN+0HSKA1Q2Zxq5SzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCqO6_kVJHLu9=vZVme2vhm7N70UN+0HSKA1Q2Zxq5SzQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 17, 2024 at 10:21:01AM +0800, Yafang Shao wrote:
> On Fri, May 17, 2024 at 1:29 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Thu, May 16, 2024 at 11:35:57AM +0800, Yafang Shao wrote:
> > > On Thu, May 9, 2024 at 2:33 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Wed, May 08, 2024 at 08:41:29PM -0700, Roman Gushchin wrote:
> > > > > Cgroups v2 have been around for a while and many users have fully adopted them,
> > > > > so they never use cgroups v1 features and functionality. Yet they have to "pay"
> > > > > for the cgroup v1 support anyway:
> > > > > 1) the kernel binary contains useless cgroup v1 code,
> > > > > 2) some common structures like task_struct and mem_cgroup have never used
> > > > >    cgroup v1-specific members,
> > > > > 3) some code paths have additional checks which are not needed.
> > > > >
> > > > > Cgroup v1's memory controller has a number of features that are not supported
> > > > > by cgroup v2 and their implementation is pretty much self contained.
> > > > > Most notably, these features are: soft limit reclaim, oom handling in userspace,
> > > > > complicated event notification system, charge migration.
> > > > >
> > > > > Cgroup v1-specific code in memcontrol.c is close to 4k lines in size and it's
> > > > > intervened with generic and cgroup v2-specific code. It's a burden on
> > > > > developers and maintainers.
> > > > >
> > > > > This patchset aims to solve these problems by:
> > > > > 1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1.c file,
> > > > > 2) putting definitions shared by memcontrol.c and memcontrol-v1.c into the
> > > > >    mm/internal.h header
> > > > > 3) introducing the CONFIG_MEMCG_V1 config option, turned on by default
> > > > > 4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set
> > > > > 5) putting unused struct memory_cgroup and task_struct members under
> > > > >    CONFIG_MEMCG_V1 as well.
> > > > >
> > > > > This is an RFC version, which is not 100% polished yet, so but it would be great
> > > > > to discuss and agree on the overall approach.
> > > > >
> > > > > Some open questions, opinions are appreciated:
> > > > > 1) I consider renaming non-static functions in memcontrol-v1.c to have
> > > > >    mem_cgroup_v1_ prefix. Is this a good idea?
> > > > > 2) Do we want to extend it beyond the memory controller? Should
> > > > > 3) Is it better to use a new include/linux/memcontrol-v1.h instead of
> > > > >    mm/internal.h? Or mm/memcontrol-v1.h.
> > > > >
> > > >
> > > > Hi Roman,
> > > >
> > > > A very timely and important topic and we should definitely talk about it
> > > > during LSFMM as well. I have been thinking about this problem for quite
> > > > sometime and I am getting more and more convinced that we should aim to
> > > > completely deprecate memcg-v1.
> > > >
> > > > More specifically:
> > > >
> > > > 1. What are the memcg-v1 features which have no alternative in memcg-v2
> > > > and are blocker for memcg-v1 users? (setting aside the cgroup v2
> > > > structual restrictions)
> > > >
> > > > 2. What are unused memcg-v1 features which we should start deprecating?
> > > >
> > > > IMO we should systematically start deprecating memcg-v1 features and
> > > > start unblocking the users stuck on memcg-v1.
> > > >
> > > > Now regarding the proposal in this series, I think it can be a first
> > > > step but should not give an impression that we are done. The only
> > > > concern I have is the potential of "out of sight, out of mind" situation
> > > > with this change but if we keep the momentum of deprecation of memcg-v1
> > > > it should be fine.
> > > >
> > > > I have CCed Greg and David from Google to get their opinion on what
> > > > memcg-v1 features are blocker for their memcg-v2 migration and if they
> > > > have concern in deprecation of memcg-v1 features.
> > > >
> > > > Anyone else still on memcg-v1, please do provide your input.
> > >
> > > Hi Shakeel,
> > >
> > > Hopefully I'm not too late.  We are currently using memcg v1.
> > >
> > > One specific feature we rely on in v1 is skmem accounting. In v1, we
> > > account for TCP memory usage without charging it to memcg v1, which is
> > > useful for monitoring the TCP memory usage generated by tasks running
> > > in a container. However, in memcg v2, monitoring TCP memory requires
> > > charging it to the container, which can easily cause OOM issues. It
> > > would be better if we could monitor skmem usage without charging it in
> > > the memcg v2, allowing us to account for it without the risk of
> > > triggering OOM conditions.
> >
> > Hi Yafang,
> >
> > the data itself is available on cgroup v2 in memory.stat:sock, however
> > you're right, it's charged on pair with other types of memory. It was
> > one of the main principles of cgroup v2's memory controller, so I don't
> > think it can be changed.
> >
> > So the feature you need is not skmem accounting, but something quite
> > opposite :)
> >
> > The question I have here: what makes socket memory different here?
> >
> > Is it something specific to your setup (e.g. you mostly use memory.max
> > to protect against memory leaks in the userspace code, but socket memory
> > spikes are always caused by external traffic and are legit) or we have
> > more fundamental problems with the socket memory handling, e.g. we can't
> > effectively reclaim it under the memory pressure?
> 
> It is the first case.
> 
> >
> > In the first case you can maintain a ~2-lines non-upstream patch which will
> > disable the charging while maintaining statistics - it's not a perfect, but
> > likely the best option here. In the second case we need collectively fix it
> > for cgroup v2.
> >
> 
> Thank you for your advice. Currently, we do not have any immediate
> plans to migrate to cgroup v2. If we are required to use cgroup v2 in
> the future, we will need to maintain non-upstream patches.
> 
> By the way, is there any reason we cannot keep this behavior
> consistent with memcg v1 in the upstream kernel? That would save us
> from having to maintain it locally.

The idea to handle various types of memory independently isn't working well
for most users: it makes the configuration trickier and more fragile.
It's also more expensive in terms of the accounting overhead.

The tcpmem accounting is btw quite expensive by itself. So by switching to
cgroup v2 you might see (depending on your traffic and cpu load) some
nice performance benefits.

Thanks!

