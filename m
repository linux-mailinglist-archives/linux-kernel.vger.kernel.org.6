Return-Path: <linux-kernel+bounces-221834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE9090F938
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0371F20984
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05F715B579;
	Wed, 19 Jun 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKYg45qv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816815B0EE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718836861; cv=none; b=NHsCYgXzfbK6eupYKFl7ppyF6xxL2LeyWXNO4VE0cDvngP4LXMHOI2Zuz9ND7R53KIBANYgTgMpUYDuQcogtgzSknmHTUBtuq5c9dBRwgIZPHUd6XiHntKgy67kbLvgytdxn6Min/es3ry9+/YWiZSU5t9HJYNkykkV3oLZyzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718836861; c=relaxed/simple;
	bh=Z3V2YEWjIUIyTe7vCln7wvCpu5r50bXJUh9xJ5cmzYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o5gUiX99kC4uW+TgitXJtoAC7IKCa71S3OCP7HXZSkQmyKKXXbd3GUccrR+IrkhFeAsIXygekQxjuV+81imFNJsqizSkYZpGl8kWowWkECprD+PMuCGcjFna7XkwpCt7ncTyEgj7xo5KVZqfc2Q4UeRq6B7wYPFbCiKE4QNjb3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKYg45qv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718836860; x=1750372860;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z3V2YEWjIUIyTe7vCln7wvCpu5r50bXJUh9xJ5cmzYI=;
  b=RKYg45qvjoJB2P8+JfH1LjeYUE41e0xnotJjlrEfOlfR7S9CZE0Q8fao
   SmKi5BWJ2h31Kosc9UDAPau7WAJZGzEJfP6wqGokGhnMNwvHphGcNyBDL
   Wf1ZJWD3ugdZdn3sw1r+SdjAuVk35CEL9mGns/We/Lbmaggh+cLZNc0ZN
   v4Tu9ysABDAvQuvlZDeUwpHZx+ode2krfL5ePDpMcjfL2BkTrlEzaOeRA
   fq1SsbpRf3azKPLcZD2m/h8y2z9GlKmm11EK6PdzfLyxUtuyTxrR4hl9Q
   egiSkib2RWmq/o6NZu4RsEH9FO6uDd8jLnk3ndlhh/0mcH/l34jGT1UcK
   A==;
X-CSE-ConnectionGUID: mHVfxkJPSj+Pjk/pAP/u7Q==
X-CSE-MsgGUID: kP8XJVHWT1W72s4i83D2dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15766961"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15766961"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 15:40:59 -0700
X-CSE-ConnectionGUID: ajpBgmfuTfiZ+Jcfx8rmDA==
X-CSE-MsgGUID: WL+4kHWcS0iwqIcB52X6RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42710026"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 19 Jun 2024 15:40:58 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK3z5-00073l-1Q;
	Wed, 19 Jun 2024 22:40:55 +0000
Date: Thu, 20 Jun 2024 06:40:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: drivers/net/pse-pd/pd692x0.c:1193:undefined reference to
 `firmware_upload_unregister'
Message-ID: <202406200632.f52Pa3HR-lkp@intel.com>
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
config: i386-randconfig-006-20240620 (https://download.01.org/0day-ci/archive/20240620/202406200632.f52Pa3HR-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406200632.f52Pa3HR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406200632.f52Pa3HR-lkp@intel.com/

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

