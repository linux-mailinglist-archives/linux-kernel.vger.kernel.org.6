Return-Path: <linux-kernel+bounces-199947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376928FA811
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04F428B0FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EEE13D62C;
	Tue,  4 Jun 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VO2bURFY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4113D2B5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466604; cv=none; b=hgzVxVVrEHNzwLrDSykHNNTsPrJqIWGecWMClg1rLOkfzXcPfv9KhLfED/VjeO+vfRSSfC/LrqAwuCxiIfEI9ugYZ+GpNNYAah2bVe6nabTqGAZ7YUkF0++sLkVZauGhOOo0Ezz7XNE6g+oLQLd+JAIAZhsT/icSlHG5yf29j+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466604; c=relaxed/simple;
	bh=VTCH11EDuFxS9Okiehsc89nS6yYQ+MIJBAIq81KUk0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkVlhHxcgCtKRPFPpEn9IV/ewxMHj/n/bqnY9J6UZw6Cc9VHa6SYzJ7wcwmX1NwA5ifFOFyt0xPCbd037osPPUzlIpYAWgaBm4R5w0OxyqZlVEPneaH6oW6fdQ5XsA+yvaimnBt4ssq9GiCucdHQATi4kh9Fw00X+2ecGuKzzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VO2bURFY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466603; x=1749002603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VTCH11EDuFxS9Okiehsc89nS6yYQ+MIJBAIq81KUk0s=;
  b=VO2bURFYJQl9YEYVL2m0kReVxaAFIYOz6pzW6hjS66R1IAlK6lMeWjDp
   47wxjcGyd3YDO39zCPU/VhR+sMDaX/E9U338qMiai0d8WtcHRvpFzGGlj
   bA130eGSEd/5qYxnVitMJgTB1fyQMDzkJ2ITgK5zugkEHGUSf1m74MnhY
   KV92fjyWrTJ5oPfLNiMWSu9SPwseslkYFNNdGcV2Z4CwRgbhQEqfoKUPg
   WHR6DR37iwiD2GkbO0bV4oU+GnUAb+WLugj1VOco9PuZDrjsSlBqL4y5L
   LHS+0W4L2BcX7JsJXAE2XkbmT+EQ22RGqRhzd84cYqCFeNVDrptTWfaxf
   g==;
X-CSE-ConnectionGUID: 8t+yBy4STuiSReeaQcSTTQ==
X-CSE-MsgGUID: 8VGoKzX5QD6FHKqW7Pch/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="11884912"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="11884912"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 19:03:13 -0700
X-CSE-ConnectionGUID: YFB59XH6RPabyn5x7q+MDg==
X-CSE-MsgGUID: O0cRuqV4QWOcwVyqRpgsIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="74557144"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 03 Jun 2024 19:03:10 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEJVn-000MQt-0n;
	Tue, 04 Jun 2024 02:03:05 +0000
Date: Tue, 4 Jun 2024 10:02:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>, hughsient@gmail.com
Subject: Re: [PATCH v2] drm/client: Detect when ACPI lid is closed during
 initialization
Message-ID: <202406040928.Eu1gRIWv-lkp@intel.com>
References: <20240528210319.1242-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528210319.1242-1-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.10-rc2 next-20240603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/drm-client-Detect-when-ACPI-lid-is-closed-during-initialization/20240529-050440
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240528210319.1242-1-mario.limonciello%40amd.com
patch subject: [PATCH v2] drm/client: Detect when ACPI lid is closed during initialization
config: i386-randconfig-053-20240604 (https://download.01.org/0day-ci/archive/20240604/202406040928.Eu1gRIWv-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.5.0-4ubuntu2) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406040928.Eu1gRIWv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406040928.Eu1gRIWv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/drm_client_modeset.o: in function `drm_client_match_edp_lid':
>> drivers/gpu/drm/drm_client_modeset.c:281:(.text+0x221b): undefined reference to `acpi_lid_open'


vim +281 drivers/gpu/drm/drm_client_modeset.c

   260	
   261	static void drm_client_match_edp_lid(struct drm_device *dev,
   262					     struct drm_connector **connectors,
   263					     unsigned int connector_count,
   264					     bool *enabled)
   265	{
   266		int i;
   267	
   268		for (i = 0; i < connector_count; i++) {
   269			struct drm_connector *connector = connectors[i];
   270	
   271			switch (connector->connector_type) {
   272			case DRM_MODE_CONNECTOR_LVDS:
   273			case DRM_MODE_CONNECTOR_eDP:
   274				if (!enabled[i])
   275					continue;
   276				break;
   277			default:
   278				continue;
   279			}
   280	
 > 281			if (!acpi_lid_open()) {
   282				drm_dbg_kms(dev, "[CONNECTOR:%d:%s] lid is closed, disabling\n",
   283					    connector->base.id, connector->name);
   284				enabled[i] = false;
   285			}
   286		}
   287	}
   288	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

