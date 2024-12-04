Return-Path: <linux-kernel+bounces-431014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0DD9E38FC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29E9B3626D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C28E1B21B7;
	Wed,  4 Dec 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPto0+Fj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8156F17F4F6;
	Wed,  4 Dec 2024 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310127; cv=none; b=P+ay/YNexEiEGBJ7Sks580sO6obUkd5IAdbpQ9XeC5vive9DoEdIy7/Vc2GjmMF07fBzrSIAJpV6pnmW3Nx/pazmAoO/xLFbq9einyPzqhjxqH4td+mSTS16tPFywAGdqPWpXnniMhnnNGLMibaTPOeibxqi2q+lcRjrtr0bAX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310127; c=relaxed/simple;
	bh=RiCweuB8rkuhzPPyg5St6zFsmso3G0CQ0fGJY7lokf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nduHhpAtRKo6Bu4n+XiB/nfAeCAYaDiPid+msOSHDR1DzQQpKQquFHa9lgL+PjoTNuqksgLkK3MjIk8r9IeCv7TML//7WwXcYsF0kav2nKFHiEKmYBJirUES46nE8C+6Iu1djrc2Y4ThjaeynPsOPm0VMd7J1+lU5Juem49N/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPto0+Fj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733310124; x=1764846124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RiCweuB8rkuhzPPyg5St6zFsmso3G0CQ0fGJY7lokf8=;
  b=EPto0+Fj4LTdxXsDeRUnB2CoSZZrrFqlQoch2qrzCG5p5R0NmFxvE8qt
   d7s0Ov31iKoM+S5uYhNJ9IA545E4v2nJjoZG55zBCtYY236KsaU3B0aH8
   dhCXwsjF4jljhwbXC5ns9rNArEs9r7nEBm5lJF66zfNxPA6fbC/dmNGol
   P+7rLN5C7Z0ybVBWINyKagKzk1zR0ZMs7a/Y/STEjS22VA9FqOrWqZbjA
   E8EmOuVmKBYKB8po1ibbWtf6MiPY2lAVq5uzuv7V01xW6MXVwudAErFaf
   aZYh4qRDqonM0Z2/Oxc80g6nkeg/C4+YElsER7N0vGIcZrO47A0DyViJY
   w==;
X-CSE-ConnectionGUID: uNcu6Kv9R9Odr7EIC8kk3w==
X-CSE-MsgGUID: 3yu55FeKTFarnyMRb1xLYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="51102120"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="51102120"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:02:04 -0800
X-CSE-ConnectionGUID: WT/cDZSmTn6v81Zc4iWBog==
X-CSE-MsgGUID: gyJESw+5Rmai01xO4XTjXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93594678"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Dec 2024 03:02:02 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIn8H-0002uP-0g;
	Wed, 04 Dec 2024 11:01:31 +0000
Date: Wed, 4 Dec 2024 19:00:44 +0800
From: kernel test robot <lkp@intel.com>
To: Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH] of: Hide of_default_bus_match_table[]
Message-ID: <202412041839.pjv6awcS-lkp@intel.com>
References: <20241204000415.2404264-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204000415.2404264-1-swboyd@chromium.org>

Hi Stephen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephen-Boyd/of-Hide-of_default_bus_match_table/20241204-123701
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/20241204000415.2404264-1-swboyd%40chromium.org
patch subject: [PATCH] of: Hide of_default_bus_match_table[]
config: sparc-allnoconfig (https://download.01.org/0day-ci/archive/20241204/202412041839.pjv6awcS-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041839.pjv6awcS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041839.pjv6awcS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/of/platform.c:27:34: warning: 'of_default_bus_match_table' defined but not used [-Wunused-const-variable=]
      27 | static const struct of_device_id of_default_bus_match_table[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/of_default_bus_match_table +27 drivers/of/platform.c

    26	
  > 27	static const struct of_device_id of_default_bus_match_table[] = {
    28		{ .compatible = "simple-bus", },
    29		{ .compatible = "simple-mfd", },
    30		{ .compatible = "isa", },
    31	#ifdef CONFIG_ARM_AMBA
    32		{ .compatible = "arm,amba-bus", },
    33	#endif /* CONFIG_ARM_AMBA */
    34		{} /* Empty terminated list */
    35	};
    36	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

