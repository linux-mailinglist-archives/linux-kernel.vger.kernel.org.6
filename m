Return-Path: <linux-kernel+bounces-347726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2A98DD6B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40EEB255F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFC1D095C;
	Wed,  2 Oct 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CZ4lWd3A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="akGB3XGx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB801D078B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880322; cv=none; b=rVAm1MEJYK7SEIu5mrAMTMG1zcHJFa01psZyhmdaTvkeGT0ms7yj1q53E1m/uQUFphU8DfNoFj4+X4dutghaRHOaGVHjk6OlDVAVzFvKXFeGJ9DNHeOg4aCPWp0hkntCewr2mEhzk9jW22zk/3t5f7XodMBGgKh5XzfJwLQfEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880322; c=relaxed/simple;
	bh=Du5wv0ljE1PI8km3B36ID0l2DYQDa9fjrXAKNK8YTFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qyRh4SLWWdqtwj7zGHmwiH8sjX/qWJZlOptZZZ/Z6xmI4GBfhSdCEK72aE9vlWqJFWVt3WSnHy9e2EibrQI2fU0s7HZyDVbRy/FzsoHSCWLEmvyLTLb1GiJFa9OhxmkBaECHQTG1ZqWSMxjCOqK/Ntrm0hrhQ5PlP2z41Uryopk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CZ4lWd3A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=akGB3XGx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727880319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpTJTBkdmhdXVNaxYeJphWMyoIytDRhKrl9PT+v1puo=;
	b=CZ4lWd3AlEmOMnStWQ8WuIXFZ62m+LRJYwtcaHmZLV8MNJsxICMK11iN3iQIWRLq76nTPc
	TbolXaRTgOkdC5LiSSIPhSgNs09n39aZCZaVHFDa6TlQmXRBheD6NJ8edi7O7D3c0/WEAa
	InWuR+TpGTWpwn+SgCpQhX3NNIwzd5lmWxjJebax9y6EYUPaZJSwsDwG5CIuR+KphS9tc0
	Zk7d9vaLjYq2zsFYjP1cLnXIUW/jM+BZAsICxRUnworFlb3yFGZSAyXjTp8XOTftOt/OQw
	+kUcttj4hEQv9RdRXE+293RZaGhYV2thFsNda6H170E6AbSf7nIuRGglTj5pRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727880319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpTJTBkdmhdXVNaxYeJphWMyoIytDRhKrl9PT+v1puo=;
	b=akGB3XGxnivOezROYsqlvKSrOcwIzP64m3UnVjUbFleFUc9Ft5zP/VFDJFE68WM9Mi9gNm
	nG8jGqv3N7hcpUBQ==
To: Mario Limonciello <superm1@kernel.org>, Mateusz =?utf-8?Q?Jo=C5=84czyk?=
 <mat.jonczyk@o2.pl>, John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, "open list:TIMEKEEPING, CLOCKSOURCE
 CORE, NTP, ALARMTIMER" <linux-kernel@vger.kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH RESEND] alarmtimer: Use aie_timer from RTC device
 instead of own timer
In-Reply-To: <e35d22f7-4796-43ae-bc73-7e41497094d6@kernel.org>
References: <20240930182945.3332896-1-superm1@kernel.org>
 <87ed50z0le.ffs@tglx> <e35d22f7-4796-43ae-bc73-7e41497094d6@kernel.org>
Date: Wed, 02 Oct 2024 16:45:18 +0200
Message-ID: <87wmiqwold.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 01 2024 at 08:41, Mario Limonciello wrote:
> On 10/1/2024 03:30, Thomas Gleixner wrote:
>> On Mon, Sep 30 2024 at 13:29, Mario Limonciello wrote:
>>> It was reported that suspend-then-hibernate stopped working with modern
>>> systemd versions on an AMD Cezanne system. The reason for this breakage
>>> was because systemd switched to using alarmtimer instead of the wakealarm
>>> sysfs file.
>>>
>>> The wakealarm sysfs file programs the time to the `rtc->aie_timer` member
>>> of the RTC, whereas the alarmtimer suspend routine programs it to it's
>>> own device.
>>>
>>> On AMD Cezanne systems rtc_read_alarm() is used to program a secondary
>>> timer with the value of the timer. This behavior was introduced by
>>> commit 59348401ebed9 ("platform/x86: amd-pmc: Add special handling
>>> for timer based S0i3 wakeup").
>>>
>>> As rtc_read_alarm() uses the `rtc->aie_timer` to report the cached
>>> timer no alarm is provided as enabled.
>>>
>>> To fix this issue, drop the use of a dedicated timer for the alarmtimer
>>> and instead use `rtc->aie_timer` in the alarmtimer suspend/resume
>>> routines.
>> 
>> I'm not sure that this is correct. There is a reason why alarmtimer uses
>> a dedicated timer 
>
> Do you know what it is?  When I was looking at this problem I wasn't sure.

Because you cannot just blindly overwrite the aie_timer. It might have
been set by something else. Both end up in the timerqueue and the first
expiring timer is armed first.

>> and this worked correctly so far.
>> 
>> I'd rather look at commit 59348401ebed9, which plays games with the RTC.
>
> The workaround in commit 59348401ebed9 exists because of what appears to 
> be a platform bug that is unique to Cezanne systems.  Newer stuff 
> (Mendocino, Rembrandt, Phoenix, Strix etc) doesn't need or use it.

The problem is that this hack looks at the aie_timer and not at the
first expiring timer in the timerqueue which arms the RTC. That's
obviously wrong. There is no interface to get that information, but
that's a solvable problem.

Thanks,

        tglx





