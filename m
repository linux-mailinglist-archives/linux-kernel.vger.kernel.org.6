Return-Path: <linux-kernel+bounces-540770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D65A4B4B9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30C61890B67
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCC11E9B0B;
	Sun,  2 Mar 2025 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yp2DeGSP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147C2AD13
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740948616; cv=none; b=eK3Zv6jGnWCDie4XzjHyUqjsco7RBXhXAaJdRkEz1D2mjh1mWn/CkjIF7WCXFvnX/h4evF+Dv1K1pSiEaajxk2l8w5i/iwx5TRuM8YNqA1nUgWo9KkXl9T+kybd2wgBD72EYWu52Bui6XuBL9jRAe4RKvUfZAQpqvyG4ExDIBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740948616; c=relaxed/simple;
	bh=iKKiULY4FrHKeHfEkzQVmNq5MpBQvJcZT6hoXQtN69s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYDjyfDfVrht058d6rxT8Py6YojTLOxNUpg4AvpCajzgD2GZ0GTjLJXJbAJBT+GYcpUVRNQRRKBw8EXJbDOsuhdXela03fU3gO+4yHSufPNXwMBtnU+63iXBBfAd4n/k02MLv/HK3cIEzw9ELxo+8kD9TLth4XhM+1Z8kbKdebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yp2DeGSP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740948615; x=1772484615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iKKiULY4FrHKeHfEkzQVmNq5MpBQvJcZT6hoXQtN69s=;
  b=Yp2DeGSPqF8zw86mLgcB1R1AKp7yxx1pDqEdj84oIrYEv4cpKWIIMKtk
   3QufjFTbXeET1h4Cv9oKi+xwgyYefjpEzyHtlansD5He+cSN7SARyzSqc
   behnERujRG6dowzkyhwa7QXx9m+qebGNTiy0YQEJUan2d5fExA/O9d4pm
   isXHQztwdNmp7cnoQytBltC10HFuaqP5sVmG1D8686LgyI4alJ4JiLLLG
   DTwf+Rq2rjQTFMhEbU/eD8AT81cvXeNsdIKqR54ERv6OBO9f1ALx/FSql
   giWsivFzbUWLayDlW9piMkv1ysheZGQlV+dpLM28di6T2BrN38qTh/D1+
   g==;
X-CSE-ConnectionGUID: 77M7UnPMRL6j5MgZSWJXzw==
X-CSE-MsgGUID: 3hrvNXrPS/GH+bayseEd2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="52461093"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="52461093"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 12:50:14 -0800
X-CSE-ConnectionGUID: hsh7De5aRaqhCoc8UibPvg==
X-CSE-MsgGUID: RdcPx0RwRfay3N2DQ3ZppQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="118019499"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Mar 2025 12:50:10 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toqG3-000HcQ-08;
	Sun, 02 Mar 2025 20:50:05 +0000
Date: Mon, 3 Mar 2025 04:49:33 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com, pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, qyousef@layalina.io,
	hongyan.xia2@arm.com, christian.loehle@arm.com,
	luis.machado@arm.com, qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 6/7 v4] sched/fair: Add misfit case to push task mecanism
 for EAS
Message-ID: <202503030443.zgft6lMb-lkp@intel.com>
References: <20250302161321.1476139-7-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302161321.1476139-7-vincent.guittot@linaro.org>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on peterz-queue/sched/core linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Guittot/sched-fair-Filter-false-overloaded_group-case-for-EAS/20250303-001556
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250302161321.1476139-7-vincent.guittot%40linaro.org
patch subject: [PATCH 6/7 v4] sched/fair: Add misfit case to push task mecanism for EAS
config: riscv-randconfig-002-20250303 (https://download.01.org/0day-ci/archive/20250303/202503030443.zgft6lMb-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503030443.zgft6lMb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503030443.zgft6lMb-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'check_pushable_task':
>> kernel/sched/fair.c:8964:21: error: expected ';' before '}' token
    8964 |         return false
         |                     ^
         |                     ;
    8965 | }
         | ~                    


vim +8964 kernel/sched/fair.c

  8952	
  8953	static int
  8954	balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  8955	{
  8956		if (sched_fair_runnable(rq))
  8957			return 1;
  8958	
  8959		return sched_balance_newidle(rq, rf) != 0;
  8960	}
  8961	#else
  8962	static inline bool check_pushable_task(struct task_struct *p, struct rq *rq)
  8963	{
> 8964		return false
  8965	}
  8966	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

