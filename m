Return-Path: <linux-kernel+bounces-343099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E179896C8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B47DB23735
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04D244375;
	Sun, 29 Sep 2024 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoFnN59B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D782263A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727634532; cv=none; b=pakhO9GGp9ViTBefmTO2ZRsu1dLQOo+VJDd6/lhJ4iGRdEe6vbqgCTyfw1IBVtjWb3q+defaL8O7q3o1pLIvoojCZ/mQpEPNXPxMf5ryq7Z8ex59L4dxv5CVeCM3c1xotQm9urvCWvYMCc5LufIi5J0unSbZqnnkfll9K6KFhjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727634532; c=relaxed/simple;
	bh=/fA3E5/0f0nZfBodt4r0U6WraEMDwsyW13TODN0CqqU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OnFpzYm+optt/fnziO6Se4Vpr/2/HCRAOz9ifK/wzIxNuq4K8lG95fcuJJJHiVZgEKzqayPhvfoMAE/WvHLoLIjhFcb2W78KWQWtW+uPEnMI/EKZy4c4P9NMut2WZmVo26l+3eDggLPtIcOIHoTtkOM0npNu2NBkXzvmDTO24GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoFnN59B; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727634529; x=1759170529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/fA3E5/0f0nZfBodt4r0U6WraEMDwsyW13TODN0CqqU=;
  b=JoFnN59B88GPHN+/dwUoRxOmfo2oFfoyFn+Hh7pFOkI80xwF4VXQyx9N
   3eqUWDZUQ+vPrqU5fylU57Yd/qmI8nEcH9385tNGbFcdqzwQmt1kLWUny
   q+5pl7+6/bKUnfMKcMGgNRkAFeATFPyu8WrmfkYtktusVTibSpk6tE71S
   PIYGGIeFelKSjVY3Qv/FoMOssAFd7rH+WnKfOxfck9STEJJMqYGLgta4B
   i1PQ54J3z8CVjgDZukXeGj4LqHu/kYlHRjv9eEc2jXJy1TYM2wYw3k1pH
   3aWFWpf93YVdp8VPiKbmuy4yuSxNRrbxOV7HGcwOZkmkVAYVcV22odUCJ
   Q==;
X-CSE-ConnectionGUID: KwEjKzeZTnya6hxCThuw3w==
X-CSE-MsgGUID: Fc3mPpSfS5aTBHiLph1X5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="37300013"
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="37300013"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 11:28:49 -0700
X-CSE-ConnectionGUID: Xg/OtcC+RyaAbHFCr6EKDQ==
X-CSE-MsgGUID: LhdbBhSoSqiMXhiJvTi4ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="110559983"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2024 11:28:47 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suyey-000OaR-1p;
	Sun, 29 Sep 2024 18:28:44 +0000
Date: Mon, 30 Sep 2024 02:28:07 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: arch/sh/boards/mach-ecovec24/setup.c:1133:9: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202409300224.rylEkKz3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3efc57369a0ce8f76bf0804f7e673982384e4ac9
commit: d87123aa9a7920e88633ffc5c5a0a22ab08bdc06 sh: ecovec24: Rename missed backlight field from fbdev to dev
date:   8 months ago
config: sh-randconfig-r132-20240929 (https://download.01.org/0day-ci/archive/20240930/202409300224.rylEkKz3-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240930/202409300224.rylEkKz3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409300224.rylEkKz3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/sh/boards/mach-ecovec24/setup.c:1133:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1133:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1133:9: sparse:     got unsigned int
>> arch/sh/boards/mach-ecovec24/setup.c:1133:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1133:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1133:9: sparse:     got unsigned int
   arch/sh/boards/mach-ecovec24/setup.c:1153:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1153:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1153:9: sparse:     got unsigned int
   arch/sh/boards/mach-ecovec24/setup.c:1154:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1154:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1154:9: sparse:     got unsigned int
   arch/sh/boards/mach-ecovec24/setup.c:1161:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1161:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1161:9: sparse:     got unsigned int
   arch/sh/boards/mach-ecovec24/setup.c:1162:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1162:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1162:9: sparse:     got unsigned int
   arch/sh/boards/mach-ecovec24/setup.c:1203:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1203:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1203:9: sparse:     got unsigned int
   arch/sh/boards/mach-ecovec24/setup.c:1203:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1203:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1203:9: sparse:     got unsigned int
   arch/sh/boards/mach-ecovec24/setup.c:1213:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1213:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1213:9: sparse:     got unsigned int
   arch/sh/boards/mach-ecovec24/setup.c:1213:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1213:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1213:9: sparse:     got unsigned int
   arch/sh/boards/mach-ecovec24/setup.c:1356:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1356:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1356:17: sparse:     got unsigned int
   arch/sh/boards/mach-ecovec24/setup.c:1356:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-ecovec24/setup.c:1356:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-ecovec24/setup.c:1356:17: sparse:     got unsigned int
>> arch/sh/boards/mach-ecovec24/setup.c:621:9: sparse: sparse: Initializer entry defined twice
   arch/sh/boards/mach-ecovec24/setup.c:622:10: sparse:   also defined here

vim +1133 arch/sh/boards/mach-ecovec24/setup.c

eb0cd9e88c6a65 Magnus Damm           2009-10-30  1101  
4907d57f76dc1d Kuninori Morimoto     2009-09-10  1102  static int __init arch_setup(void)
4138b74066cc33 Kuninori Morimoto     2009-08-19  1103  {
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1104  	struct clk *clk;
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1105  	bool cn12_enabled = false;
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1106  
eb0cd9e88c6a65 Magnus Damm           2009-10-30  1107  	/* register board specific self-refresh code */
2839bd61f671d3 Magnus Damm           2010-02-25  1108  	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF |
2839bd61f671d3 Magnus Damm           2010-02-25  1109  					SUSP_SH_RSTANDBY,
eb0cd9e88c6a65 Magnus Damm           2009-10-30  1110  					&ecovec24_sdram_enter_start,
eb0cd9e88c6a65 Magnus Damm           2009-10-30  1111  					&ecovec24_sdram_enter_end,
eb0cd9e88c6a65 Magnus Damm           2009-10-30  1112  					&ecovec24_sdram_leave_start,
eb0cd9e88c6a65 Magnus Damm           2009-10-30  1113  					&ecovec24_sdram_leave_end);
eb0cd9e88c6a65 Magnus Damm           2009-10-30  1114  
f78bab30707e04 Magnus Damm           2009-10-07  1115  	/* enable STATUS0, STATUS2 and PDSTATUS */
f78bab30707e04 Magnus Damm           2009-10-07  1116  	gpio_request(GPIO_FN_STATUS0, NULL);
f78bab30707e04 Magnus Damm           2009-10-07  1117  	gpio_request(GPIO_FN_STATUS2, NULL);
f78bab30707e04 Magnus Damm           2009-10-07  1118  	gpio_request(GPIO_FN_PDSTATUS, NULL);
f78bab30707e04 Magnus Damm           2009-10-07  1119  
4138b74066cc33 Kuninori Morimoto     2009-08-19  1120  	/* enable SCIFA0 */
4138b74066cc33 Kuninori Morimoto     2009-08-19  1121  	gpio_request(GPIO_FN_SCIF0_TXD, NULL);
4138b74066cc33 Kuninori Morimoto     2009-08-19  1122  	gpio_request(GPIO_FN_SCIF0_RXD, NULL);
4138b74066cc33 Kuninori Morimoto     2009-08-19  1123  
4138b74066cc33 Kuninori Morimoto     2009-08-19  1124  	/* enable debug LED */
4138b74066cc33 Kuninori Morimoto     2009-08-19  1125  	gpio_request(GPIO_PTG0, NULL);
4138b74066cc33 Kuninori Morimoto     2009-08-19  1126  	gpio_request(GPIO_PTG1, NULL);
4138b74066cc33 Kuninori Morimoto     2009-08-19  1127  	gpio_request(GPIO_PTG2, NULL);
4138b74066cc33 Kuninori Morimoto     2009-08-19  1128  	gpio_request(GPIO_PTG3, NULL);
b7056bc1943ec8 Kuninori Morimoto     2009-08-26  1129  	gpio_direction_output(GPIO_PTG0, 0);
b7056bc1943ec8 Kuninori Morimoto     2009-08-26  1130  	gpio_direction_output(GPIO_PTG1, 0);
b7056bc1943ec8 Kuninori Morimoto     2009-08-26  1131  	gpio_direction_output(GPIO_PTG2, 0);
b7056bc1943ec8 Kuninori Morimoto     2009-08-26  1132  	gpio_direction_output(GPIO_PTG3, 0);
9d56dd3b083a3b Paul Mundt            2010-01-26 @1133  	__raw_writew((__raw_readw(PORT_HIZA) & ~(0x1 << 1)) , PORT_HIZA);
4138b74066cc33 Kuninori Morimoto     2009-08-19  1134  
35a35408914bcd Kuninori Morimoto     2009-08-26  1135  	/* enable SH-Eth */
35a35408914bcd Kuninori Morimoto     2009-08-26  1136  	gpio_request(GPIO_PTA1, NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1137  	gpio_direction_output(GPIO_PTA1, 1);
35a35408914bcd Kuninori Morimoto     2009-08-26  1138  	mdelay(20);
35a35408914bcd Kuninori Morimoto     2009-08-26  1139  
35a35408914bcd Kuninori Morimoto     2009-08-26  1140  	gpio_request(GPIO_FN_RMII_RXD0,    NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1141  	gpio_request(GPIO_FN_RMII_RXD1,    NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1142  	gpio_request(GPIO_FN_RMII_TXD0,    NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1143  	gpio_request(GPIO_FN_RMII_TXD1,    NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1144  	gpio_request(GPIO_FN_RMII_REF_CLK, NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1145  	gpio_request(GPIO_FN_RMII_TX_EN,   NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1146  	gpio_request(GPIO_FN_RMII_RX_ER,   NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1147  	gpio_request(GPIO_FN_RMII_CRS_DV,  NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1148  	gpio_request(GPIO_FN_MDIO,         NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1149  	gpio_request(GPIO_FN_MDC,          NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1150  	gpio_request(GPIO_FN_LNKSTA,       NULL);
35a35408914bcd Kuninori Morimoto     2009-08-26  1151  
907050a33d3b6a Kuninori Morimoto     2009-08-26  1152  	/* enable USB */
9d56dd3b083a3b Paul Mundt            2010-01-26  1153  	__raw_writew(0x0000, 0xA4D80000);
9d56dd3b083a3b Paul Mundt            2010-01-26  1154  	__raw_writew(0x0000, 0xA4D90000);
907050a33d3b6a Kuninori Morimoto     2009-08-26  1155  	gpio_request(GPIO_PTB3,  NULL);
907050a33d3b6a Kuninori Morimoto     2009-08-26  1156  	gpio_request(GPIO_PTB4,  NULL);
907050a33d3b6a Kuninori Morimoto     2009-08-26  1157  	gpio_request(GPIO_PTB5,  NULL);
907050a33d3b6a Kuninori Morimoto     2009-08-26  1158  	gpio_direction_input(GPIO_PTB3);
907050a33d3b6a Kuninori Morimoto     2009-08-26  1159  	gpio_direction_output(GPIO_PTB4, 0);
907050a33d3b6a Kuninori Morimoto     2009-08-26  1160  	gpio_direction_output(GPIO_PTB5, 0);
9d56dd3b083a3b Paul Mundt            2010-01-26  1161  	__raw_writew(0x0600, 0xa40501d4);
9d56dd3b083a3b Paul Mundt            2010-01-26  1162  	__raw_writew(0x0600, 0xa4050192);
907050a33d3b6a Kuninori Morimoto     2009-08-26  1163  
3714a9a026bba0 Kuninori Morimoto     2009-10-28  1164  	if (gpio_get_value(GPIO_PTB3)) {
3714a9a026bba0 Kuninori Morimoto     2009-10-28  1165  		printk(KERN_INFO "USB1 function is selected\n");
3714a9a026bba0 Kuninori Morimoto     2009-10-28  1166  		usb1_common_device.name = "r8a66597_udc";
3714a9a026bba0 Kuninori Morimoto     2009-10-28  1167  	} else {
3714a9a026bba0 Kuninori Morimoto     2009-10-28  1168  		printk(KERN_INFO "USB1 host is selected\n");
3714a9a026bba0 Kuninori Morimoto     2009-10-28  1169  		usb1_common_device.name = "r8a66597_hcd";
3714a9a026bba0 Kuninori Morimoto     2009-10-28  1170  	}
3714a9a026bba0 Kuninori Morimoto     2009-10-28  1171  
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1172  	/* enable LCDC */
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1173  	gpio_request(GPIO_FN_LCDD23,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1174  	gpio_request(GPIO_FN_LCDD22,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1175  	gpio_request(GPIO_FN_LCDD21,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1176  	gpio_request(GPIO_FN_LCDD20,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1177  	gpio_request(GPIO_FN_LCDD19,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1178  	gpio_request(GPIO_FN_LCDD18,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1179  	gpio_request(GPIO_FN_LCDD17,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1180  	gpio_request(GPIO_FN_LCDD16,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1181  	gpio_request(GPIO_FN_LCDD15,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1182  	gpio_request(GPIO_FN_LCDD14,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1183  	gpio_request(GPIO_FN_LCDD13,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1184  	gpio_request(GPIO_FN_LCDD12,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1185  	gpio_request(GPIO_FN_LCDD11,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1186  	gpio_request(GPIO_FN_LCDD10,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1187  	gpio_request(GPIO_FN_LCDD9,    NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1188  	gpio_request(GPIO_FN_LCDD8,    NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1189  	gpio_request(GPIO_FN_LCDD7,    NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1190  	gpio_request(GPIO_FN_LCDD6,    NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1191  	gpio_request(GPIO_FN_LCDD5,    NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1192  	gpio_request(GPIO_FN_LCDD4,    NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1193  	gpio_request(GPIO_FN_LCDD3,    NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1194  	gpio_request(GPIO_FN_LCDD2,    NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1195  	gpio_request(GPIO_FN_LCDD1,    NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1196  	gpio_request(GPIO_FN_LCDD0,    NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1197  	gpio_request(GPIO_FN_LCDDISP,  NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1198  	gpio_request(GPIO_FN_LCDHSYN,  NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1199  	gpio_request(GPIO_FN_LCDDCK,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1200  	gpio_request(GPIO_FN_LCDVSYN,  NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1201  	gpio_request(GPIO_FN_LCDDON,   NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1202  	gpio_request(GPIO_FN_LCDLCLK,  NULL);
9d56dd3b083a3b Paul Mundt            2010-01-26  1203  	__raw_writew((__raw_readw(PORT_HIZA) & ~0x0001), PORT_HIZA);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1204  
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1205  	gpio_request(GPIO_PTE6, NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1206  	gpio_request(GPIO_PTU1, NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1207  	gpio_request(GPIO_PTA2, NULL);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1208  	gpio_direction_input(GPIO_PTE6);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1209  	gpio_direction_output(GPIO_PTU1, 0);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1210  	gpio_direction_output(GPIO_PTA2, 0);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1211  
82b33221784850 Kuninori Morimoto     2009-12-02  1212  	/* I/O buffer drive ability is high */
9d56dd3b083a3b Paul Mundt            2010-01-26  1213  	__raw_writew((__raw_readw(IODRIVEA) & ~0x00c0) | 0x0080 , IODRIVEA);
ea15edb292197a Kuninori Morimoto     2009-08-26  1214  
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1215  	if (gpio_get_value(GPIO_PTE6)) {
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1216  		/* DVI */
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1217  		lcdc_info.clock_source			= LCDC_CLK_EXTERNAL;
44432407d9f5e4 Guennadi Liakhovetski 2010-09-03  1218  		lcdc_info.ch[0].clock_divider		= 1;
93ff259846a774 Laurent Pinchart      2011-11-29  1219  		lcdc_info.ch[0].lcd_modes		= ecovec_dvi_modes;
93ff259846a774 Laurent Pinchart      2011-11-29  1220  		lcdc_info.ch[0].num_modes		= ARRAY_SIZE(ecovec_dvi_modes);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1221  
fe79f919f47eab Laurent Pinchart      2013-07-04  1222  		/* No backlight */
d87123aa9a7920 Geert Uytterhoeven    2023-09-25  1223  		gpio_backlight_data.dev = NULL;
fe79f919f47eab Laurent Pinchart      2013-07-04  1224  
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1225  		gpio_set_value(GPIO_PTA2, 1);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1226  		gpio_set_value(GPIO_PTU1, 1);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1227  	} else {
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1228  		/* Panel */
ea15edb292197a Kuninori Morimoto     2009-08-26  1229  		lcdc_info.clock_source			= LCDC_CLK_PERIPHERAL;
44432407d9f5e4 Guennadi Liakhovetski 2010-09-03  1230  		lcdc_info.ch[0].clock_divider		= 2;
93ff259846a774 Laurent Pinchart      2011-11-29  1231  		lcdc_info.ch[0].lcd_modes		= ecovec_lcd_modes;
93ff259846a774 Laurent Pinchart      2011-11-29  1232  		lcdc_info.ch[0].num_modes		= ARRAY_SIZE(ecovec_lcd_modes);
ea15edb292197a Kuninori Morimoto     2009-08-26  1233  
ea15edb292197a Kuninori Morimoto     2009-08-26  1234  		/* FIXME
ea15edb292197a Kuninori Morimoto     2009-08-26  1235  		 *
ea15edb292197a Kuninori Morimoto     2009-08-26  1236  		 * LCDDON control is needed for Panel,
ea15edb292197a Kuninori Morimoto     2009-08-26  1237  		 * but current sh_mobile_lcdc driver doesn't control it.
ea15edb292197a Kuninori Morimoto     2009-08-26  1238  		 * It is temporary correspondence
ea15edb292197a Kuninori Morimoto     2009-08-26  1239  		 */
ea15edb292197a Kuninori Morimoto     2009-08-26  1240  		gpio_request(GPIO_PTF4, NULL);
ea15edb292197a Kuninori Morimoto     2009-08-26  1241  		gpio_direction_output(GPIO_PTF4, 1);
8810e0553fec6f Kuninori Morimoto     2009-09-28  1242  
8810e0553fec6f Kuninori Morimoto     2009-09-28  1243  		/* enable TouchScreen */
8810e0553fec6f Kuninori Morimoto     2009-09-28  1244  		i2c_register_board_info(0, &ts_i2c_clients, 1);
fcb8918fd242f3 Thomas Gleixner       2011-03-24  1245  		irq_set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1246  	}
fa3ba51bcf2351 Kuninori Morimoto     2009-08-26  1247  
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1248  	/* enable CEU0 */
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1249  	gpio_request(GPIO_FN_VIO0_D15, NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1250  	gpio_request(GPIO_FN_VIO0_D14, NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1251  	gpio_request(GPIO_FN_VIO0_D13, NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1252  	gpio_request(GPIO_FN_VIO0_D12, NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1253  	gpio_request(GPIO_FN_VIO0_D11, NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1254  	gpio_request(GPIO_FN_VIO0_D10, NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1255  	gpio_request(GPIO_FN_VIO0_D9,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1256  	gpio_request(GPIO_FN_VIO0_D8,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1257  	gpio_request(GPIO_FN_VIO0_D7,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1258  	gpio_request(GPIO_FN_VIO0_D6,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1259  	gpio_request(GPIO_FN_VIO0_D5,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1260  	gpio_request(GPIO_FN_VIO0_D4,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1261  	gpio_request(GPIO_FN_VIO0_D3,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1262  	gpio_request(GPIO_FN_VIO0_D2,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1263  	gpio_request(GPIO_FN_VIO0_D1,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1264  	gpio_request(GPIO_FN_VIO0_D0,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1265  	gpio_request(GPIO_FN_VIO0_VD,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1266  	gpio_request(GPIO_FN_VIO0_CLK, NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1267  	gpio_request(GPIO_FN_VIO0_FLD, NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1268  	gpio_request(GPIO_FN_VIO0_HD,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1269  
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1270  	/* enable CEU1 */
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1271  	gpio_request(GPIO_FN_VIO1_D7,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1272  	gpio_request(GPIO_FN_VIO1_D6,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1273  	gpio_request(GPIO_FN_VIO1_D5,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1274  	gpio_request(GPIO_FN_VIO1_D4,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1275  	gpio_request(GPIO_FN_VIO1_D3,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1276  	gpio_request(GPIO_FN_VIO1_D2,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1277  	gpio_request(GPIO_FN_VIO1_D1,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1278  	gpio_request(GPIO_FN_VIO1_D0,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1279  	gpio_request(GPIO_FN_VIO1_FLD, NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1280  	gpio_request(GPIO_FN_VIO1_HD,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1281  	gpio_request(GPIO_FN_VIO1_VD,  NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1282  	gpio_request(GPIO_FN_VIO1_CLK, NULL);
2153ad3294e3e1 Kuninori Morimoto     2009-08-26  1283  
e9103e74907d74 Kuninori Morimoto     2009-09-14  1284  	/* enable KEYSC */
e9103e74907d74 Kuninori Morimoto     2009-09-14  1285  	gpio_request(GPIO_FN_KEYOUT5_IN5, NULL);
e9103e74907d74 Kuninori Morimoto     2009-09-14  1286  	gpio_request(GPIO_FN_KEYOUT4_IN6, NULL);
e9103e74907d74 Kuninori Morimoto     2009-09-14  1287  	gpio_request(GPIO_FN_KEYOUT3,     NULL);
e9103e74907d74 Kuninori Morimoto     2009-09-14  1288  	gpio_request(GPIO_FN_KEYOUT2,     NULL);
e9103e74907d74 Kuninori Morimoto     2009-09-14  1289  	gpio_request(GPIO_FN_KEYOUT1,     NULL);
e9103e74907d74 Kuninori Morimoto     2009-09-14  1290  	gpio_request(GPIO_FN_KEYOUT0,     NULL);
e9103e74907d74 Kuninori Morimoto     2009-09-14  1291  	gpio_request(GPIO_FN_KEYIN0,      NULL);
e9103e74907d74 Kuninori Morimoto     2009-09-14  1292  
064a16dc41be87 Kuninori Morimoto     2009-09-16  1293  	/* enable user debug switch */
064a16dc41be87 Kuninori Morimoto     2009-09-16  1294  	gpio_request(GPIO_PTR0, NULL);
064a16dc41be87 Kuninori Morimoto     2009-09-16  1295  	gpio_request(GPIO_PTR4, NULL);
064a16dc41be87 Kuninori Morimoto     2009-09-16  1296  	gpio_request(GPIO_PTR5, NULL);
064a16dc41be87 Kuninori Morimoto     2009-09-16  1297  	gpio_request(GPIO_PTR6, NULL);
064a16dc41be87 Kuninori Morimoto     2009-09-16  1298  	gpio_direction_input(GPIO_PTR0);
064a16dc41be87 Kuninori Morimoto     2009-09-16  1299  	gpio_direction_input(GPIO_PTR4);
064a16dc41be87 Kuninori Morimoto     2009-09-16  1300  	gpio_direction_input(GPIO_PTR5);
064a16dc41be87 Kuninori Morimoto     2009-09-16  1301  	gpio_direction_input(GPIO_PTR6);
064a16dc41be87 Kuninori Morimoto     2009-09-16  1302  
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1303  	/* SD-card slot CN11 */
5744c88111f076 Guennadi Liakhovetski 2011-04-15  1304  #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
1ce4da7a502ea6 Magnus Damm           2009-12-07  1305  	/* enable SDHI0 on CN11 (needs DS2.4 set to ON) */
96987d96f0058d Kuninori Morimoto     2009-10-02  1306  	gpio_request(GPIO_FN_SDHI0WP,  NULL);
96987d96f0058d Kuninori Morimoto     2009-10-02  1307  	gpio_request(GPIO_FN_SDHI0CMD, NULL);
96987d96f0058d Kuninori Morimoto     2009-10-02  1308  	gpio_request(GPIO_FN_SDHI0CLK, NULL);
96987d96f0058d Kuninori Morimoto     2009-10-02  1309  	gpio_request(GPIO_FN_SDHI0D3,  NULL);
96987d96f0058d Kuninori Morimoto     2009-10-02  1310  	gpio_request(GPIO_FN_SDHI0D2,  NULL);
96987d96f0058d Kuninori Morimoto     2009-10-02  1311  	gpio_request(GPIO_FN_SDHI0D1,  NULL);
96987d96f0058d Kuninori Morimoto     2009-10-02  1312  	gpio_request(GPIO_FN_SDHI0D0,  NULL);
1ce4da7a502ea6 Magnus Damm           2009-12-07  1313  #else
1ce4da7a502ea6 Magnus Damm           2009-12-07  1314  	/* enable MSIOF0 on CN11 (needs DS2.4 set to OFF) */
1ce4da7a502ea6 Magnus Damm           2009-12-07  1315  	gpio_request(GPIO_FN_MSIOF0_TXD, NULL);
1ce4da7a502ea6 Magnus Damm           2009-12-07  1316  	gpio_request(GPIO_FN_MSIOF0_RXD, NULL);
1ce4da7a502ea6 Magnus Damm           2009-12-07  1317  	gpio_request(GPIO_FN_MSIOF0_TSCK, NULL);
1ce4da7a502ea6 Magnus Damm           2009-12-07  1318  	gpio_request(GPIO_PTB6, NULL); /* 3.3V power control */
1ce4da7a502ea6 Magnus Damm           2009-12-07  1319  	gpio_direction_output(GPIO_PTB6, 0); /* disable power by default */
1ce4da7a502ea6 Magnus Damm           2009-12-07  1320  
5716fb9bd9c6d3 Linus Walleij         2018-12-02  1321  	gpiod_add_lookup_table(&mmc_spi_gpio_table);
9fda6693335cd5 Geert Uytterhoeven    2019-04-03  1322  	gpiod_add_lookup_table(&msiof_gpio_table);
1ce4da7a502ea6 Magnus Damm           2009-12-07  1323  	spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
1ce4da7a502ea6 Magnus Damm           2009-12-07  1324  #endif
96987d96f0058d Kuninori Morimoto     2009-10-02  1325  
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1326  	/* MMC/SD-card slot CN12 */
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1327  #if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1328  	/* enable MMCIF (needs DS2.6,7 set to OFF,ON) */
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1329  	gpio_request(GPIO_FN_MMC_D7, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1330  	gpio_request(GPIO_FN_MMC_D6, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1331  	gpio_request(GPIO_FN_MMC_D5, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1332  	gpio_request(GPIO_FN_MMC_D4, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1333  	gpio_request(GPIO_FN_MMC_D3, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1334  	gpio_request(GPIO_FN_MMC_D2, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1335  	gpio_request(GPIO_FN_MMC_D1, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1336  	gpio_request(GPIO_FN_MMC_D0, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1337  	gpio_request(GPIO_FN_MMC_CLK, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1338  	gpio_request(GPIO_FN_MMC_CMD, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1339  
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1340  	cn12_enabled = true;
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1341  #elif defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1342  	/* enable SDHI1 on CN12 (needs DS2.6,7 set to ON,OFF) */
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1343  	gpio_request(GPIO_FN_SDHI1WP,  NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1344  	gpio_request(GPIO_FN_SDHI1CMD, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1345  	gpio_request(GPIO_FN_SDHI1CLK, NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1346  	gpio_request(GPIO_FN_SDHI1D3,  NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1347  	gpio_request(GPIO_FN_SDHI1D2,  NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1348  	gpio_request(GPIO_FN_SDHI1D1,  NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1349  	gpio_request(GPIO_FN_SDHI1D0,  NULL);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1350  
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1351  	cn12_enabled = true;
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1352  #endif
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1353  
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1354  	if (cn12_enabled)
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1355  		/* I/O buffer drive ability is high for CN12 */
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1356  		__raw_writew((__raw_readw(IODRIVEA) & ~0x3000) | 0x2000,
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1357  			     IODRIVEA);
4eb80146f8ccd4 Guennadi Liakhovetski 2012-01-28  1358  
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1359  	/* enable FSI */
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1360  	gpio_request(GPIO_FN_FSIMCKB,    NULL);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1361  	gpio_request(GPIO_FN_FSIIBSD,    NULL);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1362  	gpio_request(GPIO_FN_FSIOBSD,    NULL);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1363  	gpio_request(GPIO_FN_FSIIBBCK,   NULL);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1364  	gpio_request(GPIO_FN_FSIIBLRCK,  NULL);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1365  	gpio_request(GPIO_FN_FSIOBBCK,   NULL);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1366  	gpio_request(GPIO_FN_FSIOBLRCK,  NULL);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1367  	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1368  
16afc9fb0298a6 Kuninori Morimoto     2010-02-22  1369  	/* set SPU2 clock to 83.4 MHz */
16afc9fb0298a6 Kuninori Morimoto     2010-02-22  1370  	clk = clk_get(NULL, "spu_clk");
56ea510962ec69 Guennadi Liakhovetski 2010-10-15  1371  	if (!IS_ERR(clk)) {
16afc9fb0298a6 Kuninori Morimoto     2010-02-22  1372  		clk_set_rate(clk, clk_round_rate(clk, 83333333));
16afc9fb0298a6 Kuninori Morimoto     2010-02-22  1373  		clk_put(clk);
103058536300f8 Kuninori Morimoto     2010-05-13  1374  	}
16afc9fb0298a6 Kuninori Morimoto     2010-02-22  1375  
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1376  	/* change parent of FSI B */
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1377  	clk = clk_get(NULL, "fsib_clk");
56ea510962ec69 Guennadi Liakhovetski 2010-10-15  1378  	if (!IS_ERR(clk)) {
4bd5d259e451d3 Kuninori Morimoto     2010-11-26  1379  		/* 48kHz dummy clock was used to make sure 1/1 divide */
4bd5d259e451d3 Kuninori Morimoto     2010-11-26  1380  		clk_set_rate(&sh7724_fsimckb_clk, 48000);
4bd5d259e451d3 Kuninori Morimoto     2010-11-26  1381  		clk_set_parent(clk, &sh7724_fsimckb_clk);
4bd5d259e451d3 Kuninori Morimoto     2010-11-26  1382  		clk_set_rate(clk, 48000);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1383  		clk_put(clk);
103058536300f8 Kuninori Morimoto     2010-05-13  1384  	}
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1385  
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1386  	gpio_request(GPIO_PTU0, NULL);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1387  	gpio_direction_output(GPIO_PTU0, 0);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1388  	mdelay(20);
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1389  
ea440783411840 NISHIMOTO Hiroki      2010-01-15  1390  	/* enable motion sensor */
ea440783411840 NISHIMOTO Hiroki      2010-01-15  1391  	gpio_request(GPIO_FN_INTC_IRQ1, NULL);
ea440783411840 NISHIMOTO Hiroki      2010-01-15  1392  	gpio_direction_input(GPIO_FN_INTC_IRQ1);
ea440783411840 NISHIMOTO Hiroki      2010-01-15  1393  
6f26d19fce5907 Magnus Damm           2010-02-19  1394  	/* set VPU clock to 166 MHz */
6f26d19fce5907 Magnus Damm           2010-02-19  1395  	clk = clk_get(NULL, "vpu_clk");
56ea510962ec69 Guennadi Liakhovetski 2010-10-15  1396  	if (!IS_ERR(clk)) {
6f26d19fce5907 Magnus Damm           2010-02-19  1397  		clk_set_rate(clk, clk_round_rate(clk, 166000000));
6f26d19fce5907 Magnus Damm           2010-02-19  1398  		clk_put(clk);
103058536300f8 Kuninori Morimoto     2010-05-13  1399  	}
6f26d19fce5907 Magnus Damm           2010-02-19  1400  
26365716854907 Kuninori Morimoto     2010-02-24  1401  	/* enable IrDA */
26365716854907 Kuninori Morimoto     2010-02-24  1402  	gpio_request(GPIO_FN_IRDA_OUT, NULL);
26365716854907 Kuninori Morimoto     2010-02-24  1403  	gpio_request(GPIO_FN_IRDA_IN,  NULL);
26365716854907 Kuninori Morimoto     2010-02-24  1404  	gpio_request(GPIO_PTU5, NULL);
26365716854907 Kuninori Morimoto     2010-02-24  1405  	gpio_direction_output(GPIO_PTU5, 0);
26365716854907 Kuninori Morimoto     2010-02-24  1406  
c2f9b05fd5c129 Jacopo Mondi          2018-03-12  1407  	/* Register gpio lookup tables for cameras and video decoder */
c2f9b05fd5c129 Jacopo Mondi          2018-03-12  1408  	gpiod_add_lookup_table(&tw9910_gpios);
c2f9b05fd5c129 Jacopo Mondi          2018-03-12  1409  	gpiod_add_lookup_table(&mt9t112_0_gpios);
c2f9b05fd5c129 Jacopo Mondi          2018-03-12  1410  	gpiod_add_lookup_table(&mt9t112_1_gpios);
c2f9b05fd5c129 Jacopo Mondi          2018-03-12  1411  
125ecce6960e33 Kuninori Morimoto     2009-09-10  1412  	/* enable I2C device */
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1413  	i2c_register_board_info(0, i2c0_devices,
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1414  				ARRAY_SIZE(i2c0_devices));
1980fdc4df4778 Kuninori Morimoto     2009-12-15  1415  
125ecce6960e33 Kuninori Morimoto     2009-09-10  1416  	i2c_register_board_info(1, i2c1_devices,
125ecce6960e33 Kuninori Morimoto     2009-09-10  1417  				ARRAY_SIZE(i2c1_devices));
125ecce6960e33 Kuninori Morimoto     2009-09-10  1418  

:::::: The code at line 1133 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

