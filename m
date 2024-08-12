Return-Path: <linux-kernel+bounces-283794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578B694F8BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE6FB2127C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514F186E37;
	Mon, 12 Aug 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OMRZMQzF"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041551581EB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496847; cv=none; b=iRmd+nrD9E0asAMU4jJgFR5+FsS/iDPnrD5sE64XFra6Vo6r34vX4oABzp3RvUL8eoqmdY4ZOJutXJswY/ZAqjd7zoI6No8dakcvsccTwm53iHaMMioVl6TE9IkeyCiu/TUholnjSE209KyHXP/xpI4MQV7RVHbM5HRgsShWOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496847; c=relaxed/simple;
	bh=CJnIpz+BT5KpvUhf82gHS8CYfDD2h7TWLoQzhvwsnoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGnXeRjkLAM9xC71KzdzJn3YpJ7Li1W/AYeZh9zDnrJ926K6TUHhOtuO5/JEb6MHLX286WumJPNrUXPlSM14yIUQDvlzSzEIItZ8zWtWhM5IuOE9LeO5ZlDaam16ABLENoMV7SCx/Bo8tVYxuujy/MsVKmHMWzm66FjV9bdEyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OMRZMQzF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so6600130e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723496842; x=1724101642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+M6sFpemSi2gVT65UI6JVGzP9ICp9Za4S0jkx11wVbg=;
        b=OMRZMQzFtInJGdF+PXxeiacbGJ/z95HdqVVP0a2d/c80cYFaabxg0kkTUPebnK+kGS
         6V99ztRfbcZROd55FOq0VR48szpx133m8kUys/z7ZFpUG+ut9PWGzp4a1SXUWdaVlb6z
         OnsLslpnjTPo9bXsIoO9/zHfaoGtrdeQfALv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723496842; x=1724101642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+M6sFpemSi2gVT65UI6JVGzP9ICp9Za4S0jkx11wVbg=;
        b=YBWOMAEk2sNKIcbSkzY0seYvYtBDbkCgjiC15Xn5MzQHi3qk5UzHoK1XOnv1XuVXkr
         00u2LcSWhX8I3f7cM22DA5ud+/al8I3XgA62Kh05pzmDfRvatLDnzemjpkZqWpcElnOU
         /TJc5fPNaEgsGF5ixywpKL/tYfPpV+QVMrX8ht+RADjMtvMPrE/Ko3ZCSTqPGdRcVEXD
         M0XvajwdDwJLFFvcrV/R2yUf4mIDOH5lynD3vzUtqnCHiSDkhDo5Ji2bg5fAlov5kkla
         ZbralL52JiQ8EYWmIWkVDG8l0mQxJd7CYdDbGJiNcVfrM9vN9QWToRgcFroycx9ZRMVq
         gcRw==
X-Forwarded-Encrypted: i=1; AJvYcCVYLih6BZ16hRekK1YzriyeG2IxQc3Sy4d8XavbDFIcOzakKRhRR5D3bt3Lv+a3EqBJaKorrh3ukXVR7U2ZyoLYeToWICkTelHOTa4T
X-Gm-Message-State: AOJu0Yx8U1Zyel5H2Pi9gwXF/K+osnqK03lxw1WSIz62oFVvrJWKhjVm
	IvlWw6xxA0igqz7H4LYirefgvp9jLneKQS8/jw6M7URpZZgmAC1B/klgXAYYHV6ou20SrvLtpWO
	LkYA=
X-Google-Smtp-Source: AGHT+IGtWgmPiV1bljeJoSA1NdU3Zoe285mrqkaudr+BEJV0weg+4J9Sb8y65iDicKrg4k53OHm6Fg==
X-Received: by 2002:a05:6512:23a5:b0:52c:deba:7e6e with SMTP id 2adb3069b0e04-5321365cbc8mr1088547e87.29.1723496841626;
        Mon, 12 Aug 2024 14:07:21 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414f078sm10055366b.154.2024.08.12.14.07.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 14:07:19 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so5652690a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:07:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWL0UtgEJKIANSX/YUcbpVq6uM6L0E3H+tYVWCXFaWImXgYFDPPeieFsxIdQO+JDeXou60e0m5P8SOicyHoCQuanNlBL9Q9WPYJJaj4
X-Received: by 2002:a05:6402:4406:b0:5b4:d025:b9f1 with SMTP id
 4fb4d7f45d1cf-5bd44c0e794mr1118723a12.6.1723496839459; Mon, 12 Aug 2024
 14:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com> <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com> <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com> <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
 <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com> <871q4td59k.fsf@oracle.com>
 <14d4584d-a087-4674-9e2b-810e96078b3a@linux.ibm.com> <87msn785f0.fsf@oracle.com>
 <87sewzkjy5.fsf@mail.lhotse> <e8efdade-161e-4efe-8bd3-abb12ad45dee@linux.ibm.com>
 <87sewr6o5w.fsf@oracle.com> <1a973dda-c79e-4d95-935b-e4b93eb077b8@linux.ibm.com>
In-Reply-To: <1a973dda-c79e-4d95-935b-e4b93eb077b8@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Aug 2024 14:07:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+VFeT7e04kMr7jhoKWb4iKgb1szb7BxXC_-M38_qAKw@mail.gmail.com>
Message-ID: <CAHk-=wi+VFeT7e04kMr7jhoKWb4iKgb1szb7BxXC_-M38_qAKw@mail.gmail.com>
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, tglx@linutronix.de, 
	peterz@infradead.org, paulmck@kernel.org, rostedt@goodmis.org, 
	mark.rutland@arm.com, juri.lelli@redhat.com, joel@joelfernandes.org, 
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, 
	LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Aug 2024 at 10:33, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> top 3 callstacks of __schedule collected with bpftrace.
>
>                         preempt=none                                                            preempt=full
>
>      __schedule+12                                                                  |@[
>      schedule+64                                                                    |    __schedule+12
>      interrupt_exit_user_prepare_main+600                                           |    preempt_schedule+84
>      interrupt_exit_user_prepare+88                                                 |    _raw_spin_unlock_irqrestore+124
>      interrupt_return_srr_user+8                                                    |    __wake_up_sync_key+108
> , hackbench]: 482228                                                               |    pipe_write+1772
> @[                                                                                 |    vfs_write+1052
>      __schedule+12                                                                  |    ksys_write+248
>      schedule+64                                                                    |    system_call_exception+296
>      pipe_write+1452                                                                |    system_call_vectored_common+348
>      vfs_write+940                                                                  |, hackbench]: 538591
>      ksys_write+248                                                                 |@[
>      system_call_exception+292                                                      |    __schedule+12
>      system_call_vectored_common+348                                                |    schedule+76
> , hackbench]: 1427161                                                              |    schedule_preempt_disabled+52
> @[                                                                                 |    __mutex_lock.constprop.0+1748
>      __schedule+12                                                                  |    pipe_write+132
>      schedule+64                                                                    |    vfs_write+1052
>      interrupt_exit_user_prepare_main+600                                           |    ksys_write+248
>      syscall_exit_prepare+336                                                       |    system_call_exception+296
>      system_call_vectored_common+360                                                |    system_call_vectored_common+348
> , hackbench]: 8151309                                                              |, hackbench]: 5388301
> @[                                                                                 |@[
>      __schedule+12                                                                  |    __schedule+12
>      schedule+64                                                                    |    schedule+76
>      pipe_read+1100                                                                 |    pipe_read+1100
>      vfs_read+716                                                                   |    vfs_read+716
>      ksys_read+252                                                                  |    ksys_read+252
>      system_call_exception+292                                                      |    system_call_exception+296
>      system_call_vectored_common+348                                                |    system_call_vectored_common+348
> , hackbench]: 18132753                                                             |, hackbench]: 64424110
>

So the pipe performance is very sensitive, partly because the pipe
overhead is normally very low.

So we've seen it in lots of benchmarks where the benchmark then gets
wildly different results depending on whether you get the goo "optimal
pattern".

And I think your "preempt=none" pattern is the one you really want,
where all the pipe IO scheduling is basically done at exactly the
(optimized) pipe points, ie where the writer blocks because there is
no room (if it's a throughput benchmark), and the reader blocks
because there is no data (for the ping-pong or pipe ring latency
benchmarks).

And then when you get that "perfect" behavior, you typically also get
the best performance when all readers and all writers are on the same
CPU, so you get no unnecessary cache ping-pong either.

And that's a *very* typical pipe benchmark, where there are no costs
to generating the pipe data and no costs involved with consuming it
(ie the actual data isn't really *used* by the benchmark).

In real (non-benchmark) loads, you typically want to spread the
consumer and producer apart on different CPUs, so that the real load
then uses multiple CPUs on the data. But the benchmark case - having
no real data load - likes the "stay on the same CPU" thing.

Your traces for "preempt=none" very much look like that "both reader
and writer sleep synchronously" case, which is the optimal benchmark
case.

And then with "preempt=full", you see that "oh damn, reader and writer
actually hit the pipe mutex contention, because they are presumably
running at the same time on different CPUs, and didn't get into that
nice serial synchronous pattern. So now you not only have that mutex
overhead (which doesn't exist in the reader and writer synchronize),
you also end up with the cost of cache misses *and* the cost of
scheduling on two different CPU's where both of them basically go into
idle while waiting for the other end.

I'm not convinced this is solvable, because it really is an effect
that comes from "benchmarking is doing something odd that we
*shouldn't* generally optimize for".

I also absolutely detest the pipe mutex - 99% of what it protects
should be using either just atomic cmpxchg or possibly a spinlock, and
that's actually what the "use pipes for events" code does. However,
the actual honest user read()/write() code needs to do user space
accesses, and so it wants a sleeping lock.

We could - and probably at some point should - split the pipe mutex
into two: one that protects the writer side, one that protects the
reader side. Then with the common situation of a single reader and a
single writer, the mutex would never be contended. Then the rendezvous
between that "one reader" and "one writer" would be done using
atomics.

But it would be more complex, and it's already complicated by the
whole "you can also use pipes for atomic messaging for watch-queues".

Anyeway, preempt=none has always excelled at certain things. This is
one of them.

               Linus

