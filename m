Return-Path: <linux-kernel+bounces-178062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1AF8C4811
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C1B2842CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020247E118;
	Mon, 13 May 2024 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvsk0Kjm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157BF7BB12;
	Mon, 13 May 2024 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631000; cv=none; b=amxF9NssC5fes0uw7EV4NCf52wxQBtEQc0UuqEZpn6eZ49uZAc+/J0vXjCMQo3NZCzr9X4imT9x5KurfY3NcL82981Ovrl6ubmIbUXkVbhVgTq0cWix8SyOc1o8JvAngZKtd6bQiLObb298vxl/fLFoLw7ItIjcXWh1pLvvV8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631000; c=relaxed/simple;
	bh=5srbF7A/r6ZZVZ38QlSzulTr02juUo3FmLj9M76HhZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtG0ZAV0P/qVZqLEJSQ6Mp9YjzBF31cu5X/KoqTebatRaW6KV/Fhh4Z9i/jnEhYRUngsxlqZ+HxggerQBS8XiF+kmu4GfdMjN8Mh09RtBow11xmZ80AE78wma612pedfUtYR4w0X65XuGprVXGYTmBxE7dF9V5RzwVopgfuPjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvsk0Kjm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715630998; x=1747166998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5srbF7A/r6ZZVZ38QlSzulTr02juUo3FmLj9M76HhZ8=;
  b=mvsk0KjmLA8fgXx5JvqX52VVbAuMSkhC4k+84nOO6Va+L8AzycnryfsV
   VnooiIrWjAX9YJtNNs8RvYVbTVWT1h+xOScc2eQU/zT+tB2n2CpfVcZ81
   Uun7kxF1wmCghtYEo6kfg7owRc7fMjx4qvcy/4Kp1xKp3sQBqHRg+YWx5
   7AgX1ypzbhQT7fKPOI2CkWROo1tJWPrfYIsG6MFRBQg6l588V88vGh+ba
   NC/E7hBY1tVE/CDet+KCYvHfeWtfiYMHiJ8Q1XteUsfcvT9JmNsSM9Nc4
   QxdevDI53P+srAe+TD0xCET/RT9jzgrTRRsKLaSJX2lGVhuk5WDUBPuvF
   Q==;
X-CSE-ConnectionGUID: C0MNPuq6SYe3yJkh8RICxQ==
X-CSE-MsgGUID: GN7ao2MNQ32Jzhip8+N35A==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="14530865"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="14530865"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 13:09:57 -0700
X-CSE-ConnectionGUID: +aadTLrMRYyEcp7OimqdlQ==
X-CSE-MsgGUID: zFsui8dvRbKCxU0Ftvz+/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="61266228"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 May 2024 13:09:55 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6bzb-000Afp-1j;
	Mon, 13 May 2024 20:09:51 +0000
Date: Tue, 14 May 2024 04:09:04 +0800
From: kernel test robot <lkp@intel.com>
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: oe-kbuild-all@lists.linux.dev, mario.limonciello@amd.com,
	pali@kernel.org, W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2] platform/x86: dell-laptop: Implement platform_profile
Message-ID: <202405140348.Wz7gOmdP-lkp@intel.com>
References: <20240426020448.10862-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426020448.10862-1-lsanche@lyndeno.ca>

Hi Lyndon,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.9 next-20240513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lyndon-Sanche/platform-x86-dell-laptop-Implement-platform_profile/20240511-144534
base:   linus/master
patch link:    https://lore.kernel.org/r/20240426020448.10862-1-lsanche%40lyndeno.ca
patch subject: [PATCH v2] platform/x86: dell-laptop: Implement platform_profile
config: i386-randconfig-005-20240513 (https://download.01.org/0day-ci/archive/20240514/202405140348.Wz7gOmdP-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240514/202405140348.Wz7gOmdP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405140348.Wz7gOmdP-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/platform/x86/dell/dell-laptop.o: in function `thermal_init':
>> drivers/platform/x86/dell/dell-laptop.c:2404:(.text+0x21a3): undefined reference to `platform_profile_register'
   ld: drivers/platform/x86/dell/dell-laptop.o: in function `thermal_cleanup':
>> drivers/platform/x86/dell/dell-laptop.c:2412:(.text+0x21cc): undefined reference to `platform_profile_remove'
>> ld: drivers/platform/x86/dell/dell-laptop.c:2412:(.init.text+0xb44): undefined reference to `platform_profile_remove'
>> ld: drivers/platform/x86/dell/dell-laptop.c:2412:(.exit.text+0x7c): undefined reference to `platform_profile_remove'


vim +2404 drivers/platform/x86/dell/dell-laptop.c

  2377	
  2378	int thermal_init(void)
  2379	{
  2380		int ret;
  2381		int supported_modes;
  2382	
  2383		ret = thermal_get_supported_modes(&supported_modes);
  2384	
  2385		if (ret || !supported_modes)
  2386			return 0;
  2387	
  2388		thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
  2389		if (!thermal_handler)
  2390			return -ENOMEM;
  2391		thermal_handler->profile_get = thermal_platform_profile_get;
  2392		thermal_handler->profile_set = thermal_platform_profile_set;
  2393	
  2394		if ((supported_modes >> DELL_QUIET) & 1)
  2395			set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
  2396		if ((supported_modes >> DELL_COOL_BOTTOM) & 1)
  2397			set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
  2398		if ((supported_modes >> DELL_BALANCED) & 1)
  2399			set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
  2400		if ((supported_modes >> DELL_PERFORMANCE) & 1)
  2401			set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
  2402	
  2403		// Clean up but do not fail
> 2404		if (platform_profile_register(thermal_handler))
  2405			kfree(thermal_handler);
  2406	
  2407		return 0;
  2408	}
  2409	
  2410	void thermal_cleanup(void)
  2411	{
> 2412		platform_profile_remove();
  2413		kfree(thermal_handler);
  2414	}
  2415	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

