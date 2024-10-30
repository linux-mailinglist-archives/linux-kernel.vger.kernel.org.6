Return-Path: <linux-kernel+bounces-389100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144509B6883
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD5E2856C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02666213EF3;
	Wed, 30 Oct 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbai/SiS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F44213127
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303725; cv=none; b=lKy0gqmprVpqUTIZtDCP06dBxqNK4LzEUrHa96btN8lkku7q+LQ/up4v+9szXj97O0FP1OMUiB4Wzuc9QHnMXBpzCH/VdC6w/087TGNH1OopygyOPCTe/XctvovAnCNfsmhoPrRQhOMIvpA3L3bc5QTKO64uQNioZUTTgUSdEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303725; c=relaxed/simple;
	bh=/L01TVo2SDCaqeJwbWnkEVmigYqS/uS6d3qQl/Wfa1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7XCFp39TT2bv1zfTuZUHSP/fvYQOA8glSANPwVRke+nBd2EuQD+tfwiH2bVWIX0AObI6FgWfbo/4ema/y9IF2pHPXve4WjyZPo0RNOpTSs05NWyIdqSbnsRCbAxhAX8iIDaUT4m+h5pd5IlSrKPWrPo5W9B3jleCXbvkGwwvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbai/SiS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730303723; x=1761839723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/L01TVo2SDCaqeJwbWnkEVmigYqS/uS6d3qQl/Wfa1Q=;
  b=kbai/SiSqHRk4mvR4my22gHsDGUH+rvcgYuzVh+zDOR82WbQ74B8SBn7
   Glt50HvS8bJSksMvncDr2jqtiAbGzP23M+SwvEHYo1vBSVDwzDBI2+GZN
   0fs0kA6b7kQGfLp1x0WA2C5vpjir/G8gABQYYIp50/lFMRAU7QHYVspTL
   WWU245j5ApC/09/Q8d6Z6Y8hcSHCEZ5adUdc+z0VVAD/cvM7V9qXCELym
   Thp4VDdfdenFByahbe3DiOK72CBwtnR0VOabNV6t2DO05RdUJPkFBWQC1
   Q/ZJgnzP4j1WtL00vXz6yPxrPDkbO5H0rKBTUjwI+aFJu07if+bKdf+lT
   w==;
X-CSE-ConnectionGUID: Sxso7k12RXOK5G0M8Wt0qA==
X-CSE-MsgGUID: WyZM9OuJTxy4YUOvVaZohA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="47489687"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="47489687"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 08:55:22 -0700
X-CSE-ConnectionGUID: fJFqD3ejSjGBswsYUAN0Lg==
X-CSE-MsgGUID: at6ayCdARwO2wLmWFIVdSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82775966"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Oct 2024 08:55:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6B2R-000f1k-2X;
	Wed, 30 Oct 2024 15:55:15 +0000
Date: Wed, 30 Oct 2024 23:54:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH] dl_server: Reset DL server params when rd changes
Message-ID: <202410302318.EbfnSdKM-lkp@intel.com>
References: <20241029225116.3998487-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029225116.3998487-1-joel@joelfernandes.org>

Hi Joel,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.12-rc5 next-20241030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes-Google/dl_server-Reset-DL-server-params-when-rd-changes/20241030-065241
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20241029225116.3998487-1-joel%40joelfernandes.org
patch subject: [PATCH] dl_server: Reset DL server params when rd changes
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20241030/202410302318.EbfnSdKM-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241030/202410302318.EbfnSdKM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410302318.EbfnSdKM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:60:
   kernel/sched/deadline.c: In function 'dl_server_start':
>> kernel/sched/deadline.c:1631:47: error: 'struct rq' has no member named 'rd'; did you mean 'rt'?
    1631 |         struct root_domain *rd = cpu_rq(cpu)->rd;
         |                                               ^~
         |                                               rt


vim +1631 kernel/sched/deadline.c

  1626	
  1627	void dl_server_start(struct sched_dl_entity *dl_se)
  1628	{
  1629		struct rq *rq = dl_se->rq;
  1630		int cpu = cpu_of(rq);
> 1631		struct root_domain *rd = cpu_rq(cpu)->rd;
  1632	
  1633		/*
  1634		 * XXX: the apply do not work fine at the init phase for the
  1635		 * fair server because things are not yet set. We need to improve
  1636		 * this before getting generic.
  1637		 */
  1638		if (!dl_server(dl_se) || dl_se->last_rd != rd) {
  1639			u64 runtime =  50 * NSEC_PER_MSEC;
  1640			u64 period = 1000 * NSEC_PER_MSEC;
  1641	
  1642			dl_se->last_rd = rd;
  1643			dl_server_apply_params(dl_se, runtime, period, 1);
  1644	
  1645			if (!dl_server(dl_se)) {
  1646				dl_se->dl_server = 1;
  1647				dl_se->dl_defer = 1;
  1648				setup_new_dl_entity(dl_se);
  1649			}
  1650		}
  1651	
  1652		if (!dl_se->dl_runtime)
  1653			return;
  1654	
  1655		enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
  1656		if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
  1657			resched_curr(dl_se->rq);
  1658	}
  1659	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

