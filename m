Return-Path: <linux-kernel+bounces-561588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B6A613C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69C93A49DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676C1FF7C9;
	Fri, 14 Mar 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnEzAhrB"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340F20124E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963015; cv=none; b=fj7D21q6BytSJsJfkUOthPQhTvY9JIuDqKp1TjRapL1cRJjvamckYidESJzzbOCChXUNdEMlxQmu+3UHUXHEmAS7Z+3+0JaLJpg+U3mOs7c38FnwXDJBMepLXZRWwAE3mPxowut7ZAgF6hIndmMq+nvvaoCbwaBCND3o9Rlz3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963015; c=relaxed/simple;
	bh=wZ10FQLiuwkYwLwWirtPVn+8nOyCMaXVYeh3W4gjkh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSgmkVTERfNP2qt50WIe6ZtH3oE94u6gVnhhAcYiYco7lnyzeif3L/WfNxDfK/j1/5pdnsUosJg9qS8j+ABoqymu5H55LIcZYmDwWsh/BOMnbvAatRRh9qdyIuwVNJXTUpaXx7yP3jeeFkNe0xio9/b9acAWQYtSRoU0j1LONlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnEzAhrB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso3608042a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741963011; x=1742567811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTsoWnhVuQdLexLEfuDRY1NuPB1h020VB1UaRMkV2fU=;
        b=JnEzAhrBPHPs2OmJ+RVoD4iIy91zisSa7fXlO4wUUt/QQ8dOS1960NoCn0ItVazbtA
         mpQuJxvudu4YvOfLPG4YznrQLgivPJ/BBtn+2u+aCmu3AibLPZONXu93OId85q4u5Pnq
         wppzhXqIKTEFFgRT7tANHsUH21feqbbCp14diR77UjwpvqxgzZ8a9x8K5s/a9qJJEws6
         jmu5qhK/kMEKGt626vY6JMb+VbI0fUMC7xXAhsmXK4pxox37PAVpljPThqLn4uVd/p+u
         0KeRbrkjyJiarZituxJqFh2AiQbT80b5vMbK3CHx/CliuHoGk3KjPD01indcHGETEoZf
         +2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963011; x=1742567811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTsoWnhVuQdLexLEfuDRY1NuPB1h020VB1UaRMkV2fU=;
        b=cO6l9+RTBKzN8N/s3uiQbbSsMisPAXGxdWQibFJXcxfYiwWmCZv001qz+6nHLun/MY
         vQzuhydShSHg3bNukXpD4eAv1UpUhXE4UK9hfLHc3+dU2aXppVozxvCbYPco5oYM0py2
         nffU7CyLeM7QWdAJOLLdPHXP0GKqEqF13wILZ8MfLH2geNk0I3oxm2iV/qOpYVQF2pr/
         RpRSnFk7+CRqaphGNR763rRnZPr5rLAmsFnPV36eUB63RI4GkMKiESGxll9bal7uoZ2E
         60DqXKpjtgCMB3sP95+sYQu6qTRW++hJVhBGOfeRjflsvNSTvMt1lBy9TQJN4+piPHOc
         7/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4hJuZl30ZokbOrdsih4mCdNoemXSMGkJ/LtcsDqNqrzanufoYS5tncmww2TV8H7hJVvo6GFGEGFVja5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZqHuHyMe9E4biv6R4LEnp5n4VTkJMNOzeF0a4bjfFqV9C+As3
	J+MkegLy5TMSRixXnEE3SG/j1zIgcynU0cmRhdnVBQYjqH29Cepn+9jMQO0NzR0vJCA+ktCLYDL
	4APxoOXhvC+/Kl9ersR9o5FcbvKY=
X-Gm-Gg: ASbGncuoLV6I44HwUyzaUttRMTiBhInrEzOFW3Rgt/bpNU8I3z05GafHiyr6N2QVMu4
	uWSvKhhtoNhJSRdw3rqX/kpuNXPS33KZdb0BRS5zSfdfk1SYUOrEKFEj2dTKl5IuFeq3BlXws+b
	3fUS1/0dP8ZPfcnf3TDCUSiFIgUNO0cWcgDNIP+Pc=
X-Google-Smtp-Source: AGHT+IG/QkhIdFRFPRjqDFgoOcJvYt3NC4eKV4Cc2inTyo06DN2YJgD9yow6x8AtJwOOBYD340MwPGeEK1scuiX+978=
X-Received: by 2002:a05:6402:13d0:b0:5de:aa54:dc30 with SMTP id
 4fb4d7f45d1cf-5e89ea8ecc1mr2963450a12.5.1741963009544; Fri, 14 Mar 2025
 07:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314142839.24910-1-ioworker0@gmail.com>
In-Reply-To: <20250314142839.24910-1-ioworker0@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 14 Mar 2025 22:36:11 +0800
X-Gm-Features: AQ5f1JrxgQaDkcQJqDKq-MD7cjwskNjGxe3qpTnlDh15iJHKwK_Pk6GnkyZ7_cM
Message-ID: <CAK1f24nbxP2csK=yU=umVbKHUgjWiEVaeaJ_7Yk1NtgKu21NOg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hung_task: extend blocking task stacktrace dump to semaphore
To: akpm@linux-foundation.org
Cc: will@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	longman@redhat.com, mhiramat@kernel.org, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, joel.granados@kernel.org, kent.overstreet@linux.dev, 
	leonylgao@tencent.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, amaindex@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oops, I got the version wrong and will resend the new one right away.

Thanks,
Lance

On Fri, Mar 14, 2025 at 10:29=E2=80=AFPM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> Hi all,
>
> Inspired by mutex blocker tracking[1], this patch series extend the
> feature to not only dump the blocker task holding a mutex but also to
> support semaphores. Unlike mutexes, semaphores lack explicit ownership
> tracking, making it challenging to identify the root cause of hangs. To
> address this, we introduce a last_holder field to the semaphore structure=
,
> which is updated when a task successfully calls down() and cleared during
> up().
>
> The assumption is that if a task is blocked on a semaphore, the holders
> must not have released it. While this does not guarantee that the last
> holder is one of the current blockers, it likely provides a practical hin=
t
> for diagnosing semaphore-related stalls.
>
> With this change, the hung task detector can now show blocker task's info
> like below:
>
> [Thu Mar 13 15:18:38 2025] INFO: task cat:1803 blocked for more than 122 =
seconds.
> [Thu Mar 13 15:18:38 2025]       Tainted: G           OE      6.14.0-rc3+=
 #14
> [Thu Mar 13 15:18:38 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_s=
ecs" disables this message.
> [Thu Mar 13 15:18:38 2025] task:cat             state:D stack:0     pid:1=
803  tgid:1803  ppid:1057   task_flags:0x400000 flags:0x00000004
> [Thu Mar 13 15:18:38 2025] Call trace:
> [Thu Mar 13 15:18:38 2025]  __switch_to+0x1ec/0x380 (T)
> [Thu Mar 13 15:18:38 2025]  __schedule+0xc30/0x44f8
> [Thu Mar 13 15:18:38 2025]  schedule+0xb8/0x3b0
> [Thu Mar 13 15:18:38 2025]  schedule_timeout+0x1d0/0x208
> [Thu Mar 13 15:18:38 2025]  __down_common+0x2d4/0x6f8
> [Thu Mar 13 15:18:38 2025]  __down+0x24/0x50
> [Thu Mar 13 15:18:38 2025]  down+0xd0/0x140
> [Thu Mar 13 15:18:38 2025]  read_dummy+0x3c/0xa0 [hung_task_sem]
> [Thu Mar 13 15:18:38 2025]  full_proxy_read+0xfc/0x1d0
> [Thu Mar 13 15:18:38 2025]  vfs_read+0x1a0/0x858
> [Thu Mar 13 15:18:38 2025]  ksys_read+0x100/0x220
> [Thu Mar 13 15:18:38 2025]  __arm64_sys_read+0x78/0xc8
> [Thu Mar 13 15:18:38 2025]  invoke_syscall+0xd8/0x278
> [Thu Mar 13 15:18:38 2025]  el0_svc_common.constprop.0+0xb8/0x298
> [Thu Mar 13 15:18:38 2025]  do_el0_svc+0x4c/0x88
> [Thu Mar 13 15:18:38 2025]  el0_svc+0x44/0x108
> [Thu Mar 13 15:18:38 2025]  el0t_64_sync_handler+0x134/0x160
> [Thu Mar 13 15:18:38 2025]  el0t_64_sync+0x1b8/0x1c0
> [Thu Mar 13 15:18:38 2025] INFO: task cat:1803 blocked on a semaphore lik=
ely last held by task cat:1802
> [Thu Mar 13 15:18:38 2025] task:cat             state:S stack:0     pid:1=
802  tgid:1802  ppid:1057   task_flags:0x400000 flags:0x00000004
> [Thu Mar 13 15:18:38 2025] Call trace:
> [Thu Mar 13 15:18:38 2025]  __switch_to+0x1ec/0x380 (T)
> [Thu Mar 13 15:18:38 2025]  __schedule+0xc30/0x44f8
> [Thu Mar 13 15:18:38 2025]  schedule+0xb8/0x3b0
> [Thu Mar 13 15:18:38 2025]  schedule_timeout+0xf4/0x208
> [Thu Mar 13 15:18:38 2025]  msleep_interruptible+0x70/0x130
> [Thu Mar 13 15:18:38 2025]  read_dummy+0x48/0xa0 [hung_task_sem]
> [Thu Mar 13 15:18:38 2025]  full_proxy_read+0xfc/0x1d0
> [Thu Mar 13 15:18:38 2025]  vfs_read+0x1a0/0x858
> [Thu Mar 13 15:18:38 2025]  ksys_read+0x100/0x220
> [Thu Mar 13 15:18:38 2025]  __arm64_sys_read+0x78/0xc8
> [Thu Mar 13 15:18:38 2025]  invoke_syscall+0xd8/0x278
> [Thu Mar 13 15:18:38 2025]  el0_svc_common.constprop.0+0xb8/0x298
> [Thu Mar 13 15:18:38 2025]  do_el0_svc+0x4c/0x88
> [Thu Mar 13 15:18:38 2025]  el0_svc+0x44/0x108
> [Thu Mar 13 15:18:38 2025]  el0t_64_sync_handler+0x134/0x160
> [Thu Mar 13 15:18:38 2025]  el0t_64_sync+0x1b8/0x1c0
>
> [1] https://lore.kernel.org/all/174046694331.2194069.15472952050240807469=
.stgit@mhiramat.tok.corp.google.com
>
> Thanks,
> Lance
>
> ---
> v1 -> v2:
>  * Use one field to store the blocker as only one is active at a time,
>  suggested by Masami
>  * Leverage the LSB of the blocker field to reduce memory footprint,
>  suggested by Masami
>  * Add a hung_task detector semaphore blocking test sample code
>  * https://lore.kernel.org/all/20250301055102.88746-1-ioworker0@gmail.com
>
> Lance Yang (2):
>   hung_task: replace blocker_mutex with encoded blocker
>   hung_task: show the blocker task if the task is hung on semaphore
>
> Zi Li (1):
>   samples: add hung_task detector semaphore blocking sample
>
>  include/linux/hung_task.h               | 94 +++++++++++++++++++++++++
>  include/linux/sched.h                   |  2 +-
>  include/linux/semaphore.h               | 15 +++-
>  kernel/hung_task.c                      | 52 +++++++++++---
>  kernel/locking/mutex.c                  |  8 ++-
>  kernel/locking/semaphore.c              | 55 +++++++++++++--
>  samples/Kconfig                         | 11 +--
>  samples/hung_task/Makefile              |  3 +-
>  samples/hung_task/hung_task_mutex.c     | 20 ++++--
>  samples/hung_task/hung_task_semaphore.c | 74 +++++++++++++++++++
>  10 files changed, 301 insertions(+), 33 deletions(-)
>  create mode 100644 include/linux/hung_task.h
>  create mode 100644 samples/hung_task/hung_task_semaphore.c
>
> --
> 2.45.2
>

