Return-Path: <linux-kernel+bounces-410608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE29CDDF8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F001F2257A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6156F1BA89B;
	Fri, 15 Nov 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+63SvC5"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA366F30F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731672039; cv=none; b=YpgbsCLaQNRbqAG5nK4SYOeaJtvI38qq/f3JFk6MaWRmMV2C5V4oMfBK4UhABBhbONXEDEbSxTZWkTurpkdYPiprUpvVWa8/IuccUG+t8Pmujw2P9AZLGMdIGiXHOJ/yxmYmAT9XuIlr+K3f5g9f0haW3d9u9EnGNN5vI3lLrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731672039; c=relaxed/simple;
	bh=sbMgTAqFvmxiYPh86rMErvrguzcYNGOlX+IRUbTYogA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkfK7cTXzG9vywJd3zXTa4Sldi3dYF1ZKD126RWygcGIZY4rrPlE0MAB+Sgj3fJpMdHv72hWyZd+q3viLYyN/blcjii37uXfdM9Jvc1E+PVPIgla62Z6bGm0fF8YuTha0uEkTXUAXF5XXIdRsFQb/icirRkH3XJVktJ4VXdcecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+63SvC5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ea12c1c78dso798524a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731672037; x=1732276837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KlGdhGP6WA+spFDXddhwm5CPfAlGC4n5EQHyhAQX98w=;
        b=0+63SvC5BVDJuFygHHnNYbBI8mSYUhO8z/ZVji9x4xJN5ZjVQaVEOVW6/NukiwFoeR
         0L2+jUpva0gCLHwRHiF9aNjtZ8+d3dOjgaXqjwv00oFuSvUmrhvS4Fh4V6XvkNFn4QT3
         TyGqEl4HoncVyEBbMLtVl9C8w1d/5n8sHSlp7/p3znqJyW7BDqm8QCkqidonmYsjuZ5l
         yuM22nXvU3jIda67v2mYZvCQhQ7XWKL42/ZmdZaVt8saMM+mrLNimXTDs27jV45AkcIn
         8fnMu0PSQtwsFf6sb8HVL84yV1BX03gYCeVIiVqmNUH+lBZ2aVAPl9OI/tMLwbkBtyEb
         EA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731672037; x=1732276837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlGdhGP6WA+spFDXddhwm5CPfAlGC4n5EQHyhAQX98w=;
        b=wcYqxuV1Qc8YVgm8kQYQeooHJgOvs3Xlx7TLcWxzJw82nVZkFCSwfd2pK0gqXIOSG+
         bDPOfzWoDY9e/LySfx95ga6WK9J/8Mb4e7A2mxAWkV9InP87brwVKMO1yq5hJDLWhMVo
         c0WPvFgNozpZXhWcKSe4tfMVZ5ZRXb1uoyt2UJCUn5JsDTF5fnVK+PdukIuO4UPtxB8V
         KTvwhg1+Rb8B0NYX3LXBKAL+zLucJqIosKdHDbBkUerh5OmjWCMHNH304bxauBeJwMMK
         T9oBjpmDnpvA11+clbAcIeCO6JyE3CIqz2QyEC6oOA7W7vx5keZjtbKuS2CvLRnqzPYa
         e+mg==
X-Forwarded-Encrypted: i=1; AJvYcCX3k+S/QzvebS/VBWy0EKE3TzGvMe0+hbEYWA+FhsODr4eGB3ICbMO79LmkyRPPgM3zB0az5YUicKJreBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvreYK7x2uWJdn7URGR9NVgsSJBGeOnYMsPLP+nV4IpVz2Dhu
	gmmm5HKXN+A/uWRYGdue/uqC2wleU12DrNp2iHQ7ezaKAk8La/lqfhZehCZOrWAzV1o3yv6bzkq
	1+j1zImpwvs8rx0LXXdompWEHmrSDT6zhsiU+
X-Google-Smtp-Source: AGHT+IFq3++1lZ1u+PsFkUT+yHYiMJdy6mGF08BRpddoq6EZ39JutGG0PVhugLD3EvpUzEig3CDK3bMB+TRRJ3Uatno=
X-Received: by 2002:a17:90b:3a81:b0:2d8:e7db:9996 with SMTP id
 98e67ed59e1d1-2ea154f9cabmr2767715a91.13.1731672037347; Fri, 15 Nov 2024
 04:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108113455.2924361-1-elver@google.com>
In-Reply-To: <20241108113455.2924361-1-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Fri, 15 Nov 2024 13:00:00 +0100
Message-ID: <CANpmjNPuXxa3=SDZ_0uQ+ez2Tis96C2B-nE4NJSvCs4LBjjQgA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tracing: Add task_prctl_unknown tracepoint
To: elver@google.com, Steven Rostedt <rostedt@goodmis.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 12:35, Marco Elver <elver@google.com> wrote:
>
> prctl() is a complex syscall which multiplexes its functionality based
> on a large set of PR_* options. Currently we count 64 such options. The
> return value of unknown options is -EINVAL, and doesn't distinguish from
> known options that were passed invalid args that also return -EINVAL.
>
> To understand if programs are attempting to use prctl() options not yet
> available on the running kernel, provide the task_prctl_unknown
> tracepoint.
>
> Note, this tracepoint is in an unlikely cold path, and would therefore
> be suitable for continuous monitoring (e.g. via perf_event_open).
>
> While the above is likely the simplest usecase, additionally this
> tracepoint can help unlock some testing scenarios (where probing
> sys_enter or sys_exit causes undesirable performance overheads):
>
>   a. unprivileged triggering of a test module: test modules may register a
>      probe to be called back on task_prctl_unknown, and pick a very large
>      unknown prctl() option upon which they perform a test function for an
>      unprivileged user;
>
>   b. unprivileged triggering of an eBPF program function: similar
>      as idea (a).
>
> Example trace_pipe output:
>
>   test-380     [001] .....    78.142904: task_prctl_unknown: option=1234 arg2=101 arg3=102 arg4=103 arg5=104
>
> Signed-off-by: Marco Elver <elver@google.com>

Steven, unless there are any further objections, would you be able to
take this through the tracing tree?

Many thanks!

> ---
> v3:
> * Remove "comm".
>
> v2:
> * Remove "pid" in trace output (suggested by Steven).
> ---
>  include/trace/events/task.h | 37 +++++++++++++++++++++++++++++++++++++
>  kernel/sys.c                |  3 +++
>  2 files changed, 40 insertions(+)
>
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 47b527464d1a..209d315852fb 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -56,6 +56,43 @@ TRACE_EVENT(task_rename,
>                 __entry->newcomm, __entry->oom_score_adj)
>  );
>
> +/**
> + * task_prctl_unknown - called on unknown prctl() option
> + * @option:    option passed
> + * @arg2:      arg2 passed
> + * @arg3:      arg3 passed
> + * @arg4:      arg4 passed
> + * @arg5:      arg5 passed
> + *
> + * Called on an unknown prctl() option.
> + */
> +TRACE_EVENT(task_prctl_unknown,
> +
> +       TP_PROTO(int option, unsigned long arg2, unsigned long arg3,
> +                unsigned long arg4, unsigned long arg5),
> +
> +       TP_ARGS(option, arg2, arg3, arg4, arg5),
> +
> +       TP_STRUCT__entry(
> +               __field(        int,            option)
> +               __field(        unsigned long,  arg2)
> +               __field(        unsigned long,  arg3)
> +               __field(        unsigned long,  arg4)
> +               __field(        unsigned long,  arg5)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->option = option;
> +               __entry->arg2 = arg2;
> +               __entry->arg3 = arg3;
> +               __entry->arg4 = arg4;
> +               __entry->arg5 = arg5;
> +       ),
> +
> +       TP_printk("option=%d arg2=%ld arg3=%ld arg4=%ld arg5=%ld",
> +                 __entry->option, __entry->arg2, __entry->arg3, __entry->arg4, __entry->arg5)
> +);
> +
>  #endif
>
>  /* This part must be outside protection */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 4da31f28fda8..b366cef102ec 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -75,6 +75,8 @@
>  #include <asm/io.h>
>  #include <asm/unistd.h>
>
> +#include <trace/events/task.h>
> +
>  #include "uid16.h"
>
>  #ifndef SET_UNALIGN_CTL
> @@ -2785,6 +2787,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>                 error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
>                 break;
>         default:
> +               trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
>                 error = -EINVAL;
>                 break;
>         }
> --
> 2.47.0.277.g8800431eea-goog
>

