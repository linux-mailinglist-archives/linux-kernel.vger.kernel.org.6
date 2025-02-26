Return-Path: <linux-kernel+bounces-533947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A779A460A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B9F3ACC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BD821C9FA;
	Wed, 26 Feb 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXNV4NZT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD9258CCB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576151; cv=none; b=IgKtafObLsXc/lUaWRHNzHWcOs27wvtpy2k6kNQDCEBLDgP4rEEP5UruRZavyvmIChktRKVJghSa8e2Kaau2fa8sl+EFm64YvqKPFfLOuwafm6y0zXRsm2JtOofHuCsnq2AOLM6dWmqVDd4BqU6OG1JTS6f6JLJTxZ8DuA3TFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576151; c=relaxed/simple;
	bh=F4EDCOt+pN0vItg4IqYGZS5cM2Bt7kx6pZt5jApU9o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWaNN0gEJCh5pJ5vOiNMJxXdO4tPqxP96hybpn8qSmjLY59tiMb+o/Y7lXdqp4BezYB3yJLzooMV1UHzr3GJbw/zi8iCfYxKjKhzYwmka8LrvqPhtmUYF7VIli1IYKYTOEPeJl8wGn4P+y6TFdPPfLjY7WDTNXYIA0fQG2LNqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXNV4NZT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740576150; x=1772112150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F4EDCOt+pN0vItg4IqYGZS5cM2Bt7kx6pZt5jApU9o0=;
  b=XXNV4NZTinZNQnqMRqY0ktWC1aORDsQYUuU9E3xwM3oR1u4WaviKdV+U
   AQI5aFgXlq1mlw9gaa1g1uL2tBTSsPggpCyQVo4LaiECrWCVvPAW/KoGO
   uUIFj8ZMFTWbKsv89pHQL9L3DqqHA7FB/1zk0/a/YFLY4HzumzvXKM92y
   oIBj91DXU4+opxhddLGQwvX8Hkyx/JyLKJMJ2/bt0ZAScyauAFXlVq8ND
   LHcN8vQ/CCkZaTBXxjh2XxIMFSeGX6ycrrqIcnB09LqIAGoeNVhZHPY2j
   +p4xiLhmgBH97ZyWcOeagWf+i5atHYuubL/JkQItgoAO9R3UjCWzxnN10
   A==;
X-CSE-ConnectionGUID: 0qv9J6qoSvKqq3QpUfXJ9A==
X-CSE-MsgGUID: SW6jvaH0Tz2UXeQVkkF/CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="66791351"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="66791351"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:22:29 -0800
X-CSE-ConnectionGUID: OUQayhPtTsCfClUhjmwcSg==
X-CSE-MsgGUID: 6tT3gXXJQfe1nByuA8qkRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="117189432"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:22:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnHMm-0000000FKhp-2rnr;
	Wed, 26 Feb 2025 15:22:24 +0200
Date: Wed, 26 Feb 2025 15:22:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: lee@kernel.org, giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mfd: intel-ehl: Introduce Intel Elkhart Lake PSE
 GPIO and TIO
Message-ID: <Z78VkEnJh8l9MWF7@smile.fi.intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-5-raag.jadav@intel.com>
 <Z78VIjgkzf_GlauU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78VIjgkzf_GlauU@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 03:20:35PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 26, 2025 at 11:45:27AM +0530, Raag Jadav wrote:

...

> > +++ b/drivers/mfd/intel-ehl-gpio.c
> 
> We are usually align the file name and Kconfig option, and I like Kconfig
> choice, so intel_ehl_pse_gpio.c (also note the style with other intel_$SOC_*
> files in the folder.

And also Subject, you have currently 3 different names for the same:
Kconfig, Subject, filename.

-- 
With Best Regards,
Andy Shevchenko



