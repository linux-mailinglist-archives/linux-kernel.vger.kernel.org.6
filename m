Return-Path: <linux-kernel+bounces-274212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0870A947513
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B780E28162C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC491422AB;
	Mon,  5 Aug 2024 06:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3nV/MqA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEAD38385
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838423; cv=none; b=otaZ5Jc9TAFt3OTCrXyYjYsbzTSe0L/pm3aoFRdE2VZkIQ88WGWL38sbwCkeWTk2Ydx/IeG8wT2Ni9UT8UCT38lo/aKKSrQQTB0iwdi/z64TUnB0ErEmeJBrq5Qs5yoim2xP/53Pd13TIrZwwsUYmGMeb4ZmMCzoS5pmFwQlZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838423; c=relaxed/simple;
	bh=8eCxN3TayP9/FKSTSM4KY+ZNtCrU63RI6A+v7qQLh9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/MjEmmeFACFs0ph551azMZHrbSEW+9eibyp+1vs3UXGz6oc3WjLiQlhx35LbYr4ZRs2kBX3ByeTm/LJdd3+dfv6ijbH9s/AwVupJOIvQ9iVfgBGitrSVVBOlA89HJ+2OgDhixhjFP4wwuVBsKTAIvmRgaguUgC+ffmI7Dv02FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3nV/MqA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722838422; x=1754374422;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8eCxN3TayP9/FKSTSM4KY+ZNtCrU63RI6A+v7qQLh9Q=;
  b=d3nV/MqApMJpeumopSQRGURJLShOPwqUHXklVRUw0diLn88syT9vOJTl
   rChUVce0Ob7HbUJ+Nl1oBcWCXDNXUOtFcITU3c3pkbwTQ19U2ifTZbQoc
   tlLhbKQlBQk9w9DfvPhwzGzdL+tLVy7md2+vlaKY9pNUi3XYXdR5GLD7S
   vQj4UzrOvvuZnMSs9SaiOTqBUAyDNRY9Enl2eiIUmeTDnx1bsJZP4Psgc
   gEyeGXAwxSYjO/oBID5V2CgQOSLBg8isDAc77BrEF7Jqz1jO5TxKqb1gS
   xhOmtNvAC5oh/bL+Yuchmg0MeSgNEORuFWhnqvUOkvL2982jp5ysSXip5
   A==;
X-CSE-ConnectionGUID: Kqs7GH0KS8S29b4q4MSgZA==
X-CSE-MsgGUID: lQnCcUq4R1uJEp6lwcuhFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20903633"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="20903633"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 23:13:42 -0700
X-CSE-ConnectionGUID: IPVbLpnpRyKjkQGOifU1xA==
X-CSE-MsgGUID: 3w1M8vCMQBe4O60OzDV86g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="55710351"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 23:13:36 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Barry Song <21cnbao@gmail.com>,  akpm@linux-foundation.org,
  linux-mm@kvack.org,  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,
  david@redhat.com,  hannes@cmpxchg.org,  hughd@google.com,
  kaleshsingh@google.com,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  mhocko@suse.com,  minchan@kernel.org,
  nphamcs@gmail.com,  ryan.roberts@arm.com,  senozhatsky@chromium.org,
  shakeel.butt@linux.dev,  shy828301@gmail.com,  surenb@google.com,
  v-songbaohua@oppo.com,  xiang@kernel.org,  yosryahmed@google.com
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
In-Reply-To: <ZqcR_oZmVpi2TrHO@casper.infradead.org> (Matthew Wilcox's message
	of "Mon, 29 Jul 2024 04:52:30 +0100")
References: <20240726094618.401593-1-21cnbao@gmail.com>
	<20240726094618.401593-5-21cnbao@gmail.com>
	<ZqcR_oZmVpi2TrHO@casper.infradead.org>
Date: Mon, 05 Aug 2024 14:10:03 +0800
Message-ID: <874j7zfqkk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Jul 26, 2024 at 09:46:18PM +1200, Barry Song wrote:
>> A user space interface can be implemented to select different swap-in
>> order policies, similar to the mTHP allocation order policy. We need
>> a distinct policy because the performance characteristics of memory
>> allocation differ significantly from those of swap-in. For example,
>> SSD read speeds can be much slower than memory allocation. With
>> policy selection, I believe we can implement mTHP swap-in for
>> non-SWAP_SYNCHRONOUS scenarios as well. However, users need to understand
>> the implications of their choices. I think that it's better to start
>> with at least always never. I believe that we will add auto in the
>> future to tune automatically, which can be used as default finally.
>
> I strongly disagree.  Use the same sysctl as the other anonymous memory
> allocations.

I still believe we have some reasons for this tunable.

1. As Ryan pointed out in [1], swap-in with large mTHP orders may cause
   long latency, which some users might want to avoid.

[1] https://lore.kernel.org/lkml/f0c7f061-6284-4fe5-8cbf-93281070895b@arm.com/

2. We have readahead information available for swap-in, which is
   unavailable for anonymous page allocation.  This enables us to build
   an automatic swap-in order policy similar to that for page cache
   order based on readahead.

3. Swap-out/swap-in cycles present an opportunity to identify hot pages.
   In many use cases, we can utilize mTHP for hot pages and order-0 page
   for cold pages, especially under memory pressure.  When an mTHP has
   been swapped out, it indicates that it could be a cold page.
   Converting it to order-0 pages might be a beneficial policy.

--
Best Regards,
Huang, Ying

