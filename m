Return-Path: <linux-kernel+bounces-518855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD9EA39561
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A74A178D52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF76122CBFD;
	Tue, 18 Feb 2025 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3y6mbYv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8C22B59B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867062; cv=none; b=P5qvlRk7AN5T8Mreuhc3yEGlib3mAbL8XT3ADjldyTkub/xL3cqEVeI3hMZT1Pw4aAqMkVO8hpV8tQiamHGhSRp/oz5l6F3DFeQTKpmiE5Wo8ZXDdP1UATUkBVVdGpqXthnSIhyhvOpxGR1AlMgkDrcIDisT3jCMhGCZJIlH5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867062; c=relaxed/simple;
	bh=9QSp1xJjXIJGt7MBed1jthL6tlBO/Os9n0CIOftZryg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCarXAw5aL+LDMZCL4N/FZOFo6RR2g0W3uRR3XtOMrqsAdZMUsLJ0Wv6aiDF/62E4ckldsKwtKMOWpAcbt0exE+FBpB4/ymbKtFVYyCqra6UAiyVbNCAtu5OFokU1etHscxpV3pQ1XSW8r4f4rdkLBxsonDAFL5xisDNtgoaqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3y6mbYv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739867061; x=1771403061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9QSp1xJjXIJGt7MBed1jthL6tlBO/Os9n0CIOftZryg=;
  b=Q3y6mbYvLATnMc/vlXSemP1YWwHeldRpTpx+s82YhbuR3DloxRc19T7i
   kzTJe1cw4OLyJVq3XrkKbkaIJNGkdddzGJ8CDF6Go98saHTSXDAZoJNKz
   iiAvIykjfwxPVKnfrPcWdrgZlzFNph34Lx5CFpphh1NsPfZ6ea6sfn5el
   8pvjkgY0nVlAsirL48dQ4TkqAaWtw285325CwtBwTa57A/RaKoUwKmDb8
   dpQimIm0j0qWmotIktxai7WJMY5v2oUvRp0GDu1dq9KyBxWcN8xLMQ8c3
   4fiXWnxmps8MrR9d1xFyIJi10v8VzX/UTHIaqSkLFRSm9MKHffwzdfpu7
   w==;
X-CSE-ConnectionGUID: XX0WtzwyQhCwxDwFZmCp/g==
X-CSE-MsgGUID: Tw0VngQcSRG8G0eTAjQblw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44306874"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44306874"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:24:12 -0800
X-CSE-ConnectionGUID: rtXNBxsPQf2XUCXppQb8uA==
X-CSE-MsgGUID: kOvm/njvSiG8keubVWzrxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="114977360"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:24:08 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id AF3D811F7F2;
	Tue, 18 Feb 2025 10:24:05 +0200 (EET)
Date: Tue, 18 Feb 2025 08:24:05 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wentong Wu <wentong.wu@intel.com>, Jason Chen <jason.z.chen@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: vsc: Use "wakeuphostint" when getting the host
 wakeup GPIO
Message-ID: <Z7RDpYVCLIdMiytw@kekkonen.localdomain>
References: <20250214212425.84021-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214212425.84021-1-hdegoede@redhat.com>

Hi Hans,

On Fri, Feb 14, 2025 at 10:24:25PM +0100, Hans de Goede wrote:
> The _CRS ACPI resources table has 2 entries for the host wakeup GPIO,
> the first one being a regular GpioIo () resource while the second one
> is a GpioInt () resource for the same pin.
> 
> The acpi_gpio_mapping table used by vsc-tp.c maps the first Gpio ()
> resource to "wakeuphost-gpios" where as the second GpioInt () entry
> is mapped to "wakeuphostint-gpios".
> 
> Using "wakeuphost" to request the GPIO as was done until now, means
> that the gpiolib-acpi code does not know that the GPIO is active-low
> as that info is only available in the GpioInt () entry.
> 
> Things were still working before due to the following happening:
> 
> 1. Since the 2 entries point to the same pin they share a struct gpio_desc
> 2. The SPI core creates the SPI device vsc-tp.c binds to and calls
>    acpi_dev_gpio_irq_get(). This does use the second entry and sets
>    FLAG_ACTIVE_LOW in gpio_desc.flags .
> 3. vsc_tp_probe() requests the "wakeuphost" GPIO and inherits the
>    active-low flag set by acpi_dev_gpio_irq_get()
> 
> But there is a possible scenario where things do not work:
> 
> 1. - 3. happen as above
> 4. After requesting the "wakeuphost" GPIO, the "resetfw" GPIO is requested
>    next, but its USB GPIO controller is not available yet, so this call
>    returns -EPROBE_DEFER.
> 5. The gpio_desc for "wakeuphost" is put() and during this the active-low
>    flag is cleared from gpio_desc.flags .
> 6. Later on vsc_tp_probe() requests the "wakeuphost" GPIO again, but now it
>    is not marked active-low.
> 
> The difference can also be seen in /sys/kernel/debug/gpio, which contains
> the following line for this GPIO:
> 
>  gpio-535 (                    |wakeuphost          ) in  hi IRQ ACTIVE LOW
> 
> If the second scenario is hit the "ACTIVE LOW" at the end disappears and
> things do not work.
> 
> Fix this by requesting the GPIO through the "wakeuphostint" mapping instead
> which provides active-low info without relying on acpi_dev_gpio_irq_get()
> pre-populating this info in the gpio_desc.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2316918
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Great detective work! :-)

Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>

This was on Arch Linux where I've seen this only, never on Debian.

-- 
Regards,

Sakari Ailus

