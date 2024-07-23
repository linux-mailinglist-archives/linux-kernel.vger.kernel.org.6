Return-Path: <linux-kernel+bounces-259606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F8C939950
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78201C21A58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552BE13C66A;
	Tue, 23 Jul 2024 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMkxlgb9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAF634
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721713806; cv=none; b=gE6Pa4eCuPGVnU8q+mbtvvkNo2OIEnMZ/XEeLcw4oEej1gLXhJRpjLOA/vTQbjDy1XcJeVxiVmOI6QuLGPUNOwLIIXxC/SgoSLL6Zrf/KeFDMChhcNnaxtueTtQsDIxqNk89kXZueKf+q0MprRpq74gCM4b0PUnu56Kx9Cn6aG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721713806; c=relaxed/simple;
	bh=KRSVEKuQf4D7uKsk/SQEgnkrXd61qjSP50UUz7uThlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ac9ApVvLsL7BOh7hgowTtFJTwmT5TAdFoLIWohM4rj7U5+bTekPTrdeI9047UA35K/2u5rRXkVQUTmwigIOWTiq1x9zfzTC0HgkQ1pQiKgxwUPxboKGAjf0CU8M3ZoI0+PD5z5CpZ1cGJt+fsVzpBGrItToBqorPw3fJQZLgX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMkxlgb9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721713805; x=1753249805;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KRSVEKuQf4D7uKsk/SQEgnkrXd61qjSP50UUz7uThlI=;
  b=WMkxlgb9BxtOGiSKhPnUWmWzYqoZHyT7eCReJgKcw9yllNgbq1hdQSQP
   uRC9lLwS8JaplHsA4lHau1sjIs/NuCed/x3kF//KNnq897S3M3Ju8RBR1
   NFaJvr5R7nlv0/qxdNXZkAnZ7mQoXJfqnXYFcFu+17ej2F+WmBh0sNYeW
   a6sCBWfZ0x1PBSOQmMKqxAehiaNYtjTDy8U33f3tFavChK+PBwMehZWgv
   ovfbH0avtyezSaQWcCUI/bSu1T7Ov1ESfinwQ8l5l9hlwugE/0S6Up8iB
   he20m3U5vzEoRnzajD0CbAztEzG+ponDpGNRtsKDaBrghSgQLDIwvV3aj
   w==;
X-CSE-ConnectionGUID: q6Ljn5OpSsOoI/RSDiwXOw==
X-CSE-MsgGUID: RJemQTpYSgqgqIThb2Ea0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19017678"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19017678"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 22:50:00 -0700
X-CSE-ConnectionGUID: rwpwn8nZQe6rHHxwdO8mcg==
X-CSE-MsgGUID: A03Y7/5JRjykVMxM5WARwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="89578334"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 22:49:58 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Zi Yan <ziy@nvidia.com>,  Andrew Morton <akpm@linux-foundation.org>,
  <linux-mm@kvack.org>,  David Hildenbrand <david@redhat.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] memory tiering: count PGPROMOTE_SUCCESS when mem
 tiering is enabled.
In-Reply-To: <d31b0226-6013-4152-af4b-1526146eb179@huawei.com> (Kefeng Wang's
	message of "Tue, 23 Jul 2024 11:24:23 +0800")
References: <20240722172917.503370-1-ziy@nvidia.com>
	<20240722172917.503370-3-ziy@nvidia.com>
	<5230d72e-81fa-4ef1-b386-90bd3b06bf0e@huawei.com>
	<D2WJLRHB9T9S.DRAUA25VKCBP@nvidia.com>
	<d31b0226-6013-4152-af4b-1526146eb179@huawei.com>
Date: Tue, 23 Jul 2024 13:46:24 +0800
Message-ID: <87wmlcek3z.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

> On 2024/7/23 9:54, Zi Yan wrote:
>> On Mon Jul 22, 2024 at 9:48 PM EDT, Kefeng Wang wrote:
>>>
>>>
>>> On 2024/7/23 1:29, Zi Yan wrote:
>>>> memory tiering can be enabled/disabled at runtime and
>>>> sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING is used to check
>>>> it. In migrate_misplaced_folio(), the check is missing when
>>>> PGPROMOTE_SUCCESS is incremented. Add the missing check.
>>>>
>>>> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> Closes: https://lore.kernel.org/linux-mm/f4ae2c9c-fe40-4807-bdb2-64cf2d716c1a@huawei.com/
>>>> Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>
>>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>
>> Thanks.
>> 
>>>> ---
>>>>    mm/migrate.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index bdbb5bb04c91..b819809da470 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -2630,7 +2630,9 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>>>>    		putback_movable_pages(&migratepages);
>>>>    	if (nr_succeeded) {
>>>>    		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
>>>> -		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
>>>> +		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
>>>> +		    && !node_is_toptier(folio_nid(folio))
>>>> +		    && node_is_toptier(node))
>>>>    			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
>>>>    					    nr_succeeded);
>>>
>>> The should be in advance of patch2, and change above to use
>>> folio_has_cpupid() helper() too.
>> It shares the same logic of !folio_has_cpupid() but it might be
>> confusing to
>> put !folio_has_cpupid(folio) && node_is_toptier(node) here. folio's
>> cpupid has nothing to do with the stats here, thus I did not use the
>> function.
>
> If folio don't include access time, we do migrate it but it isn't a
> promotion, so don't count it, other comments?

Personally, I prefer to use !node_is_toptier() && node_is_toptier()
here.  That sounds more natural for me.

> PS: Could we rename folio_has_cpupid() to folio_has_access_time(),
> even without memory_tiering, we still have cpupid in folio, right?

--
Best Regards,
Huang, Ying

