Return-Path: <linux-kernel+bounces-358206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBBE997B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B294B2302A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D3192B69;
	Thu, 10 Oct 2024 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCIOLnOs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83134BE57;
	Thu, 10 Oct 2024 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531887; cv=none; b=m18J47tB7yaCxFmgmCC+AssLATSVsQ3VLD8xJJMXvq8y8nqzTOYn45CdUFtxj2KzX7DOwiykZeTGJJXrEYmk3bVUEKIl7/3MfERSXaA07FGa7fc0FwRBXT2FK5XR7qHG6pEWEwfFXCEjdgJJ+uyMl+uspwBmX0/gbIpN5UPBP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531887; c=relaxed/simple;
	bh=PISRcAtaVQX0sH6brsB+BVG0siQZUE29JBaLN8+snY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSiQHc4cIIYsrN+valGV9uIYdAHxyhdtef5vvIUNd2TTglQZN/tUaUIyDIXewuRdLS2BcXUJCjCPxemo/tnT9qkkOpigoZD0zMRlkMeHO8aI3OJCvxLx7w7GY3i2Aby6W8sBqmBovLk7dxaSJK6Vkf0GpDumQGGCSRR8Vao5YhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCIOLnOs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728531886; x=1760067886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PISRcAtaVQX0sH6brsB+BVG0siQZUE29JBaLN8+snY8=;
  b=UCIOLnOsrDKAkFzRuGvxiuOZiCHvQDzo19+0CjOXzXa4WRlbOS+s7jQZ
   YDfVXCM6Ndh92MIGTGOgpPGIyky01C0AInu5cm+3PiJRr2LbA9EGJGYTA
   GdNAiLCHVHgDJbjQj/3+1m5Qba+CmlRexEMaaod71kWGVaBiYbktD3nWN
   Ec612LBL/DjxFkpII89SX3LkYGJfpJImFsfhTaIAa++5HpIs+FqQuJg9x
   dDB615Womv+CznnXVuzVYmsB3666lowzwb5pdAvi6W4wK6FFHhc1iePDK
   5j616bfKLmo8ZGGnXwPJgkfUiqwWKslp0IYjNQmjli9KYPXiLmvZX1Cel
   Q==;
X-CSE-ConnectionGUID: y6p4FOWOQsyzucpYC7j03g==
X-CSE-MsgGUID: UY+Hb5umQ7O2YpHJuIx2rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38452258"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="38452258"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 20:44:45 -0700
X-CSE-ConnectionGUID: FkV0STOEQGyYN4z1B0EfpQ==
X-CSE-MsgGUID: sXuUxQxMRleg1YYuo9Qs7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="107298147"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Oct 2024 20:44:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syk6S-000A7l-2c;
	Thu, 10 Oct 2024 03:44:40 +0000
Date: Thu, 10 Oct 2024 11:44:08 +0800
From: kernel test robot <lkp@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
Message-ID: <202410101120.w4OLAnaI-lkp@intel.com>
References: <20241008195642.36677-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008195642.36677-2-kuurtb@gmail.com>

Hi Kurt,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc2 next-20241009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kurt-Borja/alienware-wmi-Dell-AWCC-platform_profile-support/20241009-040025
base:   linus/master
patch link:    https://lore.kernel.org/r/20241008195642.36677-2-kuurtb%40gmail.com
patch subject: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
config: i386-randconfig-r051-20241010 (https://download.01.org/0day-ci/archive/20241010/202410101120.w4OLAnaI-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410101120.w4OLAnaI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410101120.w4OLAnaI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/x86/dell/alienware-wmi.c:822:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     822 |         return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
         |                ^
   1 error generated.


vim +/FIELD_PREP +822 drivers/platform/x86/dell/alienware-wmi.c

   819	
   820	static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
   821	{
 > 822		return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
   823	}
   824	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

