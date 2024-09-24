Return-Path: <linux-kernel+bounces-337502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19A0984AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04EA283135
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08EA1AC880;
	Tue, 24 Sep 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geVh7DAN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69C11CA0;
	Tue, 24 Sep 2024 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727202820; cv=none; b=aXgJyESqt5tQTWTtgvTcGHmy2C5xlGh0JQ7RMABsE0w6cV9x8AOTnnM6HPQBbpGtvkvsBT8qAjXt2kZ3pwaNFPgEblggJLo8Mx5v7YVSAsTiV+LzDk3atvxyLIn7KiK28jWMMbhottlxdQJwKIWqh/HIzRClZMLc0muRW/e/ZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727202820; c=relaxed/simple;
	bh=5GznWfCDnUnyKOCfGDttffNNb5sJr81NujIVW9fi2A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5EmGzoNfe+YuRxKeXhZZMmoqB5vtlBAW1MqAW7ST6xQIhYyDHwV4FeheHGIVFiblahbNCgE/M7SDpv+WD8dNTRgApLl24Dwa0O2L85xkfSLwQubSTOVavvEite+upUKNfNbWUbn8XCquMDIKFH44QTw/Z477q8tG293X9DfP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geVh7DAN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727202817; x=1758738817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5GznWfCDnUnyKOCfGDttffNNb5sJr81NujIVW9fi2A8=;
  b=geVh7DANMo+jx6ES3DcV00dhHKL4wsqLHOaca3kWCwAzxgauJVRuiyTd
   Ziv2PKM4kjM+CMzK7lYYaF38lvIvyk9JxbvKy+6rzwwgJNMLgrZDYm0N5
   zrSlnbOIEi4f3AejJYsqXs7fxZnDh3VaxE+0DWl+A9ib9yBn2FmXaqSpD
   lXm89LVQk3lbXhSow7FoSjx1N12YuuUw5WtlQ/cshRhutsKIigZOXzIhm
   T2WrHZ7I5gpaT5e7aoe+IYfNi0ZE3KRrP2r8EkVPO24VJt8tgytVmtTNS
   F/F5uzwHUsjiTt19+jbN/73G2OyIF7dft1h0eD+sh8x8dcAWTy4Cm/n7t
   g==;
X-CSE-ConnectionGUID: AdPk8WPdTkGMhnavO5DSLQ==
X-CSE-MsgGUID: lE1Pw0EqQFOD0830q8deVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="43690613"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="43690613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 11:33:36 -0700
X-CSE-ConnectionGUID: BrxgntzbQjqqAVMJPEq+cA==
X-CSE-MsgGUID: CxoHm09bTTWpi/JiWpQb7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="71122146"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2024 11:33:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stALr-000IgU-1X;
	Tue, 24 Sep 2024 18:33:31 +0000
Date: Wed, 25 Sep 2024 02:32:36 +0800
From: kernel test robot <lkp@intel.com>
To: Junhui Liu <liujh2818@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Junhui Liu <liujh2818@outlook.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] reset: canaan: Add reset driver for Kendryte K230
Message-ID: <202409250201.ZlZsYfH8-lkp@intel.com>
References: <20240924-k230-reset-v1-2-d0cdc11989eb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-k230-reset-v1-2-d0cdc11989eb@outlook.com>

Hi Junhui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on abf2050f51fdca0fd146388f83cddd95a57a008d]

url:    https://github.com/intel-lab-lkp/linux/commits/Junhui-Liu/dt-bindings-reset-Add-support-for-canaan-k230-rst/20240924-140732
base:   abf2050f51fdca0fd146388f83cddd95a57a008d
patch link:    https://lore.kernel.org/r/20240924-k230-reset-v1-2-d0cdc11989eb%40outlook.com
patch subject: [PATCH 2/2] reset: canaan: Add reset driver for Kendryte K230
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240925/202409250201.ZlZsYfH8-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250201.ZlZsYfH8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250201.ZlZsYfH8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/reset/reset-k230.c:8:
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
   In file included from drivers/reset/reset-k230.c:8:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/reset/reset-k230.c:8:
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
>> drivers/reset/reset-k230.c:223:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     223 |         case RST_TYPE_SW_DONE:
         |              ^~~~~~~~~~~~~~~~
   drivers/reset/reset-k230.c:231:9: note: uninitialized use occurs here
     231 |         return ret;
         |                ^~~
   drivers/reset/reset-k230.c:214:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     214 |         case RST_TYPE_CPU1:
         |              ^~~~~~~~~~~~~
   drivers/reset/reset-k230.c:231:9: note: uninitialized use occurs here
     231 |         return ret;
         |                ^~~
   drivers/reset/reset-k230.c:215:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     215 |         case RST_TYPE_FLUSH:
         |              ^~~~~~~~~~~~~~
   drivers/reset/reset-k230.c:231:9: note: uninitialized use occurs here
     231 |         return ret;
         |                ^~~
   drivers/reset/reset-k230.c:206:9: note: initialize the variable 'ret' to silence this warning
     206 |         int ret;
         |                ^
         |                 = 0
   drivers/reset/reset-k230.c:250:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     250 |         case RST_TYPE_SW_DONE:
         |              ^~~~~~~~~~~~~~~~
   drivers/reset/reset-k230.c:258:9: note: uninitialized use occurs here
     258 |         return ret;
         |                ^~~
   drivers/reset/reset-k230.c:247:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     247 |         case RST_TYPE_FLUSH:
         |              ^~~~~~~~~~~~~~
   drivers/reset/reset-k230.c:258:9: note: uninitialized use occurs here
     258 |         return ret;
         |                ^~~
   drivers/reset/reset-k230.c:248:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     248 |         case RST_TYPE_HW_DONE:
         |              ^~~~~~~~~~~~~~~~
   drivers/reset/reset-k230.c:258:9: note: uninitialized use occurs here
     258 |         return ret;
         |                ^~~
   drivers/reset/reset-k230.c:241:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     241 |         case RST_TYPE_CPU0:
         |              ^~~~~~~~~~~~~
   drivers/reset/reset-k230.c:258:9: note: uninitialized use occurs here
     258 |         return ret;
         |                ^~~
   drivers/reset/reset-k230.c:238:9: note: initialize the variable 'ret' to silence this warning
     238 |         int ret;
         |                ^
         |                 = 0
   13 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/ret +223 drivers/reset/reset-k230.c

   201	
   202	static int k230_rst_assert(struct reset_controller_dev *rcdev, unsigned long id)
   203	{
   204		struct k230_rst *rstc = to_k230_rst(rcdev);
   205		const struct k230_rst_map *rmap = &k230_resets[id];
   206		int ret;
   207	
   208		switch (rmap->type) {
   209		case RST_TYPE_CPU0:
   210			k230_rst_clear_done(rstc, id, true);
   211			k230_rst_update(rstc, id, true, true, false);
   212			ret = k230_rst_wait_and_clear_done(rstc, id, true);
   213			break;
   214		case RST_TYPE_CPU1:
   215		case RST_TYPE_FLUSH:
   216			k230_rst_update(rstc, id, true, true, false);
   217			break;
   218		case RST_TYPE_HW_DONE:
   219			k230_rst_clear_done(rstc, id, false);
   220			k230_rst_update(rstc, id, true, false, false);
   221			ret = k230_rst_wait_and_clear_done(rstc, id, false);
   222			break;
 > 223		case RST_TYPE_SW_DONE:
   224			k230_rst_update(rstc, id, true, false,
   225					id == RST_SPI2AXI ? false : true);
   226			break;
   227		default:
   228			return -EINVAL;
   229		}
   230	
   231		return ret;
   232	}
   233	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

