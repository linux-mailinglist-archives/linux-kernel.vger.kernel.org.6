Return-Path: <linux-kernel+bounces-436788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C9F9E8AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F182280E1B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6016F0D0;
	Mon,  9 Dec 2024 05:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrrZ+3Ye"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC9165EFA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720991; cv=none; b=iHafwfQqlCTZLSk7rAgjFn+5OjQJp9LW5tb5IS+4JzoRN//WucNfsPjxKI/5TOXbIRku6QyzdEiMclo4ggaa9C2egLEAyKJ6Q01SzGpufxDHUMPjfycLBlxV+YILqRJqONzSud/tTdQLPhA8vFFSymb4x4XKwgYCZeCYWKjEtV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720991; c=relaxed/simple;
	bh=5m4JmzjnytwMP7zAl2HUHtoskiDxy9zyHZNjVcK5v/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p7Wa3yS1vKNk4FYnqL6G74il9tyoNrdGA0jcYRVRDoQtH40EfxY6yitQ86A4IhUidYOXARjjmlgDOSaRaPaozvuAKb+nHCXxSwlMrBffjv2YjFj+OdNea05Oxo7du9hwvX/owGM670wbIrcfiEHrl9rqU1AXKR2AHPCKFJL+ivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrrZ+3Ye; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720988; x=1765256988;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5m4JmzjnytwMP7zAl2HUHtoskiDxy9zyHZNjVcK5v/A=;
  b=NrrZ+3YeK94ixHaASDxRcprbjPQZ8IXDFq1+E9zyduFFMqYiIT1sDi91
   Ht/N9Vf9Xc2p3a06VXc9y+L3sihBb2KfeiWMBLnBwrFt4gIk4a6+KVNOx
   H8fEIac/kdUvdxlTiIHwTqNulBGC/JzDK/xleWiUt1mokg53lS4r2NGYG
   zyv7JfoO7FT7f9jBv/ddPi6Es5qwKVrtRct2WXjAZeCFnF10skFE7raiU
   P3Ky6ODwkdyvesOPoOOOxVySlCSN+TT7WDcpOQRE0Algq/Wg/74F15v+6
   qXacM9+u6xxlpIr7wDcIJmntxuXayzezqBGYgOgP0nfFvzGFYb4WirlbM
   g==;
X-CSE-ConnectionGUID: HUt0AYGwT1Owq6izWeGdpQ==
X-CSE-MsgGUID: TyeLer/3Tq6rrO6s1gLPZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37684002"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37684002"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:09:47 -0800
X-CSE-ConnectionGUID: TdNsSRXGTS66YWjImErunw==
X-CSE-MsgGUID: yLiAv7zHSFC4RafG2A5/pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="125806863"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Dec 2024 21:09:46 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKW1e-0003yU-28;
	Mon, 09 Dec 2024 05:09:42 +0000
Date: Mon, 9 Dec 2024 13:08:59 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: cast
 truncates bits from constant value (fffffffff000 becomes fffff000)
Message-ID: <202412091227.KUZgstBB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
commit: 6f14293257309a02a6d451e80e4ef1d78560479e MIPS: Allow using more than 32-bit addresses for reset vectors when possible
date:   6 weeks ago
config: mips-randconfig-r112-20241209 (https://download.01.org/0day-ci/archive/20241209/202412091227.KUZgstBB-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241209/202412091227.KUZgstBB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412091227.KUZgstBB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/mips/kernel/smp-cps.c:83:32: sparse: sparse: cast removes address space '__iomem' of expression
   arch/mips/kernel/smp-cps.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false
   arch/mips/kernel/smp-cps.c: note: in included file (through arch/mips/include/asm/mips-cps.h):
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:308:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:308:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:308:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:308:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:308:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:308:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:308:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:308:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:308:1: sparse:     got void [noderef] __iomem *
   arch/mips/kernel/smp-cps.c: note: in included file (through arch/mips/include/asm/mips-cps.h):
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void [noderef] __iomem *
   arch/mips/kernel/smp-cps.c: note: in included file (through arch/mips/include/asm/mips-cps.h):
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
>> arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: cast truncates bits from constant value (fffffffff000 becomes fffff000)
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] __iomem *
>> arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: cast truncates bits from constant value (fffffffff000 becomes fffff000)
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:329:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:329:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:143:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:143:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:143:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:143:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:143:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:143:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:143:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:143:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:143:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:164:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:164:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:143:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@

vim +329 arch/mips/include/asm/mips-cm.h

   326	
   327	/* GCR_Cx_RESET_BASE - Configure where powered up cores will fetch from */
   328	GCR_CX_ACCESSOR_RW(32, 0x020, reset_base)
 > 329	GCR_CX_ACCESSOR_RW(64, 0x020, reset64_base)
   330	#define CM_GCR_Cx_RESET_BASE_BEVEXCBASE		GENMASK(31, 12)
   331	#define CM_GCR_Cx_RESET64_BASE_BEVEXCBASE	GENMASK_ULL(47, 12)
   332	#define CM_GCR_Cx_RESET_BASE_MODE		BIT(1)
   333	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

