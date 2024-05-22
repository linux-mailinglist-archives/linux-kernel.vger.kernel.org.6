Return-Path: <linux-kernel+bounces-186404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E0D8CC3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB72C1C22181
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F114249FE;
	Wed, 22 May 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2euVCne"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60E21362
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390385; cv=none; b=WaJKawzcLcPxtmEl766BhkGh+XA8+il96UG1z27xS3+OZ2Ba+xbVWYskshxMkF4MRwjvmwcdxvskr1d+xZo0YQYkYUMGR4bGRP+uJWLlKpGC71bVpQKjkoGNpI/BNCFRZXkkJsyYTWoFO1roehvb0Ak/ttigNgnl07X5Ny5uk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390385; c=relaxed/simple;
	bh=qv0FoQjoCwEfgMkQVSH/WXa2+aVacXHUSQDy3m2KIU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FXHqPi/16QUgAZd7rkxmYLPNpl6M0YLTisINTecxvTVfgs/ATSynYM6Id4XrZUQowpWDkVcPu+98wB48pwx3obVgK+2cUoWEyQ/Sxe2+TwKh+u86uaMX1HBSemG8q1uVENLDZIUlJ/MXDozH6QZ8qywJwf4ePDYw6+zLyLh+zCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2euVCne; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716390383; x=1747926383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qv0FoQjoCwEfgMkQVSH/WXa2+aVacXHUSQDy3m2KIU4=;
  b=n2euVCneJmklC4ipVnZXkxTfD2sWatcE3/RKZBcNSie2vwoOWGGoLljX
   YOfI6uz6+UQbAy+gX9nWq5YGruSHuLAHWSzqSMH5gGA1+vcDE+ROYsWPs
   3q4qTjMZKUdVkX8EXvllVQj00lU307z6EGdvaIwEFyhNb9+Vk6JRJntbq
   rKtj8Jg//3DWa26VvrtHpGZRm42mo+XSXEvPwdFv9IaFEJQ3y7kMNGNFt
   IdPQrEOSvBFNB2iQE2xuOgziRTSW1cRWVS7pKkq6MLecymtVyVTDZ1p2v
   MPsiZ+TfTXhq0dSR2BKiqHJTJzMkdbOUwpZ3Hax5koK5kWskAbNyumaIG
   g==;
X-CSE-ConnectionGUID: KTC6k19uTEWvvGjHH71+vw==
X-CSE-MsgGUID: V1hSigpFRey1NaTUGfDRsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="11647657"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="11647657"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 08:06:22 -0700
X-CSE-ConnectionGUID: byC7jGm3Tqi5b1v82Ld6Xg==
X-CSE-MsgGUID: ARlKyOfxQUiWaKr6PoEzyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37797515"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 22 May 2024 08:06:20 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9nXe-0001fV-1f;
	Wed, 22 May 2024 15:06:12 +0000
Date: Wed, 22 May 2024 23:05:31 +0800
From: kernel test robot <lkp@intel.com>
To: Shahab Vahedi <shahab@synopsys.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: arch/arc/net/bpf_jit.h:42:15: sparse: sparse: marked inline, but
 without a definition
Message-ID: <202405222314.UG5F2NHn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   29c73fc794c83505066ee6db893b2a83ac5fac63
commit: f122668ddcce450c2585f0be4bf4478d6fd6176b ARC: Add eBPF JIT support
date:   10 days ago
config: arc-randconfig-r133-20240522 (https://download.01.org/0day-ci/archive/20240522/202405222314.UG5F2NHn-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240522/202405222314.UG5F2NHn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405222314.UG5F2NHn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/arc/net/bpf_jit_core.c: note: in included file:
>> arch/arc/net/bpf_jit.h:42:15: sparse: sparse: marked inline, but without a definition
--
>> arch/arc/net/bpf_jit_arcv2.c:2238:17: sparse: sparse: statement expected after case label
   arch/arc/net/bpf_jit_arcv2.c:2256:17: sparse: sparse: statement expected after case label
   arch/arc/net/bpf_jit_arcv2.c:2872:9: sparse: sparse: statement expected after case label
>> arch/arc/net/bpf_jit_arcv2.c:65:10: sparse: sparse: symbol 'bpf2arc' was not declared. Should it be static?
>> arch/arc/net/bpf_jit_arcv2.c:2536:3: sparse: sparse: symbol 'arcv2_64_jccs' was not declared. Should it be static?
>> arch/arc/net/bpf_jit_arcv2.c:2886:10: sparse: sparse: symbol 'arcv2_32_jmps' was not declared. Should it be static?

vim +42 arch/arc/net/bpf_jit.h

    39	
    40	/************** Functions that the back-end must provide **************/
    41	/* Extension for 32-bit operations. */
  > 42	inline u8 zext(u8 *buf, u8 rd);
    43	/***** Moves *****/
    44	u8 mov_r32(u8 *buf, u8 rd, u8 rs, u8 sign_ext);
    45	u8 mov_r32_i32(u8 *buf, u8 reg, s32 imm);
    46	u8 mov_r64(u8 *buf, u8 rd, u8 rs, u8 sign_ext);
    47	u8 mov_r64_i32(u8 *buf, u8 reg, s32 imm);
    48	u8 mov_r64_i64(u8 *buf, u8 reg, u32 lo, u32 hi);
    49	/***** Loads and stores *****/
    50	u8 load_r(u8 *buf, u8 rd, u8 rs, s16 off, u8 size, bool sign_ext);
    51	u8 store_r(u8 *buf, u8 rd, u8 rs, s16 off, u8 size);
    52	u8 store_i(u8 *buf, s32 imm, u8 rd, s16 off, u8 size);
    53	/***** Addition *****/
    54	u8 add_r32(u8 *buf, u8 rd, u8 rs);
    55	u8 add_r32_i32(u8 *buf, u8 rd, s32 imm);
    56	u8 add_r64(u8 *buf, u8 rd, u8 rs);
    57	u8 add_r64_i32(u8 *buf, u8 rd, s32 imm);
    58	/***** Subtraction *****/
    59	u8 sub_r32(u8 *buf, u8 rd, u8 rs);
    60	u8 sub_r32_i32(u8 *buf, u8 rd, s32 imm);
    61	u8 sub_r64(u8 *buf, u8 rd, u8 rs);
    62	u8 sub_r64_i32(u8 *buf, u8 rd, s32 imm);
    63	/***** Multiplication *****/
    64	u8 mul_r32(u8 *buf, u8 rd, u8 rs);
    65	u8 mul_r32_i32(u8 *buf, u8 rd, s32 imm);
    66	u8 mul_r64(u8 *buf, u8 rd, u8 rs);
    67	u8 mul_r64_i32(u8 *buf, u8 rd, s32 imm);
    68	/***** Division *****/
    69	u8 div_r32(u8 *buf, u8 rd, u8 rs, bool sign_ext);
    70	u8 div_r32_i32(u8 *buf, u8 rd, s32 imm, bool sign_ext);
    71	/***** Remainder *****/
    72	u8 mod_r32(u8 *buf, u8 rd, u8 rs, bool sign_ext);
    73	u8 mod_r32_i32(u8 *buf, u8 rd, s32 imm, bool sign_ext);
    74	/***** Bitwise AND *****/
    75	u8 and_r32(u8 *buf, u8 rd, u8 rs);
    76	u8 and_r32_i32(u8 *buf, u8 rd, s32 imm);
    77	u8 and_r64(u8 *buf, u8 rd, u8 rs);
    78	u8 and_r64_i32(u8 *buf, u8 rd, s32 imm);
    79	/***** Bitwise OR *****/
    80	u8 or_r32(u8 *buf, u8 rd, u8 rs);
    81	u8 or_r32_i32(u8 *buf, u8 rd, s32 imm);
    82	u8 or_r64(u8 *buf, u8 rd, u8 rs);
    83	u8 or_r64_i32(u8 *buf, u8 rd, s32 imm);
    84	/***** Bitwise XOR *****/
    85	u8 xor_r32(u8 *buf, u8 rd, u8 rs);
    86	u8 xor_r32_i32(u8 *buf, u8 rd, s32 imm);
    87	u8 xor_r64(u8 *buf, u8 rd, u8 rs);
    88	u8 xor_r64_i32(u8 *buf, u8 rd, s32 imm);
    89	/***** Bitwise Negate *****/
    90	u8 neg_r32(u8 *buf, u8 r);
    91	u8 neg_r64(u8 *buf, u8 r);
    92	/***** Bitwise left shift *****/
    93	u8 lsh_r32(u8 *buf, u8 rd, u8 rs);
    94	u8 lsh_r32_i32(u8 *buf, u8 rd, u8 imm);
    95	u8 lsh_r64(u8 *buf, u8 rd, u8 rs);
    96	u8 lsh_r64_i32(u8 *buf, u8 rd, s32 imm);
    97	/***** Bitwise right shift (logical) *****/
    98	u8 rsh_r32(u8 *buf, u8 rd, u8 rs);
    99	u8 rsh_r32_i32(u8 *buf, u8 rd, u8 imm);
   100	u8 rsh_r64(u8 *buf, u8 rd, u8 rs);
   101	u8 rsh_r64_i32(u8 *buf, u8 rd, s32 imm);
   102	/***** Bitwise right shift (arithmetic) *****/
   103	u8 arsh_r32(u8 *buf, u8 rd, u8 rs);
   104	u8 arsh_r32_i32(u8 *buf, u8 rd, u8 imm);
   105	u8 arsh_r64(u8 *buf, u8 rd, u8 rs);
   106	u8 arsh_r64_i32(u8 *buf, u8 rd, s32 imm);
   107	/***** Frame related *****/
   108	u32 mask_for_used_regs(u8 bpf_reg, bool is_call);
   109	u8 arc_prologue(u8 *buf, u32 usage, u16 frame_size);
   110	u8 arc_epilogue(u8 *buf, u32 usage, u16 frame_size);
   111	/***** Jumps *****/
   112	/*
   113	 * Different sorts of conditions (ARC enum as opposed to BPF_*).
   114	 *
   115	 * Do not change the order of enums here. ARC_CC_SLE+1 is used
   116	 * to determine the number of JCCs.
   117	 */
   118	enum ARC_CC {
   119		ARC_CC_UGT = 0,		/* unsigned >  */
   120		ARC_CC_UGE,		/* unsigned >= */
   121		ARC_CC_ULT,		/* unsigned <  */
   122		ARC_CC_ULE,		/* unsigned <= */
   123		ARC_CC_SGT,		/*   signed >  */
   124		ARC_CC_SGE,		/*   signed >= */
   125		ARC_CC_SLT,		/*   signed <  */
   126		ARC_CC_SLE,		/*   signed <= */
   127		ARC_CC_AL,		/* always      */
   128		ARC_CC_EQ,		/*          == */
   129		ARC_CC_NE,		/*          != */
   130		ARC_CC_SET,		/* test        */
   131		ARC_CC_LAST
   132	};
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

