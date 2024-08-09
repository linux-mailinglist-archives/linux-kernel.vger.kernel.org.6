Return-Path: <linux-kernel+bounces-281183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF05794D40C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5EAB21C31
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701D198E71;
	Fri,  9 Aug 2024 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwdxrWr2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425F168B8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219074; cv=none; b=LgywF3yvcJDBn6LHz9EDuhJ9s0GxXQqhektEa3ZxEZlS45qM74fW72Tqw3k0yP3I9qRwFmOJv/kcIQNclQOIl0lCmeLyjzgR1S+PjOna8fLKaK5yQ0lbavYwUf7+dVKXbTVylsdrn3ad9eNeCn5dpGHANwErNoaKrxabHDDlC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219074; c=relaxed/simple;
	bh=Y8edBrqv1pzht7Xi4mM+aUWqnoTHAgGonimtxluGamw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+pKFGoWE3rR968E9zS1gDUyNxYytwtT8k1qA7iwGc9tCFjIXBbABYzhSauo3MI9ouWoZ3ymJK0T6Lg2XlZatIj3/zk/Mv/eOYeYyJYltfZabqG7fR7DX9E/SivFhT4v4I7qhZjomGg4HtSGNTcMSnuJtNr+Q0VVO0XeT4M/TcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwdxrWr2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723219074; x=1754755074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y8edBrqv1pzht7Xi4mM+aUWqnoTHAgGonimtxluGamw=;
  b=iwdxrWr2uilgzBDU1PsncqNU0uRQaHZxieNjO8ay5P0ajL1UNotx3Uob
   XuuSM6yvn/PY3x/lQg/tGCdLUhKw8VPwwAILBYhrvepAL4hisD8yH35dS
   qkfWsDeseP5c0fKxi+i00aPvJ93IYO25KkU+43N+ZKdjj9yBzDmot367w
   puvDu1N3RoQM1BFinbnUKF8s1XWUfQc1nXMBn2adYa0MH0ICCUXPQmFxS
   q4FLW0zk2MqhoRUEWqJDSBhKvcpwuheN1qyIc3I/j3qCDlsiU42aprGKu
   cEyFMTGcReH5rAggIX2PbIhHKdKx1hzm2gftZ7y6ywcEFyleqoPZu3zbk
   g==;
X-CSE-ConnectionGUID: yXPl7OCgSNSfDS3QsaeGJQ==
X-CSE-MsgGUID: 78b4LL15TzGseTcXu37bcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25193362"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="25193362"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:57:10 -0700
X-CSE-ConnectionGUID: HIDNdw4fQI26LVRB1vR5OA==
X-CSE-MsgGUID: 3mVOzCSmSrOQTpCMNvGOkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57565751"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:57:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scRzE-0000000DTBB-3uIV;
	Fri, 09 Aug 2024 18:57:04 +0300
Date: Fri, 9 Aug 2024 18:57:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RESEND v3 1/6] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to
 the I3C Support List
Message-ID: <ZrY8UOIsud8-NM_F@smile.fi.intel.com>
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-2-Shyam-sundar.S-k@amd.com>
 <e94efd42-bc3f-4003-8ad8-2da6500f0f13@linux.intel.com>
 <ZrYlNOjFQE9dHsVV@smile.fi.intel.com>
 <c6ef0253-9f32-46d6-a658-295e39c926b2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ef0253-9f32-46d6-a658-295e39c926b2@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 09, 2024 at 09:02:35PM +0530, Shyam Sundar S K wrote:
> On 8/9/2024 19:48, Andy Shevchenko wrote:
> > On Fri, Aug 09, 2024 at 04:54:18PM +0300, Jarkko Nikula wrote:
> >> On 8/7/24 8:23 AM, Shyam Sundar S K wrote:

...

> > When adding a new ACPI ID, always provide the following information:
> > 
> > 1) link (in some form) to the official confirmation / documentation for
> > the allocated ID by the vendor (MIPI in this case) _OR_ (very exceptional!)
> > why the bad ID had been allocated;
> 
> Member version:
> https://members.mipi.org/wg/All-Members/document/previewpdf/89465
> 
> Public version: https://www.mipi.org/mipi-disco-for-i3c-download (this
> requires a signup).
> 
> Since there is no direct link available for preview, I did not include
> them in the commit-msg. But left a note that the MIPI ID is the one as
> specified in the MIPI DisCo spec.

It's fine.

> > 2) are there devices in the wild (on the market) that use the being added ID(s)?
> 
> Not in the wild. But the latest platform will have this support
> included. So, these device IDs are crucial for the i3c-hci to be
> supported on AMD platforms.

Good, let's do it right then!

> > 3) excerpt from the device (independently if it's public already, see above,
> > or not) DSDT ACPI table.
> > 
> > With the given patch it looks to me that you most likely need a local, AMD
> > specific ID as well.
> > 
> > So, in my ideal world the DSDT should be like
> > 
> > 	Device (I3CC)
> > 	{
> > 		Name (_HID, "...") // AMD specific _HID
> > 		Name (_CID, "MIPI0100") // Compatible ID for generic I3C controller
> > 		...
> > 	}
> > 
> > Is this the case? Why not?
> 
> Please refer to the MIPI HCI I3C DisCo specification
> (https://members.mipi.org/wg/All-Members/document/previewpdf/89465)
> section 5.4. The ASL looks the same in case of AMD.
> 
> MSFT says that they want to use MIPI0100 as mentioned in the
> specification.

MIPI doesn't know how to assign the ACPI ID correctly. But again, what I put in
the above is the correct way of approaching.

> What would you advise?

Since my intuition and experience tells me that the two devices even based on
the same IP are not the same (see word 'quirk' or '.driver_data' or alike in
the kernel sources) the generic ID may not be used for the specific vendor
unless it's _the only_ vendor for the certain IP.

So, please do as I suggested above. And file a error report (and correction
proposal) to the MIPI, so in "5.1 I3C Host Controller ACPI Hardware ID (_HID)"
they should use _CID instead of _HID and add some text like
"Each vendor should dedicate it's own _HID for the platform in question. The
same _HID as _CID may be used if and only if vendor guarantees that there 100%
compatibility with MIPI as described in this and other related documents."

I.o.w. do you 100% guarantee that MIPI HCI I3C DisCo covers all necessary
properties that you need for _your_ hardware? If not, use my approach, if yes,
use the same _HID *and* _CID.

Microsoft should know this as well and much better than MIPI.

-- 
With Best Regards,
Andy Shevchenko



