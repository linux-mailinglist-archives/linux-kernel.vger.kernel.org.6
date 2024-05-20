Return-Path: <linux-kernel+bounces-183987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA38CA105
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C890DB21412
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DBB137C34;
	Mon, 20 May 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtKSLB/q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF2F137930;
	Mon, 20 May 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224689; cv=none; b=ktoLCP76x32KqEkxqYD5+yBbuTI0Eek5+zwJGAp+9pgp6ky8jt6thZMQzAcxj7eiy74AexU6rKQxzbNc6RzvOTZ1cBniL/lZ/JT4i5KtZcPQcD2wL1UBP9PstKWLgJcO5xrcybZgV00fHngf78v42lJRVg9scQiKu1lz+pCxAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224689; c=relaxed/simple;
	bh=lYZdxF7vHXYI37d+JuoV5KIDqrDVCRlsGP24iqU8REU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InFaVNBYA91E/k8OPwSVvpHmc4EVTPNB3b+qmNiLOyA2ZYHk4Msa/pgy6xhNTFxsOcoh6J71Sml00y/s839BRDBzi5sNAnmwIR+N3JLD8oRwBaYdb1BqJnk1xhLJ9iGEGfmsPqvKPptGAZGVZh99b7KceK+opEa78BxnFi9eUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtKSLB/q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716224688; x=1747760688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lYZdxF7vHXYI37d+JuoV5KIDqrDVCRlsGP24iqU8REU=;
  b=BtKSLB/qxFO37djOyTCUr3jZy045DRkahSpRM9OHoWnYgHGBZHpi35By
   QZhegEQqgadgKIuEkSdAXIsdJpwzUcFTNULZKlr9lBCAED2gGdyucafBV
   oxbvUDd+fbbkVAg/WDgV7ABR5Kug2s9yilpIUxqFXrLI6ism7sLS47yC5
   N0l6wICGXRpv3jOuaj8nsTo10hMELHu4EgWm32sDWo9Hqxa6V/OBryuLT
   NARbj16n29vitqtoKoXW8AbG7jYnZvW5m6tPCFdbnFF6iuTDiBdlGwrCh
   /6u7D7gnwN8674+bB5tJaoJzNB92BEHceS6efX5yb0ZzyPneiDhFJu76o
   g==;
X-CSE-ConnectionGUID: f88ccsDPQ1G/Lf5XBTSgdw==
X-CSE-MsgGUID: 2CYgAhLjRLKVZ72JvMjazA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23036919"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="23036919"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 10:04:47 -0700
X-CSE-ConnectionGUID: IsGF1I3PSKOfdMC+9IW4ag==
X-CSE-MsgGUID: i1hjL61qSq+Ho/4jpl1hKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="33170094"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 20 May 2024 10:04:43 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s96RD-0004zo-1n;
	Mon, 20 May 2024 17:04:39 +0000
Date: Tue, 21 May 2024 01:04:00 +0800
From: kernel test robot <lkp@intel.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, marex@denx.de, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, shengjiu.wang@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 2/5] clk: imx: clk-audiomix: Add reset controller
Message-ID: <202405210036.hMLQ7OGl-lkp@intel.com>
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
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240521/202405210036.hMLQ7OGl-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project fa9b1be45088dce1e4b602d451f118128b94237b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240521/202405210036.hMLQ7OGl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405210036.hMLQ7OGl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/clk/imx/clk-imx8mp-audiomix.c:11:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/clk/imx/clk-imx8mp-audiomix.c:11:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/clk/imx/clk-imx8mp-audiomix.c:11:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/clk/imx/clk-imx8mp-audiomix.c:235:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     235 |         kfree(adev);
         |         ^
   drivers/clk/imx/clk-imx8mp-audiomix.c:235:2: note: did you mean 'vfree'?
   include/linux/vmalloc.h:162:13: note: 'vfree' declared here
     162 | extern void vfree(const void *addr);
         |             ^
>> drivers/clk/imx/clk-imx8mp-audiomix.c:244:9: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     244 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |                ^
   drivers/clk/imx/clk-imx8mp-audiomix.c:244:9: note: did you mean 'vzalloc'?
   include/linux/vmalloc.h:142:14: note: 'vzalloc' declared here
     142 | extern void *vzalloc(unsigned long size) __alloc_size(1);
         |              ^
>> drivers/clk/imx/clk-imx8mp-audiomix.c:244:7: error: incompatible integer to pointer conversion assigning to 'struct auxiliary_device *' from 'int' [-Wint-conversion]
     244 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx8mp-audiomix.c:254:3: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     254 |                 kfree(adev);
         |                 ^
   drivers/clk/imx/clk-imx8mp-audiomix.c:261:3: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     261 |                 kfree(adev);
         |                 ^
   6 warnings and 5 errors generated.


vim +/kfree +235 drivers/clk/imx/clk-imx8mp-audiomix.c

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

