Return-Path: <linux-kernel+bounces-258162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6BC93849B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699F71F2145D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7C015FA7E;
	Sun, 21 Jul 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQ9JVZyg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259676FB0
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721565443; cv=none; b=C7K5BF5QLA+UWQSWBBUGknQzAlJ800xyAPuU/jvxBvu9dJ/S+pqr5Vz3DlvEaHwFDDSV8zB1h1qdaqFhlU24OYQuldtiBx3qVcgs92cOcgR3ZaSG6yOAqVvjdOz4Ije5hjTt2cE+xkQAvkjVqpI2dFl8ew3JJIuvPZOMtcHI8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721565443; c=relaxed/simple;
	bh=UUCUj3Wit8dtnKf7lJBPBR++wT4Aw+SkWisE5r/mNqU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LX2ru4IiizquqeIMbXVZvzohoTanqTmG+ARQzFr9BL3gdblli0NPAr1x7q4isGaxlZbJUAVUC8OHSu8nbJ0ZV0kqqhuQbtZ42SEsNqjlFrgV2CGp6b2RYvXbH1GCzXAaWczPzU2TjSvnjPIoXeWADSp5nwOsXW2seTgygfywP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQ9JVZyg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721565441; x=1753101441;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UUCUj3Wit8dtnKf7lJBPBR++wT4Aw+SkWisE5r/mNqU=;
  b=VQ9JVZyg5VO+eO56WnXLpGj6SwaWJghb+ekvvJpWv1azqizsrKraMKT2
   7FYhj00plTe7B1HTOLxoCCAp6HJ86VE5RJymcG47/5s22y0yh5eUqjbwh
   pqD8mBmrZ/NZyeqkwIbiTSayveH50dO0uZLX/jjrYkhaAmlzfJY1uA6RN
   ovNidaE3xEMmiwVPXhIeH5PdKVTbexOQMGxwDtg7oHFq67mb5sJcNmwOF
   qawgvg+fW8VDLw7txWRemg3L7857HmQidKLtoPuNrgmf40aXQ7ZTWN44a
   0YGkznXFkBLUlwBzMJF1ysAWSN5HvTqXvzdXDsRAEAKEuuWZWY0n5NjbA
   w==;
X-CSE-ConnectionGUID: MWYgsuQ0SbOx2x7uYoJXkg==
X-CSE-MsgGUID: 4LOLemuJSzqRmRbDkQHvtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="12639452"
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="12639452"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 05:37:20 -0700
X-CSE-ConnectionGUID: TFO0dtPhRR2WUIMwvkWkNw==
X-CSE-MsgGUID: 5v6VdCWQTfaamSYRy3ijlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="51485593"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 21 Jul 2024 05:37:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVVoR-000kGw-1O;
	Sun, 21 Jul 2024 12:37:15 +0000
Date: Sun, 21 Jul 2024 20:36:40 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Price <steven.price@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: powerpc-linux-ld: dw_mipi_dsi-stm.c:undefined reference to
 `clk_hw_unregister'
Message-ID: <202407212000.rpDH64jP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2c9b3512402ed192d1f43f4531fb5da947e72bd0
commit: d076e2bd09f22db8a181a081479008524674b5b3 Merge tag 'drm-misc-next-2024-07-04' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
date:   2 weeks ago
config: powerpc-randconfig-r051-20240721 (https://download.01.org/0day-ci/archive/20240721/202407212000.rpDH64jP-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240721/202407212000.rpDH64jP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407212000.rpDH64jP-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/gpu/drm/stm/dw_mipi_dsi-stm.o: in function `dw_mipi_dsi_stm_remove':
   dw_mipi_dsi-stm.c:(.text+0x664): undefined reference to `of_clk_del_provider'
>> powerpc-linux-ld: dw_mipi_dsi-stm.c:(.text+0x66c): undefined reference to `clk_hw_unregister'
   powerpc-linux-ld: drivers/gpu/drm/stm/dw_mipi_dsi-stm.o: in function `dw_mipi_dsi_stm_probe':
   dw_mipi_dsi-stm.c:(.text+0x98c): undefined reference to `clk_hw_register'
>> powerpc-linux-ld: dw_mipi_dsi-stm.c:(.text+0x99a): undefined reference to `of_clk_hw_simple_get'
   powerpc-linux-ld: dw_mipi_dsi-stm.c:(.text+0x9a2): undefined reference to `of_clk_hw_simple_get'
>> powerpc-linux-ld: dw_mipi_dsi-stm.c:(.text+0x9a8): undefined reference to `of_clk_add_hw_provider'
   powerpc-linux-ld: dw_mipi_dsi-stm.c:(.text+0x9b8): undefined reference to `clk_hw_unregister'
   powerpc-linux-ld: drivers/gpu/drm/stm/lvds.o: in function `lvds_remove':
   lvds.c:(.text+0x300): undefined reference to `of_clk_del_provider'
>> powerpc-linux-ld: lvds.c:(.text+0x308): undefined reference to `clk_hw_unregister'
   powerpc-linux-ld: drivers/gpu/drm/stm/lvds.o: in function `lvds_probe':
   lvds.c:(.text+0x14b4): undefined reference to `clk_hw_register'
>> powerpc-linux-ld: lvds.c:(.text+0x14c2): undefined reference to `of_clk_hw_simple_get'
   powerpc-linux-ld: lvds.c:(.text+0x14ca): undefined reference to `of_clk_hw_simple_get'
>> powerpc-linux-ld: lvds.c:(.text+0x14d0): undefined reference to `of_clk_add_hw_provider'
   powerpc-linux-ld: lvds.c:(.text+0x1570): undefined reference to `clk_hw_unregister'
   powerpc-linux-ld: drivers/gpu/drm/stm/lvds.o: in function `lvds_pll_config':
   lvds.c:(.text+0x178c): undefined reference to `clk_hw_get_rate'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

