Return-Path: <linux-kernel+bounces-310660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72548967FC6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B620B21C79
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF926156960;
	Mon,  2 Sep 2024 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSj6FpcB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62A136982
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260223; cv=none; b=NOQfpPxgl1WZiiF7vDiM0Mt/7bG5zVmjntbRlm9moMx9VYWyK2lK7h6N7PpLVrQrNg+FJaDOePaChB4dgULFX0yMqFF1e0AHBY5a1+cfS825HFuygctQRt036lk5+BaW7v1vVdVnK8SKlFM22LA2X6IRbk3oy45FxkdjDHjA8dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260223; c=relaxed/simple;
	bh=05BncVjKxgwNPFHZU9+GI6c3nsn4O6yfhfAuVdbWhjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dJl3Soiy3GAOgzJ3mAqiAccidXkXX3aZnc9syGiigpCCN9dfC/kueL8uGKRClSLGqvN3ndB3RgKLjcDB4q5m0PuW2Y0lGtXXmwc69srkI3Sr1V0crT3vTK1xO0e0Nr78ZR0pB9CaWG2vcbsMzJWTD4h1otVE0zGxpRVxMphQgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSj6FpcB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725260222; x=1756796222;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=05BncVjKxgwNPFHZU9+GI6c3nsn4O6yfhfAuVdbWhjc=;
  b=PSj6FpcB5QH/poCde1qAWLkYegpU63lrqL5uCcMGTTUzQ6wgl/jZcgna
   EszUpjFA3SdrmBGwEhTVFnEI/d+sztg2EwHuFn2MsafVRhz4bkskhQcP/
   OmgUgtPKapGbKAakTLp2mZ2X5bFJpPVb3tA+h29P391ajPRSkYUJ0K8JI
   1RKNBMY42EMyvn/FXwRyxbIed7vXvxzzOyep7MW/V45Z5PpmJ6PZxn6al
   c2B840X8qWO+s9PBc3uUSF2ZbmhgVbi72/HN/BZVi+rE4LulRmv+oFWpf
   Gec853Uv5hZduYBNo8zpNGqDMP3H8BuQFPBD3iFhFs3BL0Idj5S7cTAu8
   A==;
X-CSE-ConnectionGUID: B/Ph26bWRjOI176k7FMZkQ==
X-CSE-MsgGUID: pVC/YWWmTeiGT+ywmgpoGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34392871"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34392871"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 23:57:01 -0700
X-CSE-ConnectionGUID: 8Y/AafKDSx2DZUU066CqFQ==
X-CSE-MsgGUID: uTKe24iqQ4Ow5xEUDCcKdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69323791"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 23:56:58 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  akpm@linux-foundation.org,  david@redhat.com,  nphamcs@gmail.com,
  nehagholkar@meta.com,  abhishekd@meta.com,  Johannes Weiner
 <hannes@cmpxchg.org>, Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
In-Reply-To: <ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Mon, 19 Aug 2024 11:15:13 -0400")
References: <20240803094715.23900-1-gourry@gourry.net>
	<875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com>
Date: Mon, 02 Sep 2024 14:53:26 +0800
Message-ID: <87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Mon, Aug 19, 2024 at 03:46:00PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry@gourry.net> writes:
>> 
>> > Unmapped pagecache pages can be demoted to low-tier memory, but 
>> > they can only be promoted if a process maps the pages into the
>> > memory space (so that NUMA hint faults can be caught).  This can
>> > cause significant performance degradation as the pagecache ages
>> > and unmapped, cached files are accessed.
>> >
>> > This patch series enables the pagecache to request a promotion of
>> > a folio when it is accessed via the pagecache.
>> >
>> > We add a new `numa_hint_page_cache` counter in vmstat to capture
>> > information on when these migrations occur.
>> 
>> It appears that you will promote page cache page on the second access.
>> Do you have some better way to identify hot pages from the not-so-hot
>> pages?  How to balance between unmapped and mapped pages?  We have hot
>> page selection for hot pages.
>> 
>> [snip]
>> 
>
> I've since explored moving this down under a (referenced && active) check.
>
> This would be more like promotion on third access within an LRU shrink
> round (the LRU should, in theory, hack off the active bits on some decent
> time interval when the system is pressured).
>
> Barring adding new counters to folios to track hits, I don't see a clear
> and obvious way way to track hotness.  The primary observation here is 
> that pagecache is un-mapped, and so cannot use numa-fault hints.
>
> This is more complicated with MGLRU, but I'm saving that for after I
> figure out the plan for plain old LRU.

Several years ago, we have tried to use the access time tracking
mechanism of NUMA balancing to track the access time latency of unmapped
file cache folios.  The original implementation is as follows,

https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=5f2e64ce75c0322602c2ec8c70b64bb69b1f1329

What do you think about this?

--
Best Regards,
Huang, Ying

