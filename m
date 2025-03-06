Return-Path: <linux-kernel+bounces-548918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62213A54AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B591891626
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232920B1E4;
	Thu,  6 Mar 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G10FoJKX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780061FC0E5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264683; cv=none; b=tl+6MwwBjzs7spoMmbVqJoGuhx1RliRq2d5KLnJCvfMqxJTpO6ZhrY9+/v280ERaG8p5two8WckiUAIaknmdiRTW8kLLsL/6/RstNJeeuN6ZYPQBMySRI0/A23HbZVfk48ldAM/gK2SIjlEkZzzCsJD3rXu1katG4e2cdygHHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264683; c=relaxed/simple;
	bh=zauPh/FxCkM1LLQh0HklNveqEdMXSZj8H+5pd4/Y3lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpE21q0Izm8w19rv69jETRLnjBHVd3EcFG2gVi9AE2JriGocedVIShb0F9t5TC/fm22WdqvRrXPeSNurS54OvnZwdppLcbsBXhocOUJ8IcyxWZ8oOiSaPv/8htwDvMdOvkpkD2YvsIIsfdYsvkYgdKJihTqbEKb8I26BzrItP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G10FoJKX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741264683; x=1772800683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zauPh/FxCkM1LLQh0HklNveqEdMXSZj8H+5pd4/Y3lA=;
  b=G10FoJKXbwZ5RjQS1HECSBtc3sQ09QPyxs9DMTpd8G9Wz/bbPbk0gz6k
   I3ifJ2H9RKxD2WU9GFgwbt6MOYRl4/2e0CBV9waYEBHLmue5uK/Rt7ldf
   d6fe5+kxPXWzO0fzJzID0u46lhDcp7rN4kfTFx3Tr0vnvKDC+Kfkj0oPz
   y0YimaN7J26I5yzYYlvT/RJhHNXqOCh5yXim/Hwdu8zlpyVUSmRNApioD
   TGNbuxO065ew472smpoBGCyptelyqEok0+cwjYQQ31sqKWHlVE0tsQE6/
   MBlMg5oqPpglbP2utY54D/eHT+XaNoZqH5oaopCX0Er2NAJv0msCZM5U+
   A==;
X-CSE-ConnectionGUID: xOS0cIdmTg6+6WCVJM6Jmw==
X-CSE-MsgGUID: Yu4/ndqVTyiS1BuYyYMdEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42466927"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42466927"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 04:38:02 -0800
X-CSE-ConnectionGUID: SqIkQi8MQ2StcqiExmbZaQ==
X-CSE-MsgGUID: +r7KQ3LSSqWkCBjXNYkdVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="119019708"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 04:38:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqAU9-000000007Gz-2KHf;
	Thu, 06 Mar 2025 14:37:57 +0200
Date: Thu, 6 Mar 2025 14:37:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	bleung@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Convert regulator drivers to use
 devm_kmemdup_array()
Message-ID: <Z8mXJUwt4q2NY059@smile.fi.intel.com>
References: <20250228072057.151436-1-raag.jadav@intel.com>
 <174077776750.602863.5336934105237710269.b4-ty@kernel.org>
 <Z8kFW13EyR0YXnJd@black.fi.intel.com>
 <Z8loo-N5byavJLkm@smile.fi.intel.com>
 <Z8l1ozUOMTDNQupC@black.fi.intel.com>
 <Z8mBQEKAJfZd6a7G@smile.fi.intel.com>
 <Z8mHw_W1xT9Mcilt@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8mHw_W1xT9Mcilt@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 01:32:19PM +0200, Raag Jadav wrote:
> On Thu, Mar 06, 2025 at 01:04:32PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 06, 2025 at 12:14:59PM +0200, Raag Jadav wrote:
> > > On Thu, Mar 06, 2025 at 11:19:31AM +0200, Andy Shevchenko wrote:
> > > > On Thu, Mar 06, 2025 at 04:15:55AM +0200, Raag Jadav wrote:
> > > > > On Fri, Feb 28, 2025 at 09:22:47PM +0000, Mark Brown wrote:
> > > > > > On Fri, 28 Feb 2025 12:50:55 +0530, Raag Jadav wrote:
> > > > > > > This series converts regulator drivers to use the newly introduced[1]
> > > > > > > devm_kmemdup_array() helper. This depends on changes available on
> > > > > > > immutable tag[2].
> > > > > > > 
> > > > > > > [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> > > > > > > [2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > > > > > > 
> > > > > > > [...]
> > > > > > 
> > > > > > Applied to
> > > > > > 
> > > > > >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> > > > > 
> > > > > Thank you.
> > > > > 
> > > > > Unless there's a nuance intended in the merge series title that I'm unable
> > > > > to understand, it probably seems incomplete.
> > > > 
> > > > I believe it's an issue somewhere in the scripts. The long Subject line is
> > > > split in the mailbox and that's probably is not supported by the machinery.
> > > > 
> > > > You are not the only one who reports this issue.
> > > 
> > > While I'm not well educated on the machinery, I'm also seeing devm_kmemdup_array()
> > > introduction commit reordered in -next and thinking perhaps it can cause issues
> > > with bisect, especially after final merge into Linus' tree?
> > 
> > I;m not sure what you exactly pointing out here. Mark seems applied only
> > necessary part of the immutable tag, which have the same effect. The Git merges
> > only once the stuff as long as it has the same hash.
> 
> $ git describe
> next-20250306
> 
> $ git log --oneline --grep raag

--author="Raag ..."

...

> 1f4c7f3b3afa Merge patch series "Split devres APIs to device/devres.h and introduce devm_kmemdup_array()"
> a103b833ac38 devres: Introduce devm_kmemdup_array()
> b8c38ccb2ca5 input: ipaq-micro-keys: use devm_kmemdup_array()
> cdcc09a495a4 input: sparse-keymap: use devm_kmemdup_array()
> a0d78eec8839 iio: adc: xilinx-xadc-core: use devm_kmemdup_array()
> 86068aca7548 pinctrl: pxa2xx: use devm_kmemdup_array()
> 91bfcc7a2fdb pinctrl: tangier: use devm_kmemdup_array()
> d795fb90d6c6 pinctrl: cherryview: use devm_kmemdup_array()
> f192c8447f4e pinctrl: baytrail: copy communities using devm_kmemdup_array()
> 753764aa8eb5 pinctrl: intel: copy communities using devm_kmemdup_array()
> a21cad931276 driver core: Split devres APIs to device/devres.h
> 18311a766c58 err.h: move IOMEM_ERR_PTR() to err.h
> 
> I'm expecting commit a103b833ac38 to be before its users, or perhaps I'm
> doing something wrong here?

$ git tag --contains a103b833ac38
ib-devres-iio-input-pinctrl-v6.15
next-20250225
next-20250226
next-20250227
next-20250228
next-20250303
next-20250304
next-20250305
next-20250306

-- 
With Best Regards,
Andy Shevchenko



