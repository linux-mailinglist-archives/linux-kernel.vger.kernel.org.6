Return-Path: <linux-kernel+bounces-513773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5C7A34E81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0465D18903A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CE324A079;
	Thu, 13 Feb 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTgtnaQA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E624A06C;
	Thu, 13 Feb 2025 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475145; cv=none; b=iKfrbAgQeVu/7HuaG5ioCxAiK49kOXHsAHChVcaC4vk3CWc8Ftx/TRHNkHO4bz05HLsgiCCOQbDCJHjUUo9cbkzh7U7s3OWpV09vHUaYFYxIsqG0YJP2e2EDxTSfsuQJw0vQS3MeHYB5XknO522gJVPbs5JsdP2X52gt7ry3Pxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475145; c=relaxed/simple;
	bh=Qj+F86dsqXkmAV7Wp0h+E2C2QouUJZ9pZ8c3ZCoW/Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIyOUiDUVEVs4m+AzdJHioPFjFZ8YypYWnw0dWXRyPsvSULWMY9DgRED0qhxudUAhTlK83ZNFiyKY/GUY0VwkFAtCXTor8iyb8kJ/EhC6SJPDdzg3l3dOMfM2O4b+3SnKk6gtuvDlE/mseCHhu0Xdpfg7oGKlX5E7tYUnA6wmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTgtnaQA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739475142; x=1771011142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qj+F86dsqXkmAV7Wp0h+E2C2QouUJZ9pZ8c3ZCoW/Lo=;
  b=fTgtnaQA3wW5KwrQFWZ+3YlPgSqWMp6bYRVq87avJOoTMHTIz+iPzHr4
   N8i+h5/osJD/TFTJ7b7nL5lecznn1z1S1M0HpYY+zeq7fcsG7WfMDFjJt
   wldDuDLmOGTkyI9XYLD9d6UPNQtWDiBF2ptIUgKQlE3W7UDiomoGbsbQ+
   9PqMWC8UkHAUE3gC5uNUbRIhGQBXyFsulPGcC00TUbGObvrdlQ4Mk5p5V
   W3JVByypqAlZxzgXNV3If6FHUvF7cg+N/Khxyr6TbmHJXsxNeny3K9KzJ
   P9a9OnQNFQrwpDiylDfEyuXsf6pz3jck9JrBc9LC1OPcHLNTsjBj2+HoD
   A==;
X-CSE-ConnectionGUID: 3XIx1N+iSGCK0vwpOgtZHw==
X-CSE-MsgGUID: 5pAEXOnvTOWFzoUt9Gkl+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44132343"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44132343"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 11:32:22 -0800
X-CSE-ConnectionGUID: Cm3tK4RqQkm+dkgYGdCBBw==
X-CSE-MsgGUID: U7H7sMZsTgey4v5itG7VNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113194614"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Feb 2025 11:32:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiewa-0018d9-0v;
	Thu, 13 Feb 2025 19:32:16 +0000
Date: Fri, 14 Feb 2025 03:32:05 +0800
From: kernel test robot <lkp@intel.com>
To: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Cryolitia PukNgae <Cryolitia@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	Marcin =?utf-8?Q?Str=C4=85gowski?= <marcin@stragowski.com>,
	someone5678 <someone5678.dev@gmail.com>,
	Justin Weiss <justin@justinweiss.com>
Subject: Re: [PATCH v5 1/2] hwmon: add GPD devices sensor driver
Message-ID: <202502140302.IkW9UALU-lkp@intel.com>
References: <20250211-gpd_fan-v5-1-608f4255f0e1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-gpd_fan-v5-1-608f4255f0e1@gmail.com>

Hi Cryolitia,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ffd294d346d185b70e28b1a28abe367bbfe53c04]

url:    https://github.com/intel-lab-lkp/linux/commits/Cryolitia-PukNgae-via-B4-Relay/hwmon-add-GPD-devices-sensor-driver/20250211-150418
base:   ffd294d346d185b70e28b1a28abe367bbfe53c04
patch link:    https://lore.kernel.org/r/20250211-gpd_fan-v5-1-608f4255f0e1%40gmail.com
patch subject: [PATCH v5 1/2] hwmon: add GPD devices sensor driver
config: i386-randconfig-002-20250214 (https://download.01.org/0day-ci/archive/20250214/202502140302.IkW9UALU-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502140302.IkW9UALU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502140302.IkW9UALU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/gpd-fan.c:361:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     361 |                 const struct gpd_board_drvdata *drvdata = gpd_driver_priv.drvdata;
         |                 ^
   drivers/hwmon/gpd-fan.c:452:4: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     452 |                         int ret = gpd_read_pwm();
         |                         ^
   drivers/hwmon/gpd-fan.c:478:4: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     478 |                         u8 var = clamp_val(val, 0, 255);
         |                         ^
   3 warnings generated.


vim +361 drivers/hwmon/gpd-fan.c

   352	
   353	static int gpd_win_mini_set_pwm_enable(enum FAN_PWM_ENABLE pwm_enable)
   354	{
   355		switch (pwm_enable) {
   356		case DISABLE:
   357			return gpd_generic_write_pwm(255);
   358		case MANUAL:
   359			return gpd_generic_write_pwm(gpd_driver_priv.pwm_value);
   360		case AUTOMATIC:
 > 361			const struct gpd_board_drvdata *drvdata = gpd_driver_priv.drvdata;
   362	
   363			return gpd_ecram_write(drvdata, drvdata->pwm_write, 0);
   364		}
   365		return 0;
   366	}
   367	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

