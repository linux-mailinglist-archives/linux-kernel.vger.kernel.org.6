Return-Path: <linux-kernel+bounces-266509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F109400E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484A3283A55
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770418F2C7;
	Mon, 29 Jul 2024 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bU4hgrff"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8621618E776
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290949; cv=none; b=B+8jjp0ak8ZYldbJf/HEwVr/tFOLAShuVS+SMcl4SEg0+2M3EY7Q/dZ6bz7dFud674ljQofAlseUlS5QOIPc7e5P1qX9GngaZBU+L0GTi8zv1zQ6MvmT0iHyEqGuGAjxqTtH+XYO0jMGx8lQuMQEQUj1i5PWRxfYidDWulRJI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290949; c=relaxed/simple;
	bh=/R/gLSYAJ25dSaQ8oF89ox+wvwjc4z2AyAcZjWIZIEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fu6KAEej9TCP57h3TxEd0ZH4tGM2jwzd3NrIY1eYQD0EiNZfoDrhSi/4SQKmE0/J6E82z2TQLun6Gkr8Nkg+SAsZsOEZVAcQxHwP7ElvXNMslLaH6xyNx8yjWJlSGTX5gXOTE8QwxkBqnfjMVVCLO3FH3c8sW0OP3ZURdUaMPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bU4hgrff; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722290947; x=1753826947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/R/gLSYAJ25dSaQ8oF89ox+wvwjc4z2AyAcZjWIZIEY=;
  b=bU4hgrff22C2jmrULJyPiDhL3TjPyoviPmHth/KJHkhOK8Mk7bWbbc6r
   0clPjdEbZg5KhbmPIi399N5ZZZjd57gWkW+P8UnhHKuNhWyxMXOJTB1Hg
   sjHkYMFG4q5ca/m1pNxLkh6LpSzlGyVSPwWo3MflYW9RyZLt26dlqwqke
   NQs6hVe+8T4K7w4UiwL6thJgx4+k2fbuhPR6EdME972CBZ/KuGq1RIK2g
   GQdSAyXRdgFeSAh1vUVeydD0Hnjd8aY1H+4hbZlaN0ojR70pxrUbUYY9b
   uyF6OHmELWTvg3sCQknPGUkzGdwHt3o+0HG5no+UDl3gyHXXhWjqOHN23
   w==;
X-CSE-ConnectionGUID: swtMUSfDSy6mltJ+tHhAmA==
X-CSE-MsgGUID: FhUrxkftQhGX4AL590zOqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="42604878"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="42604878"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 15:09:06 -0700
X-CSE-ConnectionGUID: 1p482hqFTMSBIYLLxfFnOg==
X-CSE-MsgGUID: owAy2lN+TzaRRNM4tWMKOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="53766358"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 29 Jul 2024 15:09:04 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYYYA-000s7S-1I;
	Mon, 29 Jul 2024 22:09:02 +0000
Date: Tue, 30 Jul 2024 06:08:53 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: drivers/usb/dwc3/core.c:1499:47: warning: '%u' directive output may
 be truncated writing between 1 and 10 bytes into a region of size 4
Message-ID: <202407300647.A8UggFiR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6b5faec9f564ea627c66064a4a6a5904fe5a07dd
commit: 3f12222a4bebeb13ce06ddecc1610ad32fa835dd usb: dwc3: core: Fix compile warning on s390 gcc in dwc3_get_phy call
date:   3 months ago
config: x86_64-randconfig-071-20240730 (https://download.01.org/0day-ci/archive/20240730/202407300647.A8UggFiR-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407300647.A8UggFiR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407300647.A8UggFiR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/dwc3/core.c: In function 'dwc3_core_init':
>> drivers/usb/dwc3/core.c:1499:47: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 4 [-Wformat-truncation=]
       snprintf(phy_name, sizeof(phy_name), "usb3-%u", i);
                                                  ^~
   drivers/usb/dwc3/core.c:1499:41: note: directive argument in the range [0, 2147483647]
       snprintf(phy_name, sizeof(phy_name), "usb3-%u", i);
                                            ^~~~~~~~~
   drivers/usb/dwc3/core.c:1499:4: note: 'snprintf' output between 7 and 16 bytes into a destination of size 9
       snprintf(phy_name, sizeof(phy_name), "usb3-%u", i);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/dwc3/core.c:1482:48: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 4 [-Wformat-truncation=]
       snprintf(phy_name, sizeof(phy_name),  "usb2-%u", i);
                                                   ^~
   drivers/usb/dwc3/core.c:1482:42: note: directive argument in the range [0, 2147483647]
       snprintf(phy_name, sizeof(phy_name),  "usb2-%u", i);
                                             ^~~~~~~~~
   drivers/usb/dwc3/core.c:1482:4: note: 'snprintf' output between 7 and 16 bytes into a destination of size 9
       snprintf(phy_name, sizeof(phy_name),  "usb2-%u", i);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1499 drivers/usb/dwc3/core.c

  1445	
  1446	static int dwc3_core_get_phy(struct dwc3 *dwc)
  1447	{
  1448		struct device		*dev = dwc->dev;
  1449		struct device_node	*node = dev->of_node;
  1450		char phy_name[9];
  1451		int ret;
  1452		u8 i;
  1453	
  1454		if (node) {
  1455			dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
  1456			dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
  1457		} else {
  1458			dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
  1459			dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
  1460		}
  1461	
  1462		if (IS_ERR(dwc->usb2_phy)) {
  1463			ret = PTR_ERR(dwc->usb2_phy);
  1464			if (ret == -ENXIO || ret == -ENODEV)
  1465				dwc->usb2_phy = NULL;
  1466			else
  1467				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
  1468		}
  1469	
  1470		if (IS_ERR(dwc->usb3_phy)) {
  1471			ret = PTR_ERR(dwc->usb3_phy);
  1472			if (ret == -ENXIO || ret == -ENODEV)
  1473				dwc->usb3_phy = NULL;
  1474			else
  1475				return dev_err_probe(dev, ret, "no usb3 phy configured\n");
  1476		}
  1477	
  1478		for (i = 0; i < dwc->num_usb2_ports; i++) {
  1479			if (dwc->num_usb2_ports == 1)
  1480				snprintf(phy_name, sizeof(phy_name), "usb2-phy");
  1481			else
  1482				snprintf(phy_name, sizeof(phy_name),  "usb2-%u", i);
  1483	
  1484			dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
  1485			if (IS_ERR(dwc->usb2_generic_phy[i])) {
  1486				ret = PTR_ERR(dwc->usb2_generic_phy[i]);
  1487				if (ret == -ENOSYS || ret == -ENODEV)
  1488					dwc->usb2_generic_phy[i] = NULL;
  1489				else
  1490					return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
  1491								phy_name);
  1492			}
  1493		}
  1494	
  1495		for (i = 0; i < dwc->num_usb3_ports; i++) {
  1496			if (dwc->num_usb3_ports == 1)
  1497				snprintf(phy_name, sizeof(phy_name), "usb3-phy");
  1498			else
> 1499				snprintf(phy_name, sizeof(phy_name), "usb3-%u", i);
  1500	
  1501			dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
  1502			if (IS_ERR(dwc->usb3_generic_phy[i])) {
  1503				ret = PTR_ERR(dwc->usb3_generic_phy[i]);
  1504				if (ret == -ENOSYS || ret == -ENODEV)
  1505					dwc->usb3_generic_phy[i] = NULL;
  1506				else
  1507					return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
  1508								phy_name);
  1509			}
  1510		}
  1511	
  1512		return 0;
  1513	}
  1514	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

