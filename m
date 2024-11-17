Return-Path: <linux-kernel+bounces-411989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 588399D020B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 06:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012231F22150
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 05:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E2C2561D;
	Sun, 17 Nov 2024 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5h7XVNe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376171CFBC
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731819900; cv=none; b=az4plSw/mJBNLplsaMWHt/bkIXoa62X6xy76ReASgr7f29vvu48dcYq5q3oAqTO87wVkEZg4i3zie0XEd+pj5ritjoxbRMoa8tJRhrkKQf03OdMwhdhFYA/9+uTK0uaA0O1W+nkNagZEInAmWyiTh0aGTOX63LXVuACzHTfl544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731819900; c=relaxed/simple;
	bh=20y8OGZSQnC8J2Yf8YwMSVI1+a57Lz4nJCgsXlDc/Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcWQEhEwumO3EXfgLiI/n26VyTn5INe0vOiWpjRFAfdaKHJw/+NkBbGwL0Fk7Du2DZrNEEnXviIQYdgosxbe5JXEOwewKKZJo3i8tVGbaePhW7xvqcg4IV/1BD7zNklyIut1yGG9/jPHDcBU0oIGSwGhp9YMhsKlS9O3vPqgTbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5h7XVNe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731819899; x=1763355899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=20y8OGZSQnC8J2Yf8YwMSVI1+a57Lz4nJCgsXlDc/Dg=;
  b=l5h7XVNeL5Ww0pV6AGT0gsy2XsN498cVR5H9kXLijhcTkfnzJJ2Ld5UE
   ux2uqCaXtmK5JNltEFx5SpkMitSq/smFwMhr0dDYEvgr4IYHvhSYpxSZE
   rU6iQys8dvRVuGKm6fWqP2FELtk+JbvozL74abmgLO4zZEZWb1yMloXtB
   IMSusLVJ1FjzDyHYF298GBJA3yAcNkdieTgxcWlDtUiIy/GxlAdH9Qd29
   46D6aO4oTfSNXbjKK3Wzw/NRhOm5zCBj/jtrLtRG2/o2E1HFYeu9DcA7j
   cvHabzGEymAGlIbCk2duahHnw2jwMyAfhzbhhWtIDPDmmYQbEgKwCA8s3
   g==;
X-CSE-ConnectionGUID: ZzgfYxkpTWKjrYXEeJZ3yA==
X-CSE-MsgGUID: aNXi8hmbS+a9Ch3kLN47wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31713539"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31713539"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 21:04:58 -0800
X-CSE-ConnectionGUID: gHbq7c/7Sk234V0ozXvUwA==
X-CSE-MsgGUID: j7H8LuLYS1eK/xhQ0aU1UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="119853918"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Nov 2024 21:04:54 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCXSu-0001Wr-1P;
	Sun, 17 Nov 2024 05:04:52 +0000
Date: Sun, 17 Nov 2024 13:04:45 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jani Nikula <jani.nikula@intel.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: rework FB_CORE dependency
Message-ID: <202411171217.DZow6M4R-lkp@intel.com>
References: <20241115152722.3537630-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115152722.3537630-1-arnd@kernel.org>

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-exynos/exynos-drm-next]
[also build test ERROR on next-20241115]
[cannot apply to linus/master v6.12-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/drm-rework-FB_CORE-dependency/20241117-003714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
patch link:    https://lore.kernel.org/r/20241115152722.3537630-1-arnd%40kernel.org
patch subject: [PATCH] drm: rework FB_CORE dependency
config: arc-randconfig-052-20241117 (attached as .config)
compiler: arc-elf-gcc (GCC) 13.2.0
dtschema version: 2024.12.dev1+gcabb5b9
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171217.DZow6M4R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171217.DZow6M4R-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: recursive dependency detected!
   symbol BACKLIGHT_CLASS_DEVICE is selected by FB_BACKLIGHT
   symbol FB_BACKLIGHT is selected by FB_SH_MOBILE_LCDC
   symbol FB_SH_MOBILE_LCDC depends on FB_DEVICE
   symbol FB_DEVICE depends on FB_CORE
   symbol FB_CORE is selected by DRM_KMS_HELPER
   symbol DRM_KMS_HELPER is selected by DRM_MIPI_DBI
   symbol DRM_MIPI_DBI is selected by DRM_PANEL_ILITEK_ILI9341
   symbol DRM_PANEL_ILITEK_ILI9341 depends on BACKLIGHT_CLASS_DEVICE
   For a resolution refer to Documentation/kbuild/kconfig-language.rst
   subsection "Kconfig recursive dependency limitations"

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

