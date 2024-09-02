Return-Path: <linux-kernel+bounces-311061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D87996846E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA672809DC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39E13CFB7;
	Mon,  2 Sep 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhR9r9xK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C461FEB;
	Mon,  2 Sep 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272295; cv=none; b=HLtDix99Cy/b3uCFtyj1cByZOW0dQrruGvd1SVKrzoHgbN2T1Al/XkxSME+WN4Wmek8yo8OIKeXPEY55MnSgAqiHdY9IttIGyZKz996zqClQ7YZRqSrBru3XSLTLua7a78xt+NB0W6nCgv5xyvzRNW5FErbmi0vsYeEjUc7Pcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272295; c=relaxed/simple;
	bh=GaMmyKHdZWZAQw653fQ+MGXw3Ni90psnatbML82zq10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwFOzz5n9hAq1QDSoSiwE9TlAHCV2EWiqEjYnElUjTzJEdNDon6hzR29hX+4BzSpSGisCmC7mtvOMk+Ra8p4hb5CElflbyH6Igu3ISbh6Ma54S2KFOllmuOSn8Oq9vJdNRISq7BMkS+OJMYDWsQ4vIhU9rxbt7FDoXnSbYXrOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhR9r9xK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725272292; x=1756808292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GaMmyKHdZWZAQw653fQ+MGXw3Ni90psnatbML82zq10=;
  b=MhR9r9xKu3eUC2D+IE6qG1tJn90TujtwLGvv55eqxmdUx+40rIz/zXud
   PfhATDz2/JgHIdpVL8i6mivDgmXbbr+EzuRwC8J7axOM3KcoyvnWsFrhr
   mlYsIPLTYSG+T5xi+UYB4cAz9pT83KA7svl37YHbVDnU5uxc71VaDJykf
   WDtCeTEZNev/McvSbYsOAUl/JEQT4gtFlIhh3Hs469nts54Iwt+89icrs
   cg1gkbnyNfVMtIkFzHsr0z3G4A6PVDcEizX6CnlbM4nforG0+9DtdZXxf
   OAvZmdIprNaBiFZObF1Pav4K2/0QV2oQNCdYbKbQLdcEncTsifHpQ7ZXX
   A==;
X-CSE-ConnectionGUID: arTVof5dS+qkDX1cBrbpMg==
X-CSE-MsgGUID: myL9FmOiTUG7cgBCoMTNag==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="13328524"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="13328524"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:18:11 -0700
X-CSE-ConnectionGUID: 3inN7/nQQ+y50FdryI0b5A==
X-CSE-MsgGUID: CAbety6mRYy+tohwK0HG3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="95277957"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:18:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl487-00000004Jep-1vmR;
	Mon, 02 Sep 2024 13:17:51 +0300
Date: Mon, 2 Sep 2024 13:17:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 2/4] platform/x86: int3472: Simplify dev_err_probe()
 usage
Message-ID: <ZtWQzwvo7f0QfeCI@smile.fi.intel.com>
References: <20240822130722.1261891-3-andriy.shevchenko@linux.intel.com>
 <20dd56f0-78ea-4255-86ac-32151160b83d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20dd56f0-78ea-4255-86ac-32151160b83d@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 31, 2024 at 11:31:53AM +0300, Dan Carpenter wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/driver-core-Ignore-0-in-dev_err_probe/20240826-113856
> base:   driver-core/driver-core-testing
> patch link:    https://lore.kernel.org/r/20240822130722.1261891-3-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v2 2/4] platform/x86: int3472: Simplify dev_err_probe() usage
> config: i386-randconfig-141-20240830 (https://download.01.org/0day-ci/archive/20240831/202408310807.sNPe5Mr2-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202408310807.sNPe5Mr2-lkp@intel.com/
> 
> smatch warnings:
> drivers/platform/x86/intel/int3472/discrete.c:292 skl_int3472_handle_gpio_resources() error: uninitialized symbol 'err_msg'.
> drivers/platform/x86/intel/int3472/discrete.c:292 skl_int3472_handle_gpio_resources() warn: passing zero to 'dev_err_probe'

Okay, I might agree on the err_msg, which is good to have to be passed anyway.
In such a case it might be good to have a dev_dbg() in the dev_err_probe() to
say that it is likely a bug in the code.

Would you accept that approach?

-- 
With Best Regards,
Andy Shevchenko



