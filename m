Return-Path: <linux-kernel+bounces-548649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF5A54780
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B2C189315B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0D1FF1AA;
	Thu,  6 Mar 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrDRY6u/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265815697B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256107; cv=none; b=qmvy4+MgnE/gT4VMiXlIqxmqHkti+Okn8VolegQTqn9E4ZVETRCC5s3volEjSveNxYQiRnI4PEcXnCOsRXISd9Xb/KSGwsp2QUqWwoDNXAkKzg4ZIPhR9SCRfZAH+2j5drScf0eRsfsWM364A/QYon1xnKIy5HWPSHxZSePPW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256107; c=relaxed/simple;
	bh=mzOPU1nRq/bpDwqoFQ2rylDfvUt/eO5QzJ/9Zzsibd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPY41UoyCeObGQuJX7grCsghPUom4YLlvXq4859aG9zpEZsuiGEAIgNYV5bE7ViKLSSRnZKvTmBFsqCP2sjdG/3Bp9YJIUDals+yHDyMsc0Xort63AB5NAW1CU1xhrIro2FucfnTdFBG0O3RjX1WkGU0CofN9vjqsberiiTlYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrDRY6u/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256106; x=1772792106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mzOPU1nRq/bpDwqoFQ2rylDfvUt/eO5QzJ/9Zzsibd0=;
  b=lrDRY6u/JETO4MLuiCaU7L5uz2mxo5zWztevSZlJPwZiLW6fanBF+P9D
   rSCLV8yVoUqJF3h5MJdZVWyZ/35+aapEbzRxAKJQzc+zZ7g1hOzykl9YD
   F7d5qH8mLui93A9ydVdhs/TJ9qXjCQqfdzFlyecTwA4aG1tXfudHnIqt3
   1oTIOeECYBYp5zRJ/ln/zBbq6n73og8zdc62AQqQ6DjyJ04LwzHsv+byO
   fZDRPRKRfUpaXwkhtJHzzZONsdLVrs4+Ez2slxajqNfQck9xSWqya4D6m
   YdYkN0m/DCTSqvwNwAbuQFOtldyvB9PomAN/XA50gIEECv1I/VKLCsEl1
   w==;
X-CSE-ConnectionGUID: Y8yJ3QzWSdSEAAfV0B2L2w==
X-CSE-MsgGUID: 9EiO1dEfTvqnyLMeXtbO9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29841335"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29841335"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:15:05 -0800
X-CSE-ConnectionGUID: pW57NHdPQxSL0gHklTP0ug==
X-CSE-MsgGUID: +f41jPjLSU6ZDII/HuFRVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118985851"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:15:03 -0800
Date: Thu, 6 Mar 2025 12:14:59 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	bleung@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Convert regulator drivers to use
 devm_kmemdup_array()
Message-ID: <Z8l1ozUOMTDNQupC@black.fi.intel.com>
References: <20250228072057.151436-1-raag.jadav@intel.com>
 <174077776750.602863.5336934105237710269.b4-ty@kernel.org>
 <Z8kFW13EyR0YXnJd@black.fi.intel.com>
 <Z8loo-N5byavJLkm@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8loo-N5byavJLkm@smile.fi.intel.com>

On Thu, Mar 06, 2025 at 11:19:31AM +0200, Andy Shevchenko wrote:
> On Thu, Mar 06, 2025 at 04:15:55AM +0200, Raag Jadav wrote:
> > On Fri, Feb 28, 2025 at 09:22:47PM +0000, Mark Brown wrote:
> > > On Fri, 28 Feb 2025 12:50:55 +0530, Raag Jadav wrote:
> > > > This series converts regulator drivers to use the newly introduced[1]
> > > > devm_kmemdup_array() helper. This depends on changes available on
> > > > immutable tag[2].
> > > > 
> > > > [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> > > > [2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > > > 
> > > > [...]
> > > 
> > > Applied to
> > > 
> > >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> > 
> > Thank you.
> > 
> > Unless there's a nuance intended in the merge series title that I'm unable
> > to understand, it probably seems incomplete.
> 
> I believe it's an issue somewhere in the scripts. The long Subject line is
> split in the mailbox and that's probably is not supported by the machinery.
> 
> You are not the only one who reports this issue.

While I'm not well educated on the machinery, I'm also seeing devm_kmemdup_array()
introduction commit reordered in -next and thinking perhaps it can cause issues
with bisect, especially after final merge into Linus' tree?

Raag

