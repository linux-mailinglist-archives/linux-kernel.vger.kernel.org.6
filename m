Return-Path: <linux-kernel+bounces-251216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C1930237
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA171C212C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D1378C80;
	Fri, 12 Jul 2024 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2ozC//A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7571BC40
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720824357; cv=none; b=k8jpLszSSec3+P07igPQkP5ymwO+oRd/qhBC75X7DLcQz4TEJlVVFnD8PlF5Fn2KYbC+BzMiSt8uBXHJrAmFIpJgdzvMRLr/9lNthhgbdR4EKa28yQ58V9vvplm6jGfxoXgt2yeFGwomwtx8sw1RK+o88GdobewHjhFcaJGfTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720824357; c=relaxed/simple;
	bh=9rg1NXM9FzU8DLG6AHYhQ30lueZeefBdwKmeRgmPHh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk0ccKyO34VvbOQR8tRkvdwQjt8nYcgTtpccrkM2sygl+cUyvjJww3CbyzsjvIfuQJj9DWThHqJLjFLiII77HgqlXF4LCLR58FT2d+vlEWpAtUA6hNjbazqnPv4iPIfVHXPIE/TzFVGqdasvmxZRo2/MoyPdBzKFeQa6KyGwRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2ozC//A; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720824355; x=1752360355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9rg1NXM9FzU8DLG6AHYhQ30lueZeefBdwKmeRgmPHh0=;
  b=i2ozC//AeDp16imcDpmSYcSuuu6ZPKGlbNwKn8QvCFaJZNpnlB8UUUEz
   6cL+sgsL6FijU2oVhNJDmbRFHUEdkmLSVnfZ44pXhtz4Qk+1Pwl+5enXr
   03JD36f7yCQWhNfTXf/yYeiHzrvUozEu6nVlYrN0aRCQ6TOJBvR7R6bJB
   5N/zfRta3XA7LdLvp6tkRADT6bmjfRwyZsmRv+p7TUp8gq8qK5zArLieP
   QPv5DSH/zxYRKEa3idkwtG3rbqjtU3y8GshbdfqYi/rA3lA+mFf7WeX3G
   lwQCIlebOTUif9sbKaysYssGn8nJnperFMTEl3AKbmkHShWdipTvh6cFR
   w==;
X-CSE-ConnectionGUID: 1ySG2CaIRD2WtdbI0AdFdQ==
X-CSE-MsgGUID: mTFD8Oz3TaWkzkCwYP2DSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="35826583"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="35826583"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:45:55 -0700
X-CSE-ConnectionGUID: z0P74SadSIq1+/xHfks/ow==
X-CSE-MsgGUID: 6lnJn73fTuWXKZhem8Tnfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="54231240"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Jul 2024 15:45:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSP1R-000bOg-01;
	Fri, 12 Jul 2024 22:45:49 +0000
Date: Sat, 13 Jul 2024 06:44:58 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
Message-ID: <202407130620.DbyYULnj-lkp@intel.com>
References: <20240711072929.3590000-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711072929.3590000-3-ryan.roberts@arm.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20240712]
[cannot apply to linus/master v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/mm-Cleanup-count_mthp_stat-definition/20240711-154455
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240711072929.3590000-3-ryan.roberts%40arm.com
patch subject: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240713/202407130620.DbyYULnj-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407130620.DbyYULnj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407130620.DbyYULnj-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm64/crypto/crct10dif-ce.o
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm64/crypto/aes-neon-bs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/btrfs/btrfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/af_alg.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/ecc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/curve25519-generic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/xor.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libchacha.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libarc4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libdes.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx27.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-mediatek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-visconti.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek-gen3.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/qcom/lpass-gfm-sm8250.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/mediatek/mtk-cmdq-helper.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/qcom/spm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xen-pciback/xen-pciback.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611uxc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-slimbus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/fastrpc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-omap2-mcspi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/host/xhci-pci-renesas.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_acm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/u_serial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_serial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_obex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/u_ether.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ncm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ecm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_eem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ecm_subset.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_rndis.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_mass_storage.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_fs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/libcomposite.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/tuners/tda9887.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/rc-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/common/uvc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-fwnode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/edac/layerscape_edac_mod.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ufs/host/ufs-qcom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/coreboot_table.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/cbmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/crypto/sa2ul.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mailbox/mtk-cmdq-mailbox.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rpmsg/rpmsg_char.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/buffer/kfifo_buf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm-ccn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/fsl_imx8_ddr_perf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/arm_cspmu_module.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/nvidia_cspmu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mm-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mq-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mn-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hte/hte-tegra194-test.o
>> ERROR: modpost: "mthp_stats" [fs/btrfs/btrfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

