Return-Path: <linux-kernel+bounces-201646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C68FC142
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FE4283795
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA02E3F7;
	Wed,  5 Jun 2024 01:24:28 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF883B1AB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550667; cv=none; b=f3t6tvbCi+MbP+tyuyJzR7pmVKXbz6Er8P8ewRvw1FMF741IfGF5S1MugcvFJCTjpJiit7bYyjZIrmc4Qjcv0R06Y75xhjThSrfa+RhnaYTpu60AM2btXUtldm2wstthJFs6+aIAxNWHKU3/DUqDbafN9TgxYosLP6PLON9HBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550667; c=relaxed/simple;
	bh=T8O06QjdZh1D+PRba0p4yzaAuU3zp3tbAtxFbEiiGNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oorOK5pSXIyMGq0bm6JOw4rDfVaCk/udrhtCdjm4sZZLC6fMTsRsvoEu57mrC6BNtQvUKpw0ZmCoqOAhcoMdFHjEU0buKCU00yK4kETT3W1+Nno7H6uUjKYSNLquwoVqwfPJEhCZ5U8BqP7stFP5VFBZxO9lSWVbKpDm3UbBeSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-f1-665fbe422db8
Date: Wed, 5 Jun 2024 10:24:12 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, iamjoonsoo.kim@lge.com,
	rientjes@google.com
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240605012412.GA75311@system.software.com>
References: <20240604072323.10886-1-byungchul@sk.com>
 <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604084533.GA68919@system.software.com>
 <8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604091221.GA28034@system.software.com>
 <20240604102516.GB28034@system.software.com>
 <20240604122927.GA1992@cmpxchg.org>
 <20240605002114.GA23651@system.software.com>
 <87y17kb3xm.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y17kb3xm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnoa7Tvvg0g6aznBZz1q9hs1i9yddi
	ZXczm8XlXXPYLO6t+c9q0bZkI5PFyVmTWRzYPQ6/ec/ssWBTqcfiPS+ZPDZ9msTu0fX2CpPH
	iRm/WTw+b5ILYI/isklJzcksSy3St0vgyji/bTNbwRSzisNrrjI2MM7Q7GLk5JAQMJHoO3qf
	Ccbe2rSNHcRmEVCR+Nm7kw3EZhNQl7hx4ycziC0ioCHxaeFyoBouDmaBg4wSjU9vAzVzcAgL
	pEoc3x4AUsMrYCHR0LGSBaRGSGAzs8SujreMEAlBiZMzn7CA2MwCWhI3/r0E62UWkJZY/o8D
	JMwpYCfRuX4m2C5RAWWJA9uOQ922h01izoZ6CFtS4uCKGywTGAVmIZk6C8nUWQhTFzAyr2IU
	yswry03MzDHRy6jMy6zQS87P3cQIDPVltX+idzB+uhB8iFGAg1GJh3fHr7g0IdbEsuLK3EOM
	EhzMSiK8fsXxaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4
	pRoY1Y+fOrb/nhuLyts1/J+zfFh3ZrKwdZ1PUtmwIKa340dbn+/BXPGpSbxpj9bI2v5QS5z9
	sF878Tpnh8j6nrpNksEZ76XO1JWc/djEI7+3KvKZ9d4sua7quaaZajsmLpKa/1t/zZnmqcve
	qHtcZnG1nb96q1LBGp63Jx/a6NzyyFsmanRmydEEJZbijERDLeai4kQA/eZ7aXECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXC5WfdrOu4Lz7NYNMtG4s569ewWaze5Gux
	sruZzeLw3JOsFpd3zWGzuLfmP6tF25KNTBYnZ01mceDwOPzmPbPHgk2lHov3vGTy2PRpErtH
	19srTB4nZvxm8Vj84gOTx+dNcgEcUVw2Kak5mWWpRfp2CVwZ57dtZiuYYlZxeM1VxgbGGZpd
	jJwcEgImElubtrGD2CwCKhI/e3eygdhsAuoSN278ZAaxRQQ0JD4tXA5Uw8XBLHCQUaLx6W2m
	LkYODmGBVInj2wNAangFLCQaOlaygNQICWxmltjV8ZYRIiEocXLmExYQm1lAS+LGv5dgvcwC
	0hLL/3GAhDkF7CQ6188E2yUqoCxxYNtxpgmMvLOQdM9C0j0LoXsBI/MqRpHMvLLcxMwcU73i
	7IzKvMwKveT83E2MwNBdVvtn4g7GL5fdDzEKcDAq8fDu+BWXJsSaWFZcmXuIUYKDWUmE1684
	Pk2INyWxsiq1KD++qDQntfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qBUbNNYUtn
	zXKtyUV39sqoa/VJFWwS4XpweELuoo8iNpWM74J8S60vCm/88b5l0W3lOnVb7r1NbEX7l3C8
	npz/tvyN9c319VIbU6xvz9+lrdb8NpZxb161ztXPhmdbttbX2s7jn309Z730C9P5IZY3d2x2
	WhLa+k3LdRvfgTdRd5a5n2G/e0N+jxJLcUaioRZzUXEiABbSl6dZAgAA
X-CFilter-Loop: Reflected

On Wed, Jun 05, 2024 at 08:59:01AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Tue, Jun 04, 2024 at 08:29:27AM -0400, Johannes Weiner wrote:
> >> On Tue, Jun 04, 2024 at 07:25:16PM +0900, Byungchul Park wrote:
> >> > On Tue, Jun 04, 2024 at 06:12:22PM +0900, Byungchul Park wrote:
> >> > > On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
> >> > > > Byungchul Park <byungchul@sk.com> writes:
> >> > > > 
> >> > > > > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
> >> > > > >> Byungchul Park <byungchul@sk.com> writes:
> >> > > > >> 
> >> > > > >> > Changes from v1:
> >> > > > >> > 	1. Don't allow to resume kswapd if the system is under memory
> >> > > > >> > 	   pressure that might affect direct reclaim by any chance, like
> >> > > > >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
> >> > > > >> >
> >> > > > >> > --->8---
> >> > > > >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
> >> > > > >> > From: Byungchul Park <byungchul@sk.com>
> >> > > > >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
> >> > > > >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
> >> > > > >> >
> >> > > > >> > A system should run with kswapd running in background when under memory
> >> > > > >> > pressure, such as when the available memory level is below the low water
> >> > > > >> > mark and there are reclaimable folios.
> >> > > > >> >
> >> > > > >> > However, the current code let the system run with kswapd stopped if
> >> > > > >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
> >> > > > >> > until direct reclaim will do for that, even if there are reclaimable
> >> > > > >> > folios that can be reclaimed by kswapd.  This case was observed in the
> >> > > > >> > following scenario:
> >> > > > >> >
> >> > > > >> >    CONFIG_NUMA_BALANCING enabled
> >> > > > >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >> > > > >> >    numa node0 (500GB local DRAM, 128 CPUs)
> >> > > > >> >    numa node1 (100GB CXL memory, no CPUs)
> >> > > > >> >    swap off
> >> > > > >> >
> >> > > > >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
> >> > > > >> >    2) Continue adding the same workload to the system.
> >> > > > >> >    3) The anon pages are placed in node0 by promotion/demotion.
> >> > > > >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
> >> > > > >> >    5) Kill the memory hoggers to restore the system.
> >> > > > >> >
> >> > > > >> > After restoring the system at 5), the system starts to run without
> >> > > > >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
> >> > > > >> > the mechanism relies on kswapd for demotion.
> >> > > > >> 
> >> > > > >> We have run into the situation that kswapd is kept in failure state for
> >> > > > >> long in a multiple tiers system.  I think that your solution is too
> >> > > > >
> >> > > > > My solution just gives a chance for kswapd to work again even if
> >> > > > > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
> >> > > > > reclaimable folios.  That's it.
> >> > > > >
> >> > > > >> limited, because OOM killing may not happen, while the access pattern of
> >> > > > >
> >> > > > > I don't get this.  OOM will happen as is, through direct reclaim.
> >> > > > 
> >> > > > A system that fails to reclaim via kswapd may succeed to reclaim via
> >> > > > direct reclaim, because more CPUs are used to scanning the page tables.
> >> > > > 
> >> > > > In a system with NUMA balancing based page promotion and page demotion
> >> > > > enabled, page promotion will wake up kswapd, but kswapd may fail in some
> >> > > > situations.  But page promotion will no trigger direct reclaim or OOM.
> >> > > > 
> >> > > > >> the workloads may change.  We have a preliminary and simple solution for
> >> > > > >> this as follows,
> >> > > > >> 
> >> > > > >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
> >> > > > >
> >> > > > > Whether tiering is involved or not, the same problem can arise if
> >> > > > > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
> >> > > > 
> >> > > > Your description is about tiering too.  Can you describe a situation
> >> > > 
> >> > > I mentioned "tiering" while I described how to reproduce because I ran
> >> > > into the situation while testing with tiering system but I don't think
> >> > > it's the necessary condition.
> >> > > 
> >> > > Let me ask you back, why the logic to stop kswapd was considered in the
> >> > > first place?  That's because the problem was already observed anyway
> >> > 
> >> > To be clear..
> >> > 
> >> > The problem, kswapd_failures >= MAX_RECLAIM_RETRIES, can happen whether
> >> > tiering is involved not not.  Once kswapd stops, the system should run
> >> > without kswapd even after recovered e.g. by killing the hoggers.  *Even
> >> > worse*, tiering mechanism doesn't work in this situation.
> >> 
> >> But like Ying said, in other situations it's direct reclaim that kicks
> >> in and clears the flag.
> >
> > I already described it in the commit message.
> >
> >> The failure-sleep and direct reclaim triggered recovery have been in
> >
> > Sure.  It's better than nothing.
> >
> >> place since 2017. Both parties who observed an issue with it recently
> >> did so in tiering scenarios. IMO a tiering-specific solution makes the
> >> most sense.
> >
> > So..  Is the follow situation in a non-tiering system okay?  Really?
> >
> >    A system runs with kswapd disabled unless hitting min water mark,
> >    even if there might be something that kswapd can work on.
> >
> > I don't undertand why it's okay.  Could you explain more?  Then why do
> > we use kswapd in background?
> 
> IIUC, it's okey.  One direct reclaiming will be triggered, then kswapd
> reclaiming will be recovered.  So, the performance will not be
> influenced much.

So is it because the performance will not be influenced much?  Hm..  the
system would get impacted at the moment when direct reclaim gets
triggerred, even though kswapd can mitigate the impact proactively.

However, I don't want to insist strongly if you all consider it's okay.

Changing the topic to tiering, which one looks better between two
appoaches to solve the issue that tiering doens't work once the failures
hit MAX_RECLAIM_RETRIES:

   1) periodically run kswapd
   2) run kswapd if there might be reclaimable folios as this patch does

For 2), this patch should be modified a lil bit tho.

	Byungchul

> Do you think that this will impact performance?  If so, please try to
> prove it with test results.
> 
> --
> Best Regards,
> Huang, Ying

