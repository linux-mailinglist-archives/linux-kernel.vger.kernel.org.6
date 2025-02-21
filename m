Return-Path: <linux-kernel+bounces-526157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764AEA3FB43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F27E8678EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657281F1932;
	Fri, 21 Feb 2025 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UW/3qSXe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E421E282D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154262; cv=none; b=l5HU6lVeLG8VMn1z/hZg8ahb2lfpN2wdj3EZla8jhSC53t0Y+2eqhJ+gcQRmMwANkWAWV3H8pMDnPrf7kkpgwHIsSbFJS8ZqQdElEtR1TkKhuqiEJ3yB71tzOZZU7PGdBS+XfNdHHCJQpS7w4XkQX8JRScor+kKcoLqFXbl+Hq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154262; c=relaxed/simple;
	bh=KRjsAT5DUOpWHkO4tSIDUkdRch527sPbLWMDBLFtJyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf3HuoNSFVtHsbWSEDJ9nWcg1YRiLzTX/y6tTPVAkS6U5AsFGsebEqqxiC0glE7OoRq3by1Nxdim+FIIRNhL9PVNFrWa1npZkdJ5n2RmbFuUty5Ucr7SlzgKxvbdY6e6VjNBtZsbfOW0hgqMOJ1x7dtdRZqDPpjaKFf1Uks0qbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UW/3qSXe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740154261; x=1771690261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KRjsAT5DUOpWHkO4tSIDUkdRch527sPbLWMDBLFtJyA=;
  b=UW/3qSXecWXxHcbd71HU6keyyVOdSdRWyNjLx7SGtVHP75YgrP/lgmDH
   A0UDJE0XTCaRHl+tW8CmALWLNx96n+OwNX49/bjKZ3+9XOgh0UuPTf6Ff
   HbudjEY0Ba6LjdZRE4W5sCpP/kDvkKaHshRCKtdMWvopifGlmkhOPIhGa
   DdGw5H814mecH1JaSsCdtVyhxTI6IBclb4ue4KmvpKyKfTazpETAHAjpC
   YOJ8CW8Q8SWvHqrtorHdLYHxR2Iq03A7V/MCJaUB/76BJbs4MM1nJFps5
   9w2OvA4B3fGRQolkOmaQx+ysqrzKRqSPShSivC4Wt4NK+Dp4Tn710+og4
   w==;
X-CSE-ConnectionGUID: 6WF1l1yITLqWMeAOscS31Q==
X-CSE-MsgGUID: 0Vl0+A3NQmS98ZspCAxezg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="58388059"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="58388059"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:11:01 -0800
X-CSE-ConnectionGUID: S8BT3XOQRLKjH6e3xlYVOQ==
X-CSE-MsgGUID: HjAahuYcQI+inxqd0Oaetg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120644962"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:11:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tlVc8-0000000DgeM-2vfg;
	Fri, 21 Feb 2025 18:10:56 +0200
Date: Fri, 21 Feb 2025 18:10:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, arnd@arndb.de,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] io.h: drop unused headers
Message-ID: <Z7ilkKt1waKJuZPi@smile.fi.intel.com>
References: <20250220173305.2752125-1-raag.jadav@intel.com>
 <202502211137.IRE8qrlR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502211137.IRE8qrlR-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 21, 2025 at 11:22:38AM +0800, kernel test robot wrote:
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
> config: nios2-randconfig-001-20250221 (https://download.01.org/0day-ci/archive/20250221/202502211137.IRE8qrlR-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502211137.IRE8qrlR-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502211137.IRE8qrlR-lkp@intel.com/

...

>    drivers/gpu/drm/drm_draw.c: At top level:
> >> drivers/gpu/drm/drm_draw.c:134:1: warning: data definition has no type or storage class
>      134 | EXPORT_SYMBOL(drm_draw_color_from_xrgb8888);
>          | ^~~~~~~~~~~~~
> >> drivers/gpu/drm/drm_draw.c:134:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
> >> drivers/gpu/drm/drm_draw.c:134:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
>    drivers/gpu/drm/drm_draw.c:151:1: warning: data definition has no type or storage class
>      151 | EXPORT_SYMBOL(drm_draw_blit16);
>          | ^~~~~~~~~~~~~

I haven't looked deeply into this, but it might be the export.h is missing
or it's just a followup of missing bug.h. In any case the io.h patch needs
a prerequisite for dwm_draw.c to eliminate usage of "proxy" headers and follow
IWYU principle. So, it will become a series of two. But as I said before,
let's wait a bit longer.

-- 
With Best Regards,
Andy Shevchenko



