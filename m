Return-Path: <linux-kernel+bounces-530352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D415A43263
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAA63AD3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4266D17BBF;
	Tue, 25 Feb 2025 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLklv7rQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9A55887
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446474; cv=none; b=ii27qv/IiURm3+zRaOqR5KHa96yIYsj22bSmMKHQicFWJZOPN24xYdN6rA+HOFI9TNzGcLLyILPPAffWoyVgBrJblJYyJrXXhon8fzWY1Ric8qdWw5PEFEHPjriMCE3G3q9CgW0LNv8oBHoeenliBh6XTbgaz1MDIHLtk+6fW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446474; c=relaxed/simple;
	bh=34rmwhb2bBO3XVsccPBg5dFXR9H5wQTu1+GuS3aaCRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jhJ5zYQU1Q3c2YsZxu5KBid1y6WbDvSh8lpWQsiE0MQxZHG+kynkuTu9d2NcxncPrqVk0L/bWGy1igwzK4ALOY4nRnjY81JLXfeCMPKRD1gDnFkBmddx4praaJPPXegUKoMaNg8WBlb+aM+D8qaFsQe3+cPh6uEJmkTCE8TLNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLklv7rQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740446473; x=1771982473;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=34rmwhb2bBO3XVsccPBg5dFXR9H5wQTu1+GuS3aaCRU=;
  b=NLklv7rQW3U+eAfCGbR9LblPyubZ+vvVDyo5HkgtE+ooNkTbZoBnDY1q
   ShrDte0GXwYdtYO9i2JUSFO17jTrxk7VS/P/pp3XL8aEMxDTv+gthPwNx
   kGHoOTdWVc02mxRhfoOYnNrQI7p576EYsnhRhtcSSTnipDadWWIIWc0gP
   wqCtJOISIoDif2pWId0CinutAV7r/yC7I6PbgvV7kMT44hnEDlFvkFpBJ
   kostt2onvDYMKgD/HQ475j6RID9kEyKm5bKDAjKlNiIv+eQ5fwO6vG35K
   wHz5IXb0khW2tyMJ6xFEmNNKzx/4ccw0D+ER82uambR0gTTXsm9nD9aQy
   A==;
X-CSE-ConnectionGUID: FDlFvK9QTDeSxjOCfqglMg==
X-CSE-MsgGUID: vc3pgwhxT5ay3kDE8pwAdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="52230937"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="52230937"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 17:21:12 -0800
X-CSE-ConnectionGUID: Z123ZxbbQviv/AyiMaHNhw==
X-CSE-MsgGUID: KuOlUUnNTKiwSo7Jy88aXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121209972"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 24 Feb 2025 17:21:11 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmjdE-0009YU-1v;
	Tue, 25 Feb 2025 01:21:08 +0000
Date: Tue, 25 Feb 2025 09:21:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: arch/riscv/kernel/unaligned_access_speed.c:22:1: sparse: sparse:
 symbol '__pcpu_scope_misaligned_access_speed' was not declared. Should it be
 static?
Message-ID: <202502250928.pomaaBLM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d082ecbc71e9e0bf49883ee4afd435a77a5101b6
commit: d1703dc7bc8ec7adb91f5ceaf1556ff1ed212858 RISC-V: Detect unaligned vector accesses supported
date:   4 months ago
config: riscv-randconfig-r131-20250225 (https://download.01.org/0day-ci/archive/20250225/202502250928.pomaaBLM-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250225/202502250928.pomaaBLM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502250928.pomaaBLM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/unaligned_access_speed.c:22:1: sparse: sparse: symbol '__pcpu_scope_misaligned_access_speed' was not declared. Should it be static?
   arch/riscv/kernel/unaligned_access_speed.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false

vim +/__pcpu_scope_misaligned_access_speed +22 arch/riscv/kernel/unaligned_access_speed.c

    21	
  > 22	DEFINE_PER_CPU(long, misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
    23	DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

