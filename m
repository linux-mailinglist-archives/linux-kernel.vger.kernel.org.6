Return-Path: <linux-kernel+bounces-516072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E53A36CA0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBDF3B1A19
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3F519CC39;
	Sat, 15 Feb 2025 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbqHMkGE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CCD18CC1C;
	Sat, 15 Feb 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739608343; cv=none; b=QLRO+/w+ndIoYfF6WUcxKX5MtYngBBfNmOBPdvAWCOKdPhzRSRkKC+FzIx+hg/1BZ+C9tLw/6NnFoWXpx4S5wmF8CwRm0yyjPtvHIVgw45DXgAr0vx1r+RKs4l9VmyeVJBE0nqKlCrJltCG3zNinGz/Zw4q1GpoJoQzourQliuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739608343; c=relaxed/simple;
	bh=yfOx8DKj++Lm3z+ojZHZk7o9JJyUNNAgBOSSNe18ydY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/ENb3UKkXy590jM/uQK4ft8zLjN0H8Asqt4fT/JJn1sZrNGT/O2NjejjpEp+r30Wr0B5OGTtWDjqCpqTNwLOHbUo8EWsp9RyUs+U8iAHqYEH2d803JfdqFyCqHaHb3IAPiOxl6nnEaiihSFBiWHiroay4q7eOqpWp+U752cnpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbqHMkGE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739608342; x=1771144342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yfOx8DKj++Lm3z+ojZHZk7o9JJyUNNAgBOSSNe18ydY=;
  b=mbqHMkGEiBBKygpVZl9T0IMhUrr2qZlJAAzsl1QxKzmUYDR3efM9yKbx
   flIvPTrZSpxS34xiI82SapQFQbwxDS/4FgGWvaEAB6EbBlFN9qx+U87n/
   arUhhQ61ZsBZ7sbJCBKUfb2GH3FWXFbhBen2bLe7UZ6YU3h8GwVeeVmsS
   FnYKHrRQ+5s9EbNQlLuzP7TS5HI10i/9s5wIHOHdQRrJ+MULjJuH8mITq
   fIJPsu2LZIjaY99LipzEj2+lWdUfMIimbMpcWRhz4112j0GxbPBiJwI5y
   SBzQzA8MWhsY3fV9HC/Q4uau2ZNp4zdAabKi5b5V37b9P7mDUOnhTUSc2
   A==;
X-CSE-ConnectionGUID: FQFDspj/S2a7e452mdTwcA==
X-CSE-MsgGUID: p53YaVJtS2axldBCfDPlQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40499684"
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="40499684"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 00:32:21 -0800
X-CSE-ConnectionGUID: pMCwmK60RauH2BLX2OxMog==
X-CSE-MsgGUID: BenTPVhfT9u9wJMP2iag2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="113524585"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Feb 2025 00:32:17 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjDax-001AdT-12;
	Sat, 15 Feb 2025 08:32:15 +0000
Date: Sat, 15 Feb 2025 16:31:16 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm: bridge: Add support for Solomon SSD2825
 RGB/DSI bridge
Message-ID: <202502151636.fgFKMZoI-lkp@intel.com>
References: <20250213135605.157650-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135605.157650-3-clamor95@gmail.com>

Hi Svyatoslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master drm-misc/drm-misc-next v6.14-rc2 next-20250214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-display-bridge-Document-Solomon-SSD2825/20250213-215821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250213135605.157650-3-clamor95%40gmail.com
patch subject: [PATCH v1 2/2] drm: bridge: Add support for Solomon SSD2825 RGB/DSI bridge
config: openrisc-randconfig-r063-20250215 (https://download.01.org/0day-ci/archive/20250215/202502151636.fgFKMZoI-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502151636.fgFKMZoI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502151636.fgFKMZoI-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/asn1_decoder.o
>> ERROR: modpost: "__spi_register_driver" [drivers/gpu/drm/bridge/ssd2825.ko] undefined!
>> ERROR: modpost: "spi_setup" [drivers/gpu/drm/bridge/ssd2825.ko] undefined!
>> ERROR: modpost: "spi_sync" [drivers/gpu/drm/bridge/ssd2825.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

