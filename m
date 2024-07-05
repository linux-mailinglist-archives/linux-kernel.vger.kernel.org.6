Return-Path: <linux-kernel+bounces-241814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE7C927FDE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB0C1C21DE7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C538C12B77;
	Fri,  5 Jul 2024 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWYLNnSZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1279D3;
	Fri,  5 Jul 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144267; cv=none; b=PpjjxvjgU7iOmWtI7YmZbCOSQ5QsvNFFrITLd6NE7O7lYyF+iIsPw/rwx5yTFatMcvshibgPUp8uy9HPyIQMiB6uXisHUxWoT9kZbW3ZBQJe4D+RlGeDTnf0lbgvIvo2ZSE6qczIXFMDJ9gNBUMISfckbQxzqqFjOcC6ya61FIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144267; c=relaxed/simple;
	bh=CRRfXqrbQs7tLcrxZpfuE5Kh1RIwcGT87Lps4lI9koU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbBYOaErqFDN/mh1pti2znfUygoEPuGHytvD6YpSoJURJnyllEVuwkQm9MP/1CvyzqJRtlDWZenyfmc0nlphMop4cb9IEh1+cV92ULkqmz7aidIDWk7//kmujEFj1pzKQh6ln3E+UKGXODvFEsHkkCYAx9ufCXajlDn+ghlFIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWYLNnSZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720144264; x=1751680264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CRRfXqrbQs7tLcrxZpfuE5Kh1RIwcGT87Lps4lI9koU=;
  b=IWYLNnSZVCro8PlEsvNuvfTA8fz7bYy3XIloLaCvrQ5nYNA+meHOn2Og
   C4lTjR/3NLQBY0U88EY/ydBpX3YhdIf5L61Wbo4MXQxDcRsAEdX624KPN
   tUgZDQGrc2Lt0eoIe21JyD5pDO1ecvk5sIXI57MJp3PnOrqk7OtqOHtXG
   CX8nHdP+/uKtYdGKrAJMbCSveuaRS85cypNxJsqVwqS2YrQYZxXUCt0OV
   AxOXuLBGC36e1QeQ8FsXEctZ/IQdNdLy1QsJi66fWSImfm/TFkJUb/Gj5
   J3DDHif2U3Sh7+qFicABOBW6JNMGbKPEvjbmmteWm6w7Nhm6bnC5KufG3
   w==;
X-CSE-ConnectionGUID: NIBPJVoxQL2l7WhcOxyOaQ==
X-CSE-MsgGUID: J94FQyDgQeqEgXXInLVVqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21239041"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="21239041"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 18:51:04 -0700
X-CSE-ConnectionGUID: wGr7m+PyRo+lra4tO7HwPw==
X-CSE-MsgGUID: Fawo+R7ISN+VwmUeHScWeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46699156"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 Jul 2024 18:50:59 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPY6D-000RlE-27;
	Fri, 05 Jul 2024 01:50:57 +0000
Date: Fri, 5 Jul 2024 09:50:41 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 4/4] clk: eyeq: add driver
Message-ID: <202407050921.S41aCBdD-lkp@intel.com>
References: <20240703-mbly-clk-v2-4-fe8c6199a579@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703-mbly-clk-v2-4-fe8c6199a579@bootlin.com>

Hi Théo,

kernel test robot noticed the following build errors:

[auto build test ERROR on f2661062f16b2de5d7b6a5c42a9a5c96326b8454]

url:    https://github.com/intel-lab-lkp/linux/commits/Th-o-Lebrun/Revert-dt-bindings-clock-mobileye-eyeq5-clk-add-bindings/20240704-211515
base:   f2661062f16b2de5d7b6a5c42a9a5c96326b8454
patch link:    https://lore.kernel.org/r/20240703-mbly-clk-v2-4-fe8c6199a579%40bootlin.com
patch subject: [PATCH v2 4/4] clk: eyeq: add driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240705/202407050921.S41aCBdD-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407050921.S41aCBdD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407050921.S41aCBdD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/clk/clk-eyeq.c:30:
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
   In file included from drivers/clk/clk-eyeq.c:30:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/clk/clk-eyeq.c:30:
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
>> drivers/clk/clk-eyeq.c:264:9: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     264 |                 val = readq(priv->base + pll->reg64);
         |                       ^
   drivers/clk/clk-eyeq.c:724:9: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     724 |                 val = readq(base + pll->reg64);
         |                       ^
   6 warnings and 2 errors generated.


vim +/readq +264 drivers/clk/clk-eyeq.c

   249	
   250	static void eqc_probe_init_plls(struct device *dev, struct eqc_priv *priv)
   251	{
   252		const struct eqc_match_data *data = priv->data;
   253		unsigned long mult, div, acc;
   254		const struct eqc_pll *pll;
   255		struct clk_hw *hw;
   256		unsigned int i;
   257		u32 r0, r1;
   258		u64 val;
   259		int ret;
   260	
   261		for (i = 0; i < data->pll_count; i++) {
   262			pll = &data->plls[i];
   263	
 > 264			val = readq(priv->base + pll->reg64);
   265			r0 = val;
   266			r1 = val >> 32;
   267	
   268			ret = eqc_pll_parse_registers(r0, r1, &mult, &div, &acc);
   269			if (ret) {
   270				dev_warn(dev, "failed parsing state of %s\n", pll->name);
   271				priv->cells->hws[pll->index] = ERR_PTR(ret);
   272				continue;
   273			}
   274	
   275			hw = clk_hw_register_fixed_factor_with_accuracy_fwname(dev,
   276					dev->of_node, pll->name, "ref", 0, mult, div, acc);
   277			priv->cells->hws[pll->index] = hw;
   278			if (IS_ERR(hw))
   279				dev_warn(dev, "failed registering %s: %pe\n", pll->name, hw);
   280		}
   281	}
   282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

