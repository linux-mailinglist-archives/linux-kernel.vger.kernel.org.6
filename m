Return-Path: <linux-kernel+bounces-529462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB6FA4267C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496DC167529
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A7A24889B;
	Mon, 24 Feb 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlzlIwEd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECC2571BD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411416; cv=none; b=N8Q5z9nVsL65wkVVLIf2vwdOxRopIeHBbX8TBjgaVsuQWY9lqzpxKOl6udQ/fPWARxz3tfNRErJA6nkh9x3SWU9F9SLph+HOUDJIRZqRqNQSiPO6ZY3PX7FeI132GpEzN0A3OToT0M6GIh0yiPzTgZFUAtnFlMKLVOkiPhFYUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411416; c=relaxed/simple;
	bh=tlqeQlxXj7Z3p6b5lmb+YRd29W7Q03s6EkuRtxcr0LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSH73JQOoF0AJotNnDbkH3T4E/xEnquwuhQBZFDdpnKmhg/i7nNxrDqSlZi/57fvNssaQdMW9hV/b41w2FUp1TQWq/2xA1UnF+7TVe+VMzBwIdoGVLUwOWQiMnh6KlScOzrrpYB6W0OIrh4vdb9Pjz8Psz/0IbxZyppR8Mpm2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlzlIwEd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740411415; x=1771947415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tlqeQlxXj7Z3p6b5lmb+YRd29W7Q03s6EkuRtxcr0LI=;
  b=SlzlIwEdeWgl7LT+hfWkr5sl7wQ0bEaEsAEMDCFQpW3BF7oyd6wTURoM
   mEOjDwO315rBnPilkllICQ81IVRHPsesvvFhdIv3ruY1l5bDTQ9dwZzqj
   Up5PGQg0H7nq9cDUtqnUnnpzEbj0Go7W2hKc5vDqvTJwrKSSetpPvdbTy
   1MSPVzCv2kAXURUn4HKfzEJPQBtKB0A13/TEsEYhDu2KrToCVUILczTSc
   uNPfYcN7nlbRbqZCi1u7d7XmtwNBAtgE3Gx1QvpDKBUkBOAooaKP2db7Z
   dsY+PTpublSVe9S+TGm97RKPL8ZNeG0bQ/cDgdcxQqvdd8Za+jhbeYKiY
   A==;
X-CSE-ConnectionGUID: Z5zHzrhPQb6YYeNOMdsI3A==
X-CSE-MsgGUID: srNhmqOYRWuAHAnVQflSRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41379033"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41379033"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:36:55 -0800
X-CSE-ConnectionGUID: EppH+i3LS6CwiRoOJoJ8Hg==
X-CSE-MsgGUID: b5zUQ9CmTLu3d9WEAJr0bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120211657"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:36:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmaVT-0000000EjWv-0igG;
	Mon, 24 Feb 2025 17:36:31 +0200
Date: Mon, 24 Feb 2025 17:36:30 +0200
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
Message-ID: <Z7yR_u6ISEQFAwsI@smile.fi.intel.com>
References: <Z7yMIC1wxm0AGBCt@smile.fi.intel.com>
 <PN3PR01MB9597D4FD9FD8B8A8FB0F2B3CB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB9597D4FD9FD8B8A8FB0F2B3CB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 03:20:13PM +0000, Aditya Garg wrote:
> > On 24 Feb 2025, at 8:41 PM, andriy.shevchenko@linux.intel.com wrote:
> > On Mon, Feb 24, 2025 at 03:03:40PM +0000, Aditya Garg wrote:
> >>>> On 24 Feb 2025, at 8:27 PM, andriy.shevchenko@linux.intel.com wrote:
> >>> On Mon, Feb 24, 2025 at 02:32:37PM +0000, Aditya Garg wrote:
> >>>>> On 24 Feb 2025, at 7:30 PM, andriy.shevchenko@linux.intel.com wrote:
> >>>>> On Mon, Feb 24, 2025 at 01:40:20PM +0000, Aditya Garg wrote:

...

> >>>>>> +#define __APPLETBDRM_MSG_STR4(str4) ((__le32 __force)((str4[0] << 24) | (str4[1] << 16) | (str4[2] << 8) | str4[3]))
> >>>>> 
> >>>>> As commented previously this is quite strange what's going on with endianess in
> >>>>> this driver. Especially the above weirdness when get_unaligned_be32() is being
> >>>>> open coded and force-cast to __le32.
> >>>> 
> >>>> I would assume it was also mimicked from the Windows driver, though I haven't
> >>>> really tried exploring this there.
> >>>> 
> >>>> I’d rather be happy if you give me code change suggestions and let me review
> >>>> and test them
> >>> 
> >>> For the starter I would do the following for all related constants and
> >>> drop that weird and ugly macros at the top (it also has an issue with
> >>> the str4 length as it is 5 bytes long, not 4, btw):
> >>> 
> >>> #define APPLETBDRM_MSG_CLEAR_DISPLAY cpu_to_le32(0x434c5244) /* CLRD */
> >> 
> >> Lemme test this.
> > 
> > Just in case it won't work, reverse bytes in the integer. Because I was lost in
> > this conversion.
> 
> It works. What I understand is that you used the macro to get the final hex
> and converted it into little endian, which on the x86 macs would technically
> remain the same.

Right, the problem is the macro itself which does really weird things altogether.
Using integer + comment much clearer in my opinion.

> >>> (assuming we stick with __leXX for now). This will be much less confusing.

-- 
With Best Regards,
Andy Shevchenko



