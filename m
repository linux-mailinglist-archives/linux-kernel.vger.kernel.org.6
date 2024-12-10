Return-Path: <linux-kernel+bounces-439029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CEC9EA9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C50188727E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71BF192D66;
	Tue, 10 Dec 2024 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiFfHTrz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BF172BD5;
	Tue, 10 Dec 2024 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816308; cv=none; b=aC13fFq+SWozVuZ4e7GRJKngt+8nSurJ3WPYSdACR9Gd6Uzak1KDYFGYjR9Nr68HbUK+PJGJW22CC8gn38NgaKzMvVrggehOcmj84VFwn6XB+f2b9Xfm68G2ljRulILOHFcOQ0tqa7KWawpBUiHFsil4LGpN9pIVKla3bV0TlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816308; c=relaxed/simple;
	bh=H6C+H0ERg2udqpIlH6eX06oEpkp6sFJgzrUzQhN7GMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJmyHO43tZ2FkMEsGUpRW/3nU/wqwUbwK9aDgmLu1QvMjOSeI9D33wGDGE2xNGhfZWhm7/OSLV4nYm3cfCaProOSgwGPFonYR5d/r1T2uq4X8sO1UDTe+pk+yT5OmSVj6hTPTUuXZCL7hMl7kcWRYVD/gQML5vRJf/S9x2UAyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiFfHTrz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733816305; x=1765352305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H6C+H0ERg2udqpIlH6eX06oEpkp6sFJgzrUzQhN7GMk=;
  b=BiFfHTrzgALEaWeAeWFXvGnAScqLipN6vFCgpAavhy6sTo3jyheTnbZc
   ED+9BSijd8gh4dQEGufV4gZJFX0fBvbdGsT7GSUcnLjmY5rNeOWMmPxyf
   OkK3xOiXNWkkmSSZJcgu2sIXriv8eCBFvkyJshLnKBO4RHLZ9W4s/2oKU
   rkolEvGbh3ro99QutDHjVHd4AUsaLz7enwKr6ybWekatU1V1Num9aPivY
   6yjAUXSvtT+cy4fT7wWo6/KhXAlVuqMMeJt1QlIPG144cdDNpnFkIDmQK
   6U/mOyD9vlC1SKF8b8g7TxwtahJuxPf0ZxfqmuNBqJVYBLRfhYK1Es0n+
   w==;
X-CSE-ConnectionGUID: w9aG15SHTR27rKRgyp0K2Q==
X-CSE-MsgGUID: ncQVT807ROCwLENs50E6Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="45543315"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="45543315"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 23:38:25 -0800
X-CSE-ConnectionGUID: Rq4nbTcHSlu/PC9fbFCHXQ==
X-CSE-MsgGUID: imrIX125Q92cD6pes/MbMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="126217843"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Dec 2024 23:38:20 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKup0-0005Fd-0c;
	Tue, 10 Dec 2024 07:38:18 +0000
Date: Tue, 10 Dec 2024 15:37:17 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu, arnd@arndb.de, unicorn_wang@outlook.com,
	conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
	krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
	robh@kernel.org, tglx@linutronix.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
Message-ID: <202412101545.Psk65SvD-lkp@intel.com>
References: <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>

Hi Chen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on fac04efc5c793dccbd07e2d59af9f90b7fc0dca4]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-interrupt-controller-Add-Sophgo-SG2042-MSI/20241209-151429
base:   fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
patch link:    https://lore.kernel.org/r/c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang%40outlook.com
patch subject: [PATCH v2 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt controller
config: arm-randconfig-r131-20241210 (https://download.01.org/0day-ci/archive/20241210/202412101545.Psk65SvD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241210/202412101545.Psk65SvD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412101545.Psk65SvD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-sg2042-msi.c:64:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/irqchip/irq-sg2042-msi.c:64:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/irqchip/irq-sg2042-msi.c:64:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/irqchip/irq-sg2042-msi.c:64:9: sparse:     got unsigned int *

vim +/__iomem +64 drivers/irqchip/irq-sg2042-msi.c

    58	
    59	static void sg2042_msi_irq_ack(struct irq_data *d)
    60	{
    61		struct sg2042_msi_data *data  = irq_data_get_irq_chip_data(d);
    62		int bit_off = d->hwirq - data->irq_first;
    63	
  > 64		writel(1 << bit_off, (unsigned int *)data->reg_clr);
    65	
    66		irq_chip_ack_parent(d);
    67	}
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

