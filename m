Return-Path: <linux-kernel+bounces-329403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5162C9790E7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11285284C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABFB1CF7DF;
	Sat, 14 Sep 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/d56EnX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A20190675;
	Sat, 14 Sep 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726320426; cv=none; b=I8+DMwpRXnNJYtIqaffVQHIuQkTmvnFv6fy0rBN6cikafuvpP0F6/qErwvKczS6Kz4gaC5IJahhlu6FN/qmx/5dCar11vq7lBYfi8rmFLEFH8JVjcmRpn9dP9NzPDfxMCMxXe5vVAcB1Z66BhZdlCzF0MoknmAJsFR9+mYK8/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726320426; c=relaxed/simple;
	bh=bfwqlZPrPDDj9RmAuDLGsQEpeaFuEXu2QbOhoqDsVLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1w9kGCEo8XanN1EIfd8kcb+jcW7jbqKBOw1sCt2GOeLjKNrVhsTzKL7ujcaoT/PqvyL2GL34bE+sZXCqGWsAW4jKv7zdvwlCok7Ba+npwl6upE5/kLvHjMsGNmy8MfJjezKQF+Tbbc6UKLb9ZKgr/DjVUeiP8cZNUsoB2+f/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/d56EnX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726320424; x=1757856424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bfwqlZPrPDDj9RmAuDLGsQEpeaFuEXu2QbOhoqDsVLI=;
  b=X/d56EnXnb6fTU1ha43hezEhi6t+s0wD7pTYcEBy/fCGgTcc7zhMR+l5
   TWv/55R8CC/ZlYreb2M4XihDc7Uc+zbQOb6+VrBtl1K3SKp6lx/IN5sks
   AHC2ucTk77IWDv/kpaoQmSSVB69dIw9DY6U1yik4pIu/421WOGH8kxcMb
   u2LORzKuDIkrk3vql0ZQXuPumULT9IVZJmIbuFdgoyOB6eHdXWC6DPMyC
   H5DhPi9BOgN4sUS+CNDRy4r9j/AVIZg3noVUl3y1A05NZVn9u7hyd9ted
   ybpgzX8zk8AQIjtNn8Gb58zy8lthXEkFBjIVufJmxCuaRXxGKI2544/Bb
   w==;
X-CSE-ConnectionGUID: 6z0Ixlx3RZWm5xb5+AmsVA==
X-CSE-MsgGUID: 83CDFYcVRga5+cMlhE8/kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="24698594"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="24698594"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 06:27:04 -0700
X-CSE-ConnectionGUID: mHzuBfSMQ6+R0oB732P08Q==
X-CSE-MsgGUID: 7TqGNRHXQwKIO3eJz7yGZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="68268763"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Sep 2024 06:27:00 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spSnh-0007mK-2W;
	Sat, 14 Sep 2024 13:26:57 +0000
Date: Sat, 14 Sep 2024 21:26:26 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Bruel <christian.bruel@foss.st.com>, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de
Cc: oe-kbuild-all@lists.linux.dev, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com,
	Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH v8 2/5] phy: stm32: Add support for STM32MP25 COMBOPHY.
Message-ID: <202409142143.iJkSYPUK-lkp@intel.com>
References: <20240911104646.2980821-3-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911104646.2980821-3-christian.bruel@foss.st.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on atorgue-stm32/stm32-next]
[also build test ERROR on robh/for-next linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Bruel/dt-bindings-phy-Add-STM32MP25-COMBOPHY-bindings/20240911-185452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
patch link:    https://lore.kernel.org/r/20240911104646.2980821-3-christian.bruel%40foss.st.com
patch subject: [PATCH v8 2/5] phy: stm32: Add support for STM32MP25 COMBOPHY.
config: um-randconfig-r132-20240914 (https://download.01.org/0day-ci/archive/20240914/202409142143.iJkSYPUK-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409142143.iJkSYPUK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409142143.iJkSYPUK-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/phy/st/phy-stm32-combophy.c:12:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/phy/st/phy-stm32-combophy.c:12:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/phy/st/phy-stm32-combophy.c:12:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/phy/st/phy-stm32-combophy.c:140:8: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                      FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_OHM, imp_of));
                                      ^
>> drivers/phy/st/phy-stm32-combophy.c:143:12: error: implicit declaration of function 'FIELD_GET' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   imp_of = FIELD_GET(STM32MP25_PCIEPRG_IMPCTRL_OHM, val);
                            ^
   drivers/phy/st/phy-stm32-combophy.c:161:8: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                      FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_VSWING, vswing_of));
                                      ^
   drivers/phy/st/phy-stm32-combophy.c:530:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
                   return ret;
                          ^~~
   drivers/phy/st/phy-stm32-combophy.c:515:9: note: initialize the variable 'ret' to silence this warning
           int ret, irq;
                  ^
                   = 0
   13 warnings and 3 errors generated.


vim +/FIELD_PREP +140 drivers/phy/st/phy-stm32-combophy.c

   113	
   114	static int stm32_impedance_tune(struct stm32_combophy *combophy)
   115	{
   116		u8 imp_size = ARRAY_SIZE(imp_lookup);
   117		u8 vswing_size = ARRAY_SIZE(imp_lookup[0].vswing);
   118		u8 imp_of, vswing_of;
   119		u32 max_imp = imp_lookup[0].microohm;
   120		u32 min_imp = imp_lookup[imp_size - 1].microohm;
   121		u32 max_vswing = imp_lookup[imp_size - 1].vswing[vswing_size - 1];
   122		u32 min_vswing = imp_lookup[0].vswing[0];
   123		u32 val;
   124	
   125		if (!of_property_read_u32(combophy->dev->of_node, "st,output-micro-ohms", &val)) {
   126			if (val < min_imp || val > max_imp) {
   127				dev_err(combophy->dev, "Invalid value %u for output ohm\n", val);
   128				return -EINVAL;
   129			}
   130	
   131			for (imp_of = 0; imp_of < ARRAY_SIZE(imp_lookup); imp_of++)
   132				if (imp_lookup[imp_of].microohm <= val)
   133					break;
   134	
   135			dev_dbg(combophy->dev, "Set %u micro-ohms output impedance\n",
   136				imp_lookup[imp_of].microohm);
   137	
   138			regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
   139					   STM32MP25_PCIEPRG_IMPCTRL_OHM,
 > 140					   FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_OHM, imp_of));
   141		} else {
   142			regmap_read(combophy->regmap, SYSCFG_PCIEPRGCR, &val);
 > 143			imp_of = FIELD_GET(STM32MP25_PCIEPRG_IMPCTRL_OHM, val);
   144		}
   145	
   146		if (!of_property_read_u32(combophy->dev->of_node, "st,output-vswing-microvolt", &val)) {
   147			if (val < min_vswing || val > max_vswing) {
   148				dev_err(combophy->dev, "Invalid value %u for output vswing\n", val);
   149				return -EINVAL;
   150			}
   151	
   152			for (vswing_of = 0; vswing_of < ARRAY_SIZE(imp_lookup[imp_of].vswing); vswing_of++)
   153				if (imp_lookup[imp_of].vswing[vswing_of] >= val)
   154					break;
   155	
   156			dev_dbg(combophy->dev, "Set %u microvolt swing\n",
   157				 imp_lookup[imp_of].vswing[vswing_of]);
   158	
   159			regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
   160					   STM32MP25_PCIEPRG_IMPCTRL_VSWING,
   161					   FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_VSWING, vswing_of));
   162		}
   163	
   164		return 0;
   165	}
   166	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

