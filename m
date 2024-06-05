Return-Path: <linux-kernel+bounces-203412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6118FDA9C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D461C21DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DC8167D85;
	Wed,  5 Jun 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfRRpUii"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F261667DD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630586; cv=none; b=qfgrXag1HK4qwyV1H6UcolGBTWsY9r2QUiJi3jLrjUlYsW3k7Z5HV2AP6yNsdyO89usqdZiuV6vDx9kIjARKx6LRrVhI6uPLG1OAlnkwKufXF7d7HwFS0Zoi1zce87QvEbXg2YoTqqErsan3yfbjF0oGbQldrBE052St2jn/sgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630586; c=relaxed/simple;
	bh=xdASMDf4Tm82GtJgefF/t3MYj6IeJ/Clz6nY3OU+qpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shk+l+cyPFm5avCtqW68OIEbNQrbG132rMhxX9uhvwU4pKPq+P1/66jfp6n6CyhFGHH1S78+htNYoZIagIvps/LwsWHNp5LGXw/h0CpUeR3CGDM3+loZIhxxsgxUwuVHn3RwTCHaSQVIshwYlOEZvMQTzIMm0wzn+x7MtxTPd1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfRRpUii; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717630585; x=1749166585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xdASMDf4Tm82GtJgefF/t3MYj6IeJ/Clz6nY3OU+qpk=;
  b=VfRRpUiiaoda/MJAbVMW7sSOqm8tkQ2utYLyOtedT3QCew00fBXbB6cA
   boEaI/R2rO5GWT5emumWEAxbtLz72hEdb7GuMbfpnLVZSm4vitiEv2pPK
   1FbIDBGEdRu3eirLIjh8uQ6EoMUN26iNMpt+oOipaGNG7gbAOIZQj62jN
   xHtEe3a+Ugld7WFpDjPTPkB0CwSWWvI96DwQ7plCQPzWxYorBjuvwc64V
   Sp5usggvWxMDvIUNSfCszNO7PF0OUtuddw4ko9Rk/F9049MO4zaElCknz
   AJObn7MroHiX3EWylCOu6N23Y0xTWVDqK7uBlsKeKLcozIblwu56QCrA7
   Q==;
X-CSE-ConnectionGUID: Tfi2MuirQZOY7f9nQjPD2g==
X-CSE-MsgGUID: J4cnwUFjQQWG/wRCDNCh8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25382958"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="25382958"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 16:36:24 -0700
X-CSE-ConnectionGUID: NgQcYZ+ZSNWbxu6/zPfF5g==
X-CSE-MsgGUID: Q1B0DD+MSJyc/AD03pHZzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="38195924"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 16:36:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sF0B1-0000000E00b-1cXd;
	Thu, 06 Jun 2024 02:36:19 +0300
Date: Thu, 6 Jun 2024 02:36:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] resource: add a simple test for walk_iomem_res_desc()
Message-ID: <ZmD2c0rNz10KsPA0@smile.fi.intel.com>
References: <20240605212840.3227774-1-olvaffe@gmail.com>
 <ZmDiYze9MEFxn50C@smile.fi.intel.com>
 <CAPaKu7SJ5TVXsqnsqnucpE=wVKwGCdXyCTNBhr+rcJrmLw5GgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPaKu7SJ5TVXsqnsqnucpE=wVKwGCdXyCTNBhr+rcJrmLw5GgQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 05, 2024 at 03:52:26PM -0700, Chia-I Wu wrote:
> On Wed, Jun 5, 2024 at 3:10 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Jun 05, 2024 at 02:28:26PM -0700, Chia-I Wu wrote:
> > > This mainly tests that find_next_iomem_res() does not miss resources.

...

> > > +     /* build the resource tree */
> > > +     res[0] = DEFINE_RES_NAMED(root.start + 0x0000, 0x1000, "SYSRAM 1",
> > > +                     IORESOURCE_SYSTEM_RAM);
> > > +     res[1] = DEFINE_RES_NAMED(root.start + 0x1000, 0x1000, "OTHER", 0);
> > > +
> > > +     res[2] = DEFINE_RES_NAMED(root.start + 0x3000, 0x1000, "NESTED", 0);
> > > +     res[3] = DEFINE_RES_NAMED(root.start + 0x3800, 0x0400, "SYSRAM 2",
> > > +                     IORESOURCE_SYSTEM_RAM);
> >
> > ...here is overlap with the previous resource.
> >
> > And here is the gap to the next one, in case we make that overlapping gone.
> >
> > > +     res[4] = DEFINE_RES_NAMED(root.start + 0x4000, 0x1000, "SYSRAM 3",
> > > +                     IORESOURCE_SYSTEM_RAM);
> >
> > It wasn't the case in previous data. Please, elaborate what's going on here?
> The test data is chosen to be
> 
>   first interval: a matching resource (res[0])
>   second interval: a non-matching resource (res[1])
>   third interval: a hole
>   fourth interval: a matching resource (res[3]) nested in a
> non-matching resource (res[2])
>   fifth interval: a matching resource (res[4])
> 
> The idea hasn't changed between revisions.
> 
> res[3] went from a half of res[2] to a quarter of res[2] in v4.  I
> guess it causes confusion if it is not viewed as a nested resource.

Okay, so far it's correct data from testing p.o.v.

Maybe you can add a comment on top explaining this layout?

...

> > And rather sending one version per 12h, take your time and think more about
> > test data. What are we testing? Are the testing data correct? Shouldn't we also
> > have negative test cases?
> The current choice of test data covers the most common patterns.  Do
> you have other patterns you want to cover?  I am new to the resource
> code and that's why I am largely reactive to review feedback.

Nope, seems okay to have what is there for the starter. Later on we might add
more if required. Just got confused.

-- 
With Best Regards,
Andy Shevchenko



