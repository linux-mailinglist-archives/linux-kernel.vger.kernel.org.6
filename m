Return-Path: <linux-kernel+bounces-221852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F17290F96D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541A21F237B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4E415A87D;
	Wed, 19 Jun 2024 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azEIq9VU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09891763EE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837522; cv=none; b=ug4Xc+w1NtFE/bN/kI140gUntnWmx0TwGeXOBmey3BNzl66V0oRfQiGsu7NFamBsfD3JDI7ivxAPUObEgzCHUrg3WlfEKmVZVOBT1vq9+0v9/WKA23hdJ73xJL1b4tiCdOsXrHY+3/YQ5cu2b79opO0H640+yRJMNE3dK6IGZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837522; c=relaxed/simple;
	bh=hz/Ub6qykNJpOqlQI49DPOFgZluMHHDpuTsjeBK0Xws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UgGbF+f6DURquTsq4sXxFzXsVHU+Rfm+oAaVc83cKZhDsFZXQN15ALdoyKphBzKzfy8VEBxmNDc99UGYlFMDoHr5f2evET7c3jwTQNk+BX6uqqhKoJW9jC37efT2FBm0/RhH/K0easxN2cMBsczWKOiKeu/XdtYfUv2XpGQTQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azEIq9VU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718837520; x=1750373520;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hz/Ub6qykNJpOqlQI49DPOFgZluMHHDpuTsjeBK0Xws=;
  b=azEIq9VUS/goHrJLmZULmqSdXFrJV+m3Apzdo4kRbFrH4LdxRA3f+J36
   c7HGEVhQLnGFbakz30Nu70AAP5+OG8CnaWRhnVgeqqIhK0t4k92E3xMN+
   7ygSPws8Am36jUCJBDEEdT7Bvxlx4CdCHbbKDK+KOk2ibBDv4fOYd2rAl
   POAyihdNFpVjEYw/kZWylVCZWnFnNgiBHzxITtXrXjwOvl9oMYW3v5pz3
   FfmZ3Hu4D3KZLNmhLd+bw3FECKzjmF8D7PhnYj+yS4v2ar7/Hi41KdIhB
   UeglJ0HbZjTTbZIrH6dKf3OYPiRTiEEQHRVMsvSX6i3PN6QbewfQpv96C
   g==;
X-CSE-ConnectionGUID: kOtJ1yMfRya4IQqsffOZbA==
X-CSE-MsgGUID: H6mEbtIlTV2LnORU8Jk2WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="27201114"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="27201114"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 15:51:59 -0700
X-CSE-ConnectionGUID: JbWlesIzT/ispUxzLZmsvA==
X-CSE-MsgGUID: 1nxtQMcrQgG7sDCCXs4Q+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="41899359"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2024 15:51:58 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK49j-00074c-37;
	Wed, 19 Jun 2024 22:51:55 +0000
Date: Thu, 20 Jun 2024 06:51:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: drivers/net/pse-pd/pd692x0.c:1193:undefined reference to
 `firmware_upload_unregister'
Message-ID: <202406200632.hSChnX0g-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5b3efbe1ab1793bb49ae07d56d0973267e65112
commit: 9a993845189004a923b78d0df643e47970147337 net: pse-pd: Add PD692x0 PSE controller driver
date:   9 weeks ago
config: i386-randconfig-006-20240620 (https://download.01.org/0day-ci/archive/20240620/202406200632.hSChnX0g-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406200632.hSChnX0g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406200632.hSChnX0g-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/net/pse-pd/pd692x0.o: in function `pd692x0_i2c_remove':
>> drivers/net/pse-pd/pd692x0.c:1193:(.text+0x26): undefined reference to `firmware_upload_unregister'
   ld: drivers/net/pse-pd/pd692x0.o: in function `pd692x0_i2c_probe':
>> drivers/net/pse-pd/pd692x0.c:1179:(.text+0x1148): undefined reference to `firmware_upload_register'


vim +1193 drivers/net/pse-pd/pd692x0.c

  1108	
  1109	static int pd692x0_i2c_probe(struct i2c_client *client)
  1110	{
  1111		struct pd692x0_msg msg, buf = {0}, zero = {0};
  1112		struct device *dev = &client->dev;
  1113		struct pd692x0_msg_ver ver;
  1114		struct pd692x0_priv *priv;
  1115		struct fw_upload *fwl;
  1116		int ret;
  1117	
  1118		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
  1119			dev_err(dev, "i2c check functionality failed\n");
  1120			return -ENXIO;
  1121		}
  1122	
  1123		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
  1124		if (!priv)
  1125			return -ENOMEM;
  1126	
  1127		priv->client = client;
  1128		i2c_set_clientdata(client, priv);
  1129	
  1130		ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
  1131		if (ret != sizeof(buf)) {
  1132			dev_err(dev, "Failed to get device status\n");
  1133			return -EIO;
  1134		}
  1135	
  1136		/* Probe has been already run and the status dumped */
  1137		if (!memcmp(&buf, &zero, sizeof(buf))) {
  1138			/* Ask again the controller status */
  1139			msg = pd692x0_msg_template_list[PD692X0_MSG_GET_SYS_STATUS];
  1140			ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
  1141			if (ret < 0) {
  1142				dev_err(dev, "Failed to get device status\n");
  1143				return ret;
  1144			}
  1145		}
  1146	
  1147		if (buf.key != 0x03 || buf.sub[0] & 0x01) {
  1148			dev_err(dev, "PSE controller error\n");
  1149			return -EIO;
  1150		}
  1151		if (buf.sub[0] & 0x02) {
  1152			dev_err(dev, "PSE firmware error. Please update it.\n");
  1153			priv->fw_state = PD692X0_FW_BROKEN;
  1154		} else {
  1155			ver = pd692x0_get_sw_version(priv);
  1156			dev_info(&client->dev, "Software version %d.%02d.%d.%d\n",
  1157				 ver.prod, ver.maj_sw_ver, ver.min_sw_ver,
  1158				 ver.pa_sw_ver);
  1159	
  1160			if (ver.maj_sw_ver < PD692X0_FW_MAJ_VER) {
  1161				dev_err(dev, "Too old firmware version. Please update it\n");
  1162				priv->fw_state = PD692X0_FW_NEED_UPDATE;
  1163			} else {
  1164				priv->fw_state = PD692X0_FW_OK;
  1165			}
  1166		}
  1167	
  1168		priv->np = dev->of_node;
  1169		priv->pcdev.nr_lines = PD692X0_MAX_PIS;
  1170		priv->pcdev.owner = THIS_MODULE;
  1171		priv->pcdev.ops = &pd692x0_ops;
  1172		priv->pcdev.dev = dev;
  1173		priv->pcdev.types = ETHTOOL_PSE_C33;
  1174		ret = devm_pse_controller_register(dev, &priv->pcdev);
  1175		if (ret)
  1176			return dev_err_probe(dev, ret,
  1177					     "failed to register PSE controller\n");
  1178	
> 1179		fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
  1180					       &pd692x0_fw_ops, priv);
  1181		if (IS_ERR(fwl))
  1182			return dev_err_probe(dev, PTR_ERR(fwl),
  1183					     "failed to register to the Firmware Upload API\n");
  1184		priv->fwl = fwl;
  1185	
  1186		return 0;
  1187	}
  1188	
  1189	static void pd692x0_i2c_remove(struct i2c_client *client)
  1190	{
  1191		struct pd692x0_priv *priv = i2c_get_clientdata(client);
  1192	
> 1193		firmware_upload_unregister(priv->fwl);
  1194	}
  1195	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

