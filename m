Return-Path: <linux-kernel+bounces-559194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B4EA5F0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905AA188C06C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3924EF69;
	Thu, 13 Mar 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNMS/hVR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF02265CAF;
	Thu, 13 Mar 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861435; cv=none; b=GuLnO8kFWnFzM0fiYfyh5idbATBykKk+WGeifoSqtslSKtS3lX4PkvqyyNmkSzGbvqqO28PMePlpbBb/vZNr21SP+1y6oGAiyElWmoMsEq5ljEO13NwEk71QMzF/AKQIfA65AfKplFRnrtNNyB24/3OWaupRMpkhdK+7ARnTFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861435; c=relaxed/simple;
	bh=ZQtNwbAkNNsl8udTvZE9qtF99bHC259EAPIcckU+49I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3yHPp6JpJJV++En8UKq5M4X6Rs4j2jTAyWh8WKk7aEJSxzrsUep5p4sLDHpEXTSSk55ndreY/VbIfFSw0gvX9d6H8V/LNGS65LX0Ljl+URksclju1jb+ZRclVjTJFG3+mneQaXBjNImrQEaQthyAW5e4lnu2ayGe1mqp4Mzuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNMS/hVR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741861435; x=1773397435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQtNwbAkNNsl8udTvZE9qtF99bHC259EAPIcckU+49I=;
  b=dNMS/hVRO6M5bujSSzN8Q8gxnBy/s63jQw5X4OtPMR4ipqRhM+4+0LiS
   YWEvzN0KWu3PzEaXFqc1Qv7fzXEC29LOJn4k0V3q68XGjczGUIj/mJW4f
   HvdREq50oCohTAZdVWUNTYlhIKF9Mn90k8msN3rZvR1eJW3FfZYNtxRaW
   DgFDKl51iXQeyxEd0rbLIHGyh2jczy1/dOoEw2+gMR7M2wh4Uwreg5kxb
   MSPQRG2mwOA6K/T3juxO9mYED1rUeR+YmtEhbDLA6og7ZSqRuaFCq9ATz
   Budb2XC5aAQLtv6RAu1XkyiYAl+Bfl+vIlhHiHM6AqM8hCelrOhxWSMRL
   A==;
X-CSE-ConnectionGUID: VXQIVsXfRdCqUjvXhsa1CA==
X-CSE-MsgGUID: Fk7+yJtMTL2oOoAOA4MAFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42876732"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42876732"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 03:23:54 -0700
X-CSE-ConnectionGUID: b9SeeQFFQzK2+zUVwwtadg==
X-CSE-MsgGUID: AdmzUk5XSoCTpleSuNLcew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="151865467"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 13 Mar 2025 03:23:51 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsfjA-0009Jk-1k;
	Thu, 13 Mar 2025 10:23:48 +0000
Date: Thu, 13 Mar 2025 18:23:12 +0800
From: kernel test robot <lkp@intel.com>
To: Kurt Borja <kuurtb@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, Kurt Borja <kuurtb@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 08/12] platform/x86: alienware-wmi-wmax: Add support
 for manual fan control
Message-ID: <202503131819.lgRZtPus-lkp@intel.com>
References: <20250312-hwm-v5-8-deb15ff8f3c6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-hwm-v5-8-deb15ff8f3c6@gmail.com>

Hi Kurt,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f895f2493098b862f1ada0568aba278e49bf05b4]

url:    https://github.com/intel-lab-lkp/linux/commits/Kurt-Borja/platform-x86-alienware-wmi-wmax-Rename-thermal-related-symbols/20250312-131534
base:   f895f2493098b862f1ada0568aba278e49bf05b4
patch link:    https://lore.kernel.org/r/20250312-hwm-v5-8-deb15ff8f3c6%40gmail.com
patch subject: [PATCH v5 08/12] platform/x86: alienware-wmi-wmax: Add support for manual fan control
config: x86_64-randconfig-122-20250313 (https://download.01.org/0day-ci/archive/20250313/202503131819.lgRZtPus-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503131819.lgRZtPus-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503131819.lgRZtPus-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/dell/alienware-wmi-wmax.c:1359:1: sparse: sparse: symbol 'wmax_wmi_pm_ops' was not declared. Should it be static?

vim +/wmax_wmi_pm_ops +1359 drivers/platform/x86/dell/alienware-wmi-wmax.c

  1358	
> 1359	DEFINE_SIMPLE_DEV_PM_OPS(wmax_wmi_pm_ops, wmax_wmi_suspend, wmax_wmi_resume);
  1360	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

