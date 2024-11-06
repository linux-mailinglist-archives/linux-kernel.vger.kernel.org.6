Return-Path: <linux-kernel+bounces-397379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FDB9BDB37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6499B21B1C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A9A18786C;
	Wed,  6 Nov 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONtD99Gr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C93EA76
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856663; cv=none; b=RyJ6WqEi5rKud/BikzGl4tr9C0D+fFgj5Whg/iyP7rEj3ZXFteP9jgXB6KnhvxxwTpLBV8rGBFge7F+XxzFYXpWQZLvjRoKHlEV+yHArQnyZ1g1u2DVqz708FycUG8m8UUKekFf4Y3oFtcj1tmDODsOWhgn4N3yMY1EL6OCTZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856663; c=relaxed/simple;
	bh=w4uRAgM8xbGcWtcxv849nFQ4mF6NuoUMjhUqN7BpOZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeVrq+bbQ0sxQojivhaRP0gxMaT46ZSpdUjPxUF1alMR4KhL1VkEQ+aAW6+zo8hOzx1xLiuOP+MLy7Gu37/OpDmk94YtjXmYOrXCkjO7rfsA9MT0lc1bDngtIw0BM2kyUXWkkwoXh0SQtschW6VSrD0qx+IWzBHbcdFuh5kyYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONtD99Gr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730856660; x=1762392660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w4uRAgM8xbGcWtcxv849nFQ4mF6NuoUMjhUqN7BpOZE=;
  b=ONtD99GrBf25+rM34KqHUwiiwURJm/oah1vLGcWaIc5uQ35/pb8qi8bk
   m32DKNOLqFNO0G1UE38es+/jeRiiG2FSdhTn5QJ20y4RaariVeN/uBFcu
   7GNO9SJPGq1kHva5k2UKCo0MNlysf+CTJDpdPM83y8ZogbMGBY8ifnqFJ
   B6VZm7Y0cZBH2l62hclJA8GycLUGFIxUaeBauGxOXBWX4bGs9/w21FEdB
   xq9wwsQpqByCrRLpItYG9tyL0vDW4gQeHdQL0fyDl+BJCl8Yx8vruioCa
   uCkzhgp8GU9o3bUvocDy/Vxd6UMKOoKf3GnSUbEkGe9oet0J+NEaGaHgk
   w==;
X-CSE-ConnectionGUID: w62g+gfjRfau4wwr4o52Ig==
X-CSE-MsgGUID: k1NY0S4gSvWMjuRUrLWyZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53201959"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53201959"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 17:30:59 -0800
X-CSE-ConnectionGUID: 4L7Ct1tFSgaMWkNvEsRxBQ==
X-CSE-MsgGUID: +Z+xLsTLRoWY1bWMap8SKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84347612"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Nov 2024 17:30:55 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Usn-000mhP-1q;
	Wed, 06 Nov 2024 01:30:53 +0000
Date: Wed, 6 Nov 2024 09:30:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v6 2/6] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
Message-ID: <202411060951.mK9Fi0fi-lkp@intel.com>
References: <20241105125109.226866-3-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105125109.226866-3-jfalempe@redhat.com>

Hi Jocelyn,

kernel test robot noticed the following build errors:

[auto build test ERROR on d78f0ee0406803cda8801fd5201746ccf89e5e4a]

url:    https://github.com/intel-lab-lkp/linux/commits/Jocelyn-Falempe/drm-panic-Move-drawing-functions-to-drm_draw/20241105-205432
base:   d78f0ee0406803cda8801fd5201746ccf89e5e4a
patch link:    https://lore.kernel.org/r/20241105125109.226866-3-jfalempe%40redhat.com
patch subject: [PATCH v6 2/6] drm/log: Introduce a new boot logger to draw the kmsg on the screen
config: hexagon-randconfig-002-20241106 (https://download.01.org/0day-ci/archive/20241106/202411060951.mK9Fi0fi-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411060951.mK9Fi0fi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411060951.mK9Fi0fi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: drm_client_setup
   >>> referenced by komeda_drv.c:87 (drivers/gpu/drm/arm/display/komeda/komeda_drv.c:87)
   >>>               drivers/gpu/drm/arm/display/komeda/komeda_drv.o:(komeda_platform_probe) in archive vmlinux.a
   >>> referenced by komeda_drv.c:87 (drivers/gpu/drm/arm/display/komeda/komeda_drv.c:87)
   >>>               drivers/gpu/drm/arm/display/komeda/komeda_drv.o:(komeda_platform_probe) in archive vmlinux.a
   >>> referenced by vkms_drv.c:230 (drivers/gpu/drm/vkms/vkms_drv.c:230)
   >>>               drivers/gpu/drm/vkms/vkms_drv.o:(vkms_init) in archive vmlinux.a
   >>> referenced 23 more times
--
>> ld.lld: error: undefined symbol: drm_client_setup_with_fourcc
   >>> referenced by arcpgu.c:399 (drivers/gpu/drm/tiny/arcpgu.c:399)
   >>>               drivers/gpu/drm/tiny/arcpgu.o:(arcpgu_probe) in archive vmlinux.a
   >>> referenced by arcpgu.c:399 (drivers/gpu/drm/tiny/arcpgu.c:399)
   >>>               drivers/gpu/drm/tiny/arcpgu.o:(arcpgu_probe) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

