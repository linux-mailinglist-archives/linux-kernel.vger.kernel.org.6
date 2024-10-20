Return-Path: <linux-kernel+bounces-373164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6B9A532F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 10:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFCB281B97
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7910839AEB;
	Sun, 20 Oct 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvRKO674"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902F1CABF
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729414231; cv=none; b=S9wnQl/w28vMDn6fiVQLDcgApx4SvlWl5380toOLg1ZUTl0Xieo0aifi4EjevWqb81ZuO6XdDKpBE7TJ1yQesKumgFo3wbkZJARX1ivWruF3cShagvdoAzk2ppzfGxdTbW/JWK7djarCZLRtsEI+IL6UrePvBfLgeGACTqvnqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729414231; c=relaxed/simple;
	bh=a0ocEBhJEtWBUoqkQTUwegAb3mDN0y7olLSB2npzvX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HaoJhefP+7w5gbrynp677F2tFjx7XxjsCDbtp8nxZdkSQaV3m2fC+qdDwi5oOLZEzH2W75Y0RpLs3xcsfmB+DIMUTuwjv0Awr5RGnTkICqRT5gwBf7lcDy3FL7hjlJwKDHGB9jigpATV2nyr7seREhlj8E6DGTKdUvVfdkXZZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvRKO674; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729414229; x=1760950229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a0ocEBhJEtWBUoqkQTUwegAb3mDN0y7olLSB2npzvX4=;
  b=mvRKO674I+GMtDU91+x4e1lTeAHxSQ0dOYGDbw5RNr7+I+bjdC+QpRfu
   JVAVaovhyYx6YvcSPINaf6JiCagiwIg8S+fA5EN9C4Wz7o7EHGDhXStaT
   9GMDXAs6MgI83nLoFe7s6qgu/5JwQ5P5cvovnwptcovjaf+AqLnKL/YD1
   NEID94iRHk0NngZqqmsy2p3EACbJTxIwPAF4CqWxLFAV5Lpvq6/tVhca4
   Cir02vRQKmhyO/BJQXFUQeSkDpFX2os1+ttkQqXD06mgbrIuYZ9sUdcTx
   tqEkJXFhsOxeXceb0uCkfSSwDh8YTGMCik/iCtEcBLRgroL1cXfdjjy65
   g==;
X-CSE-ConnectionGUID: wFCymhI4SaOGW73GTUVFig==
X-CSE-MsgGUID: 8l2DH/UuQLO/b7+9v65bGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29069425"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29069425"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 01:50:29 -0700
X-CSE-ConnectionGUID: s+yuDPGNR4G4YI2T80OJmw==
X-CSE-MsgGUID: vY4V4YIqQdyM6lBzW26y5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="78842094"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Oct 2024 01:50:27 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2Rdp-000Q81-08;
	Sun, 20 Oct 2024 08:50:25 +0000
Date: Sun, 20 Oct 2024 16:49:57 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 prb_rec_init_rd+0x1b (section: .text.prb_rec_init_rd) -> setup_text_buf
 (section: .init.data)
Message-ID: <202410201635.Y0YWnfZL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   715ca9dd687f89ddaac8ec8ccb3b5e5a30311a99
commit: 53585f9ea40a9466ab9c1151f15984513eb542f7 um: enable UBSAN
date:   4 months ago
config: um-randconfig-r111-20241019 (https://download.01.org/0day-ci/archive/20241020/202410201635.Y0YWnfZL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201635.Y0YWnfZL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201635.Y0YWnfZL-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: prb_rec_init_rd+0x1b (section: .text.prb_rec_init_rd) -> setup_text_buf (section: .init.data)
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/locktorture.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp855.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp860.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp861.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp949.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp1250.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-5.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-9.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_koi8-r.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-centeuro.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-gaelic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-greek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-romanian.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/binfmt_script.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/jbd2/jbd2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/hpfs/hpfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/btrfs/btrfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/encrypted-keys/encrypted-keys.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/math/prime_numbers.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libsha256.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_deflate/zlib_deflate.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pinctrl/pinctrl-mcp23s08_i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pinctrl/pinctrl-mcp23s08.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/tps6286x-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/ttynull.o
WARNING: modpost: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
Is "cmpxchg8b_emu" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "csum_partial" [vmlinux] version generation failed, symbol will not be versioned.
Is "csum_partial" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "cmpxchg8b_emu" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "cmpxchg8b_emu" [fs/bcachefs/bcachefs.ko] has no CRC!
WARNING: modpost: "csum_partial" [block/t10-pi.ko] has no CRC!
WARNING: modpost: "cmpxchg8b_emu" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "csum_partial" [drivers/scsi/scsi_debug.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

