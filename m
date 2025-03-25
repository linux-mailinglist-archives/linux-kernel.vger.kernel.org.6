Return-Path: <linux-kernel+bounces-575759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92760A706EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D322916797E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB2925D1E2;
	Tue, 25 Mar 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBEG6cXX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66525BAA9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920051; cv=none; b=RdVZ0ot6F2eGHows/TlT+7ZNNLuND2xR0nx2YJ87/7yvj683FTjrcCebrhUGuLwUXAVRRA7WXxBzOXtuF6z2Hw9SV/rhNSzZgNlXLEogaITmPNKHJnQKXUltXDaUSw7YUGz0O5IcUyDKXu/957lnPNz7e2hQoQnG6h1yqLTWVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920051; c=relaxed/simple;
	bh=DXYLHXiwzIcA/Bj/2td4YqOe2oymYE7jS6LyMPCk+S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/mUDgf1Ayffs+Y3DdBaP9SUZD8O4iWIHgCqI6ehf9mQ2c8djtGWnbk8m0RiF70kZ0733+b4r6pYBclzuEtDsj2+SC3dceomRdCwrU2sxbB6KiP3QfNx8m77wV+He0H8Z2DoXrjxG58wcnXGmWKAgLnk2HCmwBUF7Q94WkfRklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBEG6cXX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742920050; x=1774456050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DXYLHXiwzIcA/Bj/2td4YqOe2oymYE7jS6LyMPCk+S8=;
  b=IBEG6cXXkrIfdq/0LE8HYuOdRKZ/iibsQzRmFa6mSfqr6Fp0XvZBG4xC
   uz28Pv46/83BXDn952k6fZxZBRnpc5wcc1evjs4/BVOu2BADuifsjxAos
   aoxzfaMNtcK4HsvOQ6NZyy5SmwcM5FPq0kOzsSShA0VZdVZ50TXj6dqOY
   hpdAdm2y7fYul58Ru4JJPq8Pun9qVY9L8xtGmslQwbP5nq3WOQRG62ddI
   zxT597p7nF5ZOujcxmO4ye2r3BXqNGX+q3UQmjw3v7x5e9kY7PWbu0REz
   q7HIOKW9uTJ2C7UovFN0Y6DmuL8uXA70El0g7zT5+MBQ6i2RRNsEHbkau
   w==;
X-CSE-ConnectionGUID: ilmEHJkaRIWMOzqbc0uSXg==
X-CSE-MsgGUID: nsDr4sSlQFC1Fx6W8FRIAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61570261"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="61570261"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:27:29 -0700
X-CSE-ConnectionGUID: yll9APRVQx63HH74bLC0Wg==
X-CSE-MsgGUID: nY7nGxCqQyGk0UZVVRoCUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="125221710"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:27:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tx77Z-00000005nlV-1ZAR;
	Tue, 25 Mar 2025 18:27:21 +0200
Date: Tue, 25 Mar 2025 18:27:21 +0200
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v8 3/6] bits: introduce fixed-type BIT_U*()
Message-ID: <Z-LZaSEO0jGw_Q-y@smile.fi.intel.com>
References: <20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr>
 <20250326-fixed-type-genmasks-v8-3-24afed16ca00@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-fixed-type-genmasks-v8-3-24afed16ca00@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 12:59:58AM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Implement fixed-type BIT_U*() to help drivers add stricter checks,
> like it was done for GENMASK_U*().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



