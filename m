Return-Path: <linux-kernel+bounces-403008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25CA9C2F81
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 21:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF8428211B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226111A0739;
	Sat,  9 Nov 2024 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9oYKpxD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414513BC12
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731184267; cv=none; b=XxrTMqAFKCnPyVfvm7zn9o1vW2o6TT+o1ucihpVU654JIoumSQuVZvGjf65ddcIyOqQwj/NDyHeMw6TQLZ/FmqDM01e5PIDLhw8HHBYZgMupmUYpcjv75INicN0PJpT72EW6Haip0MrOTfxx2INE5Vi1HZTWGpQzRqvEjBsc5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731184267; c=relaxed/simple;
	bh=lwc+6sp3mcJ5Ad0yQLyDMLqBIcNpYLMMzahip6ZIWmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdJO4wkhUI52h+2Z767pylrAc+yIsxQQOBkzIvYlcvEw9+XjcWyZzei5oFjniLVh4TZNXjoA1bS0mZt2zBezHvLjm5FtdDyOvGR8hGZr/JD0lv6sV/FPliBYdCkkIVpfHfhSYCkI0VzXuvz0WY/sJIZyCd900uh2ANqX/vEn0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9oYKpxD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731184264; x=1762720264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lwc+6sp3mcJ5Ad0yQLyDMLqBIcNpYLMMzahip6ZIWmI=;
  b=m9oYKpxDl36q0mQ2H5UPuGv9IX/5g5hizmK7EulooXW1oMFEqO5Ymc4b
   t7FSXPY/NCMtNVvlx3jYDMhaLepsVifPbYnFgGRDQKnqy2i4jr/kC6baE
   FIxgajU+Gui6T/dVadPEu8v6RRQA5ExvJ/F/r9e0Jl2rCovTDmWdCm/fi
   uZVPe22RrinOjWpNBeZq6C09iQx3N+A9Sj32HDJkJqeCqkrCxo00HR6Pc
   M92ibTbKNTvFKJJotMKiQDFnP+q2f+81qaEwJbknf9wRHu4KFBzvIXdiC
   Mc++WGLfKzma04lWMqs0F5BCJ2s+n0uQ2umx4hTgW/Mky3VhixnhCHXY7
   Q==;
X-CSE-ConnectionGUID: w8iMUUrES663m/Bbti9NYQ==
X-CSE-MsgGUID: AMt9YctTSpuxqKkuMawqqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11251"; a="31146956"
X-IronPort-AV: E=Sophos;i="6.12,141,1728975600"; 
   d="scan'208";a="31146956"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 12:31:03 -0800
X-CSE-ConnectionGUID: SqYXoFcpRpS+1UQ6kzFulw==
X-CSE-MsgGUID: gbPkTUaOTr+b6WNW2HVVlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="91027501"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Nov 2024 12:30:58 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9s6i-000sby-0c;
	Sat, 09 Nov 2024 20:30:56 +0000
Date: Sun, 10 Nov 2024 04:29:58 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 3/7] drm/vc4: use drm_hdmi_connector_mode_valid()
Message-ID: <202411100456.0JcsAx2b-lkp@intel.com>
References: <20241109-hdmi-mode-valid-v3-3-5348c2368076@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109-hdmi-mode-valid-v3-3-5348c2368076@linaro.org>

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 929beafbe7acce3267c06115e13e03ff6e50548a]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/drm-display-hdmi-add-generic-mode_valid-helper/20241109-203557
base:   929beafbe7acce3267c06115e13e03ff6e50548a
patch link:    https://lore.kernel.org/r/20241109-hdmi-mode-valid-v3-3-5348c2368076%40linaro.org
patch subject: [PATCH v3 3/7] drm/vc4: use drm_hdmi_connector_mode_valid()
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20241110/202411100456.0JcsAx2b-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241110/202411100456.0JcsAx2b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411100456.0JcsAx2b-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/vc4/vc4_hdmi.c: In function 'vc4_hdmi_encoder_mode_valid':
>> drivers/gpu/drm/vc4/vc4_hdmi.c:1762:68: warning: passing argument 2 of 'drm_hdmi_connector_mode_valid' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1762 |         return drm_hdmi_connector_mode_valid(&vc4_hdmi->connector, mode);
         |                                                                    ^~~~
   In file included from drivers/gpu/drm/vc4/vc4_hdmi.c:35:
   include/drm/display/drm_hdmi_state_helper.h:25:56: note: expected 'struct drm_display_mode *' but argument is of type 'const struct drm_display_mode *'
      25 |                               struct drm_display_mode *mode);
         |                               ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +1762 drivers/gpu/drm/vc4/vc4_hdmi.c

  1749	
  1750	static enum drm_mode_status
  1751	vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
  1752				    const struct drm_display_mode *mode)
  1753	{
  1754		struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
  1755	
  1756		if (vc4_hdmi->variant->unsupported_odd_h_timings &&
  1757		    !(mode->flags & DRM_MODE_FLAG_DBLCLK) &&
  1758		    ((mode->hdisplay % 2) || (mode->hsync_start % 2) ||
  1759		     (mode->hsync_end % 2) || (mode->htotal % 2)))
  1760			return MODE_H_ILLEGAL;
  1761	
> 1762		return drm_hdmi_connector_mode_valid(&vc4_hdmi->connector, mode);
  1763	}
  1764	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

