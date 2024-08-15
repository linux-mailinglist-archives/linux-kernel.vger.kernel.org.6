Return-Path: <linux-kernel+bounces-287551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977B695291E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3130288131
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBD5176AAE;
	Thu, 15 Aug 2024 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKv3R2Ta"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF928433D0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701722; cv=none; b=iM86xZsw72wTpsYvMZcOZYAk4WCU/sQC1qqR0xe/ZMpq9L49h33HfbDxn+yQl7OkZj6iVzjG29oKHhidb9KPKXkzL2AF0ycCNU3N7Il3Q6ajsoIGYhuBsr0r65U097kysA7A2MP8Imkm1Tw24LXLIpOCInUE9mTNlgZYnGnJZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701722; c=relaxed/simple;
	bh=vu1B/EeFrK/WcfW+zjpMgI08UNRgMD3HObvhhZKI/Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huIPlSFniOVO6JJrbasteVIwBAJVEcWYhqIzIB2BfJHCVLYSDPCNkF2++rMr/vdjgarcF58vZaB4wVP7H6Gmsw/eX6tmNJKmb4nkPIB6+83tHNHv/a2SiIjyzUpHlg98D0T1FhagsCwKHhmV8TS7iP2V1WNQl8gy6eVLKsBWpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKv3R2Ta; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723701721; x=1755237721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vu1B/EeFrK/WcfW+zjpMgI08UNRgMD3HObvhhZKI/Fk=;
  b=gKv3R2TaXfAfi8wV3l78fKt3D7bLQ0lp2hOnfxw1zW0MWirky4H7G03V
   S3HUSb2zfjkdbVZIozj6RgbxEGoj0vAxivSHeKWAZk/UjqLKZA3M7sIyo
   C6JesQ0/+HP5PUMn49iRDUQxsQ15pjNPIKPBmhV5b6j004Z+wzNUoIYO3
   qcm/WbxTQI3aMKM27EFCaIt6kcpwHzPUy+vic3SQek0Bh3VgOd/8RcQAQ
   gbSQMLapqKMA93I+lzKMc3cbB63Ep/LXHacM3oSuja1PfnZY1nRlDMjJ9
   onxfpMJ5isz6Ww4NNwBwSbdzVLkvQrr0E9QZiALVlk45L75q89pUCn113
   A==;
X-CSE-ConnectionGUID: /qJJwqDQRuWqVKG4OGORpw==
X-CSE-MsgGUID: pyDg65jGRGOj133xMUrpxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21821138"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="21821138"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 23:02:00 -0700
X-CSE-ConnectionGUID: gPdgotpfQI6thxk2ydnzLA==
X-CSE-MsgGUID: 9LUZn0LHRk2aVlw9PuLIng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59238463"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Aug 2024 23:01:58 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seTYa-0003Fa-0W;
	Thu, 15 Aug 2024 06:01:56 +0000
Date: Thu, 15 Aug 2024 14:01:22 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, liviu.dudau@arm.com,
	steven.price@arm.com, carsten.haitzler@arm.com,
	boris.brezillon@collabora.com, robh@kernel.org,
	faith.ekstrand@collabora.com
Cc: oe-kbuild-all@lists.linux.dev,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] drm: panthor: add devcoredump support
Message-ID: <202408151326.jXpMoKtS-lkp@intel.com>
References: <20240813210555.607641-4-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813210555.607641-4-daniel.almeida@collabora.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.11-rc3 next-20240814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Almeida/drm-panthor-expose-some-fw-information-through-the-query-ioctl/20240814-234511
base:   git://anongit.freedesktop.org/drm/drm drm-next
patch link:    https://lore.kernel.org/r/20240813210555.607641-4-daniel.almeida%40collabora.com
patch subject: [PATCH v2 2/5] drm: panthor: add devcoredump support
config: x86_64-buildonly-randconfig-002-20240815 (https://download.01.org/0day-ci/archive/20240815/202408151326.jXpMoKtS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151326.jXpMoKtS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151326.jXpMoKtS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/drm/panthor_drm.h:1073:9: error: unknown type name 'u32'
    1073 |         u32 flags;
         |         ^~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

