Return-Path: <linux-kernel+bounces-401614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9079C1CEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8D9284FCF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7901E7C38;
	Fri,  8 Nov 2024 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGDMHdXQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295111E7C06
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068890; cv=none; b=nU9rNSEr+CTcRcdvxKugAGtYqnee0WNfhgHUAOdxGNYepiQLcWARBP13EBqGbggGSDYozWjngZl8IZys6PkMQu9XMvQ2foo0E3BSeepoAkRC9N4JgGhV8bxNLFcQ9cUoz0wkFySkl5ZaOx0AZpipd9XlQIWnUu9si3P53jOdBYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068890; c=relaxed/simple;
	bh=bOnSnfghil8eztkx0QAVOkK/Z5EvmrYIytE5HE9doqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRvUzO+1qkgyw8m4vMDoQ9yYNQ8ZQji+H527DMXVDSbyKz/N2XSXg5jw+lmFkPpWn0qfIMRDqXAEO12t1+RXcw+r8ZaglX5wRU5wSeodJO8UGpGpTmy+f9CqVJzri8EUOkKyFWOZlZa1ku+68DjGfLeo9PIfQBVsu+2n0ANEuBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGDMHdXQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731068888; x=1762604888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bOnSnfghil8eztkx0QAVOkK/Z5EvmrYIytE5HE9doqk=;
  b=NGDMHdXQKVrsN4EugnYNWUItpISuvRHJL7qOfaSgHZhAmuJEv7uJuaV/
   b4C7SjpujsQTBAdxX/KSwRGR0u4i95vnrgtiYA6bX1j9xTWvQB7f9rY1i
   H3HtQgYxTBxifvg+L3E/Sl8BEffsbRR7NBTvQYWYoSs6FtoXxEKuCxy5p
   oAAICAyopwtuEHGYOYbfwSJXzbV4w8D9XObs8GCBqNm4ClOwj65rYQxfK
   yxh2bRnt/McNbMv8MM6xHMrpcosPgZeFysH9XJp2eN7oMrfQ0rv8Cw7a+
   HeLBFSSSOcM247Eq6kLAMwwE4xaT93mIFf2+YkiLKa6sEgMkj7H4g8EFI
   g==;
X-CSE-ConnectionGUID: jsK/BQtMR9Sh3LjnGQtcyg==
X-CSE-MsgGUID: tgywKPUlSQiSk2SQBd+4Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="42347927"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="42347927"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:28:08 -0800
X-CSE-ConnectionGUID: qk7/gN9KTX+KVphisCHoRw==
X-CSE-MsgGUID: mrjG7lpOQKmYWiTZko7N9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85054673"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Nov 2024 04:28:04 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9O5q-000rPq-0C;
	Fri, 08 Nov 2024 12:28:02 +0000
Date: Fri, 8 Nov 2024 20:27:17 +0800
From: kernel test robot <lkp@intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v7 3/7] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
Message-ID: <202411082006.DB7Dlk06-lkp@intel.com>
References: <20241108082025.1004653-4-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108082025.1004653-4-jfalempe@redhat.com>

Hi Jocelyn,

kernel test robot noticed the following build errors:

[auto build test ERROR on baf4afc5831438b35de4b0e951b9cd58435a6d99]

url:    https://github.com/intel-lab-lkp/linux/commits/Jocelyn-Falempe/drm-panic-Move-drawing-functions-to-drm_draw/20241108-162222
base:   baf4afc5831438b35de4b0e951b9cd58435a6d99
patch link:    https://lore.kernel.org/r/20241108082025.1004653-4-jfalempe%40redhat.com
patch subject: [PATCH v7 3/7] drm/log: Introduce a new boot logger to draw the kmsg on the screen
config: x86_64-buildonly-randconfig-002-20241108 (https://download.01.org/0day-ci/archive/20241108/202411082006.DB7Dlk06-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411082006.DB7Dlk06-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411082006.DB7Dlk06-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/drm_client_setup.c:11:38: error: use of undeclared identifier 'CONFIG_DRM_CLIENT_DEFAULT'
      11 | static char drm_client_default[16] = CONFIG_DRM_CLIENT_DEFAULT;
         |                                      ^
>> drivers/gpu/drm/drm_client_setup.c:15:4: error: expected ';' after top level declarator
      15 |                  CONFIG_DRM_CLIENT_DEFAULT "]");
         |                  ^
   drivers/gpu/drm/drm_client_setup.c:33:6: error: redefinition of 'drm_client_setup'
      33 | void drm_client_setup(struct drm_device *dev, const struct drm_format_info *format)
         |      ^
   include/drm/drm_client_setup.h:16:20: note: previous definition is here
      16 | static inline void drm_client_setup(struct drm_device *dev,
         |                    ^
   drivers/gpu/drm/drm_client_setup.c:55:6: error: redefinition of 'drm_client_setup_with_fourcc'
      55 | void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc)
         |      ^
   include/drm/drm_client_setup.h:19:20: note: previous definition is here
      19 | static inline void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc)
         |                    ^
   drivers/gpu/drm/drm_client_setup.c:72:6: error: redefinition of 'drm_client_setup_with_color_mode'
      72 | void drm_client_setup_with_color_mode(struct drm_device *dev, unsigned int color_mode)
         |      ^
   include/drm/drm_client_setup.h:21:20: note: previous definition is here
      21 | static inline void drm_client_setup_with_color_mode(struct drm_device *dev,
         |                    ^
   5 errors generated.


vim +/CONFIG_DRM_CLIENT_DEFAULT +11 drivers/gpu/drm/drm_client_setup.c

    10	
  > 11	static char drm_client_default[16] = CONFIG_DRM_CLIENT_DEFAULT;
    12	module_param_string(client, drm_client_default, sizeof(drm_client_default), 0444);
    13	MODULE_PARM_DESC(client,
    14			 "Choose which drm client to start, default is"
  > 15			 CONFIG_DRM_CLIENT_DEFAULT "]");
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

