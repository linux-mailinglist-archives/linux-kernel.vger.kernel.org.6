Return-Path: <linux-kernel+bounces-213224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F09071F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917AC1C21635
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A30F1428EA;
	Thu, 13 Jun 2024 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="me5ueXM1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C620ED
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282521; cv=none; b=KQ/c7D9DaEwt9ETmCq+Wtg9QE4orKB72hObIxvdhJnRH4D6jhIC7nN44OAq4y6scunBd5q7RxmAdkOLN/XfQov28O/oce8wT63ZjMCKindFnuOHUc1qH1SJApC/mMSCprr1XcbD9JUtnf0u9g835G62SiVuK8AnAz9LaoeedhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282521; c=relaxed/simple;
	bh=ttOJfvUelXPVznHlvv9zD4MIgIfpGKyfFitOZVzl5uk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QxogyEYgcIzOyPAsWswoUdRnaOFzREgodYHmV0MS6zMeKV6wkUpVXOgG9M4JeKdKXILOkv2svDTx9TRC7+Zcq0Fa0fcw5XKQcn/jCOSaSQPsfNiZF5dPbbuyuWI+O0oVvtEpxpoS7aPaMnw7Z7ahyoMrT6q7xrGsI8lGyk1a9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=me5ueXM1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718282520; x=1749818520;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ttOJfvUelXPVznHlvv9zD4MIgIfpGKyfFitOZVzl5uk=;
  b=me5ueXM1fC6R0R6zCCY0IwZJ/Ylb14D9NqURMnxdzmNBS/zlHJC4Q1gg
   K2ZE/W2B9loP3u/U6O7q8/AVG7qmewFviLQAl60UQjXLsP0GhcxZs1o4d
   OUw7GzJyfygDsQIHHaQjWdGwCZfL7jCibn4cWRZ5pQewBiW5QsAL1GZqh
   rD7nQbxrKA5340/xAo2jSnwnGOs/72u3QLbWQq0grqVjR38TIkS5ZcBFi
   CuMfCIeDsy7fowcxVsOtUSMcNrpTtRMajcKgIuM2EIWeNrM5SzEUCt0sc
   CaDflg+0vJp31CHT/LwFveRik2z7b4pNlA4iqjUGOtiDV/gCXqHamdX5c
   Q==;
X-CSE-ConnectionGUID: pEH5J4CeSYKAKMSi+F60sQ==
X-CSE-MsgGUID: rbv/A1n7QuCGyRXQo2o+HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32641693"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="32641693"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 05:41:59 -0700
X-CSE-ConnectionGUID: vlyW8AXbTNWrNm1fwEx/aA==
X-CSE-MsgGUID: ZG1SeumTQLikt+GVsApFRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="45254690"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Jun 2024 05:41:58 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHjm7-00001u-1o;
	Thu, 13 Jun 2024 12:41:55 +0000
Date: Thu, 13 Jun 2024 20:41:26 +0800
From: kernel test robot <lkp@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/pci/intel/ivsc/mei_csi.c:679:undefined reference to
 `ipu_bridge_parse_ssdb'
Message-ID: <202406132238.3hXHG7nB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ccbdf43d5e758f8493a95252073cf9078a5fea5
commit: 33116eb12c6b29889cc161058ae0ee4124821b6f media: ivsc: csi: Use IPU bridge
date:   6 weeks ago
config: x86_64-randconfig-003-20231130 (https://download.01.org/0day-ci/archive/20240613/202406132238.3hXHG7nB-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240613/202406132238.3hXHG7nB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406132238.3hXHG7nB-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/media/pci/intel/ivsc/mei_csi.o: in function `mei_csi_probe':
>> drivers/media/pci/intel/ivsc/mei_csi.c:679:(.text+0xd8e): undefined reference to `ipu_bridge_parse_ssdb'
>> ld: drivers/media/pci/intel/ivsc/mei_csi.c:679:(.text+0xd93): undefined reference to `ipu_bridge_init'


vim +679 drivers/media/pci/intel/ivsc/mei_csi.c

   662	
   663	static int mei_csi_probe(struct mei_cl_device *cldev,
   664				 const struct mei_cl_device_id *id)
   665	{
   666		struct device *dev = &cldev->dev;
   667		struct pci_dev *ipu;
   668		struct mei_csi *csi;
   669		unsigned int i;
   670		int ret;
   671	
   672		for (i = 0, ipu = NULL; !ipu && ipu6_pci_tbl[i].vendor; i++)
   673			ipu = pci_get_device(ipu6_pci_tbl[i].vendor,
   674					     ipu6_pci_tbl[i].device, NULL);
   675	
   676		if (!ipu)
   677			return -ENODEV;
   678	
 > 679		ret = ipu_bridge_init(&ipu->dev, ipu_bridge_parse_ssdb);
   680		if (ret < 0)
   681			return ret;
   682		if (WARN_ON(!dev_fwnode(dev)))
   683			return -ENXIO;
   684	
   685		csi = devm_kzalloc(dev, sizeof(struct mei_csi), GFP_KERNEL);
   686		if (!csi)
   687			return -ENOMEM;
   688	
   689		csi->cldev = cldev;
   690		mutex_init(&csi->lock);
   691		init_completion(&csi->cmd_completion);
   692	
   693		mei_cldev_set_drvdata(cldev, csi);
   694	
   695		ret = mei_cldev_enable(cldev);
   696		if (ret < 0) {
   697			dev_err(dev, "mei_cldev_enable failed: %d\n", ret);
   698			goto destroy_mutex;
   699		}
   700	
   701		ret = mei_cldev_register_rx_cb(cldev, mei_csi_rx);
   702		if (ret) {
   703			dev_err(dev, "event cb registration failed: %d\n", ret);
   704			goto err_disable;
   705		}
   706	
   707		ret = mei_csi_parse_firmware(csi);
   708		if (ret)
   709			goto err_disable;
   710	
   711		csi->subdev.dev = &cldev->dev;
   712		csi->subdev.state_lock = &csi->lock;
   713		v4l2_subdev_init(&csi->subdev, &mei_csi_subdev_ops);
   714		csi->subdev.internal_ops = &mei_csi_internal_ops;
   715		v4l2_set_subdevdata(&csi->subdev, csi);
   716		csi->subdev.flags = V4L2_SUBDEV_FL_HAS_DEVNODE |
   717				    V4L2_SUBDEV_FL_HAS_EVENTS;
   718		csi->subdev.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
   719		csi->subdev.entity.ops = &mei_csi_entity_ops;
   720	
   721		snprintf(csi->subdev.name, sizeof(csi->subdev.name),
   722			 MEI_CSI_ENTITY_NAME);
   723	
   724		ret = mei_csi_init_controls(csi);
   725		if (ret)
   726			goto err_ctrl_handler;
   727	
   728		csi->pads[CSI_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
   729		csi->pads[CSI_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
   730		ret = media_entity_pads_init(&csi->subdev.entity, CSI_NUM_PADS,
   731					     csi->pads);
   732		if (ret)
   733			goto err_ctrl_handler;
   734	
   735		ret = v4l2_subdev_init_finalize(&csi->subdev);
   736		if (ret < 0)
   737			goto err_entity;
   738	
   739		ret = v4l2_async_register_subdev(&csi->subdev);
   740		if (ret < 0)
   741			goto err_subdev;
   742	
   743		pm_runtime_enable(&cldev->dev);
   744	
   745		return 0;
   746	
   747	err_subdev:
   748		v4l2_subdev_cleanup(&csi->subdev);
   749	
   750	err_entity:
   751		media_entity_cleanup(&csi->subdev.entity);
   752	
   753	err_ctrl_handler:
   754		v4l2_ctrl_handler_free(&csi->ctrl_handler);
   755		v4l2_async_nf_unregister(&csi->notifier);
   756		v4l2_async_nf_cleanup(&csi->notifier);
   757	
   758	err_disable:
   759		mei_cldev_disable(cldev);
   760	
   761	destroy_mutex:
   762		mutex_destroy(&csi->lock);
   763	
   764		return ret;
   765	}
   766	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

