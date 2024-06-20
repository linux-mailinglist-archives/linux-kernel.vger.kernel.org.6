Return-Path: <linux-kernel+bounces-222073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9490FC81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC23C1C22FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB6611CA1;
	Thu, 20 Jun 2024 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xj8Vyy5f"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F4B657
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863673; cv=none; b=WeezvlXEFlebwG7Yv8TSQMjJRzP0Tzw32cR0KlALGuiIKWmVfgdkQ7bCuVToVR36teFVZ4RdVqtBAiGP+tVr2pAHxiH8RC0+fFw6bN7kBo19Z33Z5KCjuIVnO23zQh4Uj3V2v99CIEfkIuWpI1CWOtCvQ/xUYadiLdbyiiqpy4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863673; c=relaxed/simple;
	bh=FStbBfdg+j7XfIBBW9IRfCjjixtzBucuCdiKdH1puc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP+sWnn8YBD4a1K4vaSUjZB8hSwg37NvhD3GC6bVxB9OBtaC1wBYDSo5Sjb93Ofnn4vxpiC+GLKVMXqGG6iBY17Fsmx0B533ZgJdORYyAfnBleJDnvHAyFf8XATJbQ7UAdziP/Gh7KiB66Z7pQXRGQjjkwqvvTw2QHDvpBx63AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xj8Vyy5f; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718863668; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rxs7RYOCJ6F7fVorwZRw+xVI5v9xMBcKEYUN83Xwho4=;
	b=xj8Vyy5fCYqIo3QGjQ2Vc5v7dtIdy9Xt5etCvMR86/UG6afjszthCn0k2BVEPGuUHNhMNEUmPkeHh5kxI8W3ul+3Ayl78stCN+UtlF95ANfVS/SA9QX+4TwtlercbRX0Nxg5/DyvVkLcYfu4v+5wlBS86Awa+HW1cMSv7XDncQI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8qFaN3_1718863665;
Received: from 30.97.56.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8qFaN3_1718863665)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 14:07:46 +0800
Message-ID: <24a985cf-1bbf-41f9-b234-24f000164fa6@linux.alibaba.com>
Date: Thu, 20 Jun 2024 14:07:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] d2136d749d: vm-scalability.throughput -7.1%
 regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
 <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Mel Gorman <mgorman@techsingularity.net>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
 feng.tang@intel.com, fengwei.yin@intel.com
References: <202406201010.a1344783-oliver.sang@intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <202406201010.a1344783-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/20 10:39, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -7.1% regression of vm-scalability.throughput on:
> 
> 
> commit: d2136d749d76af980b3accd72704eea4eab625bd ("mm: support multi-size THP numa balancing")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [still regression on linus/master 92e5605a199efbaee59fb19e15d6cc2103a04ec2]
> 
> 
> testcase: vm-scalability
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	runtime: 300s
> 	size: 512G
> 	test: anon-cow-rand-hugetlb
> 	cpufreq_governor: performance

Thanks for reporting. IIUC numa balancing will not scan hugetlb VMA, I'm 
not sure how this patch affects the performance of hugetlb cow, but let 
me try to reproduce it.


> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202406201010.a1344783-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240620/202406201010.a1344783-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>    gcc-13/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/512G/lkp-icl-2sp2/anon-cow-rand-hugetlb/vm-scalability
> 
> commit:
>    6b0ed7b3c7 ("mm: factor out the numa mapping rebuilding into a new helper")
>    d2136d749d ("mm: support multi-size THP numa balancing")
> 
> 6b0ed7b3c77547d2 d2136d749d76af980b3accd7270
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>       12.02            -1.3       10.72 ±  4%  mpstat.cpu.all.sys%
>     1228757            +3.0%    1265679        proc-vmstat.pgfault
>     7392513            -7.1%    6865649        vm-scalability.throughput
>       17356            +9.4%      18986        vm-scalability.time.user_time
>        0.32 ± 22%     -36.9%       0.20 ± 17%  sched_debug.cfs_rq:/.h_nr_running.stddev
>       28657 ± 86%     -90.8%       2640 ± 19%  sched_debug.cfs_rq:/.load.stddev
>        0.28 ± 35%     -52.1%       0.13 ± 29%  sched_debug.cfs_rq:/.nr_running.stddev
>      299.88 ± 27%     -39.6%     181.04 ± 23%  sched_debug.cfs_rq:/.runnable_avg.stddev
>      284.88 ± 32%     -44.0%     159.65 ± 27%  sched_debug.cfs_rq:/.util_avg.stddev
>        0.32 ± 22%     -37.2%       0.20 ± 17%  sched_debug.cpu.nr_running.stddev
>   1.584e+10 ±  2%      -6.9%  1.476e+10 ±  3%  perf-stat.i.branch-instructions
>    11673151 ±  3%      -6.3%   10935072 ±  4%  perf-stat.i.branch-misses
>        4.90            +3.5%       5.07        perf-stat.i.cpi
>      333.40            +7.5%     358.32        perf-stat.i.cycles-between-cache-misses
>   6.787e+10 ±  2%      -6.8%  6.324e+10 ±  3%  perf-stat.i.instructions
>        0.25            -6.2%       0.24        perf-stat.i.ipc
>        4.19            +7.5%       4.51        perf-stat.overall.cpi
>      323.02            +7.4%     346.94        perf-stat.overall.cycles-between-cache-misses
>        0.24            -7.0%       0.22        perf-stat.overall.ipc
>   1.549e+10 ±  2%      -6.8%  1.444e+10 ±  3%  perf-stat.ps.branch-instructions
>   6.634e+10 ±  2%      -6.7%  6.186e+10 ±  3%  perf-stat.ps.instructions
>       17.33 ± 77%     -10.6        6.72 ±169%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
>       17.30 ± 77%     -10.6        6.71 ±169%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
>       17.30 ± 77%     -10.6        6.71 ±169%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>       17.28 ± 77%     -10.6        6.70 ±169%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>       17.27 ± 77%     -10.6        6.70 ±169%  perf-profile.calltrace.cycles-pp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       13.65 ± 76%      -8.4        5.29 ±168%  perf-profile.calltrace.cycles-pp.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>       13.37 ± 76%      -8.2        5.18 ±168%  perf-profile.calltrace.cycles-pp.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault
>       13.35 ± 76%      -8.2        5.18 ±168%  perf-profile.calltrace.cycles-pp.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault
>       13.23 ± 76%      -8.1        5.13 ±168%  perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_string.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault
>        3.59 ± 78%      -2.2        1.39 ±169%  perf-profile.calltrace.cycles-pp.__mutex_lock.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>       17.35 ± 77%     -10.6        6.73 ±169%  perf-profile.children.cycles-pp.asm_exc_page_fault
>       17.32 ± 77%     -10.6        6.72 ±168%  perf-profile.children.cycles-pp.do_user_addr_fault
>       17.32 ± 77%     -10.6        6.72 ±168%  perf-profile.children.cycles-pp.exc_page_fault
>       17.30 ± 77%     -10.6        6.71 ±168%  perf-profile.children.cycles-pp.handle_mm_fault
>       17.28 ± 77%     -10.6        6.70 ±169%  perf-profile.children.cycles-pp.hugetlb_fault
>       13.65 ± 76%      -8.4        5.29 ±168%  perf-profile.children.cycles-pp.hugetlb_wp
>       13.37 ± 76%      -8.2        5.18 ±168%  perf-profile.children.cycles-pp.copy_user_large_folio
>       13.35 ± 76%      -8.2        5.18 ±168%  perf-profile.children.cycles-pp.copy_subpage
>       13.34 ± 76%      -8.2        5.17 ±168%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
>        3.59 ± 78%      -2.2        1.39 ±169%  perf-profile.children.cycles-pp.__mutex_lock
>       13.24 ± 76%      -8.1        5.13 ±168%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 

