Return-Path: <linux-kernel+bounces-409230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B59C8946
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0871028407B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0911F943F;
	Thu, 14 Nov 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leKxIlsX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B708B18C32C;
	Thu, 14 Nov 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585103; cv=none; b=ssjb1kS8OoALB1hhZa/CQTZEiMeO5yYFLpkZ+aTURY7NpRGSCtMSCFOoHI3LHMyorxm2zytjhy60orN99x4RYdiDT0atxXpwNqt5wwx8yDUzPuDrrlPAhxiDxxl+5sCBVtptSzTzGUoYtlmGux9XeKdUVCgha280O6tymh5Uhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585103; c=relaxed/simple;
	bh=yWNvnoXRvIL5L9rGGJxlutE5msSoXsLBNxKXbB6Wh/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4PDQ13HsmX/+J52hySfMkAM9P5xr718DIhy04x/y6mT1oobrUgVk0f8jJVK2OesIV80Tm+cjEOWy0EXxu6o4kX4ZWLAvE3NMjhHBHy/vgwItxqAY1FI3mi7CvUzvp8i1K1AuHOXcwdGCXI0a9NsHSqcC4CIADl946cPhbUYIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leKxIlsX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731585102; x=1763121102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yWNvnoXRvIL5L9rGGJxlutE5msSoXsLBNxKXbB6Wh/E=;
  b=leKxIlsXDXVteHoN95vF/yrJo3fDYIyC+ti/2apFrTsN1ZQEXwOVS21R
   Q4VmwBdO3nd9Ywn2iY7JKE0NAzM6DRZPS2wFp0+6AxeUQY0uLwvZkFehJ
   EOouUIoCsevztsYe91bqH7TTh6wpq8H1S5/GBrAE97Hz60DL7J10iAYna
   FsuraYPs6kHkBYhZjdjYUEyEJlOYEe6soYKKdGk6GyKSfS3rfeNCp3j4e
   6OA2JoZZI9jxaTCHAj+f198WawC8oohEUWwKUlXIIJSrsSTQOx0BuxgAB
   ZKXcmdmEYwYKDtQ26CLerjTbjCuv3sum7G9DYk7m89VtATthmAsWXwgkP
   A==;
X-CSE-ConnectionGUID: FIDMsMqBRuG0xPQ3tbj7FQ==
X-CSE-MsgGUID: qta/+0xmSUC8pj6vzdOnJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48967242"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48967242"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 03:51:40 -0800
X-CSE-ConnectionGUID: /MDWVJEoQ+WWpAGpWVdRHg==
X-CSE-MsgGUID: xopzvJh5T8KRM1q87e7zJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="119114485"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 14 Nov 2024 03:51:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 223C2193; Thu, 14 Nov 2024 13:51:37 +0200 (EET)
Date: Thu, 14 Nov 2024 13:51:36 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241114115136.GB3187799@black.fi.intel.com>
References: <20241031095542.587e8aa6@kf-ir16>
 <20241101072155.GW275077@black.fi.intel.com>
 <20241101181334.25724aff@kf-ir16>
 <20241104060159.GY275077@black.fi.intel.com>
 <20241105141627.5e5199b3@kf-ir16>
 <20241106060635.GJ275077@black.fi.intel.com>
 <20241106110134.1871a7f6@kf-ir16>
 <20241107094543.GL275077@black.fi.intel.com>
 <20241111082223.GP275077@black.fi.intel.com>
 <20241112164447.4d81dc3a@kfocus.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112164447.4d81dc3a@kfocus.org>

Hi Aaron,

On Tue, Nov 12, 2024 at 04:44:47PM -0500, Aaron Rainbolt wrote:
> On Mon, 11 Nov 2024 10:22:23 +0200
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > Hi,
> > 
> > On Thu, Nov 07, 2024 at 11:45:44AM +0200, Mika Westerberg wrote:
> > > Hi,
> > > 
> > > On Wed, Nov 06, 2024 at 11:01:34AM -0600, Aaron Rainbolt wrote:  
> > > > > Unfortunately that does not help here. I need to figure
> > > > > something else how to detect the redrive case with this
> > > > > firmware but first, does this work in Windows? I mean if you
> > > > > install Windows to this same system does it work as expected?  
> > > > 
> > > > It does work as expected under Windows 11, with one major caveat.
> > > > We used a Windows 11 ISO with a setup.exe created on April 05
> > > > 2023 for installing the test system, and after initial
> > > > installation it behaved exactly the same way as Linux behaves now
> > > > (displays going blank soon after being plugged in). However,
> > > > after installing all available Windows updates, the issue
> > > > resolved, and the displays worked exactly as intended (the
> > > > screens are recognized when attached and do not end up
> > > > disconnecting after a timeout).
> > > > 
> > > > Would it be helpful to test on Windows 11, and provide a report
> > > > and system logs?  
> > > 
> > > Unfortunately, I don't know anything about Windows ;-)
> > > 
> > > However, I asked our Thunderbolt hardware/firmware team about this,
> > > if they have any idea how it was solved in Windows side. Might take
> > > a couple of days though.  
> > 
> > While waiting for this, I wonder if you guys could do one more
> > experiment? I would like to get the traces what is happening there
> > (hoping something pops out there). Following steps:
> > 
> >   1. Download and install tbtools [1].
> >   2. Build and install the kernel with my "redrive" patch.
> >   3. Boot the system up, nothing connected.
> >   4. Wait until the Barlow Ridge is in runtime suspend (so wait for
> >      ~30s or so)
> >   5. Enable tracing:
> > 
> >     # tbtrace enable
> > 
> >   6. Plug in USB-C monitor to the USB-C port of the Barlow Ridge. Do
> > not run 'lspci -k'. Expectation here is that there is no picture on
> >      the monitor (in other words the issue reproduces).
> > 
> >   7. Stop tracing and take full dump:
> > 
> >     # tbtrace disable
> >     # tbtrace dump -vv > trace.out
> > 
> >   8. Send trace.out along with full dmesg to me.
> > 
> > Thanks!
> > 
> > [1] https://github.com/intel/tbtools
> 
> Testing done as requested. Notes from tester:

Thanks!

> * I verified lsmod |grep thunderbolt which showed module.
> * When running sudo ./tbtrace enable, output was Thunderbolt/USB4
>   tracing: Enabled.
> * When plugging in monitor, it wakes the backlight, but there is no
>   image. syslog shows it as LG monitor controls. The monitor reports
>   "no signal" and eventually turns off the backlight to save power.
> * When running sudo ./tbtrace disable, output was Thunderbolt/USB4
>   tracing: Disabled.
> * Output was save using tbtrace dump -vv > trace.out and sudo dmesg >
>   trace.dmesg. trace.out is an empty file.
> 
> ---
> 
> (Yes, that's correct, trace.out is empty. I attached it nonetheless,
> but it's a 0-byte file. I'm guessing the Thunderbolt chip probably
> didn't come out of suspend?)

Yes, that's possible and this could explain the Linux behaviour but it
does not explain why it works in Windows. Also the dmesg is full of
stacktraces, not much else.

I got reply from our experts. They say that we are expected to get the
DP IN unplugs every single time we enter redrive mode. There is nothing
"special" added to the Windows side for this either so there is no real
explanation why it works in Windows and why we see this in Linux. What
they also wanted to check is that with the "production quality" Barlow
Ridge firmwares this is not expected to happen and yours is in 14.x so
is this some pre-production hardware that you are dealing with or this
can be purchased from somewhere? Where did you get the firmware?

Thanks!

