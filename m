Return-Path: <linux-kernel+bounces-539224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2339A4A237
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751A216F382
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB891F4CA1;
	Fri, 28 Feb 2025 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6tXwGJN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDD277005
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768777; cv=none; b=YNXKnzuY3DOx2lXlb95NszaifLTVQJnim1Cy3dP6+qT7CldrdR3BuIbQWyqgYek3vznq5gUwl4us5EWC1KzshxS8xAZNCHB9Bp//dRGIFFqKyLFFuz5EHpJeteeEWu3hW6WZieW6pVTFQZDG4jp+81/uN5seZ1nEAsZsOft26Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768777; c=relaxed/simple;
	bh=4Q0hw/ajRFKVPitC4Ch9KNn7FeeRH/hNMXpUNvC+1Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezTDoTw140X8xwHKS0EEjcM+R9DuZoNAtHBv/R3XKa35rVbEjNBkb87bYIAAdubmtpEzHBTRMdYdWr81BHR4uRGo66aUJALVwvsBDlmhFVd1Sw1f7WAj2qzd3zsCY/1XtFrF642SwiNKeXApthXooat67jOIOzjV6XtpeDdZKjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6tXwGJN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740768776; x=1772304776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Q0hw/ajRFKVPitC4Ch9KNn7FeeRH/hNMXpUNvC+1Cc=;
  b=d6tXwGJNNrGLFgCuyr4IKIP7qEqJ78s8NTv4KaodFzqog3qhTyKtXBDN
   ndpmVUPyO0PqSf9ThJded2zxy+Fv460PhrSFBWztepspg1ijwpRypYLtV
   FSbY7iTnIFiDVeEhgc6OTOxghPE91guO5E0kC//0TOzsjJBfNZLg9f5mj
   W3NLQHgluOyfee6TmMyIfPWIxE3B+WpirVDnUyPsD4IQnR5M8WdXLsVSo
   +FtF9ZN4abE+xW6wHHgS42qdEjHKBTFM+Sw9WNYX8l7Ab8SONPD/WWjvs
   ndORfM0BkHEimsH1RkhIyEOKtJlzjpDoA2RSHW/Y+8ZgaL1XDc1goU1Lq
   g==;
X-CSE-ConnectionGUID: JU/2jZUpQ1CrEAXX/y4zdg==
X-CSE-MsgGUID: p2qjqepOTpuIrReHogtIFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41593415"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="41593415"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:52:56 -0800
X-CSE-ConnectionGUID: H2zszMg5SVWhBGdpTtACbg==
X-CSE-MsgGUID: SRQuiKOdRe6jElvpX27CPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122549103"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:52:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1to5Tf-0000000G3oN-1QEH;
	Fri, 28 Feb 2025 20:52:51 +0200
Date: Fri, 28 Feb 2025 20:52:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Cleanup io.h
Message-ID: <Z8IGA821OAgYN-K1@smile.fi.intel.com>
References: <20250227070747.3105451-1-raag.jadav@intel.com>
 <Z8CD33_OWK2LB6IZ@smile.fi.intel.com>
 <0011035a-5816-48c4-9fe4-c0b9db3c8e72@app.fastmail.com>
 <Z8H1Y2_RlFnXeNEa@black.fi.intel.com>
 <Z8IDXD2bkO1t71yB@smile.fi.intel.com>
 <Z8IDgmrLx5DQADxJ@smile.fi.intel.com>
 <Z8IERmwHXUuJoD4S@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8IERmwHXUuJoD4S@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 08:45:26PM +0200, Raag Jadav wrote:
> On Fri, Feb 28, 2025 at 08:42:10PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 28, 2025 at 08:41:33PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 28, 2025 at 07:41:55PM +0200, Raag Jadav wrote:
> > > > On Fri, Feb 28, 2025 at 06:11:16PM +0100, Arnd Bergmann wrote:
> > > > > On Thu, Feb 27, 2025, at 16:25, Andy Shevchenko wrote:
> > > > > > On Thu, Feb 27, 2025 at 12:37:45PM +0530, Raag Jadav wrote:
> > > > > >> This series attempts to cleanup io.h with "include what you use" approach.
> > > > > >> This depends on changes available on immutable tag[1].
> > > > > >> 
> > > > > >> Although this series is too trivial in the grand scheme of things, it is
> > > > > >> still a tiny step towards untangling core headers. I have success results
> > > > > >> from LKP for this series but there can still be corner cases. So perhaps
> > > > > >> we can queue this on a temporary branch which we can use to submit fixes
> > > > > >> in case of fallout.
> > > > > >> 
> > > > > >> Future plan is to use the excellent analysis[2][3] by Arnd to cleanup other
> > > > > >> headers.
> > > > > >> 
> > > > > >> [1] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > > > > >> [2] https://lore.kernel.org/r/2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com
> > > > > >> [3] https://lore.kernel.org/r/f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com
> > > > > >
> > > > > > I believe Arnd can take it through his tree for headers as DRM part is 
> > > > > > Acked already.
> > > > > 
> > > > > I've applied it yesterday and not seen any regression reports so far.
> > > > 
> > > > Probably because the immutable tag is already in -next?
> > > 
> > > Is there any?
> > 
> > Ah, you mean devres related?
> 
> Yeah, couldn't find it on Arnd's tree and I'm not sure if this series
> works without it.

But err.h is included in the io.h, no? Or did I misunderstand the point?

-- 
With Best Regards,
Andy Shevchenko



