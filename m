Return-Path: <linux-kernel+bounces-516505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87664A372A2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504C216E089
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A71158851;
	Sun, 16 Feb 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9i6jsGA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900A14658B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739695666; cv=none; b=Xj/OhehBH/rSZ/ftcU+0QRm1/5gm3WT7sTlhvmYWZNsuENMVKeHB/TPfYt+LU/ZL9AiQsS4WbXB59W6hAkm6YkfglsQFsNlP8yrRzDJAlYgenhOA9xhgX7fP3NCr7EFRRXZCaFKPHQvFtmGlNfpmVEFwxhNQ28zlcXLkbG5MdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739695666; c=relaxed/simple;
	bh=JjFpiMgcU5A3YARaCEOhDLgvm9/evP6IgGp9NwHlW/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pvHxjZXH/c7sUtbPZY6njUVsCaHi+buTdgRSmkH0oUySADg52PMyCnELsxAeZYnT5SFvaQXZN6YHRMOk8FIKXF6s/hh6pEYLfiwvn8rDGOpBMe5sqoWhEZlP/B2cs1eZfIYmH+7bdlQlj2Cbz0SU3bBsf0a6TjMMU5GFuYRsR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9i6jsGA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739695664; x=1771231664;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JjFpiMgcU5A3YARaCEOhDLgvm9/evP6IgGp9NwHlW/0=;
  b=K9i6jsGA2W+shW3BMxG3uNlwiDykHC2ZbDyeAUtAK1rAVP0/9OkwEgse
   4E0Y0maJ5mvmoPv9rMHHn5pAQkUJQ0xoDFO0z+/dMDm0iBv0QtQKfWf3k
   zNreCGHAq6rwgvboLS1cqxxAWUTNwSlDD4+CXz4iAhNHS8gTGWTmltT1p
   vEUelnWH/ddaU3af51B2AG6wCGO55CllkV2Xz2mx0F/2itFRzNoMQwYn8
   KVdE23WS12jvww71DwbnCMYr3K+hS1tDF0ApkXbn2qxODWuANPxNO8vYe
   FeGhDf/cK11cIJd7wcP6YPBVEtcMReDmfecu43y9Ay0C4oJttGd9mKbDn
   Q==;
X-CSE-ConnectionGUID: XlDNp+OUS82lDrtV7S1Gpg==
X-CSE-MsgGUID: 6ncwikc1S/G6se+GKtPoGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40535364"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40535364"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 00:47:44 -0800
X-CSE-ConnectionGUID: q4/0rrhdQw2aZ8vSEcdWVw==
X-CSE-MsgGUID: kv1TOuqFTkixiT8j7Y/E2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119056105"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 Feb 2025 00:47:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjaJP-001Bip-2H;
	Sun, 16 Feb 2025 08:47:39 +0000
Date: Sun, 16 Feb 2025 16:46:42 +0800
From: kernel test robot <lkp@intel.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: drivers/remoteproc/omap_remoteproc.c:732: warning: Function
 parameter or struct member 'is_iomem' not described in 'omap_rproc_da_to_va'
Message-ID: <202502161648.WZWrFV7I-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ad1b832bf1cf2df9304f8eb72943111625c7e5a7
commit: 40df0a91b2a5228ded8e5f75b80d28c96c6831cd remoteproc: add is_iomem to da_to_va
date:   3 years, 11 months ago
config: arm-randconfig-c041-20230507 (https://download.01.org/0day-ci/archive/20250216/202502161648.WZWrFV7I-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502161648.WZWrFV7I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502161648.WZWrFV7I-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/omap_remoteproc.c:732: warning: Function parameter or struct member 'is_iomem' not described in 'omap_rproc_da_to_va'


vim +732 drivers/remoteproc/omap_remoteproc.c

34ed5a33b1218e Ohad Ben-Cohen 2011-10-20  716  
530a1b57e8590f Suman Anna     2020-03-24  717  /**
530a1b57e8590f Suman Anna     2020-03-24  718   * omap_rproc_da_to_va() - internal memory translation helper
530a1b57e8590f Suman Anna     2020-03-24  719   * @rproc: remote processor to apply the address translation for
530a1b57e8590f Suman Anna     2020-03-24  720   * @da: device address to translate
530a1b57e8590f Suman Anna     2020-03-24  721   * @len: length of the memory buffer
530a1b57e8590f Suman Anna     2020-03-24  722   *
530a1b57e8590f Suman Anna     2020-03-24  723   * Custom function implementing the rproc .da_to_va ops to provide address
530a1b57e8590f Suman Anna     2020-03-24  724   * translation (device address to kernel virtual address) for internal RAMs
530a1b57e8590f Suman Anna     2020-03-24  725   * present in a DSP or IPU device). The translated addresses can be used
530a1b57e8590f Suman Anna     2020-03-24  726   * either by the remoteproc core for loading, or by any rpmsg bus drivers.
530a1b57e8590f Suman Anna     2020-03-24  727   *
530a1b57e8590f Suman Anna     2020-03-24  728   * Return: translated virtual address in kernel memory space on success,
530a1b57e8590f Suman Anna     2020-03-24  729   *         or NULL on failure.
530a1b57e8590f Suman Anna     2020-03-24  730   */
40df0a91b2a522 Peng Fan       2021-03-06  731  static void *omap_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
530a1b57e8590f Suman Anna     2020-03-24 @732  {
530a1b57e8590f Suman Anna     2020-03-24  733  	struct omap_rproc *oproc = rproc->priv;
530a1b57e8590f Suman Anna     2020-03-24  734  	int i;
530a1b57e8590f Suman Anna     2020-03-24  735  	u32 offset;
530a1b57e8590f Suman Anna     2020-03-24  736  
530a1b57e8590f Suman Anna     2020-03-24  737  	if (len <= 0)
530a1b57e8590f Suman Anna     2020-03-24  738  		return NULL;
530a1b57e8590f Suman Anna     2020-03-24  739  
530a1b57e8590f Suman Anna     2020-03-24  740  	if (!oproc->num_mems)
530a1b57e8590f Suman Anna     2020-03-24  741  		return NULL;
530a1b57e8590f Suman Anna     2020-03-24  742  
530a1b57e8590f Suman Anna     2020-03-24  743  	for (i = 0; i < oproc->num_mems; i++) {
530a1b57e8590f Suman Anna     2020-03-24  744  		if (da >= oproc->mem[i].dev_addr && da + len <=
530a1b57e8590f Suman Anna     2020-03-24  745  		    oproc->mem[i].dev_addr + oproc->mem[i].size) {
530a1b57e8590f Suman Anna     2020-03-24  746  			offset = da - oproc->mem[i].dev_addr;
530a1b57e8590f Suman Anna     2020-03-24  747  			/* __force to make sparse happy with type conversion */
530a1b57e8590f Suman Anna     2020-03-24  748  			return (__force void *)(oproc->mem[i].cpu_addr +
530a1b57e8590f Suman Anna     2020-03-24  749  						offset);
530a1b57e8590f Suman Anna     2020-03-24  750  		}
530a1b57e8590f Suman Anna     2020-03-24  751  	}
530a1b57e8590f Suman Anna     2020-03-24  752  
530a1b57e8590f Suman Anna     2020-03-24  753  	return NULL;
530a1b57e8590f Suman Anna     2020-03-24  754  }
530a1b57e8590f Suman Anna     2020-03-24  755  

:::::: The code at line 732 was first introduced by commit
:::::: 530a1b57e8590f2ebbb6a35effa0efa988aabf6c remoteproc/omap: Add the rproc ops .da_to_va() implementation

:::::: TO: Suman Anna <s-anna@ti.com>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

