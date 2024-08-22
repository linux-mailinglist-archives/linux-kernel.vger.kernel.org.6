Return-Path: <linux-kernel+bounces-296537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB90095ABDA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A201F282785
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BC81CD2B;
	Thu, 22 Aug 2024 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/EVDd8B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDC208B8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297124; cv=none; b=W9rt7/0hPjpCGafkvKKAycHq3/uaWqPlPj0aQVteY0nuHdeMpjvovsH5iLpOOdPRfnxhWe0tX9kVGf0sgj98R6C0cZffR/tC0O09I0v4C9GPKNDxMlqAZp5HBvU5pm8WMJK5pLMT8zy388Lw+a47/DsaK/bleD32JSWohnpAKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297124; c=relaxed/simple;
	bh=MIqF375ibJSnM4YyPzDw9hdtZR7zLyO70D4shPrCUuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brkpgjxWEBRw4ec1tAFHjiFSga0Y7JXw4/oWRKwrmKEStWwJaS1Kj2Z+PEnaVbQrx1Fj3i9ffIacwkf/mKED1g0as1BgHTDcZZhbFAXqqkI5UnmgDSOwV5svV/d2uE+5FMyNnPpBMgQML8AiTIH4YZIszOlMbLDUIav3XHgxS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/EVDd8B; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724297122; x=1755833122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MIqF375ibJSnM4YyPzDw9hdtZR7zLyO70D4shPrCUuc=;
  b=A/EVDd8BHcD6kPEqtZ8g/DiufifFGnoyw54hR0JQLEMQqfFWlcYCX2+e
   Ae5ISuqaW5vidJLzQa9sA849a+CbionT3/FBDZGThobjcpGvgbqAnlMrb
   ey9tyYFLZUMpg4yBKU+CBtLkL96qQAEkaOOeZ9sF3K3PaGfuo6JD2fl5X
   7IqhxfGIQS6rigoile2n0VnZQ/jkzdJoD3FVqDWZuE5qEXgoAa5tPOx5/
   aUxUxqMdiIXRaO7XR1MKH5ptvd71szX93JJYR15seKvKVDhQMLF3HyOqe
   K6LggP8DSoD6MNXO/vDa8zMqaDzx5CzITbH9YCCRTMvgeZTBQsnbPxc+6
   Q==;
X-CSE-ConnectionGUID: 8uY/iAQMQKOVAUVGXztZCw==
X-CSE-MsgGUID: P4G87kxySASdmjVkqbHwTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="13145927"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="13145927"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 20:25:19 -0700
X-CSE-ConnectionGUID: a+MHE1AlS0u6A2stIc492g==
X-CSE-MsgGUID: 8r2pG5hBR0Ku5ZDhLueedg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61288490"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Aug 2024 20:25:17 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgyRm-000CET-2h;
	Thu, 22 Aug 2024 03:25:14 +0000
Date: Thu, 22 Aug 2024 11:24:51 +0800
From: kernel test robot <lkp@intel.com>
To: Charles Han <hanchunchao@inspur.com>, neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com, mripard@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, liuyanming@ieisystem.com,
	hanchunchao <hanchunchao@inspur.com>
Subject: Re: [PATCH] drm/panel/hx83102: fix null pointer dereference in
 hx83102_get_modes
Message-ID: <202408221127.2O9Pauzi-lkp@intel.com>
References: <20240821095039.15282-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821095039.15282-1-hanchunchao@inspur.com>

Hi Charles,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc4 next-20240821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charles-Han/drm-panel-hx83102-fix-null-pointer-dereference-in-hx83102_get_modes/20240821-191703
base:   linus/master
patch link:    https://lore.kernel.org/r/20240821095039.15282-1-hanchunchao%40inspur.com
patch subject: [PATCH] drm/panel/hx83102: fix null pointer dereference in hx83102_get_modes
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240822/202408221127.2O9Pauzi-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408221127.2O9Pauzi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221127.2O9Pauzi-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/panel/panel-himax-hx83102.c:12:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-himax-hx83102.c:569:11: error: incompatible pointer types passing 'struct drm_device *' to parameter of type 'const struct device *' [-Werror,-Wincompatible-pointer-types]
     569 |                 dev_err(connector->dev, "bad mode or failed to add mode\n");
         |                         ^~~~~~~~~~~~~~
   include/linux/dev_printk.h:154:44: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~
   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/dev_printk.h:50:36: note: passing argument to parameter 'dev' here
      50 | void _dev_err(const struct device *dev, const char *fmt, ...);
         |                                    ^
   4 warnings and 1 error generated.


vim +569 drivers/gpu/drm/panel/panel-himax-hx83102.c

   559	
   560	static int hx83102_get_modes(struct drm_panel *panel,
   561				    struct drm_connector *connector)
   562	{
   563		struct hx83102 *ctx = panel_to_hx83102(panel);
   564		const struct drm_display_mode *m = ctx->desc->modes;
   565		struct drm_display_mode *mode;
   566	
   567		mode = drm_mode_duplicate(connector->dev, m);
   568		if (!mode) {
 > 569			dev_err(connector->dev, "bad mode or failed to add mode\n");
   570			return -EINVAL;
   571		}
   572	
   573		mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
   574		drm_mode_set_name(mode);
   575		drm_mode_probed_add(connector, mode);
   576	
   577		connector->display_info.width_mm = ctx->desc->size.width_mm;
   578		connector->display_info.height_mm = ctx->desc->size.height_mm;
   579		connector->display_info.bpc = 8;
   580	
   581		return 1;
   582	}
   583	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

