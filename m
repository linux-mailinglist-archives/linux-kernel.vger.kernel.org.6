Return-Path: <linux-kernel+bounces-283074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D694ECB7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525C31C21BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B9A17ADEB;
	Mon, 12 Aug 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nn5nPnVg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E517A93D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465067; cv=none; b=tFTXcqX0jCjllo/onunWJJUIjpUL2dnhJpXHXItezvanlXiAYmr1vCQLLB5PpOeb63bewnEt4iW9cab8JTM9kIl83oW8eL/plw5diPSliZRgwHDWOIsQLys4sc0rx4JRtZMVdfzuU8lpukPFqhHOlBPVlp82HS/giBofdldD+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465067; c=relaxed/simple;
	bh=zVrE1ziOBDm89ZZUuFAl8nfIqMixay1u8ld1OLeodv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxLNEa2G5KvyAHn8FzQ27Bgh5IBr9FmZsndUXrLEXfVbmDy+6SkMwOcXRSKXMSl6x7MdB5Vrqp0cGhyLD+hf3Sg6AafOv+S8kRdgXXJSpP0FtANvT84PDelaqwOqXr71V/rbKluR2GSpfCci3/ghVSEkZs5Fp7dNo97LVRSPRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nn5nPnVg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723465066; x=1755001066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVrE1ziOBDm89ZZUuFAl8nfIqMixay1u8ld1OLeodv0=;
  b=nn5nPnVgKDtgwwllY2fH/nygwBvCE7IUZ3+fgb+j521D/Nkv9IyGnsGw
   Op+uJXGnkqf9QE+f8xeG4XUpMRZKkfKL7DhoWYkDsiv3FnlDRcspihFCp
   Wvts6q7rDpMoh8Kd+YG7ND8gQWfmEt08JbJbEy3w9wU/h/0YjLfhBn/W4
   hwNUjKb5JoG84SdOadB3CttAQtWxfPd1awrbCsRaIGHjzBegOdmK2NnYY
   nIzbw0isLZ1iXVj1KvStQxbx7YKMoisERYQt9EYgL+/FTmqu9oh5b3zs9
   wNIXhb7oMdFCXx4+zga2lzLkI6vk5VsCu4xIHfSeciTGyver/pxE3yKrJ
   Q==;
X-CSE-ConnectionGUID: cQnCucCaR1iUA+PE+WjH3Q==
X-CSE-MsgGUID: pVPcU3cLTtmOIxCK6sjX+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21720290"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21720290"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:17:45 -0700
X-CSE-ConnectionGUID: 57/tv0/BTxaAFt7q5/9cNA==
X-CSE-MsgGUID: fSWgTmkJQVeSD94EkS4KXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="88898350"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:17:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdTzY-0000000EKru-32P6;
	Mon, 12 Aug 2024 15:17:40 +0300
Date: Mon, 12 Aug 2024 15:17:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RESEND v3 1/6] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to
 the I3C Support List
Message-ID: <Zrn9ZLEMVGm2e1Db@smile.fi.intel.com>
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-2-Shyam-sundar.S-k@amd.com>
 <e94efd42-bc3f-4003-8ad8-2da6500f0f13@linux.intel.com>
 <ZrYlNOjFQE9dHsVV@smile.fi.intel.com>
 <c6ef0253-9f32-46d6-a658-295e39c926b2@amd.com>
 <ZrY8UOIsud8-NM_F@smile.fi.intel.com>
 <20240809183940461e3838@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809183940461e3838@mail.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 09, 2024 at 08:39:40PM +0200, Alexandre Belloni wrote:
> On 09/08/2024 18:57:04+0300, Andy Shevchenko wrote:
> > > Please refer to the MIPI HCI I3C DisCo specification
> > > (https://members.mipi.org/wg/All-Members/document/previewpdf/89465)
> > > section 5.4. The ASL looks the same in case of AMD.
> > > 
> > > MSFT says that they want to use MIPI0100 as mentioned in the
> > > specification.
> > 
> > MIPI doesn't know how to assign the ACPI ID correctly. But again, what I put in
> > the above is the correct way of approaching.
> > 
> > > What would you advise?
> > 
> > Since my intuition and experience tells me that the two devices even based on
> > the same IP are not the same (see word 'quirk' or '.driver_data' or alike in
> > the kernel sources) the generic ID may not be used for the specific vendor
> > unless it's _the only_ vendor for the certain IP.
> 
> Just to be clear, the HCI defines the register interface to the IP but
> not the IP itself, this is just like the various USB and SD HCIs.

Thank you for this elaboration, it's a crucial aspect!

> So we will definitively see quirks as implementers will interpret the
> interface differently

With the above remark this makes a lot of sense.

> (and so I agree with everything that was said ;) )

> > So, please do as I suggested above. And file a error report (and correction
> > proposal) to the MIPI, so in "5.1 I3C Host Controller ACPI Hardware ID (_HID)"
> > they should use _CID instead of _HID and add some text like
> > "Each vendor should dedicate it's own _HID for the platform in question. The
> > same _HID as _CID may be used if and only if vendor guarantees that there 100%
> > compatibility with MIPI as described in this and other related documents."
> > 
> > I.o.w. do you 100% guarantee that MIPI HCI I3C DisCo covers all necessary
> > properties that you need for _your_ hardware? If not, use my approach, if yes,
> > use the same _HID *and* _CID.
> > 
> > Microsoft should know this as well and much better than MIPI.

-- 
With Best Regards,
Andy Shevchenko



