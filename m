Return-Path: <linux-kernel+bounces-343236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2FC989871
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0198B283242
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5632A17E44A;
	Sun, 29 Sep 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgywopnZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A74768E1
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727653702; cv=none; b=n6tqT/VX034FrFoY1iqwr9d5jetAe3Qcl7g9vmtFxrt6H0HUZT03qSTJHcbvIMCtp7Q0Nc95FzX+zrFbKV/40KVTkxRW1I4YkPV0Kf6O0EQ/iiURUVEpdwrzlo22D1xa1nMKVHPRkNeCY590IJ3ThUbZ2H0B9XHK+BsS/k80Xq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727653702; c=relaxed/simple;
	bh=dxYsvHJGAMJR30y6C9sWaQDIpLLI3bR3EE5Mh9WL5ac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aXM7ZHGkJzdPlA4S9xTbztBJ/2xeTHmIeHRTe0zKaf3CB+R44/oM7Ytu9MJO+efOagYHnz++TDHtQzM/10ZQ/MO9fNTSL1G9AC2Gw4YOX/lA7JGfYkhYgdCkT1zjCXEzZTG64OG7Z0fiUd2PwuzANwnEAuoGsek+V1S94933Wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgywopnZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727653701; x=1759189701;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dxYsvHJGAMJR30y6C9sWaQDIpLLI3bR3EE5Mh9WL5ac=;
  b=SgywopnZvhMgTg8SBRzG4/PiwTRneeXrjbwVH84yBW4JbdEdZiR3y27r
   w+bfxaK2GqFbtMbrBfDEa4tyb8l456YM7XT6gVI1scpkFk8JwX0k6s5Dl
   qLBxXzTmsDVsI/lP8IybR3SDJ9aQU5dykxEyxXMxD64dhENhRCGXNRMv4
   Lr/do+X8tIIqA6epPDFsgZa47rC15/IMHmIHrcpbeBlvY1JaTp2vd/w1m
   QNIBhLyGzA9+KTrOoLh2j1eCHaQe2lHCte+ivQsecuyILz3HAV28uGCaH
   wDxkJ5onsq2+QjiY9Dv8MyYSNDfo3quowMx8kaTukrDAqKl4rCOhP8RYZ
   Q==;
X-CSE-ConnectionGUID: dY+M7VQ+QbmniU0R2ysIcw==
X-CSE-MsgGUID: 8BmP2NUZQRiIF2ndRlI8Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26858740"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="26858740"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 16:48:21 -0700
X-CSE-ConnectionGUID: KxpGiRmUTLiJyXH3hBArGA==
X-CSE-MsgGUID: iCEcDrm0Tu2uBukA6fy7nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="77514531"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Sep 2024 16:48:19 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sv3eC-000Oof-1s;
	Sun, 29 Sep 2024 23:48:16 +0000
Date: Mon, 30 Sep 2024 07:48:07 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: arch/riscv/errata/andes/errata.c:53:14: warning: result of
 comparison of constant 9223372036854811205 with expression of type 'unsigned
 long' is always true
Message-ID: <202409300745.CSqY0i4z-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9852d85ec9d492ebef56dc5f229416c925758edc
commit: f862bbf4cdca696ef3073c5cf3d340b778a3e42a riscv: Allow NOMMU kernels to run in S-mode
date:   6 months ago
config: riscv-randconfig-r064-20240930 (https://download.01.org/0day-ci/archive/20240930/202409300745.CSqY0i4z-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240930/202409300745.CSqY0i4z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409300745.CSqY0i4z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/riscv/errata/andes/errata.c:53:14: warning: result of comparison of constant 9223372036854811205 with expression of type 'unsigned long' is always true [-Wtautological-constant-out-of-range-compare]
           if (arch_id != ANDESTECH_AX45MP_MARCHID || impid != ANDESTECH_AX45MP_MIMPID)
               ~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +53 arch/riscv/errata/andes/errata.c

e021ae7f5145d4 Lad Prabhakar 2023-08-18  40  
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  41  static void errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
e021ae7f5145d4 Lad Prabhakar 2023-08-18  42  {
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  43  	static bool done;
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  44  
e021ae7f5145d4 Lad Prabhakar 2023-08-18  45  	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  46  		return;
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  47  
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  48  	if (done)
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  49  		return;
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  50  
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  51  	done = true;
e021ae7f5145d4 Lad Prabhakar 2023-08-18  52  
e021ae7f5145d4 Lad Prabhakar 2023-08-18 @53  	if (arch_id != ANDESTECH_AX45MP_MARCHID || impid != ANDESTECH_AX45MP_MIMPID)
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  54  		return;
e021ae7f5145d4 Lad Prabhakar 2023-08-18  55  
e021ae7f5145d4 Lad Prabhakar 2023-08-18  56  	if (!ax45mp_iocp_sw_workaround())
ed5b7cfd7839f9 Lad Prabhakar 2023-11-30  57  		return;
e021ae7f5145d4 Lad Prabhakar 2023-08-18  58  
e021ae7f5145d4 Lad Prabhakar 2023-08-18  59  	/* Set this just to make core cbo code happy */
e021ae7f5145d4 Lad Prabhakar 2023-08-18  60  	riscv_cbom_block_size = 1;
e021ae7f5145d4 Lad Prabhakar 2023-08-18  61  	riscv_noncoherent_supported();
e021ae7f5145d4 Lad Prabhakar 2023-08-18  62  }
e021ae7f5145d4 Lad Prabhakar 2023-08-18  63  

:::::: The code at line 53 was first introduced by commit
:::::: e021ae7f5145d46ab64cb058cbffda31059f37e5 riscv: errata: Add Andes alternative ports

:::::: TO: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

