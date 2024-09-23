Return-Path: <linux-kernel+bounces-335916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E60E97EC8B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7C6B20FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB9312CDB6;
	Mon, 23 Sep 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jx5NFNrZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89A126C01;
	Mon, 23 Sep 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099053; cv=none; b=aYxqhUwV7NOIsNYQsa5ddfIYhSTuSC+50v/ipTX+B4Rb7cDyLrUDlHnq1tRE+DnWkT31IutxyBbJpxWS5QXhpIvyFfL/qYf4W57yt+EcKk6u1udcpdHepprFpqtwZVSrPurGuzo7dimBGh/qlsR6D2qPyVRqZPd+laeRRk4jfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099053; c=relaxed/simple;
	bh=N5NIP3ZW+5iVO/QubsRqPXXSLKWvzlJWTErvwa2ixIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUPjIuODFAyLHK0DNXvje436pz4eJ/1SfxcaV1TTHXsP3qOIcL0tpOtJ3jodYlGkww4/vt40RfgYgXVrfw1b7G/UUa8kMBc1ypq79d3MGjzd+pmq65lh7o/3RdFCqBeQn/P8tkIvWsN4UcWs7JfB6s6LSVB6j7WXZodONd7daew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jx5NFNrZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727099052; x=1758635052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5NIP3ZW+5iVO/QubsRqPXXSLKWvzlJWTErvwa2ixIA=;
  b=jx5NFNrZiWdZeGYBw2Xc4OkQO6VWcVfUZ0quJdcMO1MfwgDl2LC0zzk6
   1VCfskQYuIgUQXspbwsJc/aD6/zISxX/YwozrcZpYtNWlI6bLgQQcUBbX
   Pd2xDSwyEGtLP/lmeoL9wWBQWHAQsptGpm8pvQrhO2BpFD4Q2u13jQGEU
   UksSw4Q+75yAd/Bwc8S0hgJxaDc7P8k1fv6Ln9No5/C8/y2JjQYrnrE8m
   igqqnCh3Om/x+iHUqK+Rsjqwak1g62WEHsUiqboQpwg9fFV16TzeLisg7
   eymvza5a7ZTCcs9+Szb01U7/YguJu9Yg5D/3WP1zfTgvjKxmR3O0G2TQO
   A==;
X-CSE-ConnectionGUID: C7Z+MRZNQ928idsKS1z1rQ==
X-CSE-MsgGUID: fhR3ddUzR2u5PQiKDqGe2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29935057"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="29935057"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 06:44:11 -0700
X-CSE-ConnectionGUID: CWNEBTUFQyOlxuQomxaYEw==
X-CSE-MsgGUID: W7W7GCQ5QD+QGy5On4DvRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71070503"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 06:44:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ssjME-0000000C17b-2lN9;
	Mon, 23 Sep 2024 16:44:06 +0300
Date: Mon, 23 Sep 2024 16:44:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] sub: cdns3: Use predefined PCI vendor ID constant
Message-ID: <ZvFwppgtysrFR6Dx@smile.fi.intel.com>
References: <20240913131710.3630560-1-andriy.shevchenko@linux.intel.com>
 <d6ec3b8b-9405-49fa-ba39-a0bf6311a489@kernel.org>
 <ZvFkv-xrs1ul7-oI@smile.fi.intel.com>
 <ed7e7044-1b5a-44a4-be24-7c94278244b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed7e7044-1b5a-44a4-be24-7c94278244b0@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 04:24:15PM +0300, Roger Quadros wrote:
> On 23/09/2024 15:53, Andy Shevchenko wrote:
> > On Mon, Sep 23, 2024 at 03:42:20PM +0300, Roger Quadros wrote:
> >> On 13/09/2024 16:17, Andy Shevchenko wrote:

...

> >>> -#define CDNS_DEVICE_ID		0x0200
> >>> -#define CDNS_DRD_ID		0x0100
> >>> -#define CDNS_DRD_IF		(PCI_CLASS_SERIAL_USB << 8 | 0x80)
> >>> +#define PCI_DEVICE_ID_CDNS_USB3		0x0100
> >>
> >> This is an entirely different card who's device ID should be 0x200?
> >> Also I don't think this card supports USB3 so it is a wrong name choice.
> > 
> > Are you stating that 0x0100 in both cases points to the *different* devices?!
> > This is unbelievable, however possible abuse of PCI IDs.
> 
> I am not entirely sure.
> What I do know is that one card should be USBSS (0x100) and other should be
> USBSSP (0x200). P for super-speed-Plus.

That's my understanding as well.

> Also please see commit 96b96b2a567f ("usb: cdnsp: changes PCI Device ID to
> fix conflict with CNDS3 driver")

I believe this is an interesting way to solve the issue "enumeration with two
or more drivers for the same HW". So, 0x100 in here is used just to see which
driver is in use (has been chosen at build time?).

That said, the 0x100 in both cases seems to me the _same_ device in question.
Hence it should be called the same, whatever you prefer. So, since the patches
are already in USB Next, feel free to update the constant definition names as
it looks like you are much more familiar with the hardware than me.

-- 
With Best Regards,
Andy Shevchenko



