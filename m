Return-Path: <linux-kernel+bounces-366616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 466E699F7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76371F21A93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887FF1F76D2;
	Tue, 15 Oct 2024 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyBEIiwk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9D1B6D04
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022754; cv=none; b=qqmBXfjFCDr3qZuQRDwRKMZHKkosGojq4090qrR9KIAvvx4hlqHr6w4VJ8NLLJPfwtlORuhL+83ZU1qWpogEP9kMk8csY54gCA0G1mvG3Uo7s5ecAmOKwgtgN1yw3boppBvvty1NBbWaQ9tpXb5e/IkxJwYPIG6NcwIb82AwC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022754; c=relaxed/simple;
	bh=dX1g8jSzU+VXezh2f98dU2JeKi1rg/GRDajYDlMn9PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COehGr+ZOJW75KlVrM4YkmDPQo+j8Y/PJcDBQevaXvqDHTDaGcQ1H+HoPlXjz7UFT4ZCG6tOfCVQgx7BHRxlcwGb3wzJ2Eps3GcoPrQpPrFjAS0JLiIoiJNcotr0cvAkmyDpOazhTRDk7W1EInKmRJ2WgiHh7YeVkUTIrg0PYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyBEIiwk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729022753; x=1760558753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dX1g8jSzU+VXezh2f98dU2JeKi1rg/GRDajYDlMn9PA=;
  b=kyBEIiwkuTAHgmg6rXTYqyu4BbI4q/dFHfQosAAicdlDuvwOlrYuHZhw
   6ydt2oq8d5HCWaiNpggATBcttWn4j8uFUSvtMgrmTP2UlLcPrSXptYSS9
   SnOlAH5DgmPewQJCYziPdMpSLvJ3sltZ7TQvLho+AilR83Qh8zguw+MBK
   jTLYkWnZoth+iPnG8rfFYG5nEV91WSUSoRoHoGPTKh6QTd/vZHquw5cbI
   x3OnXzwo4QZTFmqDspPH/spIucWVMao6bXezYtLgfyrc9V45fiyStFUdc
   if+cetfGacEJ7xxc5z3piREZVTAnavIRZtV5mN66nHtPEMY9ETcz+8nYZ
   Q==;
X-CSE-ConnectionGUID: xl9n+s61TXuk5JzpdRfRSQ==
X-CSE-MsgGUID: zj33EzHlRg6R+ToaOtMlsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28230128"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28230128"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 13:05:52 -0700
X-CSE-ConnectionGUID: 1C/qME2AT76iW7Hx1up+UA==
X-CSE-MsgGUID: bI9P401BTACr5r2atWDXUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78834721"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Oct 2024 13:05:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0nnd-000JsT-2V;
	Tue, 15 Oct 2024 20:05:45 +0000
Date: Wed, 16 Oct 2024 04:05:02 +0800
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
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v4 3/7] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
Message-ID: <202410160342.rkkekxWK-lkp@intel.com>
References: <20241011105526.615812-4-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011105526.615812-4-jfalempe@redhat.com>

Hi Jocelyn,

kernel test robot noticed the following build errors:

[auto build test ERROR on 33c255312660653cf54f8019896b5dca28e3c580]

url:    https://github.com/intel-lab-lkp/linux/commits/Jocelyn-Falempe/drm-client-squash-of-drm-client-pending-series/20241011-225715
base:   33c255312660653cf54f8019896b5dca28e3c580
patch link:    https://lore.kernel.org/r/20241011105526.615812-4-jfalempe%40redhat.com
patch subject: [PATCH v4 3/7] drm/log: Introduce a new boot logger to draw the kmsg on the screen
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20241016/202410160342.rkkekxWK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410160342.rkkekxWK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410160342.rkkekxWK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/drm_log.c:347:6: error: redefinition of 'drm_log_register'
     347 | void drm_log_register(struct drm_device *dev)
         |      ^~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/drm_log.c:21:
   drivers/gpu/drm/drm_log.h:8:20: note: previous definition of 'drm_log_register' with type 'void(struct drm_device *)'
       8 | static inline void drm_log_register(struct drm_device *dev) {}
         |                    ^~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=n] || GCC_PLUGINS [=y]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/drm_log_register +347 drivers/gpu/drm/drm_log.c

   342	
   343	/**
   344	 * drm_log_register() - Register a drm device to drm_log
   345	 * @dev: the drm device to register.
   346	 */
 > 347	void drm_log_register(struct drm_device *dev)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

