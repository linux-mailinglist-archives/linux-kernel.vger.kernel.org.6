Return-Path: <linux-kernel+bounces-191207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E488D0807
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583081F21A69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DB7155C82;
	Mon, 27 May 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQGeqTFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VgylFGwG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6587C61FC6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826384; cv=none; b=DrMG2uyjN3o/vFBMkfH3ic8g2ELJB6MJs/Xvjs7F3QfwwUIKyG38EY790pKq5Bo3IEq3XZxOH2meSS/6jKU3xgSii0iKWSiF9DpG6uiyCvxA0+YylxQ0drundnOrVmtAF9Ww5qDwr5i/GO81/s1ry0OMnc9/bZ28iXxRKfOMoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826384; c=relaxed/simple;
	bh=a42e2Xf1GNWvhAY2Tj1SM4zxAQkbkwQelk3WLmIr/5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lja99RKKYWTHpK2uMbzbg0xUjg4c0BtMZTT9lYeiakSwazQN7EcAyFsOpFDw77Ga0rKBQJR0MNrZb/bremA74346Vv1oS8NBuhu8FkWpKCogQLYrVYqCWgpAb87aSMZ/ZETKqMzQ0RVxVm8L0rhoz6sPztWUVkRJSzmuxT2wPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQGeqTFF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VgylFGwG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716826381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLmwJM6hz9qUhzixzSAK8wDdiZKr1mPFgk7wH20IjSI=;
	b=sQGeqTFFGqacG2PsRz8fGw0+8mic2QYWoIZ9ucj6an5Xiak8g2kMoMQWCNZpfBpyEYQJJp
	VsVT8pZBpJpFE1IbCMmuheAqm6aP4WKm+G/cMGB2Z6Sj7DVetRvPr1YY5Ap8tqXNFlwwJ/
	JhxMzd5w2hNvk4q7U5XX7qOJptxE63XnKqjp5rugFTHwz7xsPk4/nK7z3owiwb1YxuHNuB
	6gHBs/cWycEmYBjWDIfJUach9z+fTnS7lIN/YdcMBVURMRWPCQqoEmQ67t7c7jJ6bsBMyH
	XzhYs/MOhEWhIb1oW/s805tDRepDQDB7bnJBjueoEURKS5vNbwKMc2NwOoeSJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716826381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLmwJM6hz9qUhzixzSAK8wDdiZKr1mPFgk7wH20IjSI=;
	b=VgylFGwG/P1iLaaGO4rlmPXtyUJL5LUo+ljv1SrAmvbj8PXreAqWAx3l6DV2/ohqrufjJP
	/egz2oBJ0lIWAsCg==
To: Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Phil Auld
 <pauld@redhat.com>, Chris von Recklinghausen <crecklin@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
In-Reply-To: <D1KDJILBPEKS.27MVR6A44NMX8@gmail.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com> <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home> <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx> <20240526192758.GA21193@redhat.com>
 <D1KDJILBPEKS.27MVR6A44NMX8@gmail.com>
Date: Mon, 27 May 2024 18:13:01 +0200
Message-ID: <87plt7b5de.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 27 2024 at 21:01, Nicholas Piggin wrote:
> On Mon May 27, 2024 at 5:27 AM AEST, Oleg Nesterov wrote:
>> The more I grep the more I confused.
>>
>> On 05/25, Thomas Gleixner wrote:
>> >
>> > Right. It does not happen because the kernel starts with jiffies as
>> > clocksource except on S390. The jiffies clocksource is not qualified to
>> > switch over to NOHZ mode for obvious reasons.
>>
>> Not obvious for those who never looked at this code ;)
>>
>> OK, clocksource_jiffies doesn't have CLOCK_SOURCE_VALID_FOR_HRES,
>
> jiffies clocksource requires a timer to run it I suppose.

Yes, but it's all periodic (nohz disabled) mode until
clocksource_done_booting() selects a high resolution clocksource and
kicks the NOHZ stuff alive. That's a fs_initcall() and happens late in
the boot process.

Thanks,

        tglx

