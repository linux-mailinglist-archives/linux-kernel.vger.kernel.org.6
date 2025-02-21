Return-Path: <linux-kernel+bounces-525078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B9FA3EA83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA0016E013
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E9B1C8FB5;
	Fri, 21 Feb 2025 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0AtTq4l"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B9149C4D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103469; cv=none; b=c8LL0JbLS4v81jCcvjVZ7lzrjdXPYwYXVmGYmnzAhojSZyX/8ErDETctCoIf0IlRRuOPdAyQxUjNGXsh4QNHYhvglHxiUHj3VjdXV6MFs6TGp4rb+ecwOgXY8B7A67fOzSd3Wnk+SQToIEKvW4cStEhUk/M7/6nxT2PTB2ZWMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103469; c=relaxed/simple;
	bh=N1yHkd6WcyNSVQbGsYczlSizRGhxXsmcqx1x0a+rzi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEDhL2p/1GCq+LA/vs3zsOOOCdQlfLAxXF7ygrNIGVQb4BkhIJbHb9jYQjmJro3xxOIPp5fiDiQ+QQlXsyKANv4fpjc+d7LxR0FLs7DXGaTxBhSoeXaThpIvQl7g32P1GiWRO8LyPm4bYErDer5IZNCeadQTCOIPlU8IP8P433A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0AtTq4l; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471fa3b19bcso130501cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740103466; x=1740708266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1yHkd6WcyNSVQbGsYczlSizRGhxXsmcqx1x0a+rzi4=;
        b=t0AtTq4lP9LfsczerQW+Epu5wAdRGMYG1ySqYNNl+06+XEn0v3khTxj5MITbA6fR5X
         Rc4Ifi6gdvnKUz0PnNNUu2g7j8H3N0keBDMLLNXUxY/acRDiL/ea5UAiacluGMLn7pAu
         L5wHJftJtoyUyrooZa19/8UnT4FCRz593jTVWjdyxw7mXpMthSFNPd2EOamE9PDjEjOC
         E5mx/Cvk88mmItf1HIF8e8adi5AfQbep5d4uwI+yg7AjXFtrNcRycjfbanJawbKtKZZ/
         G56suRtSU4enfWMvrVg9nZo1nzD2lkfMQ53myx0R5AbYlKi/q5swnSTQYwP/zNmfEIc4
         hepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740103466; x=1740708266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1yHkd6WcyNSVQbGsYczlSizRGhxXsmcqx1x0a+rzi4=;
        b=kNP5Fnb7bLVdAzQTm6r0TKAf5QB88jhDwervjodPVVmoLUjUdhJMNGQTKSVwpFQBZ/
         0GbfsgMupIRAv4StW6dCdDQj/qxgrEKv22ntnJbOdr0kdQq1kwc9vbI9jCyU7mhzQ9TY
         PG+3qRy1acm5u0MU1MqLIP7VGx25eQmS1ZfBeGZtCZS1HZ2oaLtSMqM5kmiV0cu1SU5I
         WfZofeAFvg+OhvCoounh5/MHIRuhTqRfCBGHZacfRkEXq0mfrkzy6LRUwNJWnAXhcjy9
         PknoxRdL0s5FAAxSr8gHkfEteuCxcDLd779jM4WNYfwR8tLEFaSfRgSzTRlaH89VC3C8
         mQCw==
X-Forwarded-Encrypted: i=1; AJvYcCVSdWhpRUxCgZPXHdzrWMJUfECOqxR62xEjQ9eTUn383qahDbwu312nP+d33QxzMVobIyZmqoQucbRtDMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBK4dZhCv3DwSyEEkMEEfX9f2CJTCA+ntLDk/SyzeGkW8VDBS
	7P78ewwk5H1ekJNvzkPlk99OKKMjYt9AVkZUrjelc6KhXZtH4W/+5l5Bc3jTFtWxLghp9yM1v9r
	/M94Wk8B/IQC+y4qKSQLmx98jd2OCBPwO4yeL
X-Gm-Gg: ASbGncvKXZt8RJx2HQJmUFUa+Q29PvKJBNwCiv2LZZRbksBuAQOAkxeOwq2mcT9D8ph
	FzB8yDGzZIkKbUli5dI4e2IRzGCVRm/vIbii2D1Ga/B3lmDTUufCwEub88y7EpUN6kiLK/ZKeHw
	MbPDPVci7W
X-Google-Smtp-Source: AGHT+IFShkeKNa7hBQxM8WJImL27ya3TaFWjy9t41mcSCg8PXCJXsgBgjYpdo+tD3SDjLtFIoBf92VZ9oD1/FNTlZj0=
X-Received: by 2002:ac8:5a10:0:b0:471:9ece:b13b with SMTP id
 d75a77b69052e-47225043af1mr904521cf.1.1740103466046; Thu, 20 Feb 2025
 18:04:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220093257.9380-1-kprateek.nayak@amd.com> <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com> <20250220113227.GL34567@noisy.programming.kicks-ass.net>
 <59d46dd3-33da-4e95-8674-d93fc00d73f6@amd.com>
In-Reply-To: <59d46dd3-33da-4e95-8674-d93fc00d73f6@amd.com>
From: Josh Don <joshdon@google.com>
Date: Thu, 20 Feb 2025 18:04:14 -0800
X-Gm-Features: AWEUYZkezBZ_8B7pnQOk5D6fE9Yi15jahsKLRimXrfXwGO-40LmlcMoAEdkjKjc
Message-ID: <CABk29NuQZZsg+YYYyGh79Txkc=q6f8KUfKf8W8czB=ys=nPd=A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ben Segall <bsegall@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Barret Rhoden <brho@google.com>, 
	Petr Mladek <pmladek@suse.com>, Qais Yousef <qyousef@layalina.io>, 
	"Paul E. McKenney" <paulmck@kernel.org>, David Vernet <dvernet@meta.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:04=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> Hello Peter,
>
> On 2/20/2025 5:02 PM, Peter Zijlstra wrote:
> > On Thu, Feb 20, 2025 at 04:48:58PM +0530, K Prateek Nayak wrote:
> >> Any and all feedback is appreciated :)
> >
> > Pfff.. I hate it all :-)
> >
> > So the dequeue approach puts the pain on the people actually using the
> > bandwidth crud, while this 'some extra accounting' crap has *everybody*
> > pay for this nonsense, right?

Doing the context tracking could also provide benefit beyond CFS
bandwidth. As an example, we often see a pattern where a thread
acquires one mutex, then sleeps on trying to take a second mutex. When
the thread eventually is woken due to the second mutex now being
available, the thread now needs to wait to get back on cpu, which can
take an arbitrary amount of time depending on where it landed in the
tree, its weight, etc. Other threads trying to acquire that first
mutex now experience priority inversion as they must wait for the
original thread to get back on cpu and release the mutex. Re-using the
same context tracking, we could prioritize execution of threads in
kernel critical sections, even if they aren't the fair next choice.

If that isn't convincing enough, we could certainly throw another
kconfig or boot param for this behavior :)

> Is the expectation that these deployments have to be managed more
> smartly if we move to a per-task throttling model? Else it is just
> hard lockup by a thousand tasks.

+1, I don't see the per-task throttling being able to scale here.

> If Ben or Josh can comment on any scalability issues they might have
> seen on their deployment and any learning they have drawn from them
> since LPC'24, it would be great. Any stats on number of tasks that
> get throttled at one go would also be helpful.

Maybe just to emphasize that we continue to see the same type of
slowness; throttle/unthrottle when traversing a large cgroup
sub-hierarchy is still an issue for us and we're working on sending a
patch to ideally break this up to do the updates more lazily, as
described at LPC.

In particular, throttle/unthrottle (whether it be on a group basis or
a per-task basis) is a loop that is subject to a lot of cache misses.

Best,
Josh

