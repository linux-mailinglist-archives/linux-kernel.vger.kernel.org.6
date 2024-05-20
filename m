Return-Path: <linux-kernel+bounces-183608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B3C8C9B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B051C20D69
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E50210EE;
	Mon, 20 May 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOygegHc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEDF41A8F;
	Mon, 20 May 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201012; cv=none; b=A4tX57H+1whiOeLPDSflAf4cdVZKyg6bwLuFsXYZS57qeC8eaCcgku/dGbT2fPytLKTT7VU9Xuq/RqnUPmivotjBigUrpqlWXpjFDmG5ZLmFFXPxKBtFVp4wlJaGbFa4qU51paOVdooWENXZCe+gts0kksh/0DY8rFXQtB+Iokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201012; c=relaxed/simple;
	bh=TsNGLqrMAkxc98C8MUAlaIcLGC2STyWA54xrNNX1C68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4zUyMIelpCyRD/C8skGsvq0/quKRfeRf/hkrDrUPTzKy4lsl0kBF4+0uVxbNRFBGkd9WBV9I9Nw1btAJbN/e+yytgx+53Xly7i9MYWZXNaVlBoP+OE7YT5LM/BsqN2TFiRldj4PF6vtfzH19p5Mt+YcDlPxIM7lSWx1u0cXkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOygegHc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716201011; x=1747737011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TsNGLqrMAkxc98C8MUAlaIcLGC2STyWA54xrNNX1C68=;
  b=TOygegHcx3xSO3Jka890O0vJEhvk1tYLXIreGIrvlfHsr7vYMDPLB+sI
   NCy7bYkNPfKdrAXWQQt4S8WzkrdW8EDyGDS68QK/Qz/uyhOKpd+chThvQ
   hft1yxjz6hbrZNQWsziSwGw0SltKZ7PqXdQ0VNr8ZRaeqapTYg89+Jrl4
   Jv2PW0wbdKlRhc3lpmoXZonjH2f5cXz8tm6sG8iJCaXpxV+wVauacj5AV
   qOUVvXahFPAws4NCpP29e3qX+sWkaFDArbz0mNlWKlBMBHej8vAoLE5Od
   enuboS//aqSrRGCdoRrwFn2kPkrCVaIClSrtdztVdtZmWtJxiBeFN5rzq
   w==;
X-CSE-ConnectionGUID: ngFmOqJTT7ys5MaaOXINgA==
X-CSE-MsgGUID: 07X/8Il6Qg+CgaxR21sgVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12432538"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12432538"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:30:11 -0700
X-CSE-ConnectionGUID: t8nbzBW5Su6CKixjY8UHmg==
X-CSE-MsgGUID: IxOAEEApQJyy+I4fmVnzsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="55725273"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 May 2024 03:30:06 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s90HL-0004oi-1n;
	Mon, 20 May 2024 10:30:03 +0000
Date: Mon, 20 May 2024 18:29:34 +0800
From: kernel test robot <lkp@intel.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, marex@denx.de, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, shengjiu.wang@gmail.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 2/5] clk: imx: clk-audiomix: Add reset controller
Message-ID: <202405201844.zf7UkDmq-lkp@intel.com>
References: <1716188963-16175-3-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716188963-16175-3-git-send-email-shengjiu.wang@nxp.com>

Hi Shengjiu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on abelvesa/clk/imx]
[also build test WARNING on linus/master next-20240520]
[cannot apply to pza/reset/next shawnguo/for-next robh/for-next pza/imx-drm/next v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shengjiu-Wang/dt-bindings-clock-imx8mp-Add-reset-cells-property/20240520-153230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
patch link:    https://lore.kernel.org/r/1716188963-16175-3-git-send-email-shengjiu.wang%40nxp.com
patch subject: [PATCH v4 2/5] clk: imx: clk-audiomix: Add reset controller
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240520/202405201844.zf7UkDmq-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405201844.zf7UkDmq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405201844.zf7UkDmq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/imx/clk-imx8mp-audiomix.c: In function 'clk_imx8mp_audiomix_reset_adev_release':
   drivers/clk/imx/clk-imx8mp-audiomix.c:235:9: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
     235 |         kfree(adev);
         |         ^~~~~
         |         vfree
   drivers/clk/imx/clk-imx8mp-audiomix.c: In function 'clk_imx8mp_audiomix_reset_controller_register':
   drivers/clk/imx/clk-imx8mp-audiomix.c:244:16: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=implicit-function-declaration]
     244 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |                ^~~~~~~
         |                vzalloc
>> drivers/clk/imx/clk-imx8mp-audiomix.c:244:14: warning: assignment to 'struct auxiliary_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     244 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |              ^
   cc1: some warnings being treated as errors


vim +244 drivers/clk/imx/clk-imx8mp-audiomix.c

   237	
   238	static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
   239								 struct clk_imx8mp_audiomix_priv *priv)
   240	{
   241		struct auxiliary_device *adev;
   242		int ret;
   243	
 > 244		adev = kzalloc(sizeof(*adev), GFP_KERNEL);
   245		if (!adev)
   246			return -ENOMEM;
   247	
   248		adev->name = "reset";
   249		adev->dev.parent = dev;
   250		adev->dev.release = clk_imx8mp_audiomix_reset_adev_release;
   251	
   252		ret = auxiliary_device_init(adev);
   253		if (ret) {
   254			kfree(adev);
   255			return ret;
   256		}
   257	
   258		ret = auxiliary_device_add(adev);
   259		if (ret) {
   260			auxiliary_device_uninit(adev);
   261			kfree(adev);
   262			return ret;
   263		}
   264	
   265		return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_unregister_adev, adev);
   266	}
   267	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

