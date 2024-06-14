Return-Path: <linux-kernel+bounces-214465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE090851F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B76C1C22AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ADF190467;
	Fri, 14 Jun 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0+NBMFJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC619007E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350128; cv=none; b=eVRoPiJ8dRctDCSOygPX2/Qb1OoOOnG6LLhFt9hOV5PWNo34HCnGUf485CSI0k04k+t9HfOGTnxZK6NXZmgUVpsXGoc+5JcD0JawCOyOASTZd0Lk5a9xGK2aUCXiVKTO8EdoRivrk2AatxKmZBeG1Y3dMLrkpUwLihhgxCQIMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350128; c=relaxed/simple;
	bh=0BWvOiSEx29uPnXKNvRZm08d4PO/OZEmvPGS6vF3An8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gojbzb6h7t84ekSUA+rOGTwWNlJ2U7NssNYuHKncKys/CZPs6Szznr+47XDVdBxlMms0O7TvXrHSFR3c382ZCFEGJaqzdBr4BnT+tX82y3ScMQy93PKOMX0X5DML+ltHXusPLdwLmRbIYnAm/u9ZpX4YD0vZ63Mb82QaC7eECfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0+NBMFJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718350127; x=1749886127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0BWvOiSEx29uPnXKNvRZm08d4PO/OZEmvPGS6vF3An8=;
  b=n0+NBMFJbhZmgmezdCHtVOpOVv/DTjNOVb+I0JTbS9b1G0APB8KIhEOP
   3Jbv6P86KpOegtF6eHefNtCfreZQLQWSG+joAsdu9pyfN8/tr4TP9wYCj
   6nBBTlsxy/yIhW7Wy38Sf5UE/n1yuXubVR/+wlyG4dYN6a4NmDElD5ctf
   YbD2zHBWqc8+0G6/MeMG8rKo6F7JdsFSRH2FOukVYz2GSB9vqL2zSCD9w
   av9kt7GbNhpNwMxS31u0bEOczw5FCMYYqd2Cz9s0ZzJit5UDMi8TBwdox
   gKqY4BICeFfACBGQTXNcLz1KMDj/NOLzQcIaggWM6erxTbmnpvPM1OUXU
   w==;
X-CSE-ConnectionGUID: hF/gZzXPRoyhkDT5v8+b7g==
X-CSE-MsgGUID: C3GvNrK3Tf++YjWONuC/wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15452530"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15452530"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 00:28:46 -0700
X-CSE-ConnectionGUID: LGuqLpu+T2eERVzKhty47Q==
X-CSE-MsgGUID: VWKNX+soR5mvpXkuGIXnsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="71618472"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jun 2024 00:28:43 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sI1MX-0000yV-0E;
	Fri, 14 Jun 2024 07:28:41 +0000
Date: Fri, 14 Jun 2024 15:28:35 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: Re: [PATCH v3] drm/fb-helper: Detect when lid is closed during
 initialization
Message-ID: <202406141545.9xBa6XY4-lkp@intel.com>
References: <20240613051700.1112-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613051700.1112-1-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/drm-fb-helper-Detect-when-lid-is-closed-during-initialization/20240613-132009
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240613051700.1112-1-mario.limonciello%40amd.com
patch subject: [PATCH v3] drm/fb-helper: Detect when lid is closed during initialization
config: sparc-randconfig-001-20240614 (https://download.01.org/0day-ci/archive/20240614/202406141545.9xBa6XY4-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240614/202406141545.9xBa6XY4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406141545.9xBa6XY4-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_lid_disconnect':
>> drm_fb_helper.c:(.text+0x76c): undefined reference to `input_close_device'
>> sparc64-linux-ld: drm_fb_helper.c:(.text+0x774): undefined reference to `input_unregister_handle'
   sparc64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_lid_connect':
>> drm_fb_helper.c:(.text+0xed8): undefined reference to `input_register_handle'
>> sparc64-linux-ld: drm_fb_helper.c:(.text+0xf24): undefined reference to `input_open_device'
   sparc64-linux-ld: drm_fb_helper.c:(.text+0xf9c): undefined reference to `input_unregister_handle'
   sparc64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
>> drm_fb_helper.c:(.text+0x1d2c): undefined reference to `input_register_handler'
   sparc64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
>> drm_fb_helper.c:(.text+0x2ce4): undefined reference to `input_unregister_handler'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

