Return-Path: <linux-kernel+bounces-296798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B13695AF45
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E769E1F225EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3AE13C812;
	Thu, 22 Aug 2024 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8dEVsvb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3951531DD;
	Thu, 22 Aug 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311729; cv=none; b=gZ3dp6LoOAVYz4oucn+K1l3cOL/8aHiYlaHCUguqWFSr8QRYUeVNQ712vx8y61yqGsDk12bSuTe3yVP817geBt5qyTB7Qn07SpNtBCmgCYG61q41Jlq6ecFRxWk1NhbfeUuWJ/S3hGPhRKzyeTWHdJI4xDmLshJJ6mkEQIioCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311729; c=relaxed/simple;
	bh=JOmB3H1enfZrkteU613aUSjuKOs8i3PjWruFo3Cqz08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1WwDJCHxPjfspuggYhhbqVyBPgIJyxJTTEnVwdaNx9cHEGeNUrBzruExTREG8j0Asi5pYXGY21n/518MJ3LX4aE7kqFetlMXJz0x599TtcyiGhm+KA9BPEy3L3GM2TKmaFPn/+EiZsVbOUt5YrvRvLWETU/JKt6Houzr9fj1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8dEVsvb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724311727; x=1755847727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JOmB3H1enfZrkteU613aUSjuKOs8i3PjWruFo3Cqz08=;
  b=O8dEVsvbmbzFX8HsYfA+1ksejZsh2ul6ubInl7fzX5z89KaWO97yFbVz
   QT2JhNW7OX7a6pgM+HVNweqkYMzzyz8nZQauyVIdWAdbm4FHxj5XFkS+y
   5DFZniDp58YETA6QMgXKaGkVi/F10RSWHQtIfZF0AWYt5uacGAuD/uE+s
   yczaklqwCh+eQi3I8QsgT9a02WxgxvU+/peUHmgd5xcagbZ0G6Siql00K
   xgVRZlJjfGDRwiWtuUWhsIMp57Sqo0ndQMfMd7EHn34VzQKDKEH1dJpa2
   Y9huaKt4pmKEYVWmbTFR+A/rR6cG53dIrV/V9hHCxfB346RNncRrgo9dQ
   w==;
X-CSE-ConnectionGUID: w4qhHA+USqGwP0dbnX5HWg==
X-CSE-MsgGUID: VTnPA6IVSkWcjuUHpYocbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33371618"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="33371618"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 00:28:46 -0700
X-CSE-ConnectionGUID: JW9dLWMFT2CEn/TH1fuMtw==
X-CSE-MsgGUID: BbNyJbfDQvmkLO66SzP5Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="65698857"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 00:28:41 -0700
Date: Thu, 22 Aug 2024 10:28:38 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net, andi.shyti@linux.intel.com,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com
Subject: Re: [PATCH v6] drm/i915/hwmon: expose fan speed
Message-ID: <ZsbophGauSzh15lz@black.fi.intel.com>
References: <20240820062010.2000873-1-raag.jadav@intel.com>
 <ZsRup8uKiqUvADFl@smile.fi.intel.com>
 <ZsSWTtew8nCYWrxF@black.fi.intel.com>
 <ZsSi73YyfKletmgk@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsSi73YyfKletmgk@smile.fi.intel.com>

On Tue, Aug 20, 2024 at 05:06:39PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 20, 2024 at 04:12:46PM +0300, Raag Jadav wrote:
> > On Tue, Aug 20, 2024 at 01:23:35PM +0300, Andy Shevchenko wrote:
> > > On Tue, Aug 20, 2024 at 11:50:10AM +0530, Raag Jadav wrote:
> > > 
> > > But it still has an issue with 64-bit division on 32-bit platforms, right?
> > > 
> > > > +	/*
> > > > +	 * Calculate fan speed in RPM by time averaging two subsequent
> > > > +	 * readings in minutes.
> > > > +	 * RPM = number of rotations * msecs per minute / time in msecs
> > > > +	 */
> > > > +	*val = DIV_ROUND_UP(rotations * (MSEC_PER_SEC * 60), time);
> > > 
> > > ...somewhere here?
> > 
> > Use div64_u64() instead? Or is there a better alternative?
> 
> I don't know the code well to offer anything better. Probably for a starter
> you can switch to use DIV_ROUND_UP_ULL().

This one seems to work. Does it warrant an explanation here?

Raag

