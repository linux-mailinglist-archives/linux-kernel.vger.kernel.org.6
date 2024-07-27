Return-Path: <linux-kernel+bounces-264285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5644493E122
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDAFB212B2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE839AE3;
	Sat, 27 Jul 2024 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJD398A8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6B8F6D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722116924; cv=none; b=D74ilu9XwhMG1Z9JvaVWsuYwtpwGuUHtfGc5IfJ/329QiUHk9oVSsKMJNXrRg+aFVCnjea7J9M4Ito59ljczuvlUVtrZoFprDbW2NlbyXqFfXTVqhWsy1e2WVftGLNz+tF/uI76f9sLXolSnaqGoLlJ9ggHmS7auWCJTocXZXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722116924; c=relaxed/simple;
	bh=0/7JTdjU2NunOXizmj++lrsnok4A1Kgg24OQ4xODEzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hHMgC+nwVy5p53XZPuh3Ed9i8HqNbdd1zFQKEg1FoZoPv7yH0ma6l8WJ30kkd+I2WDU5N+mZ/KAWobG//Y7PaXMsj7s13NaX0t4fNL+h0Rml9jfiJbCTgCE/vkloqeljyUJVGJLlnJf3deMqgGYfvzJpy/b2+85G1Aq6Lrsk5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJD398A8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722116923; x=1753652923;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0/7JTdjU2NunOXizmj++lrsnok4A1Kgg24OQ4xODEzs=;
  b=IJD398A8zkq4PTtyQwrjlnDN0V7ROl6wU8yCjIiT+evNYT2F/l/Cy+pt
   Mx87z2yUgPtq5yke8YW3OBvE/DXyHOmyAgOVeKS3OMfmfMLQAS5ToECB7
   m8u+FmdtO7J3O/babvHPLIM5eYUspKMXrpvGVGpFutv6i08WLxDqS11c3
   WAAkUCg43OzDAWuOWhJrtfzB6XEz+MgTNddwUm7gtTLaeYrT+3Y8gNp6c
   6exhbV/eussyyFQB7BXCUxX9wgL9slp0tw+wrZwK6oPbjbys6RdWFnamm
   Bzt7gCEIPTuss2oa9C8P2JFuSi1a8iCjqEO7M17qAvWo7LOn2xFt5xE/B
   A==;
X-CSE-ConnectionGUID: chVGr1SLQD+kWtC9ZP3Pkw==
X-CSE-MsgGUID: 8KfDpQKkRO6Wtm3yasDktg==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="20015044"
X-IronPort-AV: E=Sophos;i="6.09,242,1716274800"; 
   d="scan'208";a="20015044"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 14:48:42 -0700
X-CSE-ConnectionGUID: s8EfOPczSMKCzOvxqkcZGQ==
X-CSE-MsgGUID: FnaiXTvxTbeEXnrbS5C8FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,242,1716274800"; 
   d="scan'208";a="76812479"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jul 2024 14:48:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXpHK-000qGV-1B;
	Sat, 27 Jul 2024 21:48:38 +0000
Date: Sun, 28 Jul 2024 05:48:32 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: drivers/iio/light/opt4001.c:215:9: error: call to
 '__compiletime_assert_530' declared with 'error' attribute: FIELD_PREP:
 value too large for the field
Message-ID: <202407280548.1MbEgmkH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ff30564411ffdcee49d579cb15eb13185a36e253
commit: 96e20adc43c4f81e9163a5188cee75a6dd393e09 regulator: change stubbed devm_regulator_get_enable to return Ok
date:   3 months ago
config: s390-randconfig-001-20240728 (https://download.01.org/0day-ci/archive/20240728/202407280548.1MbEgmkH-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240728/202407280548.1MbEgmkH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407280548.1MbEgmkH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/light/opt4001.c:16:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/iio/light/opt4001.c:16:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/iio/light/opt4001.c:16:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/iio/light/opt4001.c:215:9: error: call to '__compiletime_assert_530' declared with 'error' attribute: FIELD_PREP: value too large for the field
           reg |= FIELD_PREP(OPT4001_CTRL_CONV_TIME_MASK, chip->int_time);
                  ^
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^
   include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
                   ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:437:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:430:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:17:1: note: expanded from here
   __compiletime_assert_530
   ^
   12 warnings and 1 error generated.


vim +215 drivers/iio/light/opt4001.c

9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  207  
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  208  static int opt4001_set_conf(struct opt4001_chip *chip)
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  209  {
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  210  	struct device *dev = &chip->client->dev;
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  211  	u16 reg;
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  212  	int ret;
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  213  
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  214  	reg = FIELD_PREP(OPT4001_CTRL_RANGE_MASK, OPT4001_CTRL_LIGHT_SCALE_AUTO);
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26 @215  	reg |= FIELD_PREP(OPT4001_CTRL_CONV_TIME_MASK, chip->int_time);
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  216  	reg |= FIELD_PREP(OPT4001_CTRL_OPER_MODE_MASK, OPT4001_CTRL_OPER_MODE_CONTINUOUS);
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  217  
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  218  	ret = regmap_write(chip->regmap, OPT4001_CTRL, reg);
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  219  	if (ret)
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  220  		dev_err(dev, "Failed to set configuration\n");
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  221  
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  222  	return ret;
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  223  }
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  224  

:::::: The code at line 215 was first introduced by commit
:::::: 9a9608418292bb8733805c3f3123dfe0454fadac iio: light: Add support for TI OPT4001 light sensor

:::::: TO: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
:::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

