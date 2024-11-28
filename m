Return-Path: <linux-kernel+bounces-424455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2359DB4A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62087B211F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3920E155743;
	Thu, 28 Nov 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKFi0FUf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D652F88;
	Thu, 28 Nov 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732785252; cv=none; b=n/bV7b1jYYa6BeG3aRtxV4mT5y5FSSmOE1fa9PGYr6WDVCMj1AB322tS34Sgn1HmqW1E/p+Cegc63em+m+En1SZbGFsjxKR1iKcKYGfhxcT8GtJWV0r+3ppMdZ6hPy56Tu2Ulq7wxA8qzwku0JCiAivKNGufWGggLXtE3yLn9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732785252; c=relaxed/simple;
	bh=xw2wO2fUU8KQ8iSrqcL95ODU94SFi+VqIXlFh7Mb7T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luxYn3s4HvLBdEIBFRxCY3/ernUYsnaC0wSViM3lM/e6nFK1dcBB10MRGerUcFPpM+wMgt07Bi7wwV8xgn2JC61XZO2vEf9uj4LIM0uoSWw6cco71wazMbd8pLuhFPzKodO/anLecciPmCcNCZNuG8VJnpkXgGbBzeLrqvILp5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKFi0FUf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732785250; x=1764321250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xw2wO2fUU8KQ8iSrqcL95ODU94SFi+VqIXlFh7Mb7T0=;
  b=UKFi0FUfTDx7s57mp537/9lJeVxZdVsuRNpYeUpzDIevRmgNeRVPQPDO
   tleYI9odU6GT3W6fNS4j2sB3kcCpuw2tfRpnG2oCKJy6Z4q5yn3FEZVr2
   XkrkDQMDkugLxl2wej7zSCFSTfI80wASagwP3h24fM/u98c9ka+Fwj33i
   hZh3Ysii8vQ6k0D686YdHuBNR97FjqZDkqFtAaXMVP2FEb7OkQrIgs3j5
   SLDgGDDJyBEjJi/YejLFFFqAyFVQ8AL3yC4NtZc5WArf5ww7AXauC32+u
   0j50suW+LGPXMABu3BFxgt7FyXAqli38UB+afknJOBU1c8lqyBzHpFwUY
   A==;
X-CSE-ConnectionGUID: vCdBlUkxRCyKwVHAPNkYVA==
X-CSE-MsgGUID: OtIpyU89Rcu+FVojJNhrqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32946942"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="32946942"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 01:14:09 -0800
X-CSE-ConnectionGUID: uqOmvXfmQWGhfoFoRafCKg==
X-CSE-MsgGUID: qGqrPxt/RbKGmMsdYDmvEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="96942880"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Nov 2024 01:14:03 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGab3-0009Nx-07;
	Thu, 28 Nov 2024 09:14:01 +0000
Date: Thu, 28 Nov 2024 17:13:47 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com, heiko@sntech.de,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	dse@thaumatec.com, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v4 2/2] phy: rockchip: Add Samsung MIPI D-/C-PHY driver
Message-ID: <202411281638.UyY41bPE-lkp@intel.com>
References: <20241126131736.465111-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126131736.465111-3-heiko@sntech.de>

Hi Heiko,

kernel test robot noticed the following build errors:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on robh/for-next linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Stuebner/dt-bindings-phy-Add-Rockchip-MIPI-C-D-PHY-schema/20241128-100435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20241126131736.465111-3-heiko%40sntech.de
patch subject: [PATCH v4 2/2] phy: rockchip: Add Samsung MIPI D-/C-PHY driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241128/202411281638.UyY41bPE-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411281638.UyY41bPE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411281638.UyY41bPE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:15:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:15:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:15:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:15:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:895:23: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     895 |                            I_MUX_SEL_MASK, I_MUX_SEL_400MV);
         |                                            ^
   drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:33:26: note: expanded from macro 'I_MUX_SEL_400MV'
      33 | #define I_MUX_SEL_400MV         I_MUX_SEL(0)
         |                                 ^
   drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:32:23: note: expanded from macro 'I_MUX_SEL'
      32 | #define I_MUX_SEL(x)            FIELD_PREP(I_MUX_SEL_MASK, x)
         |                                 ^
   drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:900:50: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     900 |         regmap_write(samsung->regmap, DPHY_MC_GNR_CON1, T_PHY_READY(0x2000));
         |                                                         ^
   drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:69:25: note: expanded from macro 'T_PHY_READY'
      69 | #define T_PHY_READY(x)          FIELD_PREP(GENMASK(15, 0), x)
         |                                 ^
   drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:945:7: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     945 |                            S(samsung->pll.scaler) | P(samsung->pll.prediv));
         |                            ^
   drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:40:16: note: expanded from macro 'S'
      40 | #define S(x)                    FIELD_PREP(S_MASK, x)
         |                                 ^
   drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:1116:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1116 |         val = EDGE_CON(7) | EDGE_CON_DIR(0) | EDGE_CON_EN |
         |               ^
   drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:71:22: note: expanded from macro 'EDGE_CON'
      71 | #define EDGE_CON(x)             FIELD_PREP(GENMASK(14, 12), x)
         |                                 ^
   drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:1170:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1170 |         val = EDGE_CON(7) | EDGE_CON_DIR(0) | EDGE_CON_EN |
         |               ^
   drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c:71:22: note: expanded from macro 'EDGE_CON'
      71 | #define EDGE_CON(x)             FIELD_PREP(GENMASK(14, 12), x)
         |                                 ^
   7 warnings and 5 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/FIELD_PREP +895 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c

   881	
   882	static void samsung_mipi_dcphy_bias_block_enable(struct samsung_mipi_dcphy *samsung)
   883	{
   884		u32 bias_con2 = 0x3223;
   885	
   886		regmap_write(samsung->regmap, BIAS_CON0, 0x0010);
   887		regmap_write(samsung->regmap, BIAS_CON1, 0x0110);
   888		regmap_write(samsung->regmap, BIAS_CON2, bias_con2);
   889	
   890		/* default output voltage select:
   891		 * dphy: 400mv
   892		 * cphy: 530mv
   893		 */
   894		regmap_update_bits(samsung->regmap, BIAS_CON4,
 > 895				   I_MUX_SEL_MASK, I_MUX_SEL_400MV);
   896	}
   897	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

