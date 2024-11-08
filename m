Return-Path: <linux-kernel+bounces-402447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631229C279B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A682848A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE3F1F26DF;
	Fri,  8 Nov 2024 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgqwLv0T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67A233D89;
	Fri,  8 Nov 2024 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105207; cv=none; b=IpL2O5YhPmVgV+edNnjXzw+dv9ZXFansDzn9U3M5NuBEpn4Mbn+FnuI7VjlXpWT7KMREVienv8qw4XjVNfoE4En3dGpjtlZgUMJvOgrh2csoMYhpegRXrlmaw3DN5fDm0O+4aO1Ztxb3Gf9E1gj2P/XODL0BGhlHlzAd6oRwbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105207; c=relaxed/simple;
	bh=+LF7CsJ7/io270zqeQKsXvXgBShIfl+NXbOKX6jVzM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEv8HUBiabPCysnhVbUMN67e7bDbnbTNbOkhKdn8GN6+ir0tJeYn29PAV//9YZA/ms1nM8grco2NJkT8wa2CPlaweaKypY8eqQJZlGhzTRxrvghJPOeJ4l5jbZoYCQqll9qwtkE/1jFqi6D8T0pT7SGneMyQeCDl9DrktQXyskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgqwLv0T; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731105206; x=1762641206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+LF7CsJ7/io270zqeQKsXvXgBShIfl+NXbOKX6jVzM4=;
  b=DgqwLv0T9pPicR6S1TQsJkz/8RW9iWhzNzdz3abrEN7af1r7MYjUFKlA
   LXKwKK0Ox/kbg0EqnMufscSbAPNkaotm9UHqL5Ig62ZawXg82SVHwRWof
   bXxBip7/udTm11VpO9UQDoYo0eWdOXSLX5VTChA/RSfs/01dsGX4HNOKc
   hQ/qIBZEHGNHV8Gk5Ajh4cTZpT1t/V4dezcCsFxWvseu86QNRd1EawnJh
   2W6Q7XhuWKv7G4AUOp8aNvQJclqEufxAzp7GFy5nrXgortBJ4d0p4Z2+D
   Qb4U34jazjI431m4xuny3XjbpQQYQpk3uhMTwFKIFYkeftQ+9y7UDxGXu
   g==;
X-CSE-ConnectionGUID: ivD9u5uHQ4efH0JvPrZ5SA==
X-CSE-MsgGUID: NEqYNUdxRoSzdoolNSbTXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="30417942"
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="30417942"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 14:33:25 -0800
X-CSE-ConnectionGUID: sJHMUEGrSS6OVqSv/oK2bw==
X-CSE-MsgGUID: MBjI+FrtT1iEbSuKCrdJWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="90867165"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Nov 2024 14:33:21 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9XXb-000rqk-0O;
	Fri, 08 Nov 2024 22:33:19 +0000
Date: Sat, 9 Nov 2024 06:33:11 +0800
From: kernel test robot <lkp@intel.com>
To: Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <andersson@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] perf: Fujitsu: Add the Uncore PCI PMU driver
Message-ID: <202411090610.oPYJJG00-lkp@intel.com>
References: <20241108054006.2550856-3-fj5100bi@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108054006.2550856-3-fj5100bi@fujitsu.com>

Hi Yoshihiro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/smp/core]
[also build test WARNING on linus/master v6.12-rc6]
[cannot apply to arm64/for-next/core arm-perf/for-next/perf next-20241108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yoshihiro-Furudera/perf-Fujitsu-Add-the-Uncore-MAC-PMU-driver/20241108-134245
base:   tip/smp/core
patch link:    https://lore.kernel.org/r/20241108054006.2550856-3-fj5100bi%40fujitsu.com
patch subject: [PATCH 2/2] perf: Fujitsu: Add the Uncore PCI PMU driver
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241109/202411090610.oPYJJG00-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241109/202411090610.oPYJJG00-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411090610.oPYJJG00-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/fujitsu_pci_pmu.c:584:36: warning: 'fujitsu_pci_pmu_acpi_match' defined but not used [-Wunused-const-variable=]
     584 | static const struct acpi_device_id fujitsu_pci_pmu_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/fujitsu_pci_pmu_acpi_match +584 drivers/perf/fujitsu_pci_pmu.c

   583	
 > 584	static const struct acpi_device_id fujitsu_pci_pmu_acpi_match[] = {
   585		{ "FUJI200D", },
   586		{ }
   587	};
   588	MODULE_DEVICE_TABLE(acpi, fujitsu_pci_pmu_acpi_match);
   589	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

