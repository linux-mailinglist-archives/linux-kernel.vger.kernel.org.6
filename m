Return-Path: <linux-kernel+bounces-333876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA88397CF4C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 00:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09F8284A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 22:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626251B29D4;
	Thu, 19 Sep 2024 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CG1S2h1O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA4125A9
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726785830; cv=none; b=Ep1hQY7VUAepn3GwQF9EEAZBCT94xGOl5dSumLFfoGnMeR8lthuGzMUDBgFHvuxQNsS+6r6FSdkpMpgPWAFRTuL0lyvD6K7QcWZXyHsOuXa3FJ+25it7Yc0/XsytrbMdnSKXThh65rOsp/kw8es/6oCf7lYCrIHrdt8bGeqOElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726785830; c=relaxed/simple;
	bh=Fhu7YT+CCTUlhDgFevdRmHSSmqXS6RBEGTbuJJwSf0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2astVvTg7Rkl4lPzY5GD/WLwYELIVggYrwXYkT94m1h+1jtjGNZULRgTWZ6f1xQYcGJZ8bA/YYVuYb0hFYZdBE5+71SSm/z16TNIb+nlYXvPwN4G+Mz/ijZ1mIGlgFIg56M9hxhgqxt2CT6t6ekK1kVsU0l50sXHFnHKvT/EL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CG1S2h1O; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726785829; x=1758321829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fhu7YT+CCTUlhDgFevdRmHSSmqXS6RBEGTbuJJwSf0w=;
  b=CG1S2h1OdvPNNzemARCr0zNSGHAqWxVXUTtKxNQ0xnrEtsNSusvU6Qkf
   EZe1NL439ChSy+V47bWiD94c8641RRk+0lXkN6q5jeP7R1NWvAJj2p9rt
   rDAEhljrX2q45EXxKL4l3WokNIK43t+gGjcHtg+zcDlOoR2Us3FtP7Gen
   /5NRMp37s/+g/tKRdW8P7KXt98xolJVdDu1yA+Oo6mHSIOuJcbOkbJtxR
   PxU/2a8+Usbj4AWBU0DL19/K9uQtkCWTfAkwb6cJI812w5nA8jiWBIjuy
   lGpxvLbjYwjuFRIkbiWzwSjR6j7JEUFA4HM1o0PY2dBSQfE22G18SQBOK
   A==;
X-CSE-ConnectionGUID: bUcnnnHJRgmgmS7qqF4Gbg==
X-CSE-MsgGUID: mB+N9k0vTca/BRk/vo+kWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="48310044"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="48310044"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 15:43:48 -0700
X-CSE-ConnectionGUID: pfgdMEkRRHWQFN7rXW35lA==
X-CSE-MsgGUID: BMmpoMYiSsq7itvgF/dNkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="70335641"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2024 15:43:47 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srPsG-000DlX-2c;
	Thu, 19 Sep 2024 22:43:44 +0000
Date: Fri, 20 Sep 2024 06:43:24 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH v1 3/3] soc: mediatek: mtk-cmdq: Move cmdq_instruction
 init to declaration
Message-ID: <202409200659.IVYRJ33l-lkp@intel.com>
References: <20240918100620.103536-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918100620.103536-4-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on soc/for-next linus/master v6.11 next-20240919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/soc-mediatek-mtk-cmdq-Move-mask-build-and-append-to-function/20240918-180757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240918100620.103536-4-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v1 3/3] soc: mediatek: mtk-cmdq: Move cmdq_instruction init to declaration
config: parisc-randconfig-r123-20240920 (https://download.01.org/0day-ci/archive/20240920/202409200659.IVYRJ33l-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240920/202409200659.IVYRJ33l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409200659.IVYRJ33l-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/mediatek/mtk-cmdq-helper.c:240:18: sparse: sparse: Initializer entry defined twice
   drivers/soc/mediatek/mtk-cmdq-helper.c:244:18: sparse:   also defined here

vim +240 drivers/soc/mediatek/mtk-cmdq-helper.c

   234	
   235	int cmdq_pkt_write_s(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
   236			     u16 addr_low, u16 src_reg_idx)
   237	{
   238		struct cmdq_instruction inst = {
   239			.op = CMDQ_CODE_WRITE_S,
 > 240			.mask = 0,
   241			.src_t = CMDQ_REG_TYPE,
   242			.sop = high_addr_reg_idx,
   243			.offset = addr_low,
   244			.src_reg = src_reg_idx
   245		};
   246		return cmdq_pkt_append_command(pkt, inst);
   247	}
   248	EXPORT_SYMBOL(cmdq_pkt_write_s);
   249	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

