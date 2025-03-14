Return-Path: <linux-kernel+bounces-561569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 713EAA61395
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3EC88015B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7AE200BB5;
	Fri, 14 Mar 2025 14:24:21 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8C1FF5EB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962261; cv=none; b=ttSUCk+inW51lpA6CRYf9ou9HabuFSPmLSb5SQPxuHRiAM28nrFxKSm7vupA6xwzYHYrvMfbeuY4ZTB2nDxzkZzd7j3X9x3S8c1N351POTouO1o6oxT3hhTgYiHRCLB8pyn6dwRxLi2iik4CNdNKoBADSUZRwDQqpE84sWCyuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962261; c=relaxed/simple;
	bh=kYyJLmSymRZAmh2EhKWsFiv6RQFJTIzx/aENnxg8Zgw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eP/bK65P0Vw+zkyQUVRJuOWsvNXjZfkmaeuHwTLtbJIMTBF+vpbF6e3JKmADLxIpylvYZnOa7as3RLeOEXFHJ8j1Y8f8TSZiX7PFEqloRElnIyk21DQqC0m24dgDJTn2hFy6/q68ZF+Nzg7+yVsOnU63sxQT3B2+4AujEpGiJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDml235Zjz6J9YF;
	Fri, 14 Mar 2025 22:21:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B9D9140155;
	Fri, 14 Mar 2025 22:24:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 15:24:13 +0100
Date: Fri, 14 Mar 2025 14:24:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
CC: Raghavendra K T <raghavendra.kt@amd.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <lsf-pc@lists.linux-foundation.org>,
	<bharata@amd.com>, <gourry@gourry.net>, <nehagholkar@meta.com>,
	<abhishekd@meta.com>, <nphamcs@gmail.com>, <hannes@cmpxchg.org>,
	<feng.tang@intel.com>, <kbusch@meta.com>, <Hasan.Maruf@amd.com>,
	<sj@kernel.org>, <david@redhat.com>, <willy@infradead.org>,
	<k.shutemov@gmail.com>, <mgorman@techsingularity.net>, <vbabka@suse.cz>,
	<hughd@google.com>, <rientjes@google.com>, <shy828301@gmail.com>,
	<liam.howlett@oracle.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <shivankg@amd.com>, <ziy@nvidia.com>,
	<jhubbard@nvidia.com>, <AneeshKumar.KizhakeVeetil@arm.com>,
	<linux-kernel@vger.kernel.org>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <Michael.Day@amd.com>, <riel@surriel.com>,
	<weixugc@google.com>, <leesuyeon0506@gmail.com>, <honggyu.kim@sk.com>,
	<leillc@google.com>, <kmanaouil.dev@gmail.com>, <rppt@kernel.org>,
	<dave.hansen@intel.com>
Subject: Re: [LSF/MM/BPF TOPIC] Unifying sources of page temperature
 information - what info is actually wanted?
Message-ID: <20250314142412.00001689@huawei.com>
In-Reply-To: <87h64u2xkh.fsf@DESKTOP-5N7EMDA>
References: <20250123105721.424117-1-raghavendra.kt@amd.com>
	<20250131122803.000031aa@huawei.com>
	<20250131130901.00000dd1@huawei.com>
	<87h64u2xkh.fsf@DESKTOP-5N7EMDA>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 16 Feb 2025 14:49:50 +0800
"Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Hi, Jonathan,
> 
> Sorry for late reply.

Sorry for even later reply!

> 
> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > On Fri, 31 Jan 2025 12:28:03 +0000
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >  
> >> > Here is the list of potential discussion points:    
> >> ...
> >>   
> >> > 2. Possibility of maintaining single source of truth for page hotness that would
> >> > maintain hot page information from multiple sources and let other sub-systems
> >> > use that info.    
> >> Hi,
> >> 
> >> I was thinking of proposing a separate topic on a single source of hotness,
> >> but this question covers it so I'll add some thoughts here instead.
> >> I think we are very early, but sharing some experience and thoughts in a
> >> session may be useful.  
> >
> > Thinking more on this over lunch, I think it is worth calling this out as a
> > potential session topic in it's own right rather than trying to find
> > time within other sessions.  Hence the title change.
> >
> > I think a session would start with a brief listing of the temperature sources
> > we have and those on the horizon to motivate what we are unifying, then
> > discussion to focus on need for such a unification + requirements 
> > (maybe with a straw man).
> >  
> >> 
> >> What do the other subsystems that want to use a single source of page hotness
> >> want to be able to find out? (subject to filters like memory range, process etc)
> >> 
> >> A) How hot is page X?  
> >> - Is this useful, or too much data? What would use it?
> >>   * Application optimization maybe. Very handy for developing algorithms
> >>     to do the rest of the options here as an Oracle!
> >> - Provides both the cold and hot end of the scale, but maybe measurement
> >>   techniques vary and can not be easily combined. Hard in general to combine
> >>   multiple sources of truth if aiming for an absolute number.
> >> 
> >> B) Which pages are super hot?
> >> - Probably these that make the most difference if they are in a slower memory tier.
> >> 
> >> C) Some pages are hot enough to consider moving?
> >> - This may be good enough to get the key data into the fast memory over time.
> >> - Can combine sources of info as being able to compare precise numbers doesn't matter.
> >> 
> >> D) Which pages are fairly cold?
> >> - Likewise maybe good enough over time.
> >> 
> >> E) Which pages are very cold?
> >> - Ideal case for tiering. Swap these with the super hot ones.
> >> - Maybe extra signal for swap / zswap etc
> >> 
> >> F) Did these hot pages remain hot (and same for cold)
> >> - This is needed to know when to back off doing things as we have unstable
> >>   hotness (two phase applications are a pain for this), sampling a few
> >>   pages may be fine.
> >> 
> >> Messy corners:
> >> 
> >> Temporal aspects.
> >> - If only providing lists of hottest / coldest in last second, very hard
> >>   to find those that are of a stable temperature. We end up moving
> >>   very hot data (which is disruptive) and it doesn't stay hot.
> >> - Can reduce that affect by long sampling windows on some measurement approaches
> >>   (on hardware trackers that can trash accuracy due to resource exhaustion
> >>    and other subtle effects).
> >> - bistable / phase based applications are a pain but perhaps up to higher
> >>   levels to back off.
> >> 
> >> My main interest is migrating in tiered systems but good to look at what
> >> else would use a common layer.
> >> 
> >> Mostly I want to know something that is useful to move, and assume convergence
> >> over the long term with the best things to move so to me the ideal layer has
> >> following interface (strawman so shoot holes in it!):
> >> 
> >> 1) Give me up to X hotish pages from a slow tier (greater than a specific measure
> >> of temperature)  
> 
> Because the hot pages may be available upon page accessing (such PROT_NONE
> page fault), the interface may be "push" style instead of "pull" style,
> e.g.,

Absolutely agree that might be the approach, but with some form of back pressure
as for at least some approaches it is much cheaper to find a find a few hot
pages than to find lots of them.  More complex if you want a few of the very hottest
or just hotter than X. 

> 
> int register_hot_page_handler(void (*handler)(struct page *hot_page, int temperature));
> 
> >> 2) Give me X coldish pages a faster tier.
> >> 3) I expect to ask again in X seconds so please have some info ready for me!
> >> 4) (a path to get an idea of 'unhelpful moves' from earlier iterations - this
> >>     is bleeding the tiering application into a shared interface though).  
> 
> In addition to get a list hot/cold pages, it's also useful to get
> hot/cold statistics of a memory device (NUMA node), e.g., something like
> below,
> 
> Access frequency        percent
>    > 1000 HZ            10%  
>  600-1000 HZ            20%
>  200- 600 HZ            50%
>    1- 200 HZ            15%
>       < 1 HZ             5%
> 
> Compared with hot/cold pages list, this may be gotten with lower
> overhead and can be useful to tune the promotion/demotion alrogithm.  At
> the same time, a sampled (incomplete) list of hot/cold page list may be
> available too.

I agree it's useful info and 'might' be cheaper to get.  Depends on the
tracking solution and impacts of sampling approaches.

> 
> >> If we have multiple subsystems using the data we will need to resolve their
> >> conflicting demands to generate good enough data with appropriate overhead.
> >> 
> >> I'd also like a virtualized solution for case of hardware PA trackers (what
> >> I have with CXL Hotness Monitoring Units) and classic memory pool / stranding
> >> avoidance case where the VM is the right entity to make migration decisions.
> >> Making that interface convey what the kernel is going to use would be an
> >> efficient option. I'd like to hide how the sausage was made from the VM.  
> 
> ---
> Best Regards,
> Huang, Ying


