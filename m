Return-Path: <linux-kernel+bounces-571982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E7EA6C501
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AD2189F6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2D233126;
	Fri, 21 Mar 2025 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2bf4F7B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="coug5XEB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23A1E9B34
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591955; cv=none; b=GQu23A1Mt9ECLywwjJhbMjsDHH0Talx6LpgtkbyPDL0n2MRlK0Njf+TCBqTpz4qfLJTtRFnkAEn/cybmXIe+HauzcWY9SAO9+GrSgnKsMVTRpD16gIkIr8ykRortM8L5NmRxvFCJ9hbP6RDs0aFytFG4lYZoeG6PMBeYiL1Wdjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591955; c=relaxed/simple;
	bh=m99YHWB3W0eD8rLueYoxC2qfy0MyM7Bx0lb3jwxSVIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4WmLzTyXqFbJTUm2m5QEFZrDY2dPC5igR0tbF0uI/ufypUIydOfE94rLhlGKXPzDenJxiq7yUIqq/QzEepnAynJQoClNnIU8ifNvJImlx2MwrFysOT+KSqCzCGkmJsuN+BlpQaWz8arhsq6NTmj7acoOrdsCD2SSevhNk6jxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2bf4F7B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=coug5XEB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742591952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxNukZnvbEexk1o9TXm3QgKVkO67GfcWUgzxQMHhUIk=;
	b=L2bf4F7BXgd0sgGXI0BkvWz8MjLZhrwuW0AD3sngNfHJVh7+YFzEtpuyxfCV7t44RGL/fC
	zq72+6+IQfaIIeHt9PRJcpcUWyE/JSOKMIk9Q+684WaupVonnFuLi015wyWHi4nw+TCklJ
	qIbS09R/CQ3VL48bkOmNJK0NuCIlOZVYUOWofH6Od5/fITj/4K5n5hbn3L6f5/BxSSq9C6
	kg9yJIAsR1r20PCOAP/nnMIJKoShgpSD4W23Fwd/X4HFXDdRFDGeRHb2WdE+6RHVLc6qal
	rGoTz9h6LLK3H1+tf9mIeVHxau33P6biuSmwmJc52uVmR0B5gjXUXGjlUxgImQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742591952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxNukZnvbEexk1o9TXm3QgKVkO67GfcWUgzxQMHhUIk=;
	b=coug5XEB7XG7BCA5wK0zbA6sSWaA70HGlLT4r5AbrkkpZaLXLKjkvEkU7hXG9l4KW8S7xL
	Fm69DUz3pDvqtRDA==
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "H. Peter Anvin"
 <hpa@zytor.com>, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com, kernel@gpiccoli.net, kernel-dev@igalia.com
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable
 after boot
In-Reply-To: <b43e2353-41ff-f2de-881c-c9a3348552b7@igalia.com>
References: <20250226132733.58327-1-gpiccoli@igalia.com>
 <1238b1d0-275c-9117-a2e3-5e7684404980@igalia.com>
 <EA2BAF2F-3F8E-4F81-B71C-7B97677216C9@zytor.com>
 <b43e2353-41ff-f2de-881c-c9a3348552b7@igalia.com>
Date: Fri, 21 Mar 2025 22:19:11 +0100
Message-ID: <87iko213qo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21 2025 at 16:26, Guilherme G. Piccoli wrote:
> On 17/03/2025 15:42, H. Peter Anvin wrote:
>> To be honest I don't think this belongs in debugfs; rather it belongs in=
 sysfs.

No.

>> Debugfs should not be necessarily in serious production systems =E2=80=
=93 it
>> is way too large of an attack surface, which is a very good reason
>> why it is its own filesystem =E2=80=93 but if this is a real issue on
>> hardware then it may be needed.

There is ZERO reason to do that on a production system.

If the in kernel detection does not work, then switching it over after
someone detected the problem five hours after the fact does not help at
all.

The admin can force the TSC to be removed from timekeeping, which is the
really crucial part, already today by changing the clocksource via sysfs.

> In other words, we have 2 options in my understanding:
>
> (a) Drop it;
>
> (b) Re-implement using sysfs entry instead of debugfs;

Neither (a) nor (b) nor the proposed implementation.

There is actually a good reason why a debug/validation mechanism of some
sort makes sense, i.e. testing:

  1) The hardware, which exposed these issues frequently is starting to
     get into museum or junkyard state, which reduces the test base
     significantly.

  2) Modern hardware, which exposes this issue in large fleets
     occasionally due to aging and misdirected neutrons, is not really a
     good testbed either.

So we have no real test coverage for something, which can be crucial in
the actual failure case.

Sure, it could be argued that this can be implemented in qemu, but that's
fundamentally the wrong approach.

This is something which must be easily available to developers and CI
and not require to have a special setup with debug nonsense enabled in
some external tool.

The proposed implementation is just an ad hoc band aid as well. Why?

  1) It has zero relation to the actual failure detection code paths.

  2) It covers only a small part of the problem space. On all modern
     systems, which have TSC_ADJUST the clocksource watchdog is disabled
     and just asynchronously invoking TSC unstable is a hack which only
     tests the unstable logic.

So I rather want to see a more complete solution, which

  1) lets the clocksource watchdog logic fail the test

  2) lets the TSC sync (including TSC_ADJUST) logic on CPU hotplug fail

  3) tweaks the TSC_ADJUST register and validates that the detection and
     mitigation logic on systems w/o clocksource watchdog works
     correctly.

Ideally that's a kunit test for CI integration plus a debugfs interface
for developers, which comes with a related selftest.

Thanks,

        tglx






=20=20

=20=20=20

