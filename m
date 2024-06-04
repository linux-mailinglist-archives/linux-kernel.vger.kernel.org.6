Return-Path: <linux-kernel+bounces-201288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A143A8FBC8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2D51F21B77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8D14B092;
	Tue,  4 Jun 2024 19:30:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7772E64C;
	Tue,  4 Jun 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529414; cv=none; b=gBbMPUtHSjhTeBIdyP/QNdxSsxjdyi7/DCEWzdxsqzFIYh1iSNJuit4oH5esoZ8ehr5g6NWYAbWKHhB0vhxadsxzrYr/IWvhWV9AiDiP5KfGecnLDfutDd5w7ZsNXyNF5ejwlhqgweM10GLM2F5SHrEB8yqFpPQucEOQwWBqlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529414; c=relaxed/simple;
	bh=oULadjP6P41q089ExSQ5/oAxT/vKrEmTUYcwve21ydY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf6cD7vuLQ7jjBsYIJpqSKbRjPNxHNZHJYsB3DuvJlV4IQ30IJ4zUfVsYiQ6KnidZa+4rO32MLyr9Zpke0dClliljsKMSXNM3lTF2jDyKsukLqkbWM91wAVIel4RQp9mP769zqkeZQPJqmKS9MVa/xl6YDGgpnUbBZcfsA+Z8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 1Cvi0cF8TK+EeU5TvQsCOA==
X-CSE-MsgGUID: c9JEqBabSyKe2dY58hwyWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14257589"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="14257589"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 12:30:12 -0700
X-CSE-ConnectionGUID: lYBHTnAjSPer6lvyayjErg==
X-CSE-MsgGUID: D8aIAmoOQISCjC8b7LQjgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="68488808"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 12:30:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1sEZrD-0000000Ddrd-3tyz;
	Tue, 04 Jun 2024 22:30:07 +0300
Date: Tue, 4 Jun 2024 22:30:07 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: auxdisplay: ht16k33: Drop device node reference after
 registration failure in ht16k33_led_probe()
Message-ID: <Zl9rPy3hD-Hk-gxm@smile.fi.intel.com>
References: <0fc79fe9-da49-4cbe-a7ff-6443ad93f120@web.de>
 <Zl9B2zqbJqVAf83d@smile.fi.intel.com>
 <503de0cb-09d2-4716-99cb-de257a33bad8@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503de0cb-09d2-4716-99cb-de257a33bad8@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 04, 2024 at 08:15:35PM +0200, Markus Elfring wrote:
> > But, by design we don't use reference counting after we registered LED,
> > hence both error and successful paths need to have this,
> 
> Do you indicate really special data processing constraints here?

Nothing special, either we hold reference for the entire life time of the
device or not. For LEDS the convention is not to hold.


> > so add another fwnode_handle_put() after this branch.
> 
> Will this suggestion trigger any further clarifications for the affected software?

You need to put an fwnode handle in both paths: inside the if branch as you
have done (error path) and missing one is after that needs to be added.

Just address my comments and I believe everyone will be happy about it.

-- 
With Best Regards,
Andy Shevchenko



