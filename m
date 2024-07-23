Return-Path: <linux-kernel+bounces-259960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A80993A07E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD411C21C32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26D7152504;
	Tue, 23 Jul 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVfI2FtL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE2C15098E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737704; cv=none; b=hCIUt1tc74Sz/3UFiqvOk7aR8V7ZKtrpIwsfg09qWKl57DtUnONS2iIMDj7wo0qtx4oenUQUdcutHjt1VC10u0pWVhzAKChZg+gLz8AUyogAEJoIaknoOQLHBEQh8xTJOx/Po5g7PLmnBRv++asja6TI185CqiUuVuXN/nd4BCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737704; c=relaxed/simple;
	bh=+OP+/ndJDII/1ayRoWz4iTLmBd3NkR1YyAKF8OhvSAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY/O3jLKBu5WjGFEoduRrhd2HLZxhAgyXyUbpyOnGhyTfl0erPSlFLCdKLugVwGgbs3UgpOecwH+w5ypAnkRCJUBtlGk3etL9/D5+ZNVBAP2U2rUBRdLyfg6c/261I1k1Vyfdqx7BIGlLcT83MHFxLVsQGnxa48Uzy0fKW2vZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVfI2FtL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721737701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s22VzHRAIIyGxM1MC7MpBdBMABP437dIk/ekhiiTtmM=;
	b=iVfI2FtLgToNRyeJZeMulyj4Q1t0lycRQKALMycfcqSHh2DRaLELRPXJ2aryEmWZu+XqDQ
	6LMRhTkIdsbsDs+z7fstfgbz43mDWXdbg5I6glOsuu2m6KjHeS/Yi8NMDik2JiQ/kcXN1S
	cwgtv4jnZIJPGF4erGETs3a6xx4XcD8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-wKDUPbUwO9SC1FhNFwXGAw-1; Tue, 23 Jul 2024 08:28:20 -0400
X-MC-Unique: wKDUPbUwO9SC1FhNFwXGAw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4466e46a93cso72668291cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721737699; x=1722342499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s22VzHRAIIyGxM1MC7MpBdBMABP437dIk/ekhiiTtmM=;
        b=r+HnMwAMbDGKKrygj/BccEuBdjyf3lMoanQps1NR47oxSVk+avtE4+yxMAXCLtaNOj
         UP9uwSkVjWoYcf+RkfQbdZKmjwHuAQEhgj6qp7XV/bhrTzjqX7RKzL6r0Vwtpul6pMHr
         i/AzpHgk4ps1CQ3n/V3eIAOuyqxga3Cn6xZLI6KwkcTH8WBKTB2e+cli0rCPLgiO7nUx
         qdpQWm2DsOV4V5jULULNEGLJbfZNDzFjCVToT2eTi665NVUHM0z85OwcXOWD4WcLP+p/
         fRD4Usl1DgayBPbj/W5l2JOoiyKqKcfoLBA64QcPMYP9CsFj40hF7msPniQNpyUaO9uA
         z27Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+qCKSFrDxGANMxhnZaTeEGkjLyd8R8wAUBIadPiJl9v0n/2OLX/dge7PPjGVzlykd5fk2Tbol1zWrJdb0C9RbG5jtlo+J0DXJ31K2
X-Gm-Message-State: AOJu0YxSa31A8XboC7Dp9a56iXAdy3eGYI/bWPLmXs2tnjxsRXJeV8tb
	nXnM2Uf4zAnSnHxV8N8vpCQeBug/ktdRJOMcGa7Nr87U9K5bbZHEH1A+LJcZ5C415TdddhMoWXj
	9XVruoFOBWDbdBjSo3eoTe5vT4ApgNKxpC7N6D5hQFfTB+poXB7+e09698kcLlfkKc3qYW/7iS/
	jfxsfpQRtOpg8n+mhMDNlur5T/gcRwVzSfBED9
X-Received: by 2002:ac8:58d3:0:b0:44f:8870:185f with SMTP id d75a77b69052e-44fc55a2fd0mr31224841cf.61.1721737699223;
        Tue, 23 Jul 2024 05:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElPggadun/vYrfy1t67bLcizkunGZ00byACDrIH3iQhE9dAQHC3FHrGwZvPan1S3vx4vhJe32woPulBhj0ZsY=
X-Received: by 2002:ac8:58d3:0:b0:44f:8870:185f with SMTP id
 d75a77b69052e-44fc55a2fd0mr31224591cf.61.1721737698908; Tue, 23 Jul 2024
 05:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722132935.14426-1-wander@redhat.com> <20240722132935.14426-2-wander@redhat.com>
 <Zp9uzXUwbJOpuwsv@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Zp9uzXUwbJOpuwsv@jlelli-thinkpadt14gen4.remote.csb>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 23 Jul 2024 09:28:07 -0300
Message-ID: <CAAq0SU=c7vCq0honu=GpvLY=sL3xQHZ2N_=TmB23P=d4OXBcBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/deadline: Fix warning in migrate_enable for
 boosted tasks
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 5:50=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com> =
wrote:
>
> Hi Wander,
>
> On 22/07/24 10:29, Wander Lairson Costa wrote:
> > When running the following command:
> >
> > while true; do
> >     stress-ng --cyclic 30 --timeout 30s --minimize --quiet
> > done
> >
> > a warning is eventually triggered:
> >
> > WARNING: CPU: 43 PID: 2848 at kernel/sched/deadline.c:794
> > setup_new_dl_entity+0x13e/0x180
> > ...
> > Call Trace:
> >  <TASK>
> >  ? show_trace_log_lvl+0x1c4/0x2df
> >  ? enqueue_dl_entity+0x631/0x6e0
> >  ? setup_new_dl_entity+0x13e/0x180
> >  ? __warn+0x7e/0xd0
> >  ? report_bug+0x11a/0x1a0
> >  ? handle_bug+0x3c/0x70
> >  ? exc_invalid_op+0x14/0x70
> >  ? asm_exc_invalid_op+0x16/0x20
> >  enqueue_dl_entity+0x631/0x6e0
> >  enqueue_task_dl+0x7d/0x120
> >  __do_set_cpus_allowed+0xe3/0x280
> >  __set_cpus_allowed_ptr_locked+0x140/0x1d0
> >  __set_cpus_allowed_ptr+0x54/0xa0
> >  migrate_enable+0x7e/0x150
> >  rt_spin_unlock+0x1c/0x90
> >  group_send_sig_info+0xf7/0x1a0
> >  ? kill_pid_info+0x1f/0x1d0
> >  kill_pid_info+0x78/0x1d0
> >  kill_proc_info+0x5b/0x110
> >  __x64_sys_kill+0x93/0xc0
> >  do_syscall_64+0x5c/0xf0
> >  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >  RIP: 0033:0x7f0dab31f92b
> >
> > This warning occurs because set_cpus_allowed dequeues and enqueues task=
s
> > with the ENQUEUE_RESTORE flag set. If the task is boosted, the warning
> > is triggered. A boosted task already had its parameters set by
> > rt_mutex_setprio, and a new call to setup_new_dl_entity is unnecessary,
> > hence the WARN_ON call.
> >
> > Check if we are requeueing a boosted task and avoid calling
> > setup_new_dl_entity if that's the case.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > Fixes: 2279f540ea7d ("sched/deadline: Fix priority inheritance with mul=
tiple scheduling classes")
>
> I believe your fix makes sense to me. I only wonder if however it
> actually fixes 295d6d5e37360 ("sched/deadline: Fix switching to
> -deadline") instead of the change you reference above?
>

That makes more sense, thanks.

> Thanks,
> Juri
>


