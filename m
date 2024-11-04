Return-Path: <linux-kernel+bounces-394239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF98B9BAC49
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73F7AB213F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F0418BBB4;
	Mon,  4 Nov 2024 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVPjgHEb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277D44C7C;
	Mon,  4 Nov 2024 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730700125; cv=none; b=AK9MtgZZM/vz/HtjPwKK6kFs5/j5nh8DeLX8K6MOvE3BlPUgy7s4v7H/42MGnzwp3BKRaZLvr+CcK+FfkQQGw+1Rn/71Vfy+CeUV41dJA5/gRhDm7Ou30aDBdp3Hx9CueOQXtPqYRjYQ1Bjr0mVISrdHwUGzwA6FP2/Tcid/X9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730700125; c=relaxed/simple;
	bh=+S5xOXpBhWoMpNvX3Rj6Ot42dzDTDNRfbc0pnguElpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrhOJJ6/4tbnxjDaFFn9og2ri+NR4kg2xmJUN9CgNIUQrKyeYQJ4JjSYKqcFuH+TBUp+uuNcFFNCvIGdvGuD0S5UnpS+f4dovQYv8Lzw8sx3XEmeXkm3uGVM8RPHvgdjF70dmYC+w0hC+2ZAW8jrOJBlo1tyjJuZLpMyfHKcv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVPjgHEb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730700124; x=1762236124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+S5xOXpBhWoMpNvX3Rj6Ot42dzDTDNRfbc0pnguElpI=;
  b=cVPjgHEbTnUPUU9lVqndP3SzLWCQUIeMISuZwXZWhH5VkdMkiEoM8Lam
   CD5xTydG4o+0u1xUojVAhhDMXs3Yo62SqxKY/VjyfyinCmkh+FjN0e820
   FAyaL81XWNAAYbngXid14uJu/TdElB8C2WZkZjjYLWWpoJ22ZPil1rj9z
   polYu4VUNJUB67eaV6CP3CIz7LYkdV8zeNpf8RFbcnkIwE2e71tt/wdD1
   +HxOqJkwcj6I9x1elQpO/3EbrgazEI2mOedTXoNuwfWr3ysMN79kLW+y1
   oojjVGiw6XaXV00N2shdOZTYv4BVEYIaBih0xuPmlz3I9+B4gJru3vyEh
   A==;
X-CSE-ConnectionGUID: Om0f22BcT5GUsWIEO4CQ8A==
X-CSE-MsgGUID: 2HKwGAfCQ8qXaZv6qPrUlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="34171947"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="34171947"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 22:02:02 -0800
X-CSE-ConnectionGUID: d3GovnOESL2FQyLUYosOWg==
X-CSE-MsgGUID: 6zV+Ar7YQaihSdrlZ8Q0CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114358812"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 03 Nov 2024 22:02:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 2623B1C8; Mon, 04 Nov 2024 08:01:59 +0200 (EET)
Date: Mon, 4 Nov 2024 08:01:59 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241104060159.GY275077@black.fi.intel.com>
References: <20241010232656.7fc6359e@kf-ir16>
 <20241011163811.GU275077@black.fi.intel.com>
 <20241011183751.7d27c59c@kf-ir16>
 <20241023062737.GG275077@black.fi.intel.com>
 <20241023073931.GH275077@black.fi.intel.com>
 <20241023174413.451710ea@kf-ir16>
 <20241024154341.GK275077@black.fi.intel.com>
 <20241031095542.587e8aa6@kf-ir16>
 <20241101072155.GW275077@black.fi.intel.com>
 <20241101181334.25724aff@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101181334.25724aff@kf-ir16>

Hi,

On Fri, Nov 01, 2024 at 06:13:34PM -0500, Aaron Rainbolt wrote:
> Thanks! We have tested the 6.11.5 kernel with this patch. Here's the
> report from our testing team. dmesg logs are attached.
> 
> -----
> 
> 1. Created 2024-11-01_6.11.5_tbt-barlow-ridge-01.dmesg,
>   2024-11-01_6.11.5_tbt-barlow-ridge-02.dmesg.
>   Version 01 is with nouveau. Version 02 is with Nivida (rebuilt); could
>   NOT build keyboard module (complained did not support 6.11 kernel).
> 2. In both cases, hot-plug does not wake display. However, after lspci
>   -k, displays wake and are reliable.

Okay, thanks again for testing!

It means disabling adapter 16 in DROM is actually intentional as that
is not connected to the dGPU and so makes sense.

> * Boot the system up, nothing connected.
> * Wait for Barlow Ridge to enter runtime suspend. This takes ~15
>   seconds so waiting for > 15 seconds should be enough.
> * Plug in USB-C monitor to the USB-C port of the Barlow Ridge.
>   Screen shows in log, screen wakes, but then no signal is received, and
>   no image ever appears. Screen then sleeps after its timeout.
> * Run lspci -k to wake up the monitors. Once this is run, the display
>   shows correctly and is stable. Adding another USB-C display after this
>   also works correctly: It is recognized and lights up in seconds to
>   show the desktop background, and remains stable.
> 
> Notice that pre-6.5 kernels work fine with Barlow Ridge, which implies
> that new code is causing this. It may be new support code for tbt
> capability (and therefore pretty much required). But regardless, it's
> still new code. With the current patch, we can run a udev rule that
> enables hot plugging that likely always work, or (worst case) at least
> empowers the customer to refresh monitors by clicking a button.

We definitely want to fix this properly so there is no need for anyone
to run 'lspci' or similar hacks but because I'm unable to reproduce this
with my reference Barlow Ridge setup, I need some help from you.

You say with v6.5 it works? That's interesting because we only added
this redrive mode workaround for v6.9 and without that the domain surely
will not be kept powered but maybe I'm missing something.

I wonder if your test team could provide log from v6.5 as well following
the same steps, no need to run 'lspci' just do:

  1. Boot the system up, nothing connected.
  2. Wait for ~15 seconds for the domain to enter runtime suspend.
  3. Plug in USB-C monitor to the USB-C port of Barlow Ridge.
  4. Verify that it wakes up and, there is picture on the screen.
  5. Wait for ~15 seconds.

Expectation: After step 5 the monitor still displays picture.

If this works as above then I'm really surprised but if that's the case
then we can maybe think of another approach of dealing with the redrive
mode.

> -----
> 
> To my awareness, we have not yet reported the "device links to tunneled
> native ports are missing" error to the hardware manufacturer. I'll see
> if we can get that reported. Thanks for the heads-up!

Okay thanks. The corresponding "requirement" is here:

https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#map-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers

