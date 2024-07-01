Return-Path: <linux-kernel+bounces-236208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C21991DEC0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37991F2165B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47686149E0E;
	Mon,  1 Jul 2024 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPSgkEop"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F184D02
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835727; cv=none; b=rh2GWdCSUk1jfPTV3We5pgWXNuKIkyHq/PQaGMd6omVBulv27UF4QUz6Y7uUbGYLxPgxZhK0v9mqR4J4QbZZ1/vnGc2VM7swtR3HXsuX95H7I/zWE1xHJpEU9BBnx+Igx3t1o5p8uyoffdlZd++cd07tyKilLCLyLLBXpA6PijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835727; c=relaxed/simple;
	bh=WUjSuKCg9NSzxI8SCCjTXanKyqz4L8te9T07gaFM+5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EawEB7tdofhGL7P1ZmlptL2R6o2GfL2Neqxi8tCwzXnCGdUNOTmYAYfkpBHyvgdRh5fDPhvfbj9t6NAqO9N8Izoqieo+fkdrfaAo9JfwV40Wlc38lp0nm7QMDpgdOTLJ1QnvRQS5e/BlU5BSc8MjTjOrs/XA5JpoAscuqXii+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPSgkEop; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42562e4b5d1so21217155e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719835723; x=1720440523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2KF4vkhxrngZD38pR7ecJLOeZPUSvXYUWq1viVxJik=;
        b=XPSgkEopwz/TQ78Csq5dFwTerLMXwohpAWip2F0vZ6dHmJW4FYkj0eOisP1HlnylYd
         Z/5WjG/w9JwQXMXBtgkvagRZeVb+EwrjGdWKE9vaijuARDmprlf9IdZmFAjapfoUebhS
         KFwhNSh2+aVBFJBUp+lq0pfkWR5YSAtV6Vl+aFxK0WTYCOE6klLdwMj9R5PZSPlmKRkC
         RKvb/SIv8oKj8U11g5JC6GoaaGm8/OMYJ0FSYC2888wFtX12veryU2dkLQnyYpStPAKJ
         9eu7Eu9Y1HvC4WEjz1L1CSFDM2rTcts/98YWd4SGq/S6Ofb2UxbE10C9qIp37QOnfTPA
         UKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719835723; x=1720440523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2KF4vkhxrngZD38pR7ecJLOeZPUSvXYUWq1viVxJik=;
        b=PWwT9belA6WWFP+Zylnfr04Plqzsxt0lUvMobhKXfeGWWdaN3lXrSQy48Gxet+HEn8
         Oa1o/FJHqvHHqxwd9hOau53IyoCabp9Byi3X4avJZdxEBJSXHYPAeFWi88A+WWxs5vuJ
         Tb4lHHxt4fM7JgFlH8w/Hoe+/GqiV0HJZA69APUP9RD/a/3NHgpQ6qqTfDzYqPwMlNzA
         lC50zgcLN6UtpRtqw8cev4dppV5NRKsGwuoj7DJSCFWkfOBDojGROrChRmvwkRIUKtJt
         yTO0OXS23lcZYzrYw88dcbJAUnlytKgQCgR6sF8BwYBgT/rDEcqnPEblEOqzhAJysolq
         VH1g==
X-Gm-Message-State: AOJu0YyXtBAV+wJkL1XdVauCtEE6gag55sXbn9H9Nwg3GjAkmBbi9y1k
	O5bPrZHDYlx57OJlLq1sCgxlsvnISRUenQqoves8gnpWjWDGv4TL8y930vZgw3U=
X-Google-Smtp-Source: AGHT+IGvqiMOgveWhJuHFwpWtnZfXkByNdC7FHp1rCI4kFn6ENeOmd6c24XvhPliOdiTWyog3TX94A==
X-Received: by 2002:a05:600c:a14:b0:424:8ae8:d9fe with SMTP id 5b1f17b1804b1-4257a00aa4bmr36675155e9.6.1719835723387;
        Mon, 01 Jul 2024 05:08:43 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d5d7:31af:53ed:6dbc? ([2a05:6e02:1041:c10:d5d7:31af:53ed:6dbc])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256b097bcbsm150577625e9.35.2024.07.01.05.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 05:08:43 -0700 (PDT)
Message-ID: <a26fce1b-c222-4812-b889-b9859786dc70@linaro.org>
Date: Mon, 1 Jul 2024 14:08:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2764814.mvXUDI8C0e@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2764814.mvXUDI8C0e@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/06/2024 14:10, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
> if zone temperature is invalid") caused __thermal_zone_device_update()
> to return early if the current thermal zone temperature was invalid.
> 
> This was done to avoid running handle_thermal_trip() and governor
> callbacks in that case which led to confusion.  However, it went too
> far because monitor_thermal_zone() still needs to be called even when
> the zone temperature is invalid to ensure that it will be updated
> eventually in case thermal polling is enabled and the driver has no
> other means to notify the core of zone temperature changes (for example,
> it does not register an interrupt handler or ACPI notifier).
> 
> Also if the .set_trips() zone callback is expected to set up monitoring
> interrupts for a thermal zone, it has to be provided with valid
> boundaries and that can only happen if the zone temperature is known.
> 
> Accordingly, to ensure that __thermal_zone_device_update() will
> run again after a failing zone temperature check, make it call
> monitor_thermal_zone() regardless of whether or not the zone
> temperature is valid and make the latter schedule a thermal zone
> temperature update if the zone temperature is invalid even if
> polling is not enabled for the thermal zone.
> 
> Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() if zone temperature is invalid")
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


