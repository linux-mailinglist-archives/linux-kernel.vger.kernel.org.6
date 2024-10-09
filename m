Return-Path: <linux-kernel+bounces-357950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B657997857
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0D51C21C24
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE691E32B7;
	Wed,  9 Oct 2024 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfpggcsl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226DB1E230A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512070; cv=none; b=fHL8L56lpHpHq9kMwIZbqrwSJjWzi/jPeXFM5tt6w3POC0ILbNA9uBvGekqxoyU+kfmU5wKuPnLKExVkiotfPymXV9nK4PVelsMyo5qPsSa4copKAhDwn/Q15CDYCIm3PdvMK1jOwhHHU95rXdZGKnW7c8mEEVApXua+HXEav48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512070; c=relaxed/simple;
	bh=aPE8EeGv6cp9FSCthHiVZeteDR6lumGj+9qfHbzXBwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzM9nv9ZGecdBI+QjKlDVwLZgTAgXxBC5i0a9YpoEE9vukkCXMUVbSNc41ZZCph+46AfoNPDvsEzydW1+byI+Br15PwsAK3+smZHY0Puihsweis1tgTF6spnS7WG4dGrhUqNPyYHNMGKgS+5j69O1yK02k2+bGV1hHB3MKwfF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfpggcsl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728512068; x=1760048068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aPE8EeGv6cp9FSCthHiVZeteDR6lumGj+9qfHbzXBwk=;
  b=hfpggcsl5nrmDpDrikLPvop0R+zUKpKeZiNjV7tgP387SCGnocB+WE27
   r0ZaswiSRBfPA0XqQaedWCE1WhnIYZZh4sjJY7GJOZB+/r7Y1HGqm0N89
   fA6pC8P+C/n5kcQw4+LS1CDVdJGznZ/ztcmzkC2YtV+4LjbLAOgpHOfLm
   SHls0QaECh+sZdRh3Gn+jOoq4HuJJP21XwLSu6UlWzMQWCdInfr/jb4dU
   aMpONtHjggtonVBWs2I3KKpXc2DSM/lZwvV8wucyPHYleX1a7gDL7m4v7
   Yorz2sqV3H6dY5bV5beFn8ELK49UKmRPP3DihUfMv8bmQSHwURgM2Zlmt
   A==;
X-CSE-ConnectionGUID: t3CiMMkjQL6rLzEeL6/LDw==
X-CSE-MsgGUID: EEq0LamRTYWJF13ws+WYnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38425822"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="38425822"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 15:14:27 -0700
X-CSE-ConnectionGUID: 6z05KTxjSCiv+6JPvI1nIw==
X-CSE-MsgGUID: QqCrefYQR1CzjES9pNNYtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="76008488"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Oct 2024 15:14:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syewp-0009ru-0o;
	Wed, 09 Oct 2024 22:14:23 +0000
Date: Thu, 10 Oct 2024 06:14:05 +0800
From: kernel test robot <lkp@intel.com>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: Re: [PATCH 2/3] perf/dwc_pcie: Load DesignWare PCIe PMU driver
 automatically on Ampere SoCs
Message-ID: <202410100514.xcrIAa1r-lkp@intel.com>
References: <20241008231824.5102-3-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008231824.5102-3-ilkka@os.amperecomputing.com>

Hi Ilkka,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc2 next-20241009]
[cannot apply to arm-perf/for-next/perf]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ilkka-Koskinen/perf-dwc_pcie-Add-support-for-Ampere-SoCs/20241009-072027
base:   linus/master
patch link:    https://lore.kernel.org/r/20241008231824.5102-3-ilkka%40os.amperecomputing.com
patch subject: [PATCH 2/3] perf/dwc_pcie: Load DesignWare PCIe PMU driver automatically on Ampere SoCs
config: arm-randconfig-002-20241010 (https://download.01.org/0day-ci/archive/20241010/202410100514.xcrIAa1r-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410100514.xcrIAa1r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410100514.xcrIAa1r-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/perf/dwc_pcie_pmu.c:16:
   In file included from include/linux/perf_event.h:18:
   In file included from include/uapi/linux/bpf_perf_event.h:11:
   In file included from ./arch/arm/include/generated/uapi/asm/bpf_perf_event.h:1:
   In file included from include/uapi/asm-generic/bpf_perf_event.h:4:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/perf/dwc_pcie_pmu.c:785:35: warning: unused variable 'dwc_pcie_pmu_table' [-Wunused-const-variable]
     785 | static const struct pci_device_id dwc_pcie_pmu_table[] = {
         |                                   ^~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +/dwc_pcie_pmu_table +785 drivers/perf/dwc_pcie_pmu.c

   784	
 > 785	static const struct pci_device_id dwc_pcie_pmu_table[] = {
   786		{
   787			PCI_DEVICE(PCI_VENDOR_ID_AMPERE, PCI_ANY_ID),
   788			.class		= PCI_CLASS_BRIDGE_PCI_NORMAL,
   789			.class_mask	= ~0,
   790		},
   791		{ }
   792	};
   793	MODULE_DEVICE_TABLE(pci, dwc_pcie_pmu_table);
   794	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

