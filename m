Return-Path: <linux-kernel+bounces-541104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB5A4B885
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC79188F766
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDE71EBA1C;
	Mon,  3 Mar 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGr4N0Pj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7008F1EB1A1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740988124; cv=none; b=LMe2S/xdHbaSILvMtNdv0FXFie3xYYNVkbmVBHFeUZBgHhJ9ssEBVvA4C/xL4WK2nlEyN+zn0ZuOFn2vDP7CfdLg5Su0EvxbVpYIAPukGS0CnoQ5e7JX6OJqSVHvQwrOicqkm7m/RwYEJVyFgfVgtEnMkJ4hD3uSc6ulpBPmD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740988124; c=relaxed/simple;
	bh=O899tUpr33D4nkrRkipM+nGYDc/Ln+rFJrOyLP5Yc+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjLvC9v3BXrMo9ZxS4hiZ8G5g5yk40PMtpL30kBX1KKkkt1vz2O3tW9xzXyQrwo2E+uGOkCYezhpNf10PwfwoO6SBfnbyBvc1HdBeiRIq7R8uroOtn0hPFdVCuuMrzzdtRSSRlL4p8QEPkrNodL6Yxr4fjkrjEsgQIrl+4IGoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGr4N0Pj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740988123; x=1772524123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O899tUpr33D4nkrRkipM+nGYDc/Ln+rFJrOyLP5Yc+8=;
  b=XGr4N0Pjlc0D9NyYAQF+1S/986jr7G292S0/AKUqLYB7WwC62ZDzCgBG
   w03PPYtJwzT2eucvyezfRjQJMMmJA1XrushXRbMQbwcbsZr6pe9j4CwQZ
   hlSKWl6PSiTIycuxZZ30VE2Umd1t4Zwrhh3HQcMGiMowoiN3Ij0fjNqQf
   em8ulUYeZui0dtzyGz+F08+mxMewC28TRTEoHIefXvjRW5HE1XmWdwSc4
   VnbPQcUYOMPO/hDDCv7xCwXF5aC4cTTIVRECyF7Gg3k9r2EYmJE9kXuxZ
   +YK3Uy/r7tVwBJ+NTPdOkgktTYVSvb25bEGLdM7I3h+QFuXwRApmvBb0n
   Q==;
X-CSE-ConnectionGUID: aGAHWebFSyiMq5Ycv6M5QQ==
X-CSE-MsgGUID: VpWNfScGSvG+2gOByrAsmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="45501701"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="45501701"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:48:42 -0800
X-CSE-ConnectionGUID: mp1sD4VyTWKasBaS8mK2ew==
X-CSE-MsgGUID: btJ3OUAjRRuy3wGp257k8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="122888272"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:48:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp0XV-0000000GkHM-0PBg;
	Mon, 03 Mar 2025 09:48:37 +0200
Date: Mon, 3 Mar 2025 09:48:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Cleanup io.h
Message-ID: <Z8Ve1CQQQAz2le0a@smile.fi.intel.com>
References: <20250227070747.3105451-1-raag.jadav@intel.com>
 <Z8CD33_OWK2LB6IZ@smile.fi.intel.com>
 <0011035a-5816-48c4-9fe4-c0b9db3c8e72@app.fastmail.com>
 <Z8H1Y2_RlFnXeNEa@black.fi.intel.com>
 <Z8IDXD2bkO1t71yB@smile.fi.intel.com>
 <Z8IDgmrLx5DQADxJ@smile.fi.intel.com>
 <Z8IERmwHXUuJoD4S@black.fi.intel.com>
 <Z8IGA821OAgYN-K1@smile.fi.intel.com>
 <Z8IJn7dp4gypnoyz@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8IJn7dp4gypnoyz@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 09:08:15PM +0200, Raag Jadav wrote:
> On Fri, Feb 28, 2025 at 08:52:51PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 28, 2025 at 08:45:26PM +0200, Raag Jadav wrote:
> > > On Fri, Feb 28, 2025 at 08:42:10PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Feb 28, 2025 at 08:41:33PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Feb 28, 2025 at 07:41:55PM +0200, Raag Jadav wrote:
> > > > > > On Fri, Feb 28, 2025 at 06:11:16PM +0100, Arnd Bergmann wrote:
> > > > > > > On Thu, Feb 27, 2025, at 16:25, Andy Shevchenko wrote:
> > > > > > > > On Thu, Feb 27, 2025 at 12:37:45PM +0530, Raag Jadav wrote:
> > > > > > > >> This series attempts to cleanup io.h with "include what you use" approach.
> > > > > > > >> This depends on changes available on immutable tag[1].
> > > > > > > >> 
> > > > > > > >> Although this series is too trivial in the grand scheme of things, it is
> > > > > > > >> still a tiny step towards untangling core headers. I have success results
> > > > > > > >> from LKP for this series but there can still be corner cases. So perhaps
> > > > > > > >> we can queue this on a temporary branch which we can use to submit fixes
> > > > > > > >> in case of fallout.
> > > > > > > >> 
> > > > > > > >> Future plan is to use the excellent analysis[2][3] by Arnd to cleanup other
> > > > > > > >> headers.
> > > > > > > >> 
> > > > > > > >> [1] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > > > > > > >> [2] https://lore.kernel.org/r/2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com
> > > > > > > >> [3] https://lore.kernel.org/r/f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com
> > > > > > > >
> > > > > > > > I believe Arnd can take it through his tree for headers as DRM part is 
> > > > > > > > Acked already.
> > > > > > > 
> > > > > > > I've applied it yesterday and not seen any regression reports so far.
> > > > > > 
> > > > > > Probably because the immutable tag is already in -next?
> > > > > 
> > > > > Is there any?
> > > > 
> > > > Ah, you mean devres related?
> > > 
> > > Yeah, couldn't find it on Arnd's tree and I'm not sure if this series
> > > works without it.
> > 
> > But err.h is included in the io.h, no? Or did I misunderstand the point?
> 
> First patch on the immutable tag moves IOMEM_ERR_PTR() to err.h and here
> we're dropping err.h from io.h. So without the tag this series will probably
> break IOMEM_ERR_PTR().

I see, I think it might be due to some other includes that make this happen.
Whatever, I assume that Arnd heavily tested this anyway, so it's good to go
independently on the immutable tag..

-- 
With Best Regards,
Andy Shevchenko



