Return-Path: <linux-kernel+bounces-345499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B200998B6FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703FB28195F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65519E7E0;
	Tue,  1 Oct 2024 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3WPaHqYZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kA6oxpAA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57219DFAE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771457; cv=none; b=t/z8vvSiWQq40KHgYQMJQmVDSWB9kngzHV4Gv8G6kD4RzGeM2sTo2sCbU3b2WgTUxlqr0Q+fb6AMtJKAe7jacdHEtkvWmiTq+oal+oEIaxkeR5aYTGBO/vd1AXY4Rx3SBD4xXeubmBjkIGnfys5SBSK3kBBeioqUlx/uVOG9D00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771457; c=relaxed/simple;
	bh=4YFblMg6LqMKXTvZwlZr5iFr1QPj8NLMd2nkQXqJFw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aj1RhprhtCkRchDFK/d6z1y4rdu8+nz7GPMtUP8AUKUnsMVsF3uMpkFcKceeC57WwwfNY4cP9uEGmz4WKaVeaGVvCGoB6YEI9OA658jQ7iaW73GUoFbXOs8Er7rbFgJcsq0gMYfc0UFRNCUmu6sD48sgQF9pRypbjLSlWu+UOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3WPaHqYZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kA6oxpAA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727771453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9SudqWx+ls+uUq6IQ84s4bFGDXFLQMoxxIhqpQ3KNM=;
	b=3WPaHqYZZwGNfdSiRp+0hVLPUz7/y6ogGP2lt+nQBmSXiFewMohvZW5fVEm7QUiZAPHfZ9
	uZtMzAVINq1q9XIOubcq9pZaouHxFFwhlATtlFHg3YHKotNB0aZSDkFHb8VxhNMQpnXf7R
	76p8BmcNpPyTRK0RcXNpZeFIJKz/dyuP0c0aGkvlODYFN2fdXd390M+h6KsPzb9IqKs8FV
	jP0IxLS1FZt1wb3Cf70nV1I1M701+ByjD2PkoS5KYJsmvAgShOqs3NxKl9h54dtHx1slCA
	rrckG3W1ttg8KhlL9wkcSGfTlgVm0BLBgF2L5N9gRdOYjGzLL+XLTtfM7RUesA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727771453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9SudqWx+ls+uUq6IQ84s4bFGDXFLQMoxxIhqpQ3KNM=;
	b=kA6oxpAAnrQ6RCwWzTYY8k6VdWua76rkyw2WC+tDKDIOEoWTAtO1O75wzNcnCCCoUl1mtM
	oOCKPkut5Kva8MAA==
To: Mario Limonciello <superm1@kernel.org>, Mateusz =?utf-8?Q?Jo=C5=84czyk?=
 <mat.jonczyk@o2.pl>, John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, "open list:TIMEKEEPING, CLOCKSOURCE
 CORE, NTP, ALARMTIMER" <linux-kernel@vger.kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH RESEND] alarmtimer: Use aie_timer from RTC device
 instead of own timer
In-Reply-To: <20240930182945.3332896-1-superm1@kernel.org>
References: <20240930182945.3332896-1-superm1@kernel.org>
Date: Tue, 01 Oct 2024 10:30:53 +0200
Message-ID: <87ed50z0le.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 30 2024 at 13:29, Mario Limonciello wrote:
> It was reported that suspend-then-hibernate stopped working with modern
> systemd versions on an AMD Cezanne system. The reason for this breakage
> was because systemd switched to using alarmtimer instead of the wakealarm
> sysfs file.
>
> The wakealarm sysfs file programs the time to the `rtc->aie_timer` member
> of the RTC, whereas the alarmtimer suspend routine programs it to it's
> own device.
>
> On AMD Cezanne systems rtc_read_alarm() is used to program a secondary
> timer with the value of the timer. This behavior was introduced by
> commit 59348401ebed9 ("platform/x86: amd-pmc: Add special handling
> for timer based S0i3 wakeup").
>
> As rtc_read_alarm() uses the `rtc->aie_timer` to report the cached
> timer no alarm is provided as enabled.
>
> To fix this issue, drop the use of a dedicated timer for the alarmtimer
> and instead use `rtc->aie_timer` in the alarmtimer suspend/resume
> routines.

I'm not sure that this is correct. There is a reason why alarmtimer uses
a dedicated timer and this worked correctly so far.

I'd rather look at commit 59348401ebed9, which plays games with the RTC.

Thanks,

        tglx

