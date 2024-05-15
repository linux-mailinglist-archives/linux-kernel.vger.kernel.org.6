Return-Path: <linux-kernel+bounces-180313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7A88C6CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94CB5B20B47
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7186159568;
	Wed, 15 May 2024 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBIwTOpv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260E15ADAF
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800866; cv=none; b=JZBeQxrwHbiCoSHQ7MEHmTEbOHFzCtV+CLbXOWeAUL2fVKPKScBhpRBNlqHnUZYkaDvUHXFb3duTOsktoOl5wEyAWDdTtStGqx/FsEG1FU3+jl7xGhPB8WrVZSzFdXOCYe3XCK/Sg6SNIfRhgIAKLXCbAjaSZdW0It8zbFcDmiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800866; c=relaxed/simple;
	bh=7LfF5lcOdFPeGFTPb+fODEveoslcVaZ/X2jDGxGMktg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nviLlrJb0Q75S2etD0UpdcWryb6PJqJm4r6WGnPgWzNsYMc/QtPlc+Za/xBQPFDLilZLB5XgNq92Q37852gex4vslODV65pGVd/tfyydcRy4oO7/Mut/h/mvqRtyGiNWeJx6EKS1lsoRvqIFoepHjOGEKN8csKvOjcAam9+lc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBIwTOpv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715800864; x=1747336864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7LfF5lcOdFPeGFTPb+fODEveoslcVaZ/X2jDGxGMktg=;
  b=QBIwTOpvZfLKmplp2NPJi/R6gL/oBIJUKZTEG/lG00fl5oHxfr2o20yY
   ak2/BCp1mMSt6HwQB4cyJU+8gB59oqHapTaEuLCSRYzNtBW0MpjN6FD9F
   oNR5DJshIBJ7685PW+wZa64ebnXs9aTdQtcN+ySWr1rKVCRfvd0o+I287
   OUOn1A6FtRZob3eyeuq5pD7Rd31CQVnJZFsEtxMru62I3q3bubCffbxZH
   qCmM1hM6osWDkR0aiCsEzAD8nnaosYeHDXtsVc2QxRURye3hpFVZbifjE
   M4Zu35sD8z8U1YszdvHXN/WLK/aPnJjYSdQ2Nccpoix6pBkp3qjvSn0w3
   w==;
X-CSE-ConnectionGUID: P7oht22gR/6Zw0Xw+faw2g==
X-CSE-MsgGUID: 2sykfVNZSwO4yov31vuNwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23276590"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="23276590"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 12:21:03 -0700
X-CSE-ConnectionGUID: lwpOMX0UREuLrJXFoRahzQ==
X-CSE-MsgGUID: vsBQ3kzmQoy8Z20D6BF0XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35943377"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 May 2024 12:21:01 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7KBO-000DBr-2O;
	Wed, 15 May 2024 19:20:58 +0000
Date: Thu, 16 May 2024 03:20:56 +0800
From: kernel test robot <lkp@intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, Sui Jingfeng <suijingfeng@loongson.cn>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/loongson: Introduce component framework support
Message-ID: <202405160207.efDMQSwS-lkp@intel.com>
References: <20240513001243.1739336-3-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513001243.1739336-3-sui.jingfeng@linux.dev>

Hi Sui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.9 next-20240515]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/drm-loongson-Add-helpers-for-creating-subdevice/20240513-081653
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240513001243.1739336-3-sui.jingfeng%40linux.dev
patch subject: [PATCH 2/3] drm/loongson: Introduce component framework support
config: alpha-randconfig-r133-20240515 (https://download.01.org/0day-ci/archive/20240516/202405160207.efDMQSwS-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240516/202405160207.efDMQSwS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405160207.efDMQSwS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/loongson/lsdc_drv.c:282:35: sparse: sparse: symbol 'loongson_drm_master_ops' was not declared. Should it be static?

vim +/loongson_drm_master_ops +282 drivers/gpu/drm/loongson/lsdc_drv.c

   281	
 > 282	const struct component_master_ops loongson_drm_master_ops = {
   283		.bind = loongson_drm_master_bind,
   284		.unbind = loongson_drm_master_unbind,
   285	};
   286	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

