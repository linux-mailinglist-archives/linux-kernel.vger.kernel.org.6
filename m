Return-Path: <linux-kernel+bounces-529468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10889A4269B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA30A1693FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD553254856;
	Mon, 24 Feb 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOaK6H1O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7451A0BD6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411518; cv=none; b=Xa0Pmn6TbOVbgd/+mxEbmnKHHTFOKnYDsNDbfh3Wt77vb9G9GhgXuplyomB1PUtUh9XKQ0ifDASIWu2WeC80od+HKh78vAC+wcd+lCOEEYEhEXgWIL6pLhHlYQq4U+hsDttyDoS5LLczf3DXVhLY+JfDbgjFEWeGEGe4lMvI3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411518; c=relaxed/simple;
	bh=i6uCMpEqhNB6kv0LVixzotzNCRy5wG20H0n1NSAch2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5tlFFVEjbJ/QzYbTPcO/TVtgLCqo81iqJZMC1UOPogOR5sZexNnruIBcYI1n9Tbf7g9sM1du77Mlmydv+yY2IRR+pupc/V7YXZQN9V3ziQ3qzoWVYxSD24NN1YSj33coIL4AsrEMQUHZ/ChSOW37YOKfrSXeJB4mY1xcabacP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOaK6H1O; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740411516; x=1771947516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i6uCMpEqhNB6kv0LVixzotzNCRy5wG20H0n1NSAch2s=;
  b=XOaK6H1OwqM3LF9ovM3iuQlg20doUfekQMPjcxHg0YNsj5s9+dmjKoTQ
   5MJOiGDajvUfiAYm9tOpVIqG6ks+oWOTGq4lFLN2bcrxxIPbWxQ/DSTeW
   akeHTAlYnNr7Nfc1fu2qGY49SRHSmj3EYvEush6cMtX+4umBbQdIQINy5
   7C3beQbh8nmwmWTeaxZ+gcVAIoyIZKrssS/GKOfO/rJftGNCEicCVscvY
   0NZ7Lw6ckDqnEhTcvD+fuKHREIVPl7IXPgkAPLeE5OtonnLagAyzkTYqP
   dNES02mO6RO8sAKfbGWRrTKc2fvC2i5+u9e6+/MI/pY9xfjVR3Gz4EHqW
   A==;
X-CSE-ConnectionGUID: p7kyNRK8QruDyRWC18dobw==
X-CSE-MsgGUID: 3YqwupBbSw6g9gbn80yDNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="28768079"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="28768079"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:38:35 -0800
X-CSE-ConnectionGUID: Urim1mgrS46kj6kdqihpLA==
X-CSE-MsgGUID: DsOQ8Y36Rtu7vYIkDpoV3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="121057026"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:38:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmaXN-0000000EjYk-2LcO;
	Mon, 24 Feb 2025 17:38:29 +0200
Date: Mon, 24 Feb 2025 17:38:29 +0200
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
Message-ID: <Z7ySdcYWZjCVd-7v@smile.fi.intel.com>
References: <Z7yMIC1wxm0AGBCt@smile.fi.intel.com>
 <PN3PR01MB9597D4FD9FD8B8A8FB0F2B3CB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB959729DB53C0D359F8A83292B8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB959729DB53C0D359F8A83292B8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 03:32:56PM +0000, Aditya Garg wrote:
> > On 24 Feb 2025, at 8:50 PM, Aditya Garg <gargaditya08@live.com> wrote:
> >> On 24 Feb 2025, at 8:41 PM, andriy.shevchenko@linux.intel.com wrote:
> >> On Mon, Feb 24, 2025 at 03:03:40PM +0000, Aditya Garg wrote:
> >>>>> On 24 Feb 2025, at 8:27 PM, andriy.shevchenko@linux.intel.com wrote:
> >>>> On Mon, Feb 24, 2025 at 02:32:37PM +0000, Aditya Garg wrote:
> >>>>>> On 24 Feb 2025, at 7:30 PM, andriy.shevchenko@linux.intel.com wrote:
> >>>>>>> On Mon, Feb 24, 2025 at 01:40:20PM +0000, Aditya Garg wrote:

...

> >>>>>>>> +#define __APPLETBDRM_MSG_STR4(str4) ((__le32 __force)((str4[0] << 24) | (str4[1] << 16) | (str4[2] << 8) | str4[3]))
> >>>>>>> 
> >>>>>>> As commented previously this is quite strange what's going on with endianess in
> >>>>>>> this driver. Especially the above weirdness when get_unaligned_be32() is being
> >>>>>>> open coded and force-cast to __le32.
> >>>>>> 
> >>>>>> I would assume it was also mimicked from the Windows driver, though I haven't
> >>>>>> really tried exploring this there.
> >>>>>> 
> >>>>>> I’d rather be happy if you give me code change suggestions and let me review
> >>>>>> and test them
> >>>>> 
> >>>>> For the starter I would do the following for all related constants and
> >>>>> drop that weird and ugly macros at the top (it also has an issue with
> >>>>> the str4 length as it is 5 bytes long, not 4, btw):
> >>>>> 
> >>>>> #define APPLETBDRM_MSG_CLEAR_DISPLAY cpu_to_le32(0x434c5244) /* CLRD */
> >>> 
> >>> Lemme test this.
> >> 
> >> Just in case it won't work, reverse bytes in the integer. Because I was lost in
> >> this conversion.
> > 
> > It works. What I understand is that you used the macro to get the final hex and converted it into little endian, which on the x86 macs would technically remain the same.
> 
> And now that I oberved again, %p4cc is actually printing these CLRD, REDY etc
> in reverse order, probably the reason %p4ch was chosen. And I am unable to
> find what macro upstream can be used.

%.4s should work as it technically not DRM 4cc, but specifics of the protocol
(that reminds me about ACPI that uses 4cc a lot).

-- 
With Best Regards,
Andy Shevchenko



