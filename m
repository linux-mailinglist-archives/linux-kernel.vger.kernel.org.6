Return-Path: <linux-kernel+bounces-446891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615E9F2A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF64B1884A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1E41CF284;
	Mon, 16 Dec 2024 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHilZFs2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB31CEEA4;
	Mon, 16 Dec 2024 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332606; cv=none; b=GVh3rzfjOmIJlWGZokmgdw0ajqZMWvibWSSvhGc94SVMPPrFGYgdjkK18Sls1aUaRUHMDwn7tQK2o0gFRJbYVj7BqW8WJ/S8a/xnqk0MG3Ik648nGKgtPg63X64GckuiXIxTKhUw8viu/l129UHiKTs66jc4KOUNLYG1RAdJEtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332606; c=relaxed/simple;
	bh=SN2T8cm+vNsx3Mi1EyxUptHpm38RPXYJL0BrnmFuZ+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYHxH5fsVG8dVeg3F/EDUfvOI3hg2MdGyiCmgFMgvNMNTSrOBKxQc1WH97addneOYQ1ZTzX/k4LZNdT5cLEF9lNbxuzLFGvcHbGCtxE3xau1sI/3jFFXt2bJT0+Z62oAwYiCtFg4vDRQtSQFmW8owR+sEfFJsLfr3Gitg8yyS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHilZFs2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734332605; x=1765868605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SN2T8cm+vNsx3Mi1EyxUptHpm38RPXYJL0BrnmFuZ+E=;
  b=VHilZFs2vEeQb1MbHKFhqc5ABKgByKE/Bxxoa21BSKSoEKoApD4zgzfZ
   4QpLRgcUyjaAWsh+5L17isP+bR7DuKzp1paL2gxduczIXmFylu/sBcsll
   5Ra26VdJyZhRHwCEc4GiDU6t+xviCDkmYwyCHab23jPV2m908XOrh/SLz
   9IABP7bBc6aTwfxgsIQE0pGsNX0bF/MZn7tRPhuVXDirqQ1FDIz0fQYKV
   0xagTzk1yob4c49MrcMjj4MCVfSXYhOVb7DLAG9hJ/ALPSn/GfBenKF+6
   E3ccAzuDrrbNUVIEE3POW51N6bbPf1sGo1j57GQ4TarvzVOOlSLJBP6LW
   A==;
X-CSE-ConnectionGUID: U8FfrmIQRnGOZVOBr+QWRw==
X-CSE-MsgGUID: WBIGUsKSQ/mMBmAxsbDicw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34584308"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34584308"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:03:24 -0800
X-CSE-ConnectionGUID: UULt+fnGSSydPD8Ic/XKYA==
X-CSE-MsgGUID: yrIimS45TkCcS5J9bxBYgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="96991232"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Dec 2024 23:03:21 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tN58R-000E4u-2K;
	Mon, 16 Dec 2024 07:03:19 +0000
Date: Mon, 16 Dec 2024 15:02:10 +0800
From: kernel test robot <lkp@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Grant Likely <grant.likely@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Zijun Hu <zijun_hu@icloud.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] of: Fix potential wrong MODALIAS uevent value
Message-ID: <202412161436.p6lF8p6C-lkp@intel.com>
References: <20241216-of_core_fix-v2-6-e69b8f60da63@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-of_core_fix-v2-6-e69b8f60da63@quicinc.com>

Hi Zijun,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0f7ca6f69354e0c3923bbc28c92d0ecab4d50a3e]

url:    https://github.com/intel-lab-lkp/linux/commits/Zijun-Hu/of-Fix-API-of_find_node_opts_by_path-finding-OF-device-node-failure/20241216-084408
base:   0f7ca6f69354e0c3923bbc28c92d0ecab4d50a3e
patch link:    https://lore.kernel.org/r/20241216-of_core_fix-v2-6-e69b8f60da63%40quicinc.com
patch subject: [PATCH v2 6/7] of: Fix potential wrong MODALIAS uevent value
config: parisc-randconfig-002-20241216 (https://download.01.org/0day-ci/archive/20241216/202412161436.p6lF8p6C-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241216/202412161436.p6lF8p6C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412161436.p6lF8p6C-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/clk-provider.h:9,
                    from lib/vsprintf.c:23:
   include/linux/of.h: In function 'of_modalias':
>> include/linux/of.h:764:16: error: returning 'int' from a function with return type 'char *' makes pointer from integer without a cast [-Wint-conversion]
     764 |         return -ENODEV;
         |                ^
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1683:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1683 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from lib/logic_pio.c:11:
   include/linux/of.h: In function 'of_modalias':
>> include/linux/of.h:764:16: error: returning 'int' from a function with return type 'char *' makes pointer from integer without a cast [-Wint-conversion]
     764 |         return -ENODEV;
         |                ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +764 include/linux/of.h

bd69f73f2c81ee Grant Likely  2013-02-10  761  
f1f6eae8bdfdfc Zijun Hu      2024-12-16  762  static inline char *of_modalias(const struct device_node *np, ssize_t *lenp)
bd7a7ed774afd1 Miquel Raynal 2023-04-04  763  {
bd7a7ed774afd1 Miquel Raynal 2023-04-04 @764  	return -ENODEV;
bd7a7ed774afd1 Miquel Raynal 2023-04-04  765  }
bd7a7ed774afd1 Miquel Raynal 2023-04-04  766  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

