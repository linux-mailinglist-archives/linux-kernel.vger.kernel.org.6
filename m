Return-Path: <linux-kernel+bounces-365515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561C99E38C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A32C284580
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF961E32CF;
	Tue, 15 Oct 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfjL7TtX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7A1E2841
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987229; cv=none; b=tMdm5ykTFU2zwV8P2hkYV+psM5a0YsWDuKwwhNq2C2/+WYMb+QCOXMAApGTcsXCmARa4ZjBS8RMZ6ARt2/hp94ZDPbvUW0xElmru8ICcwdxYov5mlyacuUHi6zCH7zee+jrzZuV0pxHS4TzN0szi2UUHvvCKiVD7tvFGUTDe0mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987229; c=relaxed/simple;
	bh=jBNLiiDQztK8tDxklcBbYNKZ4i3UWrSzPxw5rOzncRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwkz21aiVHL4SujEH3ayzRFDp0TEVesRzZyWctVb9WaDQZS0TdDj2CcMExjzTZ5pDe29EVreNa3i2jZgy19dUwWeElUAWIUjVGjuAc5hEB48iH/v7kcrjKZGYU4iJZXj+1UtDCmO9eld0kLZDU0JymmCbbeyNqEcPUcC5L/GqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfjL7TtX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728987229; x=1760523229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jBNLiiDQztK8tDxklcBbYNKZ4i3UWrSzPxw5rOzncRg=;
  b=HfjL7TtXY+R1B+LoVwVId9KVtVtSyKcx5/aOP0Fc+yV0iY8GmibPhI4I
   8hnwzr5uWIZm4RON3HockQ05rvAf5mwhAbGa8SC9tVEfjJlkjfT9DxX1A
   5sGXBRDBHJEReqgQHLCq22YiReGFeHmOYyEeAPpA0Comud/3FMXdGcmr2
   qmr4FzmOdIESW9I+U43Ei7e6p/ZuONCjVQQVL5RL8by0yIrGg+Ndud9g/
   5R2OYmQf/uwrTQbJszw9BgQJvBw+k4+8M4fuvhQBemQBZ4OD21eZsgxzb
   H6uKK0+LEOtPTJ0kLmjWtiDZs5ejEpHghFjftbyZcmmOahdwlVubSjvcS
   g==;
X-CSE-ConnectionGUID: G84eLqd7T46r5cBpcpwoug==
X-CSE-MsgGUID: v+5uHKvERmOmCagfdV0DRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28158107"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28158107"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 03:13:48 -0700
X-CSE-ConnectionGUID: USzd0He1RrSE+DO0OgbOWg==
X-CSE-MsgGUID: Iwu0yHTATwuaRIQb8BI1Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="108574767"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2024 03:13:44 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0eYg-000Hx3-0G;
	Tue, 15 Oct 2024 10:13:42 +0000
Date: Tue, 15 Oct 2024 18:13:07 +0800
From: kernel test robot <lkp@intel.com>
To: Giedrius =?utf-8?Q?Statkevi=C4=8Dius?= <giedriuswork@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Giedrius =?utf-8?Q?Statkevi=C4=8Dius?= <giedriuswork@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/lspcon: do not hardcode settle timeout
Message-ID: <202410151813.Hw9oCTae-lkp@intel.com>
References: <20241014093914.109162-1-giedriuswork@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014093914.109162-1-giedriuswork@gmail.com>

Hi Giedrius,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc3 next-20241015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Giedrius-Statkevi-ius/drm-i915-lspcon-do-not-hardcode-settle-timeout/20241014-174131
base:   linus/master
patch link:    https://lore.kernel.org/r/20241014093914.109162-1-giedriuswork%40gmail.com
patch subject: [PATCH] drm/i915/lspcon: do not hardcode settle timeout
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20241015/202410151813.Hw9oCTae-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241015/202410151813.Hw9oCTae-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410151813.Hw9oCTae-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/display/drm_dp_dual_mode_helper.c:495: warning: Function parameter or struct member 'time_out' not described in 'drm_lspcon_set_mode'


vim +495 drivers/gpu/drm/display/drm_dp_dual_mode_helper.c

056996b9568632 drivers/gpu/drm/drm_dp_dual_mode_helper.c         Shashank Sharma       2016-10-17  482  
056996b9568632 drivers/gpu/drm/drm_dp_dual_mode_helper.c         Shashank Sharma       2016-10-17  483  /**
613a308159e5dd drivers/gpu/drm/drm_dp_dual_mode_helper.c         Jani Nikula           2016-10-19  484   * drm_lspcon_set_mode: Change LSPCON's mode of operation by
613a308159e5dd drivers/gpu/drm/drm_dp_dual_mode_helper.c         Jani Nikula           2016-10-19  485   * writing offset (0x80, 0x40)
318fbd7dfedd67 drivers/gpu/drm/drm_dp_dual_mode_helper.c         Lyude Paul            2021-04-23  486   * @dev: &drm_device to use
613a308159e5dd drivers/gpu/drm/drm_dp_dual_mode_helper.c         Jani Nikula           2016-10-19  487   * @adapter: I2C-over-aux adapter
613a308159e5dd drivers/gpu/drm/drm_dp_dual_mode_helper.c         Jani Nikula           2016-10-19  488   * @mode: required mode of operation
056996b9568632 drivers/gpu/drm/drm_dp_dual_mode_helper.c         Shashank Sharma       2016-10-17  489   *
056996b9568632 drivers/gpu/drm/drm_dp_dual_mode_helper.c         Shashank Sharma       2016-10-17  490   * Returns:
056996b9568632 drivers/gpu/drm/drm_dp_dual_mode_helper.c         Shashank Sharma       2016-10-17  491   * 0 on success, -error on failure/timeout
056996b9568632 drivers/gpu/drm/drm_dp_dual_mode_helper.c         Shashank Sharma       2016-10-17  492   */
318fbd7dfedd67 drivers/gpu/drm/drm_dp_dual_mode_helper.c         Lyude Paul            2021-04-23  493  int drm_lspcon_set_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
3d7a1094af9e7e drivers/gpu/drm/display/drm_dp_dual_mode_helper.c Giedrius Statkevičius 2024-10-14  494  			enum drm_lspcon_mode mode, int time_out)
056996b9568632 drivers/gpu/drm/drm_dp_dual_mode_helper.c         Shashank Sharma       2016-10-17 @495  {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

