Return-Path: <linux-kernel+bounces-560760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1780A60930
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76DB19C2570
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A87157465;
	Fri, 14 Mar 2025 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPMVLbWE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653DD13541B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741933609; cv=none; b=ecZwipytWPp4RRp5jF4jibniXEzaPIOTwnv2iMXs4q3cwDJVIqxq/bx/+vKYiqHd0cFwNHg57gVTXblT4CoDNP2eR5kbV58e55qMHpeWGBm0z86UO1i3HyhFtviGoRREVsUXHsp+Ekg0WMqMa1Nn3ik7YdpW3r5fEdXCAws0YyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741933609; c=relaxed/simple;
	bh=snmgh2zd1FAsGdElxkgkln6qGNbcnvjtAcmEBlbJiwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0s3Laap17ZJKBnOMk2WpdCOWXcOgI4Mk6lyRv0WR7B42PsbuS2dxAEsp+dKseU1jNcpZH8tUb1fJ21xHJWWyJgtz4jtEEHj2eo5r0haFsQ3d3ThPRJwsqDIEkOUXQohQtXEDu+uLzho4HvLLT+30c2jng0/JC5BdNPKOLHe7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPMVLbWE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741933606; x=1773469606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=snmgh2zd1FAsGdElxkgkln6qGNbcnvjtAcmEBlbJiwo=;
  b=SPMVLbWE4xzR5SEURmvx7DA+248mT+dNVJmMJHxYyRYaFCBwuzBaDhHa
   dz4vJbM66h3a6Tgygbc2K9uTUNsg9+iAPJBwKL8s3mXjBxQ3CVOmHi1Rh
   J+oWceo5W0yG4WXuQhovLSjaOCv4nwi+tG63JXSCrMvSb98U/R+9cT7uu
   igRrrMcrUj7n0PlY9L1l74MaKJbEzlIkKu83sG58ZHn1xeeb+8EG5XAqF
   7DgoOj9qk/ec6eKC2YRCsiputYOQeOk1qHlp7Vh1hJjNv7EKq/JvrgwQi
   6L7tSCcvBB3UgcZrK+YyDG5aupkvPMRVEN2WLZLWOQcKBJKzXdJe3VtCQ
   w==;
X-CSE-ConnectionGUID: /mUpfLZjRoCWhSI7DZB4Uw==
X-CSE-MsgGUID: MeUJUhtaRCqQWdN7pVFBWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46973470"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="46973470"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 23:26:46 -0700
X-CSE-ConnectionGUID: tM4sylPKSte3nDGW+dRSow==
X-CSE-MsgGUID: IXOjg544TlWNKs+YHCSoZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="120956136"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 13 Mar 2025 23:26:43 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsyVF-000A9u-0q;
	Fri, 14 Mar 2025 06:26:41 +0000
Date: Fri, 14 Mar 2025 14:26:12 +0800
From: kernel test robot <lkp@intel.com>
To: Akihiro Suda <suda.gitsendemail@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org, suda.kyoto@gmail.com,
	regressions@lists.linux.dev, aruna.ramakrishna@oracle.com,
	tglx@linutronix.de, Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Subject: Re: [PATCH v2] x86: disable PKU when running on Apple Virtualization
Message-ID: <202503141345.LkDyBcmV-lkp@intel.com>
References: <20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp>

Hi Akihiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master linus/master v6.14-rc6 next-20250313]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akihiro-Suda/x86-disable-PKU-when-running-on-Apple-Virtualization/20250312-181106
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250312100926.34954-1-akihiro.suda.cz%40hco.ntt.co.jp
patch subject: [PATCH v2] x86: disable PKU when running on Apple Virtualization
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20250314/202503141345.LkDyBcmV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503141345.LkDyBcmV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141345.LkDyBcmV-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kernel/cpu/common.c: In function 'setup_pku':
>> arch/x86/kernel/cpu/common.c:530:21: error: 'acpi_gbl_FADT' undeclared (first use in this function); did you mean 'acpi_table_fadt'?
     530 |         if (!memcmp(acpi_gbl_FADT.header.oem_table_id, "Apple Vz", 8)) {
         |                     ^~~~~~~~~~~~~
         |                     acpi_table_fadt
   arch/x86/kernel/cpu/common.c:530:21: note: each undeclared identifier is reported only once for each function it appears in


vim +530 arch/x86/kernel/cpu/common.c

   517	
   518	static __always_inline void setup_pku(struct cpuinfo_x86 *c)
   519	{
   520		/*
   521		 * OSPKE seems broken on Apple Virtualization.
   522		 * https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7knK38rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
   523		 *
   524		 * TODO: conditionally enable pku depending on the DMI BIOS version when Apple
   525		 * fixes the issue.
   526		 *
   527		 * However, this would be still not enough because DMI is missing when vmlinuz
   528		 * is directly loaded into VM.
   529		 */
 > 530		if (!memcmp(acpi_gbl_FADT.header.oem_table_id, "Apple Vz", 8)) {
   531			pr_info("pku: disabled on Apple Virtualization platform (Intel) due to a bug\n");
   532			pku_disabled = true;
   533		}
   534	
   535		if (c == &boot_cpu_data) {
   536			if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
   537				return;
   538			/*
   539			 * Setting CR4.PKE will cause the X86_FEATURE_OSPKE cpuid
   540			 * bit to be set.  Enforce it.
   541			 */
   542			setup_force_cpu_cap(X86_FEATURE_OSPKE);
   543	
   544		} else if (!cpu_feature_enabled(X86_FEATURE_OSPKE)) {
   545			return;
   546		}
   547	
   548		cr4_set_bits(X86_CR4_PKE);
   549		/* Load the default PKRU value */
   550		pkru_write_default();
   551	}
   552	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

