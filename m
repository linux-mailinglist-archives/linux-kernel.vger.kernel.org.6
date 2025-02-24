Return-Path: <linux-kernel+bounces-530186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE72A43041
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8F81892C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573220A5D5;
	Mon, 24 Feb 2025 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BswvhGq1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E16207DFF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437529; cv=none; b=cfka+cZ87w74vPxFca2Psr0fYZkduvP0+2j3lAwcKnzBulKV/ZYB06A+hPu3C4QnvISku4WO+ZOOC+K6ptcsBJCvvoW58hFspMf21eyW8zzzvwCfAmaAgq20zcYHUsW8loqcTds45BTB7nBUtEKjqJ9Zsb3aslztb0pGHLcTPAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437529; c=relaxed/simple;
	bh=O82oiPcsMLy7wzs3UgA3GGSNT0fWH9thnsRmzxfnxqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QV+JY83QbaokIP7Up6URiCOaNURKqaMIzL5ON14OdHfCdnfN2MSXbpbCDUNyrSUT2Ydq571ci04ZArzdHFm2kyQ7KjVyH1yrb+IiYyYqLbKFeoLfnkHdHF7YzPrKVeHxHpWSepdsOEUAyjtnp1uoEdSQoKHlHf8YF4jND5HWSP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BswvhGq1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740437527; x=1771973527;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O82oiPcsMLy7wzs3UgA3GGSNT0fWH9thnsRmzxfnxqk=;
  b=BswvhGq1TBW6ws9SOEHE3SjEYOqhzfRi8UXcRCelpcfcKbm+ZF+8/H9b
   wf8q4i5/N67n8BoWnfVveUpPbmJ6k4bnbVOGTQB1C5tOtIGv0t3ZTPng1
   gOtH07zaHHHVrJQi0G81MkoORkO7pvG26AcuCyDIoaz2Bhx5vVRflWstN
   2QjlxNb40717/sA2fM50UgQMgz24eYsuJrBWFd8m6GoETKk6lSwdXXeRo
   KFLcCUrVNlFXHFTjVQ39WokEwTL+nTJIVdHTC2uTwbDChfQT9nFloQQSw
   nMf7pUFl/abns6qnDvi0rTaflUHavtOL35FmMWv32kJkc02pH4iZ/vyju
   w==;
X-CSE-ConnectionGUID: MP6dzRJZRa2EyhjmL8YgWQ==
X-CSE-MsgGUID: XI1QdTWdQ4e2RbvQmH9cxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45128160"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="45128160"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 14:52:06 -0800
X-CSE-ConnectionGUID: 79PtHDDATImMUzpqLh6vdg==
X-CSE-MsgGUID: evyYl6uKR+e55hHm4veqeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121165309"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 24 Feb 2025 14:52:04 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmhIv-0009Pv-0w;
	Mon, 24 Feb 2025 22:52:01 +0000
Date: Tue, 25 Feb 2025 06:51:42 +0800
From: kernel test robot <lkp@intel.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Ray Jui <ray.jui@broadcom.com>
Subject: drivers/i2c/busses/i2c-bcm-iproc.c:871:3: warning: cast to smaller
 integer type 'enum bcm_iproc_i2c_type' from 'const void *'
Message-ID: <202502250655.7lohuY6f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d082ecbc71e9e0bf49883ee4afd435a77a5101b6
commit: 9a1038728037521d177042522bd05c3c51e744a4 i2c: iproc: add NIC I2C support
date:   6 years ago
config: x86_64-buildonly-randconfig-006-20250127 (https://download.01.org/0day-ci/archive/20250225/202502250655.7lohuY6f-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250225/202502250655.7lohuY6f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502250655.7lohuY6f-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-bcm-iproc.c:871:3: warning: cast to smaller integer type 'enum bcm_iproc_i2c_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
     871 |                 (enum bcm_iproc_i2c_type)of_device_get_match_data(&pdev->dev);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +871 drivers/i2c/busses/i2c-bcm-iproc.c

   855	
   856	static int bcm_iproc_i2c_probe(struct platform_device *pdev)
   857	{
   858		int irq, ret = 0;
   859		struct bcm_iproc_i2c_dev *iproc_i2c;
   860		struct i2c_adapter *adap;
   861		struct resource *res;
   862	
   863		iproc_i2c = devm_kzalloc(&pdev->dev, sizeof(*iproc_i2c),
   864					 GFP_KERNEL);
   865		if (!iproc_i2c)
   866			return -ENOMEM;
   867	
   868		platform_set_drvdata(pdev, iproc_i2c);
   869		iproc_i2c->device = &pdev->dev;
   870		iproc_i2c->type =
 > 871			(enum bcm_iproc_i2c_type)of_device_get_match_data(&pdev->dev);
   872		init_completion(&iproc_i2c->done);
   873	
   874		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   875		iproc_i2c->base = devm_ioremap_resource(iproc_i2c->device, res);
   876		if (IS_ERR(iproc_i2c->base))
   877			return PTR_ERR(iproc_i2c->base);
   878	
   879		if (iproc_i2c->type == IPROC_I2C_NIC) {
   880			res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
   881			iproc_i2c->idm_base = devm_ioremap_resource(iproc_i2c->device,
   882								    res);
   883			if (IS_ERR(iproc_i2c->idm_base))
   884				return PTR_ERR(iproc_i2c->idm_base);
   885	
   886			ret = of_property_read_u32(iproc_i2c->device->of_node,
   887						   "brcm,ape-hsls-addr-mask",
   888						   &iproc_i2c->ape_addr_mask);
   889			if (ret < 0) {
   890				dev_err(iproc_i2c->device,
   891					"'brcm,ape-hsls-addr-mask' missing\n");
   892				return -EINVAL;
   893			}
   894	
   895			spin_lock_init(&iproc_i2c->idm_lock);
   896	
   897			/* no slave support */
   898			bcm_iproc_algo.reg_slave = NULL;
   899			bcm_iproc_algo.unreg_slave = NULL;
   900		}
   901	
   902		ret = bcm_iproc_i2c_init(iproc_i2c);
   903		if (ret)
   904			return ret;
   905	
   906		ret = bcm_iproc_i2c_cfg_speed(iproc_i2c);
   907		if (ret)
   908			return ret;
   909	
   910		irq = platform_get_irq(pdev, 0);
   911		if (irq > 0) {
   912			ret = devm_request_irq(iproc_i2c->device, irq,
   913					       bcm_iproc_i2c_isr, 0, pdev->name,
   914					       iproc_i2c);
   915			if (ret < 0) {
   916				dev_err(iproc_i2c->device,
   917					"unable to request irq %i\n", irq);
   918				return ret;
   919			}
   920	
   921			iproc_i2c->irq = irq;
   922		} else {
   923			dev_warn(iproc_i2c->device,
   924				 "no irq resource, falling back to poll mode\n");
   925		}
   926	
   927		bcm_iproc_i2c_enable_disable(iproc_i2c, true);
   928	
   929		adap = &iproc_i2c->adapter;
   930		i2c_set_adapdata(adap, iproc_i2c);
   931		strlcpy(adap->name, "Broadcom iProc I2C adapter", sizeof(adap->name));
   932		adap->algo = &bcm_iproc_algo;
   933		adap->quirks = &bcm_iproc_i2c_quirks;
   934		adap->dev.parent = &pdev->dev;
   935		adap->dev.of_node = pdev->dev.of_node;
   936	
   937		return i2c_add_adapter(adap);
   938	}
   939	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

