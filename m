Return-Path: <linux-kernel+bounces-284336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22805950002
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550FE1C22968
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A0036B11;
	Tue, 13 Aug 2024 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neHDMpSU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02513B2B2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538362; cv=none; b=uwnlsA6EOq1rim98veN0muLiGplBr28ikbwP4peFuTfGpDmHKqmqExYbtSB4R6sh7Vib6CVqxHiWSbSirrsgkoU9HP1YQZS76ODLKc6i4vRdp6FHq3Ncyr34HBD2TH+0+GvUT/AHQq8xjJa8Qyd/gwF3dcjLpKWJjhlqKIjUKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538362; c=relaxed/simple;
	bh=bofTMDTXtmUg+7I2VrORMBCyXP2uCC2u+2ZKVpp5x0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhAm2nicK+FCXSZ7UFP3q9PGHAUgW949bdKlponTnfKA/nHVN99Rb9vFJ+iWxkqf1uFTD5OS3iflLOSBSP3i3U8z11ApvTuC65Iupo96Yoc0VMBW+IrZB0tEJkyZqmNTZJKT1YweI1FcjBHhgBqbFgx4CU2lYd2vEHBEsXT7Eb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neHDMpSU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723538361; x=1755074361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bofTMDTXtmUg+7I2VrORMBCyXP2uCC2u+2ZKVpp5x0k=;
  b=neHDMpSUBfvqvW/uRBbQQOgc+rC3MxRgHweaizUDckhvsWu/MuYWxAAg
   8J3bCt56o8UkPthsrrTlrhMpTTo69LtbqCIUmL92zFpFg8yHHHsj9FrYF
   a8K98EikRVxusCuxi2U0LiWKjhSwd4LhHA9BXCuZmBDreYgsaE+v4jQEq
   tIhJsmWUSCj9r5Q4zf02GUDfkAkEDnwUBf8+5E3SiD/+/OfPhMzHhN+7d
   tnp0bvzGw8e/u3ZcC9AHQqEIHEkpNb+ndhKtSGjw/a6Lt+0YgwtwbNQBk
   quM3XaHuJlKtKAhYEdWaCA685BFbHC7baDCvuG6vTo5x2HPn+IltqhGbV
   A==;
X-CSE-ConnectionGUID: X7Oy+c5mSCGfSDjbvvlXgw==
X-CSE-MsgGUID: SPro8YiiSBSn5w1T/cmzlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21855089"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21855089"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:39:19 -0700
X-CSE-ConnectionGUID: P0Oqp07oRke+SnBMmctSXw==
X-CSE-MsgGUID: oI7Ff9rGS4W2vWYW8Wcbdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58546108"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:39:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdn3j-0000000Ef7V-0ET8;
	Tue, 13 Aug 2024 11:39:15 +0300
Date: Tue, 13 Aug 2024 11:39:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Tal Gilboa <talgi@nvidia.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v1 1/1] dimlib: Use *-y instead of *-objs in Makefile
Message-ID: <Zrsbsn0aGAb2akjX@smile.fi.intel.com>
References: <20240508143039.1196671-1-andriy.shevchenko@linux.intel.com>
 <c0ce1a9b-d63d-43e7-96f0-6eeb35051f63@broadcom.com>
 <Zju7ZNSMCSzbqCGO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zju7ZNSMCSzbqCGO@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 08, 2024 at 08:50:28PM +0300, Andy Shevchenko wrote:
> On Wed, May 08, 2024 at 10:39:55AM -0700, Florian Fainelli wrote:
> > On 5/8/24 07:29, Andy Shevchenko wrote:
> > > *-objs suffix is reserved rather for (user-space) host programs while
> > > usually *-y suffix is used for kernel drivers (although *-objs works
> > > for that purpose for now).
> > > 
> > > Let's correct the old usages of *-objs in Makefiles.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > 

> > > 
> > > Reported by Olek. As I said him this is correct change which is
> > > documented in Documentation/kbuild/makefiles.rst "Composite Host
> > > Programs" (mind the meaning of the word "host"!).
> > 
> > Why not credit him with an official Reported-by?
> 
> No problem
> Reported-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Who is going to apply this?

-- 
With Best Regards,
Andy Shevchenko



