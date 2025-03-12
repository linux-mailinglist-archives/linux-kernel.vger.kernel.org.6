Return-Path: <linux-kernel+bounces-557932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC936A5DF77
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F23F3B0216
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29959245001;
	Wed, 12 Mar 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SE97OIjm"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89086358
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791117; cv=none; b=aVKhliH4SiM1/fjvq4W+QRhAYXAnikSFIwA2yNYt34Zv0p61f2Wah/UjYtRfeHl2XB807/LzcyfrCdBUlAXo+kqFefjAPZrOasQgK4CX8b2sSYOq9jl+jxtw9E06qsAHiearOvM2Wi8j30pENcKaIdUzVCBqrihGnPTAgmZFWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791117; c=relaxed/simple;
	bh=OFNcx1rFjTYUiFWazM1XPXSs49ger27uc8bpPEi56T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqA6cCkdm86ldt6/iArqGWW425734oNyBlIU61sBsYEhczkidcM5eEX8f5MEa0+/VEi1HVlj/vEYX47MhBWqK38trQexc1L5bKpk/Ilrp02eATKcOApscJCp77OJTBzwowdV3CluhTBOWShPVL/mMYXU/dWorQuD7cxPhoI4us0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SE97OIjm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso409135966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741791113; x=1742395913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqHa64yZqCN0DuB9FJOk79wf31KR/9+DD1L+8ldk5uU=;
        b=SE97OIjmw/HHM806tTBeRnkhqKZsJzyC96L/fU9mwzAGQXwVfOjk3Modbn61vdKRNd
         zS4GXz7iYoTxZZJ6aESMzPpddLhF3t+iDNv6qbQL+loEdCQ1CILZXHkH8kVqiw+4wfeH
         69wF63Gxc4jO4PvKd/adgUDonLc0lWhCZqDuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741791113; x=1742395913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqHa64yZqCN0DuB9FJOk79wf31KR/9+DD1L+8ldk5uU=;
        b=F5kRhcF4+RA2NapBW67ZDMEP2u/2KZB3a6ygxWZyAtyNwlv3Ilk3Jix8Y4lINt5+3S
         FeEYvMTdW0LUVzK5SFUdTXYB13SzwILlO9YJMzAk1p30sGKmL7UKwWayzwh4WGR9QD3T
         SzuPptCtijsUG0ydmnSbZaGeMHidhPvcSMmuBbkybsNoJyzFS4q20tEV9EtLlMwkeIXI
         7DEpyedkp+A+73RqujE5QKPUNH2JuzY4hPMmNb+etwq6FZKpa3zxNWWN8kDW99S0SYET
         VxGOP1Gm7CDtv9/kJuYzn3+Z8MdcJuKzMdgYMtWrPG9sj8NQmqb0vvJpEziaKBwj9NH0
         i4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWu6QJtj1HJ0X+8BzxBRhEA8zPtX34m/Lqh98Y1fim8m5wCGbZFHKIEDeggcmejFv1nWd1PYxythERHd3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVHknqRzkLNtViR1ZKiE9nrVHUf6G/nC8kq0m+o60SqTKHIefN
	FbLoxN3qkBrEWp1zTtH5o41lfUvkMiGhpSnJnTJgadPFlNxuiT4QMEzNtLdQOMt+qrjeCkcCikZ
	h6A==
X-Gm-Gg: ASbGncv9aHlvjXscRgGNTrgyF1kqTp3b6MBpLMOYjbAfFDOtmpKjfyksos9AElp8sI3
	ZdQTvnkVXk4+3pdR/9Jt5QYPzPxJU0o6Li2mDQ3cBXBzcj0Oy7l+0jR3sngX5tVZyQJxhdrm3PF
	JBLHWrb2TPuztHDwPfFASvfhumQRNgCvMJtHe6NkgjjnFPhOzSpxF8RSuJZr+LxCBRrCP3yOyz+
	xp3SoGHhjTO2f2Sth15knAxlO2F0cO6Tm2K53MDbw6h11MW2tsua4lnQ7s7+mh+Go6IftpYQH8U
	QUnEiSvudM54du9iLRZ3VU+sM+cKvMFu6LbVR6KwclNvkdpMqU5Yu4cBwR80DHzowJ8UIF8Mmg6
	jGvze
X-Google-Smtp-Source: AGHT+IFJ2iyFir03V3EU9Os94bWohiXCC9m7bt/9tfjNCUQriosPsEOhEo79Up+mpP+ff8itkXFITQ==
X-Received: by 2002:a17:907:8690:b0:abf:425d:5d3 with SMTP id a640c23a62f3a-ac2b9ea192dmr1140513166b.40.1741791113262;
        Wed, 12 Mar 2025 07:51:53 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653cdfsm637767666b.82.2025.03.12.07.51.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 07:51:51 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso10686a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:51:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLyBkbEtZKg7W+PHylw83+J7t60avrbp/L5a/V/5O0OuymRCxFjRX72C3jamEjys+DYcXzwJfL9hxII2o=@vger.kernel.org
X-Received: by 2002:a50:d65c:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5e7bf56542dmr96067a12.7.1741791110392; Wed, 12 Mar 2025
 07:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <miliiyxmqko6hx66yhdv4nkkopbm73wbz6kxxlzpts53mscqzy@dpfa6y3wnspv>
In-Reply-To: <miliiyxmqko6hx66yhdv4nkkopbm73wbz6kxxlzpts53mscqzy@dpfa6y3wnspv>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 12 Mar 2025 23:51:33 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AYA=7rQjdQ4AS1vjb0Z3zHec6bdbhrA2cW706DHZyhKg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr2eaLs2O2EC-uwC0uoIEp4UXUfcQom0TbaZauvbtu2eBYdwulBQ7VOLVA
Message-ID: <CAAFQd5AYA=7rQjdQ4AS1vjb0Z3zHec6bdbhrA2cW706DHZyhKg@mail.gmail.com>
Subject: Re: [RFC] sched: add sched_show_task() variant that accepts log level
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Mon, Mar 10, 2025 at 5:25=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi,
>
> A request for comments, not a formal patch.
>
> Is there any reason why hung-task watchdog prints error header
> with KERN_ERR log level while task's backtrace is printed with
> KERN_INFO?  Will it make sense to unify log levels and introduce
> sched_show_task() variant that accept log level param so that
> everything that hung-task watchdog prints becomes KERN_ERR?

Thanks a lot for looking into this.

Let me just add that I've been looking into ways to automatically
analyze kernel crash reports and I noticed that when I filter out
KERN_INFO and higher log levels, I end up losing useful information
for hung-task watchdog-kind of problems. This change would greatly
help in filtering out unnecessary noise from the logs.

By the way, if having it as KERN_INFO by default would still be
desirable, I suppose we could add a KConfig option to set the desired
log level?

Best regards,
Tomasz

>
> Something like this:
>
> ---
>  include/linux/sched/debug.h |  1 +
>  kernel/hung_task.c          |  4 ++--
>  kernel/sched/core.c         | 19 +++++++++++++------
>  3 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
> index b5035afa2396..8e46854d16fc 100644
> --- a/include/linux/sched/debug.h
> +++ b/include/linux/sched/debug.h
> @@ -34,6 +34,7 @@ extern void show_stack(struct task_struct *task, unsign=
ed long *sp,
>                        const char *loglvl);
>
>  extern void sched_show_task(struct task_struct *p);
> +extern void sched_show_task_log_lvl(struct task_struct *p, const char *l=
vl);
>
>  #ifdef CONFIG_SCHED_DEBUG
>  struct seq_file;
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index ccd7217fcec1..23dec32a05f3 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -119,7 +119,7 @@ static void debug_show_blocker(struct task_struct *ta=
sk)
>                 if ((unsigned long)t =3D=3D owner) {
>                         pr_err("INFO: task %s:%d is blocked on a mutex li=
kely owned by task %s:%d.\n",
>                                 task->comm, task->pid, t->comm, t->pid);
> -                       sched_show_task(t);
> +                       sched_show_task_log_lvl(t, KERN_ERR);
>                         return;
>                 }
>         }
> @@ -186,7 +186,7 @@ static void check_hung_task(struct task_struct *t, un=
signed long timeout)
>                         pr_err("      Blocked by coredump.\n");
>                 pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s\""
>                         " disables this message.\n");
> -               sched_show_task(t);
> +               sched_show_task_log_lvl(t, KERN_ERR);
>                 debug_show_blocker(t);
>                 hung_task_show_lock =3D true;
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 00ea6f31973c..b6a5a41fbbfc 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7687,7 +7687,7 @@ void __sched io_schedule(void)
>  }
>  EXPORT_SYMBOL(io_schedule);
>
> -void sched_show_task(struct task_struct *p)
> +void sched_show_task_log_lvl(struct task_struct *p, const char *lvl)
>  {
>         unsigned long free;
>         int ppid;
> @@ -7695,7 +7695,8 @@ void sched_show_task(struct task_struct *p)
>         if (!try_get_task_stack(p))
>                 return;
>
> -       pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p))=
;
> +       printk("%stask:%-15.15s state:%c", lvl,
> +              p->comm, task_state_to_char(p));
>
>         if (task_is_running(p))
>                 pr_cont("  running task    ");
> @@ -7709,12 +7710,18 @@ void sched_show_task(struct task_struct *p)
>                 free, task_pid_nr(p), task_tgid_nr(p),
>                 ppid, p->flags, read_task_thread_flags(p));
>
> -       print_worker_info(KERN_INFO, p);
> -       print_stop_info(KERN_INFO, p);
> -       print_scx_info(KERN_INFO, p);
> -       show_stack(p, NULL, KERN_INFO);
> +       print_worker_info(lvl, p);
> +       print_stop_info(lvl, p);
> +       print_scx_info(lvl, p);
> +       show_stack(p, NULL, lvl);
>         put_task_stack(p);
>  }
> +EXPORT_SYMBOL_GPL(sched_show_task_log_lvl);
> +
> +void sched_show_task(struct task_struct *p)
> +{
> +       sched_show_task_log_lvl(p, KERN_INFO);
> +}
>  EXPORT_SYMBOL_GPL(sched_show_task);
>
>  static inline bool
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>

