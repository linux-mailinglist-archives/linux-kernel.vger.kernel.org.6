Return-Path: <linux-kernel+bounces-372502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4199A4957
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39FE283EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C7518FDD0;
	Fri, 18 Oct 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rmoMJXT+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/7x9dyYA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A018E763
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288772; cv=none; b=JVMYX62BeFjW0NwFjHmzWusZjVFYoPdPaJhyJctwuL8rs0n5+vhR7KpmqV/w+DzYkE7OpgsnkkDZ9wETKqr2ZHVtIKOydDovDeo2BKyz/ruQNSi69gy17FvwEgp/Y0V3M/ZHC2eUUtkaF3ecB0pXB1Ve1YIiurat3fU8n+t16LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288772; c=relaxed/simple;
	bh=XW/A0nJki5YcX5WC3DWS1Neep22TGxvLkdp8pDiWv4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nCXFSU0CLqfAAUIZaUBvt8nkBCimQ/DV4tL90kNp4ErG1DBQwjYOZcX8K2MQ/NIR+GfUzaS9s5KWD53Pw8AkCXHesEdNzuVnC0sbobLL0FcL2mE2fwuVAqj3KwaSIRUXr6EcBvXfeCHNSOK/0Vi/h6A/GHF0zhmngssTKjHbWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rmoMJXT+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/7x9dyYA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729288161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XW/A0nJki5YcX5WC3DWS1Neep22TGxvLkdp8pDiWv4Y=;
	b=rmoMJXT+vapPrOcAdYcyWLIsjgGijDZhswletdfHHx62Xsm1uFha7tzksuWm3IsHfsBj/E
	j/sBzWSy+Q5ucgOMrFY+t0jeGjuXakA21u8aHYCqnJQWh2ygKZCqoBpbEHMW8IZOU9Y9kJ
	MretUzzJecpGs1NWJR0ryHJTZAQliOmxET0hClpRiWaCec6aMYJa6rZ0XsK21+/9HxezQr
	vrIlLgXCd11cShnKWt+akLDLQPSfIH0qG9ztS+9x7daZawxEgwPQ2OAUsA+9VQyKGC4/t1
	w9RvFIMTi/NSLhj76SVnlTZtGQgMkOe//vFFrXusjTmO6bpYa07MyfA/YJshVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729288161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XW/A0nJki5YcX5WC3DWS1Neep22TGxvLkdp8pDiWv4Y=;
	b=/7x9dyYAu62KOuqT5A8CjWaGoDFs+oNaHQeqp1xus/8bKzOMdgR8EQFCqYTouD8UsOGljM
	/8+aUTlmOOaJS5Aw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 01/26] signal: Confine POSIX_TIMERS properly
In-Reply-To: <ZxJZeDlbqVMlaFps@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.314100569@linutronix.de>
 <ZxJZeDlbqVMlaFps@localhost.localdomain>
Date: Fri, 18 Oct 2024 23:49:21 +0200
Message-ID: <87bjzh84ke.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18 2024 at 14:50, Frederic Weisbecker wrote:

> Le Tue, Oct 01, 2024 at 10:42:00AM +0200, Thomas Gleixner a =C3=A9crit :
>> From: Thomas Gleixner <tglx@linutronix.de>
>>=20
>> Move the itimer rearming out of the signal code and consolidate all posix
>> timer related functions in the signal code under one ifdef.
>>=20
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> I assume nothing has changed on this one? If so I reiterate:
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Sorry, I somehow missed to pick up the tags.

