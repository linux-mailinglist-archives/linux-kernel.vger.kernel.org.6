Return-Path: <linux-kernel+bounces-561303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBE2A60FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BFF1B636BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9411FCFF2;
	Fri, 14 Mar 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RymfN2vu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D51F5420;
	Fri, 14 Mar 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951594; cv=none; b=W2UEa4lK0slQMfX5Zxk3pqFJreZLFJib0nPq1HQUyjK4moGvhKfe1w3dYcdqaYScLOPttuyoUMgnffLrdaWHFVRs3+U41d3hPEiVYTqN0r9rBS/nwDjWt+GNLUpCRwV5Z4LqA0FF7pcnUvf5ZNvLV1/NL10J/G/v/IqmpYtwlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951594; c=relaxed/simple;
	bh=jy65FiPTJOdJJVXh5B7913Du6P29GcNh3wf++fmmB5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N384TlrKGF5Ng3QoL4HacIkaX8FHxKn2Dj8FLX4ILvUmsbo1Ocsau2B0Lo2fz/B7qxxDV/+x9V4Qdg09Afmwm2k8C607B+eb1HLyqXNnMFI6zgbBl1bMCjam8LmiK6ViNQu859xZ5DgVb3gD5ie1EQsH95aA1ZZ0RUeA+2EMYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RymfN2vu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741951592; x=1773487592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jy65FiPTJOdJJVXh5B7913Du6P29GcNh3wf++fmmB5E=;
  b=RymfN2vuaj2v0xrLZ6ykWe41ysGV7FODFMetSN075XXlDaR5/LeXbp6K
   CohcjFIB9vcOfGk6q1u1rLU157xBVv52ND3p0NA5FWxtRAwXP1fU7aZms
   lWfHixIq/0Hnzkr3W8bw2qH3QypTG9ArBmhH0N4DTH6DBnTnOAaGi2Yt1
   es7Ja1108hn/QrDiBQepidNeAs2k9kHA/nndyBmb2+4CBBGQRYVEiOXCx
   6agMvmJXD1OuH8LfgqULNIwoFEKZOHcDcy2IV3RxEqP8Gq/+6LmqDu0vg
   r96wZeodun6Pqss9YbLU1oCP4RwKyc5y1NGZnFJa90hsgVv2X6iFS3Pyy
   g==;
X-CSE-ConnectionGUID: 3VP5ji0VQxqRy9E9tMUdGA==
X-CSE-MsgGUID: cj101le2SiGT9cXktGhR8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42964518"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42964518"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:26:31 -0700
X-CSE-ConnectionGUID: 8TH9kjZeTO21QaxlKXpkxQ==
X-CSE-MsgGUID: VxkCBXuTTy6ibvK7RjHfdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126120517"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 14 Mar 2025 04:26:29 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt3BH-000ANc-0x;
	Fri, 14 Mar 2025 11:26:24 +0000
Date: Fri, 14 Mar 2025 19:25:43 +0800
From: kernel test robot <lkp@intel.com>
To: Sung-Chi Li <lschyi@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, chrome-platform@lists.linux.dev,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sung-Chi Li <lschyi@chromium.org>
Subject: Re: [PATCH 2/3] hwmon: (cros_ec) Add reading target fan RPM function
Message-ID: <202503141908.rieksBce-lkp@intel.com>
References: <20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4@chromium.org>

Hi Sung-Chi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9fbcd7b32bf7c0a5bda0f22c25df29d00a872017]

url:    https://github.com/intel-lab-lkp/linux/commits/Sung-Chi-Li/hwmon-cros_ec-Add-setting-target-fan-RPM-function/20250313-125018
base:   9fbcd7b32bf7c0a5bda0f22c25df29d00a872017
patch link:    https://lore.kernel.org/r/20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4%40chromium.org
patch subject: [PATCH 2/3] hwmon: (cros_ec) Add reading target fan RPM function
config: x86_64-randconfig-121-20250314 (https://download.01.org/0day-ci/archive/20250314/202503141908.rieksBce-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503141908.rieksBce-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141908.rieksBce-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hwmon/cros_ec_hwmon.c:48:18: sparse: sparse: cast to restricted __le32

vim +48 drivers/hwmon/cros_ec_hwmon.c

    38	
    39	static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec, u8 index, int32_t *speed)
    40	{
    41		int ret;
    42		struct ec_response_pwm_get_fan_rpm r;
    43	
    44		ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM, NULL, 0, &r, sizeof(r));
    45		if (ret < 0)
    46			return ret;
    47	
  > 48		*speed = le32_to_cpu(r.rpm);
    49		return 0;
    50	}
    51	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

