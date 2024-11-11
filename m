Return-Path: <linux-kernel+bounces-403474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC09C3635
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131E8281498
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509D21F94A;
	Mon, 11 Nov 2024 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6JkVyrg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E91B95B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731289126; cv=none; b=tINXlurohCpP3T4H/pJEtqklbdiIdDdAOvL5MgNsikzbfXvgjMVWVgaJdtyohnAO6QHmEjJbFzq7AhEpdxM5MucLkmkRkcNM21Lg0Mh3Zs4th79fymvXTkL71T6gB3I69lFKHYehKXtIfB4bfWN65e5C0iZmGav7MRcsOjiXcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731289126; c=relaxed/simple;
	bh=FsmGo0TppDFqmpjJLXUHDiGAN4OW5nTMnsuhfSTEi8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vx92ry6FP2IOzzb9QuOvk6ydAgRpYBfWXSae7MH2TjEVqBT20/+74RoZfTSlIxVSQqluLwNOBRa3dKj7FYLI7AT9DDRWuwwhEqCmFABNQL4fpgqZfSGsdp7GajQxbQs12pq33gG1gWHzeKzxm4NVrua/uY2hCw5lIBR4GvAiYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6JkVyrg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731289124; x=1762825124;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FsmGo0TppDFqmpjJLXUHDiGAN4OW5nTMnsuhfSTEi8g=;
  b=F6JkVyrghJdNK1sT/7jbSHJKkJL+OJ2z7hjbSJd6qtc6FrDbH3oaEezA
   oYnZDXprJzXZ2XDAmNgqVOs64rDAhTkoNdw7taH2yk0mSwgoV7THax1jQ
   kmBfTiXvrBWtj1L9oSf/r05oKtAKhgCVFkLQz8sjewvrfhA6UjvwLgZoI
   DP/t/VEk0M64E+grBoPKnH8BH6M1wSUNcGIAFpLEcZlqN3MESOPQj6S+z
   2PvEONeTYqC2pmpOAn2GzAnFFINUseQeSxH7zOWDCm1Qst/x8cyvtzZmX
   CyJCXGMoj7sqWZ9VXit6sepfXZbw2gP/CDGRWad6KWHO+auQ0x0CUFgfS
   A==;
X-CSE-ConnectionGUID: C4YiaImDTEqXDOMufulLtA==
X-CSE-MsgGUID: SYBYM6PPRvaL0RVjQdBYjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="18710444"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="18710444"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 17:38:44 -0800
X-CSE-ConnectionGUID: HseMNB7BQnSYUxe62vWldA==
X-CSE-MsgGUID: /M36LMEDQoqNfO82NQOnrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="87043852"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 17:38:42 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  akpm@linux-foundation.org,  david@redhat.com,  nphamcs@gmail.com,
  nehagholkar@meta.com,  abhishekd@meta.com,  Johannes Weiner
 <hannes@cmpxchg.org>,  Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
In-Reply-To: <Zy5R2JvXvhFoJzeY@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Fri, 8 Nov 2024 13:00:56 -0500")
References: <20240803094715.23900-1-gourry@gourry.net>
	<875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com>
	<87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZykOqYJpgL4lw7mw@PC2K9PVX.TheFacebook.com>
	<87jzdi782s.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zy5R2JvXvhFoJzeY@PC2K9PVX.TheFacebook.com>
Date: Mon, 11 Nov 2024 09:35:09 +0800
Message-ID: <871pzi5z8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Tue, Nov 05, 2024 at 10:00:59AM +0800, Huang, Ying wrote:
>> Hi, Gregory,
>> >> 
>> >> Several years ago, we have tried to use the access time tracking
>> >> mechanism of NUMA balancing to track the access time latency of unmapped
>> >> file cache folios.  The original implementation is as follows,
>> >> 
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=5f2e64ce75c0322602c2ec8c70b64bb69b1f1329
>> >> 
>> >> What do you think about this?
>> >> 
>> >
>> > Coming back around to explore this topic a bit more, dug into this old
>> > patch and the LRU patch by Keith - I'm struggling find a good option
>> > that doesn't over-complicate or propose something contentious.
>> >
>> >
>> > I did a browse through lore and did not see any discussion on this patch
>> > or on Keith's LRU patch, so i presume discussion on this happened largely
>> > off-list.  So if you have any context as to why this wasn't RFC'd officially
>> > I would like more information.
>> 
>> Thanks for doing this.  There's no much discussion offline.  We just
>> don't have enough time to work on the solution.
>> 
>
> Exploring and testing this a little further, I brought this up to current
> folio work in 6.9 and found this solution to be unstable as-is.
>
> After some work to fix lock/reference issues, Johannes pointed out that
> __filemap_get_folio can be called from an atomic context - which means it
> may not be safe to do migrations in this context.

Sorry, I don't understand this, the above patch changes
filemap_get_pages() and grab_cache_page_write_begin() instead of
__filemap_get_folio().

> We're back to looking at something like an LRU-esque system, but now we're
> thinking about isolating the folios in folio_mark_accessed into a task-local
> list, and then process the list on resume.

If necessary, we can use a similar method for above solution too.  And
we can filter accessed once folios with folio_mark_accessed() firstly.
That is, only promote a page if,

- record the folio access time in folio_mark_accessed() only
- when the folio are accessed again, and "access_time - record_time <
  threshold", promote the folio.

> Basically we're thinking
>
> 1) hook folio_mark_accessed and use PG_ACTIVE/PG_ACCESSED to determine whether
>    the page is a promotion candidate.
> 2) if it is, isolate it from the LRU - which is safe because folio_mark_accessed
>    already does this elsewhere, and place it onto current->promo_queue
> 3) set_notify_resume
> 4) add logic to resume_user_mode_work() to run through current->promo_queue and
>    either promote the pages accordingly, or do folio_putback_lru on failure.

Use a task_work?

> Going to RFC this up

--
Best Regards,
Huang, Ying

