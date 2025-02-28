Return-Path: <linux-kernel+bounces-539191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E469FA4A1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCB13B302B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D807A27CCD4;
	Fri, 28 Feb 2025 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBpQrzVE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6A27CCC3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768100; cv=none; b=nUdfX6HXcagC6R3RL5RaiFMVOWSUzlJcfTXOF2KS2kkhJ5WNAl58tPtIRKF2PwOvlgKniXLDsBEzGyxg0tmy2C1ICxlclocKwLKSPn9/GUB3tTp3LKyQ1SpjYFqc2gbUpms2b+u9YqQRUJ3gFUDMcvpd6Q3zzj8zqKLw9SyNKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768100; c=relaxed/simple;
	bh=Fro+5YyzK/VVfu0mLdptX/BMxw9TEdL4ipa2bCQd9UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOGOBmL8H/1oCuKVB6PMbxHK+cSWPTwLJgZp0slOCOSHDiLLujIEYzv9CvtvCwtUKsUkMwSXErGIldvakoH5/5JiZ7U2ItMkj1b9qqojnoudo0C8xNPeY5vq2liPP6mWLDqw1B5K+ws4Q+TJTMXKtgcoZOSul0Y/7Z3OUvoqIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBpQrzVE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740768098; x=1772304098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fro+5YyzK/VVfu0mLdptX/BMxw9TEdL4ipa2bCQd9UU=;
  b=RBpQrzVEwIu0/eDnO9ebVEB6G3D1kYkNSrOfyU4e/SHGbTiP3D3lBaJJ
   DcrqTSFM5Ch2/1kBAGGqvCh7RaN2V0BsU6WMVbXZNHSEY1RN9/aZR4Bdp
   Buur7SFoR7e5ejxvHLwtRtZVLOKv52bNygcTcnoQhv+/1kemnhjls6kY+
   6rd+TD0p5kb3v+19BN/D9lR+0pyeAZG+CxJKGjuShjc+fy0XkZ2VxqClS
   nsQ5Q6gfCTfSTHuxH1lkA+HbHNrxSy1z/7xMfVr6g17m0BTzAXEvZ54ux
   FSafOfZtPE1oaW4gvEGVk48o805CthgMpsg7pQbUzExpYwvfe2UKqGxy0
   A==;
X-CSE-ConnectionGUID: onRQLMqCQ7yt5wU57cLNpQ==
X-CSE-MsgGUID: fkGecCGHTS+u3wodTSrOeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="67082829"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="67082829"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:41:37 -0800
X-CSE-ConnectionGUID: FclnG/2dTamtUdfbt2DfQA==
X-CSE-MsgGUID: JT6Js5ZFT5WAOdtAD92Rog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122031056"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:41:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1to5Ij-0000000G3ba-0mKi;
	Fri, 28 Feb 2025 20:41:33 +0200
Date: Fri, 28 Feb 2025 20:41:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Cleanup io.h
Message-ID: <Z8IDXD2bkO1t71yB@smile.fi.intel.com>
References: <20250227070747.3105451-1-raag.jadav@intel.com>
 <Z8CD33_OWK2LB6IZ@smile.fi.intel.com>
 <0011035a-5816-48c4-9fe4-c0b9db3c8e72@app.fastmail.com>
 <Z8H1Y2_RlFnXeNEa@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8H1Y2_RlFnXeNEa@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 07:41:55PM +0200, Raag Jadav wrote:
> On Fri, Feb 28, 2025 at 06:11:16PM +0100, Arnd Bergmann wrote:
> > On Thu, Feb 27, 2025, at 16:25, Andy Shevchenko wrote:
> > > On Thu, Feb 27, 2025 at 12:37:45PM +0530, Raag Jadav wrote:
> > >> This series attempts to cleanup io.h with "include what you use" approach.
> > >> This depends on changes available on immutable tag[1].
> > >> 
> > >> Although this series is too trivial in the grand scheme of things, it is
> > >> still a tiny step towards untangling core headers. I have success results
> > >> from LKP for this series but there can still be corner cases. So perhaps
> > >> we can queue this on a temporary branch which we can use to submit fixes
> > >> in case of fallout.
> > >> 
> > >> Future plan is to use the excellent analysis[2][3] by Arnd to cleanup other
> > >> headers.
> > >> 
> > >> [1] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > >> [2] https://lore.kernel.org/r/2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com
> > >> [3] https://lore.kernel.org/r/f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com
> > >
> > > I believe Arnd can take it through his tree for headers as DRM part is 
> > > Acked already.
> > 
> > I've applied it yesterday and not seen any regression reports so far.
> 
> Probably because the immutable tag is already in -next?

Is there any?

-- 
With Best Regards,
Andy Shevchenko



