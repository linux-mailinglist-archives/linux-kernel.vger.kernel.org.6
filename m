Return-Path: <linux-kernel+bounces-364973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50C299DBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA791C23500
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C515A856;
	Tue, 15 Oct 2024 01:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4ErzauT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB813DBBC;
	Tue, 15 Oct 2024 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956183; cv=none; b=pID7t9UCpzXR9THzIEjnsUn2O+h4uQbbCTtlWsgoKKFTCqJxfiFATJQyW7E11C7oyF/PfFxMY8KC+nKOJUQ5KwuWMwlTcbajrmwYb1vA3IaVJ5jZOmZ3GEMe9xo5xhhJVQ8EYWTmGxT4qjOsF4B1rGG+OzghKWrG1HdO1leqjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956183; c=relaxed/simple;
	bh=BxunOLC7SLYiMYlnQtABF4rqOdPefSeGirsL1mlD6ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzjpbcpoKK2rEuqGiTkyXLNOAiddLTN0/z1RSZRlNjfSajcTXdaCeZjSOoBBMfPZk1C6mraWm+M3yDNgjQ8Sdpj1gUEjSGRsp4g7GrBiQM4zx56cA/S2f0abrMUQutJXiWje9bK1MTIXPL7xmZ2q71gxiXnpJ+IioWRIOtfsYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4ErzauT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728956182; x=1760492182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BxunOLC7SLYiMYlnQtABF4rqOdPefSeGirsL1mlD6ZA=;
  b=E4ErzauTuREde4iXU9beK0WMlbXeBcDlNELH6/XupgQ2KYTO3ksKG80r
   hAbQZHtSXSH9PegqXNWCC71ZeZrOIIjSizr6Nei7qQJDfEYAF+fOeJnN2
   MH0kLvOTAfDkCRO1K4ahQeQ1hNqKgmziaVJBZzEauA2oxoPv3TJTsIm6a
   013NapRk1eM7QTBpds/IUdZA6yJBZQk+Jhlc4BkQNY8A0FlswxUl1AiJF
   kctUjaF3ZA6eV/rWRf6gRrck4+rD+TMlz9aqtp+xQHiWGjxbPDFowBfA/
   Y0JiP6J+yNUkYMeeewYy02jofB6XGA+u47PS2R4pWOJOOwScorTPYANsJ
   g==;
X-CSE-ConnectionGUID: PLhTiosGSGyKP1a2Urp2Jg==
X-CSE-MsgGUID: 6Y7b11+mSHCLyhZ9mUwk3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="38961852"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="38961852"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 18:36:21 -0700
X-CSE-ConnectionGUID: A+HDiqjaRMGA/VUwCnfLbQ==
X-CSE-MsgGUID: gxxyTZ14QXWROMXSgMy4/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77604846"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2024 18:36:19 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0WTw-000HRe-25;
	Tue, 15 Oct 2024 01:36:16 +0000
Date: Tue, 15 Oct 2024 09:35:55 +0800
From: kernel test robot <lkp@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
Message-ID: <202410150939.BgH8WpE3-lkp@intel.com>
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
[also build test ERROR on v6.12-rc3 next-20241014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kurt-Borja/alienware-wmi-Dell-AWCC-platform_profile-support/20241011-184337
base:   linus/master
patch link:    https://lore.kernel.org/r/20241008195642.36677-2-kuurtb%40gmail.com
patch subject: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
config: x86_64-buildonly-randconfig-004-20241015 (https://download.01.org/0day-ci/archive/20241015/202410150939.BgH8WpE3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241015/202410150939.BgH8WpE3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410150939.BgH8WpE3-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/platform/x86/dell/alienware-wmi.c: In function 'profile_to_wmax_arg':
>> drivers/platform/x86/dell/alienware-wmi.c:822:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     822 |         return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
         |                ^~~~~~~~~~
   cc1: some warnings being treated as errors


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

