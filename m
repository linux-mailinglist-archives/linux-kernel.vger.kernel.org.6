Return-Path: <linux-kernel+bounces-210763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D490486A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208D0284B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129784C94;
	Wed, 12 Jun 2024 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="He1Nf2sb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBB4411;
	Wed, 12 Jun 2024 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155705; cv=none; b=ZV0xG495fga/VL/Uv60Dc/CGIVc0ZMNCO7esHRLePrBiRYFft19YC5995Tjp5IBE1dwHUV8wMLJAcy/FDg7bn9Q6WfjThKj9/yo890Is/aP5rVEwY2N9AhnsZdO/nltKFdWLYXGiOqTjcIiKsg8Agdo/KjU/l5VwEpbkH/OQEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155705; c=relaxed/simple;
	bh=+yxlnGeFBeZpOu9F46jpspVd+qUy3HO7R8cCMNex2xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXljKV3JshRIfvCq+/rpEf5Y4ThlB50R/KGfEy/LuIC91MP4fQHAPC+boj+PHVJfZIhUemaemRyHkws4qNBP9EtTUgSGR9J7M4rwGbUnRqjIrOtaq97tGipD1FhUDqQGEZRH8l/X6B31v6zmm5I6FvkMqEBmPLf+843i4jMRrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=He1Nf2sb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718155703; x=1749691703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+yxlnGeFBeZpOu9F46jpspVd+qUy3HO7R8cCMNex2xY=;
  b=He1Nf2sbhSnJsKRcSs4WtbTWzy5bKQN7Bg4BOnjTa3svTlO/qrrxI8WB
   NbiN8OgcYvshoP6nWWRFy6jEBRcQusopqwMJrLHHDdjQZRGdsB0jFzg8k
   tq/Xe8Hdy/ykA4IfqM01mqG4owT+El7hbhZrNzijt+oGFaTjrdwHVr+K3
   q4ze6FF90tCGT0lXixq+aMX2eOWu3iegjo1CDyrmPGYuM2seyEzqmcuBO
   R3XeVrhdu3w12Dme1d/Y9eeNOJT2340m4RuC0zNQKLYYqNn52VymItks4
   w6fiFjoh5ZS4SreakXNe0EeLjxdHXxDxigyRLJdXx2dbKe6zgfJo2Btym
   w==;
X-CSE-ConnectionGUID: Vvy6Qk20SKCfzOXk5387tw==
X-CSE-MsgGUID: MmjAwTNgSQuXOkPUW/84+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="26307472"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="26307472"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 18:28:22 -0700
X-CSE-ConnectionGUID: fVlgSjgFSjaCyzUxBhze6A==
X-CSE-MsgGUID: XnTGlzf6RJuHrUVzF6vsdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="44532709"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Jun 2024 18:28:16 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHCmb-00014Z-30;
	Wed, 12 Jun 2024 01:28:13 +0000
Date: Wed, 12 Jun 2024 09:27:24 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chunkuang.hu@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, shawn.sung@mediatek.com,
	yu-chang.lee@mediatek.com, ck.hu@mediatek.com,
	jitao.shi@mediatek.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
	kernel@collabora.com, sui.jinfeng@linux.dev, michael@walle.cc,
	Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v6 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Message-ID: <202406120934.xJkzoJYC-lkp@intel.com>
References: <20240611082831.477566-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611082831.477566-4-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.10-rc3 next-20240611]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-display-mediatek-Add-OF-graph-support-for-board-path/20240611-163327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240611082831.477566-4-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v6 3/3] drm/mediatek: Implement OF graphs support for display paths
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240612/202406120934.xJkzoJYC-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 4403cdbaf01379de96f8d0d6ea4f51a085e37766)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240612/202406120934.xJkzoJYC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406120934.xJkzoJYC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/mediatek/mtk_dpi.c:21:
   In file included from include/drm/drm_atomic_helper.h:31:
   In file included from include/drm/drm_crtc.h:32:
   In file included from include/drm/drm_modes.h:33:
   In file included from include/drm/drm_connector.h:32:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/mediatek/mtk_dpi.c:711:17: error: use of undeclared identifier 'dsi'; did you mean 'dpi'?
     711 |                 ret = PTR_ERR(dsi->next_bridge);
         |                               ^~~
         |                               dpi
   drivers/gpu/drm/mediatek/mtk_dpi.c:706:18: note: 'dpi' declared here
     706 |         struct mtk_dpi *dpi = bridge_to_dpi(bridge);
         |                         ^
   5 warnings and 1 error generated.


vim +711 drivers/gpu/drm/mediatek/mtk_dpi.c

   702	
   703	static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
   704					 enum drm_bridge_attach_flags flags)
   705	{
   706		struct mtk_dpi *dpi = bridge_to_dpi(bridge);
   707		int ret;
   708	
   709		dpi->next_bridge = devm_drm_of_get_bridge(dpi->dev, dpi->dev->of_node, 1, -1);
   710		if (IS_ERR(dpi->next_bridge)) {
 > 711			ret = PTR_ERR(dsi->next_bridge);
   712			if (ret == -EPROBE_DEFER)
   713				return ret;
   714	
   715			/* Old devicetree has only one endpoint */
   716			dpi->next_bridge = devm_drm_of_get_bridge(dpi->dev, dpi->dev->of_node, 0, 0);
   717			if (IS_ERR(dpi->next_bridge))
   718				return dev_err_probe(dpi->dev, PTR_ERR(dpi->next_bridge),
   719						     "Failed to get bridge\n");
   720		}
   721	
   722		return drm_bridge_attach(bridge->encoder, dpi->next_bridge,
   723					 &dpi->bridge, flags);
   724	}
   725	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

