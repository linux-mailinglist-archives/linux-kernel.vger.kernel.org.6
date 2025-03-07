Return-Path: <linux-kernel+bounces-551709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5172A56FBC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4ADD188EB2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04E242909;
	Fri,  7 Mar 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2zU5XoQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F065241679
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370062; cv=none; b=g6bBjeyu1dnAgbeviiT8YAy8Ki30RTUWIIMuQVXA/x+5bO3dgoQCHsZ/3J9/2ULQeWaa2hBDZtdY/1lIr3h8yPoUP7flafF0oPqmB38YOhkSYrXyAr9Rgou3Zf1rXOKTwEopXRzMmWH4XdcSceMBmBShV+zdmxtLN45IVUkj4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370062; c=relaxed/simple;
	bh=XCkRz2C+VBAY5TEjrnuDs2evKJARDhM5uRMblUwUFRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4qaQWxfLFzx9vvUyTuI2VcPnjBSYwwQoNTXz14fSdX0lCnZIzCgi4v1jmrbXOmn6GzCck9g7PxWiNToBAN5WYr+ZhdnAZPZTzMEInR59ugBr+p0ERdOZ5De69G2E/sikeTGq+vgL9Zfw1yd0Earg4cjWOnfph1bg+3qYAy/jGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2zU5XoQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741370061; x=1772906061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XCkRz2C+VBAY5TEjrnuDs2evKJARDhM5uRMblUwUFRY=;
  b=f2zU5XoQrMqCR5fBC/AgQK+bF6lYB5OQf4ZeMxtu4XFiK9P3pue+J2M/
   87k1cjPHaTZuxPAKpFQ2JhFg7/rEXqxmvMR0EaSZIHVxTLUOQ5GRCOzs3
   dTCYhN3r59Mp4ZAcIQtcLeC8Tw+zCrvyyR/4iuo7H4yRg1PxIcqY/n8+G
   dAWbZZGBEAw23MpJsyAVfO0DnksjjFCSm51IlYjJJYKCqHibyqnUZqQNy
   K37O95iPpB+dSK13Rb/LaKQd8g4WHHUiGYV4wZ3OSKuIrAZTRM8r9l7jR
   oNdNvyH8igsZ288rkTb6U8jSLJXClaWWhBDSq/58JVJnh/OQyd2AQkh/Y
   g==;
X-CSE-ConnectionGUID: V/5A/6R3ScWY6kfhiuwlxQ==
X-CSE-MsgGUID: 5EbznmLbQmGYZ5+tOEGyZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42307743"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42307743"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:54:19 -0800
X-CSE-ConnectionGUID: DTM8c2/QTWaTIKSAZno2rw==
X-CSE-MsgGUID: Y9fGCcfnRUufYjv0QwQAbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123577284"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:54:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqbtk-00000000TeE-0Vfq;
	Fri, 07 Mar 2025 19:54:12 +0200
Date: Fri, 7 Mar 2025 19:54:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mailhol.vincent@wanadoo.fr
Cc: Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v6 4/7] drm/i915: Convert REG_GENMASK*() to fixed-width
 GENMASK_U*()
Message-ID: <Z8syw47cN0eEW7lO@smile.fi.intel.com>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-4-f59315e73c29@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308-fixed-type-genmasks-v6-4-f59315e73c29@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 08, 2025 at 01:48:51AM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Now that include/linux/bits.h implements fixed-width GENMASK_U*(), use
> them to implement the i915/xe specific macros. Converting each driver
> to use the generic macros are left for later, when/if other
> driver-specific macros are also generalized.

...

> +/*
> + * Wrappers over the generic BIT_* and GENMASK_* implementations,

BIT_U*(), GENMASK_U*() as far as I can see.

Also "...generic fixed-width...".

> + * for compatibility reasons with previous implementation
>   */

-- 
With Best Regards,
Andy Shevchenko



