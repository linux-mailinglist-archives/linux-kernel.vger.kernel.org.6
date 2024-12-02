Return-Path: <linux-kernel+bounces-427524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483F29E0255
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0661F282A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA701FECD0;
	Mon,  2 Dec 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGIssFhV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C11FE471
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143314; cv=none; b=VXsG5eX8O4bwSX2AAEmHrsCqpG5gIhdg7PMJodANUfgX7KuXfQhcFgGPOW5iDsguIN8YDfVyw4uB7TZQMBLyxQuBtgscGLdqtknF2UCBycAO0LjInT6RVtMQR4lliJKh8s24CxZBcDeytXJ8gSAyFgT9qw0hGCLU30Y09pL5YJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143314; c=relaxed/simple;
	bh=UFPmX/+DDmzyUu0vzNMW0+U6GR8eBogJyEd182nTk2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WqJY+HGN4h0/ihuaxfzYAemJDGJGfjpzcaPQGsahemLrT6FBn3nXm0eFjuPG1g7CHwLDuQ0tEcy+flLJMuaZTijORAFNaQwSG62YB/R8t/mYtV56atG/EcRacjnmcsZouG7Lxm+0QtUctHaCvN3gp2vOssWAKGWrQOJ8MBhKmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGIssFhV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733143312; x=1764679312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UFPmX/+DDmzyUu0vzNMW0+U6GR8eBogJyEd182nTk2U=;
  b=FGIssFhVty18o4KFmB+zO0FTcz5qRZkb0FtH7cX1s0sIvD2MDHlBuskv
   j6y0hJpuuuC9xK+WDQOCcHQ9mgvynfGkxnZWmNLSYi4t0clpF4hNoOotg
   kMI2nVQQkmUyJX3MSFlpo3UDgU4CKDAsOJ6EUPyAs7wHsXbSJ1AwClImj
   ButR6JciCXXVZjuuIUmTGqrMvLGJ15OUPIxkHIvvqR4DsP0SuwksZqHue
   ZDvEji98GE3tukMqdegUxnEk+5EZXo4L6kZA54YCWGwWxgoX68TwWCDXC
   Odv1YIbK9StiGd6eQWZgZMSHeCh2PLCwQzQHIkbU1Yhvfx1iXa+Vyrk1v
   w==;
X-CSE-ConnectionGUID: g4AVD0blSWO1FwOQ/xm8xQ==
X-CSE-MsgGUID: vMQ6i2BlSIe7k6tFTxL5eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="43919568"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="43919568"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 04:41:51 -0800
X-CSE-ConnectionGUID: VfW20/V2TLq7nO8Swdkg6Q==
X-CSE-MsgGUID: RMPrlQ4qTxih5ttKsDJH2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="116355050"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 02 Dec 2024 04:41:49 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tI5kJ-0002QM-0U;
	Mon, 02 Dec 2024 12:41:47 +0000
Date: Mon, 2 Dec 2024 20:41:17 +0800
From: kernel test robot <lkp@intel.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>
Subject: drivers/gpu/drm/mediatek/mtk_drm_drv.c:1092:2-3: Unneeded semicolon
Message-ID: <202412022048.kY2ZhxZ4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e70140ba0d2b1a30467d4af6bcfe761327b9ec95
commit: 9bed494cd627cecab1114ce0416c9ddb3ad66064 Merge tag 'mediatek-drm-next-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux into drm-next
date:   4 weeks ago
config: nios2-randconfig-r061-20241202 (https://download.01.org/0day-ci/archive/20241202/202412022048.kY2ZhxZ4-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412022048.kY2ZhxZ4-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:1092:2-3: Unneeded semicolon

vim +1092 drivers/gpu/drm/mediatek/mtk_drm_drv.c

4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1044  
119f5173628aa7 CK Hu                      2016-01-04  1045  static int mtk_drm_probe(struct platform_device *pdev)
119f5173628aa7 CK Hu                      2016-01-04  1046  {
119f5173628aa7 CK Hu                      2016-01-04  1047  	struct device *dev = &pdev->dev;
667c769246b01c Enric Balletbo i Serra     2020-03-25  1048  	struct device_node *phandle = dev->parent->of_node;
667c769246b01c Enric Balletbo i Serra     2020-03-25  1049  	const struct of_device_id *of_id;
119f5173628aa7 CK Hu                      2016-01-04  1050  	struct mtk_drm_private *private;
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1051  	struct mtk_mmsys_driver_data *mtk_drm_data;
119f5173628aa7 CK Hu                      2016-01-04  1052  	struct device_node *node;
119f5173628aa7 CK Hu                      2016-01-04  1053  	struct component_match *match = NULL;
0d9eee9118b77e Nancy.Lin                  2023-03-21  1054  	struct platform_device *ovl_adaptor;
119f5173628aa7 CK Hu                      2016-01-04  1055  	int ret;
119f5173628aa7 CK Hu                      2016-01-04  1056  	int i;
119f5173628aa7 CK Hu                      2016-01-04  1057  
119f5173628aa7 CK Hu                      2016-01-04  1058  	private = devm_kzalloc(dev, sizeof(*private), GFP_KERNEL);
119f5173628aa7 CK Hu                      2016-01-04  1059  	if (!private)
119f5173628aa7 CK Hu                      2016-01-04  1060  		return -ENOMEM;
119f5173628aa7 CK Hu                      2016-01-04  1061  
2c758e301ed95a Enric Balletbo i Serra     2020-03-25  1062  	private->mmsys_dev = dev->parent;
2c758e301ed95a Enric Balletbo i Serra     2020-03-25  1063  	if (!private->mmsys_dev) {
2c758e301ed95a Enric Balletbo i Serra     2020-03-25  1064  		dev_err(dev, "Failed to get MMSYS device\n");
2c758e301ed95a Enric Balletbo i Serra     2020-03-25  1065  		return -ENODEV;
119f5173628aa7 CK Hu                      2016-01-04  1066  	}
119f5173628aa7 CK Hu                      2016-01-04  1067  
667c769246b01c Enric Balletbo i Serra     2020-03-25  1068  	of_id = of_match_node(mtk_drm_of_ids, phandle);
667c769246b01c Enric Balletbo i Serra     2020-03-25  1069  	if (!of_id)
667c769246b01c Enric Balletbo i Serra     2020-03-25  1070  		return -ENODEV;
667c769246b01c Enric Balletbo i Serra     2020-03-25  1071  
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1072  	mtk_drm_data = (struct mtk_mmsys_driver_data *)of_id->data;
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1073  	if (!mtk_drm_data)
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1074  		return -EINVAL;
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1075  
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1076  	/* Try to build the display pipeline from devicetree graphs */
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1077  	if (of_graph_is_present(phandle)) {
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1078  		dev_dbg(dev, "Building display pipeline for MMSYS %u\n",
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1079  			mtk_drm_data->mmsys_id);
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1080  		private->data = devm_kmemdup(dev, mtk_drm_data,
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1081  					     sizeof(*mtk_drm_data), GFP_KERNEL);
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1082  		if (!private->data)
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1083  			return -ENOMEM;
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1084  
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1085  		ret = mtk_drm_of_ddp_path_build(dev, phandle, private->data);
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1086  		if (ret)
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1087  			return ret;
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1088  	} else {
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1089  		/* No devicetree graphs support: go with hardcoded paths if present */
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1090  		dev_dbg(dev, "Using hardcoded paths for MMSYS %u\n", mtk_drm_data->mmsys_id);
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1091  		private->data = mtk_drm_data;
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17 @1092  	};
667c769246b01c Enric Balletbo i Serra     2020-03-25  1093  
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1094  	private->all_drm_private = devm_kmalloc_array(dev, private->data->mmsys_dev_num,
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1095  						      sizeof(*private->all_drm_private),
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1096  						      GFP_KERNEL);
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1097  	if (!private->all_drm_private)
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1098  		return -ENOMEM;
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1099  
0d9eee9118b77e Nancy.Lin                  2023-03-21  1100  	/* Bringup ovl_adaptor */
0d9eee9118b77e Nancy.Lin                  2023-03-21  1101  	if (mtk_drm_find_mmsys_comp(private, DDP_COMPONENT_DRM_OVL_ADAPTOR)) {
0d9eee9118b77e Nancy.Lin                  2023-03-21  1102  		ovl_adaptor = platform_device_register_data(dev, "mediatek-disp-ovl-adaptor",
0d9eee9118b77e Nancy.Lin                  2023-03-21  1103  							    PLATFORM_DEVID_AUTO,
0d9eee9118b77e Nancy.Lin                  2023-03-21  1104  							    (void *)private->mmsys_dev,
0d9eee9118b77e Nancy.Lin                  2023-03-21  1105  							    sizeof(*private->mmsys_dev));
0d9eee9118b77e Nancy.Lin                  2023-03-21  1106  		private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev = &ovl_adaptor->dev;
0d9eee9118b77e Nancy.Lin                  2023-03-21  1107  		mtk_ddp_comp_init(NULL, &private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR],
0d9eee9118b77e Nancy.Lin                  2023-03-21  1108  				  DDP_COMPONENT_DRM_OVL_ADAPTOR);
0d9eee9118b77e Nancy.Lin                  2023-03-21  1109  		component_match_add(dev, &match, compare_dev, &ovl_adaptor->dev);
0d9eee9118b77e Nancy.Lin                  2023-03-21  1110  	}
0d9eee9118b77e Nancy.Lin                  2023-03-21  1111  
119f5173628aa7 CK Hu                      2016-01-04  1112  	/* Iterate over sibling DISP function blocks */
667c769246b01c Enric Balletbo i Serra     2020-03-25  1113  	for_each_child_of_node(phandle->parent, node) {
119f5173628aa7 CK Hu                      2016-01-04  1114  		enum mtk_ddp_comp_type comp_type;
119f5173628aa7 CK Hu                      2016-01-04  1115  		int comp_id;
119f5173628aa7 CK Hu                      2016-01-04  1116  
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1117  		ret = mtk_drm_of_get_ddp_comp_type(node, &comp_type);
4c932840db1de4 AngeloGioacchino Del Regno 2024-10-17  1118  		if (ret)
119f5173628aa7 CK Hu                      2016-01-04  1119  			continue;
119f5173628aa7 CK Hu                      2016-01-04  1120  
119f5173628aa7 CK Hu                      2016-01-04  1121  		if (!of_device_is_available(node)) {
4bf99144d2b407 Rob Herring                2017-07-18  1122  			dev_dbg(dev, "Skipping disabled component %pOF\n",
4bf99144d2b407 Rob Herring                2017-07-18  1123  				node);
119f5173628aa7 CK Hu                      2016-01-04  1124  			continue;
119f5173628aa7 CK Hu                      2016-01-04  1125  		}
119f5173628aa7 CK Hu                      2016-01-04  1126  
119f5173628aa7 CK Hu                      2016-01-04  1127  		if (comp_type == MTK_DISP_MUTEX) {
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1128  			int id;
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1129  
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1130  			id = of_alias_get_id(node, "mutex");
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1131  			if (id < 0 || id == private->data->mmsys_id) {
119f5173628aa7 CK Hu                      2016-01-04  1132  				private->mutex_node = of_node_get(node);
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1133  				dev_dbg(dev, "get mutex for mmsys %d", private->data->mmsys_id);
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1134  			}
119f5173628aa7 CK Hu                      2016-01-04  1135  			continue;
119f5173628aa7 CK Hu                      2016-01-04  1136  		}
119f5173628aa7 CK Hu                      2016-01-04  1137  
119f5173628aa7 CK Hu                      2016-01-04  1138  		comp_id = mtk_ddp_comp_get_id(node, comp_type);
119f5173628aa7 CK Hu                      2016-01-04  1139  		if (comp_id < 0) {
4bf99144d2b407 Rob Herring                2017-07-18  1140  			dev_warn(dev, "Skipping unknown component %pOF\n",
4bf99144d2b407 Rob Herring                2017-07-18  1141  				 node);
119f5173628aa7 CK Hu                      2016-01-04  1142  			continue;
119f5173628aa7 CK Hu                      2016-01-04  1143  		}
119f5173628aa7 CK Hu                      2016-01-04  1144  
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1145  		if (!mtk_drm_find_mmsys_comp(private, comp_id))
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1146  			continue;
1ef7ed48356cd5 Nancy.Lin                  2023-03-21  1147  
119f5173628aa7 CK Hu                      2016-01-04  1148  		private->comp_node[comp_id] = of_node_get(node);
119f5173628aa7 CK Hu                      2016-01-04  1149  
119f5173628aa7 CK Hu                      2016-01-04  1150  		/*
bd448b8867b7e0 jason-jh.lin               2022-05-26  1151  		 * Currently only the AAL, CCORR, COLOR, GAMMA, MERGE, OVL, RDMA, DSI, and DPI
072a4cb512e71c Yongqiang Niu              2021-02-02  1152  		 * blocks have separate component platform drivers and initialize their own
119f5173628aa7 CK Hu                      2016-01-04  1153  		 * DDP component structure. The others are initialized here.
119f5173628aa7 CK Hu                      2016-01-04  1154  		 */
78d1783c324345 Yongqiang Niu              2021-07-16  1155  		if (comp_type == MTK_DISP_AAL ||
78d1783c324345 Yongqiang Niu              2021-07-16  1156  		    comp_type == MTK_DISP_CCORR ||
072a4cb512e71c Yongqiang Niu              2021-02-02  1157  		    comp_type == MTK_DISP_COLOR ||
69a4237ab1d13a Yongqiang Niu              2021-01-29  1158  		    comp_type == MTK_DISP_GAMMA ||
bd448b8867b7e0 jason-jh.lin               2022-05-26  1159  		    comp_type == MTK_DISP_MERGE ||
5ac5895a84d92b yt.shen@mediatek.com       2017-06-16  1160  		    comp_type == MTK_DISP_OVL ||
b17bdd0d7a733c Yongqiang Niu              2019-08-29  1161  		    comp_type == MTK_DISP_OVL_2L ||
0d9eee9118b77e Nancy.Lin                  2023-03-21  1162  		    comp_type == MTK_DISP_OVL_ADAPTOR ||
119f5173628aa7 CK Hu                      2016-01-04  1163  		    comp_type == MTK_DISP_RDMA ||
d86c1568910e70 Guillaume Ranquet          2022-07-05  1164  		    comp_type == MTK_DP_INTF ||
73d3724745db79 jason-jh.lin               2021-11-30  1165  		    comp_type == MTK_DPI ||
73d3724745db79 jason-jh.lin               2021-11-30  1166  		    comp_type == MTK_DSI) {
4bf99144d2b407 Rob Herring                2017-07-18  1167  			dev_info(dev, "Adding component match for %pOF\n",
4bf99144d2b407 Rob Herring                2017-07-18  1168  				 node);
05399aa063b19a Yong Wu                    2022-02-14  1169  			drm_of_component_match_add(dev, &match, component_compare_of,
97ac0e47aed5f6 Russell King               2016-10-19  1170  						   node);
119f5173628aa7 CK Hu                      2016-01-04  1171  		}
119f5173628aa7 CK Hu                      2016-01-04  1172  
ff1395609e20c1 CK Hu                      2020-10-13  1173  		ret = mtk_ddp_comp_init(node, &private->ddp_comp[comp_id], comp_id);
165d42c012be69 Nishka Dasgupta            2019-07-06  1174  		if (ret) {
165d42c012be69 Nishka Dasgupta            2019-07-06  1175  			of_node_put(node);
119f5173628aa7 CK Hu                      2016-01-04  1176  			goto err_node;
165d42c012be69 Nishka Dasgupta            2019-07-06  1177  		}
119f5173628aa7 CK Hu                      2016-01-04  1178  	}
119f5173628aa7 CK Hu                      2016-01-04  1179  
119f5173628aa7 CK Hu                      2016-01-04  1180  	if (!private->mutex_node) {
119f5173628aa7 CK Hu                      2016-01-04  1181  		dev_err(dev, "Failed to find disp-mutex node\n");
119f5173628aa7 CK Hu                      2016-01-04  1182  		ret = -ENODEV;
119f5173628aa7 CK Hu                      2016-01-04  1183  		goto err_node;
119f5173628aa7 CK Hu                      2016-01-04  1184  	}
119f5173628aa7 CK Hu                      2016-01-04  1185  
119f5173628aa7 CK Hu                      2016-01-04  1186  	pm_runtime_enable(dev);
119f5173628aa7 CK Hu                      2016-01-04  1187  
119f5173628aa7 CK Hu                      2016-01-04  1188  	platform_set_drvdata(pdev, private);
119f5173628aa7 CK Hu                      2016-01-04  1189  
119f5173628aa7 CK Hu                      2016-01-04  1190  	ret = component_master_add_with_match(dev, &mtk_drm_ops, match);
119f5173628aa7 CK Hu                      2016-01-04  1191  	if (ret)
119f5173628aa7 CK Hu                      2016-01-04  1192  		goto err_pm;
119f5173628aa7 CK Hu                      2016-01-04  1193  
119f5173628aa7 CK Hu                      2016-01-04  1194  	return 0;
119f5173628aa7 CK Hu                      2016-01-04  1195  
119f5173628aa7 CK Hu                      2016-01-04  1196  err_pm:
119f5173628aa7 CK Hu                      2016-01-04  1197  	pm_runtime_disable(dev);
119f5173628aa7 CK Hu                      2016-01-04  1198  err_node:
119f5173628aa7 CK Hu                      2016-01-04  1199  	of_node_put(private->mutex_node);
0d9eee9118b77e Nancy.Lin                  2023-03-21  1200  	for (i = 0; i < DDP_COMPONENT_DRM_ID_MAX; i++)
119f5173628aa7 CK Hu                      2016-01-04  1201  		of_node_put(private->comp_node[i]);
119f5173628aa7 CK Hu                      2016-01-04  1202  	return ret;
119f5173628aa7 CK Hu                      2016-01-04  1203  }
119f5173628aa7 CK Hu                      2016-01-04  1204  

:::::: The code at line 1092 was first introduced by commit
:::::: 4c932840db1de4ea9639eceaaf6d59415b8a7d59 drm/mediatek: Implement OF graphs support for display paths

:::::: TO: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
:::::: CC: Chun-Kuang Hu <chunkuang.hu@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

