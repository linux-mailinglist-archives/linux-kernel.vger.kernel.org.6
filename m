Return-Path: <linux-kernel+bounces-336407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E64983A79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF82283C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E94C12BF32;
	Mon, 23 Sep 2024 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANZa1RzS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6B85931
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727135248; cv=none; b=lxakjlQaEb5mNj2El/uF+nDsXFQ4av9zdHpChrbrIIUZLy6q/3rh9/I/2IBwQfg3k6jnLQM4PrsV5DVlzktNabXl8xi5MGcOfzqKRAtqsKx5hsnqn210+eNc6rOUHDt1UxnmjgDQcw8Pde4p5Wi26bjopf2ZqOiYPAk3Pr6Udag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727135248; c=relaxed/simple;
	bh=5Uj5mtdoOAx4kTnVRoWRzMXPTIVr/7eKH1rcTgJl9kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOx7p2anjqELmX5V7hh2b7oWGxGuRqI/zwtL370/+RcNOf1YRrvn9gE6tlM9v79bHiuwEFC5y6jKu/p3LUOlZNpgholii3R6q46fKKOv2mzQmiczcMvJh2Bk6CbMRByq0eUnl9OxDjCzK9TG0VMOP0gvnE5XlpxiZiNifNgf8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANZa1RzS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727135247; x=1758671247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Uj5mtdoOAx4kTnVRoWRzMXPTIVr/7eKH1rcTgJl9kw=;
  b=ANZa1RzS8Z3CVhcoZCnTjimQQqJcm5/+rNHRjtObtMIV/jwSK0H5sZVo
   lpaOb3zhDOfzCeXLfWZ56oT59aa8A4+bEd34gYkzvGfhfupH7sbu6AlBr
   yXrYhP8Lhkj6roZlhq96fUsevZ4RArvw8I/F9Uo8hG9yz3WsKsNrSPuBb
   3psbn0Tz/0TFslKILFJ8F64mFKVxV5oXdtn06EYI3vZvVLV5zSL5HdNrt
   B1AZiWkS6C4MUNOpoSRan434q5gimNiOGQYbPUPFtX6Pmc+7ADOv6AVh/
   sjIAxKD4SFexp3cUlaIk9TOv/EFJl2GWjK5aVMOIuUVzKpTqf61LaYsbW
   w==;
X-CSE-ConnectionGUID: Oj23CDbJR4u6pcSTMt/FAQ==
X-CSE-MsgGUID: MAWrp7k7TjmrS+YWVYdX1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26201995"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="26201995"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 16:47:25 -0700
X-CSE-ConnectionGUID: Ka2oBSuyTKOd3Z5PG+7EYQ==
X-CSE-MsgGUID: ZyAwx6NvSC2ErgBnx4lVTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="94575117"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 23 Sep 2024 16:44:51 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sssjX-000HhL-0L;
	Mon, 23 Sep 2024 23:44:47 +0000
Date: Tue, 24 Sep 2024 07:44:06 +0800
From: kernel test robot <lkp@intel.com>
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	jitao.shi@mediatek.com, mac.shen@mediatek.com,
	peng.liu@mediatek.com
Cc: oe-kbuild-all@lists.linux.dev,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/1] drm/mediatek: dp: Add sdp path reset
Message-ID: <202409240700.ARp9pDUk-lkp@intel.com>
References: <20240923133610.23728-1-liankun.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923133610.23728-1-liankun.yang@mediatek.com>

Hi Liankun,

kernel test robot noticed the following build errors:

[auto build test ERROR on pza/reset/next]
[also build test ERROR on linus/master v6.11 next-20240923]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liankun-Yang/drm-mediatek-dp-Add-sdp-path-reset/20240923-213747
base:   https://git.pengutronix.de/git/pza/linux reset/next
patch link:    https://lore.kernel.org/r/20240923133610.23728-1-liankun.yang%40mediatek.com
patch subject: [PATCH v1 1/1] drm/mediatek: dp: Add sdp path reset
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240924/202409240700.ARp9pDUk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240700.ARp9pDUk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240700.ARp9pDUk-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/mediatek/mtk_dp.c: In function 'mtk_dp_sdp_path_reset':
>> drivers/gpu/drm/mediatek/mtk_dp.c:1058:33: error: 'SDP_RESET_SW_DP_ENC0_P0' undeclared (first use in this function); did you mean 'SDP_PACKET_W_DP_ENC1_P0'?
    1058 |                                 SDP_RESET_SW_DP_ENC0_P0,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                                 SDP_PACKET_W_DP_ENC1_P0
   drivers/gpu/drm/mediatek/mtk_dp.c:1058:33: note: each undeclared identifier is reported only once for each function it appears in


vim +1058 drivers/gpu/drm/mediatek/mtk_dp.c

  1054	
  1055	static void mtk_dp_sdp_path_reset(struct mtk_dp *mtk_dp)
  1056	{
  1057		mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
> 1058					SDP_RESET_SW_DP_ENC0_P0,
  1059					SDP_RESET_SW_DP_ENC0_P0);
  1060	
  1061		/* Wait for sdp path reset to complete */
  1062		usleep_range(1000, 5000);
  1063		mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
  1064					0, SDP_RESET_SW_DP_ENC0_P0);
  1065	}
  1066	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

