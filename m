Return-Path: <linux-kernel+bounces-320203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC4E970779
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C9B28207D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FF01649A8;
	Sun,  8 Sep 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laXxMtBu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245A15F3F3
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725799214; cv=none; b=PZMy0aKOGrDXgcYt6DNyBqY6xojR9KocceqQIUkzpmhsu7qPW9sz9VHCas54RItiwruUOCLMl1z1zBTa0m1Td5w+hl0vlUfBZIT6T+aV3KGLFf3HSaL3TyEFVU+FsvlJJF2BceMCLBYi0Ua8kEr9CU7RQQbxIRk00YBDVEmR6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725799214; c=relaxed/simple;
	bh=xUXOP8Rj65fJ1yAjIYiFeZRluNvMOjmFvRZMW5xhRzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiJnw6od25442aupPVt/HGi0KZgWgJPJ+YJ1ZYQ55NCt+L+tm0T4Uvp1M9BL+dCHZEflOUkhV0sSYfkmsRAg/WX07ElKQ8LUOxF2luWc7CS5sy8Lp4lxemEKQa56QmeRtOTpybIO1pccL+RvjPziPBAZlcXEtzB1w+f89lbLLQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laXxMtBu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725799213; x=1757335213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xUXOP8Rj65fJ1yAjIYiFeZRluNvMOjmFvRZMW5xhRzs=;
  b=laXxMtBu9KIUOidn88HA6dNNK5WeKaCDxwOf4sq2XErv/yl4po8k8PiO
   Gc+W0Jvi4pt61lAmD0ih0awmlZKoDdkZfbiJYNUzzLtx6oWcwuGwS0IJJ
   CiZwOTCjUGKzaZF4MsQ9XsfAuAXjswVMhjGKZswHNikxB6sj9IxEk8x06
   /Lk0bm9if7mg4MAl0IapZrI8pGag5M3SqzwB5snyfQ372xKGRK7tL6eEy
   uBENTaUUejyTQ50aG51m/PZpjCEB9PRpcm0/TW7vC6v128wx4hfxKth/K
   uVp3rK/Q8ugKZSp9MnoDSrggVIMF/YO926P7beIuDqBi0HKwmBsgE/va5
   Q==;
X-CSE-ConnectionGUID: t1kbtqMWRumVpIl3aYc4iQ==
X-CSE-MsgGUID: pr257hm3RqKzNHsOgRK4XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="49909232"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="49909232"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 05:40:12 -0700
X-CSE-ConnectionGUID: cFp1zChKSTiD1k9noA0AUg==
X-CSE-MsgGUID: 1whzZMtfSg6NypvOaO2VOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="71363066"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2024 05:40:10 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snHD6-000DWX-1F;
	Sun, 08 Sep 2024 12:40:08 +0000
Date: Sun, 8 Sep 2024 20:39:54 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin ROBIN <dev@benjarobin.fr>, jstultz@google.com,
	tglx@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, sboyd@kernel.org,
	linux-kernel@vger.kernel.org, Benjamin ROBIN <dev@benjarobin.fr>
Subject: Re: [PATCH] ntp: Make sure RTC is synchronized when time goes
 backwards
Message-ID: <202409082049.yA7d6Zmw-lkp@intel.com>
References: <20240907190900.55421-1-dev@benjarobin.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907190900.55421-1-dev@benjarobin.fr>

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-ROBIN/ntp-Make-sure-RTC-is-synchronized-when-time-goes-backwards/20240908-032754
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20240907190900.55421-1-dev%40benjarobin.fr
patch subject: [PATCH] ntp: Make sure RTC is synchronized when time goes backwards
config: arm-randconfig-r071-20240908 (https://download.01.org/0day-ci/archive/20240908/202409082049.yA7d6Zmw-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409082049.yA7d6Zmw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409082049.yA7d6Zmw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/time/ntp.c:17:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/time/ntp.c:757:19: error: use of undeclared identifier 'sync_hrtimer'
     757 |                 hrtimer_cancel(&sync_hrtimer);
         |                                 ^
   1 warning and 1 error generated.


vim +/sync_hrtimer +757 kernel/time/ntp.c

   707	
   708	
   709	static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
   710						  s32 *time_tai)
   711	{
   712		if (txc->modes & ADJ_STATUS)
   713			process_adj_status(txc);
   714	
   715		if (txc->modes & ADJ_NANO)
   716			time_status |= STA_NANO;
   717	
   718		if (txc->modes & ADJ_MICRO)
   719			time_status &= ~STA_NANO;
   720	
   721		if (txc->modes & ADJ_FREQUENCY) {
   722			time_freq = txc->freq * PPM_SCALE;
   723			time_freq = min(time_freq, MAXFREQ_SCALED);
   724			time_freq = max(time_freq, -MAXFREQ_SCALED);
   725			/* update pps_freq */
   726			pps_set_freq(time_freq);
   727		}
   728	
   729		if (txc->modes & ADJ_MAXERROR)
   730			time_maxerror = txc->maxerror;
   731	
   732		if (txc->modes & ADJ_ESTERROR)
   733			time_esterror = txc->esterror;
   734	
   735		if (txc->modes & ADJ_TIMECONST) {
   736			time_constant = txc->constant;
   737			if (!(time_status & STA_NANO))
   738				time_constant += 4;
   739			time_constant = min(time_constant, (long)MAXTC);
   740			time_constant = max(time_constant, 0l);
   741		}
   742	
   743		if (txc->modes & ADJ_TAI &&
   744				txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
   745			*time_tai = txc->constant;
   746	
   747		if (txc->modes & ADJ_OFFSET)
   748			ntp_update_offset(txc->offset);
   749	
   750		if (txc->modes & ADJ_TICK)
   751			tick_usec = txc->tick;
   752	
   753		if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
   754			ntp_update_frequency();
   755	
   756		if (txc->modes & ADJ_SETOFFSET)
 > 757			hrtimer_cancel(&sync_hrtimer);
   758	}
   759	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

