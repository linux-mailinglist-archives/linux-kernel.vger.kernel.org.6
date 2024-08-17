Return-Path: <linux-kernel+bounces-290701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B939955799
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 13:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAC91C20CF9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F414F12F;
	Sat, 17 Aug 2024 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GS+SpAb+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2214C5A1;
	Sat, 17 Aug 2024 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723895260; cv=none; b=fUtE91Z0L0ac53517WyVkCsmk0YMZEyOc+Seiwvl97g3rtFq6m54mR6Fa/H2PIWCQPNFAc6rVXU3PeO6vN+7SY0rxztATCEiSBKRK2o15azyDeSD6fYyl1TY7fNDYoGsGxZ+i+by+dm8O+RgDVPVQPnuIvIYW5gh+SF6rk28Cyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723895260; c=relaxed/simple;
	bh=7Nl5C5yKlWmxuPZUnab0lKQEClWPdNHEEPknwLnWMvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeAGDwtz1Wf/qSPZBDFTBAB+KCh/Wz7G9997Fp69R3JYQs4Mnl/O9quA3lbstDgpLJ0MAgJ45Xvas4Omus3v/roVuiLmMx0TQTz8VbOWTs3CQIWTUXISpufTAufqHn58ZmgTfH3jxl56GsZk8p+ozXsyWbeqt/nR+c5G2fxklBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GS+SpAb+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723895259; x=1755431259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Nl5C5yKlWmxuPZUnab0lKQEClWPdNHEEPknwLnWMvI=;
  b=GS+SpAb+78cKsFJep7belkBOt1O14kIXvLZhkKqBE59N5/gxB4lAtI85
   MtfmGrmEdD+W3FPkyo1Bbpe4F1CUmtWLqP0su3V+k1F+v7vZwO/p008Jd
   3Tx+4rzcM+7RipELSSaqdXF94hrE3kQ0wa07yjy1P7nEi4LbDi/pawWhE
   ReyKebfcdgjGqyrb2L2MFi7zZnFCjihHpF+5R+uXQ+rQQkTNAlhjOAh6W
   V2wBKBYQghf6Se16SFmMs4X7nfqvgjk+XEt2f0kGttvcexs4cvULAmDqo
   i0HmiEyKvWJ0JH13BQAK51ptf8rHYQ9BhtsZj2AD3nWAMPkxVGyz1TUxc
   w==;
X-CSE-ConnectionGUID: 9Z7dgvzCSzeFW+3MIX2whg==
X-CSE-MsgGUID: SHEK5VJLQpGb+4srxzHSzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25939110"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="25939110"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 04:47:39 -0700
X-CSE-ConnectionGUID: BnlF3TVGSkSm1y9iDtOM7w==
X-CSE-MsgGUID: gHB14GcyQS+c+ppRrwJKOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="60196672"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Aug 2024 04:47:35 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfHu8-0007Pg-2D;
	Sat, 17 Aug 2024 11:47:32 +0000
Date: Sat, 17 Aug 2024 19:46:48 +0800
From: kernel test robot <lkp@intel.com>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH V2] clk: qcom: clk-alpha-pll: Simplify the
 zonda_pll_adjust_l_val()
Message-ID: <202408171932.T7RdTd9M-lkp@intel.com>
References: <20240814102005.33493-1-quic_skakitap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814102005.33493-1-quic_skakitap@quicinc.com>

Hi Satya,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240814]
[cannot apply to clk/clk-next v6.11-rc3 v6.11-rc2 v6.11-rc1 linus/master v6.11-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Satya-Priya-Kakitapalli/clk-qcom-clk-alpha-pll-Simplify-the-zonda_pll_adjust_l_val/20240815-001519
base:   next-20240814
patch link:    https://lore.kernel.org/r/20240814102005.33493-1-quic_skakitap%40quicinc.com
patch subject: [PATCH V2] clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240817/202408171932.T7RdTd9M-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408171932.T7RdTd9M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408171932.T7RdTd9M-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/clk/qcom/clk-alpha-pll.c:10:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/clk/qcom/clk-alpha-pll.c:10:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/clk/qcom/clk-alpha-pll.c:10:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   drivers/clk/qcom/clk-alpha-pll.c:2125:14: warning: comparison of distinct pointer types ('typeof ((rate)) *' (aka 'unsigned long *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
    2125 |         remainder = do_div(rate, prate);
         |                     ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
>> drivers/clk/qcom/clk-alpha-pll.c:2125:14: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
    2125 |         remainder = do_div(rate, prate);
         |                     ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                                      ^
   drivers/clk/qcom/clk-alpha-pll.c:2125:14: warning: shift count >= width of type [-Wshift-count-overflow]
    2125 |         remainder = do_div(rate, prate);
         |                     ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   8 warnings and 1 error generated.


vim +2125 drivers/clk/qcom/clk-alpha-pll.c

  2120	
  2121	static void zonda_pll_adjust_l_val(unsigned long rate, unsigned long prate, u32 *l)
  2122	{
  2123		u64 remainder;
  2124	
> 2125		remainder = do_div(rate, prate);
  2126	
  2127		*l = rate + (u32)(remainder * 2 >= prate);
  2128	}
  2129	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

