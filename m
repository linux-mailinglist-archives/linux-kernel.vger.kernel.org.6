Return-Path: <linux-kernel+bounces-296247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD295A81F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0A2B2193E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A017C9E9;
	Wed, 21 Aug 2024 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm6SfiSe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE61494AD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282708; cv=none; b=Ga2lwsaD1dNG4RLBjTu+7sppRLLJljTpM+L8UOtbQhiEm5Gxs9k/BwjDMtaTCak56CafHQXTbYqoVaFDxXuAA7AXnZTcmO/LXtWpOCvmYFNn6/zbk/pv4BMhWJFCmE047mvEmZFaI0Ap2Wg8tsNx0n+lS+4udtJMqBavb190AeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282708; c=relaxed/simple;
	bh=2raBv8nu1Lb3plRPHtPzM8gQRb7u60QiDwXZTGO85fg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oA4S9kE0IKBrhK+hgTPBCNNpwdE0xOYOZCK5ucIAPZhL8g16L1ClbM4md/VpkcQakzVCxpTXue6okNh1DSePVmlcCiKWNoYiusgzWg2v/M1yyBHySpQaEP37MONhab7ldkxJ6MZAKWawP/7FfBgF9GZWGeABwNUXw2Czpeb+tpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm6SfiSe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724282707; x=1755818707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2raBv8nu1Lb3plRPHtPzM8gQRb7u60QiDwXZTGO85fg=;
  b=Lm6SfiSes43FYxO0Z8scvrucQMtVsxnrFBoD9QXc2cNhT0ozM/J7mDR5
   /WgCByKEYSKAnwhL7UAdoAAZlblr+GfFdWVNJhL2H64vbZ/if4EiajaL7
   K98s03sdW2F50JAzZ1N5EBcDT0VLjyPNp+HHpBcAbt4/nF1HOCZ3+GU8a
   3C4ptQMBJlIGVPWiGiCueCycuab+vB45M2IX/1WJFJodb/JADvfrJrDR0
   qxlxs/UCv5nQKPzwfiFcqibihRO5eW/OvWSsoifxu0B9hD2zKsampSCJ1
   lYSyxy+I7Zq9DU6sRt2oX8prNv45MtutbZ6WFpQyo1VRdI+cxMbPuvCHt
   g==;
X-CSE-ConnectionGUID: 4laujNjTTJS07Ok89IJ8SA==
X-CSE-MsgGUID: qJeopnxTSECsuuQtZA/Oxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="48067166"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="48067166"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 16:25:06 -0700
X-CSE-ConnectionGUID: bWxU4KWrQI+x0EccHeUwVQ==
X-CSE-MsgGUID: eD+l1axjRzayP5hh/PXonw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="66129107"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 21 Aug 2024 16:25:04 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sguhK-000C2q-0G;
	Wed, 21 Aug 2024 23:25:02 +0000
Date: Thu, 22 Aug 2024 07:24:59 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 ice_adv_lnk_speed_maps+0x14 (section: .data) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
Message-ID: <202408220755.LlaA10C6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pawel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b311c1b497e51a628aa89e7cb954481e5f9dced2
commit: 982b0192db455d288fc1deb06632f529c35daa15 ice: Refactor finding advertised link speed
date:   10 months ago
config: xtensa-randconfig-r123-20240821 (https://download.01.org/0day-ci/archive/20240822/202408220755.LlaA10C6-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240822/202408220755.LlaA10C6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408220755.LlaA10C6-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x78 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x14 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x30 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x4c (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x68 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x84 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xa0 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xbc (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xd8 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xf4 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

