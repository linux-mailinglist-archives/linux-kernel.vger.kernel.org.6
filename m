Return-Path: <linux-kernel+bounces-516382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B6A3706C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD44216DF76
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1201FC0EC;
	Sat, 15 Feb 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9HxCIAY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF031F8F09
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739648127; cv=none; b=r0fPMGuk1d55594fAj3SmknIL3HAK8kWOk99yEEMiX4qz1EA3jbUCn7+qdcpG+tEwwgb1nruKArjBhdhAymugYdYty8ZF61h+DsugpaOndmgnpyoVLTRrAywtEJGmulaqIRdeTu3sOxmL30hQrvcj7w1Ewv3bWYbzQRjns4qcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739648127; c=relaxed/simple;
	bh=DWFhykgEBIP6CT0ODgW61pQyFxQtgTH725Fg9dZrMCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETq79hAciGtQuzUdpentCtXaDuDf993eoE4ldk69KfRkYXbxLBMXt+lPuQ8ypGd+pCqaQmss630qZUTbFgit0nNFOUjE5fnUR/viDR4FmtMVGINjTNLcmXlquGdc3RZZwm7om4/wcnFurZfVTTrzzyfMDJ+fgE+Qq/mlH+S1rTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9HxCIAY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739648126; x=1771184126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DWFhykgEBIP6CT0ODgW61pQyFxQtgTH725Fg9dZrMCA=;
  b=W9HxCIAYms66r9twmOYsYuIvf2Yz2soKZUjf/AVYMOcKxw3x5IRisNYD
   BfTZ6hzJJop35DU7azO/oxzv13nMQ44aswT4YNZAA+g3GCDskFzunl9Qk
   dii7ChITLPNZ44Z47bNw/T7nWey4WuIjsb2f8KgM1DIihjdsdtO5EPy2u
   KZuzgK797thIL0mkFwycMFcpBG9Hkj0zq9ICs2/KY4IL/E0hW4fS3iTzr
   JxVaXroJfiGZV69rF2JuZb7BhNAHxpGuVNJavZZ/Ea+CfsLw9qmRNUHLg
   SZu3peJrjRpA73wrmOXUBgqyYjgAzKpyAnBM0bMfFTnp6I5aTj2f76Pw9
   Q==;
X-CSE-ConnectionGUID: qYgEVhIoS1OfhraybGb7XQ==
X-CSE-MsgGUID: txyCQJ1sQJqrbvw6F580HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="51356936"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="51356936"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 11:35:25 -0800
X-CSE-ConnectionGUID: byhxzi1fQhet0cVnE79/rg==
X-CSE-MsgGUID: 0LnPZu0fT7i3b5Wp/2gr4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136972270"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Feb 2025 11:35:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjNwe-001B7L-2b;
	Sat, 15 Feb 2025 19:35:20 +0000
Date: Sun, 16 Feb 2025 03:34:49 +0800
From: kernel test robot <lkp@intel.com>
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	peterz@infradead.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, tglx@linutronix.de,
	prakash.sangappa@oracle.com
Subject: Re: [PATCH 1/2] Sched: Scheduler time slice extension
Message-ID: <202502160310.ZHjm28qH-lkp@intel.com>
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
config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20250216/202502160310.ZHjm28qH-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 910be4ff90d7d07bd4518ea03b85c0974672bf9c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502160310.ZHjm28qH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160310.ZHjm28qH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:66:
>> kernel/sched/syscalls.c:1372:15: error: no member named 'rseq_sched_delay' in 'struct task_struct'
    1372 |         if (current->rseq_sched_delay) {
         |             ~~~~~~~  ^
   1 error generated.


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

