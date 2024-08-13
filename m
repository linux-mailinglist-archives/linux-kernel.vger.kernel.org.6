Return-Path: <linux-kernel+bounces-284649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5329B950389
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CB51F213E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C4E1990DA;
	Tue, 13 Aug 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjkQFRO0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF2194AE6;
	Tue, 13 Aug 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548203; cv=none; b=JZ4sVZcJ3gh1Pax4CWea4Pw2sxQbzYGAwhKROPuLzbuBk5INUtawgQSD417QzeOkTrKhQvYiQb25vdPL+QMP8KnKZhUd8R/pxhPYo4YR6N/m/p/XIFdhFLLIVNwqyprPmeFjpwqEI0fxmv1zfET9QvX195IXlzHh283yZ8SUcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548203; c=relaxed/simple;
	bh=/UJoSeNq4Z69OVheBJmypYp4ovP53kxbHryvRHxEXXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUfS8ysl69BwsJ7RH8UTC74WS7Y3gMeCblDRM086LZFeq1tQBGN216r3HBl9MzEPq2NcDsj7LQ02jK3GJA8SptLVaPT7mjClKK6hMK38gZHAhFOuveiPHF9XrS5GUfQLcekOLcMfoE75/u1lRx3WnnMmq5pEYLKDRNjExc2j7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjkQFRO0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723548202; x=1755084202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/UJoSeNq4Z69OVheBJmypYp4ovP53kxbHryvRHxEXXE=;
  b=IjkQFRO0diQCPxoWmz+sJYH4GHlYusbB24YP7DhtI9TaQVZ3LJkOiAJ9
   +ZmUhDFIv5pJO8osUc2yv1JOwvkJrpYF2jDDgjm8yxh0bTkT1CvWDkuiO
   JafihfoyZC2gPUp6WLodDSNqdmLlrnsujVA3J32lNKalAaUmL2BqiBFcx
   FUZNGo6yBf/9/WpvuYRSH0FGNmyEhm2R9FvAW8TXqJNYRZLQG7r6s/VnF
   OA8Hm5gpfXe5Qbh61MF7kT0ymoEn4mT7fy/CIIq/TEIh0hstogzzpaMG4
   InjHJCb2jxriMCCZHp18pMZutC6fN8UjLcEywMsugQGlo8IMVmoiG+gij
   w==;
X-CSE-ConnectionGUID: LXy9eX1IQkmXa81xdqYCcg==
X-CSE-MsgGUID: 6gJpSBcURuCvYVQclJ1b7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21872583"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21872583"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:23:21 -0700
X-CSE-ConnectionGUID: jEhCf8CZR9OXK4P7V66CjQ==
X-CSE-MsgGUID: 6Ewi4twyQ42M8kTCgOLFYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63496347"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:23:17 -0700
Date: Tue, 13 Aug 2024 14:23:13 +0300
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
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <ZrtCIU8On4ZKILmh@black.fi.intel.com>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>

On Fri, Aug 09, 2024 at 02:48:08PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 09, 2024 at 11:45:25AM +0530, Raag Jadav wrote:
> 
> > +	/*
> > +	 * HW register value is accumulated count of pulses from
> > +	 * PWM fan with the scale of 2 pulses per rotation.
> > +	 */
> > +	rotations = pulses >> 1;
> 
> In accordance with the comment the
> 
> 	rotations = pulses / 2;
> 
> looks better.

This change seems to cause a build error in v5.
Something to do with __udivdi3 on i386.

Should we revert back to shift?

Found something similar here,
drivers/target/target_core_xcopy.c +697

Raag

