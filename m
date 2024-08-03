Return-Path: <linux-kernel+bounces-273284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E41F9466DF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 04:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E08B21AE9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 02:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB028AD58;
	Sat,  3 Aug 2024 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAiZfGDq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC16FC1;
	Sat,  3 Aug 2024 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722651207; cv=none; b=eSxcybtd+yYl9DvLB0K8ygde4KDXvWtkrArOhOIymEMBoS7FENfIpAVMsq3cWYcZpHXTlqHG4Le4t6uIpNhOqvMDJC/KkZAGYHcFs55EuX8VwwIioOJsL7K53cItLbIFJpwGIQsxoy3me4dAcUcrF8wl54zM+JONtIH7k+SLJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722651207; c=relaxed/simple;
	bh=ml8yJMr5An3VhYIGhMGVsAeIILi31Bm9dzNScMAZb4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQmNwJuojO9HFHwLZmDPHwSnl26AFGVf3ds3pz87yRxqjymQMa2uWWDQQJ1n8to+wwe90WIWRcZj+2Cjm1Os8Lyvg0ioVcJ84D0x244NcT+wtlVG+fi4HbLoPrBruH032F4+A2B24GFaebFk2GYQaRFMSmyLW/QxZncc6/IWLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAiZfGDq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722651205; x=1754187205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ml8yJMr5An3VhYIGhMGVsAeIILi31Bm9dzNScMAZb4g=;
  b=LAiZfGDqdKXkMlJQ1xuhyf2ElmbYfuHs2pXjm01AgBankuBVut6+6v2v
   gilk/qp5neNGsXyzO5YdAtYguuwaTHrCoTFlfmEtnnyt68IYWs1uPviF2
   61VbAe3GnRWtv9ZxtpKaBpwnC4HcPkFEdpc0MSNQPlcULpsMsSpI+MHww
   tL/T878KiM2d5pBnE8Jsnrn54sVxFBX2PsXILGnI2495JnUd+iVAdSE/q
   Sg4LKSosWs0HpF7EVfJBB3L67hYd/AkzNeP5pETKPR66uaUOqJVHJZNbT
   ieli7BiQVn67E6tBt1rIugEaLepPjyimA+HsJdpsqzQws+jCvDMeTX4qs
   A==;
X-CSE-ConnectionGUID: lbNveibhSTe06huzZmQG4Q==
X-CSE-MsgGUID: RA714PdcR1W3/2TZuPZ8pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="12856696"
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="12856696"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 19:13:24 -0700
X-CSE-ConnectionGUID: sWld8u6fSrekvgHseOCUGA==
X-CSE-MsgGUID: YvNLQpIXSfSDa5TU1HrBSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="55502363"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 02 Aug 2024 19:13:21 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sa4Gj-000xlD-2F;
	Sat, 03 Aug 2024 02:13:17 +0000
Date: Sat, 3 Aug 2024 10:12:20 +0800
From: kernel test robot <lkp@intel.com>
To: Stanley Chu <stanley.chuys@gmail.com>, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, linux-i3c@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com, cpchiang1@nuvoton.com
Subject: Re: [PATCH v1 2/2] i3c: master: Add Nuvoton npcm845 i3c master driver
Message-ID: <202408030900.Hx3aeLR4-lkp@intel.com>
References: <20240801071946.43266-3-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801071946.43266-3-yschu@nuvoton.com>

Hi Stanley,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.11-rc1 next-20240802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanley-Chu/dt-bindings-i3c-Add-NPCM845-i3c-controller/20240802-183617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240801071946.43266-3-yschu%40nuvoton.com
patch subject: [PATCH v1 2/2] i3c: master: Add Nuvoton npcm845 i3c master driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240803/202408030900.Hx3aeLR4-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408030900.Hx3aeLR4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408030900.Hx3aeLR4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/i3c/master/npcm845-i3c-master.c:14:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/i3c/master/npcm845-i3c-master.c:14:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from drivers/i3c/master/npcm845-i3c-master.c:14:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/i3c/master/npcm845-i3c-master.c:14:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
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
   drivers/i3c/master/npcm845-i3c-master.c:655:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     655 |         default:
         |         ^
   drivers/i3c/master/npcm845-i3c-master.c:655:2: note: insert 'break;' to avoid fall-through
     655 |         default:
         |         ^
         |         break; 
>> drivers/i3c/master/npcm845-i3c-master.c:885:41: warning: shift count >= width of type [-Wshift-count-overflow]
     885 |         info.pid = (NPCM_I3C_VENDORID_VID(reg) << 33) | readl(master->regs + NPCM_I3C_PARTNO);
         |                                                ^  ~~
   drivers/i3c/master/npcm845-i3c-master.c:1112:9: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
    1112 |                         if ((NPCM_I3C_MSTATUS_STATE_IDLE(reg) |
         |                             ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                               ||
    1113 |                              NPCM_I3C_MSTATUS_STATE_SLVREQ(reg)) &&
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i3c/master/npcm845-i3c-master.c:67:42: note: expanded from macro 'NPCM_I3C_MSTATUS_STATE_IDLE'
      67 | #define   NPCM_I3C_MSTATUS_STATE_IDLE(x) (NPCM_I3C_MSTATUS_STATE(x) == 0)
         |                                          ^
   drivers/i3c/master/npcm845-i3c-master.c:1112:9: note: cast one or both operands to int to silence this warning
   drivers/i3c/master/npcm845-i3c-master.c:67:42: note: expanded from macro 'NPCM_I3C_MSTATUS_STATE_IDLE'
      67 | #define   NPCM_I3C_MSTATUS_STATE_IDLE(x) (NPCM_I3C_MSTATUS_STATE(x) == 0)
         |                                          ^
   drivers/i3c/master/npcm845-i3c-master.c:2353:12: error: incompatible function pointer types initializing 'void (*)(struct platform_device *)' with an expression of type 'int (struct platform_device *)' [-Wincompatible-function-pointer-types]
    2353 |         .remove = npcm_i3c_master_remove,
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   10 warnings and 1 error generated.


vim +885 drivers/i3c/master/npcm845-i3c-master.c

   770	
   771	static int npcm_i3c_master_bus_init(struct i3c_master_controller *m)
   772	{
   773		struct npcm_i3c_master *master = to_npcm_i3c_master(m);
   774		struct i3c_bus *bus = i3c_master_get_bus(m);
   775		struct i3c_device_info info = {};
   776		unsigned long fclk_rate, fclk_period_ns;
   777		unsigned long i3c_scl_rate, i2c_scl_rate;
   778		unsigned int pp_high_period_ns, od_low_period_ns, i2c_period_ns;
   779		unsigned int scl_period_ns;
   780		u32 ppbaud, pplow, odhpp, odbaud, i2cbaud, reg;
   781		int ret;
   782	
   783		/* Timings derivation */
   784		fclk_rate = clk_get_rate(master->fclk);
   785		if (!fclk_rate)
   786			return -EINVAL;
   787	
   788		fclk_period_ns = DIV_ROUND_UP(1000000000, fclk_rate);
   789	
   790		/*
   791		 * Configure for Push-Pull mode.
   792		 */
   793		if (master->scl_timing.i3c_pp_hi >= I3C_SCL_PP_PERIOD_NS_MIN &&
   794		    master->scl_timing.i3c_pp_lo >= master->scl_timing.i3c_pp_hi) {
   795			ppbaud = DIV_ROUND_UP(master->scl_timing.i3c_pp_hi, fclk_period_ns) - 1;
   796			if (ppbaud > NPCM_I3C_MAX_PPBAUD)
   797				ppbaud = NPCM_I3C_MAX_PPBAUD;
   798			pplow = DIV_ROUND_UP(master->scl_timing.i3c_pp_lo, fclk_period_ns)
   799				- (ppbaud + 1);
   800			if (pplow > NPCM_I3C_MAX_PPLOW)
   801				pplow = NPCM_I3C_MAX_PPLOW;
   802			bus->scl_rate.i3c = 1000000000 / (((ppbaud + 1) * 2 + pplow) * fclk_period_ns);
   803		} else {
   804			scl_period_ns = DIV_ROUND_UP(1000000000, bus->scl_rate.i3c);
   805			if (bus->scl_rate.i3c == 10000000) {
   806				/* Workaround for npcm8xx: 40/60 ns */
   807				ppbaud = DIV_ROUND_UP(40, fclk_period_ns) - 1;
   808				pplow = DIV_ROUND_UP(20, fclk_period_ns);
   809			} else {
   810				/* 50% duty-cycle */
   811				ppbaud = DIV_ROUND_UP((scl_period_ns / 2), fclk_period_ns) - 1;
   812				pplow = 0;
   813			}
   814			if (ppbaud > NPCM_I3C_MAX_PPBAUD)
   815				ppbaud = NPCM_I3C_MAX_PPBAUD;
   816		}
   817		pp_high_period_ns = (ppbaud + 1) * fclk_period_ns;
   818	
   819		/*
   820		 * Configure for Open-Drain mode.
   821		 */
   822		if (master->scl_timing.i3c_od_hi >= pp_high_period_ns &&
   823		    master->scl_timing.i3c_od_lo >= I3C_SCL_OD_LOW_PERIOD_NS_MIN) {
   824			if (master->scl_timing.i3c_od_hi == pp_high_period_ns)
   825				odhpp = 1;
   826			else
   827				odhpp = 0;
   828			odbaud = DIV_ROUND_UP(master->scl_timing.i3c_od_lo, pp_high_period_ns) - 1;
   829		} else {
   830			/* Set default OD timing: 1MHz/1000ns with 50% duty cycle */
   831			odhpp = 0;
   832			odbaud = DIV_ROUND_UP(500, pp_high_period_ns) - 1;
   833		}
   834		if (odbaud > NPCM_I3C_MAX_ODBAUD)
   835			odbaud = NPCM_I3C_MAX_ODBAUD;
   836		od_low_period_ns = (odbaud + 1) * pp_high_period_ns;
   837	
   838		/* Configure for I2C mode */
   839		i2c_period_ns = DIV_ROUND_UP(1000000000, bus->scl_rate.i2c);
   840		if (i2c_period_ns < od_low_period_ns * 2)
   841			i2c_period_ns = od_low_period_ns * 2;
   842		i2cbaud = DIV_ROUND_UP(i2c_period_ns, od_low_period_ns) - 2;
   843		if (i2cbaud > NPCM_I3C_MAX_I2CBAUD)
   844			i2cbaud = NPCM_I3C_MAX_I2CBAUD;
   845	
   846		i3c_scl_rate = 1000000000 / (((ppbaud + 1) * 2 + pplow) * fclk_period_ns);
   847		i2c_scl_rate = 1000000000 / ((i2cbaud + 2) * od_low_period_ns);
   848	
   849		reg = NPCM_I3C_MCONFIG_MASTER_EN |
   850		      NPCM_I3C_MCONFIG_DISTO(0) |
   851		      NPCM_I3C_MCONFIG_HKEEP(3) |
   852		      NPCM_I3C_MCONFIG_ODSTOP(1) |
   853		      NPCM_I3C_MCONFIG_PPBAUD(ppbaud) |
   854		      NPCM_I3C_MCONFIG_PPLOW(pplow) |
   855		      NPCM_I3C_MCONFIG_ODBAUD(odbaud) |
   856		      NPCM_I3C_MCONFIG_ODHPP(odhpp) |
   857		      NPCM_I3C_MCONFIG_SKEW(0) |
   858		      NPCM_I3C_MCONFIG_I2CBAUD(i2cbaud);
   859		writel(reg, master->regs + NPCM_I3C_MCONFIG);
   860	
   861		dev_dbg(master->dev, "dts: i3c rate=%lu, i2c rate=%lu\n",
   862			bus->scl_rate.i3c, bus->scl_rate.i2c);
   863		dev_info(master->dev, "fclk=%lu, period_ns=%lu\n", fclk_rate, fclk_period_ns);
   864		dev_info(master->dev, "i3c scl_rate=%lu\n", i3c_scl_rate);
   865		dev_info(master->dev, "i2c scl_rate=%lu\n", i2c_scl_rate);
   866		dev_info(master->dev, "pp_high=%u, pp_low=%lu\n", pp_high_period_ns,
   867				(ppbaud + 1 + pplow) * fclk_period_ns);
   868		dev_info(master->dev, "pp_sda_rd_skew=%d, pp_sda_wr_skew=%d\n",
   869				master->scl_timing.i3c_pp_sda_rd_skew,
   870				master->scl_timing.i3c_pp_sda_wr_skew);
   871		dev_info(master->dev, "od_high=%d, od_low=%d\n",
   872				odhpp ? pp_high_period_ns : od_low_period_ns, od_low_period_ns);
   873		dev_dbg(master->dev, "i2c_high=%u, i2c_low=%u\n", ((i2cbaud >> 1) + 1) * od_low_period_ns,
   874				((i2cbaud >> 1) + 1 + (i2cbaud % 2)) * od_low_period_ns);
   875		dev_dbg(master->dev, "ppbaud=%d, pplow=%d, odbaud=%d, i2cbaud=%d\n",
   876			ppbaud, pplow, odbaud, i2cbaud);
   877		dev_info(master->dev, "mconfig=0x%x\n", readl(master->regs + NPCM_I3C_MCONFIG));
   878		/* Master core's registration */
   879		ret = i3c_master_get_free_addr(m, 0);
   880		if (ret < 0)
   881			return ret;
   882	
   883		info.dyn_addr = ret;
   884		reg = readl(master->regs + NPCM_I3C_VENDORID);
 > 885		info.pid = (NPCM_I3C_VENDORID_VID(reg) << 33) | readl(master->regs + NPCM_I3C_PARTNO);
   886	
   887		writel(NPCM_MDYNADDR_VALID | NPCM_MDYNADDR_ADDR(info.dyn_addr),
   888		       master->regs + NPCM_I3C_MDYNADDR);
   889	
   890		ret = i3c_master_set_info(&master->base, &info);
   891	
   892		return ret;
   893	}
   894	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

