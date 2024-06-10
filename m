Return-Path: <linux-kernel+bounces-207843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31838901CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E72C282581
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3676F2E1;
	Mon, 10 Jun 2024 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRTxXx3h"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C03BBC5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008126; cv=none; b=BmjvXTxNYMvKW2sUsd4NLgtD+ab7prgkAyhwihYNMRiLz1eL5nOrRexkwhtJ1RlYfo7QHeW0HaH2Yl9zkHX3oSXn7RwKY/4jjBpVIVSOVszOKFG5VoMutiaes53MsTRr9rBl02vWyjJP4eeYYUT7zsBNvXUrt99O4WNbXOyIMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008126; c=relaxed/simple;
	bh=dM6k5DbWIP8ixdzmtFZSfJNzZE44gJhJcdHlZIYPzic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfZR8KAxHafnUQvKpd61j+ZEJKpjBpwC3cBEAoD6rnR9Fluf/v7tDnM1XsFoIqzIxtdBr+iW1cyrx1EwVOk9I/KdJv6stw6EH/qSJXp1DKw0Sdn+5s+6y4hIh9WPXyVAZelW64NE6q13zRIoY94zZjf3pftO2p3idp2THF50t/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NRTxXx3h; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f1a7386d5so1128585f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718008123; x=1718612923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAIjV9YREPOA3y7uEEQgAajQX3eo8bQN1I0xBsKhc/E=;
        b=NRTxXx3hL6pYhkm1sYUfkyJI1noFstOgG2GHcuMMhBfQfLP+GQXsaQdHRukdbRdU/x
         Pf+aPoruCZ9qClHKBLtndYyvuAtQf3wJ24HMSd+lipVzdtTL3hDUo4kYwU5MV6SHDMhE
         EW4NHoOv5viBI7ILJALP3dAcmoxp3fMuUv0iIdPORAmGH0FtyXF2Q6bEK/ALlMFuvMBC
         4AgqBKRO2bwFqdB18y9UNfAR6ZND/6m/PvZR3rNgVCnENwXiu96vSRarXbPpoJJeGqJc
         3RUVnNrc/Thh8tjHMdpZ7hCYyhzmGvM0pK/eyViSJZRQgVmLd7kV4DEYkFQoz7PU/vi5
         mFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008123; x=1718612923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAIjV9YREPOA3y7uEEQgAajQX3eo8bQN1I0xBsKhc/E=;
        b=LQmAdgFuoT9g6lS8lMIr2gGO1zhY/qxMGZLLvoSKbzWQ+ItMWasAepWdVurMCJthTw
         dbvepZGK9gBZU8Kyt2+NFML9/fWG94k5/qDy5iGjBowRzoZcC75p+IFmDc+4pBpOVt2r
         KoytPml26ZZEkhLFNZl3WAPn6rUY3UXqp/s1IchSzza/trTBqKjFHH//W8LMV/ra5LfJ
         fecSQnmi7xEziWcQ8WZpvIZFSjhU3OulGFPC0aJ1vZcFCtTm4jxEW/Okj5eGL8NRIwER
         2huJt6wtPZ/FWQ3DKqxuYlbS1uwMOo9hJI8e4WyekKmP8JmNj95v8Le4VzDQHO/bTTVE
         rtjQ==
X-Gm-Message-State: AOJu0YwyKNJJ+YXpzx6nv41mqgMz6oXGJVvAampFcpjRNrR7Uc/uaVYH
	HWerHp5cpoKWKs9X6l+EMwBqB8DxCgY8/jNCiWmEqDGhmPOod3ipZnb2Z2ecCzcnV/BADEFwQjk
	3
X-Google-Smtp-Source: AGHT+IHPCRLdBIjnYoKmaoO0wJ+nCvloZ3gIQJhkNoof6djxllay6FKmoB4Bzi5wPFS51BxbZin8xw==
X-Received: by 2002:a5d:53c3:0:b0:35f:234a:9c0e with SMTP id ffacd0b85a97d-35f234a9cd9mr1585362f8f.30.1718008122991;
        Mon, 10 Jun 2024 01:28:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35f2210ae90sm2862139f8f.97.2024.06.10.01.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:28:42 -0700 (PDT)
Message-ID: <dd446bf6-05ca-4861-b3b1-f113c3528f13@linaro.org>
Date: Mon, 10 Jun 2024 10:28:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] thermal/debugfs: Do not extend mitigation episodes
 beyond system resume
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <2337425.ElGaqSPkdT@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2337425.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 16:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal zone handling by the thermal core is started from
> scratch during resume from system-wide suspend, prevent the debug
> code from extending mitigation episodes beyond that point by ending
> the mitigation episode currently in progress, if any, for each thermal
> zone.

Why it is done at resume time and not at suspend time ?

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Rebase.
> 
> ---
>   drivers/thermal/thermal_core.c    |    1 +
>   drivers/thermal/thermal_debugfs.c |   36 ++++++++++++++++++++++++++++++++++++
>   drivers/thermal/thermal_debugfs.h |    2 ++
>   3 files changed, 39 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1641,6 +1641,7 @@ static void thermal_zone_device_resume(s
>   
>   	tz->suspended = false;
>   
> +	thermal_debug_tz_resume(tz);
>   	thermal_zone_device_init(tz);
>   	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -926,3 +926,39 @@ void thermal_debug_tz_remove(struct ther
>   	thermal_debugfs_remove_id(thermal_dbg);
>   	kfree(trips_crossed);
>   }
> +
> +void thermal_debug_tz_resume(struct thermal_zone_device *tz)
> +{
> +	struct thermal_debugfs *thermal_dbg = tz->debugfs;
> +	ktime_t now = ktime_get();
> +	struct tz_debugfs *tz_dbg;
> +	struct tz_episode *tze;
> +	int i;
> +
> +	if (!thermal_dbg)
> +		return;
> +
> +	mutex_lock(&thermal_dbg->lock);
> +
> +	tz_dbg = &thermal_dbg->tz_dbg;
> +
> +	if (!tz_dbg->nr_trips)
> +		goto out;
> +
> +	/*
> +	 * A mitigation episode was in progress before the preceding system
> +	 * suspend transition, so close it because the zone handling is starting
> +	 * over from scratch.
> +	 */
> +	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
> +
> +	for (i = 0; i < tz_dbg->nr_trips; i++)
> +		tz_episode_close_trip(tze, tz_dbg->trips_crossed[i], now);
> +
> +	tze->duration = ktime_sub(now, tze->timestamp);
> +
> +	tz_dbg->nr_trips = 0;
> +
> +out:
> +	mutex_unlock(&thermal_dbg->lock);
> +}
> Index: linux-pm/drivers/thermal/thermal_debugfs.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.h
> +++ linux-pm/drivers/thermal/thermal_debugfs.h
> @@ -7,6 +7,7 @@ void thermal_debug_cdev_remove(struct th
>   void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev, int state);
>   void thermal_debug_tz_add(struct thermal_zone_device *tz);
>   void thermal_debug_tz_remove(struct thermal_zone_device *tz);
> +void thermal_debug_tz_resume(struct thermal_zone_device *tz);
>   void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
>   			      const struct thermal_trip *trip);
>   void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
> @@ -20,6 +21,7 @@ static inline void thermal_debug_cdev_st
>   						   int state) {}
>   static inline void thermal_debug_tz_add(struct thermal_zone_device *tz) {}
>   static inline void thermal_debug_tz_remove(struct thermal_zone_device *tz) {}
> +static inline void thermal_debug_tz_resume(struct thermal_zone_device *tz) {}
>   static inline void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
>   					    const struct thermal_trip *trip) {};
>   static inline void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


