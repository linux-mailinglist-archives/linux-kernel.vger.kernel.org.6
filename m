Return-Path: <linux-kernel+bounces-390986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B206F9B80DD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B9EB2147D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB51BDAAE;
	Thu, 31 Oct 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUV91E/n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC51BD034;
	Thu, 31 Oct 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394466; cv=none; b=KEaB2zDjtiVpU0Hqq1giRsnmxw17+X8ftHlxgK47Y67XhofmsmOEyC7NhncQ1J8C5VLW2OcQDgp0bNjpiOj4r9rBOHjRm42AEHpKqFacDZKnjfaB+WMp2uzLgvlGZAn6IyrWI1EQNwmR1MyFY1+FAXy0vo8PaBF9+Mpk8wugl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394466; c=relaxed/simple;
	bh=NuwRVX8byKFf/BtgzAUxRh+eHUfVzR4snXY14ZFx9cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwhAeQH/V8+O5QmwRC5/TgsPWUdtqIn1a/ApvcatSqvMxIjmVpDfmEH14tgYCJq1fi7oD5mXQeMcAGNzCzbb6mbCzpJfByzMx93bvOqb10R5Ta9nqcwG0HFPKreZflcfngX3PgEE4v+Wect1rdWckkkRbvJA8DRzDsrFDwXJfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUV91E/n; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730394464; x=1761930464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NuwRVX8byKFf/BtgzAUxRh+eHUfVzR4snXY14ZFx9cA=;
  b=fUV91E/nC6O7AyPtOcWJEvU0XrPyWaJLadlUthlk3k4mBa8RfB0St/f9
   RBJZRRJETulK2gTp1omsnZ5HL1QtNKLDGes5QgzecsBmpEwQBhjGHKzWu
   Uoa1naLWHMp9BvKAWVDYKvwLAHjFvuS+ZnSNCPGVdlPM5iDCnyXWQCEZV
   IPpocc1sNI4iQV7oQb3N1JEETrQjQI/CiFPMrC2hvNkzVLJt3HnteOS9n
   LhWb9fYyy6ICWpTfLqHGhDGa0l7T4jI3k9FZ2tYDBVt3YYmXMtixkI2Ls
   hp+W3cRuNE8jm42t12aKJyrx+gbGw7PgQxmJ1qkIIqGDfv/Ai1y18B9i5
   A==;
X-CSE-ConnectionGUID: WsGRzHCmQhWGuFeKfo5eGQ==
X-CSE-MsgGUID: EBhK1HvcScumZOhvY+B8Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30315699"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30315699"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 10:07:44 -0700
X-CSE-ConnectionGUID: ZAHTMA9MQQGK68AVz5GzkA==
X-CSE-MsgGUID: +KhB7CocR5C3rBgQFtpkHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="83493726"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 31 Oct 2024 10:07:40 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Ye1-000gYG-1E;
	Thu, 31 Oct 2024 17:07:37 +0000
Date: Fri, 1 Nov 2024 01:07:06 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	heikki.krogerus@linux.intel.com, tzungbi@kernel.org,
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, dmitry.baryshkov@linaro.org,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] platform/chrome: cros_ec_typec: Thunderbolt
 support
Message-ID: <202411010039.QHl0lhBw-lkp@intel.com>
References: <20241030142833.v2.6.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030142833.v2.6.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>

Hi Abhishek,

kernel test robot noticed the following build errors:

[auto build test ERROR on chrome-platform/for-next]
[also build test ERROR on chrome-platform/for-firmware-next usb/usb-testing usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.12-rc5 next-20241031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Pandit-Subedi/usb-typec-Add-driver-for-Thunderbolt-3-Alternate-Mode/20241031-053304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20241030142833.v2.6.Ic61ced3cdfb5d6776435356061f12307da719829%40changeid
patch subject: [PATCH v2 6/7] platform/chrome: cros_ec_typec: Thunderbolt support
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20241101/202411010039.QHl0lhBw-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411010039.QHl0lhBw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411010039.QHl0lhBw-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/platform/chrome/cros_ec_typec.c:21:
>> drivers/platform/chrome/cros_typec_altmode.h:41:1: warning: no previous prototype for 'cros_typec_register_thunderbolt' [-Wmissing-prototypes]
      41 | cros_typec_register_thunderbolt(struct cros_typec_port *port,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   aarch64-linux-ld: drivers/platform/chrome/cros_typec_altmode.o: in function `cros_typec_register_thunderbolt':
>> drivers/platform/chrome/cros_typec_altmode.h:43: multiple definition of `cros_typec_register_thunderbolt'; drivers/platform/chrome/cros_ec_typec.o:drivers/platform/chrome/cros_typec_altmode.h:43: first defined here


vim +43 drivers/platform/chrome/cros_typec_altmode.h

    34	
    35	#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
    36	struct typec_altmode *
    37	cros_typec_register_thunderbolt(struct cros_typec_port *port,
    38					struct typec_altmode_desc *desc);
    39	#else
    40	struct typec_altmode *
  > 41	cros_typec_register_thunderbolt(struct cros_typec_port *port,
    42					struct typec_altmode_desc *desc)
  > 43	{
    44		return typec_port_register_altmode(port->port, desc);
    45	}
    46	#endif
    47	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

