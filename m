Return-Path: <linux-kernel+bounces-577300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4AA71B18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7976E1709D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B21F4276;
	Wed, 26 Mar 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAQvHtDI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202B3A1BA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004310; cv=none; b=dJGVbCGoVU2+3utQH1DqhR2Sc7vCulkVZHWCG8gVEWSCqaNyxXVhH8vT2QIc7DJlh9Srr1WDR8e+soWSqkrVgdmrJqQgDCYd3NzEmXd/jB0pIYZhHHOFmW4TIfhtrr/RjFJ6fstJZq4F9/F+mm1clXLEvTSCM2zh3C9l1UtK5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004310; c=relaxed/simple;
	bh=WDTgACKfbFOAULZ00BSFWmKYsHzNYTrM9EPoZ8yADMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx8o75IwILMAqrz8uEYrB54YEjx0HbtUH72sbBo/haxSpupuIpGS9VvSg3u8/7t/c5yFCY/XrwijYgwebrk7NlQNfVImHRKEZpdHYOqTxPsXDGZUHJncNYFmDpy+MbR0GbZs3zvTdjz2fDQJze2GMtQwSkzAJprWcPRBro3rq+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAQvHtDI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743004308; x=1774540308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WDTgACKfbFOAULZ00BSFWmKYsHzNYTrM9EPoZ8yADMU=;
  b=FAQvHtDITl1+1PGwmkL8K/D4DQ7FCTkAlhKYKu218NqFaL+N+9lN9hcu
   sV9ml5xFDbYS8Yd360SeIPCbtwmNPdhTZo+Yk1KIN2BO9Cr7sf+49jnUz
   EVwfYGA5DnQjahOcr8PmBt2XX3c5WdGIBwyBTk7BaVXkTMNCwRaNmf+aX
   iYqw/853zhis+sTLDOrLk+Paqni1tX0NUgCe9JNq+GIQglOWwDlPvN7sL
   Co250xX8cFYxePfcwU44ZnQ9G5Fhts1ISwC4ekvjTT1jHrQvsEL9My/QA
   JMkgJpL8onsl9/SBBDltl3R6+hl0uZKYbmjz/XuVV9JX1I5Oybyu9U0zy
   w==;
X-CSE-ConnectionGUID: 7MGdNLS6RkWxoQ6wWlvDDQ==
X-CSE-MsgGUID: rLNuL4MaQp6JvskKs6535w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44188254"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="44188254"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:51:48 -0700
X-CSE-ConnectionGUID: LS0XVK0wRUKBR+t1osMCeA==
X-CSE-MsgGUID: b1QK+8PmQXC8SugrBN4iNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124550670"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:51:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1txT2d-000000067f4-1as0;
	Wed, 26 Mar 2025 17:51:43 +0200
Date: Wed, 26 Mar 2025 17:51:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Oded Gabbay <ogabbay@kernel.org>,
	"Avizrat, Yaron" <yaron.avizrat@intel.com>,
	"Elbaz, Koby" <koby.elbaz@intel.com>,
	"Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
Subject: Re: [PATCH v3 1/1] accel/habanalabs: Switch to use %ptTs
Message-ID: <Z-Qij4C8DSmS0Mq-@smile.fi.intel.com>
References: <20250305110126.2134307-1-andriy.shevchenko@linux.intel.com>
 <Z-PM8oBtTPzqv-S2@smile.fi.intel.com>
 <87zfh86rqi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfh86rqi.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 11:55:33AM +0200, Jani Nikula wrote:
> On Wed, 26 Mar 2025, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > +Cc: Jani (sorry, forgot to add you in the first place).
> >
> > Do you think it's applicable now?
> 
> Cc: Yaron, Koby, and Konstantin who are supposed to be the new
> maintainers for accel/habanalabs.

Thank you!

> > On Wed, Mar 05, 2025 at 01:00:25PM +0200, Andy Shevchenko wrote:
> >> Use %ptTs instead of open-coded variant to print contents of time64_t type
> >> in human readable form.
> >> 
> >> This changes N/A output to 1970-01-01 00:00:00 for zero timestamps,
> >> but it's used only in the dev_err() output and won't break anything.
> >> 
> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> ---
> >> 
> >> v3: explained the difference for N/A cases (Jani)
> >> v2: fixed the parameters to be the pointers
> >> 
> >>  drivers/accel/habanalabs/common/device.c | 25 +++---------------------
> >>  1 file changed, 3 insertions(+), 22 deletions(-)
> >> 
> >> diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
> >> index 68eebed3b050..80fa08bf57bd 100644
> >> --- a/drivers/accel/habanalabs/common/device.c
> >> +++ b/drivers/accel/habanalabs/common/device.c
> >> @@ -1066,28 +1066,11 @@ static bool is_pci_link_healthy(struct hl_device *hdev)
> >>  	return (device_id == hdev->pdev->device);
> >>  }
> >>  
> >> -static void stringify_time_of_last_heartbeat(struct hl_device *hdev, char *time_str, size_t size,
> >> -						bool is_pq_hb)
> >> -{
> >> -	time64_t seconds = is_pq_hb ? hdev->heartbeat_debug_info.last_pq_heartbeat_ts
> >> -					: hdev->heartbeat_debug_info.last_eq_heartbeat_ts;
> >> -	struct tm tm;
> >> -
> >> -	if (!seconds)
> >> -		return;
> >> -
> >> -	time64_to_tm(seconds, 0, &tm);
> >> -
> >> -	snprintf(time_str, size, "%ld-%02d-%02d %02d:%02d:%02d (UTC)",
> >> -		tm.tm_year + 1900, tm.tm_mon, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
> >> -}
> >> -
> >>  static bool hl_device_eq_heartbeat_received(struct hl_device *hdev)
> >>  {
> >>  	struct eq_heartbeat_debug_info *heartbeat_debug_info = &hdev->heartbeat_debug_info;
> >>  	u32 cpu_q_id = heartbeat_debug_info->cpu_queue_id, pq_pi_mask = (HL_QUEUE_LENGTH << 1) - 1;
> >>  	struct asic_fixed_properties *prop = &hdev->asic_prop;
> >> -	char pq_time_str[64] = "N/A", eq_time_str[64] = "N/A";
> >>  
> >>  	if (!prop->cpucp_info.eq_health_check_supported)
> >>  		return true;
> >> @@ -1095,17 +1078,15 @@ static bool hl_device_eq_heartbeat_received(struct hl_device *hdev)
> >>  	if (!hdev->eq_heartbeat_received) {
> >>  		dev_err(hdev->dev, "EQ heartbeat event was not received!\n");
> >>  
> >> -		stringify_time_of_last_heartbeat(hdev, pq_time_str, sizeof(pq_time_str), true);
> >> -		stringify_time_of_last_heartbeat(hdev, eq_time_str, sizeof(eq_time_str), false);
> >>  		dev_err(hdev->dev,
> >> -			"EQ: {CI %u, HB counter %u, last HB time: %s}, PQ: {PI: %u, CI: %u (%u), last HB time: %s}\n",
> >> +			"EQ: {CI %u, HB counter %u, last HB time: %ptTs}, PQ: {PI: %u, CI: %u (%u), last HB time: %ptTs}\n",
> >>  			hdev->event_queue.ci,
> >>  			heartbeat_debug_info->heartbeat_event_counter,
> >> -			eq_time_str,
> >> +			&hdev->heartbeat_debug_info.last_eq_heartbeat_ts,
> >>  			hdev->kernel_queues[cpu_q_id].pi,
> >>  			atomic_read(&hdev->kernel_queues[cpu_q_id].ci),
> >>  			atomic_read(&hdev->kernel_queues[cpu_q_id].ci) & pq_pi_mask,
> >> -			pq_time_str);
> >> +			&hdev->heartbeat_debug_info.last_pq_heartbeat_ts);
> >>  
> >>  		hl_eq_dump(hdev, &hdev->event_queue);

-- 
With Best Regards,
Andy Shevchenko



