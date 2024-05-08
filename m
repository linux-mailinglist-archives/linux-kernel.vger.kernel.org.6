Return-Path: <linux-kernel+bounces-173834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF29F8C0627
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735801F23475
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975CE131BC9;
	Wed,  8 May 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="es0Q55zq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71C13119E;
	Wed,  8 May 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203102; cv=none; b=Fo100IIDQnciOkqaSF7Q2vDDeNMNRL9t86NefqDoLoOPwjHQ3JDHicGLJfCGMquxnud2IFKcszuSZUATZhBnKoSmBs6HXaQGmdU7a9XwuB/Xvf6LqT2FKvGkkPGeJ8LMFUDAhb8iFh92bQT3KKlFbS+YsD5SNLta59+8/ksCfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203102; c=relaxed/simple;
	bh=Jl8a2gzeUWXyecXSjecelhMzBK0892fkGfODCZrcQRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJfXLD+0fN4dU9sSh3c/n1loJlUtGpOqG1xS1TWjOwFk7KYFyexcIDLXTB0K6JqBiPZf07mj6xQjMhekRpglXJaRI43E0U1uBTxRskVEV99aEZO+HW8GiadggeaFAcxpKqshsp9qLvOIK0Pp9hBWPM5DlUUxzYOriIjF0Z1by8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=es0Q55zq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715203101; x=1746739101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jl8a2gzeUWXyecXSjecelhMzBK0892fkGfODCZrcQRs=;
  b=es0Q55zqixAVf9VhmPvuOcurLdNVAl42fzN2g3Ibhn4REdxgYWJ9n8Mk
   kLSS7nQrZLkgadHrRCpFpdN6RaDEY9nYfK/RlokdtIga61acpMH5aSbXW
   TpDdvKZeFzP4eN5Zc11xnHEboFjtTu8SUD+CYTT5Ts4AaoTm6fqpdAEHt
   z353FC+zwq3CLquJ4BkqH9YSdGodJJt1dKuy3scrz+3AbQ5amdj1kF/KO
   H5dju4KU0qUFygrVRuqZt1NZ99q+Szlc01WNGn5du5BHrOdUzhNLjesJA
   Hyxeip7Wx2qYgOIc9AqRjsZnejfyY0sK4vALMhnlwJWkekhS1g6iC6jZb
   w==;
X-CSE-ConnectionGUID: LnGpM/NgSIiVwoKF+doo8g==
X-CSE-MsgGUID: AhR8wJY5RtqlioMYGw1ZKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="28572254"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28572254"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 14:18:21 -0700
X-CSE-ConnectionGUID: CaXnspVTR8ifvR6M1dU1eg==
X-CSE-MsgGUID: OZQ4MhZXRE2PBVEwSznTPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28993656"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 May 2024 14:18:15 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4og0-00047O-2S;
	Wed, 08 May 2024 21:18:12 +0000
Date: Thu, 9 May 2024 05:18:08 +0800
From: kernel test robot <lkp@intel.com>
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
	kernel@xen0n.name, tglx@linutronix.de, jiaxun.yang@flygoat.com,
	gaoliang@loongson.cn, wangliupu@loongson.cn, lvjianmin@loongson.cn,
	yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
	dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site,
	zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
	zhoubinbin@loongson.cn
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Loongarch:Support loongarch avec
Message-ID: <202405090438.c1xvjipc-lkp@intel.com>
References: <20240507125953.9117-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507125953.9117-1-zhangtianyang@loongson.cn>

Hi Tianyang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master v6.9-rc7]
[cannot apply to next-20240508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tianyang-Zhang/Loongarch-Support-loongarch-avec/20240507-210314
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20240507125953.9117-1-zhangtianyang%40loongson.cn
patch subject: [PATCH 2/2] Loongarch:Support loongarch avec
config: loongarch-randconfig-r133-20240508 (https://download.01.org/0day-ci/archive/20240509/202405090438.c1xvjipc-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240509/202405090438.c1xvjipc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405090438.c1xvjipc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-loongarch-avec.c:41:3: sparse: sparse: symbol 'loongarch_avec' was not declared. Should it be static?
   drivers/irqchip/irq-loongarch-avec.c:181:31: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_d'
   drivers/irqchip/irq-loongarch-avec.c:181:31: sparse: sparse: cast from unknown type
   drivers/irqchip/irq-loongarch-avec.c:184:31: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_d'
   drivers/irqchip/irq-loongarch-avec.c:184:31: sparse: sparse: cast from unknown type
   drivers/irqchip/irq-loongarch-avec.c:187:31: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_d'
   drivers/irqchip/irq-loongarch-avec.c:187:31: sparse: sparse: cast from unknown type
   drivers/irqchip/irq-loongarch-avec.c:190:31: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_d'
   drivers/irqchip/irq-loongarch-avec.c:190:31: sparse: sparse: cast from unknown type
   drivers/irqchip/irq-loongarch-avec.c:215:18: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_d'
   drivers/irqchip/irq-loongarch-avec.c:215:18: sparse: sparse: cast from unknown type
   drivers/irqchip/irq-loongarch-avec.c: note: in included file (through include/linux/smp.h, include/linux/percpu.h, include/linux/context_tracking_state.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   drivers/irqchip/irq-loongarch-avec.c:164:6: sparse: sparse: context imbalance in 'complete_irq_moving' - different lock contexts for basic block
   drivers/irqchip/irq-loongarch-avec.c: note: in included file (through arch/loongarch/include/asm/loongarch.h, arch/loongarch/include/asm/cpu-info.h, ...):
   ../lib/gcc/loongarch64-linux/13.2.0/include/larchintrin.h:294:30: sparse: sparse: undefined identifier '__builtin_loongarch_iocsrrd_d'
   ../lib/gcc/loongarch64-linux/13.2.0/include/larchintrin.h:294:11: sparse: sparse: cast from unknown type
   ../lib/gcc/loongarch64-linux/13.2.0/include/larchintrin.h:332:3: sparse: sparse: undefined identifier '__builtin_loongarch_iocsrwr_d'

vim +/loongarch_avec +41 drivers/irqchip/irq-loongarch-avec.c

    35	
    36	struct loongarch_avec_chip {
    37		struct fwnode_handle	*fwnode;
    38		struct irq_domain	*domain;
    39		struct irq_matrix	*vector_matrix;
    40		raw_spinlock_t		lock;
  > 41	} loongarch_avec;
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

