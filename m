Return-Path: <linux-kernel+bounces-530112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C69A42F36
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE201892E53
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DBE1DD0F6;
	Mon, 24 Feb 2025 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wTiQ0h/K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fH3pVqn1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A4487BF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432787; cv=none; b=gasWQWK+5o2N3otRQnimcBeLrN8DyckyxMzmTzdqFpn+O5VlJRW8GWxpeWnH8/opyWHyXz95DENn2zfJKzG80Fw66u0f7eB1/hPFDH/j5W0IYQshmZ4UBXFE144VPLLfF29tMsP6GhBB/mZcJJlLklYFxApYluC6X+fMaRec/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432787; c=relaxed/simple;
	bh=7j1F3muHSUrWVZJJa38ApN+toUwQgOmPJryKHmXJWtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ah+tUm5VwiJm3OfvvO7u7F01If9INXECygjD7Ks+I4V+2lpibRqfTjZj0ImxAHGf78pmNDjgamD8aCiausIWHgwBwo1o9Jzz9JrNoe+xv/+Dh08v8F8Vfn0PlIl/srHU3WyzmjT4Y2kM2NxHx6wXPx4a57+imbr4LvnTBmBjUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wTiQ0h/K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fH3pVqn1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740432784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWDoE5CbBA5B9bltSD4gKawYB98PjhAjPtq+O+D3AF4=;
	b=wTiQ0h/KLAHCKY3bebjJklkwG2TC13sofiuEsZO2I9s3ljFEoQ33aVEI0rbINt1qycJU+n
	WS/zxTfh1/qpuyaRDOve3AemkToo2NE+2eEQdA6zfEmI72HloWUCRUIiW7pDlkH7lmNXvE
	AoLIqZuslrsuIhoAEIxFPr4pfQ+UJXJyu89THUSjWaWRnbvF0UnwFSqkyXy57ZpCwJH7ap
	fT+7r9MWjbntMsiDL1yJElEu6DeACa4e5bzq4mrw59WEWHvyXYKYm7avdERqOiehJ/X5XD
	q2RVhgw7z11LKvyzrYNoRJLFiKzG+v7D3X7R6kQh1aqNOhM76mRlRZ8N0vY2uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740432784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWDoE5CbBA5B9bltSD4gKawYB98PjhAjPtq+O+D3AF4=;
	b=fH3pVqn1HLyl/y/xA8FI7olvMyBzVmvVQv41B59lqgY9Zve4AkdIJI/mEXBgGPbv3kt4ES
	JlrdCsabTLGH57BQ==
To: paulmck@kernel.org, Christian Heusel <christian@heusel.eu>
Cc: Rik van Riel <riel@surriel.com>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Ingo Molnar <mingo@kernel.org>, Zqiang
 <qiang.zhang1211@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Warning/trace in kernel/smp.c:815 smp_call_function_many_cond
In-Reply-To: <99c7bdb6-76e3-42ce-9a0d-c5b72a2c132a@paulmck-laptop>
References: <46a200b4-1293-413c-8b73-37f7b50abd1a@heusel.eu>
 <99c7bdb6-76e3-42ce-9a0d-c5b72a2c132a@paulmck-laptop>
Date: Mon, 24 Feb 2025 22:33:03 +0100
Message-ID: <87jz9ff2pc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 24 2025 at 06:57, Paul E. McKenney wrote:

> On Mon, Feb 24, 2025 at 02:57:40PM +0100, Christian Heusel wrote:
>> Hello everyone,
>> 
>> I have noticed the following new warning in my dmesg output, I think I
>> have first seen this when upgrading to v6.14-rc1.
>> 
>> So far I have been unsuccessfull in bisecting it, therefore it would be
>> nice to get some input whether this is something serious or how I could
>> debug it further. I have also attached a full dmesg for more context.
>> 
>>     ------------[ cut here ]------------
>>     WARNING: CPU: 3 PID: 0 at kernel/smp.c:815 smp_call_function_many_cond+0x46b/0x4c0
>
> This happens when something invokes one of the smp_call_function()
> APIs not in task context, that is, if it is called from NMI, hard IRQ,
> or soft IRQ contexts.
>
> Which it is in this case, due to clocksource_watchdog() being invoked
> from a timer handler.  This only matters if the clocksource is being
> marked unstable, which is what you are seeing.
>
> One possible fix is to move the call to cs->mark_unstable(cs) from
> __clocksource_unstable() to clocksource_watchdog_work().  This would
> require marking the clocksource so that clocksource_watchdog_work()
> could find it.
>
> But is there a better way?

That's fine and should be trivial to do. This business is asynchronous
anyway, so it does not matter much when the unstable call is a bit
delayed.

Thanks,

        tglx


