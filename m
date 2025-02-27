Return-Path: <linux-kernel+bounces-536924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A5A485EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B26188219F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855331C6FEA;
	Thu, 27 Feb 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fR+BMNmA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCF1ACECF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675289; cv=none; b=YLdUe1F4QG/eEABxirikr6FUjTOJSk7qyKnq3v7VrNgIqK1x3cxTq1872UFwjJngOXOf46CCf94cIqj/FQ5nV/2TXew5YUYOy/Kx9Z62UQCowZVBb2iqbdMZAb4u5hqhryKXlPZbw6MCeylVHblUrQAY4uiPEuWuHbdbLJ51fY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675289; c=relaxed/simple;
	bh=wmPZL0hTajLmHouhNoG+H8g4d9k2lliIa/FDsUAPuXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koOlUFAIA7etE/10k4xHzFEmCaHxU6kbaMYUNVu4LdK2J6Ko+tItgHnKKsjaCaQtH8r4AwfGr1zlYows5Blg+MSnbH1ekMwdn27VY3dpMz2LuAlEbczqLyL9wuEhEet4O4l2vHrjONaZiXFD8UN3Vs05Zl0+m9Gw+MRvOprZ1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fR+BMNmA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740675286; x=1772211286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wmPZL0hTajLmHouhNoG+H8g4d9k2lliIa/FDsUAPuXM=;
  b=fR+BMNmAYIzkn1JDa9x0MkXGSGPjrQh2DojUua44lvIboDFqUlUS0fb0
   OhsWwiI7/wEFmQVjgXO4c5kVDuQhpYVKrLWBQY4kwSWKpNM1gS7GaL/Hr
   jtdG5pO+aAfAoR2aMbrISKsUjMWaipO/9CeVgdbRVKq9COVt57wwbDNSn
   ZAxSSLgFm0JJqgorM2KPMsNJUAdKs8u64J56JCR+Ld1v+sxMi0bInsn/6
   CeJAuXTlU+hf64AWtnGCI9kpzSRgkDQ2EjxPmRNqRrqDsxWkc6DR3Xs2E
   V3wWqH087rp5qfvOvyICWwvQwJukNI51aaoeRBHZNV9n2ck8g8EJI3rvA
   g==;
X-CSE-ConnectionGUID: cn4fbmlqQWy0d3xlySu+OA==
X-CSE-MsgGUID: r1qFtOauTCmgi/HAgVyYqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41495722"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41495722"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 08:54:46 -0800
X-CSE-ConnectionGUID: ZDe6c26fRMyo6x8RxzXcLQ==
X-CSE-MsgGUID: cBPTHcmiQ0mGjDKfAROMAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117580453"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 27 Feb 2025 08:54:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnh9j-000Djc-3D;
	Thu, 27 Feb 2025 16:54:39 +0000
Date: Fri, 28 Feb 2025 00:54:16 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Garg <gargaditya08@live.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Message-ID: <202502280028.1Y9QMcR0-lkp@intel.com>
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
config: alpha-kismet-CONFIG_HID_MULTITOUCH-CONFIG_DRM_APPLETBDRM-0-0 (https://download.01.org/0day-ci/archive/20250228/202502280028.1Y9QMcR0-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250228/202502280028.1Y9QMcR0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280028.1Y9QMcR0-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for HID_MULTITOUCH when selected by DRM_APPLETBDRM
   WARNING: unmet direct dependencies detected for HID_MULTITOUCH
     Depends on [n]: HID_SUPPORT [=n] && HID [=n]
     Selected by [y]:
     - DRM_APPLETBDRM [=y] && HAS_IOMEM [=y] && DRM [=y] && USB [=y] && MMU [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

