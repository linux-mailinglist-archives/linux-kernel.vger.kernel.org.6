Return-Path: <linux-kernel+bounces-281153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D248294D3B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F3D1F22ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344481990A7;
	Fri,  9 Aug 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9koeSnB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C5198E9E;
	Fri,  9 Aug 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217769; cv=none; b=F10jQ7J2es9u+6bsYyr+pxZkhQLrcFm7muGsArfhRhmIyccvTfdFNjv+YlZJwPrCsWENU1sffY08AlBYE73ScmyInMaZ/V+7tduty31brd6WNUdpWtq9u2UwFrt9yuOjtWtqpq1nozSeq4FrpxRb1pB8L75U88zist6hBNuYd3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217769; c=relaxed/simple;
	bh=XKjRCrFGN0RVKhg16Q7VjOrhB2ff2JpGqpBwndpZaY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQGD2ilUHctjOLGGipI8qBwy0JbzxTrguTPiV/F6e+BffLYXLeGrkLWT4fshWmUU6zTQAIQHOAqY6ww93lfiZEW3M37ypnm7P1MUTL3wW+BAFkqi7J2zVkI/o9XpAee3G0gYwaDZfx/T/zLxsnF3DVeROSZ1zWEMkaccn41TVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9koeSnB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723217768; x=1754753768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XKjRCrFGN0RVKhg16Q7VjOrhB2ff2JpGqpBwndpZaY8=;
  b=g9koeSnB4cLcbXdqihhDrLJJvxpdn20c+wla2vwcldnxSNd36EOl8Xym
   98SVQTm9EEuqDWd0eCbCdHMo4wcqDoi/K0PqT1Vl9dKDK69G5NFKrsje6
   pUdV5aGtY8GANnOq7+2wQ/2wgB8qKErKgEpXPcnPI6Jy/k6g+qyGtibh9
   GT9Sd6Ur3YeKyz5Md31lP0Y/eiin/IXvE+7WVER2baf+/q7RmhbOeCg7E
   h49g1st6iY4qTlw5NjA8uTqcW/1VrvT4zmeuOdaDxh0odR5JnK+kBZv3e
   w8o4RvVjppyiVhdlrws4iMKlQmu3b2pFozrW+ouG6Y3mgk/4CqZwVPdT1
   w==;
X-CSE-ConnectionGUID: NA7BSn8RSveV6KyEajy7RA==
X-CSE-MsgGUID: PYhHkLqnTOmqb7IK2DPu+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21371407"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21371407"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:36:07 -0700
X-CSE-ConnectionGUID: rCcCV99ERYaSNjnNtrctYQ==
X-CSE-MsgGUID: D+/jrABGTjqg89dutHRqOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="62549899"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:36:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scRer-0000000DSVV-1vrv;
	Fri, 09 Aug 2024 18:36:01 +0300
Date: Fri, 9 Aug 2024 18:36:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	ckeepax@opensource.cirrus.com, heiko@sntech.de, robh@kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH] ASoC: ak4458: remove "reset-gpios" property handler
Message-ID: <ZrY3YZrvsua5DErC@smile.fi.intel.com>
References: <1720009575-11677-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720009575-11677-1-git-send-email-shengjiu.wang@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jul 03, 2024 at 08:26:15PM +0800, Shengjiu Wang wrote:
> commit c721f189e89c0 ("reset: Instantiate reset GPIO controller for
> shared reset-gpios") check if there is no "resets" property
> will fallback to "reset-gpios".
> 
> So don't need to handle "reset-gpios" separately in the driver,
> the "reset-gpios" handler is duplicated with "resets" control handler,
> remove it.

...

> -	if (ak4458->reset_gpiod) {
> -		gpiod_set_value_cansleep(ak4458->reset_gpiod, active);
> -		usleep_range(1000, 2000);
> -	} else if (!IS_ERR_OR_NULL(ak4458->reset)) {
> +	if (!IS_ERR_OR_NULL(ak4458->reset)) {

_OR_NULL is redundant.

>  		if (active)
>  			reset_control_assert(ak4458->reset);
>  		else

-- 
With Best Regards,
Andy Shevchenko



