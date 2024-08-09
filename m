Return-Path: <linux-kernel+bounces-280908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330F494D0B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659171C21EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4CA194A60;
	Fri,  9 Aug 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENrs2Rdn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338C18E03F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208361; cv=none; b=uqTOihK9t8tytaNTynC1DrOLj5NVk1NSDPEiONqGqFKZ+FNERekUk+i1gDIZZJn8C7nwtc/+3YW8+yev1urVcgkKeUbUk72P5dP6KBCyTKiu5vNsYvdTHfQByF3hTaBKNFW+yJ9v2/Zpiqs9ZBYcl2yB1pk4ezHiXWVYNA8+N9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208361; c=relaxed/simple;
	bh=bE+g6cxy1g+4+9qKZKD6t1egfjPMQ9zvqNCrBZ/mzgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUdO9PSjAzbE7VfjaEbNIFRihS151v6f0HwIm3sG0q7l3nLW4dUoM1z+TgsSf6CryY88NfcHncJFHp6mnshccqmUYx6PkZfwJ24/uQVWA+beEoV5ohDS+spHtFFTFIaHoypIJhCD5sCpJai33mCLk7XH+acuiM6M2+4nDNlYKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENrs2Rdn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723208360; x=1754744360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bE+g6cxy1g+4+9qKZKD6t1egfjPMQ9zvqNCrBZ/mzgo=;
  b=ENrs2Rdn2EfYSs3goqVsoViy18lgDzNvtPyTm9I1tc5Xx5me37FD5YlD
   JSYWGW85q4Non2s4+uvTnrrD9TTUg/RHRRgfH/46i6oSHMhctBcql4pDb
   tqoHAbKHAbdPgMz147shJRPmECdDKmrybWB1FfMLiCyxujQADL83v9qBB
   9inyODs5qCJrnonIhuc3K2DEJYk+81szd1NA6CemkgDWyxA4OXC/eEpQR
   3vBo0UqOOTpyRDSWyMVfyXBvMLw1OYMUfWkj2R8YFD7YakAnlqBh0Yq8b
   DO5kxg+Rs0UouVB0gpxe+piTXNffsDt9amSe+P35L8JD7eA0SOXwIHVdk
   g==;
X-CSE-ConnectionGUID: R9W6TCjVRtGAJsr7iX8uWA==
X-CSE-MsgGUID: NfZY21MJQSGB3lzWfWgBtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32527222"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="32527222"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:59:19 -0700
X-CSE-ConnectionGUID: ETObeaf7SniuxezNGMOlXw==
X-CSE-MsgGUID: PW78km/8R+6ARGtiovrgxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57770315"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:59:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scPD7-0000000DQBz-3G69;
	Fri, 09 Aug 2024 15:59:13 +0300
Date: Fri, 9 Aug 2024 15:59:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 1/1] container_of: Document container_of_const() is
 preferred
Message-ID: <ZrYSoQxHxyA5vsGT@smile.fi.intel.com>
References: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 17, 2024 at 01:08:25PM +0300, Sakari Ailus wrote:
> There is a warning in kerneldoc documentation of container_of() that
> constness of @ptr is lost. While this is a suggestion container_of_const()
> should be used instead, the vast majority of new code still uses
> container_of():

A side note...

> $ git diff v6.8 v6.9|grep container_of\(|wc -l
> 788
> $ git diff v6.8 v6.9|grep container_of_const|wc -l
> 11

This is classic "Useless use of grep".

$ git log --oneline -G 'container_of\(' v6.8..v6.9 | wc -l
296

However, if you really want the _new_ code only, you have to run to `git grep`:

$ git grep -n -w container_of v6.8 | wc
20763

$ git grep -n -w container_of v6.9 | wc
20943

180 new uses.

-- 
With Best Regards,
Andy Shevchenko



