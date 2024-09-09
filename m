Return-Path: <linux-kernel+bounces-321152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A925697153E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E0E287A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A79C1B3F2D;
	Mon,  9 Sep 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYD8EKc4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABC11B3B2A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877460; cv=none; b=oFplLamg8+dZk/ZBY20GvBosduqDOcjtK6aZeBLJsCKvjX/8B19ZwYNMtNTNyLvN0NgwmDeg7BBfjbD2i3DUpncg+47kgaB4IFhrIjIJjKGCdK2mUNTR1pa20q8yyK7FUbvqfMRdTzPwC5eBUeEe4yt4xbQ5oamJxxaO1m/QdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877460; c=relaxed/simple;
	bh=ZVTsv6mE4c+QbdDy/hXpfBf1KFLpsmMjFV4Obf2v6PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaR17KGvs+4lw1x0LrBJ4XPL7icsDy2auvECyfH065EUQOaBc/zw1cZNAsAoW/hFuwgDvdgsOM9y3ahk7qrlflGZwWYTLLr3747V7CGN1vOPKuq9Uf0qWawk05Y3voCk8vSKK28K1hzZeu+khVdWeMuhe0APpMjYOH2qJsxavFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYD8EKc4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725877459; x=1757413459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZVTsv6mE4c+QbdDy/hXpfBf1KFLpsmMjFV4Obf2v6PQ=;
  b=EYD8EKc4eeqMlilRO653bK5YZAgxol0JYvcV5OhD+Hbn/M3a6gFeyFXQ
   FxH53rxVbrua0R6l2zHiGitBv1NcB1mnd1v/Qf/q8Y3OtCA1z7bXjX1jF
   2AxPqoL78yD9CNeZbxyNR7MKHaRRlvPQonNv5DepodVDIt6T/0xNQaEg6
   bFmtXaAIp5KZaoBbJ8SG2ZCTVMuxBSgCy4xG+3CkRi4bJSn29zfk8JXw3
   5aDXhDIEDRH3alUNv9cqOkbaQXL9H/nTIXIsBmITY0H1VobUitrgUUmBy
   1ttZoZWkRYNavJDW7CbK0VTgWyvxHdMVAj+u3Id+5TI3JeO2C0Nktrn07
   Q==;
X-CSE-ConnectionGUID: zlJlJw1IQD+h30PKwI2qGQ==
X-CSE-MsgGUID: I2JB2tucTi6KdmERB9lrvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24710634"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24710634"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:24:18 -0700
X-CSE-ConnectionGUID: J4a3eApZQWKYKJsZxELFLA==
X-CSE-MsgGUID: q9KgARB8QG+rGYeDYz6Ytw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66418679"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:24:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1snbZ7-00000006kde-1Au9;
	Mon, 09 Sep 2024 13:24:13 +0300
Date: Mon, 9 Sep 2024 13:24:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] maple_tree: Drop unused functions to fix the build
Message-ID: <Zt7MzNVNmQ1j7_UW@smile.fi.intel.com>
References: <20240906150533.568994-1-andriy.shevchenko@linux.intel.com>
 <krsjmi43ziyojqicc4pxzwfwbffqrnk5npbuoq6l2cnq5eovkd@afofyteb5wo3>
 <ZtsjJoGKRxszp-m6@smile.fi.intel.com>
 <3murs2k4mouy5gkzyav4ttrqanhsc7v4hpghmuutkokvah2o2v@pkddt5ziu33o>
 <Zt7Cssu9SQury1bU@smile.fi.intel.com>
 <Zt7GJpK4ZzFZeW4S@smile.fi.intel.com>
 <77c9f504-956f-4b49-b626-8c75184e0e72@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c9f504-956f-4b49-b626-8c75184e0e72@lucifer.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 09, 2024 at 11:16:49AM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 09, 2024 at 12:55:50PM GMT, Andy Shevchenko wrote:
> > On Mon, Sep 09, 2024 at 12:41:06PM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 06, 2024 at 04:05:47PM -0400, Liam R. Howlett wrote:
> > > > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240906 11:43]:
> > > > > On Fri, Sep 06, 2024 at 11:26:26AM -0400, Liam R. Howlett wrote:
> > > > > > This exists to stop people from using the bits while the feature is in
> > > > > > active development.  We had the same patch a few days (weeks?) ago.
> > > > >
> > > > > This breaks build. Can you propose better solution, please?
> > > >
> > > > Can you please provide the config file and clang version that fails on
> > > > this error?
> > >
> > > I believe any of them where this module is marked to compile
> > > (and since it's listed as lib-y, means _any_ configuration will fail).
> > > For your convenience it's x86_64_defconfig in the source tree.
> > >
> > > Have you had a chance to read the referred commit?
> >
> > Btw, if you really, really need those stubs the workarond can be moving them to
> > a header file (IIUC what's this all about).
> 
> This issue is resolved by
> https://lore.kernel.org/all/20240907021506.4018676-1-Liam.Howlett@oracle.com/

Thanks, however I was expecting to see myself either in Cc or as reported in
that change. Whatever, the problem solved!

-- 
With Best Regards,
Andy Shevchenko



