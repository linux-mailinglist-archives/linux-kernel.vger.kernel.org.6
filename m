Return-Path: <linux-kernel+bounces-367357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC29A0146
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE8C1C22926
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA4418DF9C;
	Wed, 16 Oct 2024 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyvRG9P+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802318CC0C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059608; cv=none; b=qVvfGMTBZOHEpTlZuOXLylZTf5QJTkMcjAV7VdwsJ/GZXu9H+XuH/2x2JpobFO6wmOFfgDV2dcYRwQ0w6ktoAiDWE0z1duMXKlCj2T3H5Yz5Xj4Hu7Ylghh7/LLeCSCpCG6W8XOwCU+aAma8UHwNCiJnfWe1e0hG4CMx7CWdB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059608; c=relaxed/simple;
	bh=qaJLAfJ+hrsrmwGpkbpiwW/a3cmep1qGh4KcmkUooaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uyi7i4Woj7oeBOhHrGrFdCAo/NAdBE7GSPHfes591n5lth2sAgFwOrr6qk2jR9kPZ4DFZbhBdBpKrBGwCWRw+bI8pt/bePDgMNjds3GCsmjqX46TueIQ4kYLrpTOBCyNHfw629LK4seFEkYnBBztiKGvam2h6yj1kjZB4eWfE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyvRG9P+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729059607; x=1760595607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qaJLAfJ+hrsrmwGpkbpiwW/a3cmep1qGh4KcmkUooaY=;
  b=dyvRG9P+EdVlcnoAhUZsHRx2BQl+fHoX3gW792q8gdxoXX1NSfBwLIYo
   CzDDygOeaU8fuKay07Tef8u/4MZSntfnA3KExPR4IjoANuGsY3U8nPC4F
   TKXsZa5esQuhKlu1Q+CkZC2u8XsBu/KGd0TupN1VVlrNF4QyQd2ng2vTE
   pmD9o3KpETPh89nRscgvH+XRjHDOLsdZk5atK7iQUxPNq4EZ+3NT7vayK
   ifqzexJxOHOCyCwTAYVK6GivfPT+ei84NX5xp+JVVZnos1lv9GdxW7l+2
   t0J3pRv1svoKF6PgaZ2fvLDu14FS9pZqOpzkSj3B62bV6wqgq0HSxJphn
   Q==;
X-CSE-ConnectionGUID: 80VeZohyQpCZSpo0zUXYvQ==
X-CSE-MsgGUID: gy2LVaunRMWoHq/rlb/j2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31359195"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="31359195"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 23:20:06 -0700
X-CSE-ConnectionGUID: Qz2YFxCPRX+DL4A1Q90/JA==
X-CSE-MsgGUID: pir6H9ovQH2NODdk0aN8xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78295490"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Oct 2024 23:20:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0xO2-000KRU-0W;
	Wed, 16 Oct 2024 06:19:58 +0000
Date: Wed, 16 Oct 2024 14:19:05 +0800
From: kernel test robot <lkp@intel.com>
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, sudeep.holla@arm.com, tglx@linutronix.de,
	mpe@ellerman.id.au, linux-arm-kernel@lists.infradead.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	pierre.gondois@arm.com, dietmar.eggemann@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
	msuchanek@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com, yangyicong@hisilicon.com, xuwei5@huawei.com,
	guohanjun@huawei.com
Subject: Re: [PATCH v6 2/4] arch_topology: Support SMT control for OF based
 system
Message-ID: <202410161302.HjmSau6j-lkp@intel.com>
References: <20241015021841.35713-3-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015021841.35713-3-yangyicong@huawei.com>

Hi Yicong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on powerpc/next powerpc/fixes driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master tip/x86/core v6.12-rc3 next-20241015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yicong-Yang/cpu-SMT-Provide-a-default-topology_is_primary_thread/20241015-102147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20241015021841.35713-3-yangyicong%40huawei.com
patch subject: [PATCH v6 2/4] arch_topology: Support SMT control for OF based system
config: arm-defconfig (https://download.01.org/0day-ci/archive/20241016/202410161302.HjmSau6j-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161302.HjmSau6j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161302.HjmSau6j-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/arch_topology.c:32:21: warning: unused variable 'max_smt_thread_num' [-Wunused-variable]
   static unsigned int max_smt_thread_num;
                       ^
   1 warning generated.


vim +/max_smt_thread_num +32 drivers/base/arch_topology.c

    28	
    29	static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
    30	static struct cpumask scale_freq_counters_mask;
    31	static bool scale_freq_invariant;
  > 32	static unsigned int max_smt_thread_num;
    33	DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
    34	EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

