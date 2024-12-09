Return-Path: <linux-kernel+bounces-436763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9629E8A67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E836D163E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E802F15C120;
	Mon,  9 Dec 2024 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3duNKLr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229FA189B9F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718988; cv=none; b=eeAhweig5W4wJWLtkMwwkDtYKF5vcPvWwEJSXIWzLyEfzhJuLKJKs6jI+LtlmAa1BXCnLtlT6CMjh60QWgBOiAlPesxdRzPSzFv8CfAZpXo61YKECbNZtkZKhLxa/uC/RRw1UPaBTsVAPCpm/3VX5tR9Fka73Hq6EKmyYd0waEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718988; c=relaxed/simple;
	bh=uGfUh269xf5BWUanMyXVkZGEp4+2Kk98+gqUJweo0io=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EC14O0kYtUrx6GsJ9mlW4CO5zFPRXgqNZoogmfYoP6Nsf790dobO7dE4uNgbwZwPFNYM3uv3uqppVqCH+okcWfnA+3y81eEI/WdGpGaI6smK+8GjM4AeSfUqXD3LfAnEPnsR5CX/VcHRi0VW8LWRzRJsMCyv/N4pbCq0f824yb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3duNKLr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733718985; x=1765254985;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uGfUh269xf5BWUanMyXVkZGEp4+2Kk98+gqUJweo0io=;
  b=C3duNKLrZ8SUEMKjapdwnbg/1UZYTGfhVr7LLftTnYtWqqXuZrzYeZWo
   jx2rJ2A97bv1BqYxZDKhig4CBZO6OPFYS3i7eNso59dmOhVELeWENN5Nf
   P6JMq07X0Rzi1kFyxnfUa4WTDy5/2Xsso/bQM7OIg+F8XiSIzAiw1y3N0
   mEz0t0rh479K7+XWoszh9MaqXOdnkw8gWg2xW6FxeWeb7gmH3hXaTIWrf
   Z/0lCCLKrSSJplkZcDpdshp37wOBG/L1PWD9ebNWRFL3/IQtk0B7WjpYS
   a8CL0hG5vEdJUKNF4IbeDw+ONajdvtKvjVzOaX5Xst/bvHQJt4iisxYyO
   g==;
X-CSE-ConnectionGUID: Y/MNh1g3RE+ZHY0mGoTTgg==
X-CSE-MsgGUID: kpbO0zIrR3GwQIC9aRVjNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="51415686"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="51415686"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:36:24 -0800
X-CSE-ConnectionGUID: oullRzA+QdW0SfOjpkLFCg==
X-CSE-MsgGUID: cICaIopsTemE9waGSXnQRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99907498"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Dec 2024 20:36:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVVM-0003sx-2K;
	Mon, 09 Dec 2024 04:36:20 +0000
Date: Mon, 9 Dec 2024 12:35:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: arch/powerpc/net/bpf_jit_comp64.c:903:41: sparse: sparse: cast
 truncates bits from constant value (8000000000000000 becomes 0)
Message-ID: <202412080923.Hmv6ehSj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7503345ac5f5e82fd9a36d6e6b447c016376403a
commit: 2c9e5d4a008293407836d29d35dfd4353615bd2f bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of
date:   7 months ago
config: powerpc64-randconfig-r113-20241208 (https://download.01.org/0day-ci/archive/20241208/202412080923.Hmv6ehSj-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce: (https://download.01.org/0day-ci/archive/20241208/202412080923.Hmv6ehSj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412080923.Hmv6ehSj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/net/bpf_jit_comp64.c:903:41: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
>> arch/powerpc/net/bpf_jit_comp64.c:903:41: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
>> arch/powerpc/net/bpf_jit_comp64.c:905:41: sparse: sparse: cast truncates bits from constant value (c000000000000000 becomes 0)
>> arch/powerpc/net/bpf_jit_comp64.c:905:41: sparse: sparse: cast truncates bits from constant value (c000000000000000 becomes 0)

vim +903 arch/powerpc/net/bpf_jit_comp64.c

b7540d62509453 Naveen N. Rao    2021-10-06  362  
156d0e290e969c Naveen N. Rao    2016-06-22  363  /* Assemble the body code between the prologue & epilogue */
90d862f370b6e9 Hari Bathini     2023-10-20  364  int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
85e031154c7c14 Christophe Leroy 2023-02-01  365  		       u32 *addrs, int pass, bool extra_pass)
156d0e290e969c Naveen N. Rao    2016-06-22  366  {
b7540d62509453 Naveen N. Rao    2021-10-06  367  	enum stf_barrier_type stf_barrier = stf_barrier_type_get();
156d0e290e969c Naveen N. Rao    2016-06-22  368  	const struct bpf_insn *insn = fp->insnsi;
156d0e290e969c Naveen N. Rao    2016-06-22  369  	int flen = fp->len;
e2c95a61656d29 Daniel Borkmann  2018-11-26  370  	int i, ret;
156d0e290e969c Naveen N. Rao    2016-06-22  371  
156d0e290e969c Naveen N. Rao    2016-06-22  372  	/* Start of epilogue code - will only be valid 2nd pass onwards */
156d0e290e969c Naveen N. Rao    2016-06-22  373  	u32 exit_addr = addrs[flen];
156d0e290e969c Naveen N. Rao    2016-06-22  374  
156d0e290e969c Naveen N. Rao    2016-06-22  375  	for (i = 0; i < flen; i++) {
156d0e290e969c Naveen N. Rao    2016-06-22  376  		u32 code = insn[i].code;
49c3af43e65fbc Naveen N. Rao    2022-02-14  377  		u32 dst_reg = bpf_to_ppc(insn[i].dst_reg);
49c3af43e65fbc Naveen N. Rao    2022-02-14  378  		u32 src_reg = bpf_to_ppc(insn[i].src_reg);
efa95f031bf38c Hari Bathini     2021-10-12  379  		u32 size = BPF_SIZE(code);
49c3af43e65fbc Naveen N. Rao    2022-02-14  380  		u32 tmp1_reg = bpf_to_ppc(TMP_REG_1);
49c3af43e65fbc Naveen N. Rao    2022-02-14  381  		u32 tmp2_reg = bpf_to_ppc(TMP_REG_2);
1e82dfaa7819f0 Hari Bathini     2022-06-10  382  		u32 save_reg, ret_reg;
156d0e290e969c Naveen N. Rao    2016-06-22  383  		s16 off = insn[i].off;
156d0e290e969c Naveen N. Rao    2016-06-22  384  		s32 imm = insn[i].imm;
e2c95a61656d29 Daniel Borkmann  2018-11-26  385  		bool func_addr_fixed;
e2c95a61656d29 Daniel Borkmann  2018-11-26  386  		u64 func_addr;
156d0e290e969c Naveen N. Rao    2016-06-22  387  		u64 imm64;
156d0e290e969c Naveen N. Rao    2016-06-22  388  		u32 true_cond;
b9c1e60e7bf4e6 Daniel Borkmann  2018-07-19  389  		u32 tmp_idx;
f9320c49993ca3 Naveen N. Rao    2022-01-06  390  		int j;
156d0e290e969c Naveen N. Rao    2016-06-22  391  
156d0e290e969c Naveen N. Rao    2016-06-22  392  		/*
156d0e290e969c Naveen N. Rao    2016-06-22  393  		 * addrs[] maps a BPF bytecode address into a real offset from
156d0e290e969c Naveen N. Rao    2016-06-22  394  		 * the start of the body code.
156d0e290e969c Naveen N. Rao    2016-06-22  395  		 */
156d0e290e969c Naveen N. Rao    2016-06-22  396  		addrs[i] = ctx->idx * 4;
156d0e290e969c Naveen N. Rao    2016-06-22  397  
156d0e290e969c Naveen N. Rao    2016-06-22  398  		/*
156d0e290e969c Naveen N. Rao    2016-06-22  399  		 * As an optimization, we note down which non-volatile registers
156d0e290e969c Naveen N. Rao    2016-06-22  400  		 * are used so that we can only save/restore those in our
156d0e290e969c Naveen N. Rao    2016-06-22  401  		 * prologue and epilogue. We do this here regardless of whether
156d0e290e969c Naveen N. Rao    2016-06-22  402  		 * the actual BPF instruction uses src/dst registers or not
156d0e290e969c Naveen N. Rao    2016-06-22  403  		 * (for instance, BPF_CALL does not use them). The expectation
156d0e290e969c Naveen N. Rao    2016-06-22  404  		 * is that those instructions will have src_reg/dst_reg set to
156d0e290e969c Naveen N. Rao    2016-06-22  405  		 * 0. Even otherwise, we just lose some prologue/epilogue
156d0e290e969c Naveen N. Rao    2016-06-22  406  		 * optimization but everything else should work without
156d0e290e969c Naveen N. Rao    2016-06-22  407  		 * any issues.
156d0e290e969c Naveen N. Rao    2016-06-22  408  		 */
7b847f523fe07b Naveen N. Rao    2016-09-24  409  		if (dst_reg >= BPF_PPC_NVR_MIN && dst_reg < 32)
ed573b57e77a78 Christophe Leroy 2021-03-22  410  			bpf_set_seen_register(ctx, dst_reg);
7b847f523fe07b Naveen N. Rao    2016-09-24  411  		if (src_reg >= BPF_PPC_NVR_MIN && src_reg < 32)
ed573b57e77a78 Christophe Leroy 2021-03-22  412  			bpf_set_seen_register(ctx, src_reg);
156d0e290e969c Naveen N. Rao    2016-06-22  413  
156d0e290e969c Naveen N. Rao    2016-06-22  414  		switch (code) {
156d0e290e969c Naveen N. Rao    2016-06-22  415  		/*
156d0e290e969c Naveen N. Rao    2016-06-22  416  		 * Arithmetic operations: ADD/SUB/MUL/DIV/MOD/NEG
156d0e290e969c Naveen N. Rao    2016-06-22  417  		 */
156d0e290e969c Naveen N. Rao    2016-06-22  418  		case BPF_ALU | BPF_ADD | BPF_X: /* (u32) dst += (u32) src */
156d0e290e969c Naveen N. Rao    2016-06-22  419  		case BPF_ALU64 | BPF_ADD | BPF_X: /* dst += src */
0654186510a40e Balamuruhan S    2020-06-24  420  			EMIT(PPC_RAW_ADD(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  421  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  422  		case BPF_ALU | BPF_SUB | BPF_X: /* (u32) dst -= (u32) src */
156d0e290e969c Naveen N. Rao    2016-06-22  423  		case BPF_ALU64 | BPF_SUB | BPF_X: /* dst -= src */
3a181237916310 Balamuruhan S    2020-06-24  424  			EMIT(PPC_RAW_SUB(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  425  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  426  		case BPF_ALU | BPF_ADD | BPF_K: /* (u32) dst += (u32) imm */
156d0e290e969c Naveen N. Rao    2016-06-22  427  		case BPF_ALU64 | BPF_ADD | BPF_K: /* dst += imm */
5855c4c1f415ca Naveen N. Rao    2021-10-06  428  			if (!imm) {
5855c4c1f415ca Naveen N. Rao    2021-10-06  429  				goto bpf_alu32_trunc;
5855c4c1f415ca Naveen N. Rao    2021-10-06  430  			} else if (imm >= -32768 && imm < 32768) {
3a181237916310 Balamuruhan S    2020-06-24  431  				EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(imm)));
5855c4c1f415ca Naveen N. Rao    2021-10-06  432  			} else {
3a3fc9bf103974 Jordan Niethe    2022-02-14  433  				PPC_LI32(tmp1_reg, imm);
3a3fc9bf103974 Jordan Niethe    2022-02-14  434  				EMIT(PPC_RAW_ADD(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  435  			}
5855c4c1f415ca Naveen N. Rao    2021-10-06  436  			goto bpf_alu32_trunc;
5855c4c1f415ca Naveen N. Rao    2021-10-06  437  		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
5855c4c1f415ca Naveen N. Rao    2021-10-06  438  		case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -= imm */
5855c4c1f415ca Naveen N. Rao    2021-10-06  439  			if (!imm) {
5855c4c1f415ca Naveen N. Rao    2021-10-06  440  				goto bpf_alu32_trunc;
5855c4c1f415ca Naveen N. Rao    2021-10-06  441  			} else if (imm > -32768 && imm <= 32768) {
5855c4c1f415ca Naveen N. Rao    2021-10-06  442  				EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(-imm)));
5855c4c1f415ca Naveen N. Rao    2021-10-06  443  			} else {
3a3fc9bf103974 Jordan Niethe    2022-02-14  444  				PPC_LI32(tmp1_reg, imm);
3a3fc9bf103974 Jordan Niethe    2022-02-14  445  				EMIT(PPC_RAW_SUB(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  446  			}
156d0e290e969c Naveen N. Rao    2016-06-22  447  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  448  		case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
156d0e290e969c Naveen N. Rao    2016-06-22  449  		case BPF_ALU64 | BPF_MUL | BPF_X: /* dst *= src */
156d0e290e969c Naveen N. Rao    2016-06-22  450  			if (BPF_CLASS(code) == BPF_ALU)
3a181237916310 Balamuruhan S    2020-06-24  451  				EMIT(PPC_RAW_MULW(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  452  			else
3a181237916310 Balamuruhan S    2020-06-24  453  				EMIT(PPC_RAW_MULD(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  454  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  455  		case BPF_ALU | BPF_MUL | BPF_K: /* (u32) dst *= (u32) imm */
156d0e290e969c Naveen N. Rao    2016-06-22  456  		case BPF_ALU64 | BPF_MUL | BPF_K: /* dst *= imm */
156d0e290e969c Naveen N. Rao    2016-06-22  457  			if (imm >= -32768 && imm < 32768)
3a181237916310 Balamuruhan S    2020-06-24  458  				EMIT(PPC_RAW_MULI(dst_reg, dst_reg, IMM_L(imm)));
156d0e290e969c Naveen N. Rao    2016-06-22  459  			else {
3a3fc9bf103974 Jordan Niethe    2022-02-14  460  				PPC_LI32(tmp1_reg, imm);
156d0e290e969c Naveen N. Rao    2016-06-22  461  				if (BPF_CLASS(code) == BPF_ALU)
3a3fc9bf103974 Jordan Niethe    2022-02-14  462  					EMIT(PPC_RAW_MULW(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  463  				else
3a3fc9bf103974 Jordan Niethe    2022-02-14  464  					EMIT(PPC_RAW_MULD(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  465  			}
156d0e290e969c Naveen N. Rao    2016-06-22  466  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  467  		case BPF_ALU | BPF_DIV | BPF_X: /* (u32) dst /= (u32) src */
156d0e290e969c Naveen N. Rao    2016-06-22  468  		case BPF_ALU | BPF_MOD | BPF_X: /* (u32) dst %= (u32) src */
156d0e290e969c Naveen N. Rao    2016-06-22  469  			if (BPF_OP(code) == BPF_MOD) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  470  				EMIT(PPC_RAW_DIVWU(tmp1_reg, dst_reg, src_reg));
3a3fc9bf103974 Jordan Niethe    2022-02-14  471  				EMIT(PPC_RAW_MULW(tmp1_reg, src_reg, tmp1_reg));
3a3fc9bf103974 Jordan Niethe    2022-02-14  472  				EMIT(PPC_RAW_SUB(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  473  			} else
3a181237916310 Balamuruhan S    2020-06-24  474  				EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  475  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  476  		case BPF_ALU64 | BPF_DIV | BPF_X: /* dst /= src */
156d0e290e969c Naveen N. Rao    2016-06-22  477  		case BPF_ALU64 | BPF_MOD | BPF_X: /* dst %= src */
156d0e290e969c Naveen N. Rao    2016-06-22  478  			if (BPF_OP(code) == BPF_MOD) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  479  				EMIT(PPC_RAW_DIVDU(tmp1_reg, dst_reg, src_reg));
3a3fc9bf103974 Jordan Niethe    2022-02-14  480  				EMIT(PPC_RAW_MULD(tmp1_reg, src_reg, tmp1_reg));
3a3fc9bf103974 Jordan Niethe    2022-02-14  481  				EMIT(PPC_RAW_SUB(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  482  			} else
3a181237916310 Balamuruhan S    2020-06-24  483  				EMIT(PPC_RAW_DIVDU(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  484  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  485  		case BPF_ALU | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
156d0e290e969c Naveen N. Rao    2016-06-22  486  		case BPF_ALU | BPF_DIV | BPF_K: /* (u32) dst /= (u32) imm */
156d0e290e969c Naveen N. Rao    2016-06-22  487  		case BPF_ALU64 | BPF_MOD | BPF_K: /* dst %= imm */
156d0e290e969c Naveen N. Rao    2016-06-22  488  		case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
156d0e290e969c Naveen N. Rao    2016-06-22  489  			if (imm == 0)
156d0e290e969c Naveen N. Rao    2016-06-22  490  				return -EINVAL;
8bbc9d822421d9 Naveen N. Rao    2021-10-06  491  			if (imm == 1) {
8bbc9d822421d9 Naveen N. Rao    2021-10-06  492  				if (BPF_OP(code) == BPF_DIV) {
156d0e290e969c Naveen N. Rao    2016-06-22  493  					goto bpf_alu32_trunc;
8bbc9d822421d9 Naveen N. Rao    2021-10-06  494  				} else {
8bbc9d822421d9 Naveen N. Rao    2021-10-06  495  					EMIT(PPC_RAW_LI(dst_reg, 0));
8bbc9d822421d9 Naveen N. Rao    2021-10-06  496  					break;
8bbc9d822421d9 Naveen N. Rao    2021-10-06  497  				}
8bbc9d822421d9 Naveen N. Rao    2021-10-06  498  			}
156d0e290e969c Naveen N. Rao    2016-06-22  499  
3a3fc9bf103974 Jordan Niethe    2022-02-14  500  			PPC_LI32(tmp1_reg, imm);
156d0e290e969c Naveen N. Rao    2016-06-22  501  			switch (BPF_CLASS(code)) {
156d0e290e969c Naveen N. Rao    2016-06-22  502  			case BPF_ALU:
156d0e290e969c Naveen N. Rao    2016-06-22  503  				if (BPF_OP(code) == BPF_MOD) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  504  					EMIT(PPC_RAW_DIVWU(tmp2_reg, dst_reg, tmp1_reg));
3a3fc9bf103974 Jordan Niethe    2022-02-14  505  					EMIT(PPC_RAW_MULW(tmp1_reg, tmp1_reg, tmp2_reg));
3a3fc9bf103974 Jordan Niethe    2022-02-14  506  					EMIT(PPC_RAW_SUB(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  507  				} else
3a3fc9bf103974 Jordan Niethe    2022-02-14  508  					EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  509  				break;
156d0e290e969c Naveen N. Rao    2016-06-22  510  			case BPF_ALU64:
156d0e290e969c Naveen N. Rao    2016-06-22  511  				if (BPF_OP(code) == BPF_MOD) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  512  					EMIT(PPC_RAW_DIVDU(tmp2_reg, dst_reg, tmp1_reg));
3a3fc9bf103974 Jordan Niethe    2022-02-14  513  					EMIT(PPC_RAW_MULD(tmp1_reg, tmp1_reg, tmp2_reg));
3a3fc9bf103974 Jordan Niethe    2022-02-14  514  					EMIT(PPC_RAW_SUB(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  515  				} else
3a3fc9bf103974 Jordan Niethe    2022-02-14  516  					EMIT(PPC_RAW_DIVDU(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  517  				break;
156d0e290e969c Naveen N. Rao    2016-06-22  518  			}
156d0e290e969c Naveen N. Rao    2016-06-22  519  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  520  		case BPF_ALU | BPF_NEG: /* (u32) dst = -dst */
156d0e290e969c Naveen N. Rao    2016-06-22  521  		case BPF_ALU64 | BPF_NEG: /* dst = -dst */
3a181237916310 Balamuruhan S    2020-06-24  522  			EMIT(PPC_RAW_NEG(dst_reg, dst_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  523  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  524  
156d0e290e969c Naveen N. Rao    2016-06-22  525  		/*
156d0e290e969c Naveen N. Rao    2016-06-22  526  		 * Logical operations: AND/OR/XOR/[A]LSH/[A]RSH
156d0e290e969c Naveen N. Rao    2016-06-22  527  		 */
156d0e290e969c Naveen N. Rao    2016-06-22  528  		case BPF_ALU | BPF_AND | BPF_X: /* (u32) dst = dst & src */
156d0e290e969c Naveen N. Rao    2016-06-22  529  		case BPF_ALU64 | BPF_AND | BPF_X: /* dst = dst & src */
3a181237916310 Balamuruhan S    2020-06-24  530  			EMIT(PPC_RAW_AND(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  531  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  532  		case BPF_ALU | BPF_AND | BPF_K: /* (u32) dst = dst & imm */
156d0e290e969c Naveen N. Rao    2016-06-22  533  		case BPF_ALU64 | BPF_AND | BPF_K: /* dst = dst & imm */
156d0e290e969c Naveen N. Rao    2016-06-22  534  			if (!IMM_H(imm))
3a181237916310 Balamuruhan S    2020-06-24  535  				EMIT(PPC_RAW_ANDI(dst_reg, dst_reg, IMM_L(imm)));
156d0e290e969c Naveen N. Rao    2016-06-22  536  			else {
156d0e290e969c Naveen N. Rao    2016-06-22  537  				/* Sign-extended */
3a3fc9bf103974 Jordan Niethe    2022-02-14  538  				PPC_LI32(tmp1_reg, imm);
3a3fc9bf103974 Jordan Niethe    2022-02-14  539  				EMIT(PPC_RAW_AND(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  540  			}
156d0e290e969c Naveen N. Rao    2016-06-22  541  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  542  		case BPF_ALU | BPF_OR | BPF_X: /* dst = (u32) dst | (u32) src */
156d0e290e969c Naveen N. Rao    2016-06-22  543  		case BPF_ALU64 | BPF_OR | BPF_X: /* dst = dst | src */
3a181237916310 Balamuruhan S    2020-06-24  544  			EMIT(PPC_RAW_OR(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  545  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  546  		case BPF_ALU | BPF_OR | BPF_K:/* dst = (u32) dst | (u32) imm */
156d0e290e969c Naveen N. Rao    2016-06-22  547  		case BPF_ALU64 | BPF_OR | BPF_K:/* dst = dst | imm */
156d0e290e969c Naveen N. Rao    2016-06-22  548  			if (imm < 0 && BPF_CLASS(code) == BPF_ALU64) {
156d0e290e969c Naveen N. Rao    2016-06-22  549  				/* Sign-extended */
3a3fc9bf103974 Jordan Niethe    2022-02-14  550  				PPC_LI32(tmp1_reg, imm);
3a3fc9bf103974 Jordan Niethe    2022-02-14  551  				EMIT(PPC_RAW_OR(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  552  			} else {
156d0e290e969c Naveen N. Rao    2016-06-22  553  				if (IMM_L(imm))
3a181237916310 Balamuruhan S    2020-06-24  554  					EMIT(PPC_RAW_ORI(dst_reg, dst_reg, IMM_L(imm)));
156d0e290e969c Naveen N. Rao    2016-06-22  555  				if (IMM_H(imm))
3a181237916310 Balamuruhan S    2020-06-24  556  					EMIT(PPC_RAW_ORIS(dst_reg, dst_reg, IMM_H(imm)));
156d0e290e969c Naveen N. Rao    2016-06-22  557  			}
156d0e290e969c Naveen N. Rao    2016-06-22  558  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  559  		case BPF_ALU | BPF_XOR | BPF_X: /* (u32) dst ^= src */
156d0e290e969c Naveen N. Rao    2016-06-22  560  		case BPF_ALU64 | BPF_XOR | BPF_X: /* dst ^= src */
3a181237916310 Balamuruhan S    2020-06-24  561  			EMIT(PPC_RAW_XOR(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  562  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  563  		case BPF_ALU | BPF_XOR | BPF_K: /* (u32) dst ^= (u32) imm */
156d0e290e969c Naveen N. Rao    2016-06-22  564  		case BPF_ALU64 | BPF_XOR | BPF_K: /* dst ^= imm */
156d0e290e969c Naveen N. Rao    2016-06-22  565  			if (imm < 0 && BPF_CLASS(code) == BPF_ALU64) {
156d0e290e969c Naveen N. Rao    2016-06-22  566  				/* Sign-extended */
3a3fc9bf103974 Jordan Niethe    2022-02-14  567  				PPC_LI32(tmp1_reg, imm);
3a3fc9bf103974 Jordan Niethe    2022-02-14  568  				EMIT(PPC_RAW_XOR(dst_reg, dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  569  			} else {
156d0e290e969c Naveen N. Rao    2016-06-22  570  				if (IMM_L(imm))
3a181237916310 Balamuruhan S    2020-06-24  571  					EMIT(PPC_RAW_XORI(dst_reg, dst_reg, IMM_L(imm)));
156d0e290e969c Naveen N. Rao    2016-06-22  572  				if (IMM_H(imm))
3a181237916310 Balamuruhan S    2020-06-24  573  					EMIT(PPC_RAW_XORIS(dst_reg, dst_reg, IMM_H(imm)));
156d0e290e969c Naveen N. Rao    2016-06-22  574  			}
156d0e290e969c Naveen N. Rao    2016-06-22  575  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  576  		case BPF_ALU | BPF_LSH | BPF_X: /* (u32) dst <<= (u32) src */
156d0e290e969c Naveen N. Rao    2016-06-22  577  			/* slw clears top 32 bits */
3a181237916310 Balamuruhan S    2020-06-24  578  			EMIT(PPC_RAW_SLW(dst_reg, dst_reg, src_reg));
a4c927733e74bb Jiong Wang       2019-05-24  579  			/* skip zero extension move, but set address map. */
a4c927733e74bb Jiong Wang       2019-05-24  580  			if (insn_is_zext(&insn[i + 1]))
a4c927733e74bb Jiong Wang       2019-05-24  581  				addrs[++i] = ctx->idx * 4;
156d0e290e969c Naveen N. Rao    2016-06-22  582  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  583  		case BPF_ALU64 | BPF_LSH | BPF_X: /* dst <<= src; */
3a181237916310 Balamuruhan S    2020-06-24  584  			EMIT(PPC_RAW_SLD(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  585  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  586  		case BPF_ALU | BPF_LSH | BPF_K: /* (u32) dst <<== (u32) imm */
156d0e290e969c Naveen N. Rao    2016-06-22  587  			/* with imm 0, we still need to clear top 32 bits */
3a181237916310 Balamuruhan S    2020-06-24  588  			EMIT(PPC_RAW_SLWI(dst_reg, dst_reg, imm));
a4c927733e74bb Jiong Wang       2019-05-24  589  			if (insn_is_zext(&insn[i + 1]))
a4c927733e74bb Jiong Wang       2019-05-24  590  				addrs[++i] = ctx->idx * 4;
156d0e290e969c Naveen N. Rao    2016-06-22  591  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  592  		case BPF_ALU64 | BPF_LSH | BPF_K: /* dst <<== imm */
156d0e290e969c Naveen N. Rao    2016-06-22  593  			if (imm != 0)
3a181237916310 Balamuruhan S    2020-06-24  594  				EMIT(PPC_RAW_SLDI(dst_reg, dst_reg, imm));
156d0e290e969c Naveen N. Rao    2016-06-22  595  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  596  		case BPF_ALU | BPF_RSH | BPF_X: /* (u32) dst >>= (u32) src */
3a181237916310 Balamuruhan S    2020-06-24  597  			EMIT(PPC_RAW_SRW(dst_reg, dst_reg, src_reg));
a4c927733e74bb Jiong Wang       2019-05-24  598  			if (insn_is_zext(&insn[i + 1]))
a4c927733e74bb Jiong Wang       2019-05-24  599  				addrs[++i] = ctx->idx * 4;
156d0e290e969c Naveen N. Rao    2016-06-22  600  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  601  		case BPF_ALU64 | BPF_RSH | BPF_X: /* dst >>= src */
3a181237916310 Balamuruhan S    2020-06-24  602  			EMIT(PPC_RAW_SRD(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  603  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  604  		case BPF_ALU | BPF_RSH | BPF_K: /* (u32) dst >>= (u32) imm */
3a181237916310 Balamuruhan S    2020-06-24  605  			EMIT(PPC_RAW_SRWI(dst_reg, dst_reg, imm));
a4c927733e74bb Jiong Wang       2019-05-24  606  			if (insn_is_zext(&insn[i + 1]))
a4c927733e74bb Jiong Wang       2019-05-24  607  				addrs[++i] = ctx->idx * 4;
156d0e290e969c Naveen N. Rao    2016-06-22  608  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  609  		case BPF_ALU64 | BPF_RSH | BPF_K: /* dst >>= imm */
156d0e290e969c Naveen N. Rao    2016-06-22  610  			if (imm != 0)
3a181237916310 Balamuruhan S    2020-06-24  611  				EMIT(PPC_RAW_SRDI(dst_reg, dst_reg, imm));
156d0e290e969c Naveen N. Rao    2016-06-22  612  			break;
44cf43c04bb5f7 Jiong Wang       2018-12-05  613  		case BPF_ALU | BPF_ARSH | BPF_X: /* (s32) dst >>= src */
3a181237916310 Balamuruhan S    2020-06-24  614  			EMIT(PPC_RAW_SRAW(dst_reg, dst_reg, src_reg));
44cf43c04bb5f7 Jiong Wang       2018-12-05  615  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  616  		case BPF_ALU64 | BPF_ARSH | BPF_X: /* (s64) dst >>= src */
3a181237916310 Balamuruhan S    2020-06-24  617  			EMIT(PPC_RAW_SRAD(dst_reg, dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  618  			break;
44cf43c04bb5f7 Jiong Wang       2018-12-05  619  		case BPF_ALU | BPF_ARSH | BPF_K: /* (s32) dst >>= imm */
3a181237916310 Balamuruhan S    2020-06-24  620  			EMIT(PPC_RAW_SRAWI(dst_reg, dst_reg, imm));
44cf43c04bb5f7 Jiong Wang       2018-12-05  621  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  622  		case BPF_ALU64 | BPF_ARSH | BPF_K: /* (s64) dst >>= imm */
156d0e290e969c Naveen N. Rao    2016-06-22  623  			if (imm != 0)
3a181237916310 Balamuruhan S    2020-06-24  624  				EMIT(PPC_RAW_SRADI(dst_reg, dst_reg, imm));
156d0e290e969c Naveen N. Rao    2016-06-22  625  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  626  
156d0e290e969c Naveen N. Rao    2016-06-22  627  		/*
156d0e290e969c Naveen N. Rao    2016-06-22  628  		 * MOV
156d0e290e969c Naveen N. Rao    2016-06-22  629  		 */
156d0e290e969c Naveen N. Rao    2016-06-22  630  		case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
156d0e290e969c Naveen N. Rao    2016-06-22  631  		case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
a4c927733e74bb Jiong Wang       2019-05-24  632  			if (imm == 1) {
a4c927733e74bb Jiong Wang       2019-05-24  633  				/* special mov32 for zext */
3a181237916310 Balamuruhan S    2020-06-24  634  				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
a4c927733e74bb Jiong Wang       2019-05-24  635  				break;
a4c927733e74bb Jiong Wang       2019-05-24  636  			}
3a181237916310 Balamuruhan S    2020-06-24  637  			EMIT(PPC_RAW_MR(dst_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  638  			goto bpf_alu32_trunc;
156d0e290e969c Naveen N. Rao    2016-06-22  639  		case BPF_ALU | BPF_MOV | BPF_K: /* (u32) dst = imm */
156d0e290e969c Naveen N. Rao    2016-06-22  640  		case BPF_ALU64 | BPF_MOV | BPF_K: /* dst = (s64) imm */
156d0e290e969c Naveen N. Rao    2016-06-22  641  			PPC_LI32(dst_reg, imm);
156d0e290e969c Naveen N. Rao    2016-06-22  642  			if (imm < 0)
156d0e290e969c Naveen N. Rao    2016-06-22  643  				goto bpf_alu32_trunc;
a4c927733e74bb Jiong Wang       2019-05-24  644  			else if (insn_is_zext(&insn[i + 1]))
a4c927733e74bb Jiong Wang       2019-05-24  645  				addrs[++i] = ctx->idx * 4;
156d0e290e969c Naveen N. Rao    2016-06-22  646  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  647  
156d0e290e969c Naveen N. Rao    2016-06-22  648  bpf_alu32_trunc:
156d0e290e969c Naveen N. Rao    2016-06-22  649  		/* Truncate to 32-bits */
a4c927733e74bb Jiong Wang       2019-05-24  650  		if (BPF_CLASS(code) == BPF_ALU && !fp->aux->verifier_zext)
3a181237916310 Balamuruhan S    2020-06-24  651  			EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
156d0e290e969c Naveen N. Rao    2016-06-22  652  		break;
156d0e290e969c Naveen N. Rao    2016-06-22  653  
156d0e290e969c Naveen N. Rao    2016-06-22  654  		/*
156d0e290e969c Naveen N. Rao    2016-06-22  655  		 * BPF_FROM_BE/LE
156d0e290e969c Naveen N. Rao    2016-06-22  656  		 */
156d0e290e969c Naveen N. Rao    2016-06-22  657  		case BPF_ALU | BPF_END | BPF_FROM_LE:
156d0e290e969c Naveen N. Rao    2016-06-22  658  		case BPF_ALU | BPF_END | BPF_FROM_BE:
156d0e290e969c Naveen N. Rao    2016-06-22  659  #ifdef __BIG_ENDIAN__
156d0e290e969c Naveen N. Rao    2016-06-22  660  			if (BPF_SRC(code) == BPF_FROM_BE)
156d0e290e969c Naveen N. Rao    2016-06-22  661  				goto emit_clear;
156d0e290e969c Naveen N. Rao    2016-06-22  662  #else /* !__BIG_ENDIAN__ */
156d0e290e969c Naveen N. Rao    2016-06-22  663  			if (BPF_SRC(code) == BPF_FROM_LE)
156d0e290e969c Naveen N. Rao    2016-06-22  664  				goto emit_clear;
156d0e290e969c Naveen N. Rao    2016-06-22  665  #endif
156d0e290e969c Naveen N. Rao    2016-06-22  666  			switch (imm) {
156d0e290e969c Naveen N. Rao    2016-06-22  667  			case 16:
156d0e290e969c Naveen N. Rao    2016-06-22  668  				/* Rotate 8 bits left & mask with 0x0000ff00 */
3a3fc9bf103974 Jordan Niethe    2022-02-14  669  				EMIT(PPC_RAW_RLWINM(tmp1_reg, dst_reg, 8, 16, 23));
156d0e290e969c Naveen N. Rao    2016-06-22  670  				/* Rotate 8 bits right & insert LSB to reg */
3a3fc9bf103974 Jordan Niethe    2022-02-14  671  				EMIT(PPC_RAW_RLWIMI(tmp1_reg, dst_reg, 24, 24, 31));
156d0e290e969c Naveen N. Rao    2016-06-22  672  				/* Move result back to dst_reg */
3a3fc9bf103974 Jordan Niethe    2022-02-14  673  				EMIT(PPC_RAW_MR(dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  674  				break;
156d0e290e969c Naveen N. Rao    2016-06-22  675  			case 32:
156d0e290e969c Naveen N. Rao    2016-06-22  676  				/*
156d0e290e969c Naveen N. Rao    2016-06-22  677  				 * Rotate word left by 8 bits:
156d0e290e969c Naveen N. Rao    2016-06-22  678  				 * 2 bytes are already in their final position
156d0e290e969c Naveen N. Rao    2016-06-22  679  				 * -- byte 2 and 4 (of bytes 1, 2, 3 and 4)
156d0e290e969c Naveen N. Rao    2016-06-22  680  				 */
3a3fc9bf103974 Jordan Niethe    2022-02-14  681  				EMIT(PPC_RAW_RLWINM(tmp1_reg, dst_reg, 8, 0, 31));
156d0e290e969c Naveen N. Rao    2016-06-22  682  				/* Rotate 24 bits and insert byte 1 */
3a3fc9bf103974 Jordan Niethe    2022-02-14  683  				EMIT(PPC_RAW_RLWIMI(tmp1_reg, dst_reg, 24, 0, 7));
156d0e290e969c Naveen N. Rao    2016-06-22  684  				/* Rotate 24 bits and insert byte 3 */
3a3fc9bf103974 Jordan Niethe    2022-02-14  685  				EMIT(PPC_RAW_RLWIMI(tmp1_reg, dst_reg, 24, 16, 23));
3a3fc9bf103974 Jordan Niethe    2022-02-14  686  				EMIT(PPC_RAW_MR(dst_reg, tmp1_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  687  				break;
156d0e290e969c Naveen N. Rao    2016-06-22  688  			case 64:
3f5f766d5f7f95 Naveen N. Rao    2022-01-06  689  				/* Store the value to stack and then use byte-reverse loads */
036d559c0bdea7 Naveen N. Rao    2022-02-14  690  				EMIT(PPC_RAW_STD(dst_reg, _R1, bpf_jit_stack_local(ctx)));
3a3fc9bf103974 Jordan Niethe    2022-02-14  691  				EMIT(PPC_RAW_ADDI(tmp1_reg, _R1, bpf_jit_stack_local(ctx)));
3f5f766d5f7f95 Naveen N. Rao    2022-01-06  692  				if (cpu_has_feature(CPU_FTR_ARCH_206)) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  693  					EMIT(PPC_RAW_LDBRX(dst_reg, 0, tmp1_reg));
3f5f766d5f7f95 Naveen N. Rao    2022-01-06  694  				} else {
3a3fc9bf103974 Jordan Niethe    2022-02-14  695  					EMIT(PPC_RAW_LWBRX(dst_reg, 0, tmp1_reg));
3f5f766d5f7f95 Naveen N. Rao    2022-01-06  696  					if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
3f5f766d5f7f95 Naveen N. Rao    2022-01-06  697  						EMIT(PPC_RAW_SLDI(dst_reg, dst_reg, 32));
3a3fc9bf103974 Jordan Niethe    2022-02-14  698  					EMIT(PPC_RAW_LI(tmp2_reg, 4));
3a3fc9bf103974 Jordan Niethe    2022-02-14  699  					EMIT(PPC_RAW_LWBRX(tmp2_reg, tmp2_reg, tmp1_reg));
3f5f766d5f7f95 Naveen N. Rao    2022-01-06  700  					if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
3a3fc9bf103974 Jordan Niethe    2022-02-14  701  						EMIT(PPC_RAW_SLDI(tmp2_reg, tmp2_reg, 32));
3a3fc9bf103974 Jordan Niethe    2022-02-14  702  					EMIT(PPC_RAW_OR(dst_reg, dst_reg, tmp2_reg));
3f5f766d5f7f95 Naveen N. Rao    2022-01-06  703  				}
156d0e290e969c Naveen N. Rao    2016-06-22  704  				break;
156d0e290e969c Naveen N. Rao    2016-06-22  705  			}
156d0e290e969c Naveen N. Rao    2016-06-22  706  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  707  
156d0e290e969c Naveen N. Rao    2016-06-22  708  emit_clear:
156d0e290e969c Naveen N. Rao    2016-06-22  709  			switch (imm) {
156d0e290e969c Naveen N. Rao    2016-06-22  710  			case 16:
156d0e290e969c Naveen N. Rao    2016-06-22  711  				/* zero-extend 16 bits into 64 bits */
3a181237916310 Balamuruhan S    2020-06-24  712  				EMIT(PPC_RAW_RLDICL(dst_reg, dst_reg, 0, 48));
a4c927733e74bb Jiong Wang       2019-05-24  713  				if (insn_is_zext(&insn[i + 1]))
a4c927733e74bb Jiong Wang       2019-05-24  714  					addrs[++i] = ctx->idx * 4;
156d0e290e969c Naveen N. Rao    2016-06-22  715  				break;
156d0e290e969c Naveen N. Rao    2016-06-22  716  			case 32:
a4c927733e74bb Jiong Wang       2019-05-24  717  				if (!fp->aux->verifier_zext)
156d0e290e969c Naveen N. Rao    2016-06-22  718  					/* zero-extend 32 bits into 64 bits */
3a181237916310 Balamuruhan S    2020-06-24  719  					EMIT(PPC_RAW_RLDICL(dst_reg, dst_reg, 0, 32));
156d0e290e969c Naveen N. Rao    2016-06-22  720  				break;
156d0e290e969c Naveen N. Rao    2016-06-22  721  			case 64:
156d0e290e969c Naveen N. Rao    2016-06-22  722  				/* nop */
156d0e290e969c Naveen N. Rao    2016-06-22  723  				break;
156d0e290e969c Naveen N. Rao    2016-06-22  724  			}
156d0e290e969c Naveen N. Rao    2016-06-22  725  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  726  
f5e81d11175015 Daniel Borkmann  2021-07-13  727  		/*
f5e81d11175015 Daniel Borkmann  2021-07-13  728  		 * BPF_ST NOSPEC (speculation barrier)
f5e81d11175015 Daniel Borkmann  2021-07-13  729  		 */
f5e81d11175015 Daniel Borkmann  2021-07-13  730  		case BPF_ST | BPF_NOSPEC:
b7540d62509453 Naveen N. Rao    2021-10-06  731  			if (!security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) ||
b7540d62509453 Naveen N. Rao    2021-10-06  732  					!security_ftr_enabled(SEC_FTR_STF_BARRIER))
b7540d62509453 Naveen N. Rao    2021-10-06  733  				break;
b7540d62509453 Naveen N. Rao    2021-10-06  734  
b7540d62509453 Naveen N. Rao    2021-10-06  735  			switch (stf_barrier) {
b7540d62509453 Naveen N. Rao    2021-10-06  736  			case STF_BARRIER_EIEIO:
b7540d62509453 Naveen N. Rao    2021-10-06  737  				EMIT(PPC_RAW_EIEIO() | 0x02000000);
b7540d62509453 Naveen N. Rao    2021-10-06  738  				break;
b7540d62509453 Naveen N. Rao    2021-10-06  739  			case STF_BARRIER_SYNC_ORI:
b7540d62509453 Naveen N. Rao    2021-10-06  740  				EMIT(PPC_RAW_SYNC());
3a3fc9bf103974 Jordan Niethe    2022-02-14  741  				EMIT(PPC_RAW_LD(tmp1_reg, _R13, 0));
b7540d62509453 Naveen N. Rao    2021-10-06  742  				EMIT(PPC_RAW_ORI(_R31, _R31, 0));
b7540d62509453 Naveen N. Rao    2021-10-06  743  				break;
b7540d62509453 Naveen N. Rao    2021-10-06  744  			case STF_BARRIER_FALLBACK:
c2067f7f88830c Naveen N. Rao    2022-02-14  745  				ctx->seen |= SEEN_FUNC;
036d559c0bdea7 Naveen N. Rao    2022-02-14  746  				PPC_LI64(_R12, dereference_kernel_function_descriptor(bpf_stf_barrier));
036d559c0bdea7 Naveen N. Rao    2022-02-14  747  				EMIT(PPC_RAW_MTCTR(_R12));
b7540d62509453 Naveen N. Rao    2021-10-06  748  				EMIT(PPC_RAW_BCTRL());
b7540d62509453 Naveen N. Rao    2021-10-06  749  				break;
b7540d62509453 Naveen N. Rao    2021-10-06  750  			case STF_BARRIER_NONE:
b7540d62509453 Naveen N. Rao    2021-10-06  751  				break;
b7540d62509453 Naveen N. Rao    2021-10-06  752  			}
f5e81d11175015 Daniel Borkmann  2021-07-13  753  			break;
f5e81d11175015 Daniel Borkmann  2021-07-13  754  
156d0e290e969c Naveen N. Rao    2016-06-22  755  		/*
156d0e290e969c Naveen N. Rao    2016-06-22  756  		 * BPF_ST(X)
156d0e290e969c Naveen N. Rao    2016-06-22  757  		 */
156d0e290e969c Naveen N. Rao    2016-06-22  758  		case BPF_STX | BPF_MEM | BPF_B: /* *(u8 *)(dst + off) = src */
156d0e290e969c Naveen N. Rao    2016-06-22  759  		case BPF_ST | BPF_MEM | BPF_B: /* *(u8 *)(dst + off) = imm */
156d0e290e969c Naveen N. Rao    2016-06-22  760  			if (BPF_CLASS(code) == BPF_ST) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  761  				EMIT(PPC_RAW_LI(tmp1_reg, imm));
3a3fc9bf103974 Jordan Niethe    2022-02-14  762  				src_reg = tmp1_reg;
156d0e290e969c Naveen N. Rao    2016-06-22  763  			}
3a181237916310 Balamuruhan S    2020-06-24  764  			EMIT(PPC_RAW_STB(src_reg, dst_reg, off));
156d0e290e969c Naveen N. Rao    2016-06-22  765  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  766  		case BPF_STX | BPF_MEM | BPF_H: /* (u16 *)(dst + off) = src */
156d0e290e969c Naveen N. Rao    2016-06-22  767  		case BPF_ST | BPF_MEM | BPF_H: /* (u16 *)(dst + off) = imm */
156d0e290e969c Naveen N. Rao    2016-06-22  768  			if (BPF_CLASS(code) == BPF_ST) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  769  				EMIT(PPC_RAW_LI(tmp1_reg, imm));
3a3fc9bf103974 Jordan Niethe    2022-02-14  770  				src_reg = tmp1_reg;
156d0e290e969c Naveen N. Rao    2016-06-22  771  			}
3a181237916310 Balamuruhan S    2020-06-24  772  			EMIT(PPC_RAW_STH(src_reg, dst_reg, off));
156d0e290e969c Naveen N. Rao    2016-06-22  773  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  774  		case BPF_STX | BPF_MEM | BPF_W: /* *(u32 *)(dst + off) = src */
156d0e290e969c Naveen N. Rao    2016-06-22  775  		case BPF_ST | BPF_MEM | BPF_W: /* *(u32 *)(dst + off) = imm */
156d0e290e969c Naveen N. Rao    2016-06-22  776  			if (BPF_CLASS(code) == BPF_ST) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  777  				PPC_LI32(tmp1_reg, imm);
3a3fc9bf103974 Jordan Niethe    2022-02-14  778  				src_reg = tmp1_reg;
156d0e290e969c Naveen N. Rao    2016-06-22  779  			}
3a181237916310 Balamuruhan S    2020-06-24  780  			EMIT(PPC_RAW_STW(src_reg, dst_reg, off));
156d0e290e969c Naveen N. Rao    2016-06-22  781  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  782  		case BPF_STX | BPF_MEM | BPF_DW: /* (u64 *)(dst + off) = src */
156d0e290e969c Naveen N. Rao    2016-06-22  783  		case BPF_ST | BPF_MEM | BPF_DW: /* *(u64 *)(dst + off) = imm */
156d0e290e969c Naveen N. Rao    2016-06-22  784  			if (BPF_CLASS(code) == BPF_ST) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  785  				PPC_LI32(tmp1_reg, imm);
3a3fc9bf103974 Jordan Niethe    2022-02-14  786  				src_reg = tmp1_reg;
156d0e290e969c Naveen N. Rao    2016-06-22  787  			}
794abc08d75e9f Naveen N. Rao    2022-02-14  788  			if (off % 4) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  789  				EMIT(PPC_RAW_LI(tmp2_reg, off));
3a3fc9bf103974 Jordan Niethe    2022-02-14  790  				EMIT(PPC_RAW_STDX(src_reg, dst_reg, tmp2_reg));
794abc08d75e9f Naveen N. Rao    2022-02-14  791  			} else {
794abc08d75e9f Naveen N. Rao    2022-02-14  792  				EMIT(PPC_RAW_STD(src_reg, dst_reg, off));
794abc08d75e9f Naveen N. Rao    2022-02-14  793  			}
156d0e290e969c Naveen N. Rao    2016-06-22  794  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  795  
156d0e290e969c Naveen N. Rao    2016-06-22  796  		/*
91c960b0056672 Brendan Jackman  2021-01-14  797  		 * BPF_STX ATOMIC (atomic ops)
156d0e290e969c Naveen N. Rao    2016-06-22  798  		 */
91c960b0056672 Brendan Jackman  2021-01-14  799  		case BPF_STX | BPF_ATOMIC | BPF_W:
65112709115f48 Hari Bathini     2022-06-10  800  		case BPF_STX | BPF_ATOMIC | BPF_DW:
1e82dfaa7819f0 Hari Bathini     2022-06-10  801  			save_reg = tmp2_reg;
1e82dfaa7819f0 Hari Bathini     2022-06-10  802  			ret_reg = src_reg;
1e82dfaa7819f0 Hari Bathini     2022-06-10  803  
65112709115f48 Hari Bathini     2022-06-10  804  			/* Get offset into TMP_REG_1 */
65112709115f48 Hari Bathini     2022-06-10  805  			EMIT(PPC_RAW_LI(tmp1_reg, off));
b9c1e60e7bf4e6 Daniel Borkmann  2018-07-19  806  			tmp_idx = ctx->idx * 4;
156d0e290e969c Naveen N. Rao    2016-06-22  807  			/* load value from memory into TMP_REG_2 */
65112709115f48 Hari Bathini     2022-06-10  808  			if (size == BPF_DW)
65112709115f48 Hari Bathini     2022-06-10  809  				EMIT(PPC_RAW_LDARX(tmp2_reg, tmp1_reg, dst_reg, 0));
65112709115f48 Hari Bathini     2022-06-10  810  			else
65112709115f48 Hari Bathini     2022-06-10  811  				EMIT(PPC_RAW_LWARX(tmp2_reg, tmp1_reg, dst_reg, 0));
65112709115f48 Hari Bathini     2022-06-10  812  
dbe6e2456fb026 Hari Bathini     2022-06-10  813  			/* Save old value in _R0 */
dbe6e2456fb026 Hari Bathini     2022-06-10  814  			if (imm & BPF_FETCH)
dbe6e2456fb026 Hari Bathini     2022-06-10  815  				EMIT(PPC_RAW_MR(_R0, tmp2_reg));
dbe6e2456fb026 Hari Bathini     2022-06-10  816  
65112709115f48 Hari Bathini     2022-06-10  817  			switch (imm) {
65112709115f48 Hari Bathini     2022-06-10  818  			case BPF_ADD:
dbe6e2456fb026 Hari Bathini     2022-06-10  819  			case BPF_ADD | BPF_FETCH:
3a3fc9bf103974 Jordan Niethe    2022-02-14  820  				EMIT(PPC_RAW_ADD(tmp2_reg, tmp2_reg, src_reg));
156d0e290e969c Naveen N. Rao    2016-06-22  821  				break;
65112709115f48 Hari Bathini     2022-06-10  822  			case BPF_AND:
dbe6e2456fb026 Hari Bathini     2022-06-10  823  			case BPF_AND | BPF_FETCH:
65112709115f48 Hari Bathini     2022-06-10  824  				EMIT(PPC_RAW_AND(tmp2_reg, tmp2_reg, src_reg));
65112709115f48 Hari Bathini     2022-06-10  825  				break;
65112709115f48 Hari Bathini     2022-06-10  826  			case BPF_OR:
dbe6e2456fb026 Hari Bathini     2022-06-10  827  			case BPF_OR | BPF_FETCH:
65112709115f48 Hari Bathini     2022-06-10  828  				EMIT(PPC_RAW_OR(tmp2_reg, tmp2_reg, src_reg));
65112709115f48 Hari Bathini     2022-06-10  829  				break;
65112709115f48 Hari Bathini     2022-06-10  830  			case BPF_XOR:
dbe6e2456fb026 Hari Bathini     2022-06-10  831  			case BPF_XOR | BPF_FETCH:
65112709115f48 Hari Bathini     2022-06-10  832  				EMIT(PPC_RAW_XOR(tmp2_reg, tmp2_reg, src_reg));
65112709115f48 Hari Bathini     2022-06-10  833  				break;
1e82dfaa7819f0 Hari Bathini     2022-06-10  834  			case BPF_CMPXCHG:
1e82dfaa7819f0 Hari Bathini     2022-06-10  835  				/*
1e82dfaa7819f0 Hari Bathini     2022-06-10  836  				 * Return old value in BPF_REG_0 for BPF_CMPXCHG &
1e82dfaa7819f0 Hari Bathini     2022-06-10  837  				 * in src_reg for other cases.
1e82dfaa7819f0 Hari Bathini     2022-06-10  838  				 */
1e82dfaa7819f0 Hari Bathini     2022-06-10  839  				ret_reg = bpf_to_ppc(BPF_REG_0);
1e82dfaa7819f0 Hari Bathini     2022-06-10  840  
1e82dfaa7819f0 Hari Bathini     2022-06-10  841  				/* Compare with old value in BPF_R0 */
1e82dfaa7819f0 Hari Bathini     2022-06-10  842  				if (size == BPF_DW)
1e82dfaa7819f0 Hari Bathini     2022-06-10  843  					EMIT(PPC_RAW_CMPD(bpf_to_ppc(BPF_REG_0), tmp2_reg));
1e82dfaa7819f0 Hari Bathini     2022-06-10  844  				else
1e82dfaa7819f0 Hari Bathini     2022-06-10  845  					EMIT(PPC_RAW_CMPW(bpf_to_ppc(BPF_REG_0), tmp2_reg));
1e82dfaa7819f0 Hari Bathini     2022-06-10  846  				/* Don't set if different from old value */
1e82dfaa7819f0 Hari Bathini     2022-06-10  847  				PPC_BCC_SHORT(COND_NE, (ctx->idx + 3) * 4);
1e82dfaa7819f0 Hari Bathini     2022-06-10  848  				fallthrough;
1e82dfaa7819f0 Hari Bathini     2022-06-10  849  			case BPF_XCHG:
1e82dfaa7819f0 Hari Bathini     2022-06-10  850  				save_reg = src_reg;
1e82dfaa7819f0 Hari Bathini     2022-06-10  851  				break;
65112709115f48 Hari Bathini     2022-06-10  852  			default:
91c960b0056672 Brendan Jackman  2021-01-14  853  				pr_err_ratelimited(
91c960b0056672 Brendan Jackman  2021-01-14  854  					"eBPF filter atomic op code %02x (@%d) unsupported\n",
91c960b0056672 Brendan Jackman  2021-01-14  855  					code, i);
65112709115f48 Hari Bathini     2022-06-10  856  				return -EOPNOTSUPP;
91c960b0056672 Brendan Jackman  2021-01-14  857  			}
91c960b0056672 Brendan Jackman  2021-01-14  858  
dbe6e2456fb026 Hari Bathini     2022-06-10  859  			/* store new value */
65112709115f48 Hari Bathini     2022-06-10  860  			if (size == BPF_DW)
1e82dfaa7819f0 Hari Bathini     2022-06-10  861  				EMIT(PPC_RAW_STDCX(save_reg, tmp1_reg, dst_reg));
65112709115f48 Hari Bathini     2022-06-10  862  			else
1e82dfaa7819f0 Hari Bathini     2022-06-10  863  				EMIT(PPC_RAW_STWCX(save_reg, tmp1_reg, dst_reg));
65112709115f48 Hari Bathini     2022-06-10  864  			/* we're done if this succeeded */
b9c1e60e7bf4e6 Daniel Borkmann  2018-07-19  865  			PPC_BCC_SHORT(COND_NE, tmp_idx);
dbe6e2456fb026 Hari Bathini     2022-06-10  866  
1e82dfaa7819f0 Hari Bathini     2022-06-10  867  			if (imm & BPF_FETCH) {
1e82dfaa7819f0 Hari Bathini     2022-06-10  868  				EMIT(PPC_RAW_MR(ret_reg, _R0));
1e82dfaa7819f0 Hari Bathini     2022-06-10  869  				/*
1e82dfaa7819f0 Hari Bathini     2022-06-10  870  				 * Skip unnecessary zero-extension for 32-bit cmpxchg.
1e82dfaa7819f0 Hari Bathini     2022-06-10  871  				 * For context, see commit 39491867ace5.
1e82dfaa7819f0 Hari Bathini     2022-06-10  872  				 */
1e82dfaa7819f0 Hari Bathini     2022-06-10  873  				if (size != BPF_DW && imm == BPF_CMPXCHG &&
1e82dfaa7819f0 Hari Bathini     2022-06-10  874  				    insn_is_zext(&insn[i + 1]))
1e82dfaa7819f0 Hari Bathini     2022-06-10  875  					addrs[++i] = ctx->idx * 4;
1e82dfaa7819f0 Hari Bathini     2022-06-10  876  			}
156d0e290e969c Naveen N. Rao    2016-06-22  877  			break;
156d0e290e969c Naveen N. Rao    2016-06-22  878  
156d0e290e969c Naveen N. Rao    2016-06-22  879  		/*
156d0e290e969c Naveen N. Rao    2016-06-22  880  		 * BPF_LDX
156d0e290e969c Naveen N. Rao    2016-06-22  881  		 */
156d0e290e969c Naveen N. Rao    2016-06-22  882  		/* dst = *(u8 *)(ul) (src + off) */
156d0e290e969c Naveen N. Rao    2016-06-22  883  		case BPF_LDX | BPF_MEM | BPF_B:
983bdc0245a29c Ravi Bangoria    2021-10-12  884  		case BPF_LDX | BPF_PROBE_MEM | BPF_B:
156d0e290e969c Naveen N. Rao    2016-06-22  885  		/* dst = *(u16 *)(ul) (src + off) */
156d0e290e969c Naveen N. Rao    2016-06-22  886  		case BPF_LDX | BPF_MEM | BPF_H:
983bdc0245a29c Ravi Bangoria    2021-10-12  887  		case BPF_LDX | BPF_PROBE_MEM | BPF_H:
156d0e290e969c Naveen N. Rao    2016-06-22  888  		/* dst = *(u32 *)(ul) (src + off) */
156d0e290e969c Naveen N. Rao    2016-06-22  889  		case BPF_LDX | BPF_MEM | BPF_W:
983bdc0245a29c Ravi Bangoria    2021-10-12  890  		case BPF_LDX | BPF_PROBE_MEM | BPF_W:
156d0e290e969c Naveen N. Rao    2016-06-22  891  		/* dst = *(u64 *)(ul) (src + off) */
156d0e290e969c Naveen N. Rao    2016-06-22  892  		case BPF_LDX | BPF_MEM | BPF_DW:
983bdc0245a29c Ravi Bangoria    2021-10-12  893  		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
9c70c7147ffec3 Ravi Bangoria    2021-10-12  894  			/*
9c70c7147ffec3 Ravi Bangoria    2021-10-12  895  			 * As PTR_TO_BTF_ID that uses BPF_PROBE_MEM mode could either be a valid
9c70c7147ffec3 Ravi Bangoria    2021-10-12  896  			 * kernel pointer or NULL but not a userspace address, execute BPF_PROBE_MEM
9c70c7147ffec3 Ravi Bangoria    2021-10-12  897  			 * load only if addr is kernel address (see is_kernel_addr()), otherwise
9c70c7147ffec3 Ravi Bangoria    2021-10-12  898  			 * set dst_reg=0 and move on.
9c70c7147ffec3 Ravi Bangoria    2021-10-12  899  			 */
9c70c7147ffec3 Ravi Bangoria    2021-10-12  900  			if (BPF_MODE(code) == BPF_PROBE_MEM) {
3a3fc9bf103974 Jordan Niethe    2022-02-14  901  				EMIT(PPC_RAW_ADDI(tmp1_reg, src_reg, off));
9c70c7147ffec3 Ravi Bangoria    2021-10-12  902  				if (IS_ENABLED(CONFIG_PPC_BOOK3E_64))
3a3fc9bf103974 Jordan Niethe    2022-02-14 @903  					PPC_LI64(tmp2_reg, 0x8000000000000000ul);
9c70c7147ffec3 Ravi Bangoria    2021-10-12  904  				else /* BOOK3S_64 */
3a3fc9bf103974 Jordan Niethe    2022-02-14 @905  					PPC_LI64(tmp2_reg, PAGE_OFFSET);

:::::: The code at line 903 was first introduced by commit
:::::: 3a3fc9bf103974d9a886fa37087d5d491c806e00 powerpc64/bpf: Store temp registers' bpf to ppc mapping

:::::: TO: Jordan Niethe <jniethe5@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

