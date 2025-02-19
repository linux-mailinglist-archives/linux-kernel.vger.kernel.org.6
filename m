Return-Path: <linux-kernel+bounces-521836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE91A3C2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D791891805
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B388E1F3BB5;
	Wed, 19 Feb 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiWDqtCH"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE31E8335
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977364; cv=none; b=EUbdxlIMiYQxREwJOOkwu/Ca0AiN+SzuIksJhmfwPuEjyLnb5pLXHRZXQLS3xNoAzEPR34oRX6LI+kHkDNNSnC3UrmyL473r2sJDcfEJGAVnVA4ncFW16Me6SvIkPBUj6mL0caYrNDFmgaqWlAihnz3BdSPzOiXDRjNPqlueUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977364; c=relaxed/simple;
	bh=RCSNSrVTe/dIu2bGRH3kYV2UOZDaKXu3GBeWw3Uyyz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL9SWQALAujtjNDz4lsCsO1GXfnfNamT7a63YLKilpqtM8KpmR59Dl/r7Csu5uPA0HU2O5nPLCdLax3MbaNqQ4alRe9Z/4zewgJwNbk67wMf5AD4MN3zdb7VPAZkfSe4AC9zYXIz+YZqpmit6Qp3+CdvD6PeQhFQcUUKM9KP0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiWDqtCH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so9245057a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739977360; x=1740582160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZHxmk9Ox5llPkI9w3/SQ5aztAbCrTpqRs4EJf1BNlA=;
        b=YiWDqtCHfIyEX5aWrUlCkIixCx4eONZ+HslRwbrKeICmWVxA/M8ONQCi1UwvXeJeJB
         QV2b4dpNM3bEAgFE4YVUgzlpxmmozXjGiWZ3YpwUlwVTd7Al6lnYLb+VQ2LlvBwLZmre
         onf5N+TI42UPCbcxCENuYUNbIO0PAkbpQBh8Xcn+J3OToVApdSvi8Da5SjvYjNHxfy9x
         0ZkzIEL0V6pan5D2gw6eyI+ffp8pAJjgymdcDRfkfEC9r61rUUcdJEiEwVF/9b+MtPiX
         88PhgJlwCm7IPgSI6bT1xjA8gZWFNsQZHXhkJM0mk3i7L5i4SaSwMJo/P12sIaMHnuU3
         6g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977360; x=1740582160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZHxmk9Ox5llPkI9w3/SQ5aztAbCrTpqRs4EJf1BNlA=;
        b=FyAfUwT+XoxpXELbIOGJtgVsqAHIsJ5ImtYgVuxVl6UxFIThjDXe58RRdhnq4PjogT
         mLRXqC/OaInz2kM0BMObuVKUCWGLH5u73NPS8V+NM7hwABSsgVIo3EbSCKp91zfBI1iq
         20OPWpMDe3PmTI3PHfFPaU9h74iK89ZRWnbeuccM4Ceo1qOHu9uipy/vqfjsBxdZ6+yZ
         7tJIAGMpZLf63J0QVArI5eUa2ONrXF7BkhfIK/oR7hu/GshjEinjvtO/CvBCYiNAvgZI
         GlOJ/32atpd+RYO8W8FoHn0kPMOpIwFGsDu3XSFCX4ZPLaV1h/AhOpEKYTecbXDcVWON
         pArg==
X-Forwarded-Encrypted: i=1; AJvYcCWJOnYday2nP0DawYix6sXMNuxsO7ss7WVkLgfELXibMM62/PCOadvYa33OKwer+YmRBzuh24xI/WglgcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVGgwH72HNFis16hdcWgVX1DAh0fJMP2ZBkDjIPkQcwKEWDPy
	luWB21shKfjjleyNhV1IHqfyF9nx+bgOb19UE0qilAZHedmIGHR0WTZ33VsFD3GZtjE2aXjCGcP
	SwNHvu+U6EOZ1pNgveYHZuYCqbrs=
X-Gm-Gg: ASbGnctLw7D1tHSdoMxKAj6XPmArdlRai0NWq4W5JwYYNqOgUuWX5KMpkUpuE4C2tUc
	QhDQ6zPtDpWCJsBHnWKRDz//9y2XQeFMDadiIk5l+PMiUaHeOdaTmZlvSD/LLr3F5NVi895zD
X-Google-Smtp-Source: AGHT+IHq4IO2JlnOqG7659shJfdrV3OkM/TNkV5y/AM1wIU+x9ko/zSrRY+nfZq394aLcLTbFpCDw4LEKK3G94anSiI=
X-Received: by 2002:a05:6402:26cd:b0:5e0:6770:2b6a with SMTP id
 4fb4d7f45d1cf-5e089d316demr3345670a12.23.1739977358654; Wed, 19 Feb 2025
 07:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <CAK1f24knkxX34hNLRjT20mjyyOwasmXgXJBbTDX=7WYwiw9S1g@mail.gmail.com>
In-Reply-To: <CAK1f24knkxX34hNLRjT20mjyyOwasmXgXJBbTDX=7WYwiw9S1g@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 19 Feb 2025 23:02:01 +0800
X-Gm-Features: AWEUYZkdZAHl4TKYpUipGVKNVSOrlB6SVRk-Qdb4IJkgGdtuOP47nBGCQssv9Xw
Message-ID: <CAK1f24m-Ci3BvgfVYGW2tFSUEkPwiO9=0M_w4kpOt1qViiDXdg@mail.gmail.com>
Subject: Re: [PATCH 0/2] hung_task: Dump the blocking task stacktrace
To: mhiramat@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 9:33=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> CC linux-mm
>
> On Wed, Feb 19, 2025 at 9:00=E2=80=AFPM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > Hi,
> >
> > The hung_task detector is very useful for detecting the lockup.
> > However, since it only dumps the blocked (uninterruptible sleep)
> > processes, it is not enough to identify the root cause of that
> > lockup.
> >
> > For example, if a process holds a mutex and sleep an event in
> > interruptible state long time, the other processes will wait on
> > the mutex in uninterruptible state. In this case, the waiter
> > processes are dumped, but the blocker process is not shown
> > because it is sleep in interruptible state.

Cool! I just ran into something similar today, but with rwsem. In that
case, the blocked process was locked up, and we could not identify
the root cause either ;(

Thanks,
Lance

> >
> > This adds a feature to dump the blocker task which holds a mutex
> > when detecting a hung task. e.g.
> >
> >  INFO: task cat:113 blocked for more than 122 seconds.
> >        Not tainted 6.14.0-rc3-00002-g6afe972e1b9b #152
> >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messa=
ge.
> >  task:cat             state:D stack:13432 pid:113   tgid:113   ppid:103=
    task_flags:0x400100 flags:0x00000002
> >  Call Trace:
> >   <TASK>
> >   __schedule+0x731/0x960
> >   ? schedule_preempt_disabled+0x54/0xa0
> >   schedule+0xb7/0x140
> >   ? __mutex_lock+0x51d/0xa50
> >   ? __mutex_lock+0x51d/0xa50
> >   schedule_preempt_disabled+0x54/0xa0
> >   __mutex_lock+0x51d/0xa50
> >   ? current_time+0x3a/0x120
> >   read_dummy+0x23/0x70
> >   full_proxy_read+0x6a/0xc0
> >   vfs_read+0xc2/0x340
> >   ? __pfx_direct_file_splice_eof+0x10/0x10
> >   ? do_sendfile+0x1bd/0x2e0
> >   ksys_read+0x76/0xe0
> >   do_syscall_64+0xe3/0x1c0
> >   ? exc_page_fault+0xa9/0x1d0
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >  RIP: 0033:0x4840cd
> >  RSP: 002b:00007ffe632b76c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> >  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
> >  RDX: 0000000000001000 RSI: 00007ffe632b7710 RDI: 0000000000000003
> >  RBP: 00007ffe632b7710 R08: 0000000000000000 R09: 0000000000000000
> >  R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
> >  R13: 000000003a8b63a0 R14: 0000000000000001 R15: ffffffffffffffff
> >   </TASK>
> >  INFO: task cat:113 is blocked on a mutex owned by task cat:112.
> >  task:cat             state:S stack:13432 pid:112   tgid:112   ppid:103=
    task_flags:0x400100 flags:0x00000002
> >  Call Trace:
> >   <TASK>
> >   __schedule+0x731/0x960
> >   ? schedule_timeout+0xa8/0x120
> >   schedule+0xb7/0x140
> >   schedule_timeout+0xa8/0x120
> >   ? __pfx_process_timeout+0x10/0x10
> >   msleep_interruptible+0x3e/0x60
> >   read_dummy+0x2d/0x70
> >   full_proxy_read+0x6a/0xc0
> >   vfs_read+0xc2/0x340
> >   ? __pfx_direct_file_splice_eof+0x10/0x10
> >   ? do_sendfile+0x1bd/0x2e0
> >   ksys_read+0x76/0xe0
> >   do_syscall_64+0xe3/0x1c0
> >   ? exc_page_fault+0xa9/0x1d0
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >  RIP: 0033:0x4840cd
> >  RSP: 002b:00007ffd69513748 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> >  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
> >  RDX: 0000000000001000 RSI: 00007ffd69513790 RDI: 0000000000000003
> >  RBP: 00007ffd69513790 R08: 0000000000000000 R09: 0000000000000000
> >  R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
> >  R13: 0000000029d8d3a0 R14: 0000000000000001 R15: ffffffffffffffff
> >   </TASK>
> >
> > Thank you,
> >
> > ---
> >
> > Masami Hiramatsu (Google) (2):
> >       hung_task: Show the blocker task if the task is hung on mutex
> >       samples: Add hung_task detector mutex blocking sample
> >
> >
> >  kernel/hung_task.c                  |   38 ++++++++++++++++++++
> >  kernel/locking/mutex-debug.c        |    1 +
> >  kernel/locking/mutex.c              |    9 +++++
> >  kernel/locking/mutex.h              |    6 +++
> >  samples/Kconfig                     |    9 +++++
> >  samples/Makefile                    |    1 +
> >  samples/hung_task/Makefile          |    2 +
> >  samples/hung_task/hung_task_mutex.c |   66 +++++++++++++++++++++++++++=
++++++++
> >  8 files changed, 132 insertions(+)
> >  create mode 100644 samples/hung_task/Makefile
> >  create mode 100644 samples/hung_task/hung_task_mutex.c
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>

