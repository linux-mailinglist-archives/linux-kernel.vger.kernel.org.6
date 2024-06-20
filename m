Return-Path: <linux-kernel+bounces-222179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D043F90FDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B06728487C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE014D8BA;
	Thu, 20 Jun 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1MPVlq0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDFB4D8B6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869223; cv=none; b=Ks54kYFPwd5n9YT2I8of7Bgwnwj2HXgk1W63llZZrO+Bs68vY37mGjRTvF3YY/ANqkGFiHYiFotlcJM3uYVNtBgADo/ETu4EzAx9FFQr9B6IOprnSGDkGKk9pNPkXolb10ERsSEwsviWjN5p/WU+mKEpwTpUgejTRh9GThx58w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869223; c=relaxed/simple;
	bh=eys4YZfmghIr8LFi5aEMDS8OaDCEOgOq5PfNE6K2/WQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EXAtaD48DIi078I/0VHsVl0VV3RnWg1+beuZJRQrOw3RoPpxARlT+dtRNVBB70cvU0PU4+Nwtn/E0okobD5aI25WP2nZIPRDPWp4Bbzmxk7bRRP+bTlUsfNggb9m3O29LBNfs/5gX/trWxJuHLJiai8/2Ndn9bZZS+CwEjVEVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1MPVlq0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718869221; x=1750405221;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=eys4YZfmghIr8LFi5aEMDS8OaDCEOgOq5PfNE6K2/WQ=;
  b=B1MPVlq0ZLmxR5h1Xuv5uK8hRO/twb1fluHiB0IIoRpWdL9bSc1Kvrza
   ImqXTLiWc/JrPHQgSwvy3JaZu/xcy3GRhnWjCWsON6XWiAHp2MbFTAKwx
   XIlNQR65Ub2b3pJ0E0VH2gm1syumbwP0zC8pREfY46T0ZiJf/XCzirhxs
   yVq9kmhuEeTkAfquC68sPdebHonhqq0hdUNdv8KfAjDm3LFuX+n10ZN5U
   Kawj6ph4zx5gKeKrQuDfo93tGKKjq2mkzBfpc+U+Ze3+eD2EuJ+zakk5u
   HWBegCTKUBP/4wVDyCeNY7BoQkEREKj1XGuK7HYA9eq8L3PXbTjyDwrT3
   Q==;
X-CSE-ConnectionGUID: eBG7VdoARGq9AH2dBNzHIw==
X-CSE-MsgGUID: bexizDj/TpmUCzgy2WrC1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15704466"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15704466"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 00:40:20 -0700
X-CSE-ConnectionGUID: Xxn6JXzkR/OcK4tW30u5cg==
X-CSE-MsgGUID: PRu+wMO4TYyD/lD6rS00cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42014316"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 00:40:17 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: kernel test robot <oliver.sang@intel.com>,  <oe-lkp@lists.linux.dev>,
  <lkp@intel.com>,  <linux-kernel@vger.kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,  John
 Hubbard <jhubbard@nvidia.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,
  Mel Gorman <mgorman@techsingularity.net>,  Ryan Roberts
 <ryan.roberts@arm.com>,  <linux-mm@kvack.org>,  <feng.tang@intel.com>,
  <fengwei.yin@intel.com>
Subject: Re: [linus:master] [mm] d2136d749d: vm-scalability.throughput -7.1%
 regression
In-Reply-To: <24a985cf-1bbf-41f9-b234-24f000164fa6@linux.alibaba.com> (Baolin
	Wang's message of "Thu, 20 Jun 2024 14:07:45 +0800")
References: <202406201010.a1344783-oliver.sang@intel.com>
	<24a985cf-1bbf-41f9-b234-24f000164fa6@linux.alibaba.com>
Date: Thu, 20 Jun 2024 15:38:26 +0800
Message-ID: <87bk3w2he5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 2024/6/20 10:39, kernel test robot wrote:
>> Hello,
>> kernel test robot noticed a -7.1% regression of
>> vm-scalability.throughput on:
>> commit: d2136d749d76af980b3accd72704eea4eab625bd ("mm: support
>> multi-size THP numa balancing")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> [still regression on linus/master
>> 92e5605a199efbaee59fb19e15d6cc2103a04ec2]
>> testcase: vm-scalability
>> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.0=
0GHz (Ice Lake) with 256G memory
>> parameters:
>> 	runtime: 300s
>> 	size: 512G
>> 	test: anon-cow-rand-hugetlb
>> 	cpufreq_governor: performance
>
> Thanks for reporting. IIUC numa balancing will not scan hugetlb VMA,
> I'm not sure how this patch affects the performance of hugetlb cow,
> but let me try to reproduce it.
>
>
>> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202406201010.a1344783-oliver.sa=
ng@intel.com
>> Details are as below:
>> ------------------------------------------------------------------------=
-------------------------->
>> The kernel config and materials to reproduce are available at:
>> https://download.01.org/0day-ci/archive/20240620/202406201010.a1344783-o=
liver.sang@intel.com
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/te=
stcase:
>>    gcc-13/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s=
/512G/lkp-icl-2sp2/anon-cow-rand-hugetlb/vm-scalability
>> commit:
>>    6b0ed7b3c7 ("mm: factor out the numa mapping rebuilding into a new he=
lper")
>>    d2136d749d ("mm: support multi-size THP numa balancing")
>> 6b0ed7b3c77547d2 d2136d749d76af980b3accd7270
>> ---------------- ---------------------------
>>           %stddev     %change         %stddev
>>               \          |                \
>>       12.02            -1.3       10.72 =C2=B1  4%  mpstat.cpu.all.sys%
>>     1228757            +3.0%    1265679        proc-vmstat.pgfault

Also from other proc-vmstat stats,

     21770  36%      +6.1%      23098  28%  proc-vmstat.numa_hint_faults
      6168 107%     +48.8%       9180  18%  proc-vmstat.numa_hint_faults_lo=
cal
    154537  15%     +23.5%     190883  17%  proc-vmstat.numa_pte_updates

After your patch, more hint page faults occurs, I think this is expected.

Then, tasks may be moved between sockets because of that, so that some
hugetlb page access becomes remote?

>>     7392513            -7.1%    6865649        vm-scalability.throughput
>>       17356            +9.4%      18986        vm-scalability.time.user_=
time
>>        0.32 =C2=B1 22%     -36.9%       0.20 =C2=B1 17%  sched_debug.cfs=
_rq:/.h_nr_running.stddev
>>       28657 =C2=B1 86%     -90.8%       2640 =C2=B1 19%  sched_debug.cfs=
_rq:/.load.stddev
>>        0.28 =C2=B1 35%     -52.1%       0.13 =C2=B1 29%  sched_debug.cfs=
_rq:/.nr_running.stddev
>>      299.88 =C2=B1 27%     -39.6%     181.04 =C2=B1 23%  sched_debug.cfs=
_rq:/.runnable_avg.stddev
>>      284.88 =C2=B1 32%     -44.0%     159.65 =C2=B1 27%  sched_debug.cfs=
_rq:/.util_avg.stddev
>>        0.32 =C2=B1 22%     -37.2%       0.20 =C2=B1 17%  sched_debug.cpu=
.nr_running.stddev
>>   1.584e+10 =C2=B1  2%      -6.9%  1.476e+10 =C2=B1  3%  perf-stat.i.bra=
nch-instructions
>>    11673151 =C2=B1  3%      -6.3%   10935072 =C2=B1  4%  perf-stat.i.bra=
nch-misses
>>        4.90            +3.5%       5.07        perf-stat.i.cpi
>>      333.40            +7.5%     358.32        perf-stat.i.cycles-betwee=
n-cache-misses
>>   6.787e+10 =C2=B1  2%      -6.8%  6.324e+10 =C2=B1  3%  perf-stat.i.ins=
tructions
>>        0.25            -6.2%       0.24        perf-stat.i.ipc
>>        4.19            +7.5%       4.51        perf-stat.overall.cpi
>>      323.02            +7.4%     346.94        perf-stat.overall.cycles-=
between-cache-misses
>>        0.24            -7.0%       0.22        perf-stat.overall.ipc
>>   1.549e+10 =C2=B1  2%      -6.8%  1.444e+10 =C2=B1  3%  perf-stat.ps.br=
anch-instructions
>>   6.634e+10 =C2=B1  2%      -6.7%  6.186e+10 =C2=B1  3%  perf-stat.ps.in=
structions
>>       17.33 =C2=B1 77%     -10.6        6.72 =C2=B1169%  perf-profile.ca=
lltrace.cycles-pp.asm_exc_page_fault.do_access
>>       17.30 =C2=B1 77%     -10.6        6.71 =C2=B1169%  perf-profile.ca=
lltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
>>       17.30 =C2=B1 77%     -10.6        6.71 =C2=B1169%  perf-profile.ca=
lltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_a=
ccess
>>       17.28 =C2=B1 77%     -10.6        6.70 =C2=B1169%  perf-profile.ca=
lltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc=
_page_fault.do_access
>>       17.27 =C2=B1 77%     -10.6        6.70 =C2=B1169%  perf-profile.ca=
lltrace.cycles-pp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page=
_fault.asm_exc_page_fault
>>       13.65 =C2=B1 76%      -8.4        5.29 =C2=B1168%  perf-profile.ca=
lltrace.cycles-pp.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fau=
lt.exc_page_fault
>>       13.37 =C2=B1 76%      -8.2        5.18 =C2=B1168%  perf-profile.ca=
lltrace.cycles-pp.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_=
fault.do_user_addr_fault
>>       13.35 =C2=B1 76%      -8.2        5.18 =C2=B1168%  perf-profile.ca=
lltrace.cycles-pp.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fau=
lt.handle_mm_fault
>>       13.23 =C2=B1 76%      -8.1        5.13 =C2=B1168%  perf-profile.ca=
lltrace.cycles-pp.copy_mc_enhanced_fast_string.copy_subpage.copy_user_large=
_folio.hugetlb_wp.hugetlb_fault
>>        3.59 =C2=B1 78%      -2.2        1.39 =C2=B1169%  perf-profile.ca=
lltrace.cycles-pp.__mutex_lock.hugetlb_fault.handle_mm_fault.do_user_addr_f=
ault.exc_page_fault
>>       17.35 =C2=B1 77%     -10.6        6.73 =C2=B1169%  perf-profile.ch=
ildren.cycles-pp.asm_exc_page_fault
>>       17.32 =C2=B1 77%     -10.6        6.72 =C2=B1168%  perf-profile.ch=
ildren.cycles-pp.do_user_addr_fault
>>       17.32 =C2=B1 77%     -10.6        6.72 =C2=B1168%  perf-profile.ch=
ildren.cycles-pp.exc_page_fault
>>       17.30 =C2=B1 77%     -10.6        6.71 =C2=B1168%  perf-profile.ch=
ildren.cycles-pp.handle_mm_fault
>>       17.28 =C2=B1 77%     -10.6        6.70 =C2=B1169%  perf-profile.ch=
ildren.cycles-pp.hugetlb_fault
>>       13.65 =C2=B1 76%      -8.4        5.29 =C2=B1168%  perf-profile.ch=
ildren.cycles-pp.hugetlb_wp
>>       13.37 =C2=B1 76%      -8.2        5.18 =C2=B1168%  perf-profile.ch=
ildren.cycles-pp.copy_user_large_folio
>>       13.35 =C2=B1 76%      -8.2        5.18 =C2=B1168%  perf-profile.ch=
ildren.cycles-pp.copy_subpage
>>       13.34 =C2=B1 76%      -8.2        5.17 =C2=B1168%  perf-profile.ch=
ildren.cycles-pp.copy_mc_enhanced_fast_string
>>        3.59 =C2=B1 78%      -2.2        1.39 =C2=B1169%  perf-profile.ch=
ildren.cycles-pp.__mutex_lock
>>       13.24 =C2=B1 76%      -8.1        5.13 =C2=B1168%  perf-profile.se=
lf.cycles-pp.copy_mc_enhanced_fast_string
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are pro=
vided
>> for informational purposes only. Any difference in system hardware or so=
ftware
>> design or configuration may affect actual performance.
>>=20

--
Best Regards,
Huang, Ying

