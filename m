Return-Path: <linux-kernel+bounces-514373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6226BA35612
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD457A3CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D9189528;
	Fri, 14 Feb 2025 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkahR6HY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF8155756
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510067; cv=none; b=OSIy+4sOl38QgYLsu5dF/MqiufVX1V3JOI3toh7mMv2yyKVpN+03amMbB6jVdz0hDOquZTBSx7SuUV8nSDaZ3bIKQ4VH9xO964aPppTUPQtvlb64YdCfaT5kJ3u9Wy+Mw+/Kg8zVrkjjxJTfWjsjEuxUNBnlEycc64ZNFjJHRSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510067; c=relaxed/simple;
	bh=uuERReMqWC6yJvt46tI66bBz85DpTeNGMmjzJ9UoDmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U/2KPHnX09EmjuZdtSBSQRPQcrkILDOUrT/ltL4TRhe1aupH4xsgwHSCO4/zwMVvpfF6PDhcgXttoG3ghBR2xM1xqgjbbGIasPP1YrkijbqI4aAtKfzDF8bHdD2XMFtbp2MPi/DtgiTMmZooHkH8XbmSohooQbcy9WAsWqhUIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkahR6HY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739510064; x=1771046064;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uuERReMqWC6yJvt46tI66bBz85DpTeNGMmjzJ9UoDmA=;
  b=MkahR6HYh9YU0uvbWNwHZ05990MT02aMPtV/yxtSGym42o6ZM33xdLvj
   FSktieGhKoOj/IiWbgBLgdIoQzAimuhK7WPUxb9IVnSWwv7efZTkkO17v
   0WBZKyJwIqfmeIqtxHHuXPbNo5a9ccTx++M0uk1zXRZBQSbTRIuvtUkO9
   nHZqoizF6NL5cpKRuzh/NsKdzvW/OSztGk711kVsL3eJLi06qoX0pNuJH
   40qNLejMtmt+wQHdreh/k7xc0rSsPDWDWKoSflM4huqJXwVkheaGGEHIs
   QHx5vavFyAnJu5k34rnUmnx+HbNlxjM6QBiZijHXipJYqu5bANrLQHBIE
   g==;
X-CSE-ConnectionGUID: A/oA5TxmQq6CeLhpR8UYAQ==
X-CSE-MsgGUID: Xj0EspD+RduIp8R1haJ0iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65599671"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="65599671"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 21:14:21 -0800
X-CSE-ConnectionGUID: YWSLBOGcRbCHWGXbvSxPdg==
X-CSE-MsgGUID: /Co5VkUUTdSbpGH/vIgFQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113851879"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Feb 2025 21:14:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tio1n-00195n-1V;
	Fri, 14 Feb 2025 05:14:15 +0000
Date: Fri, 14 Feb 2025 13:13:24 +0800
From: kernel test robot <lkp@intel.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: drivers/clk/clk-cdce925.c:717:41: warning: '%d' directive writing
 between 1 and 11 bytes into a region of size 3
Message-ID: <202502141317.dff4QeXn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   128c8f96eb8638c060cd3532dc394d046ce64fe1
commit: bbd7ffdbef6888459f301c5889f3b14ada38b913 clk: Allow the common clk framework to be selectable
date:   4 years, 9 months ago
config: x86_64-buildonly-randconfig-r001-20230529 (https://download.01.org/0day-ci/archive/20250214/202502141317.dff4QeXn-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502141317.dff4QeXn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502141317.dff4QeXn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/clk-cdce925.c: In function 'cdce925_probe':
>> drivers/clk/clk-cdce925.c:717:41: warning: '%d' directive writing between 1 and 11 bytes into a region of size 3 [-Wformat-overflow=]
     717 |                 sprintf(child_name, "PLL%d", i+1);
         |                                         ^~
   drivers/clk/clk-cdce925.c:717:37: note: directive argument in the range [-2147483642, 2147483647]
     717 |                 sprintf(child_name, "PLL%d", i+1);
         |                                     ^~~~~~~
   drivers/clk/clk-cdce925.c:717:17: note: 'sprintf' output between 5 and 15 bytes into a destination of size 6
     717 |                 sprintf(child_name, "PLL%d", i+1);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +717 drivers/clk/clk-cdce925.c

19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  636  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  637  static int cdce925_probe(struct i2c_client *client,
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  638  		const struct i2c_device_id *id)
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  639  {
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  640  	struct clk_cdce925_chip *data;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  641  	struct device_node *node = client->dev.of_node;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  642  	const char *parent_name;
5508124cccb8bd7 Akinobu Mita       2017-01-01  643  	const char *pll_clk_name[MAX_NUMBER_OF_PLLS] = {NULL,};
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  644  	struct clk_init_data init;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  645  	u32 value;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  646  	int i;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  647  	int err;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  648  	struct device_node *np_output;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  649  	char child_name[6];
5508124cccb8bd7 Akinobu Mita       2017-01-01  650  	struct regmap_config config = {
5508124cccb8bd7 Akinobu Mita       2017-01-01  651  		.name = "configuration0",
5508124cccb8bd7 Akinobu Mita       2017-01-01  652  		.reg_bits = 8,
5508124cccb8bd7 Akinobu Mita       2017-01-01  653  		.val_bits = 8,
5508124cccb8bd7 Akinobu Mita       2017-01-01  654  		.cache_type = REGCACHE_RBTREE,
5508124cccb8bd7 Akinobu Mita       2017-01-01  655  	};
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  656  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  657  	dev_dbg(&client->dev, "%s\n", __func__);
d69d0b4384ba803 Phil Reid          2019-06-28  658  
d69d0b4384ba803 Phil Reid          2019-06-28  659  	err = cdce925_regulator_enable(&client->dev, "vdd");
d69d0b4384ba803 Phil Reid          2019-06-28  660  	if (err)
d69d0b4384ba803 Phil Reid          2019-06-28  661  		return err;
d69d0b4384ba803 Phil Reid          2019-06-28  662  
d69d0b4384ba803 Phil Reid          2019-06-28  663  	err = cdce925_regulator_enable(&client->dev, "vddout");
d69d0b4384ba803 Phil Reid          2019-06-28  664  	if (err)
d69d0b4384ba803 Phil Reid          2019-06-28  665  		return err;
d69d0b4384ba803 Phil Reid          2019-06-28  666  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  667  	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  668  	if (!data)
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  669  		return -ENOMEM;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  670  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  671  	data->i2c_client = client;
5508124cccb8bd7 Akinobu Mita       2017-01-01  672  	data->chip_info = &clk_cdce925_chip_info_tbl[id->driver_data];
5508124cccb8bd7 Akinobu Mita       2017-01-01  673  	config.max_register = CDCE925_OFFSET_PLL +
5508124cccb8bd7 Akinobu Mita       2017-01-01  674  		data->chip_info->num_plls * 0x10 - 1;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  675  	data->regmap = devm_regmap_init(&client->dev, &regmap_cdce925_bus,
5508124cccb8bd7 Akinobu Mita       2017-01-01  676  			&client->dev, &config);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  677  	if (IS_ERR(data->regmap)) {
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  678  		dev_err(&client->dev, "failed to allocate register map\n");
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  679  		return PTR_ERR(data->regmap);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  680  	}
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  681  	i2c_set_clientdata(client, data);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  682  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  683  	parent_name = of_clk_get_parent_name(node, 0);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  684  	if (!parent_name) {
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  685  		dev_err(&client->dev, "missing parent clock\n");
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  686  		return -ENODEV;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  687  	}
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  688  	dev_dbg(&client->dev, "parent is: %s\n", parent_name);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  689  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  690  	if (of_property_read_u32(node, "xtal-load-pf", &value) == 0)
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  691  		regmap_write(data->regmap,
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  692  			CDCE925_REG_XCSEL, (value << 3) & 0xF8);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  693  	/* PWDN bit */
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  694  	regmap_update_bits(data->regmap, CDCE925_REG_GLOBAL1, BIT(4), 0);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  695  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  696  	/* Set input source for Y1 to be the XTAL */
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  697  	regmap_update_bits(data->regmap, 0x02, BIT(7), 0);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  698  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  699  	init.ops = &cdce925_pll_ops;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  700  	init.flags = 0;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  701  	init.parent_names = &parent_name;
9416a5f8842a37d Colin Ian King     2017-09-05  702  	init.num_parents = 1;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  703  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  704  	/* Register PLL clocks */
5508124cccb8bd7 Akinobu Mita       2017-01-01  705  	for (i = 0; i < data->chip_info->num_plls; ++i) {
e665f029a283aff Rob Herring        2018-08-28  706  		pll_clk_name[i] = kasprintf(GFP_KERNEL, "%pOFn.pll%d",
e665f029a283aff Rob Herring        2018-08-28  707  			client->dev.of_node, i);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  708  		init.name = pll_clk_name[i];
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  709  		data->pll[i].chip = data;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  710  		data->pll[i].hw.init = &init;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  711  		data->pll[i].index = i;
a85d11712dd13fc Stephen Boyd       2016-06-01  712  		err = devm_clk_hw_register(&client->dev, &data->pll[i].hw);
a85d11712dd13fc Stephen Boyd       2016-06-01  713  		if (err) {
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  714  			dev_err(&client->dev, "Failed register PLL %d\n", i);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  715  			goto error;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  716  		}
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03 @717  		sprintf(child_name, "PLL%d", i+1);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  718  		np_output = of_get_child_by_name(node, child_name);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  719  		if (!np_output)
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  720  			continue;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  721  		if (!of_property_read_u32(np_output,
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  722  			"clock-frequency", &value)) {
a85d11712dd13fc Stephen Boyd       2016-06-01  723  			err = clk_set_rate(data->pll[i].hw.clk, value);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  724  			if (err)
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  725  				dev_err(&client->dev,
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  726  					"unable to set PLL frequency %ud\n",
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  727  					value);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  728  		}
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  729  		if (!of_property_read_u32(np_output,
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  730  			"spread-spectrum", &value)) {
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  731  			u8 flag = of_property_read_bool(np_output,
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  732  				"spread-spectrum-center") ? 0x80 : 0x00;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  733  			regmap_update_bits(data->regmap,
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  734  				0x16 + (i*CDCE925_OFFSET_PLL),
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  735  				0x80, flag);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  736  			regmap_update_bits(data->regmap,
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  737  				0x12 + (i*CDCE925_OFFSET_PLL),
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  738  				0x07, value & 0x07);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  739  		}
0b85de7cef013ee Alexey Khoroshilov 2018-08-22  740  		of_node_put(np_output);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  741  	}
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  742  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  743  	/* Register output clock Y1 */
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  744  	init.ops = &cdce925_clk_y1_ops;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  745  	init.flags = 0;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  746  	init.num_parents = 1;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  747  	init.parent_names = &parent_name; /* Mux Y1 to input */
e665f029a283aff Rob Herring        2018-08-28  748  	init.name = kasprintf(GFP_KERNEL, "%pOFn.Y1", client->dev.of_node);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  749  	data->clk[0].chip = data;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  750  	data->clk[0].hw.init = &init;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  751  	data->clk[0].index = 0;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  752  	data->clk[0].pdiv = 1;
a85d11712dd13fc Stephen Boyd       2016-06-01  753  	err = devm_clk_hw_register(&client->dev, &data->clk[0].hw);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  754  	kfree(init.name); /* clock framework made a copy of the name */
a85d11712dd13fc Stephen Boyd       2016-06-01  755  	if (err) {
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  756  		dev_err(&client->dev, "clock registration Y1 failed\n");
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  757  		goto error;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  758  	}
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  759  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  760  	/* Register output clocks Y2 .. Y5*/
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  761  	init.ops = &cdce925_clk_ops;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  762  	init.flags = CLK_SET_RATE_PARENT;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  763  	init.num_parents = 1;
5508124cccb8bd7 Akinobu Mita       2017-01-01  764  	for (i = 1; i < data->chip_info->num_outputs; ++i) {
e665f029a283aff Rob Herring        2018-08-28  765  		init.name = kasprintf(GFP_KERNEL, "%pOFn.Y%d",
e665f029a283aff Rob Herring        2018-08-28  766  			client->dev.of_node, i+1);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  767  		data->clk[i].chip = data;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  768  		data->clk[i].hw.init = &init;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  769  		data->clk[i].index = i;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  770  		data->clk[i].pdiv = 1;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  771  		switch (i) {
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  772  		case 1:
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  773  		case 2:
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  774  			/* Mux Y2/3 to PLL1 */
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  775  			init.parent_names = &pll_clk_name[0];
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  776  			break;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  777  		case 3:
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  778  		case 4:
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  779  			/* Mux Y4/5 to PLL2 */
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  780  			init.parent_names = &pll_clk_name[1];
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  781  			break;
5508124cccb8bd7 Akinobu Mita       2017-01-01  782  		case 5:
5508124cccb8bd7 Akinobu Mita       2017-01-01  783  		case 6:
5508124cccb8bd7 Akinobu Mita       2017-01-01  784  			/* Mux Y6/7 to PLL3 */
5508124cccb8bd7 Akinobu Mita       2017-01-01  785  			init.parent_names = &pll_clk_name[2];
5508124cccb8bd7 Akinobu Mita       2017-01-01  786  			break;
5508124cccb8bd7 Akinobu Mita       2017-01-01  787  		case 7:
5508124cccb8bd7 Akinobu Mita       2017-01-01  788  		case 8:
5508124cccb8bd7 Akinobu Mita       2017-01-01  789  			/* Mux Y8/9 to PLL4 */
5508124cccb8bd7 Akinobu Mita       2017-01-01  790  			init.parent_names = &pll_clk_name[3];
5508124cccb8bd7 Akinobu Mita       2017-01-01  791  			break;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  792  		}
a85d11712dd13fc Stephen Boyd       2016-06-01  793  		err = devm_clk_hw_register(&client->dev, &data->clk[i].hw);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  794  		kfree(init.name); /* clock framework made a copy of the name */
a85d11712dd13fc Stephen Boyd       2016-06-01  795  		if (err) {
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  796  			dev_err(&client->dev, "clock registration failed\n");
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  797  			goto error;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  798  		}
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  799  	}
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  800  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  801  	/* Register the output clocks */
a85d11712dd13fc Stephen Boyd       2016-06-01  802  	err = of_clk_add_hw_provider(client->dev.of_node, of_clk_cdce925_get,
a85d11712dd13fc Stephen Boyd       2016-06-01  803  				  data);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  804  	if (err)
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  805  		dev_err(&client->dev, "unable to add OF clock provider\n");
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  806  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  807  	err = 0;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  808  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  809  error:
5508124cccb8bd7 Akinobu Mita       2017-01-01  810  	for (i = 0; i < data->chip_info->num_plls; ++i)
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  811  		/* clock framework made a copy of the name */
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  812  		kfree(pll_clk_name[i]);
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  813  
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  814  	return err;
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  815  }
19fbbbbcd3a3a8e Mike Looijmans     2015-06-03  816  

:::::: The code at line 717 was first introduced by commit
:::::: 19fbbbbcd3a3a8e307a4768784166abf7b55b779 Add TI CDCE925 I2C controlled clock synthesizer driver

:::::: TO: Mike Looijmans <mike.looijmans@topic.nl>
:::::: CC: Michael Turquette <mturquette@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

