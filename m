Return-Path: <linux-kernel+bounces-556279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A02A5C395
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C19C1881DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8A2580F8;
	Tue, 11 Mar 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="chQdwNG6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="00ArYphL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E519D067
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702594; cv=none; b=g+eqjDRViPgy6gw7vJ4jgQuE2fOAwEAEixPnV6L+Mu+nqY3MjGUiqccF154rKsDkcpYOUPF9aefOYz3kNlf3uDyngD39IJozRf8FswI/49lZ7QCXKp4XRVkxajLM6UltxFsUhTn7DBg9Rm3i41MzM5rfZfh462Hl/35zOqhSSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702594; c=relaxed/simple;
	bh=UfXHTMaPVdG7ZxNL1lHSUbJV5e4J5vNj/AHB9cZQTac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dyKozvEIEvTP2xtZCrQYcSfzf/g/D8Y471aujtcyAHp8CL9o7SUSt8UdeP3DMvp7tD2RbO7ue0K4E/09QSS9fZeiNwQlexBoOH/nsvVhIrAg+EfwZ0GIkVaaiBouvkjKK6pep5a5tmfMOeVkxIr6LZIkv4Wyg8zVPAro57IlTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=chQdwNG6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=00ArYphL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741702591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwyWWMDbvftDi6swFTAUyPJOVj0fxdOJ/gPcHhgwuoQ=;
	b=chQdwNG6AzEXXMLe1zDBCnPTPxLEyGI02HWMKBlIwLf/dyPTJkOpO15oa+Z1NzhOt9iGNa
	4L6LFuT+W6ryBgHTafQ+os29/0QSxjv/1HyZsdm4HKWsMkIUAdj3/EeGFyib9/386EsIWA
	Y7ZhJf/Vw69Rt5znxAVfa1e6jF/c7puI0n5gFCUex0ak4aocmOMdmWcrv5dF5PEyGWIIJm
	s+RrfoZF/GkAsCRXODRnXkvqZO7BptTY/h05WtkLViSBXcitGpflutSfU8zmvIsikx31Is
	A/cu1VVizPKFCnuRxS1XUpY5m0dEdhIsgUgtDIfpBu6J3e5m1ni1I/cHIiCq3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741702591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwyWWMDbvftDi6swFTAUyPJOVj0fxdOJ/gPcHhgwuoQ=;
	b=00ArYphLbzRh7uDnC9ScRsfnzlUUL+SAj/I1l0rK3Vz0RsOmCo2s2i+B/0HgBVmT+SGTPc
	R4E6ssgEhps0ETBw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra
 <peterz@infradead.org>, Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 02/18] posix-timers: Initialise timer before adding
 it to the hash table
In-Reply-To: <Z9A5uixC_Tjk308w@localhost.localdomain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155623.572035178@linutronix.de>
 <Z9A5uixC_Tjk308w@localhost.localdomain>
Date: Tue, 11 Mar 2025 15:16:30 +0100
Message-ID: <87y0xbzm81.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11 2025 at 14:25, Frederic Weisbecker wrote:
> Le Sat, Mar 08, 2025 at 05:48:14PM +0100, Thomas Gleixner a =C3=A9crit :
>>=20=20
>> -static struct k_itimer *posix_timer_by_id(timer_t id)
>> +static inline struct signal_struct *posix_sig_owner(const struct k_itim=
er *timer)
>>  {
>> -	struct signal_struct *sig =3D current->signal;
>> -	struct hlist_head *head =3D &posix_timers_hashtable[hash(sig, id)];
>> +	unsigned long val =3D (unsigned long)timer->it_signal;
>
> When used from posix_timer_add() -> posix_timer_hashed(), it can race
> with another do_timer_create() that clears the BIT 0. It's fine but
> KCSAN is going to warn sooner or later.

Indeed

> It looks like a good candidate for data_race() ? Well, READ_ONCE() is
> fine too.

READ_ONCE() is the right thing to do.

