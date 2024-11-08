Return-Path: <linux-kernel+bounces-402324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C09C2666
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C9F1F238B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302481AA1FA;
	Fri,  8 Nov 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIfSu7OZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03801C1F0B;
	Fri,  8 Nov 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097224; cv=none; b=mDfFuOgDhrFdcWKlZ+gmGF4xmuj7QzznwzwEDJ0VMT2qEM8mwNg9idJ8V61D9D7hjWjyFFtnUS2Z8qX1G+BGZyPZF/GNx/u7ORC3doafQCb3Y4mlbfegCazXbCg057w9MGKrWJqY/5fygXN8ptLBwbKbHXDW0hiYiCI1bSEKpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097224; c=relaxed/simple;
	bh=Cex5OFKLdepISNlr/zMsoMKZr4c1wz925xujO/RtmjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCCLB2ZfBv2gCpg2ED7qVL9rsyAHyv5IZ4iFT7my7rr8Kuhgg3wTM96yOdk38PGhHTxaxu3LXIOXI0ofbgSqCj22Qi1h28qtyK5vyBlWBWBxHFJTcAIkbOnLrQKqryhc6NTlCHHl63IzKJgSppYZ9HrwKjEaDMufTqcanqQqANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIfSu7OZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731097222; x=1762633222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cex5OFKLdepISNlr/zMsoMKZr4c1wz925xujO/RtmjM=;
  b=YIfSu7OZlO0S5pIz0+o6DcB5cBXet2ETi1kIEf6ZEaMeHuhHrPG4fZ3u
   EWicq8pafqNLZZSJCqKuCKKcRVIHQXOwa7mmlkf+yWWkCJWF2q/gij2Hd
   qP8bzGJ/qEBX+piki0impNfyyp6SHpd3xawE/TgYfOG9q//mnOQ1sUYGn
   wF3+Jn+qSjyhfVRRqDeZauPPEU71cXKmMjfYQYIy5WjN4RFBIkK3TLNeM
   uyxd94ayyJO+dQ7UcyTgeVZYw99tIMOY7j7DZaOgma6405KZw38ZHOeAX
   6Nz7sLq0pa8lzSuXWM/G/wvIzfPVvzBph2iEbfoysXSTlzQRDPO8A67Ac
   A==;
X-CSE-ConnectionGUID: xczEsJKSSFanVlUJGMjgsA==
X-CSE-MsgGUID: QHkkMecFS9Wm/niKD+UYNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="34780330"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="34780330"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 12:20:21 -0800
X-CSE-ConnectionGUID: z9jpa/nIQaS3xVbzK89FJg==
X-CSE-MsgGUID: RntjX9eYQR62U2yHDkNiXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="90835236"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Nov 2024 12:20:17 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9VSo-000rlS-2Y;
	Fri, 08 Nov 2024 20:20:14 +0000
Date: Sat, 9 Nov 2024 04:19:54 +0800
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
Subject: Re: [PATCH 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Message-ID: <202411090451.quuiocP9-lkp@intel.com>
References: <20241108054006.2550856-2-fj5100bi@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108054006.2550856-2-fj5100bi@fujitsu.com>

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
patch link:    https://lore.kernel.org/r/20241108054006.2550856-2-fj5100bi%40fujitsu.com
patch subject: [PATCH 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241109/202411090451.quuiocP9-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241109/202411090451.quuiocP9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411090451.quuiocP9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/fujitsu_mac_pmu.c:604:36: warning: 'fujitsu_mac_pmu_acpi_match' defined but not used [-Wunused-const-variable=]
     604 | static const struct acpi_device_id fujitsu_mac_pmu_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/fujitsu_mac_pmu_acpi_match +604 drivers/perf/fujitsu_mac_pmu.c

   603	
 > 604	static const struct acpi_device_id fujitsu_mac_pmu_acpi_match[] = {
   605		{ "FUJI200C", },
   606		{ }
   607	};
   608	MODULE_DEVICE_TABLE(acpi, fujitsu_mac_pmu_acpi_match);
   609	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

