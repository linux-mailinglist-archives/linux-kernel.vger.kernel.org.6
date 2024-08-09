Return-Path: <linux-kernel+bounces-281042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48BB94D247
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FF1280F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089BA197556;
	Fri,  9 Aug 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIsAtwFG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857213FFC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214205; cv=none; b=PYc8Fl9j9olijQllzgbtqV7ArCYfEAq3yfEBWG4ehIDCcuO6DhEL8lWiibg88FwWn8xzLJWnHLg8X2TW/6BsumBs9YezM9ETEtz/7JVJWkieqiArDZuP0EtJppEvgwDssCo2xM3deeWvpd4xLxZUUg5Y+CFhlkyWTu4OJwfoUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214205; c=relaxed/simple;
	bh=jfeOKs/97i1MZB9mZgQc/1uRPFTjG8+Gzz1wmjHvPLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1wwnS8wAvGPS1S4SRbAndPSkFf4sNXMmCjcCdBhuEQ+chpho1CqZgZvBZVO5a48h+uMkLyiWn0XzsXg8JGDqqoCTopbdYx2LdLMey4IvPQkN2e8fWlQY0MgVDkeBYtAaCrdbeB0zAxRn5f5n1Om5Xc5Turzlcgw57aLhp93NTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIsAtwFG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723214204; x=1754750204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jfeOKs/97i1MZB9mZgQc/1uRPFTjG8+Gzz1wmjHvPLc=;
  b=lIsAtwFGP2uekuE/+mH9zGZ32n08VlM8EENVTYVA9I2HgPs801mog1to
   5t3iXOa1ZttRDoEnKvHvtWI2zWRZrDu7veHPgCs40iO2Lb5C0ACQEq0vO
   ozmvg0ol5psNA87aylNJ8apP+EAAOzLOW7XP1IoGoKFNjIL9NNPhWl1dm
   NtP6ED5+iBp6AV7k1kr7GmZoHnNVg7QBzUTlBMJtk6HRLxoJk0S09ntFc
   XXK1ae4IieQkyslC3QVaX76qbEyjuUh31dMzki+5O3EfxFh02WYzVc1+V
   nBdG29ikb28O4KeDw+10IWkWOUwfThXuL/hTbEzb0SaYMjR8hDiEs6UNc
   A==;
X-CSE-ConnectionGUID: 4I9OQmDYQfaTEjiayV2aFg==
X-CSE-MsgGUID: a4miK6WRQrqa1NcUgr8tHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21532041"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21532041"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 07:36:43 -0700
X-CSE-ConnectionGUID: W/40TGxYRI6DXUcx3PHw2g==
X-CSE-MsgGUID: 6RIEOof2RXGhCJWAdN5VlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57228455"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 07:36:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scQjK-0000000DRau-1e7G;
	Fri, 09 Aug 2024 17:36:34 +0300
Date: Fri, 9 Aug 2024 17:36:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"judyhsiao@google.com" <judyhsiao@google.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Salazar, Ivan" <i-salazar@ti.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Chadha, Jasjot Singh" <j-chadha@ti.com>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"bard.liao@intel.com" <bard.liao@intel.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"Rao, Dipa" <dipa@ti.com>,
	"yuhsuan@google.com" <yuhsuan@google.com>,
	"tiwai@suse.de" <tiwai@suse.de>, "Xu, Baojun" <baojun.xu@ti.com>,
	"soyer@irl.hu" <soyer@irl.hu>,
	"Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"cujomalainey@google.com" <cujomalainey@google.com>,
	"Kutty, Aanya" <aanya@ti.com>,
	"Mahmud, Nayeem" <nayeem.mahmud@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Add Calibration
 Kcontrols and tas2563 digtial gain for Chromebook
Message-ID: <ZrYpcjC_vf7ldnie@smile.fi.intel.com>
References: <20240522112942.994-1-shenghao-ding@ti.com>
 <Zk3eq0k2Eq-gtejq@smile.fi.intel.com>
 <6b6a0af1e55241c4b2acde42e9966e3b@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b6a0af1e55241c4b2acde42e9966e3b@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 24, 2024 at 11:42:11AM +0000, Ding, Shenghao wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday, May 22, 2024 8:02 PM
> > To: Ding, Shenghao <shenghao-ding@ti.com>
> > On Wed, May 22, 2024 at 07: 29: 41PM +0800, Shenghao Ding wrote: >


(some comments were not answered, are you agree on all of the points?)

...

> > > +	cali_data->data = devm_kzalloc(tas_priv->dev, tas_priv->ndev *
> > > +		(cali_data->reg_array_sz * 4 + 1), GFP_KERNEL);
> > 
> > No way. First of all, we have kcalloc(), second, there is an overflow.h that has
> > necessary macros to calculate sizes for memory allocations.
> Memory allocated with devm_kzalloc is automatically freed on driver detach while kcalloc can’t

Yes, we have devm variant for kcalloc(), why can it be not utilised?

> > > +	if (!cali_data->data)
> > > +		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



