Return-Path: <linux-kernel+bounces-557618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED6DA5DB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB09178F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B397823E251;
	Wed, 12 Mar 2025 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDKquXDc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CAE1DF735
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779177; cv=none; b=V15VNZ8uG/nYhGhGl7lIE0RCMovhF6nLNhSf1RJnyy2vzxjVt/4rNzvGFezaUVmhb7ZcxTRJB/osIcuSvbznQd2ZY133zH8qsqwl7J7KODccyXU8Qm/PUmnkUFYBKlgMt25FkzxQ+QLbJG/Td1OId0PcraQW2TCuUcwmxTYbVlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779177; c=relaxed/simple;
	bh=USiqbd6cawaj7UxsrH/TRbVTMozozGxono8ggdnRlHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN0/FqLAOlhyQ6Fe+pEp4RitvhaG9ygL3Rf+1yujrsqqKDCBR8QNTebKKaPKu26Fvco+wHH0o9+VPUAOCryFq11MAc4HsQ91pDpX3kIjtu8tf/ZqJArm4oqpuQv9hRekWJcofpnT0AgAAjnUtQXogK3C5N0C2X/gqJgJ6q/oCr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDKquXDc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741779175; x=1773315175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=USiqbd6cawaj7UxsrH/TRbVTMozozGxono8ggdnRlHw=;
  b=EDKquXDcsiBHA7O7twvP77334YC3Pb/RftdqDxSvXM6/q2T3UJdJtx3k
   M2FzxduBD/q5y8TR6boEUc9kq1waqz/qVS9h4epg1tUSz1/l0/95TRq9K
   ApUZIO4XSt0wa3J9VIlJpr3uxIaPDhkOqb3nruU6E5ZXwOv/CfoTkkquX
   A22mLl9XH1rxiSulR+DNOct0jQFDsP4WCfUfV9exoo3C9fbciaueJJMvF
   PMYlRgsH6uK5L+B89e5MP0lxkXIXcMWD1aUWIlmuYiUTk+pA2LwshR8Gw
   L34ST5XJt1tv0bK8PVXohCgW9b0lz2yvnpIfWk40m5QHYFtOCDpIuuZSu
   Q==;
X-CSE-ConnectionGUID: gufzRy4OQPGoc8lIxi3Biw==
X-CSE-MsgGUID: S3uIDhkZTCCI5DpxL0PDCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42108151"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42108151"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:32:55 -0700
X-CSE-ConnectionGUID: Y8aNeSvPRbqw5JC3lSdL7g==
X-CSE-MsgGUID: XCjtZuRVTbuRE/U7WFYDBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="121516266"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 12 Mar 2025 04:32:49 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsKKM-0008Sm-16;
	Wed, 12 Mar 2025 11:32:46 +0000
Date: Wed, 12 Mar 2025 19:32:07 +0800
From: kernel test robot <lkp@intel.com>
To: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: [PATCH v4 20/36] x86/bugs: Determine relevant vulnerabilities
 based on attack vector controls.
Message-ID: <202503121906.IF0k61bY-lkp@intel.com>
References: <20250310164023.779191-21-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310164023.779191-21-david.kaplan@amd.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[cannot apply to tip/x86/core linus/master tip/auto-latest tip/smp/core v6.14-rc6 next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Kaplan/x86-bugs-Restructure-mds-mitigation/20250311-005151
base:   tip/master
patch link:    https://lore.kernel.org/r/20250310164023.779191-21-david.kaplan%40amd.com
patch subject: [PATCH v4 20/36] x86/bugs: Determine relevant vulnerabilities based on attack vector controls.
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20250312/202503121906.IF0k61bY-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503121906.IF0k61bY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503121906.IF0k61bY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/bugs.c:351:11: error: use of undeclared identifier 'smt_mitigations'; did you mean 'l1tf_mitigation'?
     351 |                        (smt_mitigations != SMT_MITIGATIONS_OFF);
         |                         ^~~~~~~~~~~~~~~
         |                         l1tf_mitigation
   arch/x86/include/asm/processor.h:745:30: note: 'l1tf_mitigation' declared here
     745 | extern enum l1tf_mitigations l1tf_mitigation;
         |                              ^
   arch/x86/kernel/cpu/bugs.c:1561:7: warning: variable 'smt_possible' set but not used [-Wunused-but-set-variable]
    1561 |         bool smt_possible = IS_ENABLED(CONFIG_SMP);
         |              ^
   1 warning and 1 error generated.


vim +351 arch/x86/kernel/cpu/bugs.c

   302	
   303	/*
   304	 * Returns true if vulnerability should be mitigated based on the
   305	 * selected attack vector controls.
   306	 *
   307	 * See Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
   308	 */
   309	static bool __init should_mitigate_vuln(unsigned int bug)
   310	{
   311		switch (bug) {
   312		/*
   313		 * The only runtime-selected spectre_v1 mitigations in the kernel are
   314		 * related to SWAPGS protection on kernel entry.  Therefore, protection
   315		 * is only required for the user->kernel attack vector.
   316		 */
   317		case X86_BUG_SPECTRE_V1:
   318			return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL);
   319	
   320		case X86_BUG_SPECTRE_V2:
   321		case X86_BUG_RETBLEED:
   322		case X86_BUG_SRSO:
   323		case X86_BUG_L1TF:
   324			return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
   325			       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST);
   326	
   327		case X86_BUG_SPECTRE_V2_USER:
   328			return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
   329			       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST);
   330	
   331		/*
   332		 * All the vulnerabilities below allow potentially leaking data
   333		 * across address spaces.  Therefore, mitigation is required for
   334		 * any of these 4 attack vectors.
   335		 */
   336		case X86_BUG_MDS:
   337		case X86_BUG_TAA:
   338		case X86_BUG_MMIO_STALE_DATA:
   339		case X86_BUG_RFDS:
   340		case X86_BUG_SRBDS:
   341			return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
   342			       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST) ||
   343			       cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
   344			       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST);
   345	
   346		case X86_BUG_GDS:
   347			return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
   348			       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST) ||
   349			       cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
   350			       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST) ||
 > 351			       (smt_mitigations != SMT_MITIGATIONS_OFF);
   352		default:
   353			WARN(1, "Unknown bug %x\n", bug);
   354			return false;
   355		}
   356	}
   357	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

