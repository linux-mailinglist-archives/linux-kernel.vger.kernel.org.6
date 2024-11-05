Return-Path: <linux-kernel+bounces-395783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185159BC2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9278428299E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00149364AE;
	Tue,  5 Nov 2024 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XH/UGJkC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794A17583
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772280; cv=none; b=iTTYadtaJphgSHjKYu3G2JcyPLdRUOy05i5TEN07eQ5hgco2TLu00Koa7rcWtloIa0eUUII9UJYFbCIxU+uQtg1Es3OObck2W3JNh+FTNri6wKCX1EnCer4c98+kbBO8dVNsTn/ZofHw1fL39GXEOblLeUL4KU7tAeaw3lMk80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772280; c=relaxed/simple;
	bh=SLSWkE6E9RKAffLI8PA1u4xqrbbvNTV8e2Req3pDfwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H/lsF1FA/hepr3CJ+d50ChtGzBR61bjSxVa0gwJdbH2s60UQjxiAIFAoDRK93Jk1onJ6W7PCmYKd7yQ3RT8BhO3oX3hDXWtV8Ue6uUgySrO5GXnawWzbhR+XWnfFb/WxrR0Xw1zzO4hYpSajQu26VPLfREj0Ys/9wnroc19qbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XH/UGJkC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730772274; x=1762308274;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SLSWkE6E9RKAffLI8PA1u4xqrbbvNTV8e2Req3pDfwg=;
  b=XH/UGJkCl/xbPc1Hl8JJ77JsI7b7e8ahmZpXJExycy0+1IMBfuqtesAt
   XXr8dOuQ5PuEk+jumptWhl6gIb0N+TaNBjtroYzuX8n3My1L+/WLFmx5/
   z83iuLBQBmCCvuDZM3UFznty+5hH2Fy4OCtbZrFErgLaaVLINwqn9zDgV
   kzjBbxEGkkt7s05IFQteW24GR/mxay1XOnasdooEw6+697fthvbFceInl
   xLZMQGyR4N7244NNLY+fQbL6JGz3WhQUk2SK0Szpwpsi2SGG5s2/fGhYg
   hFQ7OB1zrX9LHkAT4acXIH2iUjna8vyGFZnVJXxKE64T7PfkYpVhbRLaS
   Q==;
X-CSE-ConnectionGUID: 0nVovKDTRp2Dtf5Okl5Uzg==
X-CSE-MsgGUID: H4hP3o0JRa225X6G7rb13A==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34283261"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="34283261"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 18:04:34 -0800
X-CSE-ConnectionGUID: 5cvHDuQyTxiit0v8Iyf+uw==
X-CSE-MsgGUID: iA7d+4/wSz2O1+rRwHFaSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83725654"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 18:04:32 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  akpm@linux-foundation.org,  david@redhat.com,  nphamcs@gmail.com,
  nehagholkar@meta.com,  abhishekd@meta.com,  Johannes Weiner
 <hannes@cmpxchg.org>,  Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
In-Reply-To: <ZykOqYJpgL4lw7mw@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Mon, 4 Nov 2024 13:12:57 -0500")
References: <20240803094715.23900-1-gourry@gourry.net>
	<875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com>
	<87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZykOqYJpgL4lw7mw@PC2K9PVX.TheFacebook.com>
Date: Tue, 05 Nov 2024 10:00:59 +0800
Message-ID: <87jzdi782s.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Gregory,

Gregory Price <gourry@gourry.net> writes:

> On Mon, Sep 02, 2024 at 02:53:26PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry@gourry.net> writes:
>> 
>> > On Mon, Aug 19, 2024 at 03:46:00PM +0800, Huang, Ying wrote:
>> >> Gregory Price <gourry@gourry.net> writes:
>> >> 
>> >> > Unmapped pagecache pages can be demoted to low-tier memory, but 
>> >> > they can only be promoted if a process maps the pages into the
>> >> > memory space (so that NUMA hint faults can be caught).  This can
>> >> > cause significant performance degradation as the pagecache ages
>> >> > and unmapped, cached files are accessed.
>> >> >
>> >> > This patch series enables the pagecache to request a promotion of
>> >> > a folio when it is accessed via the pagecache.
>> >> >
>> >> > We add a new `numa_hint_page_cache` counter in vmstat to capture
>> >> > information on when these migrations occur.
>> >> 
>> >> It appears that you will promote page cache page on the second access.
>> >> Do you have some better way to identify hot pages from the not-so-hot
>> >> pages?  How to balance between unmapped and mapped pages?  We have hot
>> >> page selection for hot pages.
>> >> 
>> >> [snip]
>> >> 
>> >
>> > I've since explored moving this down under a (referenced && active) check.
>> >
>> > This would be more like promotion on third access within an LRU shrink
>> > round (the LRU should, in theory, hack off the active bits on some decent
>> > time interval when the system is pressured).
>> >
>> > Barring adding new counters to folios to track hits, I don't see a clear
>> > and obvious way way to track hotness.  The primary observation here is 
>> > that pagecache is un-mapped, and so cannot use numa-fault hints.
>> >
>> > This is more complicated with MGLRU, but I'm saving that for after I
>> > figure out the plan for plain old LRU.
>> 
>> Several years ago, we have tried to use the access time tracking
>> mechanism of NUMA balancing to track the access time latency of unmapped
>> file cache folios.  The original implementation is as follows,
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=5f2e64ce75c0322602c2ec8c70b64bb69b1f1329
>> 
>> What do you think about this?
>> 
>
> Coming back around to explore this topic a bit more, dug into this old
> patch and the LRU patch by Keith - I'm struggling find a good option
> that doesn't over-complicate or propose something contentious.
>
>
> I did a browse through lore and did not see any discussion on this patch
> or on Keith's LRU patch, so i presume discussion on this happened largely
> off-list.  So if you have any context as to why this wasn't RFC'd officially
> I would like more information.

Thanks for doing this.  There's no much discussion offline.  We just
don't have enough time to work on the solution.

> My observations between these 3 proposals:
>
> - The page-lock state is complex while trying interpose in mark_folio_accessed,
>   meaning inline promotion inside that interface is a non-starter.
>
>   We found one deadlock during task exit due to the PTL being held. 
>
>   This worries me more generally, but we did find some success changing certain
>   calls to mark_folio_accessed to mark_folio_accessed_and_promote - rather than
>   modifying mark_folio_accessed. This ends up changing code in similar places
>   to your hook - but catches a more conditions that mark a page accessed.
>
> - For Keith's proposal, promotions via LRU requires memory pressure on the lower
>   tier to cause a shrink and therefore promotions. I'm not well versed in LRU
>   LRU sematics, but it seems we could try proactive reclaim here.
>   
>   Doing promote-reclaim and demote/swap/evict reclaim on the same triggers
>   seems counter-intuitive.

IIUC, in TPP paper (https://arxiv.org/abs/2206.02878), a similar method
is proposed for page promoting.  I guess that it works together with
proactive reclaiming.

> - Doing promotions inline with access creates overhead.  I've seen some research
>   suggesting 60us+ per migration - so aggressiveness could harm performance.
>
>   Doing it async would alleviate inline access overheads - but it could also make
>   promotion pointless if time-to-promote is to far from liveliness of the pages.

Async promotion needs to deal with the resource (CPU/memory) charging
too.  You do some work for a task, so you need to charge the consumed
resource for the task.

> - Doing async-promotion may also require something like PG_PROMOTABLE (as proposed
>   by Keith's patch), which will obviously be a very contentious topic.

Some additional data structure can be used to record pages.

> tl;dr: I'm learning towards a solution like you have here, but we may need to
> make a sysfs switch similar to demotion_enabled in case of poor performance due
> to heuristically degenerate access patterns, and we may need to expose some
> form of adjustable aggressiveness value to make it tunable.

Yes.  We may need that, because the performance benefit may be lower
than the overhead introduced.

> Reading more into the code surrounding this and other migration logic, I also
> think we should explore an optimization to mempolicy that tries to aggressively
> keep certain classes of memory on the local node (RX memory and stack
> for example).
>
> Other areas of reclaim try to actively prevent demoting this type of memory, so we
> should try not to allocate it there in the first place.

We have already used DRAM first allocation policy.  So, we need to
measure its effect firstly.

--
Best Regards,
Huang, Ying

