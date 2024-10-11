Return-Path: <linux-kernel+bounces-360401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3DE999A66
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA431C252E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB9D1F12F7;
	Fri, 11 Oct 2024 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rf2XeMYb"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7031EABB1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613600; cv=none; b=V726JjrNGCCDZYLO1Z6HSCY6yI+8/GFV5+l/sPmxE0KJbVbCu8XadVp8ZnO8gb+Vry+EmOZsFhNyeAn8l2a8YwkLk1GlbMlH2q3H7oxsOZFN4AwqwHQCHKRPtiJW9XPinOkdMaOVBVz7/4vgg7pYnXkHnS4SKEQjmrYdeo/aS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613600; c=relaxed/simple;
	bh=bXFzW1w7mdEoWVhagiHK0K42usNayawQHKf6ERbzP7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfq4as/DsxenPow2REyQGlZxS2kizThRyr3RZ2iKudetdcbpLKZqwuTz1tdcXeN3QBjDzMxOZpd1nFuiNtcs8pQFZjkrkS0BX5FF/Ka6nexiHGTHA507tKetoyrx1C6mUOUsH6w7eknnlKiHHo422MfD3z+uGM3v3a34glvEUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rf2XeMYb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso1905386a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728613597; x=1729218397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmBNwyCk2xUo0dWjZO7vAeuW0mF+ii13+PqCrb1hp3k=;
        b=Rf2XeMYbAAofGUWsxYzwCj+xROPiKmhNMLyI/McyKLpjW2yeI18bhsaAPuNtYD657Q
         7qLzqtm775vbNVy7X0+PsNEf/8s71UW9lASiqEuQZKj8+M/zy4IcuHj+ONRjCCrTusfU
         PL+ehquVhQgWl7AEnBgEJMj9ESkfZMSR88MNIw/nMNMLY8g6wON2e9mA0I+56yaXaQWP
         owFyIBk6YU+rSD+x/Xnc9nVY9rQziZO/A/nfltQLRcJvev7nt0/EE72Wjg4eOgJ/SbP8
         Y/h2gInRcpR9ezpQV+dL3qBf0gRncC8GKOcTgJ6wzLOxlM7NF+E4ilOE0lbBQqaqMtU9
         kPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613597; x=1729218397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmBNwyCk2xUo0dWjZO7vAeuW0mF+ii13+PqCrb1hp3k=;
        b=ubI1zSR2NOeoJ16f5gqnjfvMjdluJxqbHmgClb1ZJfR4QX02hMB8sxdmdKJaxoQ4GC
         1dcNOsLVaGUG4bWvDePFkQHXfuG4vfDwRAp217rt1PSoIDh6afdUEZs8iIV3hm/AcYrv
         hZwJYaALypG4MUdW1qNajVH6wNvTkMgJDBmH242H32YMpguuZjhvoJtVUHh2XCVucyrb
         Kd5hpUF2DFJOAXIXkN8CoMm7aU/IdTrRhCifC3fo4689Kyd5FTRmi7royZb6Uv7QP99X
         Uh765Ck+XHgl0SmX8oYIQS0cWv1MwFFXcoG6s1Fe8Ht3lBNU2xhki3OC+SdCfRe4DvvT
         vnbA==
X-Gm-Message-State: AOJu0YwQmkRWb209EK4FLkn0XXckfKsns2VK07VigvGlCdI2oxo29j5N
	8TENrzbYn6Z/aOVovPOkJtacy4WsEOYYO3Eh1k1vOJPEDumWYkoY5GoEi/eArHNX4Qekwco+JfM
	rS46eM/BSRmAxo8X7DbpbaST0ldAt5c0aivQ=
X-Google-Smtp-Source: AGHT+IHvVhdvbN/W5KnJFzNgIlev9P9ytassvBo+39QRtbrStxHAUyEgNXgVC/k/LxICvAV3n95z1yTfmmeIKs2EwFs=
X-Received: by 2002:a17:907:368b:b0:a99:4d67:eac1 with SMTP id
 a640c23a62f3a-a99b96cfeb0mr63217566b.52.1728613596415; Thu, 10 Oct 2024
 19:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009235352.1614323-1-jstultz@google.com> <20241009235352.1614323-3-jstultz@google.com>
 <20241010100045.321ca4de@gandalf.local.home>
In-Reply-To: <20241010100045.321ca4de@gandalf.local.home>
From: John Stultz <jstultz@google.com>
Date: Thu, 10 Oct 2024 19:26:24 -0700
Message-ID: <CANDhNCof4=mP9NBonXK9vSvxwbMN6gF9xUxqWgsVAE=Kj+F90w@mail.gmail.com>
Subject: Re: [RESEND x3][PATCH v12 2/7] locking/mutex: Make mutex::wait_lock
 irq safe
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 7:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> On Wed,  9 Oct 2024 16:53:35 -0700
> John Stultz <jstultz@google.com> wrote:
>
> > From: Juri Lelli <juri.lelli@redhat.com>
> >
> > mutex::wait_lock might be nested under rq->lock.
> >
> > Make it irq safe then.
>
> Can you expand on this please?
>
> If the mutex:wait_lock might be taken under an rq->lock, doesn't that mea=
n
> a mutex was taken under rq->lock? Or is it something internal?
>
> This change log needs to be more explicit.

Sure! Would the following work for you?

"With the proxy-execution series, we traverse the task->mutex->task
blocked_on/owner chain in the scheduler core. We do this while holding
the rq::lock to keep the structures in place while taking and
releasing the alternating lock types.

Since the mutex::wait_lock is one of the locks we will take in this
way under the rq::lock in the scheduler core, we need to make sure
that its usage elsewhere is irq safe."

?

Thanks for the feedback!
-john

