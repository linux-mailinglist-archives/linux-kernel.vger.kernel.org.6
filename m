Return-Path: <linux-kernel+bounces-536035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E6A47AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FDC16937E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F422A4F7;
	Thu, 27 Feb 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGjukulC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F33D229B3D;
	Thu, 27 Feb 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653261; cv=none; b=e8AlFY1/GjHW4gpfBq6ZT+lBqsXXR2F/aJGWOY8TE5kLEuu+7TOxo83GMrNPAer1uhm1mG9d4eR22VdN5F1KRMg1Cmnur7z9UlJsntiRWlLm2k7mvpMX3rGt4kqTdytmVL1MPv1bV3llXvU7TX0XQQqQU6JnAhXocnSt4SBH4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653261; c=relaxed/simple;
	bh=faKqbIo9ohlJImOLrrHIkwjNGaccf93VmOWvmUtLnEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tmpx/s/LvifIyLVb7Vm+rKOnxcbsR9xnGFBx7yaJV3W1NYoUsf1e/7lhZKqZg2ZcAvqpkKDErwH3VX7ccCbh3pyeiui1PTCOp9dS2Hd06DYMdIBBwwplj/vVzN/3lt0pXA9LPfUEw+XZWYSULxE6e/yFHgr6XANhJ+Gp0KItWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGjukulC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740653259; x=1772189259;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=faKqbIo9ohlJImOLrrHIkwjNGaccf93VmOWvmUtLnEg=;
  b=mGjukulC12kfBa9ndhjDjW010/RoXnaVQEOm5pppIOocBuWlnJowZXse
   Y314WbFj+iemWaVmuIeON0Um44fXxhjHS4DzjEjKd8KZRZH++U+TtfeKW
   J5l85X+KoXOVBxTKm/yUsbrGY0RcgeQa4SD3vSVRFp4oCrccLZZvBjmIo
   w8ChHiRfk0u7woUnr/m1/c5Ylz7+Lm3sFAGNKAUzWM2p98jut4GhuAn3x
   vYsmQxQ/CcG4wLvoIcZ2kOd72WcJ2KhM5c+iwhxgGySH7yky8S+qiihM1
   xuBzNdFN81QUpzpgShkq8lIUca0Ys+913T8OYK3unAVX4XEqGQRuVXKEW
   w==;
X-CSE-ConnectionGUID: a8bFODgTTBCipZuva2/s1g==
X-CSE-MsgGUID: PrzB74eyQZalYvft8dGFJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41663449"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41663449"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 02:47:39 -0800
X-CSE-ConnectionGUID: bDl6Q4biRAisW1awg+BeNw==
X-CSE-MsgGUID: 9yUe7WxTQ2u7KZi8apzAAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116783370"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.181])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 02:47:33 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Su Hui <suhui@nfschina.com>, lucas.demarchi@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: Su Hui <suhui@nfschina.com>, ilpo.jarvinen@linux.intel.com,
 andriy.shevchenko@linux.intel.com, michael.j.ruhl@intel.com,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/xe: Select INTEL_VSEC to fix build dependency
In-Reply-To: <20250227073205.1248282-1-suhui@nfschina.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250227073205.1248282-1-suhui@nfschina.com>
Date: Thu, 27 Feb 2025 12:47:28 +0200
Message-ID: <87senz3br3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 27 Feb 2025, Su Hui <suhui@nfschina.com> wrote:
> When build randconfig, there is an error:
> ld: drivers/gpu/drm/xe/xe_vsec.o: in function `xe_vsec_init':
> xe_vsec.c:(.text+0x182): undefined reference to `intel_vsec_register'
>
> When CONFIG_DRM_XE=y and CONFIG_INTEL_VSEC=m is set, ld couldn't find
> 'intel_vsec_register'. Select INTEL_VSEC to fix this error.

Documentation/kbuild/kconfig-language.rst:

  Note:
	select should be used with care. select will force
	a symbol to a value without visiting the dependencies.
	By abusing select you are able to select a symbol FOO even
	if FOO depends on BAR that is not set.
	In general use select only for non-visible symbols
	(no prompts anywhere) and for symbols with no dependencies.
	That will limit the usefulness but on the other hand avoid
	the illegal configurations all over.

This should likely be either

	depends on INTEL_VSEC || INTEL_VSEC=n

or

	depends on INTEL_VSEC


BR,
Jani.



>
> Fixes: 0c45e76fcc62 ("drm/xe/vsec: Support BMG devices")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/gpu/drm/xe/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index b51a2bde73e2..7a60d96d2dd6 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -44,6 +44,7 @@ config DRM_XE
>  	select WANT_DEV_COREDUMP
>  	select AUXILIARY_BUS
>  	select HMM_MIRROR
> +	select INTEL_VSEC
>  	help
>  	  Experimental driver for Intel Xe series GPUs

-- 
Jani Nikula, Intel

