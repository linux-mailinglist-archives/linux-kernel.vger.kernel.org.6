Return-Path: <linux-kernel+bounces-239457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E7D92603E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0559C1F21820
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C37174EFC;
	Wed,  3 Jul 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHJlgwge"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB816DEC3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009534; cv=none; b=jHCVLSIOsFgsYJo0b2O+u0vi7ZIb8QvwYmZxGs6NoO7Ha01/lqhpgTwS9v52FpRF2tjX/kwGjqdD6MPVvacNfBA0EvWMgRx/A+sz5SruG//qTZRl3lgPhzAtXYdcNcYhBTyRHU1d8VrdmyxShElMBrieeSwIxLONQweEzPyl1oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009534; c=relaxed/simple;
	bh=I0TmNWS82rfgW/QfQgxFVLhB3fa4T6aLJ83UlfiXrRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lp3xAX/Op6s0cOezKiEFMj2d6akft6hHX4WK0DpkP7cD+FdXaWz45+i5K38nfsN4K4KwzHQFANjeFjF8icCORCOTJX4CgBIa91/iV7CfWyUsQ2II7b/cVzurwwTFfH62vVDmStlQg/F1PC1mZgc11FPXq4jM1QsOI3khKAl1TS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WHJlgwge; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e829086f3so5833090e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720009530; x=1720614330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yaCxgkJVDeQB6/lkRaL7RTy2xotF3XDRfodozHqIcc4=;
        b=WHJlgwgelBCo7T+WAnvMZEyP2CM0ikB00T5/0bXnoT2vJ5PzajUNxndi0Pe0x8Nwme
         RtyIZbchgbtGdHr+7EOmL8UNDaaSD8mYAKHizz2uh7dlWB1C+aQv7+o+k9y4IU4Du1II
         1e6IVS6n3Gsn3956Fi0xrcrrgwocc4VkwwfNCaLwQtNKB5RN4MEwwt15XSp4Sv60U6Ll
         CFbgBgOYYhjqiRx7uj2zbsSwdrMUikH+zZq1LCJyCjcKSTRs4CQ4SfClzqhcUay4PXXy
         uCJ1xmGp3NFxTQabRYiFpJXLYCqvLhDcmP9yuGd+dhQ3zLm3Vw+Afa+WhTCr//ws7hkl
         Auag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720009530; x=1720614330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaCxgkJVDeQB6/lkRaL7RTy2xotF3XDRfodozHqIcc4=;
        b=UDB5v+1W3gXT/moXq/1+XDdHn1ONfQparjeGAMXfF9Q7roCMiGJEAiscw3WrVFObTJ
         3/9jNf8IgMCh342KR57K1SW3s9AZ3EKOC/HcAinSL3BbWdN7UwHpzW2jz9axQ6fkRoqt
         GHwMqhCpke6poGTaxLP00xDdshrW1S/tykfIaOezXwne6tcvMTL39LClNK4OZEd+kLla
         dWYVWwmel7lJI5rITx54VIbiQWTfL2lXM/w2a64ouIFeURzd8sKn48c9rupdCUNBlosY
         yDSu0/2Nip9FUwDBYOX078u1GYpcik9W8TiuXe1kNTndyisnfxCD44uspIQ31ccEKII4
         f/Pw==
X-Gm-Message-State: AOJu0Ywc4jgJuPLyku/AkUe6tJul0CpnGLHVDeQk3GrLjl1JvxuTjPLc
	BToY5eUwx2EzEEAKggmWKRqKyrrl7QWQSTYjQ9NDrgXoaiTGTEfAjE6vhgwE6j4=
X-Google-Smtp-Source: AGHT+IEIfeBvq5HjHJi3vvVvWXPttEL/zAsQI2rmlYX6VEfFcTpswoId1JjPyIGMFNVqE2KrkP6LiQ==
X-Received: by 2002:a05:6512:2247:b0:52c:e184:3dd6 with SMTP id 2adb3069b0e04-52e825ccc2fmr6877841e87.0.1720009530233;
        Wed, 03 Jul 2024 05:25:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256af3cf90sm235092895e9.5.2024.07.03.05.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:25:29 -0700 (PDT)
Message-ID: <8d91a3c1-018f-495b-83be-979b795b5548@linaro.org>
Date: Wed, 3 Jul 2024 14:25:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: neil.armstrong@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <2764814.mvXUDI8C0e@rjwysocki.net>
 <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Neil,

it seems there is something wrong with the driver actually.

There can be a moment where the sensor is not yet initialized for 
different reason, so reading the temperature fails. The routine will 
just retry until the sensor gets ready.

Having these errors seem to me that the sensor for this specific thermal 
zone is never ready which may be the root cause of your issue. The 
change is spotting this problem IMO.


On 03/07/2024 12:54, Neil Armstrong wrote:
> Hi,
> 
> On 28/06/2024 14:10, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
>> if zone temperature is invalid") caused __thermal_zone_device_update()
>> to return early if the current thermal zone temperature was invalid.
>>
>> This was done to avoid running handle_thermal_trip() and governor
>> callbacks in that case which led to confusion.  However, it went too
>> far because monitor_thermal_zone() still needs to be called even when
>> the zone temperature is invalid to ensure that it will be updated
>> eventually in case thermal polling is enabled and the driver has no
>> other means to notify the core of zone temperature changes (for example,
>> it does not register an interrupt handler or ACPI notifier).
>>
>> Also if the .set_trips() zone callback is expected to set up monitoring
>> interrupts for a thermal zone, it has to be provided with valid
>> boundaries and that can only happen if the zone temperature is known.
>>
>> Accordingly, to ensure that __thermal_zone_device_update() will
>> run again after a failing zone temperature check, make it call
>> monitor_thermal_zone() regardless of whether or not the zone
>> temperature is valid and make the latter schedule a thermal zone
>> temperature update if the zone temperature is invalid even if
>> polling is not enabled for the thermal zone.
>>
>> Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() 
>> if zone temperature is invalid")
>> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/thermal/thermal_core.c |    5 ++++-
>>   drivers/thermal/thermal_core.h |    6 ++++++
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> Index: linux-pm/drivers/thermal/thermal_core.c
>> ===================================================================
>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>> +++ linux-pm/drivers/thermal/thermal_core.c
>> @@ -300,6 +300,8 @@ static void monitor_thermal_zone(struct
>>           thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
>>       else if (tz->polling_delay_jiffies)
>>           thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>> +    else if (tz->temperature == THERMAL_TEMP_INVALID)
>> +        thermal_zone_device_set_polling(tz, 
>> msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
>>   }
>>   static struct thermal_governor *thermal_get_tz_governor(struct 
>> thermal_zone_device *tz)
>> @@ -514,7 +516,7 @@ void __thermal_zone_device_update(struct
>>       update_temperature(tz);
>>       if (tz->temperature == THERMAL_TEMP_INVALID)
>> -        return;
>> +        goto monitor;
>>       tz->notify_event = event;
>> @@ -536,6 +538,7 @@ void __thermal_zone_device_update(struct
>>       thermal_debug_update_trip_stats(tz);
>> +monitor:
>>       monitor_thermal_zone(tz);
>>   }
>> Index: linux-pm/drivers/thermal/thermal_core.h
>> ===================================================================
>> --- linux-pm.orig/drivers/thermal/thermal_core.h
>> +++ linux-pm/drivers/thermal/thermal_core.h
>> @@ -133,6 +133,12 @@ struct thermal_zone_device {
>>       struct thermal_trip_desc trips[] __counted_by(num_trips);
>>   };
>> +/*
>> + * Default delay after a failing thermal zone temperature check before
>> + * attempting to check it again.
>> + */
>> +#define THERMAL_RECHECK_DELAY_MS    100
>> +
>>   /* Default Thermal Governor */
>>   #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
>>   #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
>>
>>
>>
>>
> 
> This patch on next-20240702 makes Qualcomm HDK8350, HDK8450, QRD8550, 
> HDK8560, QRD8650 & HDK8650 output in loop:
> 
> thermal thermal_zoneXX: failed to read out thermal zone (-19)
> 
> Boot logs or ARM64 defconfig:
> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152439#L1393
> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152440#L2200
> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152442#L2828
> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152441#L1862
> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152443#L1776
> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152444#L1723
> 
> Result of git bisect:
> # bad: [82e4255305c554b0bb18b7ccf2db86041b4c8b6e] Add linux-next 
> specific files for 20240702
> # good: [22a40d14b572deb80c0648557f4bd502d7e83826] Linux 6.10-rc6
> git bisect start 'FETCH_HEAD' 'v6.10-rc6'
> # bad: [f6dfcf0e9567b57b93f2564966d9177f0d8dbe05] Merge branch 'master' 
> of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect bad f6dfcf0e9567b57b93f2564966d9177f0d8dbe05
> # good: [7f86ae0c2dc19fea7be1da29b2bf03f085463ae7] Merge branch 
> 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
> git bisect good 7f86ae0c2dc19fea7be1da29b2bf03f085463ae7
> # bad: [077d5bbd75dd12af2096c96846ffc78ab5dd65b1] Merge branch 
> 'devfreq-next' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> git bisect bad 077d5bbd75dd12af2096c96846ffc78ab5dd65b1
> # good: [271bcaf753d0afe2bd0386ab1e98132ee65b61ca] Merge branch 
> 'for-next' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
> git bisect good 271bcaf753d0afe2bd0386ab1e98132ee65b61ca
> # good: [9758a2ee5316a6f8736ab4fd39a6f6176aa057ec] Merge branch 
> 'hwmon-next' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> git bisect good 9758a2ee5316a6f8736ab4fd39a6f6176aa057ec
> # good: [e6bd69ea345045520bd63487b85a4b5676aff76b] Merge branch 'master' 
> of git://linuxtv.org/mchehab/media-next.git
> git bisect good e6bd69ea345045520bd63487b85a4b5676aff76b
> # good: [46398edfb36e2882be5e86ea563b2db9138ae499] Merge branches 
> 'pm-cpuidle' and 'pm-powercap' into linux-next
> git bisect good 46398edfb36e2882be5e86ea563b2db9138ae499
> # good: [d3927cbc52eed166f74ea7e031ed6384cc3d4d5f] Merge branch 
> 'thermal-intel' into linux-next
> git bisect good d3927cbc52eed166f74ea7e031ed6384cc3d4d5f
> # good: [ce84b7beeb524e7b20983838687862454ba54df7] cpufreq: sti: add 
> missing MODULE_DEVICE_TABLE entry for stih418
> git bisect good ce84b7beeb524e7b20983838687862454ba54df7
> # bad: [fcf61315d38d41f4e55856b179f9e5538e299ef4] Merge branch 
> 'thermal-fixes' into linux-next
> git bisect bad fcf61315d38d41f4e55856b179f9e5538e299ef4
> # good: [4262b8d782a74c7cf7b8b94ed9e4fcb94e856d1e] dt-bindings: thermal: 
> mediatek: Fix thermal zone definition for MT8186
> git bisect good 4262b8d782a74c7cf7b8b94ed9e4fcb94e856d1e
> # good: [7eeb114a635a04bea2fa7d57cedbf374c714d29e] dt-bindings: thermal: 
> convert hisilicon-thermal.txt to dt-schema
> git bisect good 7eeb114a635a04bea2fa7d57cedbf374c714d29e
> # good: [107ac0d49ae6a86b4986146b9a612294f7e34406] Merge branch 
> 'thermal/linux-next' of 
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into 
> linux-next
> git bisect good 107ac0d49ae6a86b4986146b9a612294f7e34406
> # bad: [5725f40698b9ba7f84fbfee25b9059ba044c4b86] thermal: core: Call 
> monitor_thermal_zone() if zone temperature is invalid
> git bisect bad 5725f40698b9ba7f84fbfee25b9059ba044c4b86
> # first bad commit: [5725f40698b9ba7f84fbfee25b9059ba044c4b86] thermal: 
> core: Call monitor_thermal_zone() if zone temperature is invalid
> 
> #regzbot introduced: 5725f40698b9ba7f84fbfee25b9059ba044c4b86
> 
> Thanks,
> Neil

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


