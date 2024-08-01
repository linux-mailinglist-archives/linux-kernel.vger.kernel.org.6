Return-Path: <linux-kernel+bounces-270629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD5D94428D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DA2B228E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655CF13DDBA;
	Thu,  1 Aug 2024 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWsW+No3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAF13D285
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 05:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488840; cv=none; b=mHlWZLCNS79ciPXO9v6T4qYcJvoIWDiU3cNRI5nikEvvWONPtggy6jh58rDmJDHXMRzClvfnSZanXSsl5HXPdaGXSFsfWEx6dGYYrCifc729n3j0R7JKS1SX18uYTQSmGdrqPFgolQO0Q7hi/HN7QDPfy745ca2RhwrkdjTc/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488840; c=relaxed/simple;
	bh=6R3N6dCTBbx2A74RWo9sA7qcPX1kWRHb71LumIZ6Qeo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TxB2iwkYGSdJxFnvpAOrLy5T023Je2quw8hk/fwb3f7XNpaXn8ZXfGv3TgJBGd1fZk67a9j50wxDrJgwHYManspTFaJ8vZaUs374nhFqTJNUnaUYxUBFGgSEooG8zmEeQvCs4JP4qqKzr0rj4OjlktbR2u9esV1ovyCR/n7+bTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWsW+No3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722488839; x=1754024839;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6R3N6dCTBbx2A74RWo9sA7qcPX1kWRHb71LumIZ6Qeo=;
  b=mWsW+No3Lf6MRQJeMojKneO6Yo8+raFmxD/h64HPCCPeI0jArhVKR4FW
   SH5Kj8MbYhOKERGGC12afffOZ6V9IGRHojJTm/vdoDJpyAi/UTRJvaAPs
   HayhfDOEo7FXpQPbuXPUd0TewpcCNRLKRfbBL9EKWss0Uq6CrKngecVvt
   LyHB86Y7Pk1w+NQCd0bi4wFljqbeZnHnlnniwcbyGL8Colp2jFpO6aZS9
   /asOUUSUTwKXQgSh1HlMCLbGMkfT9L97/y7EBIvE09233C/a1Tuvz/MZL
   krkT1SXmTKem4D1bUaFoMhHuurqbSUSys8AMP8uBDsA1AYMfWoe+lU+YB
   w==;
X-CSE-ConnectionGUID: R1yQFNapT9aa2ilv3TAxTQ==
X-CSE-MsgGUID: pSgEsaUSTWuBue4RU9VCjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20598707"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="20598707"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 22:07:18 -0700
X-CSE-ConnectionGUID: 56f1p/3cTNGH95OF1jZvZA==
X-CSE-MsgGUID: CfNeoJGtS0SBydyzzbH2Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="85527398"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Jul 2024 22:07:17 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZO1y-000vDX-07;
	Thu, 01 Aug 2024 05:07:14 +0000
Date: Thu, 1 Aug 2024 13:06:46 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: arch/powerpc/mm/nohash/tlb_64e.c:36:5: sparse: sparse: symbol
 'mmu_pte_psize' was not declared. Should it be static?
Message-ID: <202408011256.1O99IB0s-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21b136cc63d2a9ddd60d4699552b69c214b32964
commit: a898530eea3d0ba08c17a60865995a3bb468d1bc powerpc/64e: split out nohash Book3E 64-bit code
date:   3 weeks ago
config: powerpc64-randconfig-r122-20240801 (https://download.01.org/0day-ci/archive/20240801/202408011256.1O99IB0s-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240801/202408011256.1O99IB0s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408011256.1O99IB0s-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/mm/nohash/tlb_64e.c:36:5: sparse: sparse: symbol 'mmu_pte_psize' was not declared. Should it be static?
   arch/powerpc/mm/nohash/tlb_64e.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false

vim +/mmu_pte_psize +36 arch/powerpc/mm/nohash/tlb_64e.c

    31	
    32	/* The variables below are currently only used on 64-bit Book3E
    33	 * though this will probably be made common with other nohash
    34	 * implementations at some point
    35	 */
  > 36	int mmu_pte_psize;		/* Page size used for PTE pages */
    37	int mmu_vmemmap_psize;		/* Page size used for the virtual mem map */
    38	int book3e_htw_mode;		/* HW tablewalk?  Value is PPC_HTW_* */
    39	unsigned long linear_map_top;	/* Top of linear mapping */
    40	
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

