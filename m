Return-Path: <linux-kernel+bounces-553591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B9FA58C19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CA8164325
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC8F1C82F4;
	Mon, 10 Mar 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c6Ue4xac";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tsHiaYqu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A21D54FA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588386; cv=none; b=QExcT++q0Tr5F9xW8MZtGljORD35GooGUC72PLF/FQror2gFBHyrijzzEPO2zkcGpCKPmCIOJZLRMbPkd4v2GLMTKcaOpKbnZy0YbNPetNGHttdT5A7fvDvOFCxVMwFgLk6qMgRpjU/sqWYwespyw4FCV3XRfHh0WX8bJgAUDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588386; c=relaxed/simple;
	bh=6+VfqkCYsCOIpD7+UjSqI2+P2NgZGvAMOk0n2giCoYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJ85H6+kLEx7a8uwKRmGq3xRDf5GMlq5MLfk0fZ5XgA6cXNra5BE8R3DAE0jBOHqLl3E+8G+cG+tspx9YPsYOLnijsbK1sph7hsdP4sDp9xAzuL4wO3vVnKh/a5z1tTM2xoACw3wpIR7l1QPIw2u8313gGeDm40NuU/DQTAEVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c6Ue4xac; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tsHiaYqu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741588382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VmqFvAA/Q7mWs0vLZqTPYl7v5t+yTZCxJx+lzLMW/U=;
	b=c6Ue4xac1l+YMo5xJQqlQ0hQboZh+hBiSEDgEJ9rr3CICqIkyoZACXpM/6D8ug6Oe4G+Zx
	8yH0dLX+5krUoAqReVSN8YoYu/rL2c8/ykH5at/YEDN9qjMwPL/iZ9cpPW684V+AQIh9z8
	/jIlHde1RLuUU/QQu9WJUlxN0m+s7lEBf4tVZ/1OjLKbiG79fFWnz9HHbR8ZYavhLLLXti
	by3g1MG5IzuFvJvGzKAJLD1nbo9YpA0QOdOb1z2Fj1Ra3RuoYlbJXMnOYfpTyvvu4iCvhk
	bKjhcXh5+A5wNPr/IjFd6rT1RA8+R0OcS/LMy5oOc7Pi4Z3lhUbyK+2M1EBOLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741588382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VmqFvAA/Q7mWs0vLZqTPYl7v5t+yTZCxJx+lzLMW/U=;
	b=tsHiaYquvnXMCSRHAvBo3r+eac4Ri7oBlPe9R5dmdroDVoxPe+eruFX3Ojb3MyHJjdYEHJ
	rMbWDaUUny7YUpDA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra
 <peterz@infradead.org>, Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 09/18] posix-timers: Rework timer removal
In-Reply-To: <Z84hpurQ6Co2jqV1@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.024143438@linutronix.de> <Z84hpurQ6Co2jqV1@pavilion.home>
Date: Mon, 10 Mar 2025 07:33:01 +0100
Message-ID: <875xkh2y5e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10 2025 at 00:17, Frederic Weisbecker wrote:
> Le Sat, Mar 08, 2025 at 05:48:32PM +0100, Thomas Gleixner a =C3=A9crit :
>> @@ -988,90 +988,56 @@ static inline void posix_timer_cleanup_i
>>  	}
>>  }
>>=20=20
>> -/* Delete a POSIX.1b interval timer. */
>> -SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
>> +static void posix_timer_delete(struct k_itimer *timer)
>>  {
>> -	struct k_itimer *timer =3D lock_timer(timer_id);
>> -
>> -retry_delete:
>> -	if (!timer)
>> -		return -EINVAL;
>> -
>> -	/* Prevent signal delivery and rearming. */
>> +	/*
>> +	 * Invalidate the timer, remove it from the linked list and remove
>> +	 * it from the ignored list if pending.
>> +	 *
>> +	 * The invalidation must be written with siglock held so that the
>> +	 * signal code observes timer->it_valid =3D=3D false in do_sigaction(),
>
> I guess it_valid is a leftover from previous attempts?

Ooops, yes. Fixed now.

> Aside that and the lost WARN_ON in signal delivery:
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

