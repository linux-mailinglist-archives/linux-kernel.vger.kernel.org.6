Return-Path: <linux-kernel+bounces-296426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428DB95AAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE912839F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3AF17BAF;
	Thu, 22 Aug 2024 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcnwR5T+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63811712
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724293337; cv=none; b=l8lbnvwRFkhGqOCXULtjEwnI1XW6b5xKLlnks0E9jP98zrCuL6IXDEdKJ3Gtx34c7V+E5tgGQP8AC2+DpoldoWmJ/3JlZS6V5cKiQ3kJ3hBL1hmbFWM9qEYCpNoWOzbqmemH5NvsCLz4UHxkt24tmH7n0oZko084tIaaLYVp2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724293337; c=relaxed/simple;
	bh=WJtefoxByD+Lkl4bQmndoIh/R6ngWiEkC/fObPJ29CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/qexndBCEkWCvWqQLiPNwxWEBGKf9+5QPwqdUwE3+TpQ7odTPNFfIR4xEmK36sxSM/FTOBPrxEaRJJLPZQWlRvlb7lkrqA7kkCfELC6m9+kqbGQX6iiOMz/mqsrwm2IX4rMIgGsIr1GBsANctIf2p4e1AYXPbFrAgI6HbNoM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcnwR5T+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724293336; x=1755829336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WJtefoxByD+Lkl4bQmndoIh/R6ngWiEkC/fObPJ29CU=;
  b=YcnwR5T+R6WWGDUhCJdt7ziNLxC9cslYZyEs9NC8U6AW9nOlFGDrc3yI
   INJLJqpEgkahY4zLMVCrfCHgG/wcxBfCKiCFWm69Xmukzxdd6zKPAHioL
   K6vSEHPq7GB8cNp6nW9ICQYSjOjrXZvWtN+yINEsm7k9V1+OvY4aiAyv3
   lT17qOWb5oK4VT783gqXREudEv7lMzmit/GweRQJTrmyI0DXNPI/dSK0u
   64Xrno6MMxtQejAGkoAdS7olg0Dn1DN3VCcQLrbbGu6vDJEotioUeZ+Vi
   UR0RzZhr2ZcV1cG+BlmRmZKK0aATMngTvr8SfhyQA5LpwduwWh+1cHFw0
   A==;
X-CSE-ConnectionGUID: z0xpg7XUSASTA3mrURGQKQ==
X-CSE-MsgGUID: SNRvWaPWRZ2YC21CnERikA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22295834"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22295834"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 19:22:15 -0700
X-CSE-ConnectionGUID: RqiLgtclT7C8ukGKDldJNg==
X-CSE-MsgGUID: wfGEYu3ASb+Oi8n3oMh1SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="66233019"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2024 19:22:14 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgxSl-000CB4-0m;
	Thu, 22 Aug 2024 02:22:11 +0000
Date: Thu, 22 Aug 2024 10:21:18 +0800
From: kernel test robot <lkp@intel.com>
To: Charles Han <hanchunchao@inspur.com>, neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com, mripard@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	liuyanming@ieisystem.com, hanchunchao <hanchunchao@inspur.com>
Subject: Re: [PATCH] drm/panel/hx83102: fix null pointer dereference in
 hx83102_get_modes
Message-ID: <202408221044.vVHNGMnS-lkp@intel.com>
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
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240822/202408221044.vVHNGMnS-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408221044.vVHNGMnS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221044.vVHNGMnS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/blk_types.h:11,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:23,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from include/linux/regulator/consumer.h:35,
                    from drivers/gpu/drm/panel/panel-himax-hx83102.c:14:
   drivers/gpu/drm/panel/panel-himax-hx83102.c: In function 'hx83102_get_modes':
>> drivers/gpu/drm/panel/panel-himax-hx83102.c:569:34: error: passing argument 1 of '_dev_err' from incompatible pointer type [-Wincompatible-pointer-types]
     569 |                 dev_err(connector->dev, "bad mode or failed to add mode\n");
         |                         ~~~~~~~~~^~~~~
         |                                  |
         |                                  struct drm_device *
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/gpu/drm/panel/panel-himax-hx83102.c:569:17: note: in expansion of macro 'dev_err'
     569 |                 dev_err(connector->dev, "bad mode or failed to add mode\n");
         |                 ^~~~~~~
   include/linux/dev_printk.h:50:36: note: expected 'const struct device *' but argument is of type 'struct drm_device *'
      50 | void _dev_err(const struct device *dev, const char *fmt, ...);
         |               ~~~~~~~~~~~~~~~~~~~~~^~~


vim +/_dev_err +569 drivers/gpu/drm/panel/panel-himax-hx83102.c

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

