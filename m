Return-Path: <linux-kernel+bounces-339553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845629866CF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77FD1C215BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E08145335;
	Wed, 25 Sep 2024 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfLeg7fw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E31428F1;
	Wed, 25 Sep 2024 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727292160; cv=none; b=h+p/xCquqMjOeOuHF8qLOXHJVlYXlTv7pEfinjKriYq9xB1i/96aLg/QNOySBXbq4HpB8PtMZcScLwK92enJFrRHAk5FtS+YXrM6+zyviIvMO4/hw17bs3H6MZiz56vNa4FM6xk3P5+0AAhsDWkUFfAxJtIon2zxzGJnrMe2O7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727292160; c=relaxed/simple;
	bh=S0urNNv3r0yAEJslZ4kLYfAM0lYjoGfeqneTwEkgSqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2BMBE+DFr62p9t7Hxcodch/fBo279Bj8DKNka7JTHe25w368o9Xh2dUXYri7y8iQtyAe4IQBHfzfF/B6FMs8DuXq3dpPXzFH9ymmDH5vzYBvINX1qToOAUofaxJjwh6UwrnkiI7DwDR8TPj95EbD+l086CKNOwNMD7/ypb4Qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfLeg7fw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727292158; x=1758828158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0urNNv3r0yAEJslZ4kLYfAM0lYjoGfeqneTwEkgSqA=;
  b=NfLeg7fw2QyQIPLPItX24v6l6nFRkftPwW87+j4qu7u8IyYr5XBUmwWo
   /q8aUcQR19kSKP3bUmFb+U2WnXi/VbE4Jdh0bxkAsUjU8LQG+q61eyh/8
   4ILhThoSKRuxoEw7+EqM1vC2VaXpA4Sz4i0DqoUh7DtO+r27bEvGeXsms
   YsV66weeJnY7oRyR8QGwObvaPN9MXbtgDyB8hQ7/3JdruioJoXHTHeeb9
   oaPGjt59sK6Pg/lJTZ8fCboTHcf+Nl9rkCCAWUJSgkeWTRywxtQJfTSHP
   +/dZIRK1mzxg5s4acR3Nou9BcIPpjmLaTrkpcqsWa/t8ngaLvvoQnrmXE
   w==;
X-CSE-ConnectionGUID: TRvrs5/FTbOz0lH7pQDGEg==
X-CSE-MsgGUID: ineW/4EKQNWIMJazCNXKag==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37038047"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="37038047"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 12:22:37 -0700
X-CSE-ConnectionGUID: 89qIKqssR/OJ8tdOF/G8Ew==
X-CSE-MsgGUID: eD+PAUJIRDuarBhelvaQFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="76395509"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Sep 2024 12:22:35 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stXaq-000Ju7-2K;
	Wed, 25 Sep 2024 19:22:32 +0000
Date: Thu, 26 Sep 2024 03:22:30 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] usb: typec: stusb160x: Make use of
 i2c_get_match_data()
Message-ID: <202409260206.UbcSQv4S-lkp@intel.com>
References: <20240925133952.1067949-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925133952.1067949-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.11 next-20240925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/usb-typec-stusb160x-Make-use-of-i2c_get_match_data/20240925-223551
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240925133952.1067949-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] usb: typec: stusb160x: Make use of i2c_get_match_data()
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240926/202409260206.UbcSQv4S-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409260206.UbcSQv4S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409260206.UbcSQv4S-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/typec/stusb160x.c: In function 'stusb160x_probe':
>> drivers/usb/typec/stusb160x.c:647:44: error: passing argument 1 of 'i2c_get_match_data' from incompatible pointer type [-Wincompatible-pointer-types]
     647 |         regmap_config = i2c_get_match_data(&client->dev);
         |                                            ^~~~~~~~~~~~
         |                                            |
         |                                            struct device *
   In file included from drivers/usb/typec/stusb160x.c:10:
   include/linux/i2c.h:360:57: note: expected 'const struct i2c_client *' but argument is of type 'struct device *'
     360 | const void *i2c_get_match_data(const struct i2c_client *client);
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~


vim +/i2c_get_match_data +647 drivers/usb/typec/stusb160x.c

   633	
   634	static int stusb160x_probe(struct i2c_client *client)
   635	{
   636		const struct regmap_config *regmap_config;
   637		struct stusb160x *chip;
   638		struct fwnode_handle *fwnode;
   639		int ret;
   640	
   641		chip = devm_kzalloc(&client->dev, sizeof(struct stusb160x), GFP_KERNEL);
   642		if (!chip)
   643			return -ENOMEM;
   644	
   645		i2c_set_clientdata(client, chip);
   646	
 > 647		regmap_config = i2c_get_match_data(&client->dev);
   648	
   649		chip->regmap = devm_regmap_init_i2c(client, regmap_config);
   650		if (IS_ERR(chip->regmap)) {
   651			ret = PTR_ERR(chip->regmap);
   652			dev_err(&client->dev,
   653				"Failed to allocate register map:%d\n", ret);
   654			return ret;
   655		}
   656	
   657		chip->dev = &client->dev;
   658	
   659		chip->vsys_supply = devm_regulator_get_optional(chip->dev, "vsys");
   660		if (IS_ERR(chip->vsys_supply)) {
   661			ret = PTR_ERR(chip->vsys_supply);
   662			if (ret != -ENODEV)
   663				return ret;
   664			chip->vsys_supply = NULL;
   665		}
   666	
   667		chip->vdd_supply = devm_regulator_get_optional(chip->dev, "vdd");
   668		if (IS_ERR(chip->vdd_supply)) {
   669			ret = PTR_ERR(chip->vdd_supply);
   670			if (ret != -ENODEV)
   671				return ret;
   672			chip->vdd_supply = NULL;
   673		}
   674	
   675		chip->vconn_supply = devm_regulator_get_optional(chip->dev, "vconn");
   676		if (IS_ERR(chip->vconn_supply)) {
   677			ret = PTR_ERR(chip->vconn_supply);
   678			if (ret != -ENODEV)
   679				return ret;
   680			chip->vconn_supply = NULL;
   681		}
   682	
   683		fwnode = device_get_named_child_node(chip->dev, "connector");
   684		if (!fwnode)
   685			return -ENODEV;
   686	
   687		/*
   688		 * This fwnode has a "compatible" property, but is never populated as a
   689		 * struct device. Instead we simply parse it to read the properties.
   690		 * This it breaks fw_devlink=on. To maintain backward compatibility
   691		 * with existing DT files, we work around this by deleting any
   692		 * fwnode_links to/from this fwnode.
   693		 */
   694		fw_devlink_purge_absent_suppliers(fwnode);
   695	
   696		/*
   697		 * When both VDD and VSYS power supplies are present, the low power
   698		 * supply VSYS is selected when VSYS voltage is above 3.1 V.
   699		 * Otherwise VDD is selected.
   700		 */
   701		if (chip->vdd_supply &&
   702		    (!chip->vsys_supply ||
   703		     (regulator_get_voltage(chip->vsys_supply) <= 3100000)))
   704			chip->main_supply = chip->vdd_supply;
   705		else
   706			chip->main_supply = chip->vsys_supply;
   707	
   708		if (chip->main_supply) {
   709			ret = regulator_enable(chip->main_supply);
   710			if (ret) {
   711				dev_err(chip->dev,
   712					"Failed to enable main supply: %d\n", ret);
   713				goto fwnode_put;
   714			}
   715		}
   716	
   717		/* Get configuration from chip */
   718		ret = stusb160x_get_caps(chip);
   719		if (ret) {
   720			dev_err(chip->dev, "Failed to get port caps: %d\n", ret);
   721			goto main_reg_disable;
   722		}
   723	
   724		/* Get optional re-configuration from device tree */
   725		ret = stusb160x_get_fw_caps(chip, fwnode);
   726		if (ret) {
   727			dev_err(chip->dev, "Failed to get connector caps: %d\n", ret);
   728			goto main_reg_disable;
   729		}
   730	
   731		ret = stusb160x_chip_init(chip);
   732		if (ret) {
   733			dev_err(chip->dev, "Failed to init port: %d\n", ret);
   734			goto main_reg_disable;
   735		}
   736	
   737		chip->port = typec_register_port(chip->dev, &chip->capability);
   738		if (IS_ERR(chip->port)) {
   739			ret = PTR_ERR(chip->port);
   740			goto all_reg_disable;
   741		}
   742	
   743		/*
   744		 * Default power operation mode initialization: will be updated upon
   745		 * attach/detach interrupt
   746		 */
   747		typec_set_pwr_opmode(chip->port, chip->pwr_opmode);
   748	
   749		if (client->irq) {
   750			chip->role_sw = fwnode_usb_role_switch_get(fwnode);
   751			if (IS_ERR(chip->role_sw)) {
   752				ret = dev_err_probe(chip->dev, PTR_ERR(chip->role_sw),
   753						    "Failed to get usb role switch\n");
   754				goto port_unregister;
   755			}
   756	
   757			ret = stusb160x_irq_init(chip, client->irq);
   758			if (ret)
   759				goto role_sw_put;
   760		} else {
   761			/*
   762			 * If Source or Dual power role, need to enable VDD supply
   763			 * providing Vbus if present. In case of interrupt support,
   764			 * VDD supply will be dynamically managed upon attach/detach
   765			 * interrupt.
   766			 */
   767			if (chip->port_type != TYPEC_PORT_SNK && chip->vdd_supply) {
   768				ret = regulator_enable(chip->vdd_supply);
   769				if (ret) {
   770					dev_err(chip->dev,
   771						"Failed to enable VDD supply: %d\n",
   772						ret);
   773					goto port_unregister;
   774				}
   775				chip->vbus_on = true;
   776			}
   777		}
   778	
   779		fwnode_handle_put(fwnode);
   780	
   781		return 0;
   782	
   783	role_sw_put:
   784		if (chip->role_sw)
   785			usb_role_switch_put(chip->role_sw);
   786	port_unregister:
   787		typec_unregister_port(chip->port);
   788	all_reg_disable:
   789		if (stusb160x_get_vconn(chip))
   790			stusb160x_set_vconn(chip, false);
   791	main_reg_disable:
   792		if (chip->main_supply)
   793			regulator_disable(chip->main_supply);
   794	fwnode_put:
   795		fwnode_handle_put(fwnode);
   796	
   797		return ret;
   798	}
   799	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

