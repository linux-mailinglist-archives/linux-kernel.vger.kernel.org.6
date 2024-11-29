Return-Path: <linux-kernel+bounces-425533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4D9DC354
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18F21614F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3419C56D;
	Fri, 29 Nov 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a4y5LG4y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PT1lxdp8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FFB170A1A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882573; cv=none; b=UXc8rrMr3429M2hY6bXxL5erKSi7yb+5VuDfyeeJET8PQbscL1i/bMeg1qSF/5/VZrEEqokW3tpN7ysq7B4pQOQBGueSHKapKgZ+XWtkY+TMzsuPyi/MFmmc5LOd+aFNm4OWDM1lNEcfawnke7TNFS/oPCmJ06J737QLvZtqj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882573; c=relaxed/simple;
	bh=O3tqu7rPiQfKWhJaRD6waOGq54rlRMkdSc6yYt30dmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NPTIjq5Uk9/A2Bj0vUX09lKnhhdD/1/YoOsJvUJlFs4q+NKjl+/5mxsrLhp0pNfnIeae6KJO0omtOfKVOP//1DaMqDyjmbVa3C3+FCn4zVJGBRlFoxCSQTc6cEZz7WQWERvVEasPpTLFlBxzhtRSEkiR/3n+D/edelxw2cGgm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a4y5LG4y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PT1lxdp8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732882568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1keM/yjfeej7eAiI5QOW6J4N1QYsbkxaSQ6fo3TBGrk=;
	b=a4y5LG4yuZSIUVjXdiO4ePi7hEoxO7R9beEhWvuogesBlYLxeI1KbRTHfhv7L+S2UjkbnZ
	WTSKnemTQNKzBpCcZ5CWVZFKVr0OkcCbOfodG+aT+v6BMquo/i7ulF5fckVGCm8t/2KI5X
	zjRpcM6xWhZlul/GVOkvBl1c09mGWK/woL12OFyFIygtRmXigYJGkLhvfOPaRZtIbqqvpk
	g/nTKUNUAohU8QOupiO5CeBySh3kHSZWHycwgTe59Ggbz4yIFxKHuFgCKbaJxmTVcU1dak
	sfzioCT9dw+ZZbEMXFjqeuEFtXqiI9pWnNdH19FyjfP47ZOBpCBgDR6LnichvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732882568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1keM/yjfeej7eAiI5QOW6J4N1QYsbkxaSQ6fo3TBGrk=;
	b=PT1lxdp8ziGgDjdwHu0ZcQlJJNtKQ+wvxmmBYE++69YqTSu7ACDfY0w9v8jwCxgILSFL4J
	DcU4JdSMtIdkz4CA==
To: Guenter Roeck <linux@roeck-us.net>, John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 2/2] timekeeping: Always check for negative motion
In-Reply-To: <2cb25f89-50b9-4e72-9b18-bee78e09c57c@roeck-us.net>
References: <20241031115448.978498636@linutronix.de>
 <20241031120328.599430157@linutronix.de>
 <387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net>
 <CANDhNCo1RtcfqUJsuAQ+HdS7E29+gByfek5-4KYiAk3Njk4M3Q@mail.gmail.com>
 <65b412ef-fc57-4988-bf92-3c924a1c74a5@roeck-us.net> <87cyifxvgj.ffs@tglx>
 <2cb25f89-50b9-4e72-9b18-bee78e09c57c@roeck-us.net>
Date: Fri, 29 Nov 2024 13:16:08 +0100
Message-ID: <874j3qxmk7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 28 2024 at 07:30, Guenter Roeck wrote:
> On 11/28/24 06:51, Thomas Gleixner wrote:
> [   19.090000] ###### now: b5ac62 last: d447e38 mask: ffffff return: 712e2a
> [   19.110000] ###### now: b9ebc3 last: db506d0 mask: ffffff return: 4e4f3
> [   19.120000] ###### now: bb842f last: db8d760 mask: ffffff return: 2accf
> [   19.160000] ###### now: c43f2e last: dbabfa8 mask: ffffff return: 97f86
>
> 'last' advances beyond 'mask', and after that the result is always bad. The call to
> clocksource_delta() is from timekeeping_advance().

This does not make any sense. The bits above the mask in cycle_last are
irrelevant:

        delta = (now - last) & mask;

> [    3.350000] ###### now:  6c4f last:  fe6a84 mask: ffffff return: 201cb    <---
> [    3.360000] ###### now: 40427 last: 10052cc mask: ffffff return: 3b15b    <---

       0x40427 - 0x10052cc = 0xffffffffff03b15b
       0xffffffffff03b15b & 0xffffff = 0x3b15b

That's not any different than before. The only difference is that the
return value is checked:

       return delta & ~(mask >> 1) ? 0 : delta;

But clearly none of the resulting deltas (after masking) has bit 23
set. So the function can't return 0, right?

Coming back to my earlier assumption vs. the max idle time. Here is a
long idle sleep:

> [   18.500000] ###### now: 45b0a2 last: d1c7050 mask: ffffff return: 294052
> [   19.090000] ###### now: b5ac62 last: d447e38 mask: ffffff return: 712e2a

The cycle interval is 125000 clock cycles per tick. That's a HZ=100
kernel, so the nominal clock frequency is 12.5 MHz.

  0x712e2a/12.5e6 = 0.593391s

which is close to the 597268854ns max_idle_ns value.

That's about 0.0776978s away from the point where the delta becomes >
mask/2. So there is a valid concern vs. these long idle sleeps on
machines with a small counter width.

But none of this explains the problems you are observing.

Can you instrument clocksource_delta() to print the values only when the
negative motion detection triggers?

         if (delta & ~(mask >> 1))
         	pr_info(....);

Thanks,

        tglx

