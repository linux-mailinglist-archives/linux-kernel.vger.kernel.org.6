Return-Path: <linux-kernel+bounces-297283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CB395B55E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849E11F24C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88D1CC150;
	Thu, 22 Aug 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0gDflyA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849C1C9ED0;
	Thu, 22 Aug 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330763; cv=none; b=AmNvU88q58jV6VAofOVsT+DLQaXfziEv0zGWHBQjNURyrNw6wx8KFA29vqDVfvURph+yqcnxMDmqvdV2aHwVD1dZZAkP45Oi1JnjcSW1yXGGOxsGDe0kxe0Hop5QzkcAj2jm3njmh2ZZ+qwkicD6CKorj7AsO8kRTSla1lJojaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330763; c=relaxed/simple;
	bh=ZptpOyorYson3smL4eOhjqvQZ7eJWefy9xPRGMYiMMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJhiue+5ybTgpZVnHsx0muihS+n6dB1SG49XWlCY8wCBleeVOrc1hC0jMp8aV49XjsE4Mp3E4lUJGpQzy8UbBmUbWPda3pwgJXAKPmpUV/s4h2fmkRP8Ue1/v/eCRi0ZLTCeN8LLlVyM0Bmyal3xKgbVpuBKjLHuZuMV2a6y6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0gDflyA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724330762; x=1755866762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZptpOyorYson3smL4eOhjqvQZ7eJWefy9xPRGMYiMMo=;
  b=f0gDflyAzfKX/YvTugiiOfeaiEod4BxfMveIyLdq6mu5OO6FWdsm3+wI
   A8H5gtIDh6vuC4G703GMq6k1wKA+Aourktcsi14kVKX6SRmBEPU3ofG7p
   Qs8CuRRUaEFnZMOEKWtNhpBXTgzUUc1Nyg6fR9rTG4ElzO9lO0wlpD9XW
   FlpdHDqE5MzkIcvD2919jJZCy8oF76eqPekXkxRIp4yk+OiZUiWwLXeCa
   EMcLsjhyHkuDYMu+4fA3CzkZneuboUOJiF9IVn1EXBsoycjNrnfcihiOy
   HBiTBGtRg1mHh6oPd88P4JjB5DZTfsoJgetu2NZEIpsRSWZQla4mLQeje
   A==;
X-CSE-ConnectionGUID: kRf9wABTQmG5ApDK6r6mBw==
X-CSE-MsgGUID: 3C92xWsdQrWU8Kyb0Y4BFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22911762"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22911762"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:46:02 -0700
X-CSE-ConnectionGUID: c/3WxIs/Qe+K5Mo4hgx3eg==
X-CSE-MsgGUID: jUL5gKTnQaWZ8tPpDbmz0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61456770"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:46:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sh7CP-00000000S3F-0Qic;
	Thu, 22 Aug 2024 15:45:57 +0300
Date: Thu, 22 Aug 2024 15:45:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v1 1/4] driver core: Ignore 0 in dev_err_probe()
Message-ID: <ZsczBIy7sZOxwZGJ@smile.fi.intel.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com>
 <20240821122233.3761645-2-andriy.shevchenko@linux.intel.com>
 <1dde296b-045e-d56a-1734-a1333a84060b@linux.intel.com>
 <ZsXntvP6eBB_092w@smile.fi.intel.com>
 <2024082213-yogurt-kerosene-92e6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024082213-yogurt-kerosene-92e6@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 22, 2024 at 07:32:33AM +0800, Greg Kroah-Hartman wrote:
> On Wed, Aug 21, 2024 at 04:12:22PM +0300, Andy Shevchenko wrote:

...

> I like it, and will be glad to take it if you update the documentation :)

Consider it done.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



