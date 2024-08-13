Return-Path: <linux-kernel+bounces-285572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9C4950FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0161C2228E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7241AB512;
	Tue, 13 Aug 2024 22:50:31 +0000 (UTC)
Received: from sxb1plsmtpa01-04.prod.sxb1.secureserver.net (sxb1plsmtpa01-04.prod.sxb1.secureserver.net [92.204.81.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF236B11
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589431; cv=none; b=lmrtYrhiQtLBw9tHnkqPiFsh0P7OcKM+i540QG2/LXppjJAN9B09JaUE1z1kkZYci5xTrGLnQJYgWueEaIP2QqNvuSoW1BZzI2X3m8FuxFeqH0thmokxqYlNOg5t3PodK8rwafOg4yZc0wnjCXrTkGNnI2kX17LK8qt4yl4K+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589431; c=relaxed/simple;
	bh=49NHkGj4gMT2BNbHsogNRL4db5RNDTOexw5fc9yMBwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCchpmwzhcIPOXWqqAi9cZY1XTuopLB9EEHcl6UzBe3L27s6YsKNMlYbr8nNUOZVvMQrHU+bA9F8d/7tIYxxpWAmXnH/HcpfZVejE3/AZ5SeQWRtXd5xI8eVGqcyXm+NuHH+sPy3zmRmGivdXKRRR58ZF1usxOFXvwBBrSQEOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net; spf=pass smtp.mailfrom=piie.net; arc=none smtp.client-ip=92.204.81.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piie.net
Received: from [192.168.1.27] ([109.90.180.58])
	by :SMTPAUTH: with ESMTPSA
	id dykRsdOMofewidykTsOcWp; Tue, 13 Aug 2024 14:08:10 -0700
X-CMAE-Analysis: v=2.4 cv=fYxmyFQF c=1 sm=1 tr=0 ts=66bbcb3b
 a=ujCVow8R4Y5jPCx6COW8WA==:117 a=ujCVow8R4Y5jPCx6COW8WA==:17
 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=QyXUC8HyAAAA:8 a=t3YNmgBSAAAA:8
 a=uA_CGoYEU2hLf27nDvEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ctH_qozkpUrkr3SVbfwb:22
X-SECURESERVER-ACCT: peter@piie.net
Message-ID: <f8721601-3eb8-4655-a207-fb7e38de2867@piie.net>
Date: Tue, 13 Aug 2024 23:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to
 reduce overhead
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
 <2285575.iZASKD2KPV@rjwysocki.net>
Content-Language: en-US
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
In-Reply-To: <2285575.iZASKD2KPV@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGedixXDMi4Jj7OHNj9s1SlJyk2fAnQI15GP1ma5XklIJsg6LrNxyokXv2o2GRHRVqA8s5g+QZx6swcLlGCYbkaCYOoAjUKbTS4c9X+gvP9s+1xf7lYA
 f8yH5JdFbi/qWyBFgxSaAOattJZuIedYyknEAaRAY60W5D+RjEhcN0k5vnWuuwkxeoILKPdZ9NuFycUkXxeUTvT/HXcIEpObWq092nC0J1mQ/034cH1FRZp8
 LF3wsePwXYkDF8gdTwTkJEvep2WSidkBMUUDoOhqxayu+mwiNzWuWZOX2qey9ZDx13ZEZ2OE1Vt3OfYrpduIqFlPeq/iOOlBytwaJsunszcnB3Fe4ZqsLzXg
 GdSxoggLL6jFa+fpMHezO7zH0Nd5GQ==

On 13.08.24 16:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After running once, the for_each_trip_desc() loop in
> bang_bang_manage() is pure needless overhead because it is not going to
> make any changes unless a new cooling device has been bound to one of
> the trips in the thermal zone or the system is resuming from sleep.
> 
> For this reason, make bang_bang_manage() set governor_data for the
> thermal zone and check it upfront to decide whether or not it needs to
> do anything.
> 
> However, governor_data needs to be reset in some cases to let
> bang_bang_manage() know that it should walk the trips again, so add an
> .update_tz() callback to the governor and make the core additionally
> invoke it during system resume.
> 
> To avoid affecting the other users of that callback unnecessarily, add
> a special notification reason for system resume, THERMAL_TZ_RESUME, and
> also pass it to __thermal_zone_device_update() called during system
> resume for consistency.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Peter Kästle <peter@piie.net>

> ---
>   drivers/thermal/gov_bang_bang.c |   18 ++++++++++++++++++
>   drivers/thermal/thermal_core.c  |    3 ++-
>   include/linux/thermal.h         |    1 +
>   3 files changed, 21 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -86,6 +86,10 @@ static void bang_bang_manage(struct ther
>   	const struct thermal_trip_desc *td;
>   	struct thermal_instance *instance;
>   
> +	/* If the code below has run already, nothing needs to be done. */
> +	if (tz->governor_data)
> +		return;
> +
>   	for_each_trip_desc(tz, td) {
>   		const struct thermal_trip *trip = &td->trip;
>   
> @@ -107,11 +111,25 @@ static void bang_bang_manage(struct ther
>   				bang_bang_set_instance_target(instance, 0);
>   		}
>   	}
> +
> +	tz->governor_data = (void *)true;
> +}
> +
> +static void bang_bang_update_tz(struct thermal_zone_device *tz,
> +				enum thermal_notify_event reason)
> +{
> +	/*
> +	 * Let bang_bang_manage() know that it needs to walk trips after binding
> +	 * a new cdev and after system resume.
> +	 */
> +	if (reason == THERMAL_TZ_BIND_CDEV || reason == THERMAL_TZ_RESUME)
> +		tz->governor_data = NULL;
>   }
>   
>   static struct thermal_governor thermal_gov_bang_bang = {
>   	.name		= "bang_bang",
>   	.trip_crossed	= bang_bang_control,
>   	.manage		= bang_bang_manage,
> +	.update_tz	= bang_bang_update_tz,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1692,7 +1692,8 @@ static void thermal_zone_device_resume(s
>   
>   	thermal_debug_tz_resume(tz);
>   	thermal_zone_device_init(tz);
> -	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +	thermal_governor_update_tz(tz, THERMAL_TZ_RESUME);
> +	__thermal_zone_device_update(tz, THERMAL_TZ_RESUME);
>   
>   	complete(&tz->resume);
>   	tz->resuming = false;
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -55,6 +55,7 @@ enum thermal_notify_event {
>   	THERMAL_TZ_BIND_CDEV, /* Cooling dev is bind to the thermal zone */
>   	THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal zone */
>   	THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight changed */
> +	THERMAL_TZ_RESUME, /* Thermal zone is resuming after system sleep */
>   };
>   
>   /**
> 
> 
> 

