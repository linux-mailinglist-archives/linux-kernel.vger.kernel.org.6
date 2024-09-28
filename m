Return-Path: <linux-kernel+bounces-342707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB19891F7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 00:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CBA1C2214D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E99187347;
	Sat, 28 Sep 2024 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejh2e5+K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948601802AB
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727563988; cv=none; b=pA0OE1UPiNbqmJA+QGoiZPzLcfhRKfoJF/ZtTve78vtAq8akLySa8geiO/vxyVMVKHoOz+Ry+tDs67UGi6v0ttjZtxXNzkxIZPJCeJY5q+1pgxclnaLHytIml+VcKVu+NRgu2n2cY6KqRhTI2eUnsx0L57ODRXH2gC3RaIAb9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727563988; c=relaxed/simple;
	bh=JQc0Z2OjYL4V5ha5EFr4cWv2UKg0TOWssALGaegsMts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI8gfgqtdYlXrelDi6A2tTVk4lCp3Q/lMNUdsm6OSX7P2JPhk8yzcQ/mALhz0Q02subFilSSyEM8NFrg5no6PhpnBwrerBRqqXxG7HwkscxcLZChyNGxYgkrFjT02w9ZjDt+XyFKi3UEcJ0UA/NvQdh/p9hndHplR3efd1NhhOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejh2e5+K; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727563986; x=1759099986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JQc0Z2OjYL4V5ha5EFr4cWv2UKg0TOWssALGaegsMts=;
  b=ejh2e5+KclfIAD+69qxreYXOIwaVp7bov+QZe3XwacfoUIGAe9GC4ada
   x4uL0eeTjNIyxth10gXmMdTtC7FGcip3yIuclpjDFfzlKKmDkgovFq9qD
   u9nPpP4vEU++3ZMD/xiHhiE25wb+zvMx8GNpXriEjT6B+QWpHtjkdS38q
   fHAaQ1laNbKE3li1pcpQ9DiamlOW6yhjbwjeWfBRLRjNQWi9v0DxND6x4
   Vnrscq/GxBNfl1hAJQib++vWEHlZSKrQL3617K2xhcf4pcgKX2DCT4XJP
   nN9FZuheCYX9cIgIyzRPA8rtidvj2l2KQ0UeOmIqVm5YKZmxWM5vpK/vB
   g==;
X-CSE-ConnectionGUID: lZWleAXASfettfPTwX5ZiA==
X-CSE-MsgGUID: QXy/5cP3QRyC/Ssux0ipaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="52096695"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="52096695"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 15:53:06 -0700
X-CSE-ConnectionGUID: S4HAL6U0THeeehG2HcCX5A==
X-CSE-MsgGUID: kbcuEdr5Rqa1gR96kN6zNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="72760530"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2024 15:53:02 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sugJA-000Njn-05;
	Sat, 28 Sep 2024 22:53:00 +0000
Date: Sun, 29 Sep 2024 06:52:23 +0800
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
Subject: Re: [PATCH v6 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
Message-ID: <202409290651.YLKsl39c-lkp@intel.com>
References: <20240926083526.24629-3-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926083526.24629-3-jason-jh.lin@mediatek.com>

Hi Jason-JH.Lin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on linus/master next-20240927]
[cannot apply to v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-JH-Lin/drm-mediatek-ovl-Add-blend_modes-to-driver-data/20240926-163734
base:   git://anongit.freedesktop.org/drm/drm drm-next
patch link:    https://lore.kernel.org/r/20240926083526.24629-3-jason-jh.lin%40mediatek.com
patch subject: [PATCH v6 2/2] drm/mediatek: Add blend_modes to mtk_plane_init() for different SoCs
config: arm64-randconfig-001-20240929 (https://download.01.org/0day-ci/archive/20240929/202409290651.YLKsl39c-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409290651.YLKsl39c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409290651.YLKsl39c-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/mediatek/mtk_ethdr.c:18:
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
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/mediatek/mtk_ethdr.c:18:
   In file included from drivers/gpu/drm/mediatek/mtk_crtc.h:10:
   drivers/gpu/drm/mediatek/mtk_ddp_comp.h:83:2: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
      83 |         const u32 (*get_blend_modes)(struct device *dev);
         |         ^~~~~
   drivers/gpu/drm/mediatek/mtk_ddp_comp.h:271:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     271 | const u32 mtk_ddp_comp_get_blend_modes(struct mtk_ddp_comp *comp)
         | ^~~~~
   In file included from drivers/gpu/drm/mediatek/mtk_ethdr.c:21:
>> drivers/gpu/drm/mediatek/mtk_ethdr.h:16:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
      16 | const u32 mtk_ethdr_get_blend_modes(struct device *dev);
         | ^~~~~
>> drivers/gpu/drm/mediatek/mtk_ethdr.c:148:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     148 | const u32 mtk_ethdr_get_blend_modes(struct device *dev)
         | ^~~~~
   5 warnings generated.
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
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:20:
   drivers/gpu/drm/mediatek/mtk_ddp_comp.h:83:2: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
      83 |         const u32 (*get_blend_modes)(struct device *dev);
         |         ^~~~~
   drivers/gpu/drm/mediatek/mtk_ddp_comp.h:271:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     271 | const u32 mtk_ddp_comp_get_blend_modes(struct mtk_ddp_comp *comp)
         | ^~~~~
   In file included from drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:21:
   drivers/gpu/drm/mediatek/mtk_disp_drv.h:106:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     106 | const u32 mtk_ovl_get_blend_modes(struct device *dev);
         | ^~~~~
   drivers/gpu/drm/mediatek/mtk_disp_drv.h:135:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     135 | const u32 mtk_ovl_adaptor_get_blend_modes(struct device *dev);
         | ^~~~~
   In file included from drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:23:
>> drivers/gpu/drm/mediatek/mtk_ethdr.h:16:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
      16 | const u32 mtk_ethdr_get_blend_modes(struct device *dev);
         | ^~~~~
   drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:403:1: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     403 | const u32 mtk_ovl_adaptor_get_blend_modes(struct device *dev)
         | ^~~~~
   7 warnings generated.


vim +/const +16 drivers/gpu/drm/mediatek/mtk_ethdr.h

     8	
     9	void mtk_ethdr_start(struct device *dev);
    10	void mtk_ethdr_stop(struct device *dev);
    11	int mtk_ethdr_clk_enable(struct device *dev);
    12	void mtk_ethdr_clk_disable(struct device *dev);
    13	void mtk_ethdr_config(struct device *dev, unsigned int w,
    14			      unsigned int h, unsigned int vrefresh,
    15			      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
  > 16	const u32 mtk_ethdr_get_blend_modes(struct device *dev);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

