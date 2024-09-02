Return-Path: <linux-kernel+bounces-310463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92BA967D67
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFA71C2174E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958421BF37;
	Mon,  2 Sep 2024 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PN9sNJjS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25D28683
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240815; cv=none; b=frWbbzdyZQUTZjhS5fS87yuGtpnulqVEznUrcl79X77/aBrRh39X7MkLsP/hhDLsvCcnPCzr0V7pxW5erIzooreqVbkzzKf6oE/6DsUiVoEazjJ0XzICLZKfEvESK9gJFBxLV4HAFnv2C1nFcS70Fj8C+uaR/j/yrEVmhaLrmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240815; c=relaxed/simple;
	bh=+nCv4P0jKRaRO8VOTVEVucrRgtN0A2Xsa2rrL/fSubg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ccyhHqwCYPprlEYjILmo7TWqZ3ONPL+Rk03AO8e+j1PG8eKd7uhnSNab+Q8hDUKyUiWEGtZpjoxPxx2448ghkB/Yf+fshO2cFvdx5LM65gbQIsvW30XFFf5VDQtfXkiw5ylTYQqpu8JC19eh3tUhuqv+2fDi0TnrzsyVE/+KirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PN9sNJjS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725240813; x=1756776813;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+nCv4P0jKRaRO8VOTVEVucrRgtN0A2Xsa2rrL/fSubg=;
  b=PN9sNJjS+N7TetJHY2w/YrnsOLlEc7OwyjvHm9D9Hft0UGwVeWl0dIEU
   l2YQ8rbgAXlejgPhqGOLeIwoQO39xgaFQx85GbRIIZNRPR/JAwRj85PB0
   C4YmTKKw6I2UdDY6mnB02M53sKzOaPKfGSyHp5dBPHptIrPmzLyrXfeB+
   Jtysz1N4sQXDtEzgQtMRCBxm0NbNq7FsvdCLVuEvHnBNb0/PXcu61cz52
   H3fBeEmczzpD9Dh9A3tiRTVafuuJ3CIPMFtYTWHzkRvXCYOT/aMn2kqJL
   e4N186gTt8LzbFSjKrXD4hkL2NuFv0UEIe528OYKRE2nLRDQnw0902WoQ
   w==;
X-CSE-ConnectionGUID: wJJY/KFaQsOunaCi3lptFg==
X-CSE-MsgGUID: oxAavW8JQSqi5cgBR/wJ1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23943014"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="23943014"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 18:33:33 -0700
X-CSE-ConnectionGUID: qjTeZ70BSRK0RWwG/D41QQ==
X-CSE-MsgGUID: KxDCcF24QbuvmFoSNqS8KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="69262553"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 18:33:31 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: mawupeng <mawupeng1@huawei.com>
Cc: <akpm@linux-foundation.org>,  <mgorman@techsingularity.net>,
  <mhocko@suse.com>,  <dmaluka@chromium.org>,  <liushixin2@huawei.com>,
  <wangkefeng.wang@huawei.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, proc: collect percpu free pages into the free pages
In-Reply-To: <2ee7cb17-9003-482c-9741-f1f51f61ab4b@huawei.com> (mawupeng's
	message of "Mon, 2 Sep 2024 09:11:58 +0800")
References: <20240830014453.3070909-1-mawupeng1@huawei.com>
	<87a5guh2fb.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<2ee7cb17-9003-482c-9741-f1f51f61ab4b@huawei.com>
Date: Mon, 02 Sep 2024 09:29:57 +0800
Message-ID: <871q22hmga.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

mawupeng <mawupeng1@huawei.com> writes:

> On 2024/8/30 15:53, Huang, Ying wrote:
>> Hi, Wupeng,
>> 
>> Wupeng Ma <mawupeng1@huawei.com> writes:
>> 
>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>
>>> The introduction of Per-CPU-Pageset (PCP) per zone aims to enhance the
>>> performance of the page allocator by enabling page allocation without
>>> requiring the zone lock. This kind of memory is free memory however is
>>> not included in Memfree or MemAvailable.
>>>
>>> With the support of higt-order pcp and pcp auto-tuning, the size of the
>>> pages in this list has become a matter of concern due to the following
>>> patches:
>>>
>>>   1. Introduction of Order 1~3 and PMD level PCP in commit 44042b449872
>>>   ("mm/page_alloc: allow high-order pages to be stored on the per-cpu
>>>   lists").
>>>   2. Introduction of PCP auto-tuning in commit 90b41691b988 ("mm: add
>>>   framework for PCP high auto-tuning").
>> 
>> With PCP auto-tuning, the idle pages in PCP will be freed to buddy after
>> some time (may be as long as tens seconds in some cases).
>
> Thank you for the detailed explanation regarding PCP auto-tuning. If the
> PCP pages are freed to the buddy after a certain period due to auto-tuning,
> it's possible that there is no direct association between PCP auto-tuning
> and the increase in the PCP count as indicated below, especially if no
> actual tasks have commenced after booting. The primary reason for the
> increase might be more orders and a surplus of CPUs.
>
>> 
>>> Which lead to the total amount of the pcp can not be ignored just after
>>> booting without any real tasks for as the result show below:
>>>
>>> 		   w/o patch	  with patch	      diff	diff/total
>>> MemTotal:	525424652 kB	525424652 kB	      0 kB	        0%
>>> MemFree:	517030396 kB	520134136 kB	3103740 kB	      0.6%
>>> MemAvailable:	515837152 kB	518941080 kB	3103928 kB	      0.6%
>
> We do the following experiments which make the pcp amount even bigger:
> 1. alloc 8G of memory in all of the 600+ cpus
> 2. kill all the above user tasks 
> 3. waiting for 36h
>
> the pcp amount 6161097(24644M) which 4.6% of the total 512G memory.
>
>
>>>
>>> On a machine with 16 zones and 600+ CPUs, prior to these commits, the PCP
>>> list contained 274368 pages (1097M) immediately after booting. In the
>>> mainline, this number has increased to 3003M, marking a 173% increase.
>>>
>>> Since available memory is used by numerous services to determine memory
>>> pressure. A substantial PCP memory volume leads to an inaccurate estimation
>>> of available memory size, significantly impacting the service logic.
>>>
>>> Remove the useless CONFIG_HIGMEM in si_meminfo_node since it will always
>>> false in is_highmem_idx if config is not enabled.
>>>
>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> 
>> This has been discussed before in the thread of the previous version,
>> better to refer to it and summarize it.
>> 
>> [1] https://lore.kernel.org/linux-mm/YwSGqtEICW5AlhWr@dhcp22.suse.cz/
>
> As Michal Hocko mentioned in previous discussion:
>  1. If it is a real problem?
>  2. MemAvailable is documented as available without swapping, however
>     pcp need to drain reclaim.
>
> 1. Since available memory is used by numerous services to determine memory
> pressure. A substantial PCP memory volume leads to an inaccurate estimation
> of available memory size, significantly impacting the service logic.
> 2. MemAvailable here do seems wired. There is no reason to drain pcp to
> drop clean page cache As Michal Hocko already pointed in this post, drain
> clean page cache is much cheaper than drain remote pcp.Any idea on this?

Drain remote PCP may be not that expensive now after commit 4b23a68f9536
("mm/page_alloc: protect PCP lists with a spinlock").  No IPI is needed
to drain the remote PCP.

> [1] https://lore.kernel.org/linux-mm/ZWRYZmulV0B-Jv3k@tiehlicka/

--
Best Regards,
Huang, Ying

