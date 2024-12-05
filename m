Return-Path: <linux-kernel+bounces-433647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DEE9E5B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C06282181
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D421D585;
	Thu,  5 Dec 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0HbRa+z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E121C164;
	Thu,  5 Dec 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415564; cv=none; b=gzE8PZ7UZohVxcuwBrYVQDIjfwm8jG3qa7SxL646ru0iOcFlaf55NEp8sEJxKXq2EVbrBYG8fYzf//CkdV4Lk8Og0JgNl3f9PQBCrMrE8yTnO6IYwnf5FNgx8WjqWXw0q7oenr/pad00siUWsYeMPeA+YYyG8S65P9d93XGuNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415564; c=relaxed/simple;
	bh=RQuaPC2ur4uaraO165fvbtuw9fpDtmA6qNnsLNhAwWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKYB5FuEBL5pyccqppnIhh3fvA8agYhZ5b7tlq+HsgNqSm5z7mfIOjhAE4luzuhnimI0WTNRO+b44KrJe9xcsW0lrAsbMLC1Uhmp6JmdJkfPUvwNbUR2JZYS7HJw7zX3sbc5e5a7OmvFIvW9cxk4417eHac9Xa8M4rEatWqxMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0HbRa+z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733415561; x=1764951561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RQuaPC2ur4uaraO165fvbtuw9fpDtmA6qNnsLNhAwWQ=;
  b=B0HbRa+zPeDOSyhCg1WIKezZqmBypxBGa0wk0AkG2yOpnzg6M+xNhdtt
   uZadOfseBzz+C+2BUj54QIwrYcEpZ4oYHw8a5/yKdDfi60yEHXvNXv3hL
   5UNGLW57tAbyWWdtpqI9HrbVIg1lOlwjCOBRI/ptHTgPJCj6F1BrULjE7
   Ts75XMlF2cYytrjzGOMAo7sq7gEFtNmBliYbiXljvJloKkc97taUG9VBW
   zugyT8mXnh2/Wl2J7QJ3Qo3amWWrOGOPHdj37eheNwmvFVSOnPo92wrUQ
   iSDgYVrWNuEPo8/5L/9MYrTWdpVzacq7ryh5Nlxd0cQFOqewoxvrQB1Tg
   g==;
X-CSE-ConnectionGUID: Aunf+KWCTbuwNkwyHhNmMg==
X-CSE-MsgGUID: Vt7bATFqTRu5uxCnle225w==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="37522385"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="37522385"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 08:18:51 -0800
X-CSE-ConnectionGUID: SKjPmepHRFSK5ooVJrwuiQ==
X-CSE-MsgGUID: a+TN6FZqQSyXZ4kLpEe+EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="99181428"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Dec 2024 08:18:46 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJEYu-0000C7-0P;
	Thu, 05 Dec 2024 16:18:44 +0000
Date: Fri, 6 Dec 2024 00:17:54 +0800
From: kernel test robot <lkp@intel.com>
To: Vabhav Sharma <vabhav.sharma@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, frank.li@nxp.com,
	pankaj.gupta@nxp.com, daniel.baluta@nxp.com,
	silvano.dininno@nxp.com, V.Sethi@nxp.com,
	meenakshi.aggarwal@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>,
	Franck LENORMAND <franck.lenormand@nxp.com>
Subject: Re: [PATCH v4 4/4] firmware: imx: secvio: Add support for SNVS
 secvio and tamper via SCFW
Message-ID: <202412060014.woL5otGn-lkp@intel.com>
References: <20241205-secvio-v4-4-5c37cdc39573@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-secvio-v4-4-5c37cdc39573@nxp.com>

Hi Vabhav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Vabhav-Sharma/dt-bindings-firmware-imx-add-nvmem-phandle/20241205-125909
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241205-secvio-v4-4-5c37cdc39573%40nxp.com
patch subject: [PATCH v4 4/4] firmware: imx: secvio: Add support for SNVS secvio and tamper via SCFW
config: nios2-randconfig-r063-20241205 (https://download.01.org/0day-ci/archive/20241206/202412060014.woL5otGn-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412060014.woL5otGn-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/firmware/imx/imx-scu-secvio.c:368:11-29: WARNING opportunity for simple_open, see also structure on line 419

vim +368 drivers/firmware/imx/imx-scu-secvio.c

   367	
 > 368	static int imx_secvio_sc_open(struct inode *node, struct file *filp)
   369	{
   370		filp->private_data = node->i_private;
   371	
   372		return 0;
   373	}
   374	
   375	static long imx_secvio_sc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
   376	{
   377		struct device *dev = file->private_data;
   378		struct secvio_sc_notifier_info info;
   379		int ret;
   380	
   381		switch (cmd) {
   382		case IMX_SECVIO_SC_GET_STATE:
   383			ret = imx_secvio_sc_get_state(dev, &info);
   384			if (ret)
   385				return ret;
   386	
   387			ret = copy_to_user((void __user *)arg, &info, sizeof(info));
   388			if (ret) {
   389				dev_err(dev, "Fail to copy info to user\n");
   390				return -EFAULT;
   391			}
   392			break;
   393		case IMX_SECVIO_SC_CHECK_STATE:
   394			ret = imx_secvio_sc_check_state(dev);
   395			if (ret)
   396				return ret;
   397			break;
   398		case IMX_SECVIO_SC_CLEAR_STATE:
   399			ret = copy_from_user(&info, (void __user *)arg, sizeof(info));
   400			if (ret) {
   401				dev_err(dev, "Fail to copy info from user\n");
   402				return -EFAULT;
   403			}
   404	
   405			ret = imx_secvio_sc_clear_state(dev, info.hpsvs, info.lps,
   406							    info.lptds);
   407			if (ret)
   408				return ret;
   409			break;
   410		default:
   411			ret = -ENOIOCTLCMD;
   412		}
   413	
   414		return ret;
   415	}
   416	
   417	static const struct file_operations imx_secvio_sc_fops = {
   418		.owner = THIS_MODULE,
 > 419		.open = imx_secvio_sc_open,
   420		.unlocked_ioctl = imx_secvio_sc_ioctl,
   421	};
   422	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

