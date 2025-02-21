Return-Path: <linux-kernel+bounces-526143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE87A3FA9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21C1166C48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3271F2365;
	Fri, 21 Feb 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8I2+nAu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBE1DA612
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154072; cv=none; b=s9zj0sMk30qFEOO2uDc/QCjoJ9jySZvLk685apNFGtle6pOZmLXwnOTyUa51UFcSOH/Sf26u0FZO9zPr6gostPIpKgBqj8yHWnbWXqT/2Q+jbmee02oM67CgEPf0h5P9jUxQFUAUMpDXh70rpP/VjNsRBPsY/z4g5g/K54SvnGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154072; c=relaxed/simple;
	bh=y5JhGk6+y/UVmyY9PqhauCRFg3xwKvQSWW03fAoWreI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0GmgLVpBSWtL5O26pK90WpHy+SiDbwDtrpYlj5Bsvtz6i9lX7ZGmrq00YIl85X4hpWNETIJvlRj/ZChSYvuRmqvgszKyCUKU/oSBz96hfDr7VGNtYHXfc5gSaAJSKXuXrU7FaxfoMBcQmM5Bkj5sHMxUgwqKtHJ4pLpwHWxAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8I2+nAu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740154071; x=1771690071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y5JhGk6+y/UVmyY9PqhauCRFg3xwKvQSWW03fAoWreI=;
  b=B8I2+nAuqzxfr3FP4bPdkBeSuLj7QGY7Lod3ClJe0cd+ioGDUgcZQz7J
   TTkeboxPwRlTLQC29U7AlcW6GSA+MSMQHluWIQe3dnEOhHtjr1qCNoPSF
   MbK+xgu5SD4y/cA4yDA2k5B7/lOfD74XTS7o9WGNwUTXj2f923wWUdPHg
   bzXMnCQoOQfonqW+uk45rs5ycPJszp0Jel73bi9bK+ZVV7/6jUpkPETRd
   8cq2hpnl7c5BEMh6aVXIPAfA1cvpw0M4at4pxGWdPY8vy8wFcplkrETVW
   PvlD1febtwhDH9+S5xqb+1JsBHOApt2i+IQR7xmDei1uKk+C0w0pxyfa9
   g==;
X-CSE-ConnectionGUID: 25EkE+iOTH+i45V0QcIS8Q==
X-CSE-MsgGUID: qkqWM500SoW1SdBaN+yzZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44892225"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="44892225"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:07:50 -0800
X-CSE-ConnectionGUID: cfC2HSiJSmy16Dk7sQ8oGg==
X-CSE-MsgGUID: J7IerKaiSvub47CRnDOKNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120384991"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:07:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tlVZ3-0000000Dgc2-1KOk;
	Fri, 21 Feb 2025 18:07:45 +0200
Date: Fri, 21 Feb 2025 18:07:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, arnd@arndb.de,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] io.h: drop unused headers
Message-ID: <Z7ik0etxGlj3QKOa@smile.fi.intel.com>
References: <20250220173305.2752125-1-raag.jadav@intel.com>
 <202502211009.s6xoWtae-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502211009.s6xoWtae-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 21, 2025 at 10:52:12AM +0800, kernel test robot wrote:
> Hi Raag,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on b16e9f8547a328b19af59afc213ce323124d11e9]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/io-h-drop-unused-headers/20250221-013530
> base:   b16e9f8547a328b19af59afc213ce323124d11e9
> patch link:    https://lore.kernel.org/r/20250220173305.2752125-1-raag.jadav%40intel.com
> patch subject: [PATCH v1] io.h: drop unused headers
> config: sparc-randconfig-001-20250221 (https://download.01.org/0day-ci/archive/20250221/202502211009.s6xoWtae-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502211009.s6xoWtae-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502211009.s6xoWtae-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/gpu/drm/drm_draw.c: In function 'drm_draw_color_from_xrgb8888':
> >> drivers/gpu/drm/drm_draw.c:130:17: error: implicit declaration of function 'WARN_ONCE' [-Wimplicit-function-declaration]
>      130 |                 WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
>          |                 ^~~~~~~~~

dwm_draw.c misses linux/bug.h.

Raag, please add it to your patch. But let's wait at least a week that CIs can
collect more issues, if any, along with people, who want to test this change.

-- 
With Best Regards,
Andy Shevchenko



