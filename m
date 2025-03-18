Return-Path: <linux-kernel+bounces-566803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB01A67CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FF219C3808
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A74A2135AD;
	Tue, 18 Mar 2025 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I5KpBv8Q"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358C1CAA8E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324768; cv=none; b=SX+7fnx1Arg87C1NTquDcpk7vtWK8bUq1rhl2EakVmnvE7P4saNBkRa/Gg2rwIGkiGEgZgeElszFHKAXLEccbmhE4IwAexp7klxAPz9PtPiQf0cFkCcxGzKw3yIhHG7uLgpOauj/1vpXypFRGSgA0Bc2C95q7LWb4D4g6vwKyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324768; c=relaxed/simple;
	bh=8XPmIKWyWUWyux7sr4s1NTbxSXJNmP2bbDbjHkMToYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIuHc119ndZ8UidwxW/9OcGlZbEa5MCqt2BCtVzjtfT1SHpjOScgeL/9ZGt7wH6+qkbxOxERGr+ghHI4YYJrNkEMOyjnaFgVaT9BMH7PmmiGEhEYlfj6hhwNs4Om41Tz5q0jYdzuAmvFJx/GALiq4/y8gmjYaZ4gzPDY5juwu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I5KpBv8Q; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 19:05:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742324752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J2Q8ocPjDBMVKUqEppccDXJMqybpN7dBYUYJcL32qdo=;
	b=I5KpBv8QfA1qKPkKInQ1U02juIMwiFOD06uxCIfBYgkZSA/SytIxOBXt+Z68DJOpR99bZA
	hfgDCtio7RSKGgeqbXtJexSo7mNBtY7NFPR9a69JF3W0jnIO+h3pSmmGRMRa8esATSY87x
	aPVVAQTlXzs+w5ZK6a9fkgEfgj82QWg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"surenb@google.com" <surenb@google.com>,
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v8 12/14] mm: zswap: Simplify acomp_ctx resource
 allocation/deletion and mutex lock usage.
Message-ID: <Z9nECMZW67F8XYoV@google.com>
References: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
 <20250303084724.6490-13-kanchana.p.sridhar@intel.com>
 <Z8n5CCmELvpUwi3B@google.com>
 <PH8SPRMB004414B5E1E0765C18F9A89DC9D52@PH8SPRMB0044.namprd11.prod.outlook.com>
 <Z8tJOi5G_3dpK31v@google.com>
 <PH8SPRMB00447B066A769C76F57F8800C9D42@PH8SPRMB0044.namprd11.prod.outlook.com>
 <Z88h1mPkYNM6yOGE@google.com>
 <SA3PR11MB812082535F1E6D63BC0F1412C9DF2@SA3PR11MB8120.namprd11.prod.outlook.com>
 <Z9mB5IbNEdNdtmUp@google.com>
 <SA3PR11MB81206531E9B3C7F13F5740A2C9DE2@SA3PR11MB8120.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA3PR11MB81206531E9B3C7F13F5740A2C9DE2@SA3PR11MB8120.namprd11.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 18, 2025 at 05:38:49PM +0000, Sridhar, Kanchana P wrote:
[..]
> > > Thanks Yosry, for this observation! You are right, when considered purely
> > > from a CPU hotplug perspective, zswap_cpu_comp_prepare() and
> > > zswap_cpu_comp_dead() in fact run on a control CPU, because the state is
> > > registered in the PREPARE section of "enum cpuhp_state" in cpuhotplug.h.
> > >
> > > The problem however is that, in the current architecture, CPU onlining/
> > > zswap_pool creation, and CPU offlining/zswap_pool deletion have the
> > > same semantics as far as these resources are concerned. Hence, although
> > > zswap_cpu_comp_prepare() is run on a control CPU, the CPU for which
> > > the "hotplug" code is called is in fact online. It is possible for the memory
> > > allocation calls in zswap_cpu_comp_prepare() to recurse into
> > > zswap_compress(), which now needs to be handled by the current pool,
> > > since the new pool has not yet been added to the zswap_pools, as you
> > > pointed out.
> > >
> > > The ref on the current pool has not yet been dropped. Could there be
> > > a potential for a deadlock at pool transition time: the new pool is blocked
> > > from allocating acomp_ctx resources, triggering reclaim, which the old
> > > pool needs to handle?
> > 
> > I am not sure how this could lead to a deadlock. The compression will be
> > happening in a different pool with a different acomp_ctx.
> 
> I was thinking about this from the perspective of comparing the trade-offs
> between these two approaches:
> a) Allocating acomp_ctx resources for a pool when a CPU is functional, vs.
> b) Allocating acomp_ctx resources once upfront.
> 
> With (a), when the user switches zswap to use a new compressor, it is possible
> that the system is already in a low memory situation and the CPU could be doing
> a lot of swapouts. It occurred to me that in theory, the call to switch the
> compressor through the sysfs interface could never return if the acomp_ctx
> allocations trigger direct reclaim in this scenario. This was in the context of
> exploring if a better design is possible, while acknowledging that this could still
> happen today.

If the system is already in a low memory situation a lot of things will
hang. Switching the compressor is not a common operation at all and we
shouldn't really worry about that. Even if we remove the acomp_ctx
allocation, we still need to make some allocations in that path anyway.

> 
> With (b), this situation is avoided by design, and we can switch to a new pool
> without triggering additional reclaim. Sorry, I should have articulated this better.

But we have to either allocate more memory unnecessarily or add config
options and make batching a build-time decision. This is unwarranted
imo.

FWIW, the mutexes and buffers used to be per-CPU not per-acomp_ctx, but
they were changed in commit 8ba2f844f050 ("mm/zswap: change per-cpu
mutex and buffer to per-acomp_ctx"). What you're suggesting is not quite
the same as what we had before that commit, it's moving the acomp_ctx
itself to be per-CPU but not per-pool, including the mtuex and buffer.
But I thought the context may be useful.

[..]
> > > 7) To address the issue of how many reqs/buffers to allocate, there could
> > >      potentially be a memory cost for non-batching compressors, if we want
> > >      to always allocate ZSWAP_MAX_BATCH_SIZE acomp_reqs and buffers.
> > >      This would allow the acomp_ctx to seamlessly handle batching
> > >      compressors, non-batching compressors, and transitions among the
> > >      two compressor types in a pretty general manner, that relies only on
> > >      the ZSWAP_MAX_BATCH_SIZE, which we define anyway.
> > >
> > >      I believe we can maximize the chances of success for the allocation of
> > >      the acomp_ctx resources if this is done in zswap_setup(), but please
> > >      correct me if I am wrong.
> > >
> > >      The added memory cost for platforms without IAA would be
> > >      ~57 KB per cpu, on x86. Would this be acceptable?
> > 
> > I think that's a lot of memory to waste per-CPU, and I don't see a good
> > reason for it.
> 
> Yes, it appears so. Towards trying to see if a better design is possible
> by de-coupling the acomp_ctx from zswap_pool:
> Would this cost be acceptable if it is incurred based on a build config
> option, saying CONFIG_ALLOC_ZSWAP_BATCHING_RESOURCES (default OFF)?
> If this is set, we go ahead and allocate ZSWAP_MAX_BATCH_SIZE
> acomp_ctx resources once, during zswap_setup(). If not, we allocate
> only one req/buffer in the global percpu acomp_ctx? 

We should avoid making batching a build time decision if we can help it.
A lot of kernels are shipped to different hardware that may or may not
support batching, so users will have to either decide to turn off
batching completely or eat the overhead even for hardware that does not
support batching (or for users that use SW compression).

[..] 
> > >
> > >     The only other fallback solution in lieu of the proposed simplification that
> > >     I can think of is to keep the lifespan of these resources from pool creation
> > >     to deletion, using the CPU hotplug code. Although, it is not totally clear
> > >     to me if there is potential for deadlock during pool transitions, as noted
> > above.
> > 
> > I am not sure what's the deadlock scenario you're worried about, please
> > clarify.
> 
> My apologies: I was referring to triggering direct reclaim during pool creation,
> which could, in theory, run into a scenario where the pool switching would
> have to wait for reclaim to free up enough memory for the acomp_ctx
> resources allocation: this could cause the system to hang, but not a deadlock.
> This can happen even today, hence trying to see if a better design is possible.

I think the concern here is unfounded. We shouldn't care about the
performance of zswap compressor switching, especially under memory
pressure. A lot of things will slow down under memory pressure, and
compressor switching should be the least of our concerns.

