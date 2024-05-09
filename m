Return-Path: <linux-kernel+bounces-174734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7C08C1416
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284C2282513
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE41B5B1;
	Thu,  9 May 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y0/Jv7Ws"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6715C1862E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275838; cv=none; b=EY06T++Ud4G4AR3WXs/J8X57j03r46SRdorxOfjFfZqSmBen+smZF8RE4bXW6tplDP3vPHGYHDLJpHib93duW0H4G6hizurKWgpuMSTBFx8PTPG3px+2Fggmc0YIK9te8D0PlgLUSPFOaHIOB5bI7a6/L9DTSdqI4s8ek/7PKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275838; c=relaxed/simple;
	bh=2uAPY9ms+M8GoWzEQnUFJ2ui/xPeyqfggeUwN7CALoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H72U3CaIitiFfcdpE84VNzPJfjcu9PTaxyCPazU8wymEd4oVxsmawbt4zy75vH5hXyHMct4dDKcldHKAfRDSzLGzwbE1DKmhZQYW1nAKGNhSCg8bcjdOBO8MLMsANMtI1+cP8Jmw3VWLAPAGWrzXsU2enX7+B7P1FkwzvW1fSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y0/Jv7Ws; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 May 2024 10:30:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715275834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CR5MI5JJxqhgz4d1vy4O0Yhzl9P6rPqnDar/P7tXMBE=;
	b=Y0/Jv7WsJjKtJjtcykMElMphU2520hoRqAgMKNsvx6b+RHQCdTDZrZIYnpQ08CEDzf5JWB
	AC5+JBP5H8Xza5UPjHpDLSnwB4itsPjNtWJQnA6bHp0KFA+dvRZJ4HPzUkwj7aCfi4SgQo
	6LpQ2wUMiM4nN0PV1ikYKKF3wDZ4DKY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gthelen@google.coma,
	rientjes@google.com
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <Zj0INDr92x5uuonI@P9FQF9L96D.corp.robot.car>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
X-Migadu-Flow: FLOW_OUT

On Wed, May 08, 2024 at 11:33:07PM -0700, Shakeel Butt wrote:
> On Wed, May 08, 2024 at 08:41:29PM -0700, Roman Gushchin wrote:
> > Cgroups v2 have been around for a while and many users have fully adopted them,
> > so they never use cgroups v1 features and functionality. Yet they have to "pay"
> > for the cgroup v1 support anyway:
> > 1) the kernel binary contains useless cgroup v1 code,
> > 2) some common structures like task_struct and mem_cgroup have never used
> >    cgroup v1-specific members,
> > 3) some code paths have additional checks which are not needed.
> > 
> > Cgroup v1's memory controller has a number of features that are not supported
> > by cgroup v2 and their implementation is pretty much self contained.
> > Most notably, these features are: soft limit reclaim, oom handling in userspace,
> > complicated event notification system, charge migration.
> > 
> > Cgroup v1-specific code in memcontrol.c is close to 4k lines in size and it's
> > intervened with generic and cgroup v2-specific code. It's a burden on
> > developers and maintainers.
> > 
> > This patchset aims to solve these problems by:
> > 1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1.c file,
> > 2) putting definitions shared by memcontrol.c and memcontrol-v1.c into the
> >    mm/internal.h header
> > 3) introducing the CONFIG_MEMCG_V1 config option, turned on by default
> > 4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set
> > 5) putting unused struct memory_cgroup and task_struct members under
> >    CONFIG_MEMCG_V1 as well.
> > 
> > This is an RFC version, which is not 100% polished yet, so but it would be great
> > to discuss and agree on the overall approach.
> > 
> > Some open questions, opinions are appreciated:
> > 1) I consider renaming non-static functions in memcontrol-v1.c to have
> >    mem_cgroup_v1_ prefix. Is this a good idea?
> > 2) Do we want to extend it beyond the memory controller? Should
> > 3) Is it better to use a new include/linux/memcontrol-v1.h instead of
> >    mm/internal.h? Or mm/memcontrol-v1.h.
> > 
> 
> Hi Roman,
> 
> A very timely and important topic and we should definitely talk about it
> during LSFMM as well. I have been thinking about this problem for quite
> sometime and I am getting more and more convinced that we should aim to
> completely deprecate memcg-v1.
> 
> More specifically:
> 
> 1. What are the memcg-v1 features which have no alternative in memcg-v2
> and are blocker for memcg-v1 users? (setting aside the cgroup v2
> structual restrictions)

I don't think there are any, except there might be a certain cost to migrate,
so some companies might be resistant to put in resources, because they don't
see any immediate benefits as well.

> 
> 2. What are unused memcg-v1 features which we should start deprecating?
> 
> IMO we should systematically start deprecating memcg-v1 features and
> start unblocking the users stuck on memcg-v1.

I'm not sure we want to deprecate them one-by-one - it's a lot of work
and maybe we can deprecate it all together instead.

I think the only feature which we might want to deprecate separately -
it's the charge migration. It's the most annoying feature as it requires
a lot more synchronization, which can be dropped otherwise, so it's
complicating a lot of things. Other features are more or less self-contained.

> 
> Now regarding the proposal in this series, I think it can be a first
> step but should not give an impression that we are done.

Yeah, it's really only a first step.

> The only
> concern I have is the potential of "out of sight, out of mind" situation
> with this change but if we keep the momentum of deprecation of memcg-v1
> it should be fine.

My rough plan here:
1) move it out to a separate file and put under a config option, default on
2) clean up all remaining small bits here and there
.. < wait a year >
3) flip the config option to be off by default
.. < wait another year or two >
4) drop the code entirely

> 
> I have CCed Greg and David from Google to get their opinion on what
> memcg-v1 features are blocker for their memcg-v2 migration and if they
> have concern in deprecation of memcg-v1 features.

Thank you!

