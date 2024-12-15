Return-Path: <linux-kernel+bounces-446567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F669F264C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959E77A066D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E61B4150;
	Sun, 15 Dec 2024 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOduRoFZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77A148304
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734298647; cv=none; b=S7E7xpfRLlS8r9ZBLVstsl8wO3k7OdFrd60ELUee0lxflAkIuSjSEzfOo4gMy83zFKSkPQZskjQpjSuhJvf8zfNJfGm8Jhen6ZMCNIvBgdFX4AKQ/BNmrboXDWnTKO1rB8CAQEkuzBXn54o2SDTuf//fSyBeoIAYTIakF6Neh9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734298647; c=relaxed/simple;
	bh=YOiwtzBeRStAm5MVEesSPTnSKXxiVBin33yPvy82/YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So9ZTSNC2A2+rqtIR3QM4QJ9Nii84m3TqdcXiN5HzCZOos+wEYzHef05bS6/t4hHMno8zq6Xe/bb1ljs78F5gwI4sk3Q9NLTgRFlRsJf5UIQ+J8E563kDTY1hcGJ8KuBTuO8MQyV0DVEmUNBBMOQDQti086MQpBhRXUMFs6ITts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOduRoFZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734298645; x=1765834645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOiwtzBeRStAm5MVEesSPTnSKXxiVBin33yPvy82/YU=;
  b=QOduRoFZ2tZGJmNeFyjBXPJcug+GAzihOJf73S8vkN3hlLiNobxsR1rv
   tue1lX19c7aBmjE/16d41nSjoqlA8r+KJeLLCEjbXafy+/HG6YRFcwrAp
   VgGnXII15OusWrW9Ty4xbPiwD/+ZaKp6bceIQY6PYReVAPGKNeBntXgQR
   TIgDOBBpUKFktPkIwPTqdxjyrbBSkbL+Jc4dvH8e0Ftn2dc8Mixm6qjzJ
   grohxJb9yiWhCtcuL4A3IQt2+2BNC/TczZqbE83gjWhb+FqVWCZH4FSaV
   ULwYW3uvaZUatNS9GewRdYDDhPKhmEPs92xKAFny6Erhzv4bXaQIu8sz/
   w==;
X-CSE-ConnectionGUID: 0cEuTm4rTXe2jz615WWIvw==
X-CSE-MsgGUID: fm2sRinzSeKuJ8SiVjii8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34822843"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34822843"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 13:37:25 -0800
X-CSE-ConnectionGUID: zNW0scBtRgKNpdogQU0JVg==
X-CSE-MsgGUID: 6e/T0iilQKeKho9RGZdJRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128010549"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Dec 2024 13:37:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMwIi-000DsE-1M;
	Sun, 15 Dec 2024 21:37:20 +0000
Date: Mon, 16 Dec 2024 05:36:37 +0800
From: kernel test robot <lkp@intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH] mm: vmstat.h: Annotate operations between enums
Message-ID: <202412160507.MwWr4a9B-lkp@intel.com>
References: <20241202-fix-vmstat-v1-1-c995585b7df5@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-fix-vmstat-v1-1-c995585b7df5@chromium.org>

Hi Ricardo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Ribalda/mm-vmstat-h-Annotate-operations-between-enums/20241203-020840
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/20241202-fix-vmstat-v1-1-c995585b7df5%40chromium.org
patch subject: [PATCH] mm: vmstat.h: Annotate operations between enums
config: x86_64-randconfig-004-20241216 (https://download.01.org/0day-ci/archive/20241216/202412160507.MwWr4a9B-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241216/202412160507.MwWr4a9B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412160507.MwWr4a9B-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:7021:13: error: stack frame size (3096) exceeds limit (3072) in 'dml_core_mode_support' [-Werror,-Wframe-larger-than]
    7021 | static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out_params)
         |             ^
   1 error generated.
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6712:12: error: stack frame size (4088) exceeds limit (3072) in 'dml_core_mode_support' [-Werror,-Wframe-larger-than]
    6712 | dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
         |            ^
   1 error generated.


vim +/dml_core_mode_support +7021 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c

2563391e57b5a9 Chaitanya Dhere  2024-07-02  7020  
70839da6360500 Aurabindo Pillai 2024-04-19 @7021  static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out_params)
70839da6360500 Aurabindo Pillai 2024-04-19  7022  {
70839da6360500 Aurabindo Pillai 2024-04-19  7023  	struct dml2_core_internal_display_mode_lib *mode_lib = in_out_params->mode_lib;
70839da6360500 Aurabindo Pillai 2024-04-19  7024  	const struct dml2_display_cfg *display_cfg = in_out_params->in_display_cfg;
70839da6360500 Aurabindo Pillai 2024-04-19  7025  	const struct dml2_mcg_min_clock_table *min_clk_table = in_out_params->min_clk_table;
70839da6360500 Aurabindo Pillai 2024-04-19  7026  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

