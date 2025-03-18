Return-Path: <linux-kernel+bounces-565479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D3CA66941
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3070A17B777
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A21BD4F7;
	Tue, 18 Mar 2025 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+MFPizZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C219E997
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275632; cv=none; b=jpPI/0MMSq4qvVN3dgvg7545PiqCBc4Vl9oF3OcYvPLj7jfckhS/kjnm4mci7lpqo7pVvBS106SgMMiSYju182xvlmXy/1EtyHE3FyIKNrEDxjLShyW/MSax0OV6aQ/zpWuPNTkmlopVSJcH9N+g+Z/aaP1JUtEcntWp/pWVVok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275632; c=relaxed/simple;
	bh=rnCOXBiB6SkL9EQ0o/IZslWVUweBwi0bgWpDfTFQtP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QldhEvQCj26Zk07zuofAQtF4HILR8jj/EaVodAF4qaYaF/OAjHpev3QTg5wk9nnJ1dsUm16dhPXpUoxzI33mPUAYDCrd7QS/V/hJtuKVvC2TmjRhwJTNBcbY7e+pRvYAJUDLZox9qELdsdBshflTcqF2eltm22ylFBpcITbro/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+MFPizZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742275630; x=1773811630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rnCOXBiB6SkL9EQ0o/IZslWVUweBwi0bgWpDfTFQtP0=;
  b=J+MFPizZmPFZibCRwk9diReu+SOhcgLb4ammJHvqxRcJyLb0XOpA+xGQ
   s0QsKNp0QDTCqE9Hb/IR4Y1hc9C+IDd/ydrsZIpunWvy5XPY8h/hi5h8V
   sn3w38hZSvELFnC7JeKVmkFh0Xv3hIR5/YkvEWpKV8ntO13nwrScO00Qm
   1mUNjPmwk8s4jIDOEHS3KW4kRob0czTsNXbp/9S3eQGXwaHbD970zM+qV
   87jzKpJjjdiGggIBjoigfJZJtG8HbT3brWFKLV1xJvVqIQOsDPknfP9hE
   5L2qafKORmZOEmXYpGeHfMaDqoxDc+DydhST2s8ql5h+hsM7RXqN83C7t
   A==;
X-CSE-ConnectionGUID: B9qbDx64QEOOiwSzb4s+OA==
X-CSE-MsgGUID: qjw/oEDPT4GjDuyzwHG++w==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54067144"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="54067144"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 22:27:09 -0700
X-CSE-ConnectionGUID: HxTkMewBRCil1uka5Odhkw==
X-CSE-MsgGUID: rGc//BNBTZyjDfCJYPv9vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="122653565"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 17 Mar 2025 22:27:07 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuPTb-000DQp-1Q;
	Tue, 18 Mar 2025 05:26:59 +0000
Date: Tue, 18 Mar 2025 13:24:50 +0800
From: kernel test robot <lkp@intel.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>
Subject: kernel/crash_core.c:130:1: warning: 'retain' attribute ignored
Message-ID: <202503181342.ua9nDRGr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc444ada131001812c5d10b380837238c9cf7c8c
commit: 7bdcedd5c8fb88e7176b93812b139eca5fe0aa46 bpf: Harden __bpf_kfunc tag against linker kfunc removal
date:   9 months ago
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20250318/202503181342.ua9nDRGr-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503181342.ua9nDRGr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503181342.ua9nDRGr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/crash_core.c:130:1: warning: 'retain' attribute ignored [-Wattributes]
     130 | {
         | ^
--
>> kernel/cgroup/rstat.c:86:1: warning: 'retain' attribute ignored [-Wattributes]
      86 | {
         | ^
   kernel/cgroup/rstat.c:350:1: warning: 'retain' attribute ignored [-Wattributes]
     350 | {
         | ^
--
>> kernel/trace/bpf_trace.c:1289:1: warning: 'retain' attribute ignored [-Wattributes]
    1289 | {
         | ^
   kernel/trace/bpf_trace.c:1338:1: warning: 'retain' attribute ignored [-Wattributes]
    1338 | {
         | ^
   kernel/trace/bpf_trace.c:1362:1: warning: 'retain' attribute ignored [-Wattributes]
    1362 | {
         | ^
   kernel/trace/bpf_trace.c:1384:1: warning: 'retain' attribute ignored [-Wattributes]
    1384 | {
         | ^
   kernel/trace/bpf_trace.c:1457:1: warning: 'retain' attribute ignored [-Wattributes]
    1457 | {
         | ^
   kernel/trace/bpf_trace.c:3523:1: warning: 'retain' attribute ignored [-Wattributes]
    3523 | {
         | ^
   kernel/trace/bpf_trace.c:3531:1: warning: 'retain' attribute ignored [-Wattributes]
    3531 | {
         | ^
--
>> kernel/bpf/helpers.c:2050:1: warning: 'retain' attribute ignored [-Wattributes]
    2050 | {
         | ^
   kernel/bpf/helpers.c:2064:1: warning: 'retain' attribute ignored [-Wattributes]
    2064 | {
         | ^
   kernel/bpf/helpers.c:2095:1: warning: 'retain' attribute ignored [-Wattributes]
    2095 | {
         | ^
   kernel/bpf/helpers.c:2103:1: warning: 'retain' attribute ignored [-Wattributes]
    2103 | {
         | ^
   kernel/bpf/helpers.c:2109:1: warning: 'retain' attribute ignored [-Wattributes]
    2109 | {
         | ^
   kernel/bpf/helpers.c:2156:1: warning: 'retain' attribute ignored [-Wattributes]
    2156 | {
         | ^
   kernel/bpf/helpers.c:2166:1: warning: 'retain' attribute ignored [-Wattributes]
    2166 | {
         | ^
   kernel/bpf/helpers.c:2197:1: warning: 'retain' attribute ignored [-Wattributes]
    2197 | {
         | ^
   kernel/bpf/helpers.c:2202:1: warning: 'retain' attribute ignored [-Wattributes]
    2202 | {
         | ^
   kernel/bpf/helpers.c:2208:1: warning: 'retain' attribute ignored [-Wattributes]
    2208 | {
         | ^
   kernel/bpf/helpers.c:2265:1: warning: 'retain' attribute ignored [-Wattributes]
    2265 | {
         | ^
   kernel/bpf/helpers.c:2273:1: warning: 'retain' attribute ignored [-Wattributes]
    2273 | {
         | ^
   kernel/bpf/helpers.c:2286:1: warning: 'retain' attribute ignored [-Wattributes]
    2286 | {
         | ^
   kernel/bpf/helpers.c:2297:1: warning: 'retain' attribute ignored [-Wattributes]
    2297 | {
         | ^
   kernel/bpf/helpers.c:2302:1: warning: 'retain' attribute ignored [-Wattributes]
    2302 | {
         | ^
   kernel/bpf/helpers.c:2315:1: warning: 'retain' attribute ignored [-Wattributes]
    2315 | {
         | ^
   kernel/bpf/helpers.c:2327:1: warning: 'retain' attribute ignored [-Wattributes]
    2327 | {
         | ^
   kernel/bpf/helpers.c:2332:1: warning: 'retain' attribute ignored [-Wattributes]
    2332 | {
         | ^
   kernel/bpf/helpers.c:2345:1: warning: 'retain' attribute ignored [-Wattributes]
    2345 | {
         | ^
   kernel/bpf/helpers.c:2365:1: warning: 'retain' attribute ignored [-Wattributes]
    2365 | {
         | ^
   kernel/bpf/helpers.c:2386:1: warning: 'retain' attribute ignored [-Wattributes]
    2386 | {
         | ^
   kernel/bpf/helpers.c:2406:1: warning: 'retain' attribute ignored [-Wattributes]
    2406 | {
         | ^
   kernel/bpf/helpers.c:2422:1: warning: 'retain' attribute ignored [-Wattributes]
    2422 | {
         | ^
   kernel/bpf/helpers.c:2464:1: warning: 'retain' attribute ignored [-Wattributes]
    2464 | {
         | ^
   kernel/bpf/helpers.c:2548:1: warning: 'retain' attribute ignored [-Wattributes]
    2548 | {
         | ^
   kernel/bpf/helpers.c:2578:1: warning: 'retain' attribute ignored [-Wattributes]
    2578 | {
         | ^
   kernel/bpf/helpers.c:2596:1: warning: 'retain' attribute ignored [-Wattributes]
    2596 | {
         | ^
   kernel/bpf/helpers.c:2601:1: warning: 'retain' attribute ignored [-Wattributes]
    2601 | {
         | ^
   kernel/bpf/helpers.c:2609:1: warning: 'retain' attribute ignored [-Wattributes]
    2609 | {
         | ^
   kernel/bpf/helpers.c:2618:1: warning: 'retain' attribute ignored [-Wattributes]
    2618 | {
         | ^
   kernel/bpf/helpers.c:2630:1: warning: 'retain' attribute ignored [-Wattributes]
    2630 | {
         | ^
   kernel/bpf/helpers.c:2635:1: warning: 'retain' attribute ignored [-Wattributes]
    2635 | {
         | ^
   kernel/bpf/helpers.c:2640:1: warning: 'retain' attribute ignored [-Wattributes]
    2640 | {
         | ^
   kernel/bpf/helpers.c:2645:1: warning: 'retain' attribute ignored [-Wattributes]
    2645 | {
--
>> kernel/bpf/bpf_iter.c:788:1: warning: 'retain' attribute ignored [-Wattributes]
     788 | {
         | ^
   kernel/bpf/bpf_iter.c:819:1: warning: 'retain' attribute ignored [-Wattributes]
     819 | {
         | ^
   kernel/bpf/bpf_iter.c:838:1: warning: 'retain' attribute ignored [-Wattributes]
     838 | {
         | ^
--
>> kernel/bpf/map_iter.c:199:1: warning: 'retain' attribute ignored [-Wattributes]
     199 | {
         | ^
--
>> kernel/bpf/task_iter.c:827:1: warning: 'retain' attribute ignored [-Wattributes]
     827 | {
         | ^
   kernel/bpf/task_iter.c:870:1: warning: 'retain' attribute ignored [-Wattributes]
     870 | {
         | ^
   kernel/bpf/task_iter.c:879:1: warning: 'retain' attribute ignored [-Wattributes]
     879 | {
         | ^
   kernel/bpf/task_iter.c:905:1: warning: 'retain' attribute ignored [-Wattributes]
     905 | {
         | ^
   kernel/bpf/task_iter.c:929:1: warning: 'retain' attribute ignored [-Wattributes]
     929 | {
         | ^
   kernel/bpf/task_iter.c:938:1: warning: 'retain' attribute ignored [-Wattributes]
     938 | {
         | ^
   kernel/bpf/task_iter.c:974:1: warning: 'retain' attribute ignored [-Wattributes]
     974 | {
         | ^
   kernel/bpf/task_iter.c:1005:1: warning: 'retain' attribute ignored [-Wattributes]
    1005 | {
         | ^
   kernel/bpf/task_iter.c:1034:1: warning: 'retain' attribute ignored [-Wattributes]
    1034 | {
         | ^
--
>> kernel/bpf/cgroup_iter.c:312:1: warning: 'retain' attribute ignored [-Wattributes]
     312 | {
         | ^
   kernel/bpf/cgroup_iter.c:335:1: warning: 'retain' attribute ignored [-Wattributes]
     335 | {
         | ^
   kernel/bpf/cgroup_iter.c:356:1: warning: 'retain' attribute ignored [-Wattributes]
     356 | {
         | ^
--
>> kernel/bpf/cpumask.c:50:1: warning: 'retain' attribute ignored [-Wattributes]
      50 | {
         | ^
   kernel/bpf/cpumask.c:76:1: warning: 'retain' attribute ignored [-Wattributes]
      76 | {
         | ^
   kernel/bpf/cpumask.c:90:1: warning: 'retain' attribute ignored [-Wattributes]
      90 | {
         | ^
   kernel/bpf/cpumask.c:100:1: warning: 'retain' attribute ignored [-Wattributes]
     100 | {
         | ^
   kernel/bpf/cpumask.c:113:1: warning: 'retain' attribute ignored [-Wattributes]
     113 | {
         | ^
   kernel/bpf/cpumask.c:126:1: warning: 'retain' attribute ignored [-Wattributes]
     126 | {
         | ^
   kernel/bpf/cpumask.c:141:1: warning: 'retain' attribute ignored [-Wattributes]
     141 | {
         | ^
   kernel/bpf/cpumask.c:151:1: warning: 'retain' attribute ignored [-Wattributes]
     151 | {
         | ^
   kernel/bpf/cpumask.c:164:1: warning: 'retain' attribute ignored [-Wattributes]
     164 | {
         | ^
   kernel/bpf/cpumask.c:181:1: warning: 'retain' attribute ignored [-Wattributes]
     181 | {
         | ^
   kernel/bpf/cpumask.c:198:1: warning: 'retain' attribute ignored [-Wattributes]
     198 | {
         | ^
   kernel/bpf/cpumask.c:216:1: warning: 'retain' attribute ignored [-Wattributes]
     216 | {
         | ^
   kernel/bpf/cpumask.c:228:1: warning: 'retain' attribute ignored [-Wattributes]
     228 | {
         | ^
   kernel/bpf/cpumask.c:237:1: warning: 'retain' attribute ignored [-Wattributes]
     237 | {
         | ^
   kernel/bpf/cpumask.c:256:1: warning: 'retain' attribute ignored [-Wattributes]
     256 | {
         | ^
   kernel/bpf/cpumask.c:271:1: warning: 'retain' attribute ignored [-Wattributes]
     271 | {
         | ^
   kernel/bpf/cpumask.c:286:1: warning: 'retain' attribute ignored [-Wattributes]
     286 | {
         | ^
   kernel/bpf/cpumask.c:302:1: warning: 'retain' attribute ignored [-Wattributes]
     302 | {
         | ^
   kernel/bpf/cpumask.c:318:1: warning: 'retain' attribute ignored [-Wattributes]
     318 | {
         | ^
   kernel/bpf/cpumask.c:334:1: warning: 'retain' attribute ignored [-Wattributes]
     334 | {
         | ^
   kernel/bpf/cpumask.c:349:1: warning: 'retain' attribute ignored [-Wattributes]
     349 | {
         | ^
   kernel/bpf/cpumask.c:364:1: warning: 'retain' attribute ignored [-Wattributes]
     364 | {
         | ^
   kernel/bpf/cpumask.c:376:1: warning: 'retain' attribute ignored [-Wattributes]
     376 | {
         | ^
   kernel/bpf/cpumask.c:391:1: warning: 'retain' attribute ignored [-Wattributes]
     391 | {
         | ^
   kernel/bpf/cpumask.c:410:1: warning: 'retain' attribute ignored [-Wattributes]
     410 | {
         | ^
   kernel/bpf/cpumask.c:421:1: warning: 'retain' attribute ignored [-Wattributes]
     421 | {
         | ^
--
>> kernel/bpf/crypto.c:148:1: warning: 'retain' attribute ignored [-Wattributes]
     148 | {
         | ^
   kernel/bpf/crypto.c:244:1: warning: 'retain' attribute ignored [-Wattributes]
     244 | {
         | ^
   kernel/bpf/crypto.c:259:1: warning: 'retain' attribute ignored [-Wattributes]
     259 | {
         | ^
   kernel/bpf/crypto.c:317:1: warning: 'retain' attribute ignored [-Wattributes]
     317 | {
         | ^
   kernel/bpf/crypto.c:334:1: warning: 'retain' attribute ignored [-Wattributes]
     334 | {
         | ^


vim +/retain +130 kernel/crash_core.c

02aff848053381 Baoquan He 2024-01-24  128  
02aff848053381 Baoquan He 2024-01-24  129  __bpf_kfunc void crash_kexec(struct pt_regs *regs)
02aff848053381 Baoquan He 2024-01-24 @130  {
02aff848053381 Baoquan He 2024-01-24  131  	int old_cpu, this_cpu;
02aff848053381 Baoquan He 2024-01-24  132  
02aff848053381 Baoquan He 2024-01-24  133  	/*
02aff848053381 Baoquan He 2024-01-24  134  	 * Only one CPU is allowed to execute the crash_kexec() code as with
02aff848053381 Baoquan He 2024-01-24  135  	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
02aff848053381 Baoquan He 2024-01-24  136  	 * may stop each other.  To exclude them, we use panic_cpu here too.
02aff848053381 Baoquan He 2024-01-24  137  	 */
02aff848053381 Baoquan He 2024-01-24  138  	old_cpu = PANIC_CPU_INVALID;
02aff848053381 Baoquan He 2024-01-24  139  	this_cpu = raw_smp_processor_id();
02aff848053381 Baoquan He 2024-01-24  140  
02aff848053381 Baoquan He 2024-01-24  141  	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
02aff848053381 Baoquan He 2024-01-24  142  		/* This is the 1st CPU which comes here, so go ahead. */
02aff848053381 Baoquan He 2024-01-24  143  		__crash_kexec(regs);
02aff848053381 Baoquan He 2024-01-24  144  
02aff848053381 Baoquan He 2024-01-24  145  		/*
02aff848053381 Baoquan He 2024-01-24  146  		 * Reset panic_cpu to allow another panic()/crash_kexec()
02aff848053381 Baoquan He 2024-01-24  147  		 * call.
02aff848053381 Baoquan He 2024-01-24  148  		 */
02aff848053381 Baoquan He 2024-01-24  149  		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
02aff848053381 Baoquan He 2024-01-24  150  	}
02aff848053381 Baoquan He 2024-01-24  151  }
02aff848053381 Baoquan He 2024-01-24  152  

:::::: The code at line 130 was first introduced by commit
:::::: 02aff8480533817a29e820729360866441d7403d crash: split crash dumping code out from kexec_core.c

:::::: TO: Baoquan He <bhe@redhat.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

