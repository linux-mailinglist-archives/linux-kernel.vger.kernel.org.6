Return-Path: <linux-kernel+bounces-358471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36A997FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0824F2808F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684D81FCC76;
	Thu, 10 Oct 2024 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqK782ub"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513051FCC70
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546299; cv=none; b=m7B7R7zEom601Y3APJ7dLl3djWffebvFZOx++bzod4sK1uu/1h8f2u8NxodCH+28EwSNTBq0FbS5sNdux1GqUFdd83LFHbNkqlsRiMrhY25W9HKBpCnTAWOc1BFccZQXmzpN65wKqq9dbvyQ453vfrbtyy28LEuvKhk9qUODDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546299; c=relaxed/simple;
	bh=45hp/XUBOcyovIOArO++WoEHXue+KGCZoGUQk99sOeI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eNN2JhilSTjjNI3cL+x9uD5BtPMLScBWOe6r8LfkD9anjqWxuZJQgnEhi+oUgTvKXP/suskQdvO3oJPS+oYS3k0UENl+1snWxRhuR40HO+XDEER/GCpPTydx/sPcMPnI1rK9NsJ9HcrE/53C2RyjXIm4DISpXqrdRLVDzmIgJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqK782ub; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728546298; x=1760082298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=45hp/XUBOcyovIOArO++WoEHXue+KGCZoGUQk99sOeI=;
  b=EqK782ubL/gHO+Kb/7sYLS8EsATJ7CRzB3pfxaa/Lpj8wg3y/s0hPplm
   QN9VLQO8Ip8hEHWS35Q2YCbe0wjWX/OKkNO76WTXDbWdDvmqKoUXEX3CU
   LqZY018XUEU0slgHOTA3qELIQ3O1RPqzeS/+8UatjlNW642qF6Utnt2+4
   SOgNGzVsALQmN6aaG+V/20TTpG5XtWnoZ0onW3It6A0xMq8T5sgrdl5aa
   +6h0n96YXTzWPieW9EF43DF8BuKyo4haQMumIAlDWI7/lTN/L0gUI1QTt
   six6ohXfPAuxkIlSjXaip2o6Yq6EwpFLS13q27dZjgv9zWRjXg9gCNi7Y
   g==;
X-CSE-ConnectionGUID: WbugL1ZmRdyvvETIkLRtlA==
X-CSE-MsgGUID: A21Db2CuQP6LNEIpjcdG3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31588364"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31588364"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 00:44:57 -0700
X-CSE-ConnectionGUID: oHLY7ZIuS2GeOMzjoohMZg==
X-CSE-MsgGUID: tnt2BWOjRl2xRSVELtdcww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="76428658"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Oct 2024 00:44:55 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1synqu-000ALv-37;
	Thu, 10 Oct 2024 07:44:52 +0000
Date: Thu, 10 Oct 2024 15:44:05 +0800
From: kernel test robot <lkp@intel.com>
To: Guo Ren <guoren@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/irq.c:49:1: sparse: sparse: symbol
 '__pcpu_scope_irq_stack' was not declared. Should it be static?
Message-ID: <202410101516.J0ChPNHa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d3d1556696c1a993eec54ac585fe5bf677e07474
commit: 163e76cc6ef43b7a5e9b6e245a6d6667c9d9b4a7 riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
date:   1 year, 4 months ago
config: riscv-randconfig-r122-20241010 (https://download.01.org/0day-ci/archive/20241010/202410101516.J0ChPNHa-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce: (https://download.01.org/0day-ci/archive/20241010/202410101516.J0ChPNHa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410101516.J0ChPNHa-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/irq.c:49:1: sparse: sparse: symbol '__pcpu_scope_irq_stack' was not declared. Should it be static?

vim +/__pcpu_scope_irq_stack +49 arch/riscv/kernel/irq.c

    35	
    36	#ifdef CONFIG_VMAP_STACK
    37	static void init_irq_stacks(void)
    38	{
    39		int cpu;
    40		ulong *p;
    41	
    42		for_each_possible_cpu(cpu) {
    43			p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(cpu));
    44			per_cpu(irq_stack_ptr, cpu) = p;
    45		}
    46	}
    47	#else
    48	/* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned. */
  > 49	DEFINE_PER_CPU_ALIGNED(ulong [IRQ_STACK_SIZE/sizeof(ulong)], irq_stack);
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

