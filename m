Return-Path: <linux-kernel+bounces-319943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B8F970401
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 22:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCB91C21D1D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF1166F3A;
	Sat,  7 Sep 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbu4IFc4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C5F159583
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725739596; cv=none; b=QgLkwCYybL4tkltmzuwBY6B63i7pOY4q94jpqKFAtSYbWmPL/uT+CWb8Jy83m4gw4z2Y2E0jJsz6gjdtQTCOFbBYAikcIrfvj2q0xNgXryXBpO3tdECEdtO6x6RNV2SJUZZTUJDyJ7KEnk702QtaJIJJN91wXRppRt/c8NJTwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725739596; c=relaxed/simple;
	bh=idxaTK/PYli7+0psMZ7ekQHzTqlW6+uNsCvxrCQIv2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/QU0VrJibw58ULNU7zHVQVWWaadL9g41tmWv/oCJ+0SgdPIhwjeDqP7kjuhV+/2bd8MN5UksC1jF6hIJCkmRuKlMPS9B3c6k2oJNfKq5MVdAhpbtZXPGSvsAygt1TGSVJ3O/URO42zIxFGw0BE4s+5V+5GMLSxv1nMpT3pfAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbu4IFc4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725739595; x=1757275595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=idxaTK/PYli7+0psMZ7ekQHzTqlW6+uNsCvxrCQIv2c=;
  b=dbu4IFc4u561oyteeEPxlyLBvl4XNl56UwFn39/TWDHbK+vH6RLgjuml
   967PIghuaBHI+wD3hcQ79ySWBtOximIRYILoz/xasYi9d75nOfU+l6nx4
   IY9U9DtGqY/R/ARPre51m8g0hpOCsVriZ2hxfbV1lCk0vzHbx1f3VF/RD
   JECl66foPRswXOTB6CApQuEaFYF7mY3bRRx+s43fbTrx8fxdX+Wcx2xnt
   5lwrCIQyBQ/hI0GPCmW+Df0NO+hF279jKe4xAF3kvTc7wvs2DJ+Gz6Y7f
   XmJMS1C54Qy2k5+O11Qq0/o6Q1NDu9JhJndtZvAY3tvxrYLC7/Xp83lF8
   w==;
X-CSE-ConnectionGUID: Ls6HhnjrRLCcnu9mCzQEbQ==
X-CSE-MsgGUID: ATEnPiOgQAe6WfEF9vVvRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24667687"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="24667687"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 13:06:34 -0700
X-CSE-ConnectionGUID: h1ja1DfPRTW0LAbr45mSzg==
X-CSE-MsgGUID: TGDSFjBRRPKQmb61TC/ixg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="70669947"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Sep 2024 13:06:32 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn1hW-000CxL-10;
	Sat, 07 Sep 2024 20:06:30 +0000
Date: Sun, 8 Sep 2024 04:05:40 +0800
From: kernel test robot <lkp@intel.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gcherian@marvell.com, bbhushan2@marvell.com, sgoutham@marvell.com,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [PATCH v7 3/6] perf/marvell: Refactor to add version - no
 functional change
Message-ID: <202409080342.NUUWhk1l-lkp@intel.com>
References: <20240904182605.953927-4-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904182605.953927-4-gthiagarajan@marvell.com>

Hi Gowthami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gowthami-Thiagarajan/perf-marvell-Refactor-to-extract-platform-data-no-functional-change/20240905-022904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240904182605.953927-4-gthiagarajan%40marvell.com
patch subject: [PATCH v7 3/6] perf/marvell: Refactor to add version - no functional change
config: x86_64-buildonly-randconfig-006-20240908 (https://download.01.org/0day-ci/archive/20240908/202409080342.NUUWhk1l-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080342.NUUWhk1l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080342.NUUWhk1l-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/marvell_cn10k_ddr_pmu.c:750:34: warning: unused variable 'ddr_pmu_data' [-Wunused-const-variable]
     750 | static const struct ddr_pmu_data ddr_pmu_data = {
         |                                  ^~~~~~~~~~~~
   1 warning generated.


vim +/ddr_pmu_data +750 drivers/perf/marvell_cn10k_ddr_pmu.c

   749	
 > 750	static const struct ddr_pmu_data ddr_pmu_data = {
   751		.id   = DDR_PMU_V1,
   752	};
   753	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

