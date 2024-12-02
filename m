Return-Path: <linux-kernel+bounces-427870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECADB9E0720
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F562175978
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2473C20898C;
	Mon,  2 Dec 2024 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxtMhAMg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86181D5CF5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152899; cv=none; b=TUbHelz5QHg3vSoOhwk/gHkzHoRJ9clgLtS0mt0XvmgeosPI6ERjvXjmaPgncmGZjBAHOzDMJTxqU4JokOqNlKVX7F3Li4w2aDFOyqjr2gimmnlVrrUoST+1RW4iTWcbHG5zUW98C7GnUyz00Mdix5SqSYvPpFWZkSZTGrk9azo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152899; c=relaxed/simple;
	bh=1fem/pAqlIUnw0gQKE8KwwacxF35hQD/flcACpT6FO8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZu/rBWBsBuOf6DTx9K1xiYVk4pggOs+Rimk9gndmF+CNC+V1ozyIy2GEKf0kXjM7cagr0xLkZGnERoRFwS8QYJpEOzIdFwr1cOOJFEZcCBTi7fYJHRrYNPj7xE123+yL5kSYEkihkGkdisYy4g3Mm9UZD08sY4P0rTjcKwVd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxtMhAMg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733152896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1fem/pAqlIUnw0gQKE8KwwacxF35hQD/flcACpT6FO8=;
	b=ZxtMhAMg3tz3WtCW49HJ84Gt9THxyWLd8TeJYZ5QHFU8MGDqUy3G1ebpMnqD96g0mq30pd
	SuUZV0Ufk0rLNWTveP1tXchTuiy7fH+VpluHRUiQbK31BBJ5QOesImTKuwjlilHo5AReKZ
	gXfDWrgPKpOj5fw30nWw3WCj84qaPQE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-MSun0XAUMIekS_n1ym2Dbw-1; Mon, 02 Dec 2024 10:21:34 -0500
X-MC-Unique: MSun0XAUMIekS_n1ym2Dbw-1
X-Mimecast-MFC-AGG-ID: MSun0XAUMIekS_n1ym2Dbw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a5ca6a67so31816185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:21:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152893; x=1733757693;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fem/pAqlIUnw0gQKE8KwwacxF35hQD/flcACpT6FO8=;
        b=XwgiEmj1PGH4O+zWXjEoqS6uaWyefZiVu+aj6CaVRJsl6QWZPCAK5KvdIWU/nifyTY
         EGOaSrRLOTHSe/i9hCY2Ud0F5Gd4ybbBaCdVhO4l0A6dA6sWDXlvXGj7LAUuEu62X34T
         ZyJIV+Jh0Tk9lAOvqPjoGiH0j67RPGCxEK531aEyXTIafblZKFkrrTwhGvZCwYHsUtpl
         jZtT2xdSsSuuePijWn/+AX0+5I6DOKhXe2H4jF2lC4KrufKMmvqFuaEADGsmLU5UtXOO
         9DKtWuMqta/K41wFQgAiTnu3tR7DeNTZe+imuNAZtL4Nje2FE1NQuCwJT2Ju3+a6KbDX
         Jo1A==
X-Forwarded-Encrypted: i=1; AJvYcCVVVXxu85CCeUN6YDb/Bx3XWa03SszFCL56POr92DamK9gbpA8T3Qxp/wHYHsqmdRfN39r0WHQg4uthBCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUVvQu4/TiKqQR8f92a8mpdgMH/kJOn+6BDuOQ5oebPKMg2iU
	bUJ6xGk2fIPgD+2/3db+GjYxjEvmZVZ2Ap998fXStuwkGOhvYOHE8jE+U6AApHei2CHp9DxoQEJ
	Tgq1m11wbwb8jnJhGw8hRo+uP7ZcuGzUFM7F5WMAxY37d4NlJIY8KnOiNgbKp0A==
X-Gm-Gg: ASbGncvXPe9EEa9p03efnfBAr/GCjo+pSF77J+rzM/VPowPmzMBRDzjaPvIm5qf/Z7z
	T/VDiyCkmNeiMoiT4vtIpT0QjmAMAuccvSHRSU8fLgc8ciscHRq2ihTCqAeVOht1yIpxDWhvMCH
	JvHm2xb1ItcC8aPxiKFToBjcIIGGfF3+2UdR2z4btur2+Z5ou6din9MMMe5IMIUxWxYvkGUswgA
	pPnRuWXf+n7kk46rxOUo40Edx8m50+kNtP93t8aFiiIuL4FF6lukDohGkZ0XjLMMeANjmQJ7/qq
X-Received: by 2002:a5d:64cc:0:b0:385:f092:e00 with SMTP id ffacd0b85a97d-385f0a15378mr4069209f8f.50.1733152891894;
        Mon, 02 Dec 2024 07:21:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG937D3RpnGc/LAGI91biGTa9y9+eoHkJjLKa0c2h+zONfzE99nBeAZX56bsUEfuaoD1JafpA==
X-Received: by 2002:a5d:64cc:0:b0:385:f092:e00 with SMTP id ffacd0b85a97d-385f0a15378mr4069172f8f.50.1733152891494;
        Mon, 02 Dec 2024 07:21:31 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd367f9sm12577739f8f.31.2024.12.02.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:21:31 -0800 (PST)
Message-ID: <71f31ba8b26d25e3295a2e99803a11eca4e94788.camel@redhat.com>
Subject: Re: [PATCH 2/2] sched: Move task_mm_cid_work to RCU callback
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,  Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: paulmck <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
  Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett	 <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Uladzislau Rezki	 <urezki@gmail.com>, Lai
 Jiangshan <jiangshanlai@gmail.com>, Zqiang	 <qiang.zhang1211@gmail.com>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Date: Mon, 02 Dec 2024 16:21:28 +0100
In-Reply-To: <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
References: <20241202140735.56368-1-gmonaco@redhat.com>
	 <20241202140735.56368-3-gmonaco@redhat.com>
	 <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> I've used the same task work pattern as NUMA here. What makes it
> OK for NUMA and not for mm_cid ?
>=20

I didn't investigate the behaviour with the NUMA work, but my rough
guess is that this wouldn't even be visible in an isolated environment
(i.e. no migrations).
Also it doesn't seem to scale linearly with the number of cores.

Your approach (or the NUMA's) isn't wrong, in my opinion, it just
doesn't necessarily require to run in that context.

In an environment with isolated CPUs, we want the lowest latency
possible, that kind of work before switching to userspace imposes a
latency that could simply be elsewhere, even on another core since we
are doing remote accesses.
We are talking about 35us on a rather big system, not many applications
are sensitive to that kind of latency.

> I wonder why we'd want to piggy-back on call_rcu here when
> this has nothing to do with RCU. There is likely a characteristic
> of the call_rcu worker threads that we want to import into
> task_tick_mm_cid(), or change task_work.c to add a new flag
> that says the work can be dispatched to any CPU.
>=20

Alright, taking the RCU path was probably a bit lazy, another thought I
had was to run it in a workqueue, perhaps tied to the mm rather than to
the task struct itself. I'm also not entirely sure running it with the
scheduler tick is the best approach, since it doesn't seem quite
predictable, but I didn't really get the full requirements, so a
discussion on this can surely help.
=20
> > =C2=A0 void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
> > =C2=A0 {
> > - struct callback_head *work =3D &curr->cid_work;
> > + struct rcu_head *rhp =3D &curr->rcu;
>=20
> Why is it OK to re-use the task struct rcu field ? Where else is it
> used, and is there a risk of being inserted twice ?
>=20

The same approach is used in
https://elixir.bootlin.com/linux/v6.12/source/include/linux/sched/task.h#L1=
69
also there it was probably chosen for its simplicity and it isn't the
absolute best approach.
There may be a risk of messing things up, again this was the lazy path
and probably a more robust approach would work better.

Thanks for your comments.
Gabriele


