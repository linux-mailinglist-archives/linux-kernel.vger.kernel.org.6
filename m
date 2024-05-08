Return-Path: <linux-kernel+bounces-173842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529BF8C064B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C50AB24182
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742AD13280D;
	Wed,  8 May 2024 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qt3eHpTi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45113247D;
	Wed,  8 May 2024 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203763; cv=none; b=MyfTU7me3gY2129YQjIo75rn3c2OXasZjDbztdpC89C9iFcGH9FX9+8KZyME30CsYXk7V7S6HbbDODbGP6zrlJ0PPr8nztYTjK8do1DsetogEW42GMc+HDWMhFs8bStb3szePtZ7qWho12XwK3bvHpcfpRaYsFhhwfWNVS6ZRmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203763; c=relaxed/simple;
	bh=C8Xvi1dqxGMmUWFmC5443UIoMw0DmQtqXBALLo+P4cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlRExcBr3mQpRae66yUTW2ZKFNevZFUK+pbuJDHvi8vA1q+5AX5zouVuBUt1ve1tq7+hYEj7xTpb9vf+UBbp7C4f4loe/69EqZ24jAZ+Et/V1GclW82/CFG9gIw01EiDcaL+GhqoyLM3VAeXCj0a1wUWHbDb/No/4qhIRXpDywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qt3eHpTi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715203762; x=1746739762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C8Xvi1dqxGMmUWFmC5443UIoMw0DmQtqXBALLo+P4cs=;
  b=Qt3eHpTiQRNKHlRnoreEcEFcKYLgsW6tjSYtbYMvLmKw9AQr15ie3BKH
   DwFj21nizk9T6a3spB91zdTg3Yt0uefEoVMmkx8ahdkRd0RcnYMKWfPsX
   3DCl9a50Fdx4i/aVaTY0VCbjm3+McbFPNL/Od7u6GXO+Xg7ZUfANdQxIL
   mDzMAwdOUtd7SG74Yk0cMYaf9sviTbij9OTpqPnUP/sYm5k4mc8mFxxpE
   /9qFGsPPr5AWEKUz3dQb04Ov4S9/RtPyE18XIg8LjthGGL+kic0JpzEg4
   iXj7bZDDRqgm7b26gEXakGeGJTka8Lkmtw4UDYMt+QwXmFHt6aO1EsdoE
   A==;
X-CSE-ConnectionGUID: L2cp5IOkRuS7frDl0ngSKA==
X-CSE-MsgGUID: 9czIEUUIQMORxtK8H0kyUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10944295"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10944295"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 14:29:21 -0700
X-CSE-ConnectionGUID: iSeayxZASOe+bvS8jTtpbg==
X-CSE-MsgGUID: 1lF8zhgzQeu+oVzzGWXuZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33708469"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 May 2024 14:29:17 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4oqg-00047m-0I;
	Wed, 08 May 2024 21:29:14 +0000
Date: Thu, 9 May 2024 05:28:31 +0800
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
Message-ID: <202405090419.xGNdK28X-lkp@intel.com>
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
config: loongarch-randconfig-r113-20240508 (https://download.01.org/0day-ci/archive/20240509/202405090419.xGNdK28X-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240509/202405090419.xGNdK28X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405090419.xGNdK28X-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-loongarch-avec.c:34:1: sparse: sparse: symbol '__pcpu_scope_pending_list' was not declared. Should it be static?
   drivers/irqchip/irq-loongarch-avec.c:41:3: sparse: sparse: symbol 'loongarch_avec' was not declared. Should it be static?
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
   drivers/irqchip/irq-loongarch-avec.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/irq.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   drivers/irqchip/irq-loongarch-avec.c:164:6: sparse: sparse: context imbalance in 'complete_irq_moving' - different lock contexts for basic block
   drivers/irqchip/irq-loongarch-avec.c: note: in included file (through arch/loongarch/include/asm/loongarch.h, arch/loongarch/include/asm/cpu-info.h, ...):
   ../lib/gcc/loongarch64-linux/13.2.0/include/larchintrin.h:294:30: sparse: sparse: undefined identifier '__builtin_loongarch_iocsrrd_d'
   ../lib/gcc/loongarch64-linux/13.2.0/include/larchintrin.h:294:11: sparse: sparse: cast from unknown type
   ../lib/gcc/loongarch64-linux/13.2.0/include/larchintrin.h:332:3: sparse: sparse: undefined identifier '__builtin_loongarch_iocsrwr_d'

vim +/__pcpu_scope_pending_list +34 drivers/irqchip/irq-loongarch-avec.c

    33	
  > 34	DEFINE_PER_CPU(struct pending_list, pending_list);
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

