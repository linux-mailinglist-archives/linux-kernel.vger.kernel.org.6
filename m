Return-Path: <linux-kernel+bounces-367144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E9A99FF17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7418B244C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4724E16DEB2;
	Wed, 16 Oct 2024 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jl2Eyyof"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1B165EF8
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729047877; cv=none; b=JcKiq9uYvjx2QOssMvO1uGqxMaDRcDfK9Uj3AcQX3kiQc/cQ6xexroapfkCo5LgGedLC/fEt+dA0H8VDeIlSp3ZotJFIOuSltXRHUGa5Rfpy6ZzvYQyWMhQFl4JnxW11VO1LZijmalXomJmD7AZ7sUMZI7Ze0ODJZPfYAlGeiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729047877; c=relaxed/simple;
	bh=4iNh84o83ZQH4Z4x2bLRWS6mJj3EonFvkfgivqaPnFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O394SBUyqn9COcn1mhqaCYZIsEqYQsp/OPYV/QvzXZIFSbSp90GCwT0RJrKBRY7N0fGsUrmbPxTICo0KorZn779UZJu2OkTVPgfGC/KkbFLyO8cTG8oqMzpMuVNba2QzNYTg2HTJ9x2XJDKXaOqPjbmZaddv5LWMZvJXHsMOo+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jl2Eyyof; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729047876; x=1760583876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4iNh84o83ZQH4Z4x2bLRWS6mJj3EonFvkfgivqaPnFs=;
  b=jl2EyyofMIN0a4lLFgT3QWrPDlauit1h64X/elTQhJ+vKFvRgE+m8QnX
   PyL7k5XV1glR/3zjeWD33e1Y7PoWMlgXcNXiY2Vk4kFXK+uphl/dZENnP
   dA88HzUbUqRGsL6MQlfjB+w5zQsgPzL1DZu/j2ZIW15QDHxlGv15ZBIKf
   0e3T2v4pblCVeXbfhoAdE0WK7zpGnD4LWls3B1NPTQVo/MHQrGNevbUTR
   IpNYvA1sLYTQzMBdLD1/12D+39DTQeHBe+risB29Q7BJbit9G9xW8p0M1
   CZcXqfJQHbHXmSbnUwHHv84aatLUwBgT41xaF2/za6aMwAtSYEk9L32XS
   w==;
X-CSE-ConnectionGUID: NF2c6rtVTQCUy0gxZjadvA==
X-CSE-MsgGUID: fUw+ZvZaSlOfLLYrYuL+OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32395550"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="32395550"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:04:35 -0700
X-CSE-ConnectionGUID: fx3FGI0wTgGQWYVIDfOung==
X-CSE-MsgGUID: NHHcDv0ZT/qJqXahQpOP+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="83168145"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Oct 2024 20:04:30 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0uKo-000KCh-2I;
	Wed, 16 Oct 2024 03:04:26 +0000
Date: Wed, 16 Oct 2024 11:03:35 +0800
From: kernel test robot <lkp@intel.com>
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, sudeep.holla@arm.com, tglx@linutronix.de,
	mpe@ellerman.id.au, linux-arm-kernel@lists.infradead.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	pierre.gondois@arm.com, dietmar.eggemann@arm.com
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	morten.rasmussen@arm.com, msuchanek@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com, yangyicong@hisilicon.com, xuwei5@huawei.com,
	guohanjun@huawei.com
Subject: Re: [PATCH v6 2/4] arch_topology: Support SMT control for OF based
 system
Message-ID: <202410161038.WVTopMNt-lkp@intel.com>
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
config: arm-randconfig-001-20241016 (https://download.01.org/0day-ci/archive/20241016/202410161038.WVTopMNt-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161038.WVTopMNt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161038.WVTopMNt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/arch_topology.c:32:21: warning: 'max_smt_thread_num' defined but not used [-Wunused-variable]
      32 | static unsigned int max_smt_thread_num;
         |                     ^~~~~~~~~~~~~~~~~~


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

