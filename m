Return-Path: <linux-kernel+bounces-400207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DAA9C0A55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FAD1F23714
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC5213ECF;
	Thu,  7 Nov 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0+1tC2u"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A8212D07
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994446; cv=none; b=qCTVEPcEvhWzeOYrYCfsKJRAuog+RSj8GzWDHZI0WL0jJXY39461ZLo9/mQfCXmOvRQcOO/ml6A7CI9eOsCwojNNHnsfMOVepwyVze5IT+o5Lbp6DzkR0OTDfMDGUAWwBVEfCBhL98e0wy014SoWnSrUyc4C4TWTDffZRRXeElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994446; c=relaxed/simple;
	bh=4f6dWXhqteDG7Pwy9unlS3L0BaYoHx7yfFzKwlcDl3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LF76OHzRTEKloNszShd4/tDhEleEpnuLveJQOF8wHCqoNEYSoA0n0nHvb0b8TVAo9yTB4pVB72BKX0Q58s84vV7P0JvM1bJTgbNKpcNSLHZ35tWspQoa/54OlAHac4vxw+ALkUFzXW3ho0eJ5nl7fksqtZKBtwGGD3Jt30tuaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0+1tC2u; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8de14848so849369a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730994444; x=1731599244; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TKCS6QZhEemyijFYjDdqN6Pf7qMYs//016N4dS3FzLY=;
        b=D0+1tC2uWdCslGWbVlr5zDODWVd2ZPAcFz/51+S5tAWH1c8J19fYizUjTd8ODJtk9O
         CjlVPtyI/E2FdObz4MQL3KJZMs1wc2kyWpSHzbDi69ix+YuBGOZwqHLP2ELcF5XKQBRr
         pwdbN6qLwOn6uN9nNZjqd9tiroI6B3WrS92g5htSD8/dDazcbGS4+J1DvqoZAWUrWZEF
         XBL+8sX5U2jftP2l89woxFUQmZ/o3uBQgrbBwRpgv2MlTauhkFWS2D9XMNPUH6bPPFoK
         NNv26od4E37HoGo087sSx4Z1FvkDBexYk5leg/lO7WaRIgQsIyR/97BEZzYDd68Cm+oU
         rsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730994444; x=1731599244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKCS6QZhEemyijFYjDdqN6Pf7qMYs//016N4dS3FzLY=;
        b=woHOC1qKWAfeGmqSkokOD3lPGYKUbAbanErw07IdvKrWiBUBGQgfIL+E7M7v2mbo4U
         lcedSWLrIB6tFGrNiH94m7104uELMFAW0t+PSI76HaDOtKXIo9BicULkszJ+fgoqdeGf
         /3oW3HbI5ix1F2kTblOjdETQKHQPEq1wYwsyWXDq/LHAZn6EUMx5C5++xfQhvOd/Sd+J
         aAMUpYzUQmofBPV4Vxxr4Gtu/TKEFyTmlCZtgyWjxNKXPCndzNQGDmI3ZS+5RorIwf0w
         80E9aoP++XdQiqnT3hJ2ioL0bfr0Q4R0NcqWF2Lduv5aq9R2TdwvdZf0aD8//+fV9Fp1
         Cgbw==
X-Forwarded-Encrypted: i=1; AJvYcCW5kAl4usLVPmvLKuBzBgGhJpdz/BdpyKCf3Zt9/0z3JTXPndSNaR3I+xbSFdO6Eez9eaz/DElqBRbYgpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy8Cwt0bD4xWtGMKXzCjZf+nnvBlXf30jodjXfj4J1mWdj9EyO
	d832ACSojNPT4Ll/wBk9lp7BbzSCtq7N7/E0Mz8rgschd1stu8lhz3p8wxTB7gPs/9MJIqKC71X
	1Krim3H5eGmZArfF6WhbT/UcVX9LSqPaoQlWp
X-Google-Smtp-Source: AGHT+IHL/Pu3IK7QBStLEnKMlA44dgXA5l7l4UgA7xdutsuutLuPjHCkRaO3pUEYzmtnVgtkCeAoHI3GvHdVjFVOKTE=
X-Received: by 2002:a17:90a:e7cb:b0:2e2:d239:84be with SMTP id
 98e67ed59e1d1-2e9afbd3c7cmr532113a91.5.1730994444041; Thu, 07 Nov 2024
 07:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107122648.2504368-1-elver@google.com> <5b7defe4-09db-491e-b2fb-3fb6379dc452@efficios.com>
In-Reply-To: <5b7defe4-09db-491e-b2fb-3fb6379dc452@efficios.com>
From: Marco Elver <elver@google.com>
Date: Thu, 7 Nov 2024 16:46:47 +0100
Message-ID: <CANpmjNPWLOfXBMYV0_Eon6NgKPyDorTxwS4b67ZKz7hyz5i13A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 16:45, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-11-07 07:25, Marco Elver wrote:
> > prctl() is a complex syscall which multiplexes its functionality based
> > on a large set of PR_* options. Currently we count 64 such options. The
> > return value of unknown options is -EINVAL, and doesn't distinguish from
> > known options that were passed invalid args that also return -EINVAL.
> >
> > To understand if programs are attempting to use prctl() options not yet
> > available on the running kernel, provide the task_prctl_unknown
> > tracepoint.
> >
> > Note, this tracepoint is in an unlikely cold path, and would therefore
> > be suitable for continuous monitoring (e.g. via perf_event_open).
> >
> > While the above is likely the simplest usecase, additionally this
> > tracepoint can help unlock some testing scenarios (where probing
> > sys_enter or sys_exit causes undesirable performance overheads):
> >
> >    a. unprivileged triggering of a test module: test modules may register a
> >       probe to be called back on task_prctl_unknown, and pick a very large
> >       unknown prctl() option upon which they perform a test function for an
> >       unprivileged user;
> >
> >    b. unprivileged triggering of an eBPF program function: similar
> >       as idea (a).
> >
> > Example trace_pipe output:
> >
> >    test-484     [000] .....   631.748104: task_prctl_unknown: comm=test option=1234 arg2=101 arg3=102 arg4=103 arg5=104
> >
>
> My concern is that we start adding tons of special-case
> tracepoints to the implementation of system calls which
> are redundant with the sys_enter/exit tracepoints.
>
> Why favor this approach rather than hooking on sys_enter/exit ?

It's __extremely__ expensive when deployed at scale. See note in
commit description above.

