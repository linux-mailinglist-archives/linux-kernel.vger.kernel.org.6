Return-Path: <linux-kernel+bounces-305764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B59633F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4906A1C21109
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49741AB528;
	Wed, 28 Aug 2024 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZiV23sBK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C51AB512
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880875; cv=none; b=LjeoCWQKv1awLYXtdl5e3z1UKwR+aqnE8zbb0vJXcI3kkzcCAWCRK00UYcEA6+qFdeTcZMzIDDjK7Yh8NtyEKQb8FjXdn18V5M8YJ/eBmMoAR2KcbHbmUoFJ0MacPYsa9phvfAGLkXotUxD/KBXUm8Z4/Zj0SUcjq5asLHTWQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880875; c=relaxed/simple;
	bh=K3TVhqZD2LoGcgSX+U5ogY05EldIfQxSAnnsOGx6PkA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RnOzNEwX8KfyHk1bkZKU7Co30+p5eN6Xe7eaAsRRAEyVtbi6TVPZvc/ZPhfAVcgDzm1LTEsBHqBrOvUYnSv3GcXIxgm7FP5uoArosp+WjDyH1/bWuWXXIFRxGKCUyMiywtFrUUWGl+pXluUOjAum9VirE9Y/e57Iv4YZEa+2ArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZiV23sBK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724880873; x=1756416873;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K3TVhqZD2LoGcgSX+U5ogY05EldIfQxSAnnsOGx6PkA=;
  b=ZiV23sBKIX3vMPsvsqwiFvQcwUDs2McZW410zf74EygOICodt9iFr5c0
   hb5DAeT9qM0C7XlVAWxyS+s3V16MWbysQlg8h90+kx1rGJ19T0F7lHxHe
   9A3P5Voq2zdADROCD3baaV8Rd0DCXS6z4VWTmEhH80zP0/IVPVwZcusKR
   7Z4Kd7EkQjIMDXxPqj4vDczNHWUV32klRqfeAFF6bR4TijmWdM4ui/YxK
   6HwtRx8cmB81hZ072gifCTvygAfRe+8OBPTjDP0kQooyCdBqteD0mJ+g9
   LoZPiM0gqwp2WqUHOhv0b+QFUhCmIsCit7a/B2R4Q2Vepew8ziBRSS2VV
   g==;
X-CSE-ConnectionGUID: ibOGAwZmRAGiRhTNvN0lpw==
X-CSE-MsgGUID: 91R1n+ljTtK4p/gkbwqYCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23401642"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23401642"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 14:34:33 -0700
X-CSE-ConnectionGUID: LWbMWIouSyaxu5BlnjfGHA==
X-CSE-MsgGUID: B0Mf3IWjTNeYzdOVQs5q5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63425650"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 28 Aug 2024 14:34:31 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjQJB-000LNs-09;
	Wed, 28 Aug 2024 21:34:29 +0000
Date: Thu, 29 Aug 2024 05:34:10 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/net/dsa/realtek/rtl8366rb.c:953:undefined reference to
 `led_init_default_state_get'
Message-ID: <202408290528.lIGXaLsw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luiz,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   928f79a188aacc057ba36c85b36b6d1e99c8f595
commit: 32d617005475a71ebcc4ec8b2791e8d1481e9a10 net: dsa: realtek: add LED drivers for rtl8366rb
date:   4 months ago
config: nios2-randconfig-002-20240828 (https://download.01.org/0day-ci/archive/20240829/202408290528.lIGXaLsw-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408290528.lIGXaLsw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408290528.lIGXaLsw-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/net/dsa/realtek/rtl8366rb.o: in function `rtl8366rb_setup_led':
>> drivers/net/dsa/realtek/rtl8366rb.c:953:(.text.unlikely+0x3ec): undefined reference to `led_init_default_state_get'
>> drivers/net/dsa/realtek/rtl8366rb.c:953:(.text.unlikely+0x3ec): relocation truncated to fit: R_NIOS2_CALL26 against `led_init_default_state_get'
>> nios2-linux-ld: drivers/net/dsa/realtek/rtl8366rb.c:980:(.text.unlikely+0x52c): undefined reference to `devm_led_classdev_register_ext'
>> drivers/net/dsa/realtek/rtl8366rb.c:980:(.text.unlikely+0x52c): relocation truncated to fit: R_NIOS2_CALL26 against `devm_led_classdev_register_ext'


vim +953 drivers/net/dsa/realtek/rtl8366rb.c

   927	
   928	static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
   929				       struct fwnode_handle *led_fwnode)
   930	{
   931		struct rtl8366rb *rb = priv->chip_data;
   932		struct led_init_data init_data = { };
   933		enum led_default_state state;
   934		struct rtl8366rb_led *led;
   935		u32 led_group;
   936		int ret;
   937	
   938		ret = fwnode_property_read_u32(led_fwnode, "reg", &led_group);
   939		if (ret)
   940			return ret;
   941	
   942		if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
   943			dev_warn(priv->dev, "Invalid LED reg %d defined for port %d",
   944				 led_group, dp->index);
   945			return -EINVAL;
   946		}
   947	
   948		led = &rb->leds[dp->index][led_group];
   949		led->port_num = dp->index;
   950		led->led_group = led_group;
   951		led->priv = priv;
   952	
 > 953		state = led_init_default_state_get(led_fwnode);
   954		switch (state) {
   955		case LEDS_DEFSTATE_ON:
   956			led->cdev.brightness = 1;
   957			rb8366rb_set_port_led(led, 1);
   958			break;
   959		case LEDS_DEFSTATE_KEEP:
   960			led->cdev.brightness =
   961				rb8366rb_get_port_led(led);
   962			break;
   963		case LEDS_DEFSTATE_OFF:
   964		default:
   965			led->cdev.brightness = 0;
   966			rb8366rb_set_port_led(led, 0);
   967		}
   968	
   969		led->cdev.max_brightness = 1;
   970		led->cdev.brightness_set_blocking =
   971			rtl8366rb_cled_brightness_set_blocking;
   972		init_data.fwnode = led_fwnode;
   973		init_data.devname_mandatory = true;
   974	
   975		init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
   976						 dp->ds->index, dp->index, led_group);
   977		if (!init_data.devicename)
   978			return -ENOMEM;
   979	
 > 980		ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
   981		if (ret) {
   982			dev_warn(priv->dev, "Failed to init LED %d for port %d",
   983				 led_group, dp->index);
   984			return ret;
   985		}
   986	
   987		return 0;
   988	}
   989	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

