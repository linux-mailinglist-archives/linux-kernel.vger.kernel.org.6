Return-Path: <linux-kernel+bounces-289907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7090954D30
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3513F1F217E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5A1BCA08;
	Fri, 16 Aug 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5nYQv0y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA961BCA0B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819882; cv=none; b=neBatuSpDhDVhBf2xpvNOHSI7j2CcfF8eZ9g8SgwRhN30GMcColVAUi46uHtQPKG15R6lXjJJvXuZoyaEliYsCXQQZZ2KwtV86SxqCi1mhngHWOdauZRQ689ZVuffdnWeepvwjZJ/dp9aLHSSOsJ5TOXEzkNifiKRgLif51m8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819882; c=relaxed/simple;
	bh=pRyHlCh8aSYYzHXx34WfX5hxoAw8zCK3wnS3r5G3XYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkYTPH+UBLWsLTnBcZFalz7FQKpZz7U/tpUkchHdCdvtDPqStD50P3oIc5TmiYPYGkngq6pYHbWc5B+BoCuzt/VfjgnvjbAarAw+FrFyEXgiEVRXbNqGVOlhs8ZVKzk1Zz6Y+vzoudHp4HhspQc8ar4mlnftdENxU13wU6aGn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5nYQv0y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819882; x=1755355882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pRyHlCh8aSYYzHXx34WfX5hxoAw8zCK3wnS3r5G3XYI=;
  b=h5nYQv0ytmBeQ9jLYuUEnb85KqB7rjWw8PlIGsgpNS+AQZ1YkTH+nOSv
   wE10VvwwMeN13ZD1QIgXoqPgybUk2gyAWApByP4DGTKdybUzcs6yNZU7H
   v8X5CIkxPwvvC8c8iIOx+kHjzq+7w9HjxBtR1n1Q6q5wEgfE0+yCcwJ1F
   GYB/i63neTn3XCGco/tBksdXHPo4qNuaX7ZC00WiYt0vHsnrtmmqdyIfv
   ik7iIibrnpAt8PNtys/Uc619zW2UMB2Tn7l0bso0uD3GQ8Ft2joQp1R0a
   3MljxhWI3FfTh3DVwdr6gZFTWpD8MSb491Hzbr7SNKUTDc+E7B765uMAN
   g==;
X-CSE-ConnectionGUID: 6wVYhGLkTsSisXi5yosMsQ==
X-CSE-MsgGUID: iW9UmCJuQQOlNxdEwfkQNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="33503179"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="33503179"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:51:19 -0700
X-CSE-ConnectionGUID: 2WEn18WyQweCjl5zF3pxQw==
X-CSE-MsgGUID: 2rLDsdYBTRmn7nLy7PzoaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64529984"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:51:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1seyIF-0000000FwGC-40M2;
	Fri, 16 Aug 2024 17:51:07 +0300
Date: Fri, 16 Aug 2024 17:51:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"zhourui@huaqin.com" <zhourui@huaqin.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Salazar, Ivan" <i-salazar@ti.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Chadha, Jasjot Singh" <j-chadha@ti.com>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"Yue, Jaden" <jaden-yue@ti.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"Rao, Dipa" <dipa@ti.com>,
	"yuhsuan@google.com" <yuhsuan@google.com>,
	"Lo, Henry" <henry.lo@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
	"Xu, Baojun" <baojun.xu@ti.com>,
	"Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
	"judyhsiao@google.com" <judyhsiao@google.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"cujomalainey@google.com" <cujomalainey@google.com>,
	"Kutty, Aanya" <aanya@ti.com>,
	"Mahmud, Nayeem" <nayeem.mahmud@ti.com>,
	"savyasanchi.shukla@netradyne.com" <savyasanchi.shukla@netradyne.com>,
	"flaviopr@microsoft.com" <flaviopr@microsoft.com>,
	"Ji, Jesse" <jesse-ji@ti.com>,
	"darren.ye@mediatek.com" <darren.ye@mediatek.com>,
	"antheas.dk@gmail.com" <antheas.dk@gmail.com>,
	"Jerry2.Huang@lcfuturecenter.com" <Jerry2.Huang@lcfuturecenter.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Rename dai_driver name
 to unify the name between TAS2563 and TAS2781
Message-ID: <Zr9nW-rIA0TpmYVj@smile.fi.intel.com>
References: <20240803032717.175-1-shenghao-ding@ti.com>
 <ZrovmRCPN7pc0n40@smile.fi.intel.com>
 <9ec30bafdec441078828cb0d7be93342@ti.com>
 <Zr3uwfNLtTdJWrz4@smile.fi.intel.com>
 <2a4f9f583b5e4495b9fb50a446c2c949@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4f9f583b5e4495b9fb50a446c2c949@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 16, 2024 at 01:41:46PM +0000, Ding, Shenghao wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, August 15, 2024 8:04 PM
> > To: Ding, Shenghao <shenghao-ding@ti.com>
> > On Thu, Aug 15, 2024 at 03:02:01AM +0000, Ding, Shenghao wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: Monday, August 12, 2024 11:52 PM On Sat, Aug 03, 2024 at
> > > > 11:27:14AM +0800, Shenghao Ding wrote:

...

> > > > > +	strscpy(name, "Speaker Profile Id",
> > > > SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
> > > >
> > > > > +	strscpy(prog_name, "Speaker Program Id",
> > > > > +		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
> > > >
> > > > > +	strscpy(conf_name, "Speaker Config Id",
> > > > > +SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
> > > >
> > > > Why not 2-parameter strscpy()?
> > > strscpy seemed not support 2 params. Do you mean strcpy?
> > 
> > 1. It does.
> > 2. No, I meant strscpy().
> I have tried 2-parameter strscpy(), and occurred compiling issue.
> The first parameter of strscpy, *dst, must be array, but in this code
> prog_name and conf_name are points to the memories applied by
> devm_kcalloc.

Okay, I'm not sure why devm_kasprintf() is not used for these cases.

-- 
With Best Regards,
Andy Shevchenko



