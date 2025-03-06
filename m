Return-Path: <linux-kernel+bounces-548979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715EEA54BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CE13AB561
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8D20CCD6;
	Thu,  6 Mar 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3EmzpYc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB02481CD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266763; cv=none; b=HjWFB58vXi10sLs10QUjRU7VFIXWhU35uPp9JE7xphWbV+2UBcPj1j6NCpn2K7gPqlcIkoWVUHF7awhj/EyEQRM3leO3lcb4nTkxOWKlkPF1rupsbpC1yqV1vRBDKzGngNVNOOaiKuev3+WXgrbkwV4xXcIw95JbJsIjKp6JLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266763; c=relaxed/simple;
	bh=kD0+DAAqaOpRalTEvEv3LkIwBg3q4DkH1TTKWRYyGa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNbV3ATYqWcr7Pej/VHk6YTzB2td+Mq+EggqvGAS+uEH/OxC0MW0mpuThtD+PGx7wVIgkfRdvoigChEATUVljvompub777Jwjy784WPBcSfIg78kzqYOs4k9Xq4IMi7k27ve4uh5rt/2AU0nLY+11ONbeua/Le0uXjsH2b2Xd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3EmzpYc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741266762; x=1772802762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kD0+DAAqaOpRalTEvEv3LkIwBg3q4DkH1TTKWRYyGa8=;
  b=M3EmzpYclxijT0ZBga7yBcP5jwFaYBUP5E1OOKe6Vl+wefMWh39pwklP
   Tue5NKZm72G9Ts+UsdRPs3OxL0aNSOxH/45XFURrIeoDMWv/HTWBz+BVI
   v63g9RDB3LEfLvy7BapvV3dV9jYePPDeicj4vW0Z3y/w18eo5o2jiXoAe
   zoIkPPlHiWhRef5Cu5BQA6xxnUqOJt0O9tpnFkxohFVqY+hg4sV9NwmSc
   0+OV0VEO+e30oO7NPUhspRfoR4a3BU/7Se2EaWdu2DwHYEP2lbB1u66/r
   H2irTTC/mc5vRrN53tx7Ntn9eA7DI+2Ezio+rqD5dsLiRxI0XB5fkAeid
   w==;
X-CSE-ConnectionGUID: LH5GL4PCR4CFsVKQd0RKCw==
X-CSE-MsgGUID: UhZ9qhUiTBWpxZA9Ao1Kuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46043308"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="46043308"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:12:40 -0800
X-CSE-ConnectionGUID: +E/rE1M9SrukXMZwIvHJaw==
X-CSE-MsgGUID: ibkmCI4tQE2yVKV/WhaO0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="123975000"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:12:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqB1d-000000007jv-2Mea;
	Thu, 06 Mar 2025 15:12:33 +0200
Date: Thu, 6 Mar 2025 15:12:33 +0200
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
Subject: Re: [PATCH v5 0/7] bits: Fixed-type GENMASK()/BIT()
Message-ID: <Z8mfQVP6AkFIxYcY@smile.fi.intel.com>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 08:29:51PM +0900, Vincent Mailhol via B4 Relay wrote:
> Introduce some fixed width variant of the GENMASK() and the BIT()
> macros in bits.h. Note that the main goal is not to get the correct
> type, but rather to enforce more checks at compile time. For example:
> 
>   GENMASK_U16(16, 0)
> 
> will raise a build bug.

This version LGTM, just a couple of comments that you may find
in the individual replies.

-- 
With Best Regards,
Andy Shevchenko



