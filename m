Return-Path: <linux-kernel+bounces-420239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB889D7757
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 19:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C334283661
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A613AD11;
	Sun, 24 Nov 2024 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIh7KkQ6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1DB2500BF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732472993; cv=none; b=fM3QSGaiARlwP7jEKMyobI6xdJAeHPKJZX9EXzLS98MdasN9NwoBjsTVcYcPY3Wpck0GI//RB2+29gLT9A2T/p28Pgca3LqAtE8H5XpZAoxlC8IIoolE/s2ozlg2NRJTjFj5nyOXKdO0EcRynQNMIB/2HV+zHNNgEZxXrYyYT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732472993; c=relaxed/simple;
	bh=dP0bzyNubEDFeNzTdvB4Y/xpX3U8Uv9N03wZTvGUAvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ur7KhkHXEnKVFAp+60RJjdoKBXGZvN/wlfffJWAFAmRrjzjuqyosMup6vlPB6vYzKspgAQtByveSpE0NvVVghOo/rLZ66fpBJfJhwVcHy2sQLbLlI21DH3TjqR0xPrvqvCm7S8CUUrGUElTy7vATKBtMqN0B7QzhEG3xv8LuYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIh7KkQ6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732472991; x=1764008991;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dP0bzyNubEDFeNzTdvB4Y/xpX3U8Uv9N03wZTvGUAvY=;
  b=OIh7KkQ6N3QDeTDQ/yLAqQce942zOZcgA8CROlxXg7qkbpfOwp1b3wYG
   oGRBtP4uQgbT/FMlhk2ytkCUdcY0gIOsC2wPvRI0iALpRvVWkDFJVrGfp
   Pasd2BPEB1Br98Hb9JI4YUvJUUCZS5yUFRoFuyNhaULxk/hbkYmf2zNSZ
   gUq0s/U1u1Q9aWXkSXiDVrYOP7uOrov+Ix6OtuklOwDd1TVZwDIkIGARg
   vIRdZhEdkuHOcxJeWY/NVjEgTBoEI5RHPCRJ2sQe+s7pJEgOAZrSrU0fA
   YmlPNnO6dUKJ01BRwdAmWw9sP2TA1TgvueBUcz++FJVJTNTVMX3Db7FmY
   Q==;
X-CSE-ConnectionGUID: mnJUEzaDRj21e/CMmyRl3A==
X-CSE-MsgGUID: ZBw1lFHYSEiAwfrunt1GNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="36238243"
X-IronPort-AV: E=Sophos;i="6.12,181,1728975600"; 
   d="scan'208";a="36238243"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2024 10:29:50 -0800
X-CSE-ConnectionGUID: hWLYSnh2T1SBfUt1AZUa4w==
X-CSE-MsgGUID: p8R2RRVHSJKoTJJ3Ja1wCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,181,1728975600"; 
   d="scan'208";a="114335693"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 24 Nov 2024 10:29:48 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFHMg-00059Z-0E;
	Sun, 24 Nov 2024 18:29:46 +0000
Date: Mon, 25 Nov 2024 02:29:45 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christoph Hellwig <hch@lst.de>
Subject: ERROR: modpost: "_savefpr_24" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko]
 undefined!
Message-ID: <202411250241.BJ1Z95fp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Samuel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f16d5e6f220661f73b36a4be1b21575651d8833
commit: a28e4b672f042eb38d9b09f9d1fdf58c07052da4 drm/amd/display: use ARCH_HAS_KERNEL_FPU_SUPPORT
date:   6 months ago
config: powerpc64-randconfig-003-20241113 (https://download.01.org/0day-ci/archive/20241125/202411250241.BJ1Z95fp-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411250241.BJ1Z95fp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411250241.BJ1Z95fp-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/iova.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_kunit_helpers.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_buddy_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_cmdline_parser_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_connector_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_damage_helper_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_dp_mst_helper_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_exec_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_format_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_framebuffer_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_gem_shmem_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_managed_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_mm_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_modes_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_plane_helper_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_probe_helper_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_rect_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-abt-y030xx067a.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-innolux-ej030na.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-orisetech-ota5601a.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611uxc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/sil-sii8620.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/bochs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-ram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-raw-ram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-slimbus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-w1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ublk_drv.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/open-dice.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/arizona.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/ssbi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/qcom-pm8008.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/nd_pmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvdimm/nd_virtio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/scsi_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/advansys.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/BusLogic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/atp870u.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/ppa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/imm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-fsl-lib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-omap2-mcspi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_cif.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_mf624.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/vivaldi-fmap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/tests/input_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rtc/lib_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rtc/rtc-goldfish.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rtc/rtc-tps65910.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-ali1563.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-qup.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/tuners/tda9887.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/rc-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/radio/si470x/radio-si470x-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/crypto/xilinx/zynqmp-aes-gcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/crypto/atmel-sha204a.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-a4tech.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-apple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-cherry.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-dr.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-emsff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-google-stadiaff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-gyration.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kensington.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-keytouch.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kye.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lenovo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-magicmouse.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-maltron.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-petalynx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-primax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-razer.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-saitek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sjoy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sunplus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-gaff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-tivo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-twinhan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-zpff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-waltop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/of/of_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/xilinx-ams.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwtracing/intel_th/intel_th_msu_sink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_brcm_nvram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mq-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/corsair-cpro.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
ERROR: modpost: "_restfpr_20" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "_restfpr_26" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "_savegpr1_27" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "_savegpr1_25" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "_restfpr_28" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "_savegpr1_29" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "_savefpr_20" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "_restfpr_15" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "_savefpr_24" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "_savefpr_28" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
WARNING: modpost: suppressed 54 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

