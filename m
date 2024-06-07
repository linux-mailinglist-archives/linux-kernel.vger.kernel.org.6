Return-Path: <linux-kernel+bounces-205175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB478FF862
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FC2283AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7168A48;
	Fri,  7 Jun 2024 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9kDbXm/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D987E9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717718669; cv=none; b=Tc5UrbqKlEiJ1hd1nACoiuzIJjljB7+pBhFy1iLsdPqaAKnWXvxI53fv1jqgnXsFzl6FeMQ5TyZLCWZz2p217l3OEh6sjc3SBT2ksZT7FEG6hmMDBTiuPtLkB9R/ZRwd1OP3a7SBcv1q7n5lFSkdptg9SIPGb2+7wY6fBDk9dGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717718669; c=relaxed/simple;
	bh=JA6gdh/hNRE3zKNvg6yoafcgSwlrlnfT5BoV548nCU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4dGBVFpIVIiFDRrj/a21pQeDAXbBHWlY883vKH9fSKwXZ2thwI3uQPQNL3efBzal23Mu2jqHlY9a5+a1G0Upw0/KjkD9jfKdkNTd82km0oPADzUiubjROq8O0akSADuzQt3ksNc1WyW+jd4zV/5mW/v0P4WKQC6DOR96clJRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9kDbXm/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717718667; x=1749254667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JA6gdh/hNRE3zKNvg6yoafcgSwlrlnfT5BoV548nCU4=;
  b=h9kDbXm/5KUX66uAhMeK2mox1Q9wT0/K0uxSJvskqkZEYNBvspuxrQsv
   MiA4VoGjpiLq2jcvF+dpDc0Gqsx26VvzRqGdusZ2NIWbYD3By42WBu90B
   rzD/tOnZGlhZltCFGIBBXTsAF+OtA3T/2TELd1uFplf86uk3jhmt962JJ
   a24VC0/AtJxAf5pmdiUQVusMfacNJwS7y0VOt9bbMAe/P5vetg0p53sCy
   jY2G+XY5GOFc06VwGDuK7qcZKwgEFO24RZoxgfhv+azCiYZUnjGvLKr4C
   AVTX4KwzYOVI9HlhkPFRO31IEAlhNaphB9A6DSaq1QIIxpk551fiML/4T
   A==;
X-CSE-ConnectionGUID: xc0MGSk/STyTvXydBXk72Q==
X-CSE-MsgGUID: vFEkd+kBS6aOBMk1JzuVZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25821326"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25821326"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 17:04:27 -0700
X-CSE-ConnectionGUID: 7YV07cZfSZiMWaVUBdm8TA==
X-CSE-MsgGUID: DXEAU8EkTI6bg8RE+27vNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42718117"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 06 Jun 2024 17:04:23 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFN5h-0003tV-1L;
	Fri, 07 Jun 2024 00:04:21 +0000
Date: Fri, 7 Jun 2024 08:03:51 +0800
From: kernel test robot <lkp@intel.com>
To: Soumya Khasnis <soumya.khasnis@sony.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, srinavasa.nagaraju@sony.com
Cc: oe-kbuild-all@lists.linux.dev, Madhusudan.Bobbili@sony.com,
	shingo.takeuchi@sony.com, keita.aihara@sony.com,
	masaya.takahashi@sony.com
Subject: Re: [PATCH v3] driver core: Add timeout for device shutdown
Message-ID: <202406070712.OeIvg472-lkp@intel.com>
References: <20240606085003.GA118950@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085003.GA118950@sony.com>

Hi Soumya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.10-rc2 next-20240606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Soumya-Khasnis/driver-core-Add-timeout-for-device-shutdown/20240606-165454
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20240606085003.GA118950%40sony.com
patch subject: [PATCH v3] driver core: Add timeout for device shutdown
config: x86_64-randconfig-121-20240607 (https://download.01.org/0day-ci/archive/20240607/202406070712.OeIvg472-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070712.OeIvg472-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070712.OeIvg472-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/base/core.c:42:32: sparse: sparse: symbol 'devs_shutdown' was not declared. Should it be static?
   drivers/base/core.c: note: in included file (through include/linux/resource_ext.h, include/linux/acpi.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +/devs_shutdown +42 drivers/base/core.c

    40	
    41	#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
  > 42	struct device_shutdown_timeout devs_shutdown;
    43	#endif
    44	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

