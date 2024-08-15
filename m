Return-Path: <linux-kernel+bounces-288515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E9953B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9684128176B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478413B2AC;
	Thu, 15 Aug 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="at9EoyBU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356BA5A0F5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751548; cv=none; b=QowmwB7z0LQgboFELRbsuFDcimxS1yUbonu8iqBp53krSPKpBw7LKDm9846DEho5PViO4AqpqqGGPMh5QWQJCnSGt/C2nC6voKBlaTjUXWzGgvieH2W8mo08olh9xDhCLM3mSfMPeEr3BMAa4bLtLvngKs8fmAXTi7ZRsj6O05I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751548; c=relaxed/simple;
	bh=oB8oS4I1iHl/GL4cZe1LnM+cRl57HEZiPtXITi4pllg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPHf+WsOuZW68h7QLCpVN3KU0Fbz1kIrDmUzaQltjOA66VzAXLArgBpEfWypzg9L4Fz+KKG93DkTGw0tLhlELZ+CKya0HiY8MShWxIKdbpus/jVQnaEkcJJMgSuDzBG18YInCrfse+Rez1u7yo9kRvAMI3PmjtEpY/3kLUnRDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=at9EoyBU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723751548; x=1755287548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oB8oS4I1iHl/GL4cZe1LnM+cRl57HEZiPtXITi4pllg=;
  b=at9EoyBUwORpKGFOTY6JwmOIWm/wbzb9a/rIBfYFZwRwdlYnMKUE3+iy
   fJVPybe9bog7er3ndYMx8hOdbamYfJjNNMHEMJUu78miei+Bo4bvza9JC
   Lz5XHkW70KMWMU1Ly7usVxsaOZ+O8D5g38V9bqSODqykPVstifaxYuwWB
   csYiA4IuUB6h3DCootDhpIDDggl+GKiNITsVKNcx9IYN+P6M4p8Jif+1z
   HWna8m0wasFTg/5/xiVS2MTcH7XAMnvQ/9F/ekhCwi1H2OfNzaZ2vi+x5
   AcwCgWi4zy/52cAwFYBELzM7VkI/UWpxd8cD3g6zfNiKE2woPNPuCSZDN
   A==;
X-CSE-ConnectionGUID: DYEmdb+vRjmEKd34predpg==
X-CSE-MsgGUID: JKdXtbLFQjCc13/LkM/f4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22177429"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="22177429"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 12:52:27 -0700
X-CSE-ConnectionGUID: c3lwwQsdQfyiYoQnBD+ijg==
X-CSE-MsgGUID: wd8N1tU7SCmMi0JQbyflgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="59476885"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Aug 2024 12:52:21 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1segWB-0005Y6-08;
	Thu, 15 Aug 2024 19:52:19 +0000
Date: Fri, 16 Aug 2024 03:51:27 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Rommel <mail@florommel.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Thompson <daniel.thompson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
	Stefan Saecherl <stefan.saecherl@fau.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kgdb-bugreport@lists.sourceforge.net, x86@kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Florian Rommel <mail@florommel.de>
Subject: Re: [PATCH WIP] x86/kgdb: trampolines for shadowed instructions
Message-ID: <202408160303.FvgjFUth-lkp@intel.com>
References: <20240814085141.171564-1-mail@florommel.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814085141.171564-1-mail@florommel.de>

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on tip/x86/core linus/master v6.11-rc3 next-20240815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Rommel/x86-kgdb-trampolines-for-shadowed-instructions/20240814-230936
base:   tip/master
patch link:    https://lore.kernel.org/r/20240814085141.171564-1-mail%40florommel.de
patch subject: [PATCH WIP] x86/kgdb: trampolines for shadowed instructions
config: x86_64-buildonly-randconfig-004-20240815 (https://download.01.org/0day-ci/archive/20240816/202408160303.FvgjFUth-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160303.FvgjFUth-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408160303.FvgjFUth-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `kgdb_arch_init':
>> arch/x86/kernel/kgdb.c:416: undefined reference to `execmem_alloc'


vim +416 arch/x86/kernel/kgdb.c

   410	
   411	static int kgdb_init_trampolines(void)
   412	{
   413		/* FIXME: We should reserve enough space for all breakpoints
   414		   or make the trampoline table dynamic somehow.. */
   415		/* FIXME: Currently borrowing EXECMEM_KPROBES */
 > 416		kgdb_trampoline_page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
   417		if (!kgdb_trampoline_page)
   418			return 1;
   419		memset(kgdb_trampoline_page, INT3_INSN_OPCODE, PAGE_SIZE);
   420		set_memory_rox((unsigned long)kgdb_trampoline_page, 1);
   421		kgdb_trampoline_page_curr_slot = kgdb_trampoline_page;
   422		return 0;
   423	}
   424	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

