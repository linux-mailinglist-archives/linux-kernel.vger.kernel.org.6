Return-Path: <linux-kernel+bounces-548734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1BAA548B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3153A5094
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF11FECB8;
	Thu,  6 Mar 2025 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRdadga0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA719067C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259079; cv=none; b=VBs8Z5AevfL9DYPp3+B8RIvDVsUBbzzSpttTLZNRqTrTAqAOPVJZ/i+9GlavO3w4dO46veP3EFk1WgjbFWQyKJC2vL58DH0IyBLSTYlMZ7ZxWaGF0rFXqcnOaikM8yYEFY9JMnDvVLMLJgcK9XtvIQ0s5EVpSXHfNZ/UXjGU9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259079; c=relaxed/simple;
	bh=GHTKkC2JgOAA+ecTby1q55PnZQoQ4zyJlyvD9j7GgEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J13ffRpIa2sNii4rGnNBdbRdimBpSPIVjswQ4g8okjYudWGLUH++sv2rjVWBDyBW72hTU/C82Zz7Evxnx8tnROQu29wBbw5q7s9Gqsz1tSAox8GTs5Zqce3q2iyl88bOO02zuZtpy0gUavoicZIpK7QrZQJIY2uAtrV9a8JNSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRdadga0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741259077; x=1772795077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GHTKkC2JgOAA+ecTby1q55PnZQoQ4zyJlyvD9j7GgEk=;
  b=WRdadga0T/l6je9a5DM95gxQh/sP5Dp1mkefq2xVwb2TOM2yyCKAA1yB
   xNIuM2DRNm81vZICbb+pO6BiPD31YJAbCIPRgtm/cR10Q4FVDsftsuPr+
   1yicbggAFE9EvqGRqE4W7Qq9EzD2qC+Ph/4WC8fA4snzivbuAX0qLekCe
   BxzhCwmek8a3YzeEkgCUJJ7R75QHhzKgkU2tgOx9aVb0y9DlUJO+sw6/j
   AhXr46+XU2lCO2x5n5gRp1i7AoAsRy/3JeGZb8qZRnjj6CVxZHC6eClSR
   9VQrYb0xJ26pyhHskZeF7nbghZbZYXr19Y3qyuBxi1zkxjoY8+pIz+bon
   A==;
X-CSE-ConnectionGUID: SlztC5iWQ8Kp77JJV14HKw==
X-CSE-MsgGUID: cC3JsBTISYy7br4GnRQsOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41512172"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41512172"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:04:36 -0800
X-CSE-ConnectionGUID: hWBFrQq7T9SQWnJiQ5+S7A==
X-CSE-MsgGUID: fCl3Ba7HRfiUnzZvk++mfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119908179"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:04:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tq91k-0000000067R-1Rzd;
	Thu, 06 Mar 2025 13:04:32 +0200
Date: Thu, 6 Mar 2025 13:04:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	bleung@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Convert regulator drivers to use
 devm_kmemdup_array()
Message-ID: <Z8mBQEKAJfZd6a7G@smile.fi.intel.com>
References: <20250228072057.151436-1-raag.jadav@intel.com>
 <174077776750.602863.5336934105237710269.b4-ty@kernel.org>
 <Z8kFW13EyR0YXnJd@black.fi.intel.com>
 <Z8loo-N5byavJLkm@smile.fi.intel.com>
 <Z8l1ozUOMTDNQupC@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8l1ozUOMTDNQupC@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 12:14:59PM +0200, Raag Jadav wrote:
> On Thu, Mar 06, 2025 at 11:19:31AM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 06, 2025 at 04:15:55AM +0200, Raag Jadav wrote:
> > > On Fri, Feb 28, 2025 at 09:22:47PM +0000, Mark Brown wrote:
> > > > On Fri, 28 Feb 2025 12:50:55 +0530, Raag Jadav wrote:
> > > > > This series converts regulator drivers to use the newly introduced[1]
> > > > > devm_kmemdup_array() helper. This depends on changes available on
> > > > > immutable tag[2].
> > > > > 
> > > > > [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> > > > > [2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied to
> > > > 
> > > >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> > > 
> > > Thank you.
> > > 
> > > Unless there's a nuance intended in the merge series title that I'm unable
> > > to understand, it probably seems incomplete.
> > 
> > I believe it's an issue somewhere in the scripts. The long Subject line is
> > split in the mailbox and that's probably is not supported by the machinery.
> > 
> > You are not the only one who reports this issue.
> 
> While I'm not well educated on the machinery, I'm also seeing devm_kmemdup_array()
> introduction commit reordered in -next and thinking perhaps it can cause issues
> with bisect, especially after final merge into Linus' tree?

I;m not sure what you exactly pointing out here. Mark seems applied only
necessary part of the immutable tag, which have the same effect. The Git merges
only once the stuff as long as it has the same hash.

-- 
With Best Regards,
Andy Shevchenko



