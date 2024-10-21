Return-Path: <linux-kernel+bounces-373886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB559A5E76
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7D6B21B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FA61E1C27;
	Mon, 21 Oct 2024 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8b9hxgd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54F1E1C19;
	Mon, 21 Oct 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498791; cv=none; b=aQOuhicSTjkKu6Qub0sudyhRgfGlXseZiCk9zRs3Md7ancBVsMXVaC84Oxxzz9Yg617WzNVz56vZgfF6oBKH6qJlWxWuDJXKhALVecBN6dTyfXS+eIMTB7iCXEQGEMy21IElTNEs4YduDVP3Ou91X1O4lKPc1M++J6PsOj/mEd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498791; c=relaxed/simple;
	bh=zlmRWwuTPMFj9WwZa+0qdZTSrOAPHiyed6f5Pgikw10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ3Z8E5h+ALFOlv7QSipuzkMDo8dbpzYza6VqgZbLAVBNcRXs8YCgy+L0bMaxVKsuhsyWJPAxhwawbZYD1kb49sLUw7jyC4i9wiT7jj0U84ZzAPsgxzuH1EEP2O9sg5cGJo8g0O6tXt1AwjPu0YV6KjU+zneNmAuRRnPTCCYlqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8b9hxgd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729498790; x=1761034790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zlmRWwuTPMFj9WwZa+0qdZTSrOAPHiyed6f5Pgikw10=;
  b=W8b9hxgdWWEXs1VStqWhjOGLTtdnMUjqla3q6su3hHTJpqaBj1iKif3F
   sGbn1nuaU5H+qv8Hhma3w+CBY3Ckoxuykaz4MFWBbrqxJd8sepimGimPC
   ph+WrWZhOQ5Lg0IWWwnr3Fpj49megwJNiJIEF2QRV9o4rbmIymaFKQZrU
   diGGn4qfMT13oCa2PdunVacy10uQ9XRyV9DyqISJbO00WSA8Zm4endsTp
   FcYDO+yhjh3nGY7vsTdMqv3VpmoOcgAPDxyckC4ogTHQ3ZcLsGMKSbCb7
   m+AlBeFOqDnUJZ/PF2U2HqEDFXjIQzSMGEE/Zk2RZPGYzt3VskHkNu4fA
   A==;
X-CSE-ConnectionGUID: zZF0O7lZSLqzRA4FlErQ9A==
X-CSE-MsgGUID: R3/4BvKrQq6Ooge0ZjxGWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46436265"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46436265"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:19:50 -0700
X-CSE-ConnectionGUID: EWBVwNPaTIOCftOgIlaSOQ==
X-CSE-MsgGUID: 54dYTpVHQe68Xwai9pjvnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="83448319"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:19:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2nde-00000005QKp-24KK;
	Mon, 21 Oct 2024 11:19:42 +0300
Date: Mon, 21 Oct 2024 11:19:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Baojun Xu <baojun.xu@ti.com>, robh+dt@kernel.org, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	shenghao-ding@ti.com, navada@ti.com, 13916275206@139.com,
	v-hampiholi@ti.com, v-po@ti.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org,
	antheas.dk@gmail.com
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Add speaker id check for ASUS
 projects
Message-ID: <ZxYOnqRue6zpaWl8@smile.fi.intel.com>
References: <20241018071118.3298-1-baojun.xu@ti.com>
 <ZxJVCb13lQ4h2KRD@smile.fi.intel.com>
 <8734kpkjns.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734kpkjns.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 21, 2024 at 09:19:19AM +0200, Takashi Iwai wrote:
> On Fri, 18 Oct 2024 14:31:05 +0200,
> Andy Shevchenko wrote:
> > On Fri, Oct 18, 2024 at 03:11:18PM +0800, Baojun Xu wrote:

...

> > > +			// Speaker id is not valid, use default.
> > > +			dev_dbg(tas_priv->dev, "Wrong spk_id = %d\n", spk_id);
> > > +			spk_id = 0;
> > > +		}
> > > +		scnprintf(tas_priv->coef_binaryname,
> > 
> > Why 'c' variant? You do not check the return value anyway. So, what's the point?
> 
> There is a difference between snprintf() and scnprintf().
> With W=1, the compiler (at least the recent gcc version) will warn you
> when the string truncation may happen in the former case while not
> complaining for the latter.
> So, when the truncation is intentional and acceptable (that's
> certainly most cases), the use of scnprintf() will result in less
> warnings.

Yes, which is a papering over the potential problem, right?
I agree that in this case it might be not critical or even
practical to check for an error, but in general the whole lot
of s*nprintf() should be used with this is in mind.

-- 
With Best Regards,
Andy Shevchenko



