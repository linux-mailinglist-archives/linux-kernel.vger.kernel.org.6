Return-Path: <linux-kernel+bounces-449288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55569F4CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F4164D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA38C1F4721;
	Tue, 17 Dec 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VybzDDxs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61D1E8823
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443560; cv=none; b=JF3EkDVfJZ61z6j6lS3V9/ZbS1lXBRUTxqsE2sFDkh2DYvjzFyxDlPw5G8EWFYJhwV9jMZgQcPw+5FFBv1qkYhjATam9MJFaPiQ19XrqcuMMsmNsS2+1MOgXnWQrL5lKuDAw/qBp+TwxWH4aPFkZBKikisTpUPeZxy45A0EP+Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443560; c=relaxed/simple;
	bh=iDKQV47zmzx74nlwspmBa9AYGr/9i2C6H42QjLX9CSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrEYrlyIJc5gUo63qzRS/qpfbb+VszKTsRj7+3XkhrPM7OTZi3GJQfoGzSCap35plFFPJ/z7jZX6shjLpAw9ikqE+Rd0/C/4aqxAKjbUDvZSk4FCARrsMG/37PbxDRiJVqkjf/DjxqbHbr6vXDxxka/KsX45+eH4V6wSGA9uQ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VybzDDxs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734443558; x=1765979558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iDKQV47zmzx74nlwspmBa9AYGr/9i2C6H42QjLX9CSg=;
  b=VybzDDxsAMCNrFTspNtAjS/rAEphG9W5xmq3u3Q2puGBPW864+2IwEwC
   X4iR9p44GLdvIiqsG7nMY0bNPU7JzNOS/FLBCg2fhrsrfa13AnI6ee/Fm
   xSt3MpZqQUhfMfaIlKdQ+hf7JxHxzuRpB6nFPGWIKbgawNu9pktcD787s
   k48acLVC5uu3IoXe21NjfsZTbTUGiVU8mlY8waZKkI53m0AIeUB47qUJV
   T+wzTUYL16bfr2HzYyQEGIHBY/x3bmh8hdH/ur/3LCPneaIkug1JBK4Og
   kkPpw7zxXHLrlPSBNiPrlExtJwAqM2LIAEzelVkMdTnM1t9W3tNxjxp5N
   Q==;
X-CSE-ConnectionGUID: 2KGPx3nTR9S1t2X65trxIQ==
X-CSE-MsgGUID: 9CVR144TQb2s+EV/Dfn39A==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34192831"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34192831"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 05:52:37 -0800
X-CSE-ConnectionGUID: QH2LhTZlRReBr69ZfGqISw==
X-CSE-MsgGUID: 3NEAUlCeSNODMinUP6BVnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102634291"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Dec 2024 05:52:32 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNXzx-000F2K-19;
	Tue, 17 Dec 2024 13:52:29 +0000
Date: Tue, 17 Dec 2024 21:51:57 +0800
From: kernel test robot <lkp@intel.com>
To: Atharva Tiwari <evepolonium@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	evepolonium@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 tsc: avoid system instability in hibernation
Message-ID: <202412172141.6wHjHpsF-lkp@intel.com>
References: <20241210133930.1195-1-evepolonium@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210133930.1195-1-evepolonium@gmail.com>

Hi Atharva,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on tip/sched/core linus/master tip/auto-latest tip/x86/core v6.13-rc3 next-20241217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Atharva-Tiwari/x86-tsc-avoid-system-instability-in-hibernation/20241210-214059
base:   tip/master
patch link:    https://lore.kernel.org/r/20241210133930.1195-1-evepolonium%40gmail.com
patch subject: [PATCH] x86 tsc: avoid system instability in hibernation
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241217/202412172141.6wHjHpsF-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241217/202412172141.6wHjHpsF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412172141.6wHjHpsF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/tsc.c:18:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/tsc.c:1621:2: error: expected ';' after top level declarator
    1621 | }
         |  ^
         |  ;
   4 warnings and 1 error generated.


vim +1621 arch/x86/kernel/tsc.c

  1618	
  1619	static struct notifier_block tsc_pm_notifier_block = {
  1620		.notifier_call = tsc_pm_notifier,
> 1621	}
  1622	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

