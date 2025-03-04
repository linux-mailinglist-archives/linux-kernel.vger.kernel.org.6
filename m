Return-Path: <linux-kernel+bounces-544348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E8A4E045
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E231760F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869AE2054EB;
	Tue,  4 Mar 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ms9xl1bl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kLvPDIwV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82884204F7F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097214; cv=none; b=AIz7nx3W4M+0L1MdCcNTMn5Tcpdj0FjKcGMTWUWWk9Y9YJIaQRu0rQnqOFWTwvfp/PKimYiXZwnBZAOhgifahovvnYS1+wqgCHuciTHaIVzNqVxVZVQpRP09mtK1YhtrxewXI4awm1+RebFS0yQEPDEuP1UdotAsBg42RAPIuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097214; c=relaxed/simple;
	bh=nTtHJoZTZLFRcTSvqqKeIPLsJ4F+Gi2YfEeiFa2+3Ow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WKviJ4i69LmbFeEOFGUknAZ/DG9m4lSr2S0ls2QQOQ2TzZJKsAIcalQ69rB0b0FTH3cpdKUljVoW5GNAUI2RKAvn2BYGxh4g/bviBh9oV010AQuYI0NDE/QIh9mVPBQ/JuQf/8ZvLULFF/2DbW3YKEhgN7snFVoMAULJHEV6y0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ms9xl1bl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kLvPDIwV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741097210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTtHJoZTZLFRcTSvqqKeIPLsJ4F+Gi2YfEeiFa2+3Ow=;
	b=Ms9xl1bl39txeF6xPTvYn9bXjYMEXCnXG/xMddZuU5sbmB0NQ/D5o6QMTR7+FTmIOgGxda
	8zyu4MOOhMyMIL04JUAB+n/FJzqg42AX1msyifwaXEDKK3nyn7R03OBNXFTSTGREFJ+d0P
	k3+LkI7/hP6xPc1vgv7pTFTMGAy+XNVf/91WPS1Rc8tgu7wP1kJyiitUX1WewR1vaIud0N
	a0yS9wqqqTt49gMUssAK52/Uu4/F/7o6L999ain3PYivUIuKXiys54I5NkMSsMOhHwzD2s
	03NenMZoO0Z5yvzDo0+jVjQsC/9fiFuFFi9pZ6pWZ+q3Phnh4mcmzggQ47Ge1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741097210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTtHJoZTZLFRcTSvqqKeIPLsJ4F+Gi2YfEeiFa2+3Ow=;
	b=kLvPDIwVRBH9j6+THD+6EPgLC4ILX6IPU5a20JGIQxDE9L+Icmo+ZzsLdADJBR8lzrYbbH
	gLrlRoU0nC76lfDA==
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Benjamin Segall <bsegall@google.com>, Eric Dumazet
 <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [patch V2 08/17] posix-timers: Rework timer removal
In-Reply-To: <b6e7766c-3e9c-4d65-8b6b-3e19140cb572@virtuozzo.com>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.416552300@linutronix.de>
 <3e38af8c-1d06-49bd-aa30-f4e8b0263492@virtuozzo.com>
 <b6e7766c-3e9c-4d65-8b6b-3e19140cb572@virtuozzo.com>
Date: Tue, 04 Mar 2025 15:06:49 +0100
Message-ID: <878qpk7uva.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04 2025 at 18:20, Pavel Tikhomirov wrote:
> On 3/4/25 18:10, Pavel Tikhomirov wrote:
>>> +=C2=A0=C2=A0=C2=A0 while (timer->kclock->timer_del(timer) =3D=3D TIMER=
_RETRY) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(rcu)();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&timer->it_=
lock);
>>=20
>> Maybe "guard(spinlock_irq)(&timer->it_lock);", since we already use=20
>> guard constructions everywhere else?
>
> Sorry I'm just stupid. Please ignore.

You're not the first one to trip over this :)

