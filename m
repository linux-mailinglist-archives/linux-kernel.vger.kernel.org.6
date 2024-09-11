Return-Path: <linux-kernel+bounces-324235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 605C19749E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F741F2258F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A2E51C4A;
	Wed, 11 Sep 2024 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0wJ+gFj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4922066
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726033259; cv=none; b=X8c2euq2ORMReH2pjrLJZIPmUV/IomC9zVMz1+35Cpt8IILCXCdUCBXGXEX+HWgBJqDugvg4MTTYVOefwCUrU8CBQfjeNHR3Q4HBIjiIB1/ZMWn7STfIpZUC90ulJnTVr8950VHjLo66xkOLC/GeZncyOfekUmo/4M6f1ho//Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726033259; c=relaxed/simple;
	bh=KfAJtckaD6t8IGSFSxVgsxEymkRmCe4w3REfGus+RGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W4id2T8A1O/qnjwHeJ8MVIJABam4tjTycCHI4eS8Kg1G/sWYIyIbtiGYcdND2LaKNxvvP0hHMr3mLvkn6al/tij16JM8KyMJUG2FEDw7CxO5RFYxU2O1hpvRkdjydWqmXmN60rePvqWgqNV/RuDJARIA7jhpLXATT5SA1DS0xWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0wJ+gFj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726033257; x=1757569257;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=KfAJtckaD6t8IGSFSxVgsxEymkRmCe4w3REfGus+RGA=;
  b=U0wJ+gFjvIoh0tyvtCTxRhgkEUKUGRzcVWLwrkfmPLOmVcLVKX9pIHyg
   jJFfGDUUTkuzJbvCdm2l4OctVnoBjsZYJOmraNvh4ETeXPbpIhSqN6WlB
   BiRo5ALtmq0HEprRfSC4wMj8vo8CsaKMd8TC7U/DT4/9Qd6E9/tLnHg6N
   xFa1f4T+cVJHZeCPrE1fq4xdQrlfI9kalQARf1+7eDND5X3xSBCzMw12m
   BGwWJ33GmA1fz+Hc2o0lzcYhO1850emMqlBgR/hPweSYU6U2cCxqTB3by
   AuFP6v1hmiCNn2T5uZwBTZtaX2gSAuESg5d+n5AXF59qc4uW54JtzxoK5
   A==;
X-CSE-ConnectionGUID: QlTDJ60PQayV0aKFNmrvbA==
X-CSE-MsgGUID: iOXQI9hbRduBUhW/3cXPHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24750942"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24750942"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 22:40:56 -0700
X-CSE-ConnectionGUID: 5DAuK9D/Qjm+/pmx3hkAxg==
X-CSE-MsgGUID: j/hCGuhTQS2C2v54ohRnaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="97953780"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 22:40:54 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: mawupeng <mawupeng1@huawei.com>
Cc: <mhocko@suse.com>,  <akpm@linux-foundation.org>,
  <mgorman@techsingularity.net>,  <dmaluka@chromium.org>,
  <liushixin2@huawei.com>,  <wangkefeng.wang@huawei.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, proc: collect percpu free pages into the free pages
In-Reply-To: <26e53efe-7a54-499a-8d3f-345d29d90348@huawei.com> (mawupeng's
	message of "Tue, 10 Sep 2024 20:11:36 +0800")
References: <20240830014453.3070909-1-mawupeng1@huawei.com>
	<87a5guh2fb.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<2ee7cb17-9003-482c-9741-f1f51f61ab4b@huawei.com>
	<871q22hmga.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<193da117-30b8-425a-b095-6fd8aca1c987@huawei.com>
	<ZtbERGm8CJsOwx73@tiehlicka>
	<ed533d8b-40b7-447f-8453-e03b291340fa@huawei.com>
	<ZtgMHFQ4NwdvL7_e@tiehlicka>
	<26e53efe-7a54-499a-8d3f-345d29d90348@huawei.com>
Date: Wed, 11 Sep 2024 13:37:21 +0800
Message-ID: <87h6amwy26.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

mawupeng <mawupeng1@huawei.com> writes:

> On 2024/9/4 15:28, Michal Hocko wrote:
>> On Wed 04-09-24 14:49:20, mawupeng wrote:
>>>
>>>
>>> On 2024/9/3 16:09, Michal Hocko wrote:
>>>> On Tue 03-09-24 09:50:48, mawupeng wrote:
>>>>>> Drain remote PCP may be not that expensive now after commit 4b23a68f=
9536
>>>>>> ("mm/page_alloc: protect PCP lists with a spinlock").  No IPI is nee=
ded
>>>>>> to drain the remote PCP.
>>>>>
>>>>> This looks really great, we can think a way to drop pcp before goto s=
lowpath
>>>>> before swap.
>>>>
>>>> We currently drain after first unsuccessful direct reclaim run. Is that
>>>> insufficient?=20
>>>
>>> The reason i said the drain of pcp is insufficient or expensive is based
>>> on you comment[1] :-=EF=BC=89. Since IPIs is not requiered since commit=
 4b23a68f9536
>>> ("mm/page_alloc: protect PCP lists with a spinlock"). This could be much
>>> better.
>>>
>>> [1]: https://lore.kernel.org/linux-mm/ZWRYZmulV0B-Jv3k@tiehlicka/
>>=20
>> there are other reasons I have mentioned in that reply which play role
>> as well.
>>=20
>>>> Should we do a less aggressive draining sooner? Ideally
>>>> restricted to cpus on the same NUMA node maybe? Do you have any specif=
ic
>>>> workloads that would benefit from this?
>>>
>>> Current the problem is amount the pcp, which can increase to 4.6%(24644=
M)
>>> of the total 512G memory.
>>=20
>> Why is that a problem?=20
>
> MemAvailable
>               An estimate of how much memory is available for starting new
>               applications, without swapping. Calculated from MemFree,
>               SReclaimable, the size of the file LRU lists, and the low
>               watermarks in each zone.
>
> The PCP memory is essentially available memory and will be reclaimed befo=
re OOM.
> In essence, it is not fundamentally different from reclaiming file pages,=
 as both
> are reclaimed within __alloc_pages_direct_reclaim. Therefore, why shouldn=
't it be
> included in MemAvailable to avoid confusion.
>
> __alloc_pages_direct_reclaim
>   __perform_reclaim
>   if (!page && !drained)
>     drain_all_pages(NULL);
>
>
>> Just because some tools are miscalculating memory
>> pressure because they are based on MemAvailable? Or does this lead to
>> performance regressions on the kernel side? In other words would the
>> same workload behaved better if the amount of pcp-cache was reduced
>> without any userspace intervention?

Back to the original PCP cache issue.  I want to make sure that whether
PCP auto-tuning works properly on your system.  If so, the total PCP
pages should be less than the sum of the low watermark of zones.  Can
you verify that first?

--
Best Regards,
Huang, Ying

