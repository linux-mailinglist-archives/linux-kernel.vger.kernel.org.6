Return-Path: <linux-kernel+bounces-276801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD494988F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771F31C214EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114AD14EC51;
	Tue,  6 Aug 2024 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C02N1eZb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E17EEFD;
	Tue,  6 Aug 2024 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973327; cv=none; b=ZSgZogT/+uNBkeyRYYnbaF6zIcg9Gvxg/Yuc12ZjZbFaw3VKQcjFmsD4jeuOESfbkQP4UylanmGhnVZBJXZ/ABMoJPtzl8ecD1a8b8wY6f0scxJNr80B2WjBUL6u5yL122SyfDjs9+1kK2NKrYWhWN5TSAfzyl3v6CsTBCXjPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973327; c=relaxed/simple;
	bh=bH82Uasj8/KFRHcDXevgHCwll9X5e2GdmeCldRs0nH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNEo+enQghXKEAzzVuMYSz+MI4SD6ld0YoksnS1Zm39sZ0RDQhahx/NgedlkzpKjWgPu0oTktK46ChY8QxzGB9OwfR/7bcUW1DMSrvzESYGjfkft+l0N6xEvdiJrPoCImBy73oSy3kCz1zjvzoYnwDM4jb/RyC13us4YtJIPBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C02N1eZb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722973324; x=1754509324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bH82Uasj8/KFRHcDXevgHCwll9X5e2GdmeCldRs0nH8=;
  b=C02N1eZblN6QjxbkplCXzZkmM6lag/hVtLFrbNGu5merQM3/rIFR1h9I
   /dPfRhYZHtmSlS0kn6G4yC0A/nqSyRvC2kN3wmqQeIWHzbqeFQbjfXlow
   dM+voETOnICVMGwvmKQaj0x9zULXXPIqLMnXmzueBfvioA2oWW3o6rTQC
   viEEoJoaygSnBpH8sW2JqBHjw32tFqRnLGYkUmK0vx0IyumOMosqj2lky
   KVU4Sem1YPSq1hzLcPy69pdPJXS2Ve8WwhoG0B5jvwAhPTVFkwgBbO75j
   mxOqq1g/rgTaOu3kbNqsiku1oyum+pMIIKoP09DiCh9gLm52YAmeNAK7O
   g==;
X-CSE-ConnectionGUID: kEj/k4UZSaeVOxr0GTMRsw==
X-CSE-MsgGUID: x0ryiWWMRMyKpzRM/JVaVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="23927195"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="23927195"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 12:42:03 -0700
X-CSE-ConnectionGUID: 76EGUQ1jRQKkt2Y8SDSwOQ==
X-CSE-MsgGUID: irJGzyg2TFaOVQ4FR918Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56317458"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 06 Aug 2024 12:42:01 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbQ4F-0004mi-10;
	Tue, 06 Aug 2024 19:41:59 +0000
Date: Wed, 7 Aug 2024 03:41:50 +0800
From: kernel test robot <lkp@intel.com>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev, Maximilian Luz <luzmaximilian@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
Message-ID: <202408070251.EcevLWaJ-lkp@intel.com>
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804230832.247852-1-luzmaximilian@gmail.com>

Hi Maximilian,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.11-rc2 next-20240806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maximilian-Luz/hwmon-Add-thermal-sensor-driver-for-Surface-Aggregator-Module/20240805-071237
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240804230832.247852-1-luzmaximilian%40gmail.com
patch subject: [PATCH v2] hwmon: Add thermal sensor driver for Surface Aggregator Module
config: x86_64-randconfig-103-20240806 (https://download.01.org/0day-ci/archive/20240807/202408070251.EcevLWaJ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408070251.EcevLWaJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408070251.EcevLWaJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __ssam_device_driver_register
   >>> referenced by surface_temp.c:231 (drivers/hwmon/surface_temp.c:231)
   >>>               drivers/hwmon/surface_temp.o:(ssam_temp_init) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: ssam_device_driver_unregister
   >>> referenced by surface_temp.c:231 (drivers/hwmon/surface_temp.c:231)
   >>>               drivers/hwmon/surface_temp.o:(ssam_temp_exit) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

