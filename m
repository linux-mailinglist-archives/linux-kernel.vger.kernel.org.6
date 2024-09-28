Return-Path: <linux-kernel+bounces-342664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A64B989168
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 22:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2971F238FC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50E516D9AA;
	Sat, 28 Sep 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOMq4min"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A378615A858;
	Sat, 28 Sep 2024 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727557023; cv=none; b=hctmaxlX/3dvFf8ANsMU1OQLKPQQawj+Ti27mLaZD2bWwzutYK51lAxyviQigN8jPV39dxL6R4DDdvFy4gZ8z6HGVgqlmK2emX+/DRdQxIV6uwOi2pu35mrcxAMoyNE5S9UwAug651hkgbxMT1KcpivRWigvhJeTTh9JfsGn3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727557023; c=relaxed/simple;
	bh=dG+qYVYUQQ1L7vJqvdYEnnzuiyxw2mU5c+4CImsnBVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBcQpbPtsWQ0P3/YwyGjCO1QTjHRrOCNN2zbTABTcRFGAJX2rGPgTiFs1HBIEnqy5vHyPHZD1bTmoQKNjpucDfIHdrFjau35IxWfFZD291FKFEfPaqG1yoN9sBxK611d3U2i6hNxxI3ZoSeo8jKcMp1P7pg4HMPALFTv7A6v8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOMq4min; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727557021; x=1759093021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dG+qYVYUQQ1L7vJqvdYEnnzuiyxw2mU5c+4CImsnBVg=;
  b=OOMq4minogxiYb3UqAyc5KRp1cWosuxE+dZLdQqKLW/9s7zpQmjVxJK1
   fFiDsqv5G4/QbzzjIwNLYcf+h9NAAkVLDLBHjQ9NWk5RoMlh0qWjS7d4/
   Z7aA7L2Sm6xw8PVZYfz21A95BY3TLS4Q0Ur6Bv+uHQzUR5nrHJnJbTJxd
   isCy9oFODWlTVBphw2KGHzPU4nW66gRBlxCMuw+u6jwYXxqezD9pjlx6H
   BumqUuSpxsiXed4LWqXRyYL7/+RUmEi2s1+MxRqkUOIi/8cJtkOdHW1Yl
   qSMEaLEMasknE6mBlRpLgpqCPlJ/WW82QTCKZvE29SG0IwNVBgy1hT8w/
   w==;
X-CSE-ConnectionGUID: qem1414TTbWBoeMnwDp/Vw==
X-CSE-MsgGUID: 7ERP4ZevTqeRg6YBUmvsYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="30381424"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="30381424"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 13:57:01 -0700
X-CSE-ConnectionGUID: zX3rXiczQyGXsbO7zMzVBA==
X-CSE-MsgGUID: JWGyZ9FPQECcJ/ZfEe1cbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="96208134"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Sep 2024 13:56:59 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sueUq-000Ned-2S;
	Sat, 28 Sep 2024 20:56:56 +0000
Date: Sun, 29 Sep 2024 04:56:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, platform-driver-x86@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
	corentin.chary@gmail.com, superm1@kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: Re: [PATCH 3/3] platfom/x86: asus-wmi: cleanup after Ally quirk
 reverts
Message-ID: <202409290438.IYVkP4i0-lkp@intel.com>
References: <20240926095344.1291013-4-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926095344.1291013-4-luke@ljones.dev>

Hi Luke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on amd-pstate/bleeding-edge]
[also build test WARNING on linus/master v6.11 next-20240927]
[cannot apply to amd-pstate/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luke-D-Jones/Revert-platform-x86-asus-wmi-ROG-Ally-increase-wait-time-allow-MCU-powersave/20240926-175641
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
patch link:    https://lore.kernel.org/r/20240926095344.1291013-4-luke%40ljones.dev
patch subject: [PATCH 3/3] platfom/x86: asus-wmi: cleanup after Ally quirk reverts
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20240929/202409290438.IYVkP4i0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409290438.IYVkP4i0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409290438.IYVkP4i0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/asus-wmi.c:148:35: warning: 'asus_ally_mcu_quirk' defined but not used [-Wunused-const-variable=]
     148 | static const struct dmi_system_id asus_ally_mcu_quirk[] = {
         |                                   ^~~~~~~~~~~~~~~~~~~


vim +/asus_ally_mcu_quirk +148 drivers/platform/x86/asus-wmi.c

0f0ac158d28ff7 Luke D. Jones 2021-10-24  147  
d2dfed310aae07 Luke D. Jones 2024-08-06 @148  static const struct dmi_system_id asus_ally_mcu_quirk[] = {
d2dfed310aae07 Luke D. Jones 2024-08-06  149  	{
d2dfed310aae07 Luke D. Jones 2024-08-06  150  		.matches = {
d2dfed310aae07 Luke D. Jones 2024-08-06  151  			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
d2dfed310aae07 Luke D. Jones 2024-08-06  152  		},
d2dfed310aae07 Luke D. Jones 2024-08-06  153  	},
d2dfed310aae07 Luke D. Jones 2024-08-06  154  	{
d2dfed310aae07 Luke D. Jones 2024-08-06  155  		.matches = {
d2dfed310aae07 Luke D. Jones 2024-08-06  156  			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
d2dfed310aae07 Luke D. Jones 2024-08-06  157  		},
d2dfed310aae07 Luke D. Jones 2024-08-06  158  	},
d2dfed310aae07 Luke D. Jones 2024-08-06  159  	{ },
d2dfed310aae07 Luke D. Jones 2024-08-06  160  };
d2dfed310aae07 Luke D. Jones 2024-08-06  161  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

