Return-Path: <linux-kernel+bounces-387322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D049B4F73
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E864284868
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE919CC36;
	Tue, 29 Oct 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lXB5LHzN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nD19+QRi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7C19A298
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219801; cv=none; b=DqG88Yzd078ZMjLd+7bS243t2ihHyvix4YqhdrAcFBUrJDyOpN85SKkojuPzIgK7pXWVAr78RRmTlnsq6s0UMvQk9EbkVss0svQDAymN/Gv5FqNY9YHaQCKWriUM5S3HPoRp1w1zImCjQlyLTYSHpO31sfuCNVudy06T7rPEO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219801; c=relaxed/simple;
	bh=7lTjdAOIunQmKkabZ8nPfizaGGjHuYuzAF8kaIpfnVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzyxYouRXkPQnYK8C/ZJdac/kB4J4XFllyvMgzcgVSxjz7tvtAwgMWmP2oqOP4OsF/JwXk8e2Dx+36PQTX/UUZ/HA+fEUqlqjGVs//KbHGQVKU2Rwx3rbl1nFV062pd8f/LNXc26qhFTVG3IgGZ/Mq2/8x1qWwyL1ny1WKt/Jd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lXB5LHzN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nD19+QRi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730219797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X4XfhczdWLcMAUjO/L4NiYl0aNvFbneCHY0Ej82/4wY=;
	b=lXB5LHzNKzNdEsGZV8uYW5dFxbDHtzyLaxKcFmVGnEKMj/S9juBkgTv6MAHvgNnGP8i8I1
	6CZQrdGhpeG4ChYrLQHI5pzehsxXVWHlvdnKk2mYMmxihn4ntYoa2SI+wHibHichPFqBT2
	505w4/LPBVWTMECryoEPO4wetnbeb+ufS3gamcXrhnBsqhFvNQkxhhnp2WLJVDPt4utoHM
	6PnEuovR33QL8yUo0O/ZVnRRUb5iqJ5brcTNxnqbvFttC2u70nXCobxVDuVz0wOseTq26N
	NvIVyvaqKdXPucoQGHYCiH6k2OTIXqxMiFsHJD6XlHh69LgSZQLLECt5LjHo2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730219797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X4XfhczdWLcMAUjO/L4NiYl0aNvFbneCHY0Ej82/4wY=;
	b=nD19+QRi/hp8urddPfaZq/iuAi9cP8JxWM4FoydxZHxoZQT35JDUGV5m/wXF4i5KW9B/la
	6WLE+SFRaXi/fUCA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 16/26] signal: Replace resched_timer logic
In-Reply-To: <87ttcu281y.ffs@tglx>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.220867629@linutronix.de>
 <ZyEFyV28jcz85V1q@localhost.localdomain> <87ttcu281y.ffs@tglx>
Date: Tue, 29 Oct 2024 17:36:37 +0100
Message-ID: <87o73227e2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 29 2024 at 17:22, Thomas Gleixner wrote:
> On Tue, Oct 29 2024 at 16:56, Frederic Weisbecker wrote:
>>> @@ -568,10 +568,10 @@ static void collect_signal(int sig, stru
>>>  		list_del_init(&first->list);
>>>  		copy_siginfo(info, &first->info);
>>>  
>>> -		*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
>>> -				 (info->si_code == SI_TIMER);
>>> -
>>> -		__sigqueue_free(first);
>>> +		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code == SI_TIMER)))
>>> +			*timer_sigq = first;
>>> +		else
>>> +			__sigqueue_free(first);
>>
>> So this isn't calling __sigqueue_free() unconditionally anymore. What if
>> the timer has been freed already, what is going to free the sigqueue?
>
> __sigqueue_free() does not free timers marked with SIGQUEUE_PREALLOC.
>
> sigqueue_free() takes care of that, which is invoked from
> posixtimer_free_timer(). It clears SIGQUEUE_PREALLOC and if it is queued
> it lets it pending and delivery will free it.
>
> That's not any different from before this change.
>
> Though thinking more about it. As we drop the signal in that case
> anyway, we could remove it from pending in sigqueue_free() directly. Let
> me look into that.

Hrm. That requires to do partially what collect_signal() does to keep
the sigset correct. I'm not sure it's worth the trouble.

With the subsequent changes which embed the sigqueue into the timer
itself, the current flow is simple as it has just one place where it
drops the reference count which was acquired when queueing the timer,
i.e. in the delivery path.

Thanks,

        tglx


