Return-Path: <linux-kernel+bounces-287282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1E9525DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33065B2188E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF07E14B06E;
	Wed, 14 Aug 2024 22:37:43 +0000 (UTC)
Received: from sxb1plsmtpa01-03.prod.sxb1.secureserver.net (sxb1plsmtpa01-03.prod.sxb1.secureserver.net [188.121.53.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6368144D1A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675063; cv=none; b=ep1nltjHxYz9H5QZ1JWlv0cASBkpEiKQPlo8njyCSF7EJ5Sq+d1DWoinr198Zks/oPHujNPiC9jTRmtdoE+3R6Vx79Jl5+NLJdcOs0PzTUAZR7XSnbBgTUMayxxbRm8rlA5WW13MM20T7NCdKfQEilIguJpoB2mCiFXyLHDQWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675063; c=relaxed/simple;
	bh=3LXwlSHa9sQcULrGFCR8yyHdBnsZLnr0aNpVHqdosak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svR+uUzWAbbfsuzxHReXXPymr1o0DFujqakHRvbcFccggGVkdKHwubpabaz9INqZM91h+e+C9Fx3UjREmvTToJYvbhXWdds0stIQ5POdUPo0ZrKb8W2QLzBZcPyfN7Ok2GlgS0JEYWX6JTYxkCWJiRTtuT+fhyQZ5zA33G0x0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net; spf=pass smtp.mailfrom=piie.net; arc=none smtp.client-ip=188.121.53.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piie.net
Received: from [192.168.1.27] ([109.90.180.58])
	by :SMTPAUTH: with ESMTPSA
	id eL1ZsURBGQGq8eL1bs0nzo; Wed, 14 Aug 2024 13:55:20 -0700
X-CMAE-Analysis: v=2.4 cv=Sp9b6+O0 c=1 sm=1 tr=0 ts=66bd19b9
 a=ujCVow8R4Y5jPCx6COW8WA==:117 a=ujCVow8R4Y5jPCx6COW8WA==:17
 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=t3YNmgBSAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=nmDrXcoKSNg3NTg_32oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ctH_qozkpUrkr3SVbfwb:22 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: peter@piie.net
Message-ID: <f226b45b-b7b7-4004-9d2b-740a52c658d3@piie.net>
Date: Wed, 14 Aug 2024 22:55:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] thermal: gov_bang_bang: Add .manage() callback
To: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Peter_K=C3=A4stle?=
 <peter@piie.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
 <8419356.T7Z3S40VBb@rjwysocki.net>
 <291044b7-7300-42c2-91e6-fef164482cf3@piie.net>
 <CAJZ5v0h9b2E0meeHGRtRv+=GbsABUs=L4RqAvAZuCksU+uN0cQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
In-Reply-To: <CAJZ5v0h9b2E0meeHGRtRv+=GbsABUs=L4RqAvAZuCksU+uN0cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCcAgy2oqo4m+XYoMedubk2Bc9tI4XHeVtmjtRb9yu723Ck4yKRpDw/9UEqYR32Vzm4hx28jyjTRnE5xfHbnyWLHDc79CBZ2CtXGpPoJAguFo5msTVnZ
 MYvpyF15b3Au8X5+wChI9yaeqlN4bIjq9PG2C1NzSkINOxnVJZ9IanSREcSoIv+uvQqvrsjFKQdWs9KzXAU4AJIwIAwDnjZSGc5B5xwotcUULkK4o/B/n4qx
 oS1+kocMXCLxGbPNT8IcxU2lM7bNk/y9CTLkqzB9Wu0pjy1x5C0wVmZyPu2pUdP1czmzzkNEFezMCRoAltUvPgPWlFZyL9ZfnxlYebPdI/2wX2b53q3O8idD
 JSQ3QjTGT4d0dnJpuwV7/bUYFgX7OWF83vFml0rP/C99oJBTx4eafhUNBRvdHs/QViNIAjxN

Hi Rafael,

On 14.08.24 19:18, Rafael J. Wysocki wrote:
> On Wed, Aug 14, 2024 at 12:50 AM Peter Kästle <peter@piie.net> wrote:
>>
>> On 13.08.24 16:27, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> After recent changes, the Bang-bang governor may not adjust the
>>> initial configuration of cooling devices to the actual situation.
>>>
>>> Namely, if a cooling device bound to a certain trip point starts in
>>> the "on" state and the thermal zone temperature is below the threshold
>>> of that trip point, the trip point may never be crossed on the way up
>>> in which case the state of the cooling device will never be adjusted
>>> because the thermal core will never invoke the governor's
>>> .trip_crossed() callback.  [Note that there is no issue if the zone
>>> temperature is at the trip threshold or above it to start with because
>>> .trip_crossed() will be invoked then to indicate the start of thermal
>>> mitigation for the given trip.]
>>>
>>> To address this, add a .manage() callback to the Bang-bang governor
>>> and use it to ensure that all of the thermal instances managed by the
>>> governor have been initialized properly and the states of all of the
>>> cooling devices involved have been adjusted to the current zone
>>> temperature as appropriate.
>>>
>>> Fixes: 530c932bdf75 ("thermal: gov_bang_bang: Use .trip_crossed() instead of .throttle()")
>>> Link: https://lore.kernel.org/linux-pm/1bfbbae5-42b0-4c7d-9544-e98855715294@piie.net/
>>> Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> oops, previously sent from wrong email address, here again from correct one...
>> Acked-by: Peter Kästle <peter@piie.net>
> 
> No worries and thanks for the ACKs!
> 
> I gather that they mean that the changes work for you.

Yes, successfully tested all my use cases and reviewed the code.  Thanks.
Still working on the acerhdf cleanup, but this will be another patch series.

> 
>>> ---
>>>    drivers/thermal/gov_bang_bang.c |   30 ++++++++++++++++++++++++++++++
>>>    1 file changed, 30 insertions(+)
>>>
>>> Index: linux-pm/drivers/thermal/gov_bang_bang.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
>>> +++ linux-pm/drivers/thermal/gov_bang_bang.c
>>> @@ -26,6 +26,7 @@ static void bang_bang_set_instance_targe
>>>         * when the trip is crossed on the way down.
>>>         */
>>>        instance->target = target;
>>> +     instance->initialized = true;
>>>
>>>        dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
>>>
>>> @@ -80,8 +81,37 @@ static void bang_bang_control(struct the
>>>        }
>>>    }
>>>
>>> +static void bang_bang_manage(struct thermal_zone_device *tz)
>>> +{
>>> +     const struct thermal_trip_desc *td;
>>> +     struct thermal_instance *instance;
>>> +
>>> +     for_each_trip_desc(tz, td) {
>>> +             const struct thermal_trip *trip = &td->trip;
>>> +
>>> +             if (tz->temperature >= td->threshold ||
>>> +                 trip->temperature == THERMAL_TEMP_INVALID ||
>>> +                 trip->type == THERMAL_TRIP_CRITICAL ||
>>> +                 trip->type == THERMAL_TRIP_HOT)
>>> +                     continue;
>>> +
>>> +             /*
>>> +              * If the initial cooling device state is "on", but the zone
>>> +              * temperature is not above the trip point, the core will not
>>> +              * call bang_bang_control() until the zone temperature reaches
>>> +              * the trip point temperature which may be never.  In those
>>> +              * cases, set the initial state of the cooling device to 0.
>>> +              */
>>> +             list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>>> +                     if (!instance->initialized && instance->trip == trip)
>>> +                             bang_bang_set_instance_target(instance, 0);
>>> +             }
>>> +     }
>>> +}
>>> +
>>>    static struct thermal_governor thermal_gov_bang_bang = {
>>>        .name           = "bang_bang",
>>>        .trip_crossed   = bang_bang_control,
>>> +     .manage         = bang_bang_manage,
>>>    };
>>>    THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
>>>
>>>
>>>
>>

