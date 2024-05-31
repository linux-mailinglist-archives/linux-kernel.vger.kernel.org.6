Return-Path: <linux-kernel+bounces-197416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8408D6A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023401F2A8D3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF5817D341;
	Fri, 31 May 2024 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X60/4adr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19E79B84;
	Fri, 31 May 2024 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717185559; cv=none; b=EO48JjCn52cNaogjnTi7Sko2ZqNibcaLzEMfljboM7yrDd7pCOWkp2o7O1qTksOB6shjPzDFYHn/ToJUaeRqTbWi1VvoSCtkCLc6RteeeM44IxztFNH/PC25jc6cunSM4t3lixHtQ+YWy5yRXqWL9Lf56iT2I6XnQxQ82eYbMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717185559; c=relaxed/simple;
	bh=jnv5YKLbj+Z2l8vdr8swzLTMD2a39mAbcZlrOzmNvKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gexIdMCbzHk8h6O4EnOUvvGQxUBlTvRdY80MypeBU2rkwwBsdZN42Qmq/dmRPwbhf7ybGw2yNzZ+RkRZTQn9dUqj9A9TsyUPoFTBPtJ2Vsas60eJCw23ISVEvXI8b9JxFk+uKhdGap5ynY11OTjwuTquMVHzomFWpL3if0BvH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X60/4adr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717185558; x=1748721558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jnv5YKLbj+Z2l8vdr8swzLTMD2a39mAbcZlrOzmNvKc=;
  b=X60/4adrK3io+O5DpCD1DSiCqLzfcVhADlgA42iF+wEnbUTE5mgVy+Ae
   +YYZ+DDZ5G/HMT6zI3PAy8C3EPaCmjgzJ860KBdJzubGAZ8Fe12fgqoH2
   w7X+TvArKT0O5m8m4UcODBd02OThp0bya10fa9PBTzP8usEcAuIqObgnU
   rVvYVairCScE1e+T8AzWw5Js4UuTq3c3fP/ymknzmosx0L7xMFQddJ2LN
   alSPzI9geIAILrGXyc7knCpsNYqDZql9Sjg4ltBaESpbQ5ZKl/MAGkxEG
   Pmay6E2RCWHk8doiZQzuxLjOwuGi00YHqMxyVvT8Qrj6AcORLFPzs3aeN
   g==;
X-CSE-ConnectionGUID: Kk1gmGK/RgKXHI8osyoBZA==
X-CSE-MsgGUID: yP/Aj3e6S7iYQ/PkdUKeow==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="24321215"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="24321215"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:59:18 -0700
X-CSE-ConnectionGUID: koVK9twYRRmYVQ1QSc9Rvw==
X-CSE-MsgGUID: 56AM9RKLQEWQM53t0AqYIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36202161"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 31 May 2024 12:59:15 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD8P9-000HlJ-2z;
	Fri, 31 May 2024 19:59:11 +0000
Date: Sat, 1 Jun 2024 03:58:32 +0800
From: kernel test robot <lkp@intel.com>
To: Simon Trimmer <simont@opensource.cirrus.com>, tiwai@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	soyer@irl.hu, shenghao-ding@ti.com, kevin-lu@ti.com,
	baojun.xu@ti.com, kailang@realtek.com,
	Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH 4/7] ALSA: hda: hda_component: Introduce component parent
 structure
Message-ID: <202406010354.ludmQT3O-lkp@intel.com>
References: <20240531151409.80284-5-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531151409.80284-5-simont@opensource.cirrus.com>

Hi Simon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.10-rc1 next-20240531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Simon-Trimmer/ALSA-hda-cs35l56-Component-should-be-unbound-before-deconstruction/20240531-231828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240531151409.80284-5-simont%40opensource.cirrus.com
patch subject: [PATCH 4/7] ALSA: hda: hda_component: Introduce component parent structure
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240601/202406010354.ludmQT3O-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406010354.ludmQT3O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406010354.ludmQT3O-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/pci/hda/hda_component.c:140:27: warning: 'memset' call operates on objects of type 'struct hda_component_parent' while the size is based on a different type 'struct hda_component_parent *' [-Wsizeof-pointer-memaccess]
           memset(parent, 0, sizeof(parent));
                  ~~~~~~            ^~~~~~
   sound/pci/hda/hda_component.c:140:27: note: did you mean to dereference the argument to 'sizeof' (and multiply it by the number of elements)?
           memset(parent, 0, sizeof(parent));
                                    ^~~~~~
   1 warning generated.


vim +140 sound/pci/hda/hda_component.c

   133	
   134	int hda_component_manager_bind(struct hda_codec *cdc,
   135				       struct hda_component_parent *parent)
   136	{
   137		int i;
   138	
   139		/* Init shared and component specific data */
 > 140		memset(parent, 0, sizeof(parent));
   141		for (i = 0; i < ARRAY_SIZE(parent->comps); i++)
   142			parent->comps[i].codec = cdc;
   143	
   144		return component_bind_all(hda_codec_dev(cdc), &parent->comps);
   145	}
   146	EXPORT_SYMBOL_NS_GPL(hda_component_manager_bind, SND_HDA_SCODEC_COMPONENT);
   147	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

