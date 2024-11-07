Return-Path: <linux-kernel+bounces-400225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E277F9C0A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF8228419E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A0E215F72;
	Thu,  7 Nov 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBr4HiER"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F30D215002
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995098; cv=none; b=R5okFHpBYyTDeupuiIclUzFe+GltzLH6A8+iqzpG0lVLItLFJ1QgObjXooJmmuiipgwMxs1zCXnt7WPv30OUD0G/CJ4pBxDhDRbsDbZHQnqLFtl0aimwuUqDNFV+sc2fnWBr3LGngGWN1XfGDKPoaPAsRos5tlMi+pFp6ibMZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995098; c=relaxed/simple;
	bh=jIjVkJg044mQRgN/mjP562pDQUc1UFF0ugcn7Rz7fwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pi+BRWYEupCBhDDyYQ8YDlqoZMzruRs3iSmNOEYNjxItt14buPU+zlRG/NEJU+8P/ADS4KdtE2cxpH8UknECIuhPrn+3kbpnu3Ztyta15nNx8L3tiHMWGuYp09l1rFtstuGgDUBA7hX5y10GPc1fJ1RbsjM1W/OmZEtLSNYftRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uBr4HiER; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso931414a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730995096; x=1731599896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jyTQmFg5RkUDePP5hgukMfc9dpeVcrhVZzNqZ7P2B9g=;
        b=uBr4HiER34sRVOWIFeESH6DSVanp/bP+1i/Jdk44nf0MLTDPhaTVKeOUNPgjFfUN4K
         QcpXj6EyubgYM6tDgIwIuJMOvsyd0z0ulwR2j+/5Xomod20Or9zcFd1RKc8Kq+XhVHSs
         0Z0o/yAV5eK0N2sntjdTMR2YC3PTJkS5MQYLz+Kp/LJzZECOGWcbJ8Bdr2IYeX5gUtdh
         Irq9eoCo8hSIwAbr8kdVjQTarw1SxztAQGIMoMJjk4W/6fF3RBZHezzkDCPQU+oOMkW4
         v+pQTSNk+oKPHbtn2z1nXy6WBJLZ9Ok4noFv4juuacaBcsOEeNHS5SiANU/AlNwaoL5M
         fwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995096; x=1731599896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyTQmFg5RkUDePP5hgukMfc9dpeVcrhVZzNqZ7P2B9g=;
        b=MsApepyyx4EoaoHqKaV5oj8xE1aDaD2q/F6wjA+uHqryApgvhpKdRwrkwZK6kO+1kE
         OxPXa4w6N6xAgm6tMXG7bAQfUDYRBv+WX6FTar/CpvmBf9GYc3BiGmdhB8Q/dsljsw5d
         bDmpaEInnlZ7zZ7r3DmM7OVEWRGZVdcbnnqdkWF9oSRaUzIftKYIkp4W4pHRyOVMEOyP
         iI6zvnqwEevp5vXbLxZ5o86zXibLbgtcuCOIv5HC+JytZNZzzpW67D5rlkLXiztlViHG
         SMQgIUIrQ6C4T2MrcFuVt0KW0WcEDbLg1KEXi0J5WFLzF3VT3zMN+Z1DKIyPLhPa9nfz
         jkKA==
X-Forwarded-Encrypted: i=1; AJvYcCUkz2A9Kxy/zz76hC32rF2MluoZ3fH36oQSd7mcxe59bjMaMU20XFp+tpweHW5w/xckKe6rKAD23em2Vbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqBV49F/1iBzVOMHHSHc9B/FP2Sa3s2dM7vnOUQpsENu9QHKdG
	5t+luqlwCaW59mUy9l5wgU9clmdEMqv0SkKSXBgDhcbl044BHZnZZqjUj1Fzz+oS4zVePI4UZY1
	3oj7JpBmo5gnLgeNVrQr/0bL98vm0XenxWNX5
X-Google-Smtp-Source: AGHT+IHqN3uYACDxM2VYg5XCMRDWpAJbWua707JHMABCl9IpwieImgrDtLWrInxY4nExvBH8dL/YaAXFhSy1Mz9c9+c=
X-Received: by 2002:a17:90b:4c86:b0:2e2:c40c:6e8e with SMTP id
 98e67ed59e1d1-2e8f11b961fmr46812604a91.34.1730995096225; Thu, 07 Nov 2024
 07:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107122648.2504368-1-elver@google.com> <5b7defe4-09db-491e-b2fb-3fb6379dc452@efficios.com>
 <CANpmjNPWLOfXBMYV0_Eon6NgKPyDorTxwS4b67ZKz7hyz5i13A@mail.gmail.com> <3326c8a1-36c7-476b-8afa-2957f5bd5426@efficios.com>
In-Reply-To: <3326c8a1-36c7-476b-8afa-2957f5bd5426@efficios.com>
From: Marco Elver <elver@google.com>
Date: Thu, 7 Nov 2024 16:57:39 +0100
Message-ID: <CANpmjNMjd6p5-SMjNh6k1gqubvNew2fA5GDs1YmcSdiSFCA5pQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 16:54, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-11-07 10:46, Marco Elver wrote:
> > On Thu, 7 Nov 2024 at 16:45, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> On 2024-11-07 07:25, Marco Elver wrote:
> >>> prctl() is a complex syscall which multiplexes its functionality based
> >>> on a large set of PR_* options. Currently we count 64 such options. The
> >>> return value of unknown options is -EINVAL, and doesn't distinguish from
> >>> known options that were passed invalid args that also return -EINVAL.
> >>>
> >>> To understand if programs are attempting to use prctl() options not yet
> >>> available on the running kernel, provide the task_prctl_unknown
> >>> tracepoint.
> >>>
> >>> Note, this tracepoint is in an unlikely cold path, and would therefore
> >>> be suitable for continuous monitoring (e.g. via perf_event_open).
> >>>
> >>> While the above is likely the simplest usecase, additionally this
> >>> tracepoint can help unlock some testing scenarios (where probing
> >>> sys_enter or sys_exit causes undesirable performance overheads):
> >>>
> >>>     a. unprivileged triggering of a test module: test modules may register a
> >>>        probe to be called back on task_prctl_unknown, and pick a very large
> >>>        unknown prctl() option upon which they perform a test function for an
> >>>        unprivileged user;
> >>>
> >>>     b. unprivileged triggering of an eBPF program function: similar
> >>>        as idea (a).
> >>>
> >>> Example trace_pipe output:
> >>>
> >>>     test-484     [000] .....   631.748104: task_prctl_unknown: comm=test option=1234 arg2=101 arg3=102 arg4=103 arg5=104
> >>>
> >>
> >> My concern is that we start adding tons of special-case
> >> tracepoints to the implementation of system calls which
> >> are redundant with the sys_enter/exit tracepoints.
> >>
> >> Why favor this approach rather than hooking on sys_enter/exit ?
> >
> > It's __extremely__ expensive when deployed at scale. See note in
> > commit description above.
>
> I suspect you base the overhead analysis on the x86-64 implementation
> of sys_enter/exit tracepoint and especially the overhead caused by
> the SYSCALL_WORK_SYSCALL_TRACEPOINT thread flag, am I correct ?
>
> If that is causing a too large overhead, we should investigate if
> those can be improved instead of adding tracepoints in the
> implementation of system calls.

Doing that may be generally useful, but even if you improve it
somehow, there's always some additional bit of work needed on
sys_enter/exit as soon as a tracepoint is attached. Even if that's
just a few cycles, it's too much (for me at least).

Also: if you just hook sys_enter/exit, you don't know if the prctl was
handled or not by inspecting the return code (-EINVAL). I want the
kernel to tell me if it handled the prctl() or not, and I also think
it's very bad design to copy-paste the prctl() option checking of the
running kernel in a sys_enter/exit hook. This doesn't scale in terms
of performance nor maintainability.

