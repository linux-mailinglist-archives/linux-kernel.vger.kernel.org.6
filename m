Return-Path: <linux-kernel+bounces-540134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C19A4AE21
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 23:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912BC16F284
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2271E8335;
	Sat,  1 Mar 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTRBEODa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C8189BB0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740867687; cv=none; b=WCccrLey7eN/Ol2BqBwf5Pc+Rj+6vMEPsD5NIYM8fHToUv3na7MajId2FHKcecK9hVGK6yg8syBKRQue98g44YgTPoYXb9nZP/BigLsf9eLXsuozAQt4SyyP1u4/LMIRckdNlx7CqEFT2hOhZaLWwYJ9q6nmVZP/RrkUSc7ATyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740867687; c=relaxed/simple;
	bh=/kr/iiN+6mWFEvfTzLn/BSJFlMOee4GjMK9oB8NIYCk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZgQ9zMIJVOcmdah4BtKqPz1MFuP2iRvFF/EUfPPh4Pc2RA8msNrTlVqN1R/5nErGONBiVoM/Se38FjztvZg6SPoW9mOlnsu7ioIMpV3K33SiWmEUFQbFxTN03mAuuFc2S8Ao+GL1lVX1Cp8omJE8Ua56lLZsahJ0m/8ozVSmPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTRBEODa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740867685; x=1772403685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/kr/iiN+6mWFEvfTzLn/BSJFlMOee4GjMK9oB8NIYCk=;
  b=aTRBEODacebNxZYIjACBPGBS1/t1p8fDY0Y//mX68tLj5yfa5CGPAfa0
   RyUu3cOB/Yg4TC/bXo6QqPPFJo0b85TnbdO07jQY+A0KXZpX0ceW68+sp
   nS0k/DvePLiCcFvE235wlUaJcXr/ZtoeZViRw9t9Tf8yZ0/W5NNslobj8
   m0iAXqmAJGijr9Blv9t8MniD3onea6LplPKbvXnPcJurPOZK1ImyGwxhz
   /ai4BtFedtvzxCJeTf8DFZOSk+1hO+JuAJnfFxY3ED223kfwGXZyQEtYf
   vW+7mftZFTSuJ47lfidoEK0qldlmJZbjNx27spxpGU8XgnQXP31aTK4yG
   w==;
X-CSE-ConnectionGUID: cKT0Fa5fSEeu6xIhp2OPXw==
X-CSE-MsgGUID: G9xG/Ld4Shax5SOCcZtmqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="44590853"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="44590853"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 14:21:24 -0800
X-CSE-ConnectionGUID: EYT6N8NcRiGashzEsgUFFw==
X-CSE-MsgGUID: HXzo8lDLSXeR96Wdb8LBug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="117837338"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 01 Mar 2025 14:21:23 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toVCz-000GmI-0N;
	Sat, 01 Mar 2025 22:21:21 +0000
Date: Sun, 2 Mar 2025 06:21:00 +0800
From: kernel test robot <lkp@intel.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: drivers/remoteproc/omap_remoteproc.c:732: warning: Function
 parameter or struct member 'is_iomem' not described in 'omap_rproc_da_to_va'
Message-ID: <202503020637.6SBId7IR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   df87d843c6eb4dad31b7bf63614549dd3521fe71
commit: 40df0a91b2a5228ded8e5f75b80d28c96c6831cd remoteproc: add is_iomem to da_to_va
date:   4 years ago
config: arm-randconfig-c041-20230507 (https://download.01.org/0day-ci/archive/20250302/202503020637.6SBId7IR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020637.6SBId7IR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020637.6SBId7IR-lkp@intel.com/

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

