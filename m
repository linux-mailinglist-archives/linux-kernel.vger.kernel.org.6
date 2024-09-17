Return-Path: <linux-kernel+bounces-331248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B897AA56
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C1C2863B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA51BC41;
	Tue, 17 Sep 2024 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cIgmHqcQ"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C84C66
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726538854; cv=none; b=aCqtYriDbu47dlZ/x3KdGtgQm/U+6jQZIK0T/WBlEqyO6/knoxv4jnt77d0/yJxOiBdMjGl1o1emKIjxpotAk/Pv7I8VfTAIivB5K3RyAf0c7bt/P41CwHaNB7mRZyv4bKl7YXfry81LljqV1QT3FQvrOJlJpiOZPLnKT8KKPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726538854; c=relaxed/simple;
	bh=tLXRKMgmpsO6AZfn4tf1wp2I0uiZCv0QMBZTYecHVsw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d0amJmg+WqMkBHOJhxVxNFlctNzoVOR/KKtyS5UbQ0UVrOaPJ78Abwiahj0zpP5exiX4xG5QzjuiELozWHlB/42R7JPpQ4MR/KsQABmphNofEC3vMfkSTW9GiCl6nC3MDW/Ptcnlnpd1CvaEU6mBDdaJ6mFZBvG4RAil4E2jnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=cIgmHqcQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726538849;
	bh=1xaWizmP3mrgQIfgfrus1NA1o02VIYu2gs2JVI2mD0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cIgmHqcQ3P9ODkIBXU2pGjebaemrR+7iOCYznbXFpylTzE/82KVINQOJt4VcdzvF5
	 UrXZD36xcwl5nTucvzbqMLvjGIcoHnWptzE4tzfB33jNF9hW9tUE1sy2jhEVR4q2Cq
	 zHN49Jl1hcbNeSLPqWDbP3dqZMFWYoWH+lIQyKBmQXMJbvDBiqE3XuJ76cNP6xVigG
	 tLcTh9NX5O4WE2tqT259HV7lPlUo4VDO3EfFJUESVQ5K38Y9P+UTQM7eGJapbAQmCp
	 9TIueUN6mdSKxB4WeH16gd9evTs3qu2UWRpzfYEKAVhqSqPXapADm5UG3zP1x6pwFr
	 8AdBfh5fqlgLw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X74t91Zkxz4xZf;
	Tue, 17 Sep 2024 12:07:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: kernel test robot <lkp@intel.com>, Naveen N Rao <naveen@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>
Subject: Re: arch/powerpc/kernel/trace/ftrace.c:752:46: sparse: sparse: cast
 truncates bits from constant value (200000000 becomes 0)
In-Reply-To: <202409170855.Lb8k7eyz-lkp@intel.com>
References: <202409170855.Lb8k7eyz-lkp@intel.com>
Date: Tue, 17 Sep 2024 12:07:28 +1000
Message-ID: <87bk0nqbhb.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a430d95c5efa2b545d26a094eb5f624e36732af0
> commit: f3993a0330e2d11e42c095810c6c33084024df46 powerpc/ftrace: Extend ftrace support for large kernels to ppc32
> date:   1 year, 1 month ago
> config: powerpc-randconfig-r132-20240916 (https://download.01.org/0day-ci/archive/20240917/202409170855.Lb8k7eyz-lkp@intel.com/config)
 
  CONFIG_PPC32=y
  # CONFIG_PPC64 is not set

32-bit build.

> compiler: powerpc-linux-gcc (GCC) 14.1.0
> reproduce: (https://download.01.org/0day-ci/archive/20240917/202409170855.Lb8k7eyz-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409170855.Lb8k7eyz-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    arch/powerpc/kernel/trace/ftrace.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/irq.h, ...):
>    include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
>>> arch/powerpc/kernel/trace/ftrace.c:752:46: sparse: sparse: cast truncates bits from constant value (200000000 becomes 0)
>    arch/powerpc/kernel/trace/ftrace.c:752:72: sparse: sparse: cast truncates bits from constant value (200000000 becomes 0)
>
> vim +752 arch/powerpc/kernel/trace/ftrace.c
>
> 84ade0a6655bee arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2022-05-16  720  
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  721  int __init ftrace_dyn_arch_init(void)
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  722  {
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  723  	unsigned int *tramp[] = { ftrace_tramp_text, ftrace_tramp_init };
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  724  	unsigned long addr = FTRACE_REGS_ADDR;
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  725  	long reladdr;
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  726  	int i;
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  727  	u32 stub_insns[] = {
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  728  #ifdef CONFIG_PPC_KERNEL_PCREL
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  729  		/* pla r12,addr */
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  730  		PPC_PREFIX_MLS | __PPC_PRFX_R(1),
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  731  		PPC_INST_PADDI | ___PPC_RT(_R12),
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  732  		PPC_RAW_MTCTR(_R12),
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  733  		PPC_RAW_BCTR()
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  734  #elif defined(CONFIG_PPC64)
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  735  		PPC_RAW_LD(_R12, _R13, offsetof(struct paca_struct, kernel_toc)),
> e89aa642be21b1 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  736  		PPC_RAW_ADDIS(_R12, _R12, 0),
> e89aa642be21b1 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  737  		PPC_RAW_ADDI(_R12, _R12, 0),
> e89aa642be21b1 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  738  		PPC_RAW_MTCTR(_R12),
> e89aa642be21b1 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  739  		PPC_RAW_BCTR()
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  740  #else
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  741  		PPC_RAW_LIS(_R12, 0),
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  742  		PPC_RAW_ADDI(_R12, _R12, 0),
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  743  		PPC_RAW_MTCTR(_R12),
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  744  		PPC_RAW_BCTR()
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  745  #endif
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  746  	};
> af8b9f352ffd43 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  747  
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  748  	if (IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {

In practice this is 64-bit only code, but I guess sparse doesn't know that.

> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  749  		for (i = 0; i < 2; i++) {
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  750  			reladdr = addr - (unsigned long)tramp[i];
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  751  
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08 @752  			if (reladdr >= (long)SZ_8G || reladdr < -(long)SZ_8G) {

We could use s64 for these casts?

cheers

> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  753  				pr_err("Address of %ps out of range of pcrel address.\n",
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  754  					(void *)addr);
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  755  				return -1;
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  756  			}
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  757  
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  758  			memcpy(tramp[i], stub_insns, sizeof(stub_insns));
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  759  			tramp[i][0] |= IMM_H18(reladdr);
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  760  			tramp[i][1] |= IMM_L(reladdr);
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  761  			add_ftrace_tramp((unsigned long)tramp[i]);
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  762  		}
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  763  	} else if (IS_ENABLED(CONFIG_PPC64)) {
> af8b9f352ffd43 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  764  		reladdr = addr - kernel_toc_addr();
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  765  
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  766  		if (reladdr >= (long)SZ_2G || reladdr < -(long long)SZ_2G) {
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  767  			pr_err("Address of %ps out of range of kernel_toc.\n",
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  768  				(void *)addr);
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  769  			return -1;
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  770  		}
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  771  
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  772  		for (i = 0; i < 2; i++) {
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  773  			memcpy(tramp[i], stub_insns, sizeof(stub_insns));
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  774  			tramp[i][1] |= PPC_HA(reladdr);
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  775  			tramp[i][2] |= PPC_LO(reladdr);
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  776  			add_ftrace_tramp((unsigned long)tramp[i]);
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  777  		}
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  778  	} else {
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  779  		for (i = 0; i < 2; i++) {
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  780  			memcpy(tramp[i], stub_insns, sizeof(stub_insns));
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  781  			tramp[i][0] |= PPC_HA(addr);
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  782  			tramp[i][1] |= PPC_LO(addr);
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  783  			add_ftrace_tramp((unsigned long)tramp[i]);
> f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  784  		}
> 7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  785  	}
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  786  
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  787  	return 0;
> 67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  788  }
> 6794c78243bfda arch/powerpc/kernel/ftrace.c       Steven Rostedt   2009-02-09  789  
>
> :::::: The code at line 752 was first introduced by commit
> :::::: 7e3a68be42e10f5fa5890e97afc0afd992355bc3 powerpc/64: vmlinux support building with PCREL addresing
>
> :::::: TO: Nicholas Piggin <npiggin@gmail.com>
> :::::: CC: Michael Ellerman <mpe@ellerman.id.au>
>
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

