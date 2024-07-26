Return-Path: <linux-kernel+bounces-263549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68493D791
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC6AB2157A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6650017C7DE;
	Fri, 26 Jul 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="StZ9xlzD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJDA2CTK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28628101F7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014831; cv=none; b=Q/l9GlE7GsetvfSujbF99ZjiVFZg1ejj8/MYXmKELQJuB0ZYJRH7SAuVOnJMZ0gL1a0hoZ0EPWD4iB27eVJAf5klzDJ3HNLpR9qfEApap8W5piWSW/1/mV9hiX2jLLc4HAZ/zdBj+HUiF7rlcwu9LQOLQ9EAb+Jw+fhko4bB+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014831; c=relaxed/simple;
	bh=FI+LnyAiyIHoblLH8gWwLVdWKrKuCN/cAEzg+klPyL4=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Bk6xN1WSK4F4b+yw0zr+eqovHE25k+ble7TgxwQZowKT5BhZV3xYAoD39kOlId59cAe0hXK7gFoo4O8139Y23UZ5xvca9BhvKGdTJem9Lus6cgvsFbx8AysGRj+yfDL1BA/gRl+pJzS139HCr4SsYl2k7TX8YVbIYuhKlNoBNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=StZ9xlzD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJDA2CTK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722014827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Rz5NWKXgvOfmx9WgfuBLP0CmPfH1kfe4PExx5Va8Yjc=;
	b=StZ9xlzDzhgkymU2a2BKeTSjIMOsQcg0EyNwh9T2hUkrHNz2cHaCFoT9xwkDNksAmqzb+V
	DLLd+bY8R8XiKHIiAYQ8Q6wJqRPG21+PHGFoeY+P7v7GsdpW75Vdzg5K8hAtp5v9/w+ih7
	RxEAz5ZPHN25gPUgGiZosz2WTu08Pe3WjpT8cWDotTm4L9GQ3cw3bO5uYbHtM0ME5RPWSc
	6SthtdhXBE2ZbrfYtkcC5QRuDAm3ZWCzhRqZzOQpwoGLfJg2VpkBxAHLQs3YKXf3vZj8zD
	68/fDEFLARyiThDQ6k6PgoTYxGs2NqrVWvB9XPsuCNbjjXcXWLgg6qS7MDJo4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722014827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Rz5NWKXgvOfmx9WgfuBLP0CmPfH1kfe4PExx5Va8Yjc=;
	b=WJDA2CTKz1153tslQi/EEb6KpBKYlVT4TwI0q0V7/Jge2OKX1duDbj/QvbQEcEpT7if/bu
	sFfZU6gJY8QwIWAQ==
To: Pete Swain <swine@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FIXUP: genirq: defuse spurious-irq timebomb
In-Reply-To: <87jzhxvyfw.ffs@tglx>
Date: Fri, 26 Jul 2024 19:27:06 +0200
Message-ID: <87h6ccukr9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pete!

Sorry for the delay.

On Sun, Jul 07 2024 at 20:39, Thomas Gleixner wrote:
> On Fri, Jun 14 2024 at 21:42, Pete Swain wrote:
>> The flapping-irq detector still has a timebomb.
>>
>> A pathological workload, or test script,
>> can arm the spurious-irq timebomb described in
>>   4f27c00bf80f ("Improve behaviour of spurious IRQ detect")
>>
>> This leads to irqs being moved the much slower polled mode,
>> despite the actual unhandled-irq rate being well under the
>> 99.9k/100k threshold that the code appears to check.
>>
>> How?
>>   - Queued completion handler, like nvme, servicing events
>>     as they appear in the queue, even if the irq corresponding
>>     to the event has not yet been seen.
>>
>>   - queues frequently empty, so seeing "spurious" irqs
>>     whenever the last events of a threaded handler's
>>       while (events_queued()) process_them();
>>     ends with those events' irqs posted while thread was scanning.
>>     In this case the while() has consumed last event(s),
>>     so next handler says IRQ_NONE.

I'm still trying to understand the larger picture here. So what I decode
from your changelog is:

The threaded handler can drain the events. While doing so the
non-threaded handler returns WAKE_THREAD and because the threaded
handler does not return these hard interrupts are accounted as spurious.

>>   - In each run of "unhandled" irqs, exactly one IRQ_NONE response
>>     is promoted from IRQ_NONE to IRQ_HANDLED, by note_interrupt()'s
>>     SPURIOUS_DEFERRED logic.
>>
>>   - Any 2+ unhandled-irq runs will increment irqs_unhandled.
>>     The time_after() check in note_interrupt() resets irqs_unhandled
>>     to 1 after an idle period, but if irqs are never spaced more
>>     than HZ/10 apart, irqs_unhandled keeps growing.
>>
>>   - During processing of long completion queues, the non-threaded
>>     handlers will return IRQ_WAKE_THREAD, for potentially thousands
>>     of per-event irqs. These bypass note_interrupt()'s irq_count++ logic,
>>     so do not count as handled, and do not invoke the flapping-irq
>>     logic.

They cannot count as handled because they are not handling
anything. They only wake the thread and the thread handler is the one
which needs to decide whether it had something to handle or not.

>>   - When the _counted_ irq_count reaches the 100k threshold,
>>     it's possible for irqs_unhandled > 99.9k to force a move
>>     to polling mode, even though many millions of _WAKE_THREAD
>>     irqs have been handled without being counted.
>>
>> Solution: include IRQ_WAKE_THREAD events in irq_count.
>> Only when IRQ_NONE responses outweigh (IRQ_HANDLED + IRQ_WAKE_THREAD)
>> by the old 99:1 ratio will an irq be moved to polling mode.
>
> Nice detective work. Though I'm not entirely sure whether that's the
> correct approach as it might misjudge the situation where
> IRQ_WAKE_THREAD is issued but the thread does not make progress at all.

Ok. That won't happen because the SPURIOUS_DEFERRED bit stays set as
before.

Now looking deeper what your patch does. Contrary to the current code
the very first hard interrupt of a particular queue is accounted in
desc->irq_count.

Everything else stays the same:

  - SPURIOUS_DEFERRED is sticky unless the hard interrupt handler returns
    IRQ_HANDLED, which is not the case in the NVME scenario. So the
    !SPURIOUS_DEFERRED code path is only taken once.

  - Any consecutive hard interrupt which returns IRQ_WAKE_THREAD where
    threads_handled == threads_handled_last is accounted as IRQ_NONE as
    before.

  - Any consecutive hard interrupt which returns IRQ_NONE is accounted
    as IRQ_NONE as before.

I might be missing something of course, but I don't see what this change
fixes at all.

Thanks,

        tglx

