Return-Path: <linux-kernel+bounces-340188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72280986F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2E1283D88
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306A1AB6F3;
	Thu, 26 Sep 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRGws5sT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643D1A727E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341510; cv=none; b=nXOYg/DDMSzIWKLustzGBfciC0zZnWOPNWkjlY5AV7Lbndq90XwXeRmROnZu8vTjSNYZg0gLMqxnZK/qng1ArQqmmX9bxPU8Ec+DeMh2z0opq5KijZzkYOKOZc3YJAD/xBrtOId7bsyMobrC3z3P2jynGcE7zkhuG92ZkMZ6Zl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341510; c=relaxed/simple;
	bh=b6+jCnC/FvdrNVDaDF8tNm/ESaNNunVryxNFP3hGpHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFemF0Au9Qecai0XLoxOJ5vE1lYdHHAXMSOuSBfvamxttO9Qb/hMiu5N5RUFtvxggXTENwXeSsZmUppXBomSVTWu88GCrWQ5CzXOgVtU7Xa+O0wHXmMGq3buH0DCYy8Sj30AEsgFv/0yAC23rPVqL1Jm+N8SL/W/FIJPpNDcuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRGws5sT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727341509; x=1758877509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b6+jCnC/FvdrNVDaDF8tNm/ESaNNunVryxNFP3hGpHE=;
  b=lRGws5sTDiilQDSSiqNhhYcEk2zSnjoXIVe+PN4wmAHo/DO3IvH+s7Q7
   r7Q3xq4UcimK+x8i4QBNqAAgYly1JGgbvBcL47FqsSkCJWkg+FGp4djvR
   pv8PezeeNYj/YAm/y2Rxrs/kP9yPHDfTpRANIcEYdXnJNfP2494I+lyUC
   Steyc1O0yVLqPakZ/eVoT4LqgvxwvnTLBg5o5Y7xZX5wt1f923qHsxSR3
   8x8QnhErEqGcie4NuaAD33F8fms09fQ6NxCNNPbt0sZmxK+zsR62SLVux
   2Ze4JRshFe9HFnj0/6wQM+5B8y5Ug3OVJ+4GsASsUaZXC4LP1JrUy7K1v
   w==;
X-CSE-ConnectionGUID: G19tuV1rQcKQvbYrzZDynA==
X-CSE-MsgGUID: E1XFbQ+xREe0Y2Qh76g9/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26291589"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="26291589"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 02:04:09 -0700
X-CSE-ConnectionGUID: t6xjhyVyQwGjSswn/cVXqQ==
X-CSE-MsgGUID: HeO2LAgeQzupJqZuXX6N8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,260,1719903600"; 
   d="scan'208";a="72877919"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 26 Sep 2024 02:04:05 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stkPr-000KUr-09;
	Thu, 26 Sep 2024 09:04:03 +0000
Date: Thu, 26 Sep 2024 17:03:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Shawn Sung <shawn.sung@mediatek.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>,
	Nancy Lin <nancy.lin@mediatek.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v5 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
Message-ID: <202409261653.FyqBL1w8-lkp@intel.com>
References: <20240925101927.17042-3-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925101927.17042-3-jason-jh.lin@mediatek.com>

Hi Jason-JH.Lin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on linus/master next-20240926]
[cannot apply to v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-JH-Lin/drm-mediatek-ovl-Add-fmt_convert-function-pointer-to-driver-data/20240925-182056
base:   git://anongit.freedesktop.org/drm/drm drm-next
patch link:    https://lore.kernel.org/r/20240925101927.17042-3-jason-jh.lin%40mediatek.com
patch subject: [PATCH v5 2/2] drm/mediatek: Add blend_modes to mtk_plane_init() for different SoCs
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240926/202409261653.FyqBL1w8-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409261653.FyqBL1w8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409261653.FyqBL1w8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/mediatek/mtk_crtc.c:7:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2232:
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
   In file included from drivers/gpu/drm/mediatek/mtk_crtc.c:22:
   In file included from drivers/gpu/drm/mediatek/mtk_crtc.h:10:
>> drivers/gpu/drm/mediatek/mtk_ddp_comp.h:83:2: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
      83 |         const u32 (*get_blend_modes)(struct device *dev);
         |         ^~~~~
   drivers/gpu/drm/mediatek/mtk_ddp_comp.h:271:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     271 | const u32 mtk_ddp_comp_get_blend_modes(struct mtk_ddp_comp *comp)
         | ^~~~~
   6 warnings generated.
--
   In file included from drivers/gpu/drm/mediatek/mtk_ddp_comp.c:17:
   In file included from drivers/gpu/drm/mediatek/mtk_crtc.h:9:
   In file included from include/drm/drm_crtc.h:32:
   In file included from include/drm/drm_modes.h:33:
   In file included from include/drm/drm_connector.h:32:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2232:
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
   In file included from drivers/gpu/drm/mediatek/mtk_ddp_comp.c:17:
   In file included from drivers/gpu/drm/mediatek/mtk_crtc.h:10:
>> drivers/gpu/drm/mediatek/mtk_ddp_comp.h:83:2: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
      83 |         const u32 (*get_blend_modes)(struct device *dev);
         |         ^~~~~
   drivers/gpu/drm/mediatek/mtk_ddp_comp.h:271:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     271 | const u32 mtk_ddp_comp_get_blend_modes(struct mtk_ddp_comp *comp)
         | ^~~~~
   In file included from drivers/gpu/drm/mediatek/mtk_ddp_comp.c:19:
>> drivers/gpu/drm/mediatek/mtk_disp_drv.h:106:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     106 | const u32 mtk_ovl_get_blend_modes(struct device *dev);
         | ^~~~~
   drivers/gpu/drm/mediatek/mtk_disp_drv.h:135:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     135 | const u32 mtk_ovl_adaptor_get_blend_modes(struct device *dev);
         | ^~~~~
   drivers/gpu/drm/mediatek/mtk_disp_drv.h:170:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     170 | const u32 mtk_mdp_rdma_get_blend_modes(struct device *dev);
         | ^~~~~
   9 warnings generated.
--
   In file included from drivers/gpu/drm/mediatek/mtk_disp_ovl.c:18:
   In file included from drivers/gpu/drm/mediatek/mtk_crtc.h:9:
   In file included from include/drm/drm_crtc.h:32:
   In file included from include/drm/drm_modes.h:33:
   In file included from include/drm/drm_connector.h:32:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2232:
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
   In file included from drivers/gpu/drm/mediatek/mtk_disp_ovl.c:18:
   In file included from drivers/gpu/drm/mediatek/mtk_crtc.h:10:
>> drivers/gpu/drm/mediatek/mtk_ddp_comp.h:83:2: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
      83 |         const u32 (*get_blend_modes)(struct device *dev);
         |         ^~~~~
   drivers/gpu/drm/mediatek/mtk_ddp_comp.h:271:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     271 | const u32 mtk_ddp_comp_get_blend_modes(struct mtk_ddp_comp *comp)
         | ^~~~~
   In file included from drivers/gpu/drm/mediatek/mtk_disp_ovl.c:20:
>> drivers/gpu/drm/mediatek/mtk_disp_drv.h:106:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     106 | const u32 mtk_ovl_get_blend_modes(struct device *dev);
         | ^~~~~
   drivers/gpu/drm/mediatek/mtk_disp_drv.h:135:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     135 | const u32 mtk_ovl_adaptor_get_blend_modes(struct device *dev);
         | ^~~~~
   drivers/gpu/drm/mediatek/mtk_disp_drv.h:170:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     170 | const u32 mtk_mdp_rdma_get_blend_modes(struct device *dev);
         | ^~~~~
>> drivers/gpu/drm/mediatek/mtk_disp_ovl.c:219:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     219 | const u32 mtk_ovl_get_blend_modes(struct device *dev)
         | ^~~~~
   10 warnings generated.
--
   In file included from drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:7:
   In file included from include/drm/drm_of.h:8:
   In file included from include/drm/drm_bridge.h:30:
   In file included from include/drm/drm_atomic.h:31:
   In file included from include/drm/drm_crtc.h:32:
   In file included from include/drm/drm_modes.h:33:
   In file included from include/drm/drm_connector.h:32:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2232:
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
   In file included from drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:20:
>> drivers/gpu/drm/mediatek/mtk_ddp_comp.h:83:2: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
      83 |         const u32 (*get_blend_modes)(struct device *dev);
         |         ^~~~~
   drivers/gpu/drm/mediatek/mtk_ddp_comp.h:271:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     271 | const u32 mtk_ddp_comp_get_blend_modes(struct mtk_ddp_comp *comp)
         | ^~~~~
   In file included from drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:21:
>> drivers/gpu/drm/mediatek/mtk_disp_drv.h:106:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     106 | const u32 mtk_ovl_get_blend_modes(struct device *dev);
         | ^~~~~
   drivers/gpu/drm/mediatek/mtk_disp_drv.h:135:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     135 | const u32 mtk_ovl_adaptor_get_blend_modes(struct device *dev);
         | ^~~~~
   drivers/gpu/drm/mediatek/mtk_disp_drv.h:170:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     170 | const u32 mtk_mdp_rdma_get_blend_modes(struct device *dev);
         | ^~~~~
>> drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:403:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     403 | const u32 mtk_ovl_adaptor_get_blend_modes(struct device *dev)
         | ^~~~~
   10 warnings generated.
--
   In file included from drivers/gpu/drm/mediatek/mtk_mdp_rdma.c:15:
   In file included from drivers/gpu/drm/mediatek/mtk_disp_drv.h:13:
   In file included from drivers/gpu/drm/mediatek/mtk_plane.h:10:
   In file included from include/drm/drm_crtc.h:32:
   In file included from include/drm/drm_modes.h:33:
   In file included from include/drm/drm_connector.h:32:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2232:
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
   In file included from drivers/gpu/drm/mediatek/mtk_mdp_rdma.c:15:
>> drivers/gpu/drm/mediatek/mtk_disp_drv.h:106:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     106 | const u32 mtk_ovl_get_blend_modes(struct device *dev);
         | ^~~~~
   drivers/gpu/drm/mediatek/mtk_disp_drv.h:135:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     135 | const u32 mtk_ovl_adaptor_get_blend_modes(struct device *dev);
         | ^~~~~
   drivers/gpu/drm/mediatek/mtk_disp_drv.h:170:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     170 | const u32 mtk_mdp_rdma_get_blend_modes(struct device *dev);
         | ^~~~~
   In file included from drivers/gpu/drm/mediatek/mtk_mdp_rdma.c:16:
   In file included from drivers/gpu/drm/mediatek/mtk_drm_drv.h:10:
>> drivers/gpu/drm/mediatek/mtk_ddp_comp.h:83:2: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
      83 |         const u32 (*get_blend_modes)(struct device *dev);
         |         ^~~~~
   drivers/gpu/drm/mediatek/mtk_ddp_comp.h:271:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     271 | const u32 mtk_ddp_comp_get_blend_modes(struct mtk_ddp_comp *comp)
         | ^~~~~
>> drivers/gpu/drm/mediatek/mtk_mdp_rdma.c:236:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     236 | const u32 mtk_mdp_rdma_get_blend_modes(struct device *dev)
         | ^~~~~
   10 warnings generated.


vim +/const +83 drivers/gpu/drm/mediatek/mtk_ddp_comp.h

    48	
    49	struct mtk_ddp_comp;
    50	struct cmdq_pkt;
    51	struct mtk_ddp_comp_funcs {
    52		int (*power_on)(struct device *dev);
    53		void (*power_off)(struct device *dev);
    54		int (*clk_enable)(struct device *dev);
    55		void (*clk_disable)(struct device *dev);
    56		void (*config)(struct device *dev, unsigned int w,
    57			       unsigned int h, unsigned int vrefresh,
    58			       unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
    59		void (*start)(struct device *dev);
    60		void (*stop)(struct device *dev);
    61		void (*register_vblank_cb)(struct device *dev,
    62					   void (*vblank_cb)(void *),
    63					   void *vblank_cb_data);
    64		void (*unregister_vblank_cb)(struct device *dev);
    65		void (*enable_vblank)(struct device *dev);
    66		void (*disable_vblank)(struct device *dev);
    67		unsigned int (*supported_rotations)(struct device *dev);
    68		unsigned int (*layer_nr)(struct device *dev);
    69		int (*layer_check)(struct device *dev,
    70				   unsigned int idx,
    71				   struct mtk_plane_state *state);
    72		void (*layer_config)(struct device *dev, unsigned int idx,
    73				     struct mtk_plane_state *state,
    74				     struct cmdq_pkt *cmdq_pkt);
    75		unsigned int (*gamma_get_lut_size)(struct device *dev);
    76		void (*gamma_set)(struct device *dev,
    77				  struct drm_crtc_state *state);
    78		void (*bgclr_in_on)(struct device *dev);
    79		void (*bgclr_in_off)(struct device *dev);
    80		void (*ctm_set)(struct device *dev,
    81				struct drm_crtc_state *state);
    82		struct device * (*dma_dev_get)(struct device *dev);
  > 83		const u32 (*get_blend_modes)(struct device *dev);
    84		const u32 *(*get_formats)(struct device *dev);
    85		size_t (*get_num_formats)(struct device *dev);
    86		void (*connect)(struct device *dev, struct device *mmsys_dev, unsigned int next);
    87		void (*disconnect)(struct device *dev, struct device *mmsys_dev, unsigned int next);
    88		void (*add)(struct device *dev, struct mtk_mutex *mutex);
    89		void (*remove)(struct device *dev, struct mtk_mutex *mutex);
    90		unsigned int (*encoder_index)(struct device *dev);
    91		enum drm_mode_status (*mode_valid)(struct device *dev, const struct drm_display_mode *mode);
    92	};
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

