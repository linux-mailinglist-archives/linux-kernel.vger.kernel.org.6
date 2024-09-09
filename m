Return-Path: <linux-kernel+bounces-321101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A72971483
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C601F23831
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4E11B3748;
	Mon,  9 Sep 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4f91vdo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9791B29A5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875778; cv=none; b=fomjDpnOMTT0qhXLEus2iWc82Rr5Kh5l3S8IxfKkNXqcbzahxT616tgK6u9jRaig0iZh0/Fh9cF8l++MN4uYQaYz2MhxXI/Mi7am+mi3mQbGgqIgRAPL3xqr1d7EybUoReIdWhcw7inPSRp5j6KvBxeDAfpRB1SYesic25zYT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875778; c=relaxed/simple;
	bh=d8GKYd3qQsx1O1OH6iabihHDLHuEdiEm0q7A7uKP0vw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmI2MKkldaENwQcGAg21qrjeUjJdpXBaEgW7tWCqowilnrTLSrRvQEMyOJL7PJQ6vJ8ilC7nj2ZkIS0fWXqd5bVQhQaRzMZ6O7BElUIKioSGpXnh9xbhypcHNEVofat177wYgoftAx26sitGzS2cNsjaqCw5tHKGD8PIMpAbsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4f91vdo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725875777; x=1757411777;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=d8GKYd3qQsx1O1OH6iabihHDLHuEdiEm0q7A7uKP0vw=;
  b=G4f91vdostRoa38eOoZGgfPwgAm7nLCkQbD09Gn2ke+gxQQrxg9MDnWS
   K0py8+TgGgj3STi1qI54pKym0vfb0LFXmhZc9HpTiZVetsOclZ947d5WW
   LTVcfKarjmPIswGfv5e9l6CmcPL8xwKh8nG7ny3TvGkXjXERl+/+1ODqH
   8IAZ5RSZ/9XgnDT+eW36BHzo4P3nZlp5lNKrAVCc32bI2+iCv8D4lNQOe
   JZVmZzPujFV7vl8ZSlBYrsAY/8jDY5xkCPJy0I8F0vQE7G3vWN9EfG/hT
   YdRx6NvVZAqRjCLwbj3v6vGj4/hqOOjpxbkNo9+a+PUwFNtZY5J2+R9pa
   g==;
X-CSE-ConnectionGUID: 16OXFFftTYigtWcg8GdcLA==
X-CSE-MsgGUID: 27qRUpJLRaqviAYStezeSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="35943683"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="35943683"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:55:57 -0700
X-CSE-ConnectionGUID: Dt6B9e8FRKutluaIPuqY+w==
X-CSE-MsgGUID: 43T2aRR2SkuN07T1gJw3iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71203595"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:55:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1snb7e-00000006k4N-1a4l;
	Mon, 09 Sep 2024 12:55:50 +0300
Date: Mon, 9 Sep 2024 12:55:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] maple_tree: Drop unused functions to fix the build
Message-ID: <Zt7GJpK4ZzFZeW4S@smile.fi.intel.com>
References: <20240906150533.568994-1-andriy.shevchenko@linux.intel.com>
 <krsjmi43ziyojqicc4pxzwfwbffqrnk5npbuoq6l2cnq5eovkd@afofyteb5wo3>
 <ZtsjJoGKRxszp-m6@smile.fi.intel.com>
 <3murs2k4mouy5gkzyav4ttrqanhsc7v4hpghmuutkokvah2o2v@pkddt5ziu33o>
 <Zt7Cssu9SQury1bU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt7Cssu9SQury1bU@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 09, 2024 at 12:41:06PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 06, 2024 at 04:05:47PM -0400, Liam R. Howlett wrote:
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240906 11:43]:
> > > On Fri, Sep 06, 2024 at 11:26:26AM -0400, Liam R. Howlett wrote:
> > > > This exists to stop people from using the bits while the feature is in
> > > > active development.  We had the same patch a few days (weeks?) ago.
> > > 
> > > This breaks build. Can you propose better solution, please?
> > 
> > Can you please provide the config file and clang version that fails on
> > this error?
> 
> I believe any of them where this module is marked to compile
> (and since it's listed as lib-y, means _any_ configuration will fail).
> For your convenience it's x86_64_defconfig in the source tree.
> 
> Have you had a chance to read the referred commit?

Btw, if you really, really need those stubs the workarond can be moving them to
a header file (IIUC what's this all about).

-- 
With Best Regards,
Andy Shevchenko



