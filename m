Return-Path: <linux-kernel+bounces-516390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B374AA3708D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 21:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6805C170059
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78041EA7EF;
	Sat, 15 Feb 2025 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJV/5TsP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCB13DDAE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739650651; cv=none; b=uveGqKW5iVddDdjkO5mOK9fy0GmvsZX9n1QhuJO8WUA9d00decQ00jW75FasoWVVcwrYdkJnyu/GtMZM7LHFzsfTydzXW4oqC8wJQnVSfK++PBb4uXz4s1do6mBnqLpN4ATec1PtzNcrtk5iZmEFQksftjRF3u8jWwQhDmoK0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739650651; c=relaxed/simple;
	bh=KXjKMjoQkvQLOoQ8gWA1SVy4+Ztl2KFhN/PtXv3e9bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTGHXujfWrCi/o/d9dh7JN6wC8DK7pGuS3uW6ykTpfnDLrG7tiVJfUnuQe6kUoka8vqfjAjc6OfHpf0wGlmyy9h0wBU/bQ19kh5yOTHMAzeuApqu8PKmgXPPLVtbRaHfau5lM9ym6hR114VA6w3uDApHNYixTw8Ie6yRkD/euhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJV/5TsP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739650649; x=1771186649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KXjKMjoQkvQLOoQ8gWA1SVy4+Ztl2KFhN/PtXv3e9bk=;
  b=YJV/5TsPp4iT3pz1bjrx9QxPS3ZVGYs3ZhmU3RIHkCHjrv+VMD8hN8Iy
   lmtR4IHsVWw5fnjbHr2eo7/TEB3+lKlJPstpDWgVOGbeMOmKN3MqgCWcp
   Ef/p0hQU8NVRMv8lXIX75xhsXqWfZOjWsTQmmtUOk9ZCSrYEKXKCNKHVo
   oPshBnZB4JWtmwbZDgzSIZ0lMcii3CpE9kBwcgH3B+2Y9XwPD1SNSuoth
   RtknVVld16zDWNDJ7FsPi5YDpWY91b2xWLdPGW4pIfFkPYl46P6uebwTH
   97mWoW9UEK5OXea8tlVg9FdvKA4RYw27mcroLBmmTZupC9+JDi4tvw+fg
   Q==;
X-CSE-ConnectionGUID: FJJbrpb0ROOlHD8cfJWZ9g==
X-CSE-MsgGUID: UwajFumQQCSRnBiU6H48EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="65728622"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="65728622"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 12:17:29 -0800
X-CSE-ConnectionGUID: nFR14ZTlSgK3QFrCXZv70Q==
X-CSE-MsgGUID: 5Qv8FcfmSNeDY+ZC8nIoUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="144606069"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Feb 2025 12:17:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjObM-001B9T-1n;
	Sat, 15 Feb 2025 20:17:24 +0000
Date: Sun, 16 Feb 2025 04:16:27 +0800
From: kernel test robot <lkp@intel.com>
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, peterz@infradead.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	tglx@linutronix.de, prakash.sangappa@oracle.com
Subject: Re: [PATCH 1/2] Sched: Scheduler time slice extension
Message-ID: <202502160412.H5MjYC21-lkp@intel.com>
References: <20250215005414.224409-2-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005414.224409-2-prakash.sangappa@oracle.com>

Hi Prakash,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on peterz-queue/sched/core linus/master v6.14-rc2 next-20250214]
[cannot apply to tip/core/entry]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prakash-Sangappa/Sched-Scheduler-time-slice-extension/20250215-090421
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250215005414.224409-2-prakash.sangappa%40oracle.com
patch subject: [PATCH 1/2] Sched: Scheduler time slice extension
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20250216/202502160412.H5MjYC21-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502160412.H5MjYC21-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160412.H5MjYC21-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:66:
   kernel/sched/syscalls.c: In function 'sys_sched_yield':
>> kernel/sched/syscalls.c:1372:20: error: 'struct task_struct' has no member named 'rseq_sched_delay'
    1372 |         if (current->rseq_sched_delay) {
         |                    ^~


vim +1372 kernel/sched/syscalls.c

  1361	
  1362	/**
  1363	 * sys_sched_yield - yield the current processor to other threads.
  1364	 *
  1365	 * This function yields the current CPU to other tasks. If there are no
  1366	 * other threads running on this CPU then this function will return.
  1367	 *
  1368	 * Return: 0.
  1369	 */
  1370	SYSCALL_DEFINE0(sched_yield)
  1371	{
> 1372		if (current->rseq_sched_delay) {
  1373			schedule();
  1374			return 0;
  1375		}
  1376	
  1377		do_sched_yield();
  1378		return 0;
  1379	}
  1380	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

