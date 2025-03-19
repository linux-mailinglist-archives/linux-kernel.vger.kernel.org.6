Return-Path: <linux-kernel+bounces-567356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E606A68508
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A062424D17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3420FABA;
	Wed, 19 Mar 2025 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/YP5vnN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62136B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742365494; cv=none; b=m8mkiXfRbkRlvUQaZjRnkB64UFSrFp9joqjZ4Li12fJET9oQdu9EkfytT9aQRw4RmZMHzZDV7Ow1H5z47N5l05/YL3jHJol/bpoFtHwXD5vCt40o6fGNzE9lMlVfB+ZbEhCNP7F8KJkoNNqut8Do6cn4jtUCswTMxPWL3Vdsbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742365494; c=relaxed/simple;
	bh=lFbERSPbSEnNh3+vDj9uildzNeCQkCxCabQjIZINSps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N9Bum5KgMdxraVyXQ3QjOVv39JL9xQXW8KIwnUy3D454rHs4hAjwn+Mjdax8VVST46eM2O/TIMYrUjbbn5fu+KmegrS6ya72GUp8pigbAQn2m8QPFvwnvS83IhGAb9yCIr5ohbc4C/b45zL6PUF+zxVsPx2mSPlPCpEgtPfJOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/YP5vnN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742365493; x=1773901493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lFbERSPbSEnNh3+vDj9uildzNeCQkCxCabQjIZINSps=;
  b=e/YP5vnN4lHPPUz6kxbcXef/qeFcVmgxfpBVGojqLe0HsVcMIQRsOOQG
   v9SUSPglahttoB7q/+uSozXTMzKvAkyMC9R0WY1bCJfM3DAEMeTBh4f5+
   lBePJ0NJ46RfXU5e96PUrfqldkk+C8e0H/KMh/vYSOvQWE20ZeVDsolsz
   xGeH4eGYG/I/7XoJT0KNq+RL9Af073cZn9L1sfh3/fpeaPj1RurMFjR8R
   ETw/dljbFIUMgYi+4/bwIutVt81G31gF1C2wcqW4toEVxlo/ZWmO/6m1g
   /bx1P+sPNbM7InAyy222O3vlkxKsGlyzRytumotNdVulLLPX+Fd50NiZX
   g==;
X-CSE-ConnectionGUID: tHfSRCoqT+O0R0Hy7lJXuA==
X-CSE-MsgGUID: 99Bc4X6pSyGs82eUP3dPxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43427787"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="43427787"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:24:52 -0700
X-CSE-ConnectionGUID: tL7e0yGFTuOZpRIEJNvNBA==
X-CSE-MsgGUID: aYE253qiSlW0P5A7BxENrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122413645"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 18 Mar 2025 23:24:51 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tumrA-000ER0-0p;
	Wed, 19 Mar 2025 06:24:48 +0000
Date: Wed, 19 Mar 2025 14:23:48 +0800
From: kernel test robot <lkp@intel.com>
To: Shijith Thotton <sthotton@marvell.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Vamsi Attunuru <vattunuru@marvell.com>
Subject: drivers/pci/hotplug/octep_hp.c:312:53: warning: '%d' directive
 output may be truncated writing between 1 and 10 bytes into a region of size
 7
Message-ID: <202503191406.iySrpFbN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81e4f8d68c66da301bb881862735bd74c6241a19
commit: e434e54d3ffcd17eeadfcf3cf434bc1dff36daff PCI: hotplug: Add OCTEON PCI hotplug controller driver
date:   4 months ago
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20250319/202503191406.iySrpFbN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503191406.iySrpFbN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503191406.iySrpFbN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/hotplug/octep_hp.c: In function 'octep_hp_pci_probe':
>> drivers/pci/hotplug/octep_hp.c:312:53: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 7 [-Wformat-truncation=]
     snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
                                                        ^~
   drivers/pci/hotplug/octep_hp.c:312:43: note: directive argument in the range [0, 2147483646]
     snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
                                              ^~~~~~~~~~~~~
   drivers/pci/hotplug/octep_hp.c:312:2: note: 'snprintf' output between 11 and 20 bytes into a destination of size 16
     snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +312 drivers/pci/hotplug/octep_hp.c

   297	
   298	static int octep_hp_request_irq(struct octep_hp_controller *hp_ctrl,
   299					enum octep_hp_intr_type type)
   300	{
   301		struct pci_dev *pdev = hp_ctrl->pdev;
   302		struct octep_hp_intr_info *intr;
   303		int irq;
   304	
   305		irq = pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(type));
   306		if (irq < 0)
   307			return irq;
   308	
   309		intr = &hp_ctrl->intr[type];
   310		intr->number = irq;
   311		intr->type = type;
 > 312		snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
   313	
   314		return devm_request_irq(&pdev->dev, irq, octep_hp_intr_handler,
   315					IRQF_SHARED, intr->name, hp_ctrl);
   316	}
   317	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

