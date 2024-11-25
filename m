Return-Path: <linux-kernel+bounces-421597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F41B49D8D66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AADF1637EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8121BC9F0;
	Mon, 25 Nov 2024 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lT4bFiQS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F514F9CF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566672; cv=none; b=rRfmryekbIfWyjHHgeXzkp8rh60pWNYIhRrW5NKLUinSx/mr2uOh5dgwbqWGzWJftVAqtCLMEKu1TMMTRocrQRedyjHjD6aD2faxaD1GwvZKgwKgwIMbaRANrGRByRZNOV+gKKdg5tgIqDCWT6XpsVm+dlyiU6EwGc89quNvRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566672; c=relaxed/simple;
	bh=p2ssI5EsbtaTPo1K3sGX1Uf1+9ANLZRHrglRJAtZCco=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LIcwOLwmug9MHNQhcJ7gqs6CrstW5YI9iuI+oB2uxMneLiZvA/iqbnIeUXd10gDyPF92Zg2HKATt+vWHr033iiNAseP0UX9PQWVnjYjTCLia9jQVAnx4AZEEyIItD8PykGwky2/3P1HwuWBEhpU3Omu93otCu0GRMLCzROF33Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lT4bFiQS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732566671; x=1764102671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p2ssI5EsbtaTPo1K3sGX1Uf1+9ANLZRHrglRJAtZCco=;
  b=lT4bFiQSMWJSYqRs7XIwH9gMFeqRwWaR4pP4Lwkvd97Nd1qdp3OryXnV
   vVks3/wZ7nlCIfCksEJaTK1poDBHhCPuLRKg3S1FiOhgfwm/rW4H83Y0j
   yCcQXumfulgGfc6tUqz4KjsFKmYIOxbT8k8EsGEX3DggZ/NXquJXDVe+M
   SRIzyd0YDtyF6a/glXLqkAaFM2JIOJeG9YKuRRD1JUaUlrXtOK8+tYDCr
   e3/tpEaAasBx3XcEHxrot0k99ZUa6s2GCr24FhL/F+UEjAweBRUhrMZ/7
   nHwUHL3uyfYb/qL57GLwmqFq+aZRi98I2C/eYJAPKKhQ1wtEnzqwHAq/D
   g==;
X-CSE-ConnectionGUID: EJgc1G6hTvaGDhzvK2WaYg==
X-CSE-MsgGUID: YvokcrIERSCBH9p3errSlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43193850"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="43193850"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:31:11 -0800
X-CSE-ConnectionGUID: bCzzwSebTo2LtKp/xtVyog==
X-CSE-MsgGUID: jD9KFIczRYCUq+khFy67OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91801112"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2024 12:31:09 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFfje-0006m9-2R;
	Mon, 25 Nov 2024 20:31:06 +0000
Date: Tue, 26 Nov 2024 04:30:14 +0800
From: kernel test robot <lkp@intel.com>
To: Julien Massot <julien.massot@iot.bzh>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202411260438.Tinbxw1D-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f16d5e6f220661f73b36a4be1b21575651d8833
commit: 285892a74f1370a12249f765c6a4e3b16194852e remoteproc: Add Renesas rcar driver
date:   2 years, 11 months ago
config: mips-randconfig-r122-20241114 (https://download.01.org/0day-ci/archive/20241126/202411260438.Tinbxw1D-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241126/202411260438.Tinbxw1D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411260438.Tinbxw1D-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/rcar_rproc.c:28:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     expected void *va
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *va @@
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     got void *va

vim +45 drivers/remoteproc/rcar_rproc.c

    40	
    41	static int rcar_rproc_mem_release(struct rproc *rproc,
    42					   struct rproc_mem_entry *mem)
    43	{
    44		dev_dbg(&rproc->dev, "unmap memory: %pa\n", &mem->dma);
  > 45		iounmap(mem->va);
    46	
    47		return 0;
    48	}
    49	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

