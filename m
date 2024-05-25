Return-Path: <linux-kernel+bounces-189216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA898CED3E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 02:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2D11C218F2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 00:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B891362;
	Sat, 25 May 2024 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V73542UX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BD67E1
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716597839; cv=none; b=LUzKMhkvboy5bx5LVlCNTRKNI6rNj2nMRHPAYoPXUx9tihw/IFKQQF1s5eOrIjBsVN3otlXRO2EhB6Uo784aX4gsrKEU8tn4Bz+GrzuUUDBl37VkFBSyO/Sne1c0YYuz4XzxxFKJZgLaqtVYUXNQo6sefI7xhz9OlIxQbnx3nXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716597839; c=relaxed/simple;
	bh=g6+BfJKtA0JDfnKecOPqpKJmj1yQxPBtYr/NSie4UJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hy1MyoXNOKp9Y4ZNy7q+PaYUxqkP9ke+21fErLOWb4Vc1UlBD4ZmUXZcgwsnZo+MsFTurhwppWxGifqzHV+fpsOna24reQZOa65uKSuIwsQjCs5YuadCPDA0BUeoqf1tmALX0bB+DPPct8YVPIVSC0LqGI88HiiSg8HTFMLtVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V73542UX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716597837; x=1748133837;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g6+BfJKtA0JDfnKecOPqpKJmj1yQxPBtYr/NSie4UJI=;
  b=V73542UXdLdODDtkdkuTy8rhHORyhr+0Kd+T8zpFS2h0jN119LsfgKf7
   0NUTcSaXfP+yAHMUi6ILObocMFqodniP/aTsPmrqZ8Z5bhOjcAgJf9Fsp
   1LwkExOrZuCkYUX30+nm02IFYvO0pzFBu8A7ONF7RfhH05WL97TqoXzdb
   uNgxmC4yN2u5skjTInsEdb0Ndf3s4HvrDJiL2Bi6mTjPgp8jwMsdimUb1
   itED6/E9fDH9fAfhgoIJdEWdcNAx3xh0LVb/4oJnQp96uF86mUqCVOFL0
   vgyz/FfBVC4KDaZ4zxD7iu0FNqgkaXz7Rg2ob+3SAq2aSfXKQ+m1IAoba
   A==;
X-CSE-ConnectionGUID: TT1TKq3mSHmwnZvhUd7cHw==
X-CSE-MsgGUID: nhn2K7MmRwCvgqbAIAsfIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="30507312"
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="30507312"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 17:43:57 -0700
X-CSE-ConnectionGUID: DXnCg9NQTDWt7qbfPOfe1Q==
X-CSE-MsgGUID: 6nTDLBnuRnO1MgE1HyQTlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="39162518"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 24 May 2024 17:43:54 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAfVo-00063H-1J;
	Sat, 25 May 2024 00:43:52 +0000
Date: Sat, 25 May 2024 08:43:04 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christoph Hellwig <hch@lst.de>
Subject: powerpc-linux-ld:
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o uses hard
 float, arch/powerpc/kernel/udbg.o uses soft float
Message-ID: <202405250851.Z4daYSWG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0b32d436c015d5a88b3368405e3d8fe82f195a54
commit: a28e4b672f042eb38d9b09f9d1fdf58c07052da4 drm/amd/display: use ARCH_HAS_KERNEL_FPU_SUPPORT
date:   5 days ago
config: powerpc-randconfig-002-20240525 (https://download.01.org/0day-ci/archive/20240525/202405250851.Z4daYSWG-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240525/202405250851.Z4daYSWG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405250851.Z4daYSWG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.o
>> powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.o
   powerpc-linux-ld: drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
   powerpc-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

