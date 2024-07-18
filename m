Return-Path: <linux-kernel+bounces-256461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D8934EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9231F2130E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A261114037F;
	Thu, 18 Jul 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4B99KCuB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qLYrMNH+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AD1386A7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311791; cv=none; b=Rx1R33CItIsnMeEBHFp6GpFKNswZAbF4rvz/LJqjhp7e6xjNt6ISn3Q37P8BNmpi5eeTJ1Bue+40EYndNjIjBHEN6n6WzV3cO9zu5ab/RhCVrYvyyEDdOu26XfdXfVCgXXqJ3G20p6OroLIer6+tflffjLnDbfh+qaYGkdVgdKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311791; c=relaxed/simple;
	bh=GgnLs1N6M+YFujwWnXqXagoBz7fr8MDq+lsER+3s5to=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y6f9/u10gxreqoKFD+XDzPb5IsjyATHszaX5OLb1QS4O+H6GHeoDKdFu+Z2XK/exuIt9/WHvMx+N/J5M5w5oJwJmydepd3kETIKHPHs/DSPpdHBEu62MGE9NDS+khpnda9rbsUpsXc9dvpgDcv4OMGhpBsiSm0DH9KJcMcbv0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4B99KCuB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qLYrMNH+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721311784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3XzqZMOB1M8qRsfuho7tZyOrbYYaINC3V9dBrWVYXE=;
	b=4B99KCuBChMVZLO8xcWeYYiY/+Gk3dQEgAJROUGDQpeMbxbJsHRE0893W/mE+ioDmP/uyH
	4z/csIJRtiXztBJGTwblbrCk1T9JBDLme1S6CMH/B7t48FtnLaE8qvk+wB6/jh8P83iOXH
	WmLTCSqJB9H0m/DQ0JT0SAc5gU3Lew4ng0gwHDVEXAMrgreXz6EXgkI+MJShPq/a9Ay/Af
	C7my1+LeHSF/Ds8GAa9yEDpLmYeDuIqKvVKJlbObhv49Kg/iOkoTLP42+3x93oWw+O0/vo
	JMEN0ejHC9FKZRaqTp+f0UkIy3yxDbPzIdY9bfjqcdQqijZ+KUKHF4GAGw1Maw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721311784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3XzqZMOB1M8qRsfuho7tZyOrbYYaINC3V9dBrWVYXE=;
	b=qLYrMNH+X9/UN/r49B3QLaL9iJnns+uB+mbAAvZmh2XazDlZIusbmyLDsfVt5SJykjoIra
	cdcS5DYVpvfNqPAw==
To: Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Omar Sandoval <osandov@meta.com>, linux-kernel@vger.kernel.org, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, kernel-team <kernel-team@meta.com>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
In-Reply-To: <d18ff73a0ef7536f654b63854dc891984319093f.camel@surriel.com>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
 <87plrcqyii.fsf@jogness.linutronix.de>
 <93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com>
 <87r0brkvqd.fsf@jogness.linutronix.de>
 <d18ff73a0ef7536f654b63854dc891984319093f.camel@surriel.com>
Date: Thu, 18 Jul 2024 16:15:43 +0206
Message-ID: <877cdilrko.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-07-18, Rik van Riel <riel@surriel.com> wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index dddb15f48d59..36f40db0bf93 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1060,6 +1060,8 @@ static int __init log_buf_len_setup(char *str)
>> =C2=A0early_param("log_buf_len", log_buf_len_setup);
>> =C2=A0
>> =C2=A0#ifdef CONFIG_SMP
>> +static bool vprintk_emit_may_spin(void);
>> +
>> =C2=A0#define __LOG_CPU_MAX_BUF_LEN (1 << CONFIG_LOG_CPU_MAX_BUF_SHIFT)
>> =C2=A0
>> =C2=A0static void __init log_buf_add_cpu(void)
>> @@ -1090,6 +1092,7 @@ static void __init log_buf_add_cpu(void)
>> =C2=A0}
>> =C2=A0#else /* !CONFIG_SMP */
>> =C2=A0static inline void log_buf_add_cpu(void) {}
>> +static inline bool vprintk_emit_may_spin(void) { return true };
>> =C2=A0#endif /* CONFIG_SMP */
>> =C2=A0
>> =C2=A0static void __init set_percpu_data_ready(void)
>> @@ -2330,6 +2333,8 @@ asmlinkage int vprintk_emit(int facility, int
>> level,
>> =C2=A0
>> =C2=A0	/* If called from the scheduler, we can not call up(). */
>> =C2=A0	if (!in_sched) {
>> +		int ret;
>> +
>> =C2=A0		/*
>> =C2=A0		 * The caller may be holding system-critical or
>> =C2=A0		 * timing-sensitive locks. Disable preemption during
>> @@ -2344,7 +2349,11 @@ asmlinkage int vprintk_emit(int facility, int
>> level,
>> =C2=A0		 * spinning variant, this context tries to take over
>> the
>> =C2=A0		 * printing from another printing context.
>> =C2=A0		 */
>> -		if (console_trylock_spinning())
>> +		if (vprintk_emit_may_spin())
>> +			ret =3D console_trylock_spinning();
>> +		else
>> +			ret =3D console_trylock();
>> +		if (ret)
>> =C2=A0			console_unlock();
>> =C2=A0		preempt_enable();
>> =C2=A0	}
>> @@ -4321,6 +4330,15 @@ void console_replay_all(void)
>> =C2=A0static atomic_t printk_cpu_sync_owner =3D ATOMIC_INIT(-1);
>> =C2=A0static atomic_t printk_cpu_sync_nested =3D ATOMIC_INIT(0);
>> =C2=A0
>> +/*
>> + * As documented in printk_cpu_sync_get_irqsave(), a context holding
>> the
>> + * printk_cpu_sync must not spin waiting for another CPU.
>> + */
>> +static bool vprintk_emit_may_spin(void)
>> +{
>> +	return (atomic_read(&printk_cpu_sync_owner) !=3D
>> smp_processor_id());
>> +}
>
> I think what the code would have to do is only trylock, and never
> spin after taking the printk_cpu_sync_get_irqsave lock.

That is what the code does. If @printk_cpu_sync_owner is set to the
current CPU, the context is holding the cpu_sync and will call the
non-spinning variant, console_trylock().

However, my first suggestion to defer whenever the cpu_sync is held
really is the only option because console_unlock() will spin on the uart
port lock, and that is also not allowed when holding the cpu_sync.

John

