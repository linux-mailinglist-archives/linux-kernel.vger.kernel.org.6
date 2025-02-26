Return-Path: <linux-kernel+bounces-532804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1B8A45267
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79F8188E696
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A119994F;
	Wed, 26 Feb 2025 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcPYe8TG"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8001422AB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534672; cv=none; b=VXbhKpfGkKrKAy3OB3fjtNEGdZvOgIXeikA9BeCTgiI6yqP0HD88WKSVmCCO0ZF6WgHrpZBzo67gFp7bUMkY6G1BybzPqCvx2LLaFX46/fYkB2s0NVBNIsyYAifn96qCjD2OQZfslMtp2IvdFrSNKmp8xOYdWu42cwphLyjwFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534672; c=relaxed/simple;
	bh=Pzy8D+s5osxdSF0v0mjMfEhEgHlxbT0V+rH8SvhzaBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9tjU4Ve/qINAdFt0jIglOIdWiv/gztsl/fEgPkjxCkxD+AeWhVnLPpxhRoT3VknOaPp0beWh/sHakoYmGvpDDRwf0lL5vv09cqBoh3yY04XdykVXFJgGx/Cw2V8Q5cqu1T4drAC48HUQfsppgbSYmPI1r/P13kDylZ73DNNAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcPYe8TG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso8458615a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740534669; x=1741139469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t+myGN3W5WQRKnvOZ6Wf8ZnZqMZJt18SrbHN5Tulrs=;
        b=fcPYe8TGNmF2JglskNFD1cLplPE0rH7T/WuT0AdqMTRbGWb1vU3wiI3hG+8vyhGFWW
         td8bd8szCCKo84E89enRLl470HpJdN3oDtKORi48agUe/T7LIuMbmksk/Zh/dGhaGAvp
         pBFSy/Ca3gT/f5mJKDomm8+jFyFfJTULPPSf7LL1Hga//3YabAXfeyY9kefslsV1IoH9
         36PadumZf3xP0SR7GHvSSTJ9zhmiL8CI8uYCiHPdznZp0mXK/O7VBRHOymT5BugzhgpC
         ATYk7hgk5JCe1cLGL8IsEpHDpZhHrObGuFyXHrJjiNLQ8cePkbx7k+LQN12CqTGlwl7X
         ZyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740534669; x=1741139469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t+myGN3W5WQRKnvOZ6Wf8ZnZqMZJt18SrbHN5Tulrs=;
        b=CAWrb3wgIgP8wUh0cCklbH5Bubjzl7kRSQR5oXgqQt3rN+cgTAWIDmHS8Fb7XXp9gm
         e9kL2DarTIVmYbLfjmf2JTwwAKeCQQ1zpObTSKlWBFYR7C6qSSq2QJ2Zx4GQPHCyNRZ/
         ypNbowmfWKY2lU9uRKXDET6WcgWPkAeitswU4UigO0pcRL0amnH5EM8hXLDmIqCHE/je
         loF4LxfmPV7dxCA1ugfykF2jdqos/VqqLUq7xjIIrk70bV0HG5uATBtB71Z8nsnbiH6M
         2+1kik6H7+vUotPUC+vICDUS6ZFs13wMSoH/G7xwxg16yRIc0+VfQH7W3YRwc7spp80s
         EyvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJB7Bfn0LAgL0ip4Pjj6PMxceb+zx6x1I1+O2QQX8pfLScTPcF6UdhWPYyvCu+Qvj3QQR374fknqdzXNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+hElpnoZnmuoKmRcv58z17J5zhqpqKiQfwFCsAM4RTz27d+Pb
	wVsl9EslErNtPzRBEwZPfkVqC3prw6hkToEpH2UfeuOxHETVDpA5S2aFU8RWsX0qGFoKJiH6D1U
	k20rMin8rgRGe0jS37Rm8Ve9bSgw=
X-Gm-Gg: ASbGncuI4bY2xcbps1LB6U21Mg41iSH3UcvtNV36CqK0K4dISNccKl5mvjUglMAwgj6
	ai4yTCNWEH+Kd/lwUC+a7uaYc8H5zpV1mvWQe9VGif+hmxUg82AXchFt1Ydf56ZW7eYp+89NFd3
	nW0huABrQ=
X-Google-Smtp-Source: AGHT+IE2DzlezS1LNyqeTc3JgZ9/3lOixz7zZSJax/3fbtprioM4al+55yxATQL02vox3S+83lOYTLOHWj+xqdo5Mlg=
X-Received: by 2002:a05:6402:2398:b0:5e4:9218:4e72 with SMTP id
 4fb4d7f45d1cf-5e492184f97mr3082089a12.30.1740534669182; Tue, 25 Feb 2025
 17:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046696281.2194069.4567490148001547311.stgit@mhiramat.tok.corp.google.com>
In-Reply-To: <174046696281.2194069.4567490148001547311.stgit@mhiramat.tok.corp.google.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 26 Feb 2025 09:50:32 +0800
X-Gm-Features: AQ5f1Jrf084jNhJI6-hh5QKRgKlySdA1WuYrH5gUGhWlUyK3wRllyvJjI9w8Od8
Message-ID: <CAK1f24nLDHLChnwG14rNa5RYik-3+Sqz74OAR1PsWvg3Zu_2+w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] samples: Add hung_task detector mutex blocking sample
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 3:02=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add a hung_task detector mutex blocking test sample code.
>
> This module will create a dummy file on the debugfs. That file will
> cause the read process to sleep for enough long time (256 seconds)
> while holding a mutex. As a result, the second process will wait on
> the mutex for a prolonged duration and be detected by the hung_task
> detector.
>
> Usage is;
>
>  > cd /sys/kernel/debug/hung_task
>  > cat mutex & cat mutex
>
> and wait for hung_task message.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  samples/Kconfig                     |    9 +++++
>  samples/Makefile                    |    1 +
>  samples/hung_task/Makefile          |    2 +
>  samples/hung_task/hung_task_mutex.c |   66 +++++++++++++++++++++++++++++=
++++++
>  4 files changed, 78 insertions(+)
>  create mode 100644 samples/hung_task/Makefile
>  create mode 100644 samples/hung_task/hung_task_mutex.c
>
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 820e00b2ed68..09011be2391a 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -300,6 +300,15 @@ config SAMPLE_CHECK_EXEC
>           demonstrate how they should be used with execveat(2) +
>           AT_EXECVE_CHECK.
>
> +config SAMPLE_HUNG_TASK
> +       tristate "Hung task detector test code"
> +       depends on DETECT_HUNG_TASK && DEBUG_FS
> +       help
> +         Build a module which provide a simple debugfs file. If user rea=
ds
> +         the file, it will sleep long time (256 seconds) with holding a
> +         mutex. Thus if there are 2 or more processes read this file, it
> +         will be detected by the hung_task watchdog.
> +
>  source "samples/rust/Kconfig"

I'm just wondering if we should also make the SAMPLE_HUNG_TASK
depend on !PREEMPT_RT for now?

Thanks,
Lance

>
>  source "samples/damon/Kconfig"
> diff --git a/samples/Makefile b/samples/Makefile
> index f24cd0d72dd0..bf6e6fca5410 100644
> --- a/samples/Makefile
> +++ b/samples/Makefile
> @@ -42,3 +42,4 @@ obj-$(CONFIG_SAMPLE_FPROBE)           +=3D fprobe/
>  obj-$(CONFIG_SAMPLES_RUST)             +=3D rust/
>  obj-$(CONFIG_SAMPLE_DAMON_WSSE)                +=3D damon/
>  obj-$(CONFIG_SAMPLE_DAMON_PRCL)                +=3D damon/
> +obj-$(CONFIG_SAMPLE_HUNG_TASK)         +=3D hung_task/
> diff --git a/samples/hung_task/Makefile b/samples/hung_task/Makefile
> new file mode 100644
> index 000000000000..fe9dde799880
> --- /dev/null
> +++ b/samples/hung_task/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_SAMPLE_HUNG_TASK) +=3D hung_task_mutex.o
> \ No newline at end of file
> diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/hung=
_task_mutex.c
> new file mode 100644
> index 000000000000..7a29f2246d22
> --- /dev/null
> +++ b/samples/hung_task/hung_task_mutex.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * hung_task_mutex.c - Sample code which causes hung task by mutex
> + *
> + * Usage: load this module and read `<debugfs>/hung_task/mutex`
> + *        by 2 or more processes.
> + *
> + * This is for testing kernel hung_task error message.
> + * Note that this will make your system freeze and maybe
> + * cause panic. So do not use this except for the test.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +
> +#define HUNG_TASK_DIR   "hung_task"
> +#define HUNG_TASK_FILE  "mutex"
> +#define SLEEP_SECOND 256
> +
> +static const char dummy_string[] =3D "This is a dummy string.";
> +static DEFINE_MUTEX(dummy_mutex);
> +struct dentry *hung_task_dir;
> +
> +static ssize_t read_dummy(struct file *file, char __user *user_buf,
> +                         size_t count, loff_t *ppos)
> +{
> +       /* If the second task waits on the lock, it is uninterruptible sl=
eep. */
> +       guard(mutex)(&dummy_mutex);
> +
> +       /* When the first task sleep here, it is interruptible. */
> +       msleep_interruptible(SLEEP_SECOND * 1000);
> +
> +       return simple_read_from_buffer(user_buf, count, ppos,
> +                               dummy_string, sizeof(dummy_string));
> +}
> +
> +static const struct file_operations hung_task_fops =3D {
> +       .read =3D read_dummy,
> +};
> +
> +static int __init hung_task_sample_init(void)
> +{
> +       hung_task_dir =3D debugfs_create_dir(HUNG_TASK_DIR, NULL);
> +       if (IS_ERR(hung_task_dir))
> +               return PTR_ERR(hung_task_dir);
> +
> +       debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir,
> +                           NULL, &hung_task_fops);
> +
> +       return 0;
> +}
> +
> +static void __exit hung_task_sample_exit(void)
> +{
> +       debugfs_remove_recursive(hung_task_dir);
> +}
> +
> +module_init(hung_task_sample_init);
> +module_exit(hung_task_sample_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Masami Hiramatsu");
> +MODULE_DESCRIPTION("Simple sleep under mutex file for testing hung task"=
);
>

