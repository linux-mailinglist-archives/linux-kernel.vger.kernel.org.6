Return-Path: <linux-kernel+bounces-427899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD75F9E0723
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EE92810B3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEBF20899B;
	Mon,  2 Dec 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tams7/dP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DAD208991
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153743; cv=none; b=MIGMCRIuN+7bqvX4/4PQfQ7jzJlz4SZ6H9LOBgnnwCt0l7E4zgIPUsOUHjRJcNgf1GguMwFzeU7p5bIQYksihh6kr4k4gBZnEP95Hgf2XLsdzqqrt4aGh+RjWviyoJ8XfD/B8vtG05jGrUqwyCAW92NgYj/Ru9Lb0LwYjqtSYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153743; c=relaxed/simple;
	bh=Jutse4gfVPzCl0ycY/CTBU2Kpvtp039+8k5v0EcasQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhcWDe1Y5jIls0XrM20z0UMSa/AQVmSm4fDnwsz/GTpZF0JUdzDMi0zv/H5dfGZULOxVk2SgFN5MaBO3Pj8WcFpDQCdeJDzp+ZqpHiqncIb4RMYdTL52VwGk9K3A9GxTal4a1EFxaHqNV5LUL6B/2JDXJPfwQUWAvUrF+1m/aIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tams7/dP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733153740; x=1764689740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jutse4gfVPzCl0ycY/CTBU2Kpvtp039+8k5v0EcasQk=;
  b=Tams7/dPcYJqcLNuHJQ6JoAMnaCetalvrnq4oIR/HIHyxzBPojsGrr/8
   4I2YyzTlvt2ON4Y0JNbJje5YDhnb0EFMeh0QZgrBgwncKojcgvJzvnL9M
   Xy7/GZ6RZuR0645uHPUXl5zoTJkK7DQOzJDKPoGcuJo2WvKIwbcmmJcbv
   vULHPdMIty0Vb3HNBZKPNOenICBWYNNeuIKxZYbz9JQlqQ/GO5DcQmvxH
   1gBhjzDOn9+XpRggmPFyEN6aX6QiHvW9UHXgq3J5S2tVNRpjlNLefJ4Gh
   ysZUs8NVcS31H7+ynNWZp+pFLkR9Thf/FTIgV+dwl6nkV9BKtqbmo+Xd/
   A==;
X-CSE-ConnectionGUID: 6HszHtXxQ6eFiP+E977FNA==
X-CSE-MsgGUID: b5nawmwQTjaYJ0Zxgnmqfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="58722906"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="58722906"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 07:35:39 -0800
X-CSE-ConnectionGUID: kv74GcruQc6PmJ+CoNNxgA==
X-CSE-MsgGUID: Ybb0niWZQOWDsM6Rq4AJUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="93607621"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 02 Dec 2024 07:35:37 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tI8SU-0002Wr-2W;
	Mon, 02 Dec 2024 15:35:34 +0000
Date: Mon, 2 Dec 2024 23:34:33 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: oe-kbuild-all@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"(maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"(open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <linux-kernel@vger.kernel.org>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Subject: Re: [PATCH] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on
 systems with AMD preferred cores
Message-ID: <202412022352.jwqoAZXs-lkp@intel.com>
References: <20241202043724.3929062-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202043724.3929062-1-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/x86-cpu-Enable-SD_ASYM_PACKING-for-PKG-domain-on-systems-with-AMD-preferred-cores/20241202-124012
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/20241202043724.3929062-1-superm1%40kernel.org
patch subject: [PATCH] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on systems with AMD preferred cores
config: x86_64-randconfig-r061-20241202 (https://download.01.org/0day-ci/archive/20241202/202412022352.jwqoAZXs-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412022352.jwqoAZXs-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> arch/x86/kernel/smpboot.c:513:2-3: Unneeded semicolon

vim +513 arch/x86/kernel/smpboot.c

   499	
   500	static int x86_die_flags(void)
   501	{
   502		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
   503			return x86_sched_itmt_flags();
   504	
   505		switch (boot_cpu_data.x86_vendor) {
   506		case X86_VENDOR_AMD:
   507		case X86_VENDOR_HYGON:
   508			bool prefcore = false;
   509	
   510			amd_detect_prefcore(&prefcore);
   511			if (prefcore || cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
   512				return x86_sched_itmt_flags();
 > 513		};
   514	
   515		return 0;
   516	}
   517	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

