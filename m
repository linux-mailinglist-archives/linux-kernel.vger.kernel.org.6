Return-Path: <linux-kernel+bounces-548302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D15A5A54322
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B37A4B95
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC91A316C;
	Thu,  6 Mar 2025 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Frk96SLE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96018DB04;
	Thu,  6 Mar 2025 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244268; cv=none; b=c3Tdj55hWxMh3QY/XOxfhfvw1SwSP/+OplXe9awvdbP+42tBPFTs2aK90OSnGZEZaI6GD55RZIYyofV0/2T/xWSO44fQJK+Eza/Ho/rDAveLz2epUNBOvzqGRhEKMgO8GiX7WbWkfWGZRxIYmdNWms1EA2VLz8s8xnjlHOJ/7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244268; c=relaxed/simple;
	bh=weI/kwSBsrQsHpQ8px4HMhGgp73aX2Uq1ONCo9dVmW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/kpM/3qhF9Nqc8gcUgmeOZBbNBbGd76g9HO2sBu0ILYwGaoSi5j+lu00M9kLplSXF9VeMXYOcMCFqWvk0IgTOTFbDO83XtIg/Mawh4ltexG7ijShWhXNGsVlhl5TrrER99MP9BHjO7lyLK9p0ulD5bzpDOTSSschjBUCVsT0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Frk96SLE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741244267; x=1772780267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=weI/kwSBsrQsHpQ8px4HMhGgp73aX2Uq1ONCo9dVmW0=;
  b=Frk96SLERu0XMDV+OTWGomq6sO/pmeSKpZ6h0oPjBWuwy64WDNFXnayp
   GIew258qLveFlqSEOsM1oVRF5kQc5X41vrg3IOWg/R2SppdICJb4Djsjn
   KbJI6vYGVBBEcusG7FfdBQ0MFiJhR84u1yRFoz4wTAC5F1eczwFLcVxSC
   Fi2KA4dJolT7ih9tbt/Kd3CwjKmueKJOwhsN07ajKc5hk1jcvIUKC9BvR
   Wjv3A28ppdCEJ+ZxIy0oi+aVLYmpAhdvxG8UNNPARojvGBKIgI+pRbUPR
   aWD0Xp175SMrB3jnupp4jHoOBpCu6RNUqtI5nrtAZa6v17JEZORxNuTXN
   A==;
X-CSE-ConnectionGUID: 5zCScHmbRLmEWlDHpGP03w==
X-CSE-MsgGUID: VlvtVbvhQ0GQhuazY70xVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41947969"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41947969"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:57:46 -0800
X-CSE-ConnectionGUID: a4th9ztnTA+EfE0LcPrpNQ==
X-CSE-MsgGUID: cy620EDBRQeGbwMOaavjKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="119107579"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 05 Mar 2025 22:57:42 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq5Aq-000MfU-2r;
	Thu, 06 Mar 2025 06:57:40 +0000
Date: Thu, 6 Mar 2025 14:56:57 +0800
From: kernel test robot <lkp@intel.com>
To: Stanley Chu <stanley.chuys@gmail.com>, frank.li@nxp.com,
	miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v6 2/5] i3c: master: svc: Add support for Nuvoton npcm845
 i3c
Message-ID: <202503061400.GGr64rkR-lkp@intel.com>
References: <20250305034414.2246870-3-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305034414.2246870-3-yschu@nuvoton.com>

Hi Stanley,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanley-Chu/dt-bindings-i3c-silvaco-Add-npcm845-compatible-string/20250305-114705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250305034414.2246870-3-yschu%40nuvoton.com
patch subject: [PATCH v6 2/5] i3c: master: svc: Add support for Nuvoton npcm845 i3c
config: sparc-randconfig-r121-20250306 (https://download.01.org/0day-ci/archive/20250306/202503061400.GGr64rkR-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250306/202503061400.GGr64rkR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061400.GGr64rkR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/i3c/master/svc-i3c-master.c:1971:30: sparse: sparse: symbol 'npcm845_drvdata' was not declared. Should it be static?
>> drivers/i3c/master/svc-i3c-master.c:1973:30: sparse: sparse: symbol 'svc_default_drvdata' was not declared. Should it be static?
   drivers/i3c/master/svc-i3c-master.c:559:9: sparse: sparse: context imbalance in 'svc_i3c_master_ibi_work' - wrong count at exit
   drivers/i3c/master/svc-i3c-master.c: note: in included file (through include/linux/mutex.h, include/linux/notifier.h, include/linux/clk.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +/svc_default_drvdata +1973 drivers/i3c/master/svc-i3c-master.c

  1972	
> 1973	const struct svc_i3c_drvdata svc_default_drvdata = {};
  1974	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

