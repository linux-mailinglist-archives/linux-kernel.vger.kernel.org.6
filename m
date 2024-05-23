Return-Path: <linux-kernel+bounces-187946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C18CDB20
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069811F22E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D118C84A4F;
	Thu, 23 May 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R+CIzOY+"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67C2AD00
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494157; cv=none; b=hp0ObU38YGSu0ySHzVkV9GUfZ5wlLpRdmi8Ng50SYixwHTZWtUAP742/i3R3R8EFyZybVSsssN4FuZN+DHXSGQ6sDwob1Hvh7oKV50HQPwHxCip2l1ygKTx2R9wl2OrHF4GwC8OmmnOeTrSK3yB+KX2Fe/AN7Cg/VOLzDzo9Oos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494157; c=relaxed/simple;
	bh=RNUrENHzVDWSGEhPxHBy8HHaJ/WPAYKrnsnljmpDJWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnD/nRVy91Fs5jnqyzgPTEGJVE3mvTkuY4oboRlLu451dcC2OMxGSZRYMMDMvn6FS9eeKrujRMpJ8DVoIxZlv1Ss4MSUkCUdND+XOLl5THGQdo5GyCLoOZd+PNupST8OoxIUuwwF1GecUyzYLHs28IXpi903pnIhyxGILSAZtPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R+CIzOY+; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ryncsn@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716494152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfhkEzWabknfi/ShuVBS0FWHdosprJqhhLCoPMo+WAI=;
	b=R+CIzOY+P1dVjCcgGIclYcx9Ar6XmcGgx2OC/vPyjecvjUv3j810uDfQAczcRgk9EjKJYP
	F8lOyXOcRGA/m0Is3BcHwegpdQxx9ua8T0QScHaLDm1DKtcVipSIOS3dHlkM6Mif/2EIF5
	aGcVkB9dUi6xyXqQ+XSuiJ5mqq+SL04=
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: gthelen@google.coma
X-Envelope-To: rientjes@google.com
X-Envelope-To: chrisl@kernel.org
Date: Thu, 23 May 2024 12:55:46 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kairui Song <ryncsn@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gthelen@google.coma,
	rientjes@google.com, Chris Li <chrisl@kernel.org>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <Zk-fQtFrj-2YDJOo@P9FQF9L96D.corp.robot.car>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
 <CAMgjq7ARr0=OG8GQOJvzLtfdrtiwvJ19-mx1snxqmLE0Za+QCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7ARr0=OG8GQOJvzLtfdrtiwvJ19-mx1snxqmLE0Za+QCw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 23, 2024 at 01:58:49AM +0800, Kairui Song wrote:
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
> >
> 
> Hi,
> 
> Sorry for joining the discussion late, but I'd like to add some info
> here: We are using the "memsw" feature a lot. It's a very useful knob
> for container memory overcommitting: It's a great abstraction of the
> "expected total memory usage" of a container, so containers can't
> allocate too much memory using SWAP, but still be able to SWAP out.
> 
> For a simple example, with memsw.limit == memory.limit, containers
> can't exceed their original memory limit, even with SWAP enabled, they
> get OOM killed as how they used to, but the host is now able to
> offload cold pages.
> 
> Similar ability seems absent with V2: With memory.swap.max == 0, the
> host can't use SWAP to reclaim container memory at all. But with a
> value larger than that, containers are able to overuse memory, causing
> delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
> out of balance, especially with compress SWAP backends.
> 
> Cgroup accounting of ZSWAP/ZRAM doesn't really help, we want to
> account for the total raw usage, not the compressed usage. One example
> is that if a container uses tons of duplicated pages, then it can
> allocate much more memory than it is limited, that could cause
> trouble.

So you don't need separate swap knobs, only combined, right?

> I saw Chris also mentioned Google has a workaround internally for it
> for Cgroup V2. This will be a blocker for us and a similar workaround
> might be needed. It will be great so see an upstream support for this.

I think that _at least_ we should refactor the code so that it would
be a minimal patch (e.g. one #define) to switch to the old mode.

I don't think it's reasonable to add a new interface, but having a
patch/config option or even a mount option which changes the semantics
of memory.swap.max to the v1-like behavior should be ok.

I'll try to do the first part (refactoring this code), and we can have
a discussion from there.

Thanks!

