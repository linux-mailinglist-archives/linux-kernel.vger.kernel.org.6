Return-Path: <linux-kernel+bounces-205107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1292A8FF767
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ED7283645
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFF213D280;
	Thu,  6 Jun 2024 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNsKvQlX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD513C83D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711180; cv=none; b=YddD0Fl503gXTOzbbm6fTc4a+NAoW+dbrewEcGsFGWp4pYn0/kvZnEqd8PATC0AUFnDt/tzwkMIEbZiSR/8a4FTbsQGOVsmkWKBW+zjHQzw4T8q9bKRgKqu11OdxYLLQD3r0ikNh46erijiURNyueWfqW9EfuituAHT892dwUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711180; c=relaxed/simple;
	bh=+Gwn0DCpWggIO+/CSb7e0Je5msLNmTRhJebT8XHU8NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4+6IDg9MoyrKEZ+QuH0YjXB8PlJvq7ifElshVcORJYpyVUYPnVo4hNO74BeUUBV3Wlj6h+nTLRe3XHhhjGNU1t69L1t8jUAUlJwG9OfIq9W57U8jV39RXb8qvkVrO6q2O10UMsrw8/x9LtLtLXKyOa0+RRhcX/n4B6D67KkLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNsKvQlX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717711179; x=1749247179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Gwn0DCpWggIO+/CSb7e0Je5msLNmTRhJebT8XHU8NU=;
  b=iNsKvQlXd5p30NFPLFq+E9wY9qLwq0EI/fusr4Pqoc9rvgX+GOmgEct9
   //8mYOhgqmIk779maWLMrADRvZvt8JpykgaIuQ3dpmFGHwvgE0AwRxvXt
   92ND96XMDK0HAuGf9jlzKzH2tsClHOWA/01pNtRRNOxpp2f0vzKHE8fm4
   3TASNY1ITELICeB18HRSTtRruoTR2pdSsemOmnZlYp1mSm5BFFxuuNyzw
   AyNxOiAfH6dZPlSq/lN8Lg+2lrT4MAFxftXJGwTh6E6Ma2fI7QX9LD7eI
   6vkVp8gSg7G0LImHO26WdJkfjMh5Lyx/wXFF040I94EPzO1YF+/zb+7La
   A==;
X-CSE-ConnectionGUID: LmgKGEimSUyHpbzW45djkA==
X-CSE-MsgGUID: km7P2Kw/T2+v67jSLG95yQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14367729"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14367729"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 14:59:38 -0700
X-CSE-ConnectionGUID: xzoZxw0oQ8CbgKXPJQxYzw==
X-CSE-MsgGUID: iGfO0fY6TamP4YqJsropYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42545100"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Jun 2024 14:59:32 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFL8r-0003mC-2D;
	Thu, 06 Jun 2024 21:59:29 +0000
Date: Fri, 7 Jun 2024 05:58:56 +0800
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
Subject: Re: [PATCH 2/3] RISC-V: Detect unaligned vector accesses supported.
Message-ID: <202406070508.6UJUx2rO-lkp@intel.com>
References: <20240606183215.416829-2-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606183215.416829-2-jesse@rivosinc.com>

Hi Jesse,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.9]
[cannot apply to akpm-mm/mm-everything linus/master v6.10-rc2 v6.10-rc1 next-20240606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesse-Taube/RISC-V-Detect-unaligned-vector-accesses-supported/20240607-023434
base:   v6.9
patch link:    https://lore.kernel.org/r/20240606183215.416829-2-jesse%40rivosinc.com
patch subject: [PATCH 2/3] RISC-V: Detect unaligned vector accesses supported.
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20240607/202406070508.6UJUx2rO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070508.6UJUx2rO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070508.6UJUx2rO-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/kernel/traps_misaligned.c: In function 'handle_misaligned_load':
>> arch/riscv/kernel/traps_misaligned.c:427:13: error: implicit declaration of function 'insn_is_vector' [-Werror=implicit-function-declaration]
     427 |         if (insn_is_vector(insn) &&
         |             ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/insn_is_vector +427 arch/riscv/kernel/traps_misaligned.c

   406	
   407	int handle_misaligned_load(struct pt_regs *regs)
   408	{
   409		union reg_data val;
   410		unsigned long epc = regs->epc;
   411		unsigned long insn;
   412		unsigned long addr = regs->badaddr;
   413		int i, fp = 0, shift = 0, len = 0;
   414	
   415		perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
   416	
   417		if (!unaligned_enabled)
   418			return -1;
   419	
   420		if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
   421			return -1;
   422	
   423		if (get_insn(regs, epc, &insn))
   424			return -1;
   425	
   426	#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
 > 427		if (insn_is_vector(insn) &&
   428		    *this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED) {
   429			*this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
   430			regs->epc = epc + INSN_LEN(insn);
   431			return 0;
   432		}
   433	
   434		*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
   435	#endif
   436	
   437		regs->epc = 0;
   438	
   439		if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
   440			len = 4;
   441			shift = 8 * (sizeof(unsigned long) - len);
   442	#if defined(CONFIG_64BIT)
   443		} else if ((insn & INSN_MASK_LD) == INSN_MATCH_LD) {
   444			len = 8;
   445			shift = 8 * (sizeof(unsigned long) - len);
   446		} else if ((insn & INSN_MASK_LWU) == INSN_MATCH_LWU) {
   447			len = 4;
   448	#endif
   449		} else if ((insn & INSN_MASK_FLD) == INSN_MATCH_FLD) {
   450			fp = 1;
   451			len = 8;
   452		} else if ((insn & INSN_MASK_FLW) == INSN_MATCH_FLW) {
   453			fp = 1;
   454			len = 4;
   455		} else if ((insn & INSN_MASK_LH) == INSN_MATCH_LH) {
   456			len = 2;
   457			shift = 8 * (sizeof(unsigned long) - len);
   458		} else if ((insn & INSN_MASK_LHU) == INSN_MATCH_LHU) {
   459			len = 2;
   460	#if defined(CONFIG_64BIT)
   461		} else if ((insn & INSN_MASK_C_LD) == INSN_MATCH_C_LD) {
   462			len = 8;
   463			shift = 8 * (sizeof(unsigned long) - len);
   464			insn = RVC_RS2S(insn) << SH_RD;
   465		} else if ((insn & INSN_MASK_C_LDSP) == INSN_MATCH_C_LDSP &&
   466			   ((insn >> SH_RD) & 0x1f)) {
   467			len = 8;
   468			shift = 8 * (sizeof(unsigned long) - len);
   469	#endif
   470		} else if ((insn & INSN_MASK_C_LW) == INSN_MATCH_C_LW) {
   471			len = 4;
   472			shift = 8 * (sizeof(unsigned long) - len);
   473			insn = RVC_RS2S(insn) << SH_RD;
   474		} else if ((insn & INSN_MASK_C_LWSP) == INSN_MATCH_C_LWSP &&
   475			   ((insn >> SH_RD) & 0x1f)) {
   476			len = 4;
   477			shift = 8 * (sizeof(unsigned long) - len);
   478		} else if ((insn & INSN_MASK_C_FLD) == INSN_MATCH_C_FLD) {
   479			fp = 1;
   480			len = 8;
   481			insn = RVC_RS2S(insn) << SH_RD;
   482		} else if ((insn & INSN_MASK_C_FLDSP) == INSN_MATCH_C_FLDSP) {
   483			fp = 1;
   484			len = 8;
   485	#if defined(CONFIG_32BIT)
   486		} else if ((insn & INSN_MASK_C_FLW) == INSN_MATCH_C_FLW) {
   487			fp = 1;
   488			len = 4;
   489			insn = RVC_RS2S(insn) << SH_RD;
   490		} else if ((insn & INSN_MASK_C_FLWSP) == INSN_MATCH_C_FLWSP) {
   491			fp = 1;
   492			len = 4;
   493	#endif
   494		} else {
   495			regs->epc = epc;
   496			return -1;
   497		}
   498	
   499		if (!IS_ENABLED(CONFIG_FPU) && fp)
   500			return -EOPNOTSUPP;
   501	
   502		val.data_u64 = 0;
   503		for (i = 0; i < len; i++) {
   504			if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
   505				return -1;
   506		}
   507	
   508		if (!fp)
   509			SET_RD(insn, regs, val.data_ulong << shift >> shift);
   510		else if (len == 8)
   511			set_f64_rd(insn, regs, val.data_u64);
   512		else
   513			set_f32_rd(insn, regs, val.data_ulong);
   514	
   515		regs->epc = epc + INSN_LEN(insn);
   516	
   517		return 0;
   518	}
   519	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

