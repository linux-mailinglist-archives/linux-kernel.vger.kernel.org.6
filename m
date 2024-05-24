Return-Path: <linux-kernel+bounces-188965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5168F8CE91C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014371F2161D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B612E1DF;
	Fri, 24 May 2024 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CJo7IR/C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y04txm8U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691D442F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570983; cv=none; b=MagwUD58/64EXyJG8YN+W8fL8t6iWAvvcepc10Snh2cwO7HdwgcCU5KkhcQ1yylhJk6ZaCLaWTt6DWVgZW+Ul0SHxLGiB0ha8pYLqIbsgOp0kyT+n1Y2GQKDlnPKYtNfYTpELczJkbp0qYoUIwd7IDDFxQXHONFP0JD4iCt9zMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570983; c=relaxed/simple;
	bh=Lh1/ZiqQOtBnGCfUA+jL+uz9J6FiB76LY/j2aJ3Lx9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KrmHEU8OQ9BpalO0uscX6JzcuSuYv4MndLn0fAhNrbQbqwE/Vh1uM3/hPgW5/vR55C1ecAYo+7s1s8hkPCbT8KEyME5ydjkEtbgtG9i8203Ni1C/Xqdu6ia8Jv2SdNSbXqSbbzbp7ZGPjvjW6WFUEE79i8zP/wJGLhXw0yAQalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CJo7IR/C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y04txm8U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716570979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lh1/ZiqQOtBnGCfUA+jL+uz9J6FiB76LY/j2aJ3Lx9E=;
	b=CJo7IR/C2u19hzw4gvNNsArZONhriIqrB2qTmb5O/0Pv7kWazkWMDZyIMUqB7TQukaofqG
	tcHZT7/Y/Pq2VFty86zGLI//BgEr7P1qTwoLlLecdtEFxEbhuLrH40VyGKFrq1kyAql/Hs
	J8jaTB/15+dKbj+QuNGAel/e3VZ7XUT//KTbT/U1cLpawWQcYgatD8VrXQrkYTCwPpYWVp
	y+WKevUNS55NKXWonuy8HjgrIaXMxXGdqxxR7J+LupnFtc+8AJQoMYkzG3mHNc5Pl7jQ/M
	WSILhe1/g/M9vzvWRikcsE5Hxi2IJ9p6zdvS8D5p+kVU8asWLu4XrSybjcuuLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716570979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lh1/ZiqQOtBnGCfUA+jL+uz9J6FiB76LY/j2aJ3Lx9E=;
	b=Y04txm8UJxIuT5k6HvFCufPgGPl9myW8KJuWm3uXlTnOWx0LT90QVhabwRR4U2/mWr85ng
	3T+VS5Bg7w2r8iCQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Phil Auld <pauld@redhat.com>, Chris von
 Recklinghausen <crecklin@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
In-Reply-To: <ZlCwKk65-eL0FrKX@pavilion.home>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com> <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home>
Date: Fri, 24 May 2024 19:16:19 +0200
Message-ID: <878qzzdtb0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 24 2024 at 17:20, Frederic Weisbecker wrote:
> Le Fri, May 24, 2024 at 11:31:12AM +0200, Thomas Gleixner a =C3=A9crit :
>> >> Race with tick_nohz_stop_tick() on boot CPU which can set
>> >> tick_do_timer_cpu =3D TICK_DO_TIMER_NONE? Is it really bad?
>>=20
>> This can't happen.
>
> Actually... The boot CPU is nohz_full and nothing prevents it
> from stopping its tick once IRQs are enabled and before calling
> tick_nohz_idle_enter(). When that happens, tick_nohz_full_update_tick()
> doesn't go through can_stop_idle_tick() and therefore doesn't check if it
> is the timekeeper. And then it goes through tick_nohz_stop_tick() which
> can set tick_do_timer_cpu =3D TICK_DO_TIMER_NONE.

OMG...

