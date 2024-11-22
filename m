Return-Path: <linux-kernel+bounces-417719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D049D584D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D45C28240F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26591509B6;
	Fri, 22 Nov 2024 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leVA3bQL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D1230988;
	Fri, 22 Nov 2024 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732242581; cv=none; b=jYS+X1ZZjaG2kKN9xWpEp0mVlImKbL1ubLwOtv8YNPvWMXi2gt7Bt6LfXSc+OZ7VxG9WFG5Sh9Br6Wd2DQ1rAoz5yTIzjaVs/C4iNzQo2ZlAr4bZ/49gvi00CRKFeIz7rXSIwzvRlXJPdjG2L/rIRQ0tfhf4h+vvRJmofy6XeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732242581; c=relaxed/simple;
	bh=ygXdHoYgdDV8uhUQRvreb/w1Nsb+bH9PmhGFMqtau+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOdhpvYAm+7b7lU3kPb+DX+GqddMRzikpPHRiIOtFwhUR56VB7yOoZVsdcJw6A9DUWzDAnP91Eu2p9qSAJTJnLmKTrx8ImixdslfkYSwOogc00M1V4c+++5Cg5F08fH93jg1nLUlLGLS0JJb84PRksWwmd58dU+Wr+zM4DPylHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leVA3bQL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732242580; x=1763778580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ygXdHoYgdDV8uhUQRvreb/w1Nsb+bH9PmhGFMqtau+E=;
  b=leVA3bQLs1t1CdF/bHyrVzqEfvlUnnQxmjQSTUIH25TPd6JG/RBrhUp7
   J4MpkpuilTPrcsvDsW+SNgd4E2fPnq0uS+PwXX5WO+Z2BKLrXsC10cgqd
   qpJ0QRdRGrQYeGoH2kKgf6WG6RYn78ESt3cwnmEBEhezxUozq1Y6HSyIQ
   u/naThSHSiJtP+Nwvh9glUKvbzquKKxPAfygX7yOA/zLL4R2O11g7i5E3
   SurYWouJkpYHhllw3wVD77Qi1qjacOxS1lXTiPNAr5tntO6gOR8om8pJo
   5p3RVsXka7ue6CE+PJnsHqnN8pPwqgJu4QkGA4VUV1qZoXHnx5w6J4pOo
   A==;
X-CSE-ConnectionGUID: LFFFaWKZRviz5MsfVeq+Uw==
X-CSE-MsgGUID: 1zOqwdHnQmGyL5tIxIw6fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43764557"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="43764557"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 18:29:37 -0800
X-CSE-ConnectionGUID: h0ffBcEBS0CwwylnBUecLg==
X-CSE-MsgGUID: TZLT3qEHTNWFslZClvwikw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="90601994"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 21 Nov 2024 18:29:30 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEJQG-0003av-0G;
	Fri, 22 Nov 2024 02:29:28 +0000
Date: Fri, 22 Nov 2024 10:28:38 +0800
From: kernel test robot <lkp@intel.com>
To: keith zhao <keith.zhao@starfivetech.com>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
	andy.yan@rock-chips.com, william.qiu@starfivetech.com,
	xingyu.wu@starfivetech.com, kernel@esmil.dk,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	p.zabel@pengutronix.de, changhuang.liang@starfivetech.com,
	keith.zhao@starfivetech.com, jack.zhu@starfivetech.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] drm/vs: Add Hardware Functions for VS DC8200
Message-ID: <202411221030.71tSpXt2-lkp@intel.com>
References: <20241120061848.196754-5-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120061848.196754-5-keith.zhao@starfivetech.com>

Hi keith,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12 next-20241121]
[cannot apply to drm-misc/drm-misc-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/keith-zhao/dt-bindings-display-bindings-for-starfive-JH7110-display-pipeline/20241121-145710
base:   linus/master
patch link:    https://lore.kernel.org/r/20241120061848.196754-5-keith.zhao%40starfivetech.com
patch subject: [PATCH v5 4/9] drm/vs: Add Hardware Functions for VS DC8200
config: xtensa-kismet-CONFIG_CMA-CONFIG_DRM_VERISILICON_DC8200-0-0 (https://download.01.org/0day-ci/archive/20241122/202411221030.71tSpXt2-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241122/202411221030.71tSpXt2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411221030.71tSpXt2-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CMA when selected by DRM_VERISILICON_DC8200
   WARNING: unmet direct dependencies detected for CMA
     Depends on [n]: MMU [=n]
     Selected by [y]:
     - DRM_VERISILICON_DC8200 [=y] && HAS_IOMEM [=y] && DRM [=y] && HAVE_DMA_CONTIGUOUS [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

