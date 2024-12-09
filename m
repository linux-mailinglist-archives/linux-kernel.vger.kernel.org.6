Return-Path: <linux-kernel+bounces-436752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 418469E8A48
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3142816375D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBA1189BA8;
	Mon,  9 Dec 2024 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQ2S2w6Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3015A868
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718561; cv=none; b=b9dbAJ00Kao5l9qunpKs+9xcZz8GWEto8IqIKJLOwmtzHpLY+cU3rmwh1lqD0/Ohvx8J1Vh++RrypSv3YcKcv51WjKAeni1j2JA4iqu2fj2hoO42luk337aDX/7ZSi3Qui0S/7zRLNix8EBvyHd5EgZwZ5uN+57ggebvrLCi4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718561; c=relaxed/simple;
	bh=2tRIn1Im9chGWJ/YQhLJxWLMKwpT6EryNGestoecC0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=knhse1vaCiiiV0E8tk3e7f/wCq97j7mz1fi/QvFwrE/ca8C1Q4DgFTUa64+BzrvvCijUbS0NLM8X3CE4zZQf9YcPAPeAIsQVzT6l+arCZvrW0OoF0/XPdbMUR/83wl9WlpDXyws7ei52mMNpoumL7uVNl5B/ny7JvPEThCZVbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQ2S2w6Z; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733718560; x=1765254560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2tRIn1Im9chGWJ/YQhLJxWLMKwpT6EryNGestoecC0I=;
  b=RQ2S2w6ZcBdJOI23SOwye28eztEvy0vPAx2XhcbHpCStf7oa2afBK5S3
   AR9NXa22jA+R9RsArrHSI4fnzGuTPsFDxrJGsjwwLd7Q8TGvfhwOb76oH
   h4+B6k76cYtgNRnXEwXa+o474c8450xdHjHvPTV7f5q3z+MVH/RAkjKfT
   IBc43oA+BPeGT6JNWNaACqKOFs+Ds/5E8AMyNndIThxPlMHpKq4/fP7g9
   aSDBDiNKxPfO91LIfe8/uBL5PRPXoGgzeSZQKl+m103qepGPZWsacoQQa
   dBF8wo5jb3pFP89EVOQS79FVdbgp7keLyrz5nfqEyoaVdBa0O9LAOHgYQ
   Q==;
X-CSE-ConnectionGUID: pmQUEzMeTSq2jm4CHGCNlA==
X-CSE-MsgGUID: gP4jh3HcTumEm0RJWer39w==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34122919"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34122919"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:29:19 -0800
X-CSE-ConnectionGUID: aAltwH/4Rc+DhphsGJ8/YQ==
X-CSE-MsgGUID: 1zPo4DKGSni97mHW2CzCTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99404846"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Dec 2024 20:29:18 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVOV-0003rV-2u;
	Mon, 09 Dec 2024 04:29:15 +0000
Date: Mon, 9 Dec 2024 12:28:26 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c:79
 devm_imx_drm_legacy_bridge() warn: inconsistent indenting
Message-ID: <202412080122.CgaCjXX5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dmitry,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
commit: 4c3d525f65733e760f3700c0f3c83e8e46d2dcd8 drm/imx: ldb: switch to imx_legacy_bridge / drm_bridge_connector
date:   3 months ago
config: nios2-randconfig-r073-20241206 (https://download.01.org/0day-ci/archive/20241208/202412080122.CgaCjXX5-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412080122.CgaCjXX5-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c:79 devm_imx_drm_legacy_bridge() warn: inconsistent indenting

vim +79 drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c

cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  53  
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  54  struct drm_bridge *devm_imx_drm_legacy_bridge(struct device *dev,
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  55  					      struct device_node *np,
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  56  					      int type)
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  57  {
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  58  	struct imx_legacy_bridge *imx_bridge;
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  59  	int ret;
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  60  
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  61  	imx_bridge = devm_kzalloc(dev, sizeof(*imx_bridge), GFP_KERNEL);
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  62  	if (!imx_bridge)
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  63  		return ERR_PTR(-ENOMEM);
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  64  
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  65  	ret = of_get_drm_display_mode(np,
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  66  				      &imx_bridge->mode,
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  67  				      &imx_bridge->bus_flags,
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  68  				      OF_USE_NATIVE_MODE);
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  69  	if (ret)
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  70  		return ERR_PTR(ret);
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  71  
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  72  	imx_bridge->mode.type |= DRM_MODE_TYPE_DRIVER;
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  73  
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  74  	imx_bridge->base.funcs = &imx_legacy_bridge_funcs;
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  75  	imx_bridge->base.of_node = np;
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  76  	imx_bridge->base.ops = DRM_BRIDGE_OP_MODES;
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  77  	imx_bridge->base.type = type;
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  78  
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02 @79         ret = devm_drm_bridge_add(dev, &imx_bridge->base);
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  80         if (ret)
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  81                 return ERR_PTR(ret);
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  82  
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  83  	return &imx_bridge->base;
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  84  }
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  85  EXPORT_SYMBOL_GPL(devm_imx_drm_legacy_bridge);
cc3e8a216d6b817 Dmitry Baryshkov 2024-06-02  86  

:::::: The code at line 79 was first introduced by commit
:::::: cc3e8a216d6b817c509e1e1a3700055d178e04f8 drm/imx: add internal bridge handling display-timings DT node

:::::: TO: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
:::::: CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

