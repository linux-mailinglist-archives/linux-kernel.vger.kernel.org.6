Return-Path: <linux-kernel+bounces-282059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F5694DF40
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 01:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C03B1C20B5F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4525E144309;
	Sat, 10 Aug 2024 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0i3Jm4k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8C413D285;
	Sat, 10 Aug 2024 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723334052; cv=none; b=PKKNbNiCg9XByOhPTn1Qz44guYBGyeuTUpz7p4mEnEj4qXe3A2G8XgB4ecTOEOaoLlCce4lB4pAgi/GxVVDrx9tHy/d6ILKzvAL+39Wuz9Zp/inY826jjdHTkMFskxsThB51n7ou499EKepd9ZlRYCWgDiUXd1ITyO/m1dyA7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723334052; c=relaxed/simple;
	bh=jELHr4OfQX75YNJR6rcQVmwfUsLpvDrUG7RynsU1oys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7PzPrxiCSQ4WvXhlG/ApfD5Ea2EPahTesnhh1TqZvpBiP4aZbN71Eh2bGlDCasIaJnIprCGg04QlmqeKe7jwmfSBr77Ya6g8fYbImR8ZhuM1cS05zfBjMeE9+uw3gXufBiE8CGyet3Mxuu+G25e4xFHdc+upiif/XjLaZvHtAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0i3Jm4k; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723334051; x=1754870051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jELHr4OfQX75YNJR6rcQVmwfUsLpvDrUG7RynsU1oys=;
  b=g0i3Jm4korPxmB/boX1M0VkdXUagtAfsYr0BPy6Iu85CYAB5wH+VcQtI
   syANQrMw0FAun/yhUKYoqZz9zBKs/fI8DZJQQugGzGQSAYb0sPO6Uyg3+
   jK7GVeWWDrexHILIBCfxnEcdyKeykAi0nxDm/MB+XVGgtbTnC7d04QCT3
   ZOvP+Xim+9xHianOZxZ5n59nPy+oxJbnzFFf5A+MNice2U0EAoPCaLp95
   l4VxNxSuFbl7AqQUfEcZg3Rh+tbXtlnOyiVkimGlfIRLr+HwnL9oRRQVD
   z8lguE6us5+snx3KJQNJpIo9PqOXQqNMrDmbDwG1DnDI5kgGoUBhvxujL
   w==;
X-CSE-ConnectionGUID: HzQKKNy5Rnilm/Fb5GQSAw==
X-CSE-MsgGUID: EDXbe70DSvWgOEjl6TQvPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="25341572"
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="25341572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 16:54:10 -0700
X-CSE-ConnectionGUID: G3SzeE3bQJKREYtogpp9JA==
X-CSE-MsgGUID: 80sDJ7y7RxqrcWtRJ7Bj1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="62566866"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 10 Aug 2024 16:54:09 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scvuQ-000AOn-2W;
	Sat, 10 Aug 2024 23:54:06 +0000
Date: Sun, 11 Aug 2024 07:53:45 +0800
From: kernel test robot <lkp@intel.com>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev, Maximilian Luz <luzmaximilian@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (surface_fan) Change dependency on
 SURFACE_AGGREGATOR_BUS to 'select'
Message-ID: <202408110753.1wxzPUwV-lkp@intel.com>
References: <20240810214709.425095-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810214709.425095-1-luzmaximilian@gmail.com>

Hi Maximilian,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.11-rc2 next-20240809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maximilian-Luz/hwmon-surface_fan-Change-dependency-on-SURFACE_AGGREGATOR_BUS-to-select/20240811-054808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240810214709.425095-1-luzmaximilian%40gmail.com
patch subject: [PATCH] hwmon: (surface_fan) Change dependency on SURFACE_AGGREGATOR_BUS to 'select'
config: x86_64-rhel-8.3-rust (attached as .config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240811/202408110753.1wxzPUwV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408110753.1wxzPUwV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: recursive dependency detected!
   symbol GPIOLIB is selected by I2C_MUX_LTC4306
   symbol I2C_MUX_LTC4306 depends on I2C_MUX
   symbol I2C_MUX is selected by MPU3050_I2C
   symbol MPU3050_I2C depends on IIO
   symbol IIO is implied by HID_MCP2221
   symbol HID_MCP2221 depends on HID
   symbol HID is selected by SURFACE_HID_CORE
   symbol SURFACE_HID_CORE is selected by SURFACE_HID
   symbol SURFACE_HID depends on SURFACE_AGGREGATOR_REGISTRY
   symbol SURFACE_AGGREGATOR_REGISTRY depends on SURFACE_AGGREGATOR_BUS
   symbol SURFACE_AGGREGATOR_BUS is selected by SENSORS_SURFACE_FAN
   symbol SENSORS_SURFACE_FAN depends on HWMON
   symbol HWMON is selected by EEEPC_LAPTOP
   symbol EEEPC_LAPTOP depends on ACPI_VIDEO
   symbol ACPI_VIDEO depends on BACKLIGHT_CLASS_DEVICE
   symbol BACKLIGHT_CLASS_DEVICE is selected by FB_BACKLIGHT
   symbol FB_BACKLIGHT is selected by FB_SSD1307
   symbol FB_SSD1307 depends on GPIOLIB
   For a resolution refer to Documentation/kbuild/kconfig-language.rst
   subsection "Kconfig recursive dependency limitations"

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

