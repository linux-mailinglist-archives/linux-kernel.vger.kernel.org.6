Return-Path: <linux-kernel+bounces-529504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47286A42723
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A7B3B094B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5600221F00;
	Mon, 24 Feb 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFw32Jsl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031819C54F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412382; cv=none; b=lzxvAT5zQMBQZXcpuQOLJsZcpYTONi4tzFpEzcKS3uXEzklmAmn4a3uO65L8xiNAFJMbZNvx8HE8CF+8WvYRcqhDZKPUw7FnkMSvCUXazuiWa28gMIC8TeCsh8ok94OKasz5nPBcO+R2gPbovEFilamU3EKsMyKYQCM5TvSpFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412382; c=relaxed/simple;
	bh=2hO94njEkFPLGA3v6TUJPEI6paGm3pQdM5/shpowTXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egkYl/8kIF/O6gZvW4lhGt9tMl28Y8QzjT5LuMMD9Lu0zWdP3MK9EI65wYJGmtwGOhc2jcRsZfqG+hVRoV3vrUtePGLVwn1yWQAfvZk1+tr8I7o2SUqQFfPRDt8zZqPxvjSc9bmt181ybOKMdO2n3b04vV+cVQGWMw1xmAKSgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFw32Jsl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740412381; x=1771948381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2hO94njEkFPLGA3v6TUJPEI6paGm3pQdM5/shpowTXY=;
  b=WFw32Jslpk9KQf6Lp9wkLBhyMmzvittkWUk+AoOm+RSZ4Sjj/XcoERxb
   KmdW8uOIOmDfG/a43eRTwSekigsMGSgM13GpCRpv5VGFsx8Bp2qHCbZ+H
   CiUT4yJXLMxNrXJ9zDBgFx4iO+UZ4DfTmJ75gvgreRzEdL14zafLyewj8
   +XEZg1S4d+3Q7IeSHbga6oh7roarfeO/zof3GtM91AQtsvs9VmFpoAbPv
   sM+By3z0nPzZ0GtnghFy/rF5d4UnMwqm4kjxz1kywpxXweDDtmBeByd8j
   bGy09NhrL9H6rzxzFsxq+s/9yX5A5h5VwJIeqbul/bpdQr+thxye0pFDK
   g==;
X-CSE-ConnectionGUID: Uhz/3b08RuikVpwvv8cSLw==
X-CSE-MsgGUID: t4mU9DwsQ8eBFiJhr5fUfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41083603"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41083603"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:53:00 -0800
X-CSE-ConnectionGUID: 0UuTOEhJSXe2fMa8eIrDpw==
X-CSE-MsgGUID: mH/jukMGSzaYolWjscx6Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116294237"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:52:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmalK-0000000Ejtf-2WPX;
	Mon, 24 Feb 2025 17:52:54 +0200
Date: Mon, 24 Feb 2025 17:52:54 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Message-ID: <Z7yV1rvSM2OPW_un@smile.fi.intel.com>
References: <Z7yMIC1wxm0AGBCt@smile.fi.intel.com>
 <PN3PR01MB9597D4FD9FD8B8A8FB0F2B3CB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB959729DB53C0D359F8A83292B8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z7ySdcYWZjCVd-7v@smile.fi.intel.com>
 <PN3PR01MB959780B670AB514305790D8BB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB959780B670AB514305790D8BB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 03:40:29PM +0000, Aditya Garg wrote:
> > On 24 Feb 2025, at 9:08 PM, andriy.shevchenko@linux.intel.com wrote:
> > On Mon, Feb 24, 2025 at 03:32:56PM +0000, Aditya Garg wrote:
> >>> On 24 Feb 2025, at 8:50 PM, Aditya Garg <gargaditya08@live.com> wrote:
> >>>> On 24 Feb 2025, at 8:41 PM, andriy.shevchenko@linux.intel.com wrote:
> >>>> On Mon, Feb 24, 2025 at 03:03:40PM +0000, Aditya Garg wrote:
> >>>>>>> On 24 Feb 2025, at 8:27 PM, andriy.shevchenko@linux.intel.com wrote:
> >>>>>> On Mon, Feb 24, 2025 at 02:32:37PM +0000, Aditya Garg wrote:
> >>>>>>>> On 24 Feb 2025, at 7:30 PM, andriy.shevchenko@linux.intel.com wrote:
> >>>>>>>>>> On Mon, Feb 24, 2025 at 01:40:20PM +0000, Aditya Garg wrote:

...

> >>>>>>>>>>> +#define __APPLETBDRM_MSG_STR4(str4) ((__le32 __force)((str4[0] << 24) | (str4[1] << 16) | (str4[2] << 8) | str4[3]))
> >>>>>>>>>> 
> >>>>>>>>>> As commented previously this is quite strange what's going on with endianess in
> >>>>>>>>>> this driver. Especially the above weirdness when get_unaligned_be32() is being
> >>>>>>>>>> open coded and force-cast to __le32.
> >>>>>>>>> 
> >>>>>>>>> I would assume it was also mimicked from the Windows driver, though I haven't
> >>>>>>>>> really tried exploring this there.
> >>>>>>>>> 
> >>>>>>>>> I’d rather be happy if you give me code change suggestions and let me review
> >>>>>>>>> and test them
> >>>>>>>> 
> >>>>>>>> For the starter I would do the following for all related constants and
> >>>>>>>> drop that weird and ugly macros at the top (it also has an issue with
> >>>>>>>> the str4 length as it is 5 bytes long, not 4, btw):
> >>>>>>>> 
> >>>>>>>> #define APPLETBDRM_MSG_CLEAR_DISPLAY cpu_to_le32(0x434c5244) /* CLRD */
> >>>>>> 
> >>>>>> Lemme test this.
> >>>>> 
> >>>>> Just in case it won't work, reverse bytes in the integer. Because I was lost in
> >>>>> this conversion.
> >>> 
> >>> It works. What I understand is that you used the macro to get the final hex and converted it into little endian, which on the x86 macs would technically remain the same.
> >> 
> >> And now that I oberved again, %p4cc is actually printing these CLRD, REDY etc
> >> in reverse order, probably the reason %p4ch was chosen. And I am unable to
> >> find what macro upstream can be used.
> > 
> > %.4s should work as it technically not DRM 4cc, but specifics of the protocol
> > (that reminds me about ACPI that uses 4cc a lot).
> 
> I still get reverse order in that.

Ah, right, it will give you the first letter as LSB, indeed. At the end of the
day if it's so important, there are ways how to solve that without using %p4cc.
But if others (and esp. PRINTK maintainers) want to have / don't object having
that extension, why not?

-- 
With Best Regards,
Andy Shevchenko



