Return-Path: <linux-kernel+bounces-222287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDF490FF3F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748E11F23B05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754B71A00EB;
	Thu, 20 Jun 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w+4UFry4"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBD19939B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873075; cv=none; b=hYWsUoSACeowKGG6X8G9BHLGJFVvzIbJeUeX8ZT2tO7B4gEnHjp/nDZ3kqIf2Hh3aZaawcKYGTCwdIb/umwaZyK6rr6TRs2mOj9RvFSs7dhlENOvrOST0QG3lBN74HI8sxZQk5YQxaBI2miVwq69ab8/xfOifMNgh5aRSXAeQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873075; c=relaxed/simple;
	bh=jItaWTxtvQq16zawBOAbNPjZc6xybjFH2ako2FTZJYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gawZrMRl4pelF/YrcnaJzxWwE6uOmOx1aBT5O4ZojNcFkFLEk0WF1KaCVjlxUS+gLXsKPdrIirsHuaFIqzdohaHNdEtcnECdTUlsbyiwjg4Ts/WAJ07BLC/veYOhx4OaCqWc6XK+e0xADQvw55fji386MBurCv7PCDeaRlN9nxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w+4UFry4; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718873069; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iW77EJVfYwKkFDl4zjX0fOY7BnxcYMTdOkYcNmQQZZo=;
	b=w+4UFry4JhZegBR/19HFrM2VeRkGblUTT5V1A14qdR7YaALdZVAuYIr77S8zcjkLdaaB1khJ4EZI6/O7yQTZJIml5O1s+WJByQNZkD6nQPRebGPL8ZNxSDAwn5gJb7chI8SeNrwEAlKauy4fmAabMwQURKwH7OA2pF83uHweFf8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8rDW98_1718873066;
Received: from 30.97.56.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8rDW98_1718873066)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 16:44:27 +0800
Message-ID: <67930dc6-e9e4-44f2-8f10-74325a21b1d5@linux.alibaba.com>
Date: Thu, 20 Jun 2024 16:44:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] d2136d749d: vm-scalability.throughput -7.1%
 regression
To: "Huang, Ying" <ying.huang@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Mel Gorman <mgorman@techsingularity.net>, Ryan Roberts
 <ryan.roberts@arm.com>, linux-mm@kvack.org, feng.tang@intel.com,
 fengwei.yin@intel.com
References: <202406201010.a1344783-oliver.sang@intel.com>
 <24a985cf-1bbf-41f9-b234-24f000164fa6@linux.alibaba.com>
 <87bk3w2he5.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87bk3w2he5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/20 15:38, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 2024/6/20 10:39, kernel test robot wrote:
>>> Hello,
>>> kernel test robot noticed a -7.1% regression of
>>> vm-scalability.throughput on:
>>> commit: d2136d749d76af980b3accd72704eea4eab625bd ("mm: support
>>> multi-size THP numa balancing")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>> [still regression on linus/master
>>> 92e5605a199efbaee59fb19e15d6cc2103a04ec2]
>>> testcase: vm-scalability
>>> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
>>> parameters:
>>> 	runtime: 300s
>>> 	size: 512G
>>> 	test: anon-cow-rand-hugetlb
>>> 	cpufreq_governor: performance
>>
>> Thanks for reporting. IIUC numa balancing will not scan hugetlb VMA,
>> I'm not sure how this patch affects the performance of hugetlb cow,
>> but let me try to reproduce it.
>>
>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202406201010.a1344783-oliver.sang@intel.com
>>> Details are as below:
>>> -------------------------------------------------------------------------------------------------->
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20240620/202406201010.a1344783-oliver.sang@intel.com
>>> =========================================================================================
>>> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>>>     gcc-13/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/512G/lkp-icl-2sp2/anon-cow-rand-hugetlb/vm-scalability
>>> commit:
>>>     6b0ed7b3c7 ("mm: factor out the numa mapping rebuilding into a new helper")
>>>     d2136d749d ("mm: support multi-size THP numa balancing")
>>> 6b0ed7b3c77547d2 d2136d749d76af980b3accd7270
>>> ---------------- ---------------------------
>>>            %stddev     %change         %stddev
>>>                \          |                \
>>>        12.02            -1.3       10.72 ±  4%  mpstat.cpu.all.sys%
>>>      1228757            +3.0%    1265679        proc-vmstat.pgfault
> 
> Also from other proc-vmstat stats,
> 
>       21770  36%      +6.1%      23098  28%  proc-vmstat.numa_hint_faults
>        6168 107%     +48.8%       9180  18%  proc-vmstat.numa_hint_faults_local
>      154537  15%     +23.5%     190883  17%  proc-vmstat.numa_pte_updates
> 
> After your patch, more hint page faults occurs, I think this is expected.

This is exactly my confusion, why are there more numa hint faults? The 
hugetlb VMAs will be skipped from scanning, so other VMAs of the 
application will use mTHP or large folio?

> Then, tasks may be moved between sockets because of that, so that some
> hugetlb page access becomes remote?

Yes, that is possible if the application uses some large folio.

>>>      7392513            -7.1%    6865649        vm-scalability.throughput
>>>        17356            +9.4%      18986        vm-scalability.time.user_time
>>>         0.32 ± 22%     -36.9%       0.20 ± 17%  sched_debug.cfs_rq:/.h_nr_running.stddev
>>>        28657 ± 86%     -90.8%       2640 ± 19%  sched_debug.cfs_rq:/.load.stddev
>>>         0.28 ± 35%     -52.1%       0.13 ± 29%  sched_debug.cfs_rq:/.nr_running.stddev
>>>       299.88 ± 27%     -39.6%     181.04 ± 23%  sched_debug.cfs_rq:/.runnable_avg.stddev
>>>       284.88 ± 32%     -44.0%     159.65 ± 27%  sched_debug.cfs_rq:/.util_avg.stddev
>>>         0.32 ± 22%     -37.2%       0.20 ± 17%  sched_debug.cpu.nr_running.stddev
>>>    1.584e+10 ±  2%      -6.9%  1.476e+10 ±  3%  perf-stat.i.branch-instructions
>>>     11673151 ±  3%      -6.3%   10935072 ±  4%  perf-stat.i.branch-misses
>>>         4.90            +3.5%       5.07        perf-stat.i.cpi
>>>       333.40            +7.5%     358.32        perf-stat.i.cycles-between-cache-misses
>>>    6.787e+10 ±  2%      -6.8%  6.324e+10 ±  3%  perf-stat.i.instructions
>>>         0.25            -6.2%       0.24        perf-stat.i.ipc
>>>         4.19            +7.5%       4.51        perf-stat.overall.cpi
>>>       323.02            +7.4%     346.94        perf-stat.overall.cycles-between-cache-misses
>>>         0.24            -7.0%       0.22        perf-stat.overall.ipc
>>>    1.549e+10 ±  2%      -6.8%  1.444e+10 ±  3%  perf-stat.ps.branch-instructions
>>>    6.634e+10 ±  2%      -6.7%  6.186e+10 ±  3%  perf-stat.ps.instructions
>>>        17.33 ± 77%     -10.6        6.72 ±169%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
>>>        17.30 ± 77%     -10.6        6.71 ±169%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
>>>        17.30 ± 77%     -10.6        6.71 ±169%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>>>        17.28 ± 77%     -10.6        6.70 ±169%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>>>        17.27 ± 77%     -10.6        6.70 ±169%  perf-profile.calltrace.cycles-pp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>>>        13.65 ± 76%      -8.4        5.29 ±168%  perf-profile.calltrace.cycles-pp.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>>>        13.37 ± 76%      -8.2        5.18 ±168%  perf-profile.calltrace.cycles-pp.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault
>>>        13.35 ± 76%      -8.2        5.18 ±168%  perf-profile.calltrace.cycles-pp.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault
>>>        13.23 ± 76%      -8.1        5.13 ±168%  perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_string.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault
>>>         3.59 ± 78%      -2.2        1.39 ±169%  perf-profile.calltrace.cycles-pp.__mutex_lock.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>>>        17.35 ± 77%     -10.6        6.73 ±169%  perf-profile.children.cycles-pp.asm_exc_page_fault
>>>        17.32 ± 77%     -10.6        6.72 ±168%  perf-profile.children.cycles-pp.do_user_addr_fault
>>>        17.32 ± 77%     -10.6        6.72 ±168%  perf-profile.children.cycles-pp.exc_page_fault
>>>        17.30 ± 77%     -10.6        6.71 ±168%  perf-profile.children.cycles-pp.handle_mm_fault
>>>        17.28 ± 77%     -10.6        6.70 ±169%  perf-profile.children.cycles-pp.hugetlb_fault
>>>        13.65 ± 76%      -8.4        5.29 ±168%  perf-profile.children.cycles-pp.hugetlb_wp
>>>        13.37 ± 76%      -8.2        5.18 ±168%  perf-profile.children.cycles-pp.copy_user_large_folio
>>>        13.35 ± 76%      -8.2        5.18 ±168%  perf-profile.children.cycles-pp.copy_subpage
>>>        13.34 ± 76%      -8.2        5.17 ±168%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
>>>         3.59 ± 78%      -2.2        1.39 ±169%  perf-profile.children.cycles-pp.__mutex_lock
>>>        13.24 ± 76%      -8.1        5.13 ±168%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
>>> Disclaimer:
>>> Results have been estimated based on internal Intel analysis and are provided
>>> for informational purposes only. Any difference in system hardware or software
>>> design or configuration may affect actual performance.
>>>
> 
> --
> Best Regards,
> Huang, Ying

