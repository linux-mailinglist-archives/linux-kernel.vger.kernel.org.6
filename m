Return-Path: <linux-kernel+bounces-375728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190589A9A13
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774BFB2148A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C6C145FE4;
	Tue, 22 Oct 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiKA/CeD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5A4139590
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579233; cv=none; b=a+c2gTcyJE2hTFcj/+cqvB4IdqrWK9zPBT8S5nGutZ3QAWmj21PdIytsRqStW1Acc1N/9TgT5RIKeo6wUBe0IF1i9I12HFntJn/eB/tCegQ9X24T/+d9px82U3cJycQ8LdZGXQwANt1jez6TuJU2IRBBVJeiV9aRieVu5Y7F8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579233; c=relaxed/simple;
	bh=ObS/CD1nC9BsnXstuf+6HnMfJ4rOcKFcdJkNNFG/3VA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KrYRS7Dauwa1WVpUWQRXFOrTJqIFN8bI49NnrCDKoCW391XyxMxL+pFT7GCKujmwGGowZysxDNDaN+l2KE8kg1ctoqjnQfVk5LbmD7CRfWZdbCQ0Hnghxn1hvKrFwyfG2kyXxq6x5ZgrJSUcJWj1rK6dALXVQK4Btrmj4RK8Y9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiKA/CeD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729579232; x=1761115232;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ObS/CD1nC9BsnXstuf+6HnMfJ4rOcKFcdJkNNFG/3VA=;
  b=AiKA/CeD34HcDTm9swyzEqHvnRvLEuBrcwCRj5NcOPdSI5OcAxKYf0f+
   +ygsHWQ+0e19Z3HGzkOxX4V1ONnat1ZsCGc+3xfc2HybluF/4eQwdxOsa
   Wc7vUrQbZHox8f0ADB+nAKNj5wDKrI4JtAEYU6SUqqK+Ug0++bJ+g+fyg
   +pRD+n75piYr8ZPI12TuJNNjw/XkRo4alUTTfU25TY5mar2+TAaiGHl6e
   ngTtSDfI8l3QT87dC/s0oNci7ZqcsirwnkQNwjpofOFbH3CFkMEN6L3BN
   PYCHC9S4mF3ITbkMTcTBp5O/sgn0NjpHtYoPFZaKGaJOciK8VRZlKrEcu
   A==;
X-CSE-ConnectionGUID: ksqh0stvQ3+lqHy/cAjrjw==
X-CSE-MsgGUID: 5SzColo2RBOWtsFTqaHBpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40213393"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40213393"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 23:40:32 -0700
X-CSE-ConnectionGUID: vn4ZM4mfTwCfPsfjBRxIrg==
X-CSE-MsgGUID: d6Oc0JBjSj2aCIRY2JkM0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79762777"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 23:40:29 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: MengEn Sun <mengensun88@gmail.com>
Cc: akpm@linux-foundation.org,  alexjlzheng@tencent.com,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  mengensun@tencent.com
Subject: Re: [PATCH linux-mm v2] mm: make pcp_decay_high working better with
 NOHZ full
In-Reply-To: <1729574046-3392-1-git-send-email-mengensun@tencent.com> (MengEn
	Sun's message of "Tue, 22 Oct 2024 13:14:06 +0800")
References: <87msix6e8c.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<1729574046-3392-1-git-send-email-mengensun@tencent.com>
Date: Tue, 22 Oct 2024 14:36:56 +0800
Message-ID: <87v7xk4p9z.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

MengEn Sun <mengensun88@gmail.com> writes:

> Thank you for your suggestion. I understand and am ready to make
> some changes  
>
>> 
>> Have verified the issue with some test?  If not, I suggest you to do
>> that.
>> 
>
> I have conducted tests:
> Applying this patch or not does not have a significant impact on the
> test results.

I don't expect some measurable performance difference with the patch.
If we can observe that the PCP size isn't tuned down to high_min before
and is after, that should be a valid test result to show the value of
the patch.  Can you try that?  The PCP size can be observed via
/proc/zoneinfo.

> perhaps my testing was not thorough enough. #^_^
>
> But, the logic of the code is like following:
> CPU0                              CPUx
> ----                              -----
>                                   T0: vmstat_work is pending
> T1: vmstat_shepherd
>     check vmstat_work
>     and do nothing
>                                   T2: vmstat_work is in unpending state.
>
>                                   T3: alloc many pages
>                                   T4: free all the pages allocated at T3
>                                   T5: entry NOHZ, flushing all zonestats
>                                       and nodestats
> T6: next vmstat_shepherd fired
>
> In my opinion, there are indeed some issues. I'm not sure if there's
> something I haven't understood?
>
>
> By the way,
> There are two other questions for me:
> Q1:
> Vmstat_work is a **deferreable work** So, It may be delayed for a long time
> by NOHZ. As a result, "vmstat_update() may not be executed once every
> second in the above scenario. Therefore, I'm not sure if using a deferrable
> work to reduce pcp->high is appropriate. In my tests, if I don't use
> deferrable work, it takes about a minute to reduce high to high_min, but
> using deferrable work may take several minutes to reduce high to high_min.

It's not a big issue to take longer time to decay pcp->high.

> Q2:
> On a big machine, for example, with 1TB of memory, the default maximum
> memory on PCP can be 1TB * 0.125.
> This portion of memory is not accounted for in MemFree in /proc/meminfo.
> Users can see this portion of memory from /proc/zoneinfo, but the memory
> reported by the `free` command is reduced.
> can we include the PCP memory in the MemFree statistic in /proc/meminfo?

This has been discussed before.

https://lore.kernel.org/linux-mm/20220816084426.135528-1-wangkefeng.wang@huawei.com/
https://lore.kernel.org/linux-mm/20240830014453.3070909-1-mawupeng1@huawei.com/

>> > While, This seems to be fine:
>> > - if freeing and allocating memory occur later, it may the
>> >   high_max may be adjust automatically
>> > - If memory is tight, the memory reclamation process will
>> >   release the pcp
>> 
>> This could be a real issue for me.
>
> Thanks, I will test more carefully for those issue
>
>> 
>> > Whatever, we make vmstat_shepherd to checking whether we need
>> > decay pcp high_max, and fire pcp_decay_high early if we need.
>> >
>> > Fixes: 51a755c56dc0 ("mm: tune PCP high automatically")
>> > Reviewed-by: Jinliang Zheng <alexjlzheng@tencent.com>
>> > Signed-off-by: MengEn Sun <mengensun@tencent.com>
>> > ---
>> > changelog:
>> > v1: https://lore.kernel.org/lkml/20241012154328.015f57635566485ad60712f3@linux-foundation.org/T/#t
>> > v2: Make the commit message clearer by adding some comments.
>> > ---
>> >  mm/vmstat.c | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/mm/vmstat.c b/mm/vmstat.c
>> > index 1917c034c045..07b494b06872 100644
>> > --- a/mm/vmstat.c
>> > +++ b/mm/vmstat.c
>> > @@ -2024,8 +2024,17 @@ static bool need_update(int cpu)
>> >  
>> >  	for_each_populated_zone(zone) {
>> >  		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
>> > +		struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
>> >  		struct per_cpu_nodestat *n;
>> >  
>> > +		/* per_cpu_nodestats and per_cpu_zonestats maybe flush when cpu
>> > +		 * entering NOHZ full, see quiet_vmstat. so, we check pcp
>> > +		 * high_{min,max} to determine whether it is necessary to run
>> > +		 * decay_pcp_high on the corresponding CPU
>> > +		 */
>> 
>> Please follow the comments coding style.
>> 
>>                 /*
>>                  * comments line 1
>>                  * comments line 2
>>                  */
>> 
>
> Thank you for your suggestion. I understand and am ready to make
> some changes
>
>> > +		if (pcp->high_max > pcp->high_min)
>> > +			return true;
>> > +
>> 
>> We don't tune pcp->high_max/min in fact.  Instead, we tune pcp->high.
>> Your code may make need_update() return true in most cases.
>
> You are right, using high_max is incorrect. May i use pcp->high > pcp->high_min?
>
>> 
>> >  		/*
>> >  		 * The fast way of checking if there are any vmstat diffs.
>> >  		 */

--
Best Regards,
Huang, Ying

