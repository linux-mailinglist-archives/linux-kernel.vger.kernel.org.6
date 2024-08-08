Return-Path: <linux-kernel+bounces-279507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8664B94BE31
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70E01C24F49
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5618CC01;
	Thu,  8 Aug 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7jDBb0G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14D18B462;
	Thu,  8 Aug 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122492; cv=none; b=ou706FB4/Bbu5a2e/KwsQu2y6AP6lEHPR+WTXJsbpcHDCaCRVWqtZ3t9f4U9WWqB05dPGfIe8DOgL0gR7PKB9s476ql5VU+0xklzsDuO1SCWdiic5eR8TlNHqFh5uaU68MDlZzi3czftb3wd5tXSBySybjVLjglWSczFiBYh8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122492; c=relaxed/simple;
	bh=5K2F4rsZYfk3sYfK5CndNYcC/zss3mQ4xvZ/Gur/9EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/Cf/pYyWda3LLzWCGVh5wavzxrxkSyVwlXcQAyy2i3e11LiyK4m8lGgRSy1sgW2/OzCvV1uBM453/ktb3tghpgiAgV9+C89Hz0OS1GGnwR+SPyeaLIfOZDDXkPsW/6uO3gPF5AQbKoj6v/VceBsqP3B1281x45bUr0KQiirxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7jDBb0G; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723122491; x=1754658491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5K2F4rsZYfk3sYfK5CndNYcC/zss3mQ4xvZ/Gur/9EE=;
  b=e7jDBb0G/AjOoHWDKt73PFh78cXhN2+SmyjwnTstd7f9QzbiUmWTKIEL
   XM048FxEJpnWvgHglsiL1yAk9zATb+JQ2e3G9wGeemaYbjzuibtgWDN7B
   jtFve0DdxiPjjFINt2Yr6Gdkn5kt4YaPZ5wxLqEk4plluvvaR8uEze8jl
   R35ldQBQyloofDYm0CdTJGc/eEtZys9RX78Vh7lFvaWl22I8uscVm+bWT
   R6zSDPuXVqr7VdiCOxJjSlIxjwQeZG6ZfmJCK9UZuTNx0m7qOwBWwb0Jv
   G6JhVnqLlaqDYJL1ZOgbsgDe0XCjRyHtwoXJvGhGv1LZhnEETYebO8KXI
   Q==;
X-CSE-ConnectionGUID: IJ/TDQvSR8eJth3wMqyF6Q==
X-CSE-MsgGUID: 7Ho2MKmJTEud+/fuwVfk/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21387378"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21387378"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 06:08:09 -0700
X-CSE-ConnectionGUID: 921N21g3Qb+uU0QMl5ztPg==
X-CSE-MsgGUID: nyDTDXpWRXeoeiBgufgoPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57921909"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 08 Aug 2024 06:08:06 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sc2ry-0006C4-12;
	Thu, 08 Aug 2024 13:07:55 +0000
Date: Thu, 8 Aug 2024 21:06:39 +0800
From: kernel test robot <lkp@intel.com>
To: Marco Felsch <m.felsch@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Kaehlcke <mka@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH 1/3] usb: hub: add infrastructure to pass onboard_dev
 port features
Message-ID: <202408082050.BjhmZIt6-lkp@intel.com>
References: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9@pengutronix.de>

Hi Marco,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0c3836482481200ead7b416ca80c68a29cfdaabd]

url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Felsch/usb-hub-add-infrastructure-to-pass-onboard_dev-port-features/20240807-224100
base:   0c3836482481200ead7b416ca80c68a29cfdaabd
patch link:    https://lore.kernel.org/r/20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9%40pengutronix.de
patch subject: [PATCH 1/3] usb: hub: add infrastructure to pass onboard_dev port features
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240808/202408082050.BjhmZIt6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408082050.BjhmZIt6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408082050.BjhmZIt6-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/usb/core/hub.o: in function `set_port_feature':
>> drivers/usb/core/hub.c:481:(.text+0x121c): undefined reference to `onboard_dev_port_feature'
   aarch64-linux-ld: drivers/usb/core/hub.o: in function `usb_clear_port_feature':
   drivers/usb/core/hub.c:462:(.text+0x23b0): undefined reference to `onboard_dev_port_feature'


vim +481 drivers/usb/core/hub.c

   466	
   467	/*
   468	 * USB 2.0 spec Section 11.24.2.13
   469	 */
   470	static int set_port_feature(struct usb_device *hdev, int port1, int feature)
   471	{
   472		int ret;
   473	
   474		ret = usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
   475			USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port1,
   476			NULL, 0, 1000);
   477		if (ret)
   478			return ret;
   479	
   480		if (!is_root_hub(hdev))
 > 481			ret = onboard_dev_port_feature(hdev, true, feature, port1);
   482	
   483		return ret;
   484	}
   485	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

