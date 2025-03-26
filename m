Return-Path: <linux-kernel+bounces-576758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA7A7140F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C971898B78
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DD31B0435;
	Wed, 26 Mar 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OY8Pzm7k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8022A1B2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982392; cv=none; b=B+yY64M8hJ+gMzw+twTbUMlZkyFRujtG/zvHROv68ovaFPiIhNGnal9Z7UegCL33KHbxoVVq//qkOLkWzjrBCqYtgXry0DyKq83TDMsoEraSR8xMPVI62HLze5YCoPlZpxntZzXDQR8/Y8AE6w9C5VC0oLIwVFgXzfdkp3UXCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982392; c=relaxed/simple;
	bh=pSdpOBH3OsiqWCKed9YZ+vvLO/0PxNNz2Btrj67jOc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4yh2ALdptzfNg+5m7EZZmoZfHKtwc3B8XOtUWM0p1xvsdv7jXqKDKN6MoOrO0qoarc3HEkwBGWxWsxt6OORB8vhqAY3IoKNujUILe8UeyQ1BmMyII/J4cvXsO16hpvgl972TGP7mLIAGoH+HPM9iQ4i/f45eqBAxng4dVGcAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OY8Pzm7k; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742982391; x=1774518391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pSdpOBH3OsiqWCKed9YZ+vvLO/0PxNNz2Btrj67jOc4=;
  b=OY8Pzm7kwmT+NEsIuXNQB3u12qDjgXdi4IDzI0ExGERyAgsqmyV/aTGr
   kWF1KZH/axaUMwm/nDXlDMusfRCEFaahbQbUBGeTTzK+Fa1Dx+j1M/HVN
   u3KpXtnf+2XV3YWfQstUmJZDnI9BUiM5nhAdfxbEBf1LKFbYENcwWbYdz
   eCbLSPgpBEhL8rzzz0rr9Ul/14QCYrXxCv6/ROT3Wd8dTjms8JrpHdfz3
   qCqEMiymNzHJMLQ/y64WO+W+0/96tN5Z1cZWs2A8TJZgjsfhCAQcE+oAX
   V5vmwILdF9QAwOnCbHdlVpG3ZQlNrxaE9lbj1qo94M1GuMVV1UQWyj7kf
   A==;
X-CSE-ConnectionGUID: c6ubI6KvTLGZP6DA49EWBw==
X-CSE-MsgGUID: GYZe/L9wSR+yECNgpgSaiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="47912494"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="47912494"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 02:46:31 -0700
X-CSE-ConnectionGUID: QvIovGnnTvK+1T0AfTwcDw==
X-CSE-MsgGUID: 5IGA7C2wQ0uIRiBikBXcnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="124447276"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 02:46:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1txNL8-000000061wz-1N9h;
	Wed, 26 Mar 2025 11:46:26 +0200
Date: Wed, 26 Mar 2025 11:46:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ofir Bitton <obitton@habana.ai>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3 1/1] accel/habanalabs: Switch to use %ptTs
Message-ID: <Z-PM8oBtTPzqv-S2@smile.fi.intel.com>
References: <20250305110126.2134307-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305110126.2134307-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Jani (sorry, forgot to add you in the first place).

Do you think it's applicable now?

On Wed, Mar 05, 2025 at 01:00:25PM +0200, Andy Shevchenko wrote:
> Use %ptTs instead of open-coded variant to print contents of time64_t type
> in human readable form.
> 
> This changes N/A output to 1970-01-01 00:00:00 for zero timestamps,
> but it's used only in the dev_err() output and won't break anything.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v3: explained the difference for N/A cases (Jani)
> v2: fixed the parameters to be the pointers
> 
>  drivers/accel/habanalabs/common/device.c | 25 +++---------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
> index 68eebed3b050..80fa08bf57bd 100644
> --- a/drivers/accel/habanalabs/common/device.c
> +++ b/drivers/accel/habanalabs/common/device.c
> @@ -1066,28 +1066,11 @@ static bool is_pci_link_healthy(struct hl_device *hdev)
>  	return (device_id == hdev->pdev->device);
>  }
>  
> -static void stringify_time_of_last_heartbeat(struct hl_device *hdev, char *time_str, size_t size,
> -						bool is_pq_hb)
> -{
> -	time64_t seconds = is_pq_hb ? hdev->heartbeat_debug_info.last_pq_heartbeat_ts
> -					: hdev->heartbeat_debug_info.last_eq_heartbeat_ts;
> -	struct tm tm;
> -
> -	if (!seconds)
> -		return;
> -
> -	time64_to_tm(seconds, 0, &tm);
> -
> -	snprintf(time_str, size, "%ld-%02d-%02d %02d:%02d:%02d (UTC)",
> -		tm.tm_year + 1900, tm.tm_mon, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
> -}
> -
>  static bool hl_device_eq_heartbeat_received(struct hl_device *hdev)
>  {
>  	struct eq_heartbeat_debug_info *heartbeat_debug_info = &hdev->heartbeat_debug_info;
>  	u32 cpu_q_id = heartbeat_debug_info->cpu_queue_id, pq_pi_mask = (HL_QUEUE_LENGTH << 1) - 1;
>  	struct asic_fixed_properties *prop = &hdev->asic_prop;
> -	char pq_time_str[64] = "N/A", eq_time_str[64] = "N/A";
>  
>  	if (!prop->cpucp_info.eq_health_check_supported)
>  		return true;
> @@ -1095,17 +1078,15 @@ static bool hl_device_eq_heartbeat_received(struct hl_device *hdev)
>  	if (!hdev->eq_heartbeat_received) {
>  		dev_err(hdev->dev, "EQ heartbeat event was not received!\n");
>  
> -		stringify_time_of_last_heartbeat(hdev, pq_time_str, sizeof(pq_time_str), true);
> -		stringify_time_of_last_heartbeat(hdev, eq_time_str, sizeof(eq_time_str), false);
>  		dev_err(hdev->dev,
> -			"EQ: {CI %u, HB counter %u, last HB time: %s}, PQ: {PI: %u, CI: %u (%u), last HB time: %s}\n",
> +			"EQ: {CI %u, HB counter %u, last HB time: %ptTs}, PQ: {PI: %u, CI: %u (%u), last HB time: %ptTs}\n",
>  			hdev->event_queue.ci,
>  			heartbeat_debug_info->heartbeat_event_counter,
> -			eq_time_str,
> +			&hdev->heartbeat_debug_info.last_eq_heartbeat_ts,
>  			hdev->kernel_queues[cpu_q_id].pi,
>  			atomic_read(&hdev->kernel_queues[cpu_q_id].ci),
>  			atomic_read(&hdev->kernel_queues[cpu_q_id].ci) & pq_pi_mask,
> -			pq_time_str);
> +			&hdev->heartbeat_debug_info.last_pq_heartbeat_ts);
>  
>  		hl_eq_dump(hdev, &hdev->event_queue);
>  
> -- 
> 2.47.2
> 

-- 
With Best Regards,
Andy Shevchenko



