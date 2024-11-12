Return-Path: <linux-kernel+bounces-405739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282929C566E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCE028845B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67921217666;
	Tue, 12 Nov 2024 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIOB+Kp2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722E215C43
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409903; cv=none; b=m2HETKUo5fevCRCSqD9dMvgPndeZpSjMTVYe22eVbjWVkaBYsoFOXhXGrC8u91Wv2+vmZr9rV8w1wjWkUxARr68ADHzaHxch+aXR0g/HqphPxOF0s2ntUcaK3HUeWYoJgUXjtaXHzrnPo/a31g8OeNpNpy5BCF+9L9bIr8cOyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409903; c=relaxed/simple;
	bh=1RlEhTf8dfkfAzmh1l4LtaJGOgoP6QelhYhQjX8yBdo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RgRYT6RX2Kohx8QnOFar4315xlKcyZmWLfqzdURS7U0YsfetEIIDmYlrC7gOxzvxNglHHdSp7V6YaM8jO94eY+0SoV9Fvdu6zXnuC9VzDDRl5OFm4yeKLcVjXffQWlonACSS2p9/gEu3jPSMtZjMx7/5JojqI0ULdx4MFEkFMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIOB+Kp2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731409902; x=1762945902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1RlEhTf8dfkfAzmh1l4LtaJGOgoP6QelhYhQjX8yBdo=;
  b=HIOB+Kp2ZLuynF33La3ZPUDQ5c34Vbor8me162N7qcCqC8DtyT2+eonA
   l2pYvRdh4KqHVRiDVfB2Xh/HKVZrPSmShMy0AuTfSzCOVy4zbuu0dyTED
   kCbyqhmEQ9LwCQaMU0CsFmJbOdIleSWl3xGIMUyoF5PPW4laUWLUexycx
   rXPlO9MuUBczYNTu/FwHHE3DjveRIefFnC4BEGzIgtX03yNOrOKqb1NRK
   eTxzG2GQk0yJFBbSAOsH6wgVEEVrGkjKrkfPgf97Ti1IIaaK3KOiNntm+
   gSoAVtj0QU1I82XHOHxNEgWtI9Ck5kg9sEvIhY9G1FFlsH/0E7bCt5nhS
   g==;
X-CSE-ConnectionGUID: Fp49UO7mRBuOfjkqfbaTZQ==
X-CSE-MsgGUID: NeMriAa0Q16s+5g3pVoNfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="30639149"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="30639149"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 03:11:41 -0800
X-CSE-ConnectionGUID: F10JgwfUQE+i1310BjRxbQ==
X-CSE-MsgGUID: gnL4HVQ2QJeKMFgxR4ycIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="86985005"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 12 Nov 2024 03:11:39 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAoo5-0001Aj-1D;
	Tue, 12 Nov 2024 11:11:37 +0000
Date: Tue, 12 Nov 2024 19:11:00 +0800
From: kernel test robot <lkp@intel.com>
To: Shravan Kumar Ramani <shravankr@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	David Thompson <davthompson@nvidia.com>
Subject: drivers/platform/mellanox/mlxbf-pmc.c:1172:14: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202411121935.cgFcEMO4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d5404caa8c7bb5c4e0435f94b28834ae5456623
commit: 423c3361855c1e81f1cb91728a2ac5ddfd2cbf16 platform/mellanox: mlxbf-pmc: Add support for BlueField-3
date:   1 year, 2 months ago
config: arm64-randconfig-r112-20241112 (https://download.01.org/0day-ci/archive/20241112/202411121935.cgFcEMO4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241112/202411121935.cgFcEMO4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121935.cgFcEMO4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/mellanox/mlxbf-pmc.c:1172:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/platform/mellanox/mlxbf-pmc.c:1172:14: sparse:     expected void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1172:14: sparse:     got void [noderef] __iomem *
>> drivers/platform/mellanox/mlxbf-pmc.c:1174:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *addr @@
   drivers/platform/mellanox/mlxbf-pmc.c:1174:31: sparse:     expected void [noderef] __iomem *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1174:31: sparse:     got void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1186:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *addr @@
   drivers/platform/mellanox/mlxbf-pmc.c:1186:32: sparse:     expected void [noderef] __iomem *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1186:32: sparse:     got void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1194:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/platform/mellanox/mlxbf-pmc.c:1194:14: sparse:     expected void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1194:14: sparse:     got void [noderef] __iomem *
   drivers/platform/mellanox/mlxbf-pmc.c:1198:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *addr @@
   drivers/platform/mellanox/mlxbf-pmc.c:1198:32: sparse:     expected void [noderef] __iomem *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1198:32: sparse:     got void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1415:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/platform/mellanox/mlxbf-pmc.c:1415:14: sparse:     expected void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1415:14: sparse:     got void [noderef] __iomem *
   drivers/platform/mellanox/mlxbf-pmc.c:1417:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *addr @@
   drivers/platform/mellanox/mlxbf-pmc.c:1417:31: sparse:     expected void [noderef] __iomem *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1417:31: sparse:     got void *addr

vim +1172 drivers/platform/mellanox/mlxbf-pmc.c

  1163	
  1164	/* Method to handle crspace counter programming */
  1165	static int mlxbf_pmc_program_crspace_counter(int blk_num, uint32_t cnt_num,
  1166						     uint32_t evt)
  1167	{
  1168		uint32_t word;
  1169		void *addr;
  1170		int ret;
  1171	
> 1172		addr = pmc->block[blk_num].mmio_base +
  1173			(rounddown(cnt_num, 2) * MLXBF_PMC_CRSPACE_PERFSEL_SZ);
> 1174		ret = mlxbf_pmc_readl(addr, &word);
  1175		if (ret)
  1176			return ret;
  1177	
  1178		if (cnt_num % 2) {
  1179			word &= ~MLXBF_PMC_CRSPACE_PERFSEL1;
  1180			word |= FIELD_PREP(MLXBF_PMC_CRSPACE_PERFSEL1, evt);
  1181		} else {
  1182			word &= ~MLXBF_PMC_CRSPACE_PERFSEL0;
  1183			word |= FIELD_PREP(MLXBF_PMC_CRSPACE_PERFSEL0, evt);
  1184		}
  1185	
  1186		return mlxbf_pmc_write(addr, MLXBF_PMC_WRITE_REG_32, word);
  1187	}
  1188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

