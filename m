Return-Path: <linux-kernel+bounces-186883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF078CCA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A2D1F21D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0231C36;
	Thu, 23 May 2024 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcNLzS54"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E551879
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716427655; cv=none; b=emhe587sU29YYOHFcYerIWfgTF+2GS3u6PjUfn8TXeTDBcr9WZniJjFdRxSYymbLb2jYMY9heqGJcjbtbe9qr4LxbLE6cyB21I1QsjE2GX2BKatiArwrr8XZdFZPUDEFTRIQ5jM4F1L2gHJLCB278WCKmdaPhys6fA6NDG0+tDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716427655; c=relaxed/simple;
	bh=gP6mZchGnRcBPPCl64YGZjtTtoXmQ7Joujf+lM4ucXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rQL8A5lZF2VsNaaWJqCyh512h8odnQOG+lIKiif7hVGS8GdPPAA0Ars7qjQI+Ch4Ot5+hJZ/6gJamABov0puYZwFgDPPeURvWK3J3iYx2kqJZe5fPY/o2JE4fE9K7dl+/hqpTL3kQW3KL0cBnF115YCUP4NFOgq9KggMGEDEAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcNLzS54; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716427654; x=1747963654;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gP6mZchGnRcBPPCl64YGZjtTtoXmQ7Joujf+lM4ucXg=;
  b=dcNLzS54cMzOMxrII2MonJUTiXLvHLxO5qvWG9Ess8PcHQh5NTGmbmKs
   hkRxJyzarnV6vX7KvXUavHqnlNHBSujbhIvBrpMWuOt2bLQNGmPPX/BPq
   hY8XaXStHw3UhZSpOYKGjOQ+LXPNWCihmi4WjXVQbgLQh9We/pnqF7PAJ
   GvWaZHpcsXS/BlFQnl9NO+f103KiE4lYFURqUureOihVlSjw4wi7eLRow
   ia9gCCvLA1n3i2If0PDIzGJ1F7X+s7betUKPAL0uqsxYZG5gr1Tr4sT3R
   QMowob2yGVM1oYFiUv8NRtBSjBBYDl7FvaUamxBqGY6EtUgibCWRYXRAS
   w==;
X-CSE-ConnectionGUID: SSC1uWwoQYa2HIvgKgX0iQ==
X-CSE-MsgGUID: c5TAJMRIR+mg9M7WGVzrmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="30247183"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="30247183"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 18:27:33 -0700
X-CSE-ConnectionGUID: Y4mumLR/R6K6wycpL3aEuQ==
X-CSE-MsgGUID: kQZKPJyMTQSrj+hp7+JgcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38327022"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 22 May 2024 18:27:31 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9xEu-0002Jb-24;
	Thu, 23 May 2024 01:27:28 +0000
Date: Thu, 23 May 2024 09:27:02 +0800
From: kernel test robot <lkp@intel.com>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Saeed Nowshadi <saeed.nowshadi@amd.com>
Subject: drivers/mailbox/zynqmp-ipi-mailbox.c:914:15: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202405230902.aIsI0MHh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de7e71ef8bed222dd144d8878091ecb6d5dfd208
commit: 6ffb1635341bec50fa9540ae7827d1e5d75ae0b0 mailbox: zynqmp: handle SGI for shared IPI
date:   3 days ago
config: arm64-randconfig-r132-20240523 (https://download.01.org/0day-ci/archive/20240523/202405230902.aIsI0MHh-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project fa9b1be45088dce1e4b602d451f118128b94237b)
reproduce: (https://download.01.org/0day-ci/archive/20240523/202405230902.aIsI0MHh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405230902.aIsI0MHh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mailbox/zynqmp-ipi-mailbox.c:914:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct zynqmp_ipi_pdata [noderef] __percpu *pdata @@     got void * @@
   drivers/mailbox/zynqmp-ipi-mailbox.c:914:15: sparse:     expected struct zynqmp_ipi_pdata [noderef] __percpu *pdata
   drivers/mailbox/zynqmp-ipi-mailbox.c:914:15: sparse:     got void *
>> drivers/mailbox/zynqmp-ipi-mailbox.c:921:56: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected unsigned int [usertype] *out_value @@     got unsigned int [noderef] __percpu * @@
   drivers/mailbox/zynqmp-ipi-mailbox.c:921:56: sparse:     expected unsigned int [usertype] *out_value
   drivers/mailbox/zynqmp-ipi-mailbox.c:921:56: sparse:     got unsigned int [noderef] __percpu *
>> drivers/mailbox/zynqmp-ipi-mailbox.c:936:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct zynqmp_ipi_mbox *mbox @@     got struct zynqmp_ipi_mbox [noderef] __percpu * @@
   drivers/mailbox/zynqmp-ipi-mailbox.c:936:14: sparse:     expected struct zynqmp_ipi_mbox *mbox
   drivers/mailbox/zynqmp-ipi-mailbox.c:936:14: sparse:     got struct zynqmp_ipi_mbox [noderef] __percpu *
>> drivers/mailbox/zynqmp-ipi-mailbox.c:940:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct zynqmp_ipi_pdata *pdata @@     got struct zynqmp_ipi_pdata [noderef] __percpu *pdata @@
   drivers/mailbox/zynqmp-ipi-mailbox.c:940:29: sparse:     expected struct zynqmp_ipi_pdata *pdata
   drivers/mailbox/zynqmp-ipi-mailbox.c:940:29: sparse:     got struct zynqmp_ipi_pdata [noderef] __percpu *pdata
>> drivers/mailbox/zynqmp-ipi-mailbox.c:964:60: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct zynqmp_ipi_pdata *pdata @@     got struct zynqmp_ipi_pdata [noderef] __percpu *pdata @@
   drivers/mailbox/zynqmp-ipi-mailbox.c:964:60: sparse:     expected struct zynqmp_ipi_pdata *pdata
   drivers/mailbox/zynqmp-ipi-mailbox.c:964:60: sparse:     got struct zynqmp_ipi_pdata [noderef] __percpu *pdata
>> drivers/mailbox/zynqmp-ipi-mailbox.c:974:68: sparse: sparse: incorrect type in argument 6 (different address spaces) @@     expected void *dev_id @@     got struct zynqmp_ipi_pdata [noderef] __percpu *pdata @@
   drivers/mailbox/zynqmp-ipi-mailbox.c:974:68: sparse:     expected void *dev_id
   drivers/mailbox/zynqmp-ipi-mailbox.c:974:68: sparse:     got struct zynqmp_ipi_pdata [noderef] __percpu *pdata
>> drivers/mailbox/zynqmp-ipi-mailbox.c:983:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got struct zynqmp_ipi_pdata [noderef] __percpu *pdata @@
   drivers/mailbox/zynqmp-ipi-mailbox.c:983:36: sparse:     expected void *data
   drivers/mailbox/zynqmp-ipi-mailbox.c:983:36: sparse:     got struct zynqmp_ipi_pdata [noderef] __percpu *pdata
   drivers/mailbox/zynqmp-ipi-mailbox.c:987:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct zynqmp_ipi_pdata *pdata @@     got struct zynqmp_ipi_pdata [noderef] __percpu *pdata @@
   drivers/mailbox/zynqmp-ipi-mailbox.c:987:32: sparse:     expected struct zynqmp_ipi_pdata *pdata
   drivers/mailbox/zynqmp-ipi-mailbox.c:987:32: sparse:     got struct zynqmp_ipi_pdata [noderef] __percpu *pdata
>> drivers/mailbox/zynqmp-ipi-mailbox.c:918:9: sparse: sparse: dereference of noderef expression
   drivers/mailbox/zynqmp-ipi-mailbox.c:934:9: sparse: sparse: dereference of noderef expression
   drivers/mailbox/zynqmp-ipi-mailbox.c:963:17: sparse: sparse: dereference of noderef expression
   drivers/mailbox/zynqmp-ipi-mailbox.c:964:48: sparse: sparse: dereference of noderef expression
   drivers/mailbox/zynqmp-ipi-mailbox.c:972:17: sparse: sparse: dereference of noderef expression
   drivers/mailbox/zynqmp-ipi-mailbox.c:973:45: sparse: sparse: dereference of noderef expression
   drivers/mailbox/zynqmp-ipi-mailbox.c:973:45: sparse: sparse: dereference of noderef expression
   drivers/mailbox/zynqmp-ipi-mailbox.c:978:17: sparse: sparse: dereference of noderef expression

vim +914 drivers/mailbox/zynqmp-ipi-mailbox.c

4981b82ba2ff87 Wendy Liang        2019-02-21  897  
4981b82ba2ff87 Wendy Liang        2019-02-21  898  static int zynqmp_ipi_probe(struct platform_device *pdev)
4981b82ba2ff87 Wendy Liang        2019-02-21  899  {
4981b82ba2ff87 Wendy Liang        2019-02-21  900  	struct device *dev = &pdev->dev;
4981b82ba2ff87 Wendy Liang        2019-02-21  901  	struct device_node *nc, *np = pdev->dev.of_node;
6ffb1635341bec Tanmay Shah        2024-05-03  902  	struct zynqmp_ipi_pdata __percpu *pdata;
6ffb1635341bec Tanmay Shah        2024-05-03  903  	struct of_phandle_args out_irq;
4981b82ba2ff87 Wendy Liang        2019-02-21  904  	struct zynqmp_ipi_mbox *mbox;
4981b82ba2ff87 Wendy Liang        2019-02-21  905  	int num_mboxes, ret = -EINVAL;
41bcf30100c521 Ben Levinsky       2024-04-10  906  	setup_ipi_fn ipi_fn;
4981b82ba2ff87 Wendy Liang        2019-02-21  907  
f72f805e72882c Tanmay Shah        2023-03-10  908  	num_mboxes = of_get_available_child_count(np);
f72f805e72882c Tanmay Shah        2023-03-10  909  	if (num_mboxes == 0) {
f72f805e72882c Tanmay Shah        2023-03-10  910  		dev_err(dev, "mailbox nodes not available\n");
f72f805e72882c Tanmay Shah        2023-03-10  911  		return -EINVAL;
f72f805e72882c Tanmay Shah        2023-03-10  912  	}
f72f805e72882c Tanmay Shah        2023-03-10  913  
043f85ce81cb17 Christophe JAILLET 2022-11-20 @914  	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
4981b82ba2ff87 Wendy Liang        2019-02-21  915  			     GFP_KERNEL);
4981b82ba2ff87 Wendy Liang        2019-02-21  916  	if (!pdata)
4981b82ba2ff87 Wendy Liang        2019-02-21  917  		return -ENOMEM;
4981b82ba2ff87 Wendy Liang        2019-02-21 @918  	pdata->dev = dev;
4981b82ba2ff87 Wendy Liang        2019-02-21  919  
4981b82ba2ff87 Wendy Liang        2019-02-21  920  	/* Get the IPI local agents ID */
4981b82ba2ff87 Wendy Liang        2019-02-21 @921  	ret = of_property_read_u32(np, "xlnx,ipi-id", &pdata->local_id);
4981b82ba2ff87 Wendy Liang        2019-02-21  922  	if (ret < 0) {
4981b82ba2ff87 Wendy Liang        2019-02-21  923  		dev_err(dev, "No IPI local ID is specified.\n");
4981b82ba2ff87 Wendy Liang        2019-02-21  924  		return ret;
4981b82ba2ff87 Wendy Liang        2019-02-21  925  	}
4981b82ba2ff87 Wendy Liang        2019-02-21  926  
41bcf30100c521 Ben Levinsky       2024-04-10  927  	ipi_fn = (setup_ipi_fn)device_get_match_data(&pdev->dev);
41bcf30100c521 Ben Levinsky       2024-04-10  928  	if (!ipi_fn) {
41bcf30100c521 Ben Levinsky       2024-04-10  929  		dev_err(dev,
41bcf30100c521 Ben Levinsky       2024-04-10  930  			"Mbox Compatible String is missing IPI Setup fn.\n");
41bcf30100c521 Ben Levinsky       2024-04-10  931  		return -ENODEV;
41bcf30100c521 Ben Levinsky       2024-04-10  932  	}
41bcf30100c521 Ben Levinsky       2024-04-10  933  
4981b82ba2ff87 Wendy Liang        2019-02-21  934  	pdata->num_mboxes = num_mboxes;
4981b82ba2ff87 Wendy Liang        2019-02-21  935  
4981b82ba2ff87 Wendy Liang        2019-02-21 @936  	mbox = pdata->ipi_mboxes;
41bcf30100c521 Ben Levinsky       2024-04-10  937  	mbox->setup_ipi_fn = ipi_fn;
41bcf30100c521 Ben Levinsky       2024-04-10  938  
4981b82ba2ff87 Wendy Liang        2019-02-21  939  	for_each_available_child_of_node(np, nc) {
4981b82ba2ff87 Wendy Liang        2019-02-21 @940  		mbox->pdata = pdata;
4981b82ba2ff87 Wendy Liang        2019-02-21  941  		ret = zynqmp_ipi_mbox_probe(mbox, nc);
4981b82ba2ff87 Wendy Liang        2019-02-21  942  		if (ret) {
2453128847ca1e Wang Qing          2021-12-13  943  			of_node_put(nc);
4981b82ba2ff87 Wendy Liang        2019-02-21  944  			dev_err(dev, "failed to probe subdev.\n");
4981b82ba2ff87 Wendy Liang        2019-02-21  945  			ret = -EINVAL;
4981b82ba2ff87 Wendy Liang        2019-02-21  946  			goto free_mbox_dev;
4981b82ba2ff87 Wendy Liang        2019-02-21  947  		}
4981b82ba2ff87 Wendy Liang        2019-02-21  948  		mbox++;
4981b82ba2ff87 Wendy Liang        2019-02-21  949  	}
4981b82ba2ff87 Wendy Liang        2019-02-21  950  
6ffb1635341bec Tanmay Shah        2024-05-03  951  	ret = of_irq_parse_one(dev_of_node(dev), 0, &out_irq);
6ffb1635341bec Tanmay Shah        2024-05-03  952  	if (ret < 0) {
6ffb1635341bec Tanmay Shah        2024-05-03  953  		dev_err(dev, "failed to parse interrupts\n");
6ffb1635341bec Tanmay Shah        2024-05-03  954  		goto free_mbox_dev;
6ffb1635341bec Tanmay Shah        2024-05-03  955  	}
6ffb1635341bec Tanmay Shah        2024-05-03  956  	ret = out_irq.args[1];
6ffb1635341bec Tanmay Shah        2024-05-03  957  
6ffb1635341bec Tanmay Shah        2024-05-03  958  	/*
6ffb1635341bec Tanmay Shah        2024-05-03  959  	 * If Interrupt number is in SGI range, then request SGI else request
6ffb1635341bec Tanmay Shah        2024-05-03  960  	 * IPI system IRQ.
6ffb1635341bec Tanmay Shah        2024-05-03  961  	 */
6ffb1635341bec Tanmay Shah        2024-05-03  962  	if (ret < MAX_SGI) {
6ffb1635341bec Tanmay Shah        2024-05-03  963  		pdata->irq = ret;
6ffb1635341bec Tanmay Shah        2024-05-03 @964  		ret = xlnx_mbox_init_sgi(pdev, pdata->irq, pdata);
6ffb1635341bec Tanmay Shah        2024-05-03  965  		if (ret)
6ffb1635341bec Tanmay Shah        2024-05-03  966  			goto free_mbox_dev;
6ffb1635341bec Tanmay Shah        2024-05-03  967  	} else {
4981b82ba2ff87 Wendy Liang        2019-02-21  968  		ret = platform_get_irq(pdev, 0);
ec32481b1669ad Markus Elfring     2020-04-05  969  		if (ret < 0)
4981b82ba2ff87 Wendy Liang        2019-02-21  970  			goto free_mbox_dev;
ec32481b1669ad Markus Elfring     2020-04-05  971  
4981b82ba2ff87 Wendy Liang        2019-02-21  972  		pdata->irq = ret;
4981b82ba2ff87 Wendy Liang        2019-02-21  973  		ret = devm_request_irq(dev, pdata->irq, zynqmp_ipi_interrupt,
4981b82ba2ff87 Wendy Liang        2019-02-21 @974  				       IRQF_SHARED, dev_name(dev), pdata);
6ffb1635341bec Tanmay Shah        2024-05-03  975  	}
6ffb1635341bec Tanmay Shah        2024-05-03  976  
4981b82ba2ff87 Wendy Liang        2019-02-21  977  	if (ret) {
4981b82ba2ff87 Wendy Liang        2019-02-21  978  		dev_err(dev, "IRQ %d is not requested successfully.\n",
4981b82ba2ff87 Wendy Liang        2019-02-21  979  			pdata->irq);
4981b82ba2ff87 Wendy Liang        2019-02-21  980  		goto free_mbox_dev;
4981b82ba2ff87 Wendy Liang        2019-02-21  981  	}
4981b82ba2ff87 Wendy Liang        2019-02-21  982  
4981b82ba2ff87 Wendy Liang        2019-02-21 @983  	platform_set_drvdata(pdev, pdata);
4981b82ba2ff87 Wendy Liang        2019-02-21  984  	return ret;
4981b82ba2ff87 Wendy Liang        2019-02-21  985  
4981b82ba2ff87 Wendy Liang        2019-02-21  986  free_mbox_dev:
4981b82ba2ff87 Wendy Liang        2019-02-21  987  	zynqmp_ipi_free_mboxes(pdata);
4981b82ba2ff87 Wendy Liang        2019-02-21  988  	return ret;
4981b82ba2ff87 Wendy Liang        2019-02-21  989  }
4981b82ba2ff87 Wendy Liang        2019-02-21  990  

:::::: The code at line 914 was first introduced by commit
:::::: 043f85ce81cb1714e14d31c322c5646513dde3fb mailbox: zynq: Switch to flexible array to simplify code

:::::: TO: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
:::::: CC: Jassi Brar <jaswinder.singh@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

