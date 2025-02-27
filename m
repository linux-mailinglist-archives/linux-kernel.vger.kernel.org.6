Return-Path: <linux-kernel+bounces-537528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57DBA48D06
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2748E1890937
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BEE27293B;
	Thu, 27 Feb 2025 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKFi+JY4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E0272914
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700775; cv=none; b=hZCtUlqN6alQSrzZGzRvN3kC1paySGxI06L4TrZ4JA6Gdo2tspr1jD4Q113DAUWe1BKG8wrm/bIUOIL1Qxtp4AMSJPDjVsViauxHv6rVxVat+Hl4QJS/Invy1t+3TqtRvKkOdfMIebmrjfnCK6dMG4muq6YnHkvoFKzXjECU4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700775; c=relaxed/simple;
	bh=/agnUZDgWlxSvKeQY3JUoMYzB/+byrjfvzVqkXRYtNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDK23wDeTlgapa6BYrQlQGO0soou8764h+bwOwFU07/WP+xHTCBC0pk9WjS+R5sEMfpsv3SoZS7/Tsau1puwFTosh+ny0qPjg62jHU8wptlA6acd1QQAbBRRWjMa44mpUwgA77u+gn8o5GNCmEordgBU/C95dcTvI5IfBi7+rww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKFi+JY4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740700774; x=1772236774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/agnUZDgWlxSvKeQY3JUoMYzB/+byrjfvzVqkXRYtNQ=;
  b=UKFi+JY4TyRG1oQcXDmdWWfcQUP8LmvSs3mQ6eTn7Eli1EpCDQhMDFn+
   WeCAS7qhhDp490epeqzP7Yx6VtLuL25BoASyEGysCcyXErxBKPJ0/Klya
   HbyfDt9GK5QohdXgK19OvPY73vJObHkxaEn2Gyb55vTRMYm7Gkh3ngJ4O
   bJk+QVwTWE4v0Ktoez3Sw6AivLTWFhq2QGbrNFUFhOj1nhnt0l/FH1Vm1
   tRGb6QH/P3G4+peskiuVf0VDMXb0IF+6k1SiKcg7Zhk4qwe/VWhc5sWPq
   UhJxD3VdcY0i/wbM1xxHyr2utPgOeGIY5CFG2A1Cn6ueIDwwSU+AelhGk
   A==;
X-CSE-ConnectionGUID: bKzqbkfvRrmThqKvMuy5/w==
X-CSE-MsgGUID: phf5r7ycThyFwFkJXb5coQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45398272"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45398272"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:59:33 -0800
X-CSE-ConnectionGUID: ojAs1k/MS9SEC9VHc3zyCA==
X-CSE-MsgGUID: Z4S+jU04ThCLAbI6XFSa+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="140399632"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2025 15:59:29 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnnmo-000ECu-3C;
	Thu, 27 Feb 2025 23:59:26 +0000
Date: Fri, 28 Feb 2025 07:59:00 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Garg <gargaditya08@live.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Message-ID: <202502280748.oNKTNuMK-lkp@intel.com>
References: <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>

Hi Aditya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc4 next-20250227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Garg/drm-format-helper-Add-conversion-from-XRGB8888-to-BGR888/20250224-214352
base:   linus/master
patch link:    https://lore.kernel.org/r/844C1D39-4891-4DC2-8458-F46FA1B59FA0%40live.com
patch subject: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86 Macs
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250228/202502280748.oNKTNuMK-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280748.oNKTNuMK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280748.oNKTNuMK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/tiny/appletbdrm.c: In function 'appletbdrm_primary_plane_duplicate_state':
>> drivers/gpu/drm/tiny/appletbdrm.c:524:40: warning: variable 'old_appletbdrm_state' set but not used [-Wunused-but-set-variable]
     524 |         struct appletbdrm_plane_state *old_appletbdrm_state;
         |                                        ^~~~~~~~~~~~~~~~~~~~


vim +/old_appletbdrm_state +524 drivers/gpu/drm/tiny/appletbdrm.c

   520	
   521	static struct drm_plane_state *appletbdrm_primary_plane_duplicate_state(struct drm_plane *plane)
   522	{
   523		struct drm_shadow_plane_state *new_shadow_plane_state;
 > 524		struct appletbdrm_plane_state *old_appletbdrm_state;
   525		struct appletbdrm_plane_state *appletbdrm_state;
   526	
   527		if (WARN_ON(!plane->state))
   528			return NULL;
   529	
   530		old_appletbdrm_state = to_appletbdrm_plane_state(plane->state);
   531		appletbdrm_state = kzalloc(sizeof(*appletbdrm_state), GFP_KERNEL);
   532		if (!appletbdrm_state)
   533			return NULL;
   534	
   535		/* Request and response are not duplicated and are allocated in .atomic_check */
   536		appletbdrm_state->request = NULL;
   537		appletbdrm_state->response = NULL;
   538	
   539		appletbdrm_state->request_size = 0;
   540		appletbdrm_state->frames_size = 0;
   541	
   542		new_shadow_plane_state = &appletbdrm_state->base;
   543	
   544		__drm_gem_duplicate_shadow_plane_state(plane, new_shadow_plane_state);
   545	
   546		return &new_shadow_plane_state->base;
   547	}
   548	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

