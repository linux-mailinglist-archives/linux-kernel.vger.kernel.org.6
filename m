Return-Path: <linux-kernel+bounces-183809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DF18C9E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C961C220E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2E3136678;
	Mon, 20 May 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arDADyHg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5253815;
	Mon, 20 May 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213153; cv=none; b=ItJzHpJWaPMRkegz/dEwfjmO2RMckCMUl0flPLu+IyH0KX7O4H90Mj2LltmV7JDyzxULDpS2hZrFWROhhFVzCTBWWSIcrjpNLK66ixzYJKfj1cwCGUJnD60npr9om6T9d3Ipx4sMxKK9j1D7Sr3RWvpPspsUJWBXXuNY73lEwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213153; c=relaxed/simple;
	bh=hDGQ/f9tnKzEsLVgBqkboz6ShsWwZfM5TWALVwDYV6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9CrOrF1raz8mg2UdBco2GYeO1RGk7Zfvcz/22orZXBtW0loDhyosKv5m7XZba/ZG02Fj99iFvz5tyGZY3jf2z3dD9GPE7JoU7TvxMPo+b4n74Lm3JdPtuFF6BBxwN2muvyKk8A8ZeuvJcWrKC8z/g9c7+uOPO6BeYDI33e1OgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arDADyHg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716213151; x=1747749151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hDGQ/f9tnKzEsLVgBqkboz6ShsWwZfM5TWALVwDYV6Q=;
  b=arDADyHg8gU1QzfRT/RuCBAl4qCElvzvR8azTR68N8DT+ZAaiu27Ova2
   +B+a5l7OiYrgJ2hGLvofCgzwTk3RP9LSE7n9lQxriQiA0kl4Ip4UUsKmA
   Etqj7YAMSbtRnT2OtDh6KQB/HNCAYZZtN3KIqNm+QkYDO7pmszrUis35v
   EOiw/k+zhkMZZtRCqPHNQPsSBqWcnvra3xOPFlpXartweBeiWWqG3QG0l
   C2S65x6cSOeglzn0mKW8rJ7wNQVJtZp0ULwib16vXuZgS/B1Sq5FnC2NV
   LA1atqTqArKYaktpPjr2ehLvy5iQqZgw2FcTWQbXmGYJVNZ5X8Q1aXQ9+
   A==;
X-CSE-ConnectionGUID: oW3pvki2S4SmD1b4jh0M1A==
X-CSE-MsgGUID: witET3DnTDyFewDbCEflZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23749406"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="23749406"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 06:52:31 -0700
X-CSE-ConnectionGUID: IZ/kxZVCRu+B/+d4yLGwsA==
X-CSE-MsgGUID: 0q2of9YaRviqgGI9BTjUrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="32446141"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2024 06:52:26 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s93R9-0004si-2j;
	Mon, 20 May 2024 13:52:23 +0000
Date: Mon, 20 May 2024 21:51:36 +0800
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
Message-ID: <202405202110.K51viYoO-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on abelvesa/clk/imx]
[also build test ERROR on linus/master next-20240520]
[cannot apply to pza/reset/next shawnguo/for-next robh/for-next pza/imx-drm/next v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shengjiu-Wang/dt-bindings-clock-imx8mp-Add-reset-cells-property/20240520-153230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
patch link:    https://lore.kernel.org/r/1716188963-16175-3-git-send-email-shengjiu.wang%40nxp.com
patch subject: [PATCH v4 2/5] clk: imx: clk-audiomix: Add reset controller
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240520/202405202110.K51viYoO-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405202110.K51viYoO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405202110.K51viYoO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/imx/clk-imx8mp-audiomix.c: In function 'clk_imx8mp_audiomix_reset_adev_release':
>> drivers/clk/imx/clk-imx8mp-audiomix.c:235:9: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
     235 |         kfree(adev);
         |         ^~~~~
         |         vfree
   drivers/clk/imx/clk-imx8mp-audiomix.c: In function 'clk_imx8mp_audiomix_reset_controller_register':
>> drivers/clk/imx/clk-imx8mp-audiomix.c:244:16: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=implicit-function-declaration]
     244 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |                ^~~~~~~
         |                vzalloc
   drivers/clk/imx/clk-imx8mp-audiomix.c:244:14: warning: assignment to 'struct auxiliary_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     244 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |              ^
   cc1: some warnings being treated as errors


vim +235 drivers/clk/imx/clk-imx8mp-audiomix.c

   230	
   231	static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
   232	{
   233		struct auxiliary_device *adev = to_auxiliary_dev(dev);
   234	
 > 235		kfree(adev);
   236	}
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

