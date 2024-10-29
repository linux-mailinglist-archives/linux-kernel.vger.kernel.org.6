Return-Path: <linux-kernel+bounces-387536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 114EC9B528A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9979BB2297D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0846205E1B;
	Tue, 29 Oct 2024 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XFwsUzOW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DAhTgryF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D01E0B6C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229391; cv=none; b=UifEHpmEexfwtzekCRCWqbFVhCf7kVxXFJCiK1+hqOyUn0Hs7JBnKRL4bYPfvO51C8e0+L/qiS0HQmU5pHXfaIh+bWOcMudk05ySx9f7hPWGcIA8E/fXV9cA7NpNakRKYHjXPZehMftQJk9YhDzGXdpk5ysjp9XtpISpg8U0lfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229391; c=relaxed/simple;
	bh=UbSStNe9R/ETlbLpVCL2pEGDef1eHnhTobOrG+VTN74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eBHp2g80XAAX/sKVR+GIvrVuf4OpNHmoKZhDHOcyjFmkZpyuFUgoX0yBqJfNNJumFCW7fkh1Cb8kxfxMIBMVjKtaaB0/UIK/nbAAAuFbdPeHYc/ijICD/CxEkpuq5GrZcWAdHKwBTnqU7LQQOi0V/d6woER/6m9mHShTuG7olVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XFwsUzOW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DAhTgryF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730229387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Xtr6Ss9UsogchzrOxzhffEGhhorM6h4jev85f3MOJo=;
	b=XFwsUzOW5J7nSo8HOW+vG7mZbJCkqwgAQMw04feLJhLyNyglG9b/B8hOEd5akGiO8cIPEX
	xPvOst16qrWzKjY9LbyhW/iltVpJm6ASa0mn64faCC3Jdn2R2ZNhtDi/pgzLLBfd/d4uMb
	AsBO7hXGFVqlenNOPGOfPdP/g2LQgz+VJ5O8nil5gqjdCajO5zKV6BFgVhznqUl4bK3hBi
	4EZ9FL9hlNSTzJds1n5d4DhGn4fZmiK54xEMXDwUvvZas+YuIJXrc46pRUOpUOXcj4l57R
	tMYJlVIcPq8z7BO6qVBbiKtx4Scy4iPBeBbHxf/H5bHKZ9bTt9qoRYTkRf2H+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730229387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Xtr6Ss9UsogchzrOxzhffEGhhorM6h4jev85f3MOJo=;
	b=DAhTgryFYvOZP+UAB/qTUTNZur31gBoPthhudvaEAm4T9GrzQP+DrSbBBQcaDgCIOiYuqf
	oqDfP5um+z579eCg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 16/26] signal: Replace resched_timer logic
In-Reply-To: <ZyEhrrDhDiQ6LwjV@pavilion.home>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.220867629@linutronix.de>
 <ZyEFyV28jcz85V1q@localhost.localdomain> <87ttcu281y.ffs@tglx>
 <ZyEOeqkSYWR2XTp_@localhost.localdomain> <87jzdq26id.ffs@tglx>
 <ZyEhrrDhDiQ6LwjV@pavilion.home>
Date: Tue, 29 Oct 2024 20:16:27 +0100
Message-ID: <875xpa1zzo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29 2024 at 18:55, Frederic Weisbecker wrote:
> Le Tue, Oct 29, 2024 at 05:55:38PM +0100, Thomas Gleixner a =C3=A9crit :
>> It still happens because SIGQUEUE_PREALLOC is cleared in sigqueue_free()
>>=20
>> __sigqueue_free() has
>>        if (q->flags & PREALLOC)
>>        	     return;
>>=20
>> So the old code called __sigqueue_free() unconditionally which just
>> returned. But now we have a condition to that effect already, so why
>> call into __sigqueue_free() for nothing?
>
> 1) Signal is queued
> 2) Timer is deleted, sigqueue() clears SIGQUEUE_PREALLOC but doesn't go
>    further because the sigqueue is queued
> 3) Signal is collected and delivered but it's not calling __sigqueue_free=
()
>    so the sigqueue is not released.
>
> This is "fixed" on the subsequent patch which uses embedded sigqueue and
> rcuref but this patch alone breaks.
>
> Or am I missing something that prevents it?

Again:

> 1) Signal is queued
> 2) Timer is deleted, sigqueue() clears SIGQUEUE_PREALLOC but doesn't go
>    further because the sigqueue is queued

  3)
=20=20
void collect_signal(..)

     if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code =3D=
=3D SI_TIMER)))
	*timer_sigq =3D first;    // Path NOT taken because SIGQUEUE_PREALLOC is n=
ot set
     else
     	__sigqueue_free(first); // Path taken and frees it

No?

Thanks,

        tglx

