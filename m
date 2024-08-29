Return-Path: <linux-kernel+bounces-307342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CFF964C23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5A92818EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646E31B5EB4;
	Thu, 29 Aug 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyY1mOW+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288111B151C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950422; cv=none; b=oMbD2hxQY8k/37xV19hfXkjJ5EplWBX0ylDwno3SHxU1GYPNsv2ImuUhkHu164c/77Sh+Dx1/b+SydEsHd55C0Q/FI/ggO9qCDmwan3GUlc+zR7zOmqLCKP8o3OYDyi1o6bdczdLfk4hgQ/qdefjc5i+UiCeAzpOtvw+kBpW1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950422; c=relaxed/simple;
	bh=tY/o2qCVFTpCmNogacGCPMgnl7k/juPKBpptAW+kEro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE482DjBf6VMPxv70gezNFZTC1Ps0tBgtIUJ5mnpHi8pGIziOMKXy+EnKnSjbLl6grWmRNovzd1okSJXqEG0zxuaoeDkWmRU1Nl0PiSDFPDUS8/vD0q4iweuIQfOftLt0tKMtCITWmIHNW0mjN+ZdNjJnWSxxIvRXcttiv6qZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyY1mOW+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724950422; x=1756486422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tY/o2qCVFTpCmNogacGCPMgnl7k/juPKBpptAW+kEro=;
  b=AyY1mOW+Ch/TWNeH6pfAhUY1PhBNUqN7sMNUj5hyUBBNXS2oN2yFCrKX
   PsDykLvUHiq2LGVeSaaD/W3JdTk8BnI56wpm28dYBtGQXlapDeLHrQSal
   vyesn/MePBkEYxTYy4kx5ZNUyTTV+8bFwMAqC6hutlXWxwTUbEdoAPiNw
   oTOh68i05Eb6a+jXgrBsTdqSHNXecFOY+0Ewy1dB+CJYOz5ho79AglLeo
   l3w4gw5vQRmdhhpW//qoviwBagq/W/0xxWl+EPyJwkalAFiE6PuSy5mDp
   ZHtaRYFocRNJJR9JjsQGIg9hDUizM1lb9I8an1CEAOiTvcediyEo1/v4n
   w==;
X-CSE-ConnectionGUID: 4KZAfruPRQ2I5ZQdwMFyZQ==
X-CSE-MsgGUID: WBq1PawQRNaG1T1KLTJlCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34724799"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34724799"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:53:41 -0700
X-CSE-ConnectionGUID: ZD7ABZXYRYma/n7J+jff7A==
X-CSE-MsgGUID: OzuePKLiTMK+BgiEPTDWTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68307889"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:53:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjiOj-000000035Jl-2374;
	Thu, 29 Aug 2024 19:53:25 +0300
Date: Thu, 29 Aug 2024 19:53:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/2] drm/i915/fence: A couple of build fixes
Message-ID: <ZtCnhXwtO-gd1fMf@smile.fi.intel.com>
References: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
 <87cylrwahb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cylrwahb.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 29, 2024 at 07:38:08PM +0300, Jani Nikula wrote:
> On Thu, 29 Aug 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > With CONFIG_WERROR=y and `make W=1` build fails on my x86_64 machine.
> > This is due to some unused functions. Hence these quick fixes.
> 
> Since when have we been getting the warnings for static inlines?

Do you want to see any additional information of my building environment?

Debian clang version 18.1.8 (9)

-- 
With Best Regards,
Andy Shevchenko



