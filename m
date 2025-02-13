Return-Path: <linux-kernel+bounces-513041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29DA340EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B096188FBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D421F2222AC;
	Thu, 13 Feb 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JB5Xqdba"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A93B221713
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455001; cv=none; b=nQQNiINdttJUAHOnZKZfplwQyl/dzrvfYdDkLGlOdyGBOcrPlWlKZNRe+37EREfZVRWw34r9sAfUijzb11HwKvla+w0peGV8ojF+51zQCwqv+VPACMfgDdSpK6AGol0QUuu+wlLimroatZwCuEquZQeqt1b1n4wLlM6yQW1F9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455001; c=relaxed/simple;
	bh=w9vGSZWLontM/TI0Nx8tkSpanbwTFyKs+sgDRx/HSl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IKjb9wSBp3+QOSGIl6MzyuIH3OEblvPIFSEA+dD3fJTs7nZFy2aw0gt6Iswkp1fmoPeuckDGrYCMH2cGcbZlI7iMnO8XljtCMSANiI91NWC5yD4MWI9hjGbPtgVVBBgAqvWXClOspweoM3OEuJu4U5UQPSASa+I8kPwX+x6rdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JB5Xqdba; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454999; x=1770990999;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w9vGSZWLontM/TI0Nx8tkSpanbwTFyKs+sgDRx/HSl0=;
  b=JB5XqdbajHyIxLD1a69GL2CjL1fMrbH0CZDo/lMAo3+f08YMVg+RWLmd
   K2HFq0GslOvpySbFiT1hTmKQla1dAYGNG6Qmn+IpHKn8aApqMYi8+TZDp
   cvEQrUjDcki02ma/+ZWV60HlPzeTkaeRLGUK9PkGYkavTNsg7kTbkShIp
   Mr3oRUMtE31Ci6TmbPOqTXddYsuqBSng1zVOnuj9eIiOCTIzjuN57E96i
   l2HiMnnE+7ONyYM3vODTL2Uz+AnBbWogXLs/I9r3bi+DXRJFFmIrBG1t+
   i6gQEP6mYPIaHl8Al4sg95POb7NSxKh6hI8v+jXiuqgXlG/NKXPUcGny8
   g==;
X-CSE-ConnectionGUID: lqZSd5EeSwC5m6tf5IhbYQ==
X-CSE-MsgGUID: J7+wpYGVT26ihx5JqObB9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="57691514"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="57691514"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:56:38 -0800
X-CSE-ConnectionGUID: PGsZJfPITQWKO8bDxF0f8w==
X-CSE-MsgGUID: f4OfajfITsmpmgQx82z7vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136376498"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Feb 2025 05:56:38 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiZhj-00177H-1i;
	Thu, 13 Feb 2025 13:56:35 +0000
Date: Thu, 13 Feb 2025 21:55:42 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/fsl-qdma.c:170: warning: Function parameter or struct
 member '__reserved2' not described in 'fsl_qdma_format'
Message-ID: <202502132121.B7Z5mQ2y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Frank,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4dc1d1bec89864d8076e5ab314f86f46442bfb02
commit: 1878840a0328dac1c85d29fee31456ec26fcc01c dmaengine: fsl-qdma: add __iomem and struct in union to fix sparse warning
date:   12 months ago
config: arm-randconfig-004-20230928 (https://download.01.org/0day-ci/archive/20250213/202502132121.B7Z5mQ2y-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502132121.B7Z5mQ2y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502132121.B7Z5mQ2y-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/fsl-qdma.c:170: warning: Function parameter or struct member '__reserved2' not described in 'fsl_qdma_format'
>> drivers/dma/fsl-qdma.c:170: warning: Function parameter or struct member 'cmd' not described in 'fsl_qdma_format'


vim +170 drivers/dma/fsl-qdma.c

b092529e0aa098 Peng Ma   2018-10-30  135  
b092529e0aa098 Peng Ma   2018-10-30  136  #define FSL_QDMA_BLOCK_BASE_OFFSET(fsl_qdma_engine, x)			\
b092529e0aa098 Peng Ma   2018-10-30  137  	(((fsl_qdma_engine)->block_offset) * (x))
b092529e0aa098 Peng Ma   2018-10-30  138  
b092529e0aa098 Peng Ma   2018-10-30  139  /**
b092529e0aa098 Peng Ma   2018-10-30  140   * struct fsl_qdma_format - This is the struct holding describing compound
b092529e0aa098 Peng Ma   2018-10-30  141   *			    descriptor format with qDMA.
b092529e0aa098 Peng Ma   2018-10-30  142   * @status:		    Command status and enqueue status notification.
b092529e0aa098 Peng Ma   2018-10-30  143   * @cfg:		    Frame offset and frame format.
b092529e0aa098 Peng Ma   2018-10-30  144   * @addr_lo:		    Holding the compound descriptor of the lower
b092529e0aa098 Peng Ma   2018-10-30  145   *			    32-bits address in memory 40-bit address.
b092529e0aa098 Peng Ma   2018-10-30  146   * @addr_hi:		    Same as above member, but point high 8-bits in
b092529e0aa098 Peng Ma   2018-10-30  147   *			    memory 40-bit address.
b092529e0aa098 Peng Ma   2018-10-30  148   * @__reserved1:	    Reserved field.
b092529e0aa098 Peng Ma   2018-10-30  149   * @cfg8b_w1:		    Compound descriptor command queue origin produced
b092529e0aa098 Peng Ma   2018-10-30  150   *			    by qDMA and dynamic debug field.
041c4646003e23 Lee Jones 2020-07-14  151   * @data:		    Pointer to the memory 40-bit address, describes DMA
b092529e0aa098 Peng Ma   2018-10-30  152   *			    source information and DMA destination information.
b092529e0aa098 Peng Ma   2018-10-30  153   */
b092529e0aa098 Peng Ma   2018-10-30  154  struct fsl_qdma_format {
b092529e0aa098 Peng Ma   2018-10-30  155  	__le32 status;
b092529e0aa098 Peng Ma   2018-10-30  156  	__le32 cfg;
b092529e0aa098 Peng Ma   2018-10-30  157  	union {
b092529e0aa098 Peng Ma   2018-10-30  158  		struct {
b092529e0aa098 Peng Ma   2018-10-30  159  			__le32 addr_lo;
b092529e0aa098 Peng Ma   2018-10-30  160  			u8 addr_hi;
b092529e0aa098 Peng Ma   2018-10-30  161  			u8 __reserved1[2];
b092529e0aa098 Peng Ma   2018-10-30  162  			u8 cfg8b_w1;
b092529e0aa098 Peng Ma   2018-10-30  163  		} __packed;
1878840a0328da Frank Li  2024-02-19  164  		struct {
1878840a0328da Frank Li  2024-02-19  165  			__le32 __reserved2;
1878840a0328da Frank Li  2024-02-19  166  			__le32 cmd;
1878840a0328da Frank Li  2024-02-19  167  		} __packed;
b092529e0aa098 Peng Ma   2018-10-30  168  		__le64 data;
b092529e0aa098 Peng Ma   2018-10-30  169  	};
b092529e0aa098 Peng Ma   2018-10-30 @170  } __packed;
b092529e0aa098 Peng Ma   2018-10-30  171  

:::::: The code at line 170 was first introduced by commit
:::::: b092529e0aa09829a6404424ce167bf3ce3235e2 dmaengine: fsl-qdma: Add qDMA controller driver for Layerscape SoCs

:::::: TO: Peng Ma <peng.ma@nxp.com>
:::::: CC: Vinod Koul <vkoul@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

