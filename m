Return-Path: <linux-kernel+bounces-345999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DBC98BE2B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D71C22082
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001A61BF810;
	Tue,  1 Oct 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTHjdwwh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639B02BD0E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790118; cv=none; b=DVrmR2baqYrIvnRHdF/CxPByIa054nwIK3h3xbmJqmjaxEh0hUnnn5sOC4uQdhZRR8VUIh3ej3Y+vdxTB4skOmcniEj80L4Jn+anK0gl/NoImBGJ9XB5qqHL9BOdKWp8vu24eYVfhK+7FCaOdnLIh8GAA+38rlYF5/drFo3P3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790118; c=relaxed/simple;
	bh=FoCtyaP1NDDuoN2ilMTweegipS7ukAX5OISuEsZIb9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCZ20sAF5HV98WFRYuavevMD6V+/h50ltGLJEDS6a1IzJGV8/5XkIzr2xhZJLhcR5L01FKDvrF1EmRWLQvfKZjaL7vX0wV5sYLjolPNKvl2pDH3NBcpo67t5lt9t5dQnFdWG3YkrcJGXHKaA4pL8QNR1NjSY03KjMDXws5aBIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTHjdwwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F529C4CEC6;
	Tue,  1 Oct 2024 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727790118;
	bh=FoCtyaP1NDDuoN2ilMTweegipS7ukAX5OISuEsZIb9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rTHjdwwhFWy1TLGZcp7h8nDdsk08Mru+vfwgs4ni+VZx9U92jk9AdAWlCR0md7MVU
	 +cw9L2JEc4Yb8skCV06TkGP5t+qkqt8S4nb7e/ajH4p1wbAwUh4SkoaX5g6Fnk8zdy
	 0OYZvFFhlK6tJAWrywgB2g9pxTVHeeUHEBY/rRzkfXOcDfVcgGmPym5RIhCWoHVxXd
	 e1ap/l/2h5v6rIAY8oZeuM5QrrwjbPSUACGZkbZr6ud31nRMamEF1/ozXhSD7vWxZL
	 QQ39T/9JBCbqYkEsMCrZa3Ul9B8QyWp4Yl2KsJmq5YNFNkeJsxiDKxGkHmwVMgFVIn
	 xqiyCmPlIGQQg==
Message-ID: <e35d22f7-4796-43ae-bc73-7e41497094d6@kernel.org>
Date: Tue, 1 Oct 2024 08:41:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] alarmtimer: Use aie_timer from RTC device instead
 of own timer
To: Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Mateusz_Jo=C5=84czyk?=
 <mat.jonczyk@o2.pl>, John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
 "open list:TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER"
 <linux-kernel@vger.kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20240930182945.3332896-1-superm1@kernel.org>
 <87ed50z0le.ffs@tglx>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <87ed50z0le.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/2024 03:30, Thomas Gleixner wrote:
> On Mon, Sep 30 2024 at 13:29, Mario Limonciello wrote:
>> It was reported that suspend-then-hibernate stopped working with modern
>> systemd versions on an AMD Cezanne system. The reason for this breakage
>> was because systemd switched to using alarmtimer instead of the wakealarm
>> sysfs file.
>>
>> The wakealarm sysfs file programs the time to the `rtc->aie_timer` member
>> of the RTC, whereas the alarmtimer suspend routine programs it to it's
>> own device.
>>
>> On AMD Cezanne systems rtc_read_alarm() is used to program a secondary
>> timer with the value of the timer. This behavior was introduced by
>> commit 59348401ebed9 ("platform/x86: amd-pmc: Add special handling
>> for timer based S0i3 wakeup").
>>
>> As rtc_read_alarm() uses the `rtc->aie_timer` to report the cached
>> timer no alarm is provided as enabled.
>>
>> To fix this issue, drop the use of a dedicated timer for the alarmtimer
>> and instead use `rtc->aie_timer` in the alarmtimer suspend/resume
>> routines.
> 
> I'm not sure that this is correct. There is a reason why alarmtimer uses
> a dedicated timer 

Do you know what it is?  When I was looking at this problem I wasn't sure.

> and this worked correctly so far.
> 
> I'd rather look at commit 59348401ebed9, which plays games with the RTC.
> 
> Thanks,
> 
>          tglx

The workaround in commit 59348401ebed9 exists because of what appears to 
be a platform bug that is unique to Cezanne systems.  Newer stuff 
(Mendocino, Rembrandt, Phoenix, Strix etc) doesn't need or use it.

I'd love if we could tear it out; but I'm at a loss what else we can do 
from the Linux kernel side.

