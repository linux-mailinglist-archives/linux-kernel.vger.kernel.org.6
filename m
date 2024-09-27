Return-Path: <linux-kernel+bounces-341953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A4C9888CA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F268E1F24EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3632E1C1725;
	Fri, 27 Sep 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFaN/HFD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CC1465A9
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453537; cv=none; b=LKIsRDIO1djlMiujLUhDgAaUYNPaEc3N1akyY9e6yA/zYN13cfw9Ji0NS+0XtQ/BMj8d46rmN3osBqQUs26eFMfbHP6KAE1Gq3V9Fsg5tub43cZB/mRxxx2yVa18nIE6LXiQkgUGkVvuRsHa88rgUlM30CvZojY/k9w7jo3BDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453537; c=relaxed/simple;
	bh=X79qvOpP7Haz1lh12lIQHIPKIGkP5JAG3xeYPU03R9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4+33oVcrEr+p8ahLkhu/RlHu3ExB9Qe4cPqHu6RTvCXyMY3Ah38Ir0slwHbiM2PozaUmZeLQqFbPByzqlGTDD/cbJwRTKeS7PGVehVq6/iL95ajLwZhumVtH5L3dAyMYmbmCR01s9n/vYKzW7WbSelQNgwyYE1JO/YYy+aX+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFaN/HFD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727453536; x=1758989536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X79qvOpP7Haz1lh12lIQHIPKIGkP5JAG3xeYPU03R9M=;
  b=kFaN/HFDLg3nZQawlr6Oj+BATML8ztZx27/8Xoykd9GJcqC7Pwe2+hJ8
   uDZluCc1+pfZiomv7pHzmOkrpI+6NNFV6DEn6xDNHCLDSM1XjyDwaXn20
   7vMJlS2JI/lI91jAVdKu+8B75UG6Dz8fHk+8aN1dTrvHl6mqkxVQeW5xo
   EwWolh3S3VdmjZVTxvr3JtXx5ozCEQnC0Dn2kYS6usfLOm4/YCiKbujPb
   l1hyaeEzT49NdNIDXrsGIQp+s7BbrSE02eMaPMPl6/CBr+5lTz7aYfsMq
   tM+0fzmX0sxID6+/JKK1VCRMzkLFpInflxSHpG70bT21PUZNVzLRZvwGy
   Q==;
X-CSE-ConnectionGUID: YC7jNjaSQoef7znqZ7rexg==
X-CSE-MsgGUID: Iyp28rVpQlOt9osHMsdNJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="14225815"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="14225815"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 09:12:16 -0700
X-CSE-ConnectionGUID: 2Z0qTn05QEueYEpLLhBaiw==
X-CSE-MsgGUID: xBe9mr3lSBqdO/XTCHt9eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="72157345"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 09:12:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1suDZj-0000000DeeV-3q6h;
	Fri, 27 Sep 2024 19:12:11 +0300
Date: Fri, 27 Sep 2024 19:12:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Keita Morisaki <keyz@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] devres: Fix page faults when tracing devres from
 unloaded modules
Message-ID: <ZvbZWzW4I2CYNe3r@smile.fi.intel.com>
References: <20240927142807.544325-1-keyz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927142807.544325-1-keyz@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 27, 2024 at 10:28:07PM +0800, Keita Morisaki wrote:
> The devres ftrace event logs the name of the devres node, which is often a
> function name (e.g., "devm_work_drop") stringified by macros like
> devm_add_action. Currently, ftrace stores this name as a string literal
> address, which can become invalid when the module containing the string is
> unloaded. This results in page faults when ftrace tries to access the name.
> 
> This behavior is problematic because the devres ftrace event is designed to
> trace resource management throughout a device driver's lifecycle, including
> during module unload. The event should be available even after the module
> is unloaded to properly diagnose resource issues.
> 
> Fix the issue by copying the devres node name into the ftrace ring buffer
> using __assign_str(), instead of storing just the address. This ensures
> that ftrace can always access the name, even if the module is unloaded.
> 
> This change increases the memory usage for each of the ftrace entry by
> 12-16 bytes assuming the average devres node name is 20 bytes long,
> depending on the size of const char *.
> 
> Note that this change does not affect anything unless all of following
> conditions are met.
> - CONFIG_DEBUG_DEVRES is enabled
> - ftrace tracing is enabled
> - The devres event is enabled in ftrace tracing

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
thanks!

-- 
With Best Regards,
Andy Shevchenko



