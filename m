Return-Path: <linux-kernel+bounces-576768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D5CA7143B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47121173B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707781B0435;
	Wed, 26 Mar 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IaMzXBLm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAB61A83F5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982941; cv=none; b=g1kXv8jJ55bi/DlZ4JjNVU5fb4kGVrsLSBfKyeD3/gpOI7FWqZadDpzH3TBAQpVKa+S+JRzW2y1G1+TfsPba1R9JORaJDwVOBq17VPzuGw7lS4GtXnW1I44kp/bDdo8Otm3MTkG3bCzF/M/pLHKdfTRgv1Vpd40GjZBX4dUXx1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982941; c=relaxed/simple;
	bh=+TMyAXA9Y8T/sPf5483bMjpGzBJY2oL2rsAiG0HV9wI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sHVzfgEIcuoSkbzTRkXVxD9Yhb8uIizRLxH/WxEpAdGF3tebw61R/um3+5Is9I+URe2S4vhsHXktVRIK3UGlIinKXous9Qm0kVjZfEMW4NM3W8B/32pAJSxL8LvqerHgKC8k2JxQDIiIfk/w5HlRXZjq8472GrPh68s3aOGhJiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IaMzXBLm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742982939; x=1774518939;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+TMyAXA9Y8T/sPf5483bMjpGzBJY2oL2rsAiG0HV9wI=;
  b=IaMzXBLm4rlz4yA0qmmrhzWihVWu5XKMmsML0Vfw04pAywcAqIS2T879
   7IAkeL5GK6NMlhr6FAe1bAdPdZ7VLxJiB/G65tuqeaDA3AETBjitMLy3t
   MmTrGR2aVMy+ULxgTJcJwYk1mP0exqbkAGNnAL9Vd9qsbMkW+kKFNO9mm
   WROt8zHrp3Jo4EaZF+V5YHKbP8BNfTxJOt9aIkZjD/fDx38ObtzrsT24e
   MUuBfKQhMReS6UFX4qepXrSean2kDuz99UdW8eNJ2n1b0ErxSleKjs9xC
   zFed1d6gmgSnGUToVPFu/2a6bEEfvS87qLFxQkZbKuXI+EgpCqQ/wrZfy
   g==;
X-CSE-ConnectionGUID: lAfe32UBTFqDBlyfxqOajg==
X-CSE-MsgGUID: GD0FiR02T6WB9YEDtjAF1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54465501"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="54465501"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 02:55:39 -0700
X-CSE-ConnectionGUID: jWqo8wuuT9Kk/mPQWn9Myg==
X-CSE-MsgGUID: qhwbKTLkSvO1/sD1B/PJOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="155728159"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.210])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 02:55:36 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Oded Gabbay <ogabbay@kernel.org>, "Avizrat, Yaron"
 <yaron.avizrat@intel.com>, "Elbaz, Koby" <koby.elbaz@intel.com>, "Sinyuk,
 Konstantin" <konstantin.sinyuk@intel.com>
Subject: Re: [PATCH v3 1/1] accel/habanalabs: Switch to use %ptTs
In-Reply-To: <Z-PM8oBtTPzqv-S2@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250305110126.2134307-1-andriy.shevchenko@linux.intel.com>
 <Z-PM8oBtTPzqv-S2@smile.fi.intel.com>
Date: Wed, 26 Mar 2025 11:55:33 +0200
Message-ID: <87zfh86rqi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 26 Mar 2025, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> +Cc: Jani (sorry, forgot to add you in the first place).
>
> Do you think it's applicable now?

Cc: Yaron, Koby, and Konstantin who are supposed to be the new
maintainers for accel/habanalabs.


BR,
Jani.



>
> On Wed, Mar 05, 2025 at 01:00:25PM +0200, Andy Shevchenko wrote:
>> Use %ptTs instead of open-coded variant to print contents of time64_t type
>> in human readable form.
>> 
>> This changes N/A output to 1970-01-01 00:00:00 for zero timestamps,
>> but it's used only in the dev_err() output and won't break anything.
>> 
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> 
>> v3: explained the difference for N/A cases (Jani)
>> v2: fixed the parameters to be the pointers
>> 
>>  drivers/accel/habanalabs/common/device.c | 25 +++---------------------
>>  1 file changed, 3 insertions(+), 22 deletions(-)
>> 
>> diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
>> index 68eebed3b050..80fa08bf57bd 100644
>> --- a/drivers/accel/habanalabs/common/device.c
>> +++ b/drivers/accel/habanalabs/common/device.c
>> @@ -1066,28 +1066,11 @@ static bool is_pci_link_healthy(struct hl_device *hdev)
>>  	return (device_id == hdev->pdev->device);
>>  }
>>  
>> -static void stringify_time_of_last_heartbeat(struct hl_device *hdev, char *time_str, size_t size,
>> -						bool is_pq_hb)
>> -{
>> -	time64_t seconds = is_pq_hb ? hdev->heartbeat_debug_info.last_pq_heartbeat_ts
>> -					: hdev->heartbeat_debug_info.last_eq_heartbeat_ts;
>> -	struct tm tm;
>> -
>> -	if (!seconds)
>> -		return;
>> -
>> -	time64_to_tm(seconds, 0, &tm);
>> -
>> -	snprintf(time_str, size, "%ld-%02d-%02d %02d:%02d:%02d (UTC)",
>> -		tm.tm_year + 1900, tm.tm_mon, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
>> -}
>> -
>>  static bool hl_device_eq_heartbeat_received(struct hl_device *hdev)
>>  {
>>  	struct eq_heartbeat_debug_info *heartbeat_debug_info = &hdev->heartbeat_debug_info;
>>  	u32 cpu_q_id = heartbeat_debug_info->cpu_queue_id, pq_pi_mask = (HL_QUEUE_LENGTH << 1) - 1;
>>  	struct asic_fixed_properties *prop = &hdev->asic_prop;
>> -	char pq_time_str[64] = "N/A", eq_time_str[64] = "N/A";
>>  
>>  	if (!prop->cpucp_info.eq_health_check_supported)
>>  		return true;
>> @@ -1095,17 +1078,15 @@ static bool hl_device_eq_heartbeat_received(struct hl_device *hdev)
>>  	if (!hdev->eq_heartbeat_received) {
>>  		dev_err(hdev->dev, "EQ heartbeat event was not received!\n");
>>  
>> -		stringify_time_of_last_heartbeat(hdev, pq_time_str, sizeof(pq_time_str), true);
>> -		stringify_time_of_last_heartbeat(hdev, eq_time_str, sizeof(eq_time_str), false);
>>  		dev_err(hdev->dev,
>> -			"EQ: {CI %u, HB counter %u, last HB time: %s}, PQ: {PI: %u, CI: %u (%u), last HB time: %s}\n",
>> +			"EQ: {CI %u, HB counter %u, last HB time: %ptTs}, PQ: {PI: %u, CI: %u (%u), last HB time: %ptTs}\n",
>>  			hdev->event_queue.ci,
>>  			heartbeat_debug_info->heartbeat_event_counter,
>> -			eq_time_str,
>> +			&hdev->heartbeat_debug_info.last_eq_heartbeat_ts,
>>  			hdev->kernel_queues[cpu_q_id].pi,
>>  			atomic_read(&hdev->kernel_queues[cpu_q_id].ci),
>>  			atomic_read(&hdev->kernel_queues[cpu_q_id].ci) & pq_pi_mask,
>> -			pq_time_str);
>> +			&hdev->heartbeat_debug_info.last_pq_heartbeat_ts);
>>  
>>  		hl_eq_dump(hdev, &hdev->event_queue);
>>  
>> -- 
>> 2.47.2
>> 

-- 
Jani Nikula, Intel

