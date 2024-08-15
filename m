Return-Path: <linux-kernel+bounces-287842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81447952D15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47251C234A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7021AC896;
	Thu, 15 Aug 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vlss4NGz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDC7DA62
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719560; cv=none; b=HcpgsJdbCxERKuHzu+nvTct41+ZIHMP0WjOsQy5AzIYz2m0pgDutYmd+pK7olIJ774vEJVmo9qjPVeaE7VQ1ZT68A434Yf4dcP0aSi+2RjgOo+tWNZ2UPKBmIMBYZMjxvc3QIJazobl3XWz9Y+kBc35xTbY/VjbHQ8DHOzPIepU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719560; c=relaxed/simple;
	bh=0of4YWi2zamE88OpBywL8TGTpjRvyD+J2toQMrWrplE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxOIngGGXkxm38vbV85xp07wNZ3lt0i+97bYUniaYKRsk3pxopbtArwivwVJomTkUF0FaB3D17QRpZKRZRBeB0lacuR9ab3d2E6Nj3TX4BC4buekEbjUJsuMIXaCl/Luj4hI3Cqbdx2sSShTh8YQrVFX3T9W4sBSUBOkp/rviHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vlss4NGz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723719557; x=1755255557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0of4YWi2zamE88OpBywL8TGTpjRvyD+J2toQMrWrplE=;
  b=Vlss4NGzfAGUEzuORe633dKT9MAdEN0dsDSj6qXfFphJGa8aVAefTtmW
   I4Ois/YRN9NqwdLK+w+XqACttRcAu72+VlTjeDwTuRmoa1SiBTxpAB3eh
   oV7t/NLWvzpP38qC1sQr3+WpXDJuoXOXyUI/OG4W9EjXSZwUrpiMXKXsr
   66cnB6Gw1sSZXtEkYWvYDrlwiwKHqYxw4SszHUeIlVFL1tEPwFUA4FLT4
   IAnfgYTgJ9FIz/5DE6uT6cqxqdFH7jQNvZBE3+N+zyzVsGcQEdVn3NVtM
   cypLl4Dflmsh3ZKHBZFsjjWQAXb3U9cf241SzAVRhdJJwdZOIW0SRYO9l
   Q==;
X-CSE-ConnectionGUID: ndnrOhseSiSXRKhAltJ5Hw==
X-CSE-MsgGUID: RRsKTZ7sQweU4I5hisVQGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33358452"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="33358452"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 03:59:16 -0700
X-CSE-ConnectionGUID: VcTn9ComRKWXEB9EXoUg6A==
X-CSE-MsgGUID: a1fq+HxqRD+K5cRMMUMp1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="58949049"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Aug 2024 03:59:14 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seYCF-0003UU-16;
	Thu, 15 Aug 2024 10:59:11 +0000
Date: Thu, 15 Aug 2024 18:58:39 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	mingo@redhat.com, tglx@linutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	ajay.kaher@broadcom.com, bo.gan@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: Re: [PATCH 2/2] x86/vmware: Fix steal time clock under SEV
Message-ID: <202408151826.9369lzwV-lkp@intel.com>
References: <20240814210731.761010-2-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814210731.761010-2-alexey.makhalov@broadcom.com>

Hi Alexey,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/vmware]
[also build test ERROR on linus/master v6.11-rc3 next-20240815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Makhalov/x86-vmware-Fix-steal-time-clock-under-SEV/20240815-050918
base:   tip/x86/vmware
patch link:    https://lore.kernel.org/r/20240814210731.761010-2-alexey.makhalov%40broadcom.com
patch subject: [PATCH 2/2] x86/vmware: Fix steal time clock under SEV
config: i386-randconfig-003-20240815 (https://download.01.org/0day-ci/archive/20240815/202408151826.9369lzwV-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151826.9369lzwV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151826.9369lzwV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/vmware.c:313:6: error: use of undeclared identifier 'cc_vendor'
     313 |         if (cc_vendor != CC_VENDOR_AMD ||
         |             ^
>> arch/x86/kernel/cpu/vmware.c:313:19: error: use of undeclared identifier 'CC_VENDOR_AMD'
     313 |         if (cc_vendor != CC_VENDOR_AMD ||
         |                          ^
   2 errors generated.


vim +/cc_vendor +313 arch/x86/kernel/cpu/vmware.c

   308	
   309	static void __init sev_map_percpu_data(void)
   310	{
   311		int cpu;
   312	
 > 313		if (cc_vendor != CC_VENDOR_AMD ||
   314		    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
   315			return;
   316	
   317		for_each_possible_cpu(cpu) {
   318			early_set_memory_decrypted(
   319				(unsigned long)&per_cpu(vmw_steal_time, cpu),
   320				sizeof(vmw_steal_time));
   321		}
   322	}
   323	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

