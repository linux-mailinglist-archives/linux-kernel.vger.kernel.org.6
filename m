Return-Path: <linux-kernel+bounces-413030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130CB9D127A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1DF2842A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4982319EEC0;
	Mon, 18 Nov 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1l8HS+Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA651E505
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937962; cv=none; b=t0vY+LktgGKCRdD4E9/IigiRar6tepCs/73YiKVA1rRmZBnqbgPUQ3J/pk9cjImj/x+ZDZoJjaeG4gKo6eySrDulmbndhDV8qPIqb1J4QmQ0niZpwamO8+R1Ms/vxuMYQkFn3eWJpgYGPXgAPHOLyOWw/al6xIVeHxADzkbtfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937962; c=relaxed/simple;
	bh=Q7O9mWl7+BQMGLJkUqrTHli6vcK8EfFRMfbgY2ETzBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnl1nyP//SvKtKsKyQMydUHX4YGDdlMq1/v7gLqu69KOxNBqra+xuL778szxR0IRUuF77Vj2VIFZNAImI1kAovSYHkIjG9flDiOviYnHYrKICJDHzAmDPETOApFUkdEC7CIqjuzc9Yc5zHLeh7cI8QOgP0mjYJz7dVfUHEZFcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1l8HS+Z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731937961; x=1763473961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q7O9mWl7+BQMGLJkUqrTHli6vcK8EfFRMfbgY2ETzBI=;
  b=i1l8HS+ZT5VrOaAp+Y3kJuZ8DqpLQRPXYnywX+S3UaQ3cRy6R+WeOdgJ
   gi7QCkLme/GUjxy/6wIAZN9GKY4eNWKhniXPYYCkSuRoJh0atCuEMn294
   lDtEn6LvL6dPhc/ChkTyjnCQ1DxNFfdNk4sM1QsF9e0ICOx+b9ib9n0G5
   5ev8NTmxDZne91K2B7mJjlOnE0jFDlQWzQlfptK9OYbulEjhUBckINnP9
   RiScee/YTa6gtuU9ymz2zj7sfxRY3umxalchaV/Ub56/6/WKrKnal0puX
   NI7Rf05GS833c9hZdelMswHeG/hXL37twsTOvIrRQ1HZhjVdrPulNfoH/
   A==;
X-CSE-ConnectionGUID: stFcB9QpSYO33HE10Gr5+Q==
X-CSE-MsgGUID: fnM6ASByTImB7X1K1tymLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="42409427"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="42409427"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 05:52:40 -0800
X-CSE-ConnectionGUID: bbeogFUzQPaoZmZH8pmvRA==
X-CSE-MsgGUID: 2LUMntXjTmqeqp7UXHhENg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="88797742"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 05:52:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tD2B9-0000000G1Qa-2d5R;
	Mon, 18 Nov 2024 15:52:35 +0200
Date: Mon, 18 Nov 2024 15:52:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Daniel Walker (danielwa)" <danielwa@cisco.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ilpo =?utf-8?Q?J=EF=BF=BDrvinen?= <ilpo.jarvinen@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danil Rybakov <danilrybakov249@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Message-ID: <ZztGo2bO-R1nclDE@smile.fi.intel.com>
References: <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com>
 <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath>
 <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <13e47dee-848f-44b5-bcea-2216685069c7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e47dee-848f-44b5-bcea-2216685069c7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 02:29:42PM +0100, Hans de Goede wrote:
> On 18-Nov-24 2:24 PM, Andy Shevchenko wrote:
> > On Mon, Nov 18, 2024 at 12:40:16PM +0000, Daniel Walker (danielwa) wrote:
> >> On Mon, Nov 18, 2024 at 11:30:59AM +0000, Shinichiro Kawasaki wrote:

...

> > Still wondering if we simply unhide it early
> > (if it was hidden) and assume the p2sb device is always present. In this case
> > p2sb_bar() will become almost an equivalent to the pci_resource_start().
> 
> That would basically open it up for normal PCI drivers to bind to. Which is not
> necessarily a problem, but I wonder if we already have such drivers which then
> all of a sudden will start binding to it ?

AFAIK we have no P2SB device drivers in the kernel.

> Note that e.g. the GPIO code in lpc_ich.c checks if the GPIO controller is not
> ACPI enumerated before calling p2sb_bar(). Unconditionally unhiding the P2SB
> would not mean that at least the GPIO part will be enumerated twice, once
> through ACPI and once through PCI. I'm not sure if that is a good idea.

I agree, but how can it be in practice if p2sb is enumerated without creating
any devices behind it? I mean if we have the p2sb driver for solely purpose of
p2sb_bar() call.

> My vote would go to fix the problem of the PCI device being removed by
> the p2sb.c code when it was not hidden.

-- 
With Best Regards,
Andy Shevchenko



