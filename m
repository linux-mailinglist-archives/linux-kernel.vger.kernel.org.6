Return-Path: <linux-kernel+bounces-347658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF698D920
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCECF1C21EDE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03CB1D1E71;
	Wed,  2 Oct 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrJ1T+zG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6441D1E69
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877791; cv=none; b=LFSJU7ddk/Na4R+ldLE9xUcjnmpEf90/E5FJWREJxxhBNdM4caDEfjZPZlmsA+48I5Zoq8xH1WU1Lged+bJaWdOgf1qJqLgVkcZpRpblKVCsZZAnZO8byovAlyhKB4n9rxK7R1T2eO4pZoyFY7xuHn8W1Co4kYePCA+pbS0Nklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877791; c=relaxed/simple;
	bh=u9AMZzF86HRuo+ArSeE99IbuHFWDjMpwtf4ekreqqjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgZSxqdD+fdhzCYNmI1KYNA3MDHutA9Y7Uv4DVKideEpqbvF35KmsNIxIaQ+C6ws0Ohkna4s3aCZJRx1cAyjv4e+LSL95aAwb10RsvRAIZxgtvisRT36EmgoVaSkQCMctT3SJSYlkPT7s0CjrcjA+oY3rxzL7BYNKFkubCXmzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrJ1T+zG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727877790; x=1759413790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=u9AMZzF86HRuo+ArSeE99IbuHFWDjMpwtf4ekreqqjY=;
  b=WrJ1T+zGi4h0P/QYv3OLbo2LgkmqtzzZb9iaWNN9oTDcjH7u9Vq6cPC9
   ilV49Av1q9mIfsjXgDNNKq/i6ngSPGqMcPIN4Viq8R1FNyk03ynQ+Wany
   plj3a2QyG2Iv9ePj86GgtzahZp50Y61VmURaeUmxW2XN9pfm2NZFXFXne
   JF1JRzvhecwbZPvliF0/NlwzEP+iulLviuyRVD4slBpLtpTEfoIZwkt6p
   mtMW4OLWrOuW4DrM6POudcCXg0k4zPS9Gr6WivX2FbkTFg24fMJR0gxsO
   rCjT1kZSh0kct+7H91932KFURhAhod91wAG3M8Q+yra/l092TSAloV/MI
   w==;
X-CSE-ConnectionGUID: lo4zvBVSTfGZGnMjSMhBoQ==
X-CSE-MsgGUID: IAF5zGO7SV6oChHhk/1+fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="49564752"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="49564752"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:03:02 -0700
X-CSE-ConnectionGUID: ekj7SsZQSeS77KisYiIYOg==
X-CSE-MsgGUID: k5Gtkx+uT2uP/GB/wF9UZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="104801725"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:03:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1svzwQ-0000000Fgxw-0iUD;
	Wed, 02 Oct 2024 17:02:58 +0300
Date: Wed, 2 Oct 2024 17:02:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Robin van der Gracht <robin@protonic.nl>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/1] auxdisplay: ht16k33: Make use of
 i2c_get_match_data()
Message-ID: <Zv1SkQzXmpvZGjjd@smile.fi.intel.com>
References: <20240930133453.3403318-1-andriy.shevchenko@linux.intel.com>
 <20241002140855.3cbf1076@erd007>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002140855.3cbf1076@erd007>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 02, 2024 at 02:08:55PM +0200, Robin van der Gracht wrote:
> On Mon, 30 Sep 2024 16:26:42 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > 2) The above mentioned documentation says explicitly when user space
> > instantiation should be used. And for this driver it seems the only last
> > piece might be the case, i.e. prototyping / DIY configuration. For this
> > we don't need to rely on vendor ID anyway as in new supported hardware
> > the DT/ACPI emumeration is assumed.
> 
> Not sure what you mean here. It's statically declared in the device tree for
> the imx6dl-victgo board [1].

It's about documentation that listed 4 cases when the user may instantiate
the I²C target device via sysfs.

> > 3) Moreover, the currently used i2c_of_match_device() seems never be
> > considered to be used outside of i2c subsystem. Note, that it's being
> > used for device matching and probe, meaning firmware tables and board
> > info.
> 
> 4) It seems your change will also allows matching the device when it's
> enumerated through ACPI.

Yes.

> > Also note, that the other (yes, it's ONLY 2 drivers call this API)
> > user of that API is going to be updated as well. Taking 3) into account
> > I think soon we remove that API from bein exported to the modules.
> 
> i2c_of_match_device_sysfs() also matches the user input with the driver
> compatible string(s). Which is no longer true when i2c_get_match_data() is used.

Yes, and that's not needed. And again, the documentation does not mentioned
that compatible strings are allowed or have to be recognized by the driver
when the instantiation is done via sysfs.

> Not sure if it make sense to match against the compatible string at this point
> though. Because I'm not sure if the device can be instantiated through
> user space by using the compatible string in the first place. If so, there would
> only be 2 drives that can get their match data... 

Yes, strictly speaking it makes a little sense, esp. if the device needs some
(mandatory) device properties. In any case this change doesn't prevent user from
doing that, just without vendor prefix.

> The documentation doesn't mention the compatible string for user space
> instantiating just to use "the name of the I2C device".

Exactly!

> So maybe it's a good thing to remove that API or at least part of it.

We can't remove it, but we can hide it from being used outside of I²C core.
That's what I mentioned in 3) above.

> Regardless, the change looks good to me.
> 
> Reviewed-by: Robin van der Gracht <robin@protonic.nl>

Thank you for the review!

> 1: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts?h=v6.12-rc1#n278

-- 
With Best Regards,
Andy Shevchenko



