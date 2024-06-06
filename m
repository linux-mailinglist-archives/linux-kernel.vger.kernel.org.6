Return-Path: <linux-kernel+bounces-205142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6448FF7FB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D005528A607
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C35B13E054;
	Thu,  6 Jun 2024 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCCgzT/O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88FE13D884
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715545; cv=none; b=qE9hYFR9Ji4L3s0SqwA3iSSf0+X2Z/1HfHxqdA2YXaOiuwdd0fSc+9VTBHXJ+0OwvTEuWJYmjLUdDSNK2a2d43qgr7bd2PitCZhrrpkk9fxvj6PgmSzmcsNIEzAJNNmcqBpXwwHU2+I0R2QbR08qZslLqDkgrwWJ2d1i4FJAjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715545; c=relaxed/simple;
	bh=UxgXmFowYVLE9rUt04mrl6c/rElWFPzaOW5I47QclB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF/aVj8W1YeJ+lgFsjiYT80ELfNWsBEiZ+6Ck7mTmLGfrrT/MqLk+WNdbIR9Dsajs1uLKzDkWhw+EaUqVW8ZoZTHwb7Gn2HBFh/ZwZ4H+QRbG81AOZf1eY9Izjdt4O7e39H7owyxDFdryiT4KAg/1B54wP/Be10v+0B4qh5gfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCCgzT/O; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717715544; x=1749251544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UxgXmFowYVLE9rUt04mrl6c/rElWFPzaOW5I47QclB0=;
  b=WCCgzT/Oz6x13MMTpoh396G/uKIC7wZ3yRlpTzoOU/8TJN46cODLvdy0
   DVHhi9pcMPMY5Bmri3wQZitF9O7F36wRXATLbvAcHNhOfK3O3dmJce6Ai
   h8kD0kIlv7mAtsgXJUk+0uGLgrwT4afjPDFFvmkaUF7qWyiUgb2O8IRUh
   ufcb97PXNRuNO5+zOQ7U3gI9vAm+J5Xyu4ij6Glp3HiJVSswoXiuwG9be
   TWaScJeu3FUocmcuCH6HJ1IxJUxxmg7qSi1TlZ51dQjBlxYFTldV32PHu
   iNpDbwmEYbSJduBqAEeQBHbp5S9hngtqZyDcLlylxDKJ8PeFo8C2o6+G+
   Q==;
X-CSE-ConnectionGUID: h1j8fBGaR7WVWQAV4r9Ddw==
X-CSE-MsgGUID: kNYMzvHtQaiTE8n8ose2rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14600270"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14600270"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:12:23 -0700
X-CSE-ConnectionGUID: 2UalCSQ4S9iYZbcTDMW4jw==
X-CSE-MsgGUID: 5QSzTMwTQl25hS0Nqz38Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38805588"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 06 Jun 2024 16:12:17 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFMHG-0003qE-2w;
	Thu, 06 Jun 2024 23:12:14 +0000
Date: Fri, 7 Jun 2024 07:11:28 +0800
From: kernel test robot <lkp@intel.com>
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
	Erick Archer <erick.archer@gmx.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] RISC-V: Report vector unaligned accesse speed hwprobe
Message-ID: <202406070612.Vj1dDiqM-lkp@intel.com>
References: <20240606183215.416829-3-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606183215.416829-3-jesse@rivosinc.com>

Hi Jesse,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.9]
[cannot apply to akpm-mm/mm-everything linus/master v6.10-rc2 v6.10-rc1 next-20240606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesse-Taube/RISC-V-Detect-unaligned-vector-accesses-supported/20240607-023434
base:   v6.9
patch link:    https://lore.kernel.org/r/20240606183215.416829-3-jesse%40rivosinc.com
patch subject: [PATCH 3/3] RISC-V: Report vector unaligned accesse speed hwprobe
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20240607/202406070612.Vj1dDiqM-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070612.Vj1dDiqM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070612.Vj1dDiqM-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   arch/riscv/kernel/unaligned_access_speed.c: In function 'vec_check_unaligned_access_speed_all_cpus':
>> arch/riscv/kernel/unaligned_access_speed.c:370:30: error: 'check_vector_unaligned_access' undeclared (first use in this function); did you mean 'check_unaligned_access'?
     370 |         schedule_on_each_cpu(check_vector_unaligned_access);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                              check_unaligned_access
   arch/riscv/kernel/unaligned_access_speed.c:370:30: note: each undeclared identifier is reported only once for each function it appears in
>> arch/riscv/kernel/unaligned_access_speed.c:377:35: error: 'riscv_online_cpu_vec' undeclared (first use in this function); did you mean 'riscv_online_cpu'?
     377 |                                   riscv_online_cpu_vec, NULL);
         |                                   ^~~~~~~~~~~~~~~~~~~~
         |                                   riscv_online_cpu
   arch/riscv/kernel/unaligned_access_speed.c: At top level:
>> arch/riscv/kernel/unaligned_access_speed.c:368:12: warning: 'vec_check_unaligned_access_speed_all_cpus' defined but not used [-Wunused-function]
     368 | static int vec_check_unaligned_access_speed_all_cpus(void *unused)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +370 arch/riscv/kernel/unaligned_access_speed.c

   366	
   367	/* Measure unaligned access speed on all CPUs present at boot in parallel. */
 > 368	static int vec_check_unaligned_access_speed_all_cpus(void *unused)
   369	{
 > 370		schedule_on_each_cpu(check_vector_unaligned_access);
   371	
   372		/*
   373		 * Setup hotplug callbacks for any new CPUs that come online or go
   374		 * offline.
   375		 */
   376		cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
 > 377					  riscv_online_cpu_vec, NULL);
   378	
   379		return 0;
   380	}
   381	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

