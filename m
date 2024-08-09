Return-Path: <linux-kernel+bounces-281542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C391C94D7F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E4C1C22B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3798815534B;
	Fri,  9 Aug 2024 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u+CR8fXQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4jmMGTs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FB4C83
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234526; cv=none; b=gd2OXvbLXiMA9znbIfgPAK6iMTfis1lKam00PMLJwGa5w7FEW6OOYeDX7s9sKcuDgjCFZqGxzy1vG6MPUcrli3GehsFev2jHrAs4IqR/OVozpg18/cugyuHQKbVlz42NvUJQsrImXTpL4Kx5F3+LU8mMDO28Xx3C3Nv/nHbfqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234526; c=relaxed/simple;
	bh=3wDwr4ieS/qd1ZS6aZJrTSknXaFpATFsZyMZdW5VIFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bJVZBU7Eyuy4nQnVCpf57DeZY475dnB/qH7wMk3EKmWHLwk6/DkfyWuntvbyQqFe6tzImWHEOR5F7HjdRey8Mbxy5h8FKOUhf0sB6D6hoRwPVle2iI7IFCeSQ1UoUnciGYGWxADMeZMlk28NARSDv6zg9IJUqsIn0GR9bHUlI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u+CR8fXQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4jmMGTs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723234523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYzXcZ6YmSl5dDiG+XZfEaXficbZOAVIibMVnTgCdNs=;
	b=u+CR8fXQGN9XysRM47Y2z2J0SpqFWyMzyDpPiDRA90BOYGsB2M/o0FdenRPhM8tNoOS1X6
	7joZYUfBqEAdfS6g8M24ppNq4IBYpHxM1ok2+1tTZeqDWi9lO+e0y4wgz/VKolFvK5bXVC
	UFLUnH07iJLQJE/wQ64I3OwFAlAL++BjyNMe46VZYOvIYk6G8+Xej91smqmU98Cf4vKppZ
	OAFsF0cHlv7vC0HMPfBYFCkXXWKUhaE2lnBI3CKh77IXQDTQnSzScqNn+ktY9F7/QU86b5
	u7d0yc6TA8gVRlgb51RzdsZ75Tz2b7NJtqx++U1Bko6p8Z5xerfDj06hdAAocg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723234523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYzXcZ6YmSl5dDiG+XZfEaXficbZOAVIibMVnTgCdNs=;
	b=f4jmMGTsSy5aaC8oOLI1NPxRfUHt+wwvQZD+SzOmRVAni254OaVG/uHMvnGSmNrOUxcC0W
	QuDuH6pOq6CVb4Bw==
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "qyousef@layalina.io" <qyousef@layalina.io>
Cc: "frederic@kernel.org" <frederic@kernel.org>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>, "anna-maria@linutronix.de"
 <anna-maria@linutronix.de>
Subject: Re: [PATCH v2 0/1] hrtimer: More fixes for handling of timer slack
 of rt tasks
In-Reply-To: <46ad86f8b1fc4fb5dbb3da8f6ab664f48955849f.camel@siemens.com>
References: <20240805140930.29462-1-felix.moessbauer@siemens.com>
 <20240809013433.pazaymcdx37lhpau@airbuntu>
 <46ad86f8b1fc4fb5dbb3da8f6ab664f48955849f.camel@siemens.com>
Date: Fri, 09 Aug 2024 22:15:22 +0200
Message-ID: <878qx5tput.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09 2024 at 08:47, Felix MOESSBAUER wrote:
> On Fri, 2024-08-09 at 02:34 +0100, Qais Yousef wrote:
>> On 08/05/24 16:09, Felix Moessbauer wrote:
>> > This series fixes the (hopefully) last location of an incorrectly
>> > handled timer slack on rt tasks in hrtimer_start_range_ns(), which
>> > was
>> > uncovered by a userland change in glibc 2.33.
>> >=20
>> > Changes since v1:
>> >=20
>> > - drop patch "hrtimer: Document, that PI boosted tasks have no
>> > timer slack", as
>> > =C2=A0 this behavior is incorrect and is already adressed in
>> > 20240610192018.1567075-1-qyousef@layalina.io
>>=20
>> There was discussion about this hrtimer usage in earlier version if
>> it helps to
>> come up with a potentially better patch
>
> Hi, Sebastian already pointed me to this thread.
>
> When debugging my issue, I did not know about it but was scratching my
> head if the behavior / usage of rt_task is actually correct.
> The whole naming was quite confusing. Many thanks for cleaning that up.
>
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> https://lore.kernel.org/lkml/20240521110035.KRIwllGe@linutronix.de/
>>=20
>> My patches got picked up by the way, you'd probably want to rebase
>> and resend
>> as now the function is named rt_or_dl_task_policy()
>
> As we use rt_or_dl_task() in nanosleep, I'm wondering if we should use
> the same in hrtimer_start_range_ns(). Is that because PI boosted tasks
> need to acquire a lock which can only be a mutex_t or equivalent
> sleeping lock on PREEMPT_RT?

No. Arming the timer has nothing to do with mutexes or such. It's an
optimization to grant RT/DL tasks zero slack automatically.

The correct thing is to use policy based delta adjustment.

The fact that a task got boosted temporatily does not make it eligble
for zero slack. It stays a SCHED_OTHER task no matter what.

rt_or_dl_task() in nanosleep() is fundamentally wrong and needs to be
replaced with rt_or_dl_task_policy() and not the other way round.

> Anyways, I'm thinking about getting rid of the policy based delta=3D0 and
> just set the task->timer_slack_ns to 0 when changing the scheduling
> policy (and changing it back to the default when reverting to
> SCHED_OTHER). By that, we can get rid of the special handling and users
> of the procfs would also see correct data in /timerslack_ns.

That makes sense.

Thanks

        tglx


