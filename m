Return-Path: <linux-kernel+bounces-557484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D08A5D9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2392E3A585B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F323C8AE;
	Wed, 12 Mar 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMu7pdUU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A6238179
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772966; cv=none; b=TJ4+2dH6kkGt28haiH1bA8hSDGnlq+zGIMiANKf1clmkKXTcVfaJ9jlHLpmeG0i9qX16NyCrJRcwt0vW+sMLhtqLi5deYwys/+VnGLVdimyvYqstJ25V5a+fSSi5ajXhBHFm/rqnuLUDD03hIH9UBzbzsuEPUJXqGVFg2G60c1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772966; c=relaxed/simple;
	bh=5GqOKdDBYPNDAd8Dx8+dRzITFAjoSOQPmrAc2RWtbM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1slb6xLeMnhuCONlyCghs9M1iLDOP0dOPZRuPO2xY3eG9QHPHmAX6wC4o4tYzZdWg/3XLJZbdnD6JgznHssV5rzIVGIuYIHkucsC76zdBl4CvNqnDlEMUhsQn0rXuWXGD9GBWxdFRJ4ZTHi96VHbKssxLyXAq/sm1+/GfOUJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMu7pdUU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741772965; x=1773308965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5GqOKdDBYPNDAd8Dx8+dRzITFAjoSOQPmrAc2RWtbM8=;
  b=WMu7pdUUosbOGsPzot8YsYgVF9LKPbXfZtfejNXBdjlbp7uB7oYp3fgX
   HrxNbiVFkOtxu0vmqu/IODTMmT9ryMIHaYrCEMEzQYZr+SsTGbV6TaBkb
   5qNiQIvpN39TrHo/ZnVRNqhjcH/gIBRauYy1gD+8louuw6ebXJvd3N9Aq
   fhUyeD6jDW0EXmWnHsZu2YHZ1IrZ2Lqj2wDhfN8g5CVzziHCzF4viSd8g
   e4p9Y5VfalOx+oSUSN7BCyJUdJU66Ordq1m6FqNv+swxRQSbPvUJas/P4
   ILcJLGUYSYM7ywgnFJgigxaEf5uO/mb1JrmbrzlJFalO8YVo6hYXUeYAl
   A==;
X-CSE-ConnectionGUID: kXOb0VhERJCqGKHTk0h+NA==
X-CSE-MsgGUID: 7+xG+4nfQwSqGucULbuD1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42718708"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42718708"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:49:25 -0700
X-CSE-ConnectionGUID: tK+rNZ02RKSIT2dqLScd3w==
X-CSE-MsgGUID: 7LcpwGPrSi2iW52dWJL5Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120617646"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 12 Mar 2025 02:49:21 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsIiF-0008M6-19;
	Wed, 12 Mar 2025 09:49:19 +0000
Date: Wed, 12 Mar 2025 17:49:02 +0800
From: kernel test robot <lkp@intel.com>
To: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: [PATCH v4 11/36] x86/bugs: Restructure spectre_v2_user mitigation
Message-ID: <202503121721.1nslvluh-lkp@intel.com>
References: <20250310164023.779191-12-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310164023.779191-12-david.kaplan@amd.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[cannot apply to tip/x86/core linus/master tip/auto-latest tip/smp/core v6.14-rc6 next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Kaplan/x86-bugs-Restructure-mds-mitigation/20250311-005151
base:   tip/master
patch link:    https://lore.kernel.org/r/20250310164023.779191-12-david.kaplan%40amd.com
patch subject: [PATCH v4 11/36] x86/bugs: Restructure spectre_v2_user mitigation
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20250312/202503121721.1nslvluh-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503121721.1nslvluh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503121721.1nslvluh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/bugs.c:1490:7: warning: variable 'smt_possible' set but not used [-Wunused-but-set-variable]
    1490 |         bool smt_possible = IS_ENABLED(CONFIG_SMP);
         |              ^
   1 warning generated.


vim +/smt_possible +1490 arch/x86/kernel/cpu/bugs.c

  1487	
  1488	static void __init spectre_v2_user_update_mitigation(void)
  1489	{
> 1490		bool smt_possible = IS_ENABLED(CONFIG_SMP);
  1491	
  1492		if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
  1493			return;
  1494	
  1495		if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
  1496		    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
  1497			smt_possible = false;
  1498	
  1499		/* The spectre_v2 cmd line can override spectre_v2_user options */
  1500		if (spectre_v2_cmd == SPECTRE_V2_CMD_NONE) {
  1501			spectre_v2_user_ibpb = SPECTRE_V2_USER_NONE;
  1502			spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
  1503		} else if (spectre_v2_cmd == SPECTRE_V2_CMD_FORCE) {
  1504			spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
  1505			spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT;
  1506		}
  1507	
  1508		/*
  1509		 * If no STIBP, Intel enhanced IBRS is enabled, or SMT impossible, STIBP
  1510		 * is not required.
  1511		 *
  1512		 * Intel's Enhanced IBRS also protects against cross-thread branch target
  1513		 * injection in user-mode as the IBRS bit remains always set which
  1514		 * implicitly enables cross-thread protections.  However, in legacy IBRS
  1515		 * mode, the IBRS bit is set only on kernel entry and cleared on return
  1516		 * to userspace.  AMD Automatic IBRS also does not protect userspace.
  1517		 * These modes therefore disable the implicit cross-thread protection,
  1518		 * so allow for STIBP to be selected in those cases.
  1519		 */
  1520		if (!boot_cpu_has(X86_FEATURE_STIBP) ||
  1521		    !cpu_smt_possible() ||
  1522		    (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
  1523		     !boot_cpu_has(X86_FEATURE_AUTOIBRS))) {
  1524			spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
  1525			return;
  1526		}
  1527	
  1528		if (spectre_v2_user_stibp != SPECTRE_V2_USER_NONE &&
  1529		    (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
  1530		     retbleed_mitigation == RETBLEED_MITIGATION_IBPB)) {
  1531			if (spectre_v2_user_stibp != SPECTRE_V2_USER_STRICT &&
  1532			    spectre_v2_user_stibp != SPECTRE_V2_USER_STRICT_PREFERRED)
  1533				pr_info("Selecting STIBP always-on mode to complement retbleed mitigation\n");
  1534			spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT_PREFERRED;
  1535		}
  1536		pr_info("%s\n", spectre_v2_user_strings[spectre_v2_user_stibp]);
  1537	}
  1538	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

