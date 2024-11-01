Return-Path: <linux-kernel+bounces-392909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3461D9B9989
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8122829E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503801D9A57;
	Fri,  1 Nov 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tFvVF0Ye";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+8Sd31pc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513A5155330
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493400; cv=none; b=hP8G3OeAY9DlXI72eAOTqPaAx7lDbVoDwxT7Zr5VBI9ng5nWc8RReH1WZrvgPiJApt/eUzLToEuPS62KUm4Ss7MEMI3gnd4hJCCHf7HNBwOTZF14NZlTNNjJK5Qt/4dm4kTVqz2IdYZakdqKYcqbLEi7pmAIQchKEV9ZlWbWmfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493400; c=relaxed/simple;
	bh=tMpgOWHuEoX00C09GTsKskt3osObHGxA1muMd0q5COc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gNk4OTc/JJuZdEKtqLCA5xyf73ck+G1eHuTGRkR3lDN1uhxqpA8PYs4Hg3WMmleYoYsGUxHo3lQq5caOl7o9tCoYVA43ohgMIEj+7d6lvarm9kN/yUzotylg7C5SfUR1PPy1UFWmHoJ1O01QLl5eVj9s+dE+r2NHr03VQt/Vhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tFvVF0Ye; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+8Sd31pc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730493397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00BsPOy8erBIeyhiKinMrgq+25mDGcjHusNGgbRROVQ=;
	b=tFvVF0Ye3GxXAWqNPpTp0G0iDu/9x4f6V2dQW4ww2jrtW1NTj6GNXbMGPrlLoSHoqPfT2Q
	qkatB4aJykVFC9YDAgNjsoauiEiaZ1d8XLYZ5YrgZi4OWaT0Xlyhb/SXlxKCSCU4LRKJuJ
	Jzt1QA4OSqMZarYCnDJqhNkEQSTVh3+4mhOSRNSv35iKW+tp1y663QVxMLYNqLu5zktekx
	y5ys7nsn12pm4jYddXoPyEfdYWjA+akYIgK778qS2SCb5SLz70ypyZdhoratP0csLogU87
	OYQklut5bxo92++pc9FVUMRQcUZdvPrSt6iUi8R36gz9FeJeDVgsgPY+Y8R/Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730493397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00BsPOy8erBIeyhiKinMrgq+25mDGcjHusNGgbRROVQ=;
	b=+8Sd31pcvJJ6Hp29lbJAOClUbOl2MXjHkmuko7fPY9SPZ1flzbS/mxCe+mGNKAfrEWJt2o
	yWm7Bw6ZV3qJuVCw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 02/20] posix-timers: Make signal overrun accounting
 sensible
In-Reply-To: <ZyTO7mFZWRZf7sNv@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154424.677253735@linutronix.de>
 <ZyTO7mFZWRZf7sNv@localhost.localdomain>
Date: Fri, 01 Nov 2024 21:36:36 +0100
Message-ID: <877c9mvgh7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01 2024 at 13:51, Frederic Weisbecker wrote:
> Le Thu, Oct 31, 2024 at 04:46:25PM +0100, Thomas Gleixner a =C3=A9crit :
>> @@ -1968,15 +1968,9 @@ int send_sigqueue(struct sigqueue *q, st
>>=20=20
>>  	ret =3D 0;
>>  	if (unlikely(!list_empty(&q->list))) {
>> -		/*
>> -		 * If an SI_TIMER entry is already queue just increment
>> -		 * the overrun count.
>> -		 */
>> -		q->info.si_overrun++;
>>  		result =3D TRACE_SIGNAL_ALREADY_PENDING;
>>  		goto out;
>>  	}
>> -	q->info.si_overrun =3D 0;
>
> So it's not cleared anymore on signal queue?
>
> Not sure if it's a big problem but if an interval timer gets a signal with
> overruns and then the timer is reset later as non interval, the resulting
> upcoming signals will still carry the previous non-zero overruns?

Duh. Yes.

> However it's better to keep the overrun update on a single place so
> perhaps this?
>
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 66ed49efc02f..f06c52731d65 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -282,6 +282,8 @@ bool posixtimer_deliver_signal(struct kernel_siginfo =
*info)
>  		++timr->it_signal_seq;
>=20=20
>  		info->si_overrun =3D timer_overrun_to_int(timr);
> +	} else {
> +		info->si_overrun =3D 0;
>  	}
>  	ret =3D true;
>=20=20
> Other than that:

Let me fold that.

> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

