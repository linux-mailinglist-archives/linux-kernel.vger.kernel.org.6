Return-Path: <linux-kernel+bounces-521624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F54A3C019
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F2116DB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D461E25EB;
	Wed, 19 Feb 2025 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsdPe0Md"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91F20B22
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972046; cv=none; b=Ofcl21MqaIVkGn9ba8+ep/dNUjD9WR4jN5PdlmqCks9Ko4WNkEBWA3/ZOUAYtwWMD+6adSkmn5mS5Al5QJn/xxwsk7jGyTA2yg+aGJaa2SVUnyX3pPVVn7nLNTo8lSzTFIPUYqmpNTBk42Wm77UvoYSBA3kwbdKmzbNwTtDjShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972046; c=relaxed/simple;
	bh=bJ+SblaJIrZ/jpRcuFYwxFjU+vJvItX4AdxNBOHgeA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4R+PIb6c9lSXMjJkYAIPXHfQ/8Xpdrrjc0nhYSl5Mts/fS36iw9iurGXna2qEJDcwnR4bTH4emxEiWWuPhcZedzUy8y/xfBOXYOnUsOK5YCY0WTDBmfLPfOm+cx+AGGX6aDcHj0mRJOCV0GVGMtZJoM/Pb6DE715qQKEwRv06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsdPe0Md; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso8895886a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739972043; x=1740576843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25REnXQLxgZn05Nqwdk7rSgxrWQCeKo0uID/S1aXIUY=;
        b=bsdPe0MdRY9baSz3ry/tkfC5Z6Z4mcCxijzYWZbwa1T7lUm+kla+7FPL/zhDz0PlES
         7urwdQfmVGr4ToLNiyVEquf1HOohx0ROmVPwH1ghqeAbp08TCGVxuiGOdPvETKqZk6yS
         +DIRVc6jYkWi6xm5Q6rU3bAvRmMBrOC3MKm3FMY6lXVngxG8+IEuNQkNjWn+fgsJCHJi
         jK5dRW9s7IkpzsEo2GGJAkwvTXK7eT2+yMNcXcJV265gaCTfpyVO755qvU3YV+swxh7N
         bf1nlmyljcVYpHodmUfQYfzJeCp2e2VE0cpjiVEbN/gslOQW9BhNkR4eSYnGUE3wcBut
         PWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972043; x=1740576843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25REnXQLxgZn05Nqwdk7rSgxrWQCeKo0uID/S1aXIUY=;
        b=Fh+FtozabzHaTYL23xQ+7S6EUsI/p70vJJvEpgws7Jnb0o3AzowuHUwyXZWMn/RS0P
         bCdxMvHJTToYV/3EKcAf3/CIvc3tumMtxZ7+pLX7VIQFmPOyY8LXzqUoWevYkMIXCVJq
         tVIWSJBb+BW4nXsU/BwnldOOoKmMA92tjv5jFAQD0c+imr4p7QbJhjBNp5TmHpMfNhMj
         BXfjk7YnHBINKQQpydsWYmkxAazq32b1tvmX0sRDTpVW8YBIKydwmEMRK6iUBahh2Ep8
         kWfjRdOcVpbYalOZu60Uh+ppjngsh4Q/tWyr5AjVKT8eIiho0wU9TpvIl63DUj/MJTn8
         /vQA==
X-Forwarded-Encrypted: i=1; AJvYcCVpozD5sjgBQVwZ4bMy6DaBrM8qiN4wLrktx4QINYLVmvN+jxlq/Zb1pn7tWjvvo68TTu9qNkh5oL+Srqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCh3mJ8ZqBF9M1SplxFdKpOSc4eeCnm8ftRgxmx32c0jXXdmf
	rIM3/lbMQljmAq8qcBbcPbg0mZngvjISvewEqUPdwCh1bXyXemKk3zl+8ZFGY/I2wn4H//QLFQx
	3ELMjGdrbgm7FFy503kYUeoDrShw=
X-Gm-Gg: ASbGnct61tf64hU7Yja2zWdy2nSwuZnS6/nJMzNvPiQIpwLn4gReau4n2+hzuePbTMA
	ChvicHnNlxZfbc61YojTlmZFhSab5ksA7e7+Akut3BoFjMQGrJN7Jn3JPpGtyEVf5FG/hIYWp
X-Google-Smtp-Source: AGHT+IHOusADMstgVk/7CL7pb+x/4cTH/2aIvBkQyTGGtQrOgnoTh3jlohJ13hFDLOOohFvbSBzVzXjhmHPe5OEwsRk=
X-Received: by 2002:a05:6402:5244:b0:5e0:7ff3:20c with SMTP id
 4fb4d7f45d1cf-5e0895248ebmr3346441a12.17.1739972043037; Wed, 19 Feb 2025
 05:34:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
In-Reply-To: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 19 Feb 2025 21:33:26 +0800
X-Gm-Features: AWEUYZlHThszyuGsJB_bdNtLWfXi6Mc4cFvllrrOIEFuOJKhgJa6EbXlQ-qZC2w
Message-ID: <CAK1f24knkxX34hNLRjT20mjyyOwasmXgXJBbTDX=7WYwiw9S1g@mail.gmail.com>
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

CC linux-mm

On Wed, Feb 19, 2025 at 9:00=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Hi,
>
> The hung_task detector is very useful for detecting the lockup.
> However, since it only dumps the blocked (uninterruptible sleep)
> processes, it is not enough to identify the root cause of that
> lockup.
>
> For example, if a process holds a mutex and sleep an event in
> interruptible state long time, the other processes will wait on
> the mutex in uninterruptible state. In this case, the waiter
> processes are dumped, but the blocker process is not shown
> because it is sleep in interruptible state.
>
> This adds a feature to dump the blocker task which holds a mutex
> when detecting a hung task. e.g.
>
>  INFO: task cat:113 blocked for more than 122 seconds.
>        Not tainted 6.14.0-rc3-00002-g6afe972e1b9b #152
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
>  task:cat             state:D stack:13432 pid:113   tgid:113   ppid:103  =
  task_flags:0x400100 flags:0x00000002
>  Call Trace:
>   <TASK>
>   __schedule+0x731/0x960
>   ? schedule_preempt_disabled+0x54/0xa0
>   schedule+0xb7/0x140
>   ? __mutex_lock+0x51d/0xa50
>   ? __mutex_lock+0x51d/0xa50
>   schedule_preempt_disabled+0x54/0xa0
>   __mutex_lock+0x51d/0xa50
>   ? current_time+0x3a/0x120
>   read_dummy+0x23/0x70
>   full_proxy_read+0x6a/0xc0
>   vfs_read+0xc2/0x340
>   ? __pfx_direct_file_splice_eof+0x10/0x10
>   ? do_sendfile+0x1bd/0x2e0
>   ksys_read+0x76/0xe0
>   do_syscall_64+0xe3/0x1c0
>   ? exc_page_fault+0xa9/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x4840cd
>  RSP: 002b:00007ffe632b76c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>  RDX: 0000000000001000 RSI: 00007ffe632b7710 RDI: 0000000000000003
>  RBP: 00007ffe632b7710 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>  R13: 000000003a8b63a0 R14: 0000000000000001 R15: ffffffffffffffff
>   </TASK>
>  INFO: task cat:113 is blocked on a mutex owned by task cat:112.
>  task:cat             state:S stack:13432 pid:112   tgid:112   ppid:103  =
  task_flags:0x400100 flags:0x00000002
>  Call Trace:
>   <TASK>
>   __schedule+0x731/0x960
>   ? schedule_timeout+0xa8/0x120
>   schedule+0xb7/0x140
>   schedule_timeout+0xa8/0x120
>   ? __pfx_process_timeout+0x10/0x10
>   msleep_interruptible+0x3e/0x60
>   read_dummy+0x2d/0x70
>   full_proxy_read+0x6a/0xc0
>   vfs_read+0xc2/0x340
>   ? __pfx_direct_file_splice_eof+0x10/0x10
>   ? do_sendfile+0x1bd/0x2e0
>   ksys_read+0x76/0xe0
>   do_syscall_64+0xe3/0x1c0
>   ? exc_page_fault+0xa9/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x4840cd
>  RSP: 002b:00007ffd69513748 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>  RDX: 0000000000001000 RSI: 00007ffd69513790 RDI: 0000000000000003
>  RBP: 00007ffd69513790 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>  R13: 0000000029d8d3a0 R14: 0000000000000001 R15: ffffffffffffffff
>   </TASK>
>
> Thank you,
>
> ---
>
> Masami Hiramatsu (Google) (2):
>       hung_task: Show the blocker task if the task is hung on mutex
>       samples: Add hung_task detector mutex blocking sample
>
>
>  kernel/hung_task.c                  |   38 ++++++++++++++++++++
>  kernel/locking/mutex-debug.c        |    1 +
>  kernel/locking/mutex.c              |    9 +++++
>  kernel/locking/mutex.h              |    6 +++
>  samples/Kconfig                     |    9 +++++
>  samples/Makefile                    |    1 +
>  samples/hung_task/Makefile          |    2 +
>  samples/hung_task/hung_task_mutex.c |   66 +++++++++++++++++++++++++++++=
++++++
>  8 files changed, 132 insertions(+)
>  create mode 100644 samples/hung_task/Makefile
>  create mode 100644 samples/hung_task/hung_task_mutex.c
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

