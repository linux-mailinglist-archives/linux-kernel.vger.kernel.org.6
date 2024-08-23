Return-Path: <linux-kernel+bounces-299093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24C795D000
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1F72837E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDFE18FC7F;
	Fri, 23 Aug 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wohz4vfn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074818892E;
	Fri, 23 Aug 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422965; cv=none; b=ShoneoAQx56+J9tY9mslCRH5u9O2ryKqe1F9NMLPZASfORRGbyJWPAKCri7wurMpACwbrRzxpPGF/rjlxTS5rSzQ1GOMg8jX1VQPFqO3WXufLgn393oMf2/zaq0s6Un/thwRk/a94fg1NIEkjL/cY4rx+S33LWSGlYkfthRg9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422965; c=relaxed/simple;
	bh=UotOEqLkbDEfMvs99+UwExGDRHVD9lfUITGnAWoc0Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1usz8+/bMRf/6TyVC1gJAeIlZHZhzBEzCAbqJnir5/NmFrpG586rvpaQ8LC9xVYMZc1mIHTx4W8UJl6tNpkU/3OmvJF1KW/hKJ85z16eG/a0eZGVITG2y1bezWh+JLzJ+TyY4bMAyIs93glfr/6CBDPbkHrLPiKXgKiydCyJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wohz4vfn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724422963; x=1755958963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UotOEqLkbDEfMvs99+UwExGDRHVD9lfUITGnAWoc0Us=;
  b=Wohz4vfnIqkQLQf4zpWwNZm9QZ+LLZrFyNvTBjaWs1uphAKFtXKnhe6U
   6smK+2S02TZPEYb/cckWb2yZyiSAAuaFki+4vmnEWUbef7nbPxTYhkktn
   OmNLX/2c5KgIUmP+zvtBH07GLpJVNEb6QK+YvcKjy4+s1CcFLjItF+ZSx
   kICjH+6J2j0U+u9FRKMglFmgVtSQLFoIawT7uzshcHJNzSQ+QjkCDBEM1
   GncIXTHR5YcYqmyn9kkhV2/qiRGMkelvVz1NxYukyNZyHyaQzcP4h+Qol
   tjg23YKtAa8iFUMp8PBvme6h1M97Ne6sNqES9Ftd2VjkD3wmrxrVJI42Q
   g==;
X-CSE-ConnectionGUID: 83cjXKkqQtKcUjIHdj1g+A==
X-CSE-MsgGUID: RO7dJdorSV2nYO/yVwx8oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23061858"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23061858"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:22:42 -0700
X-CSE-ConnectionGUID: 79lO3hlVQbOm/FE+LreU+Q==
X-CSE-MsgGUID: lX9qaAAlRDa/KRt/yhBQ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="66130463"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:22:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shVBU-00000000ooV-3ZTv;
	Fri, 23 Aug 2024 17:22:36 +0300
Date: Fri, 23 Aug 2024 17:22:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: subramanian.mohan@intel.com
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de, giometti@enneenne.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, eddie.dong@intel.com,
	christopher.s.hall@intel.com, pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com, david.zage@intel.com,
	srinivasan.chinnadurai@intel.com
Subject: Re: [PATCH v12 1/3] pps: generators: Add PPS Generator TIO Driver
Message-ID: <ZsibLHt0iNJM4d02@smile.fi.intel.com>
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
 <20240823070109.27815-2-subramanian.mohan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823070109.27815-2-subramanian.mohan@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 12:31:06PM +0530, subramanian.mohan@intel.com wrote:
> From: Subramanian Mohan <subramanian.mohan@intel.com>
> 
> The Intel Timed IO PPS generator driver outputs a PPS signal using
> dedicated hardware that is more accurate than software actuated PPS.
> The Timed IO hardware generates output events using the ART timer.
> The ART timer period varies based on platform type, but is less than 100
> nanoseconds for all current platforms. Timed IO output accuracy is
> within 1 ART period.
> 
> PPS output is enabled by writing '1' the 'enable' sysfs attribute. The
> driver uses hrtimers to schedule a wake-up 10 ms before each event
> (edge) target time. At wakeup, the driver converts the target time in
> terms of CLOCK_REALTIME to ART trigger time and writes this to the Timed
> IO hardware. The Timed IO hardware generates an event precisely at the
> requested system time without software involvement.

...

> +#include <linux/bits.h>
> +#include <linux/bitfield.h>

These two should be swapped in ordering

> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/cpu.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hrtimer.h>
> +#include <linux/io-64-nonatomic-hi-lo.h>
> +#include <linux/kstrtox.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>
> +#include <linux/timekeeping.h>
> +#include <linux/types.h>

...

> +#define SAFE_TIME_NS			(10 * NSEC_PER_MSEC) /* Safety time to set hrtimer early */

It's better to have

/* ...comment... */
...definition...

...

> +static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
> +{
> +	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
> +	ktime_t expires, now;
> +	u32 event_count;
> +
> +	guard(spinlock)(&tio->lock);
> +
> +	/* Check if any event is missed. If an event is missed, TIO will be disabled*/

/*
 * Missing space at the of the comment. But since it's two-sentences comment,
 * make it multi-line like in this example.
 */

> +	event_count = pps_tio_read(tio, TIOEC);
> +	if (tio->prev_count && tio->prev_count == event_count)
> +		goto err;
> +	tio->prev_count = event_count;

+ Blank line.

> +	expires = hrtimer_get_expires(timer);

(1)

> +	now = ktime_get_real();
> +

The location of this blank line seems incorrect and should be moved to (1) above.

> +	if (now - expires >= SAFE_TIME_NS)
> +		goto err;
> +
> +	tio->enabled = pps_generate_next_pulse(tio, expires + SAFE_TIME_NS);
> +	if (!tio->enabled)
> +		return HRTIMER_NORESTART;
> +
> +	hrtimer_forward(timer, now, NSEC_PER_SEC / 2);
> +	return HRTIMER_RESTART;

+ Blank line.

> +err:
> +	dev_err(tio->dev, "Event missed, Disabling Timed I/O");
> +	pps_tio_disable(tio);
> +	return HRTIMER_NORESTART;
> +}

...

Note, the above are nit-picks and may be applied if you ever need a v13 to be
sent. For now let's wait for the more serious comments against the series.

-- 
With Best Regards,
Andy Shevchenko



