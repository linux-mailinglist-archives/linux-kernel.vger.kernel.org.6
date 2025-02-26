Return-Path: <linux-kernel+bounces-533162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5188AA45645
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E5F188DF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C426A087;
	Wed, 26 Feb 2025 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVf6/BTb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B622FDE4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553474; cv=none; b=XMyMLEu2YHMJVhZ5SZpNxfcdAaXKhlvr3jPKyKVDJb9CMB4+KhImD5j8Aq/mqf9xJxUT7zGm0FsZ7sFdEA3Mex7uGdsYdNOHcv0CjxsgYv7JQlMcYRr+umlGj52cnSk2b5pjyK06iyQ9HdGtJXPQ0SJ93yaM12bVhWQe+db4bTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553474; c=relaxed/simple;
	bh=Cdk9MvMUW2TT8jgiIyxLp/6WErcMa8mAoOICUjgb/3E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pAE2B5GyPQf+MOJ7jmlMtLBmV6OFYhjlflI26QhAsFQiDborgIM+YLnDTSau3o1DeCueQhMdYBt32a9b0g4C33XAb16qcQ1Qj4OKFyWROGxgRIVDaI43IwAfeAopYHnBtAakdqHdN2M+g456qocDgdNx62INGwS336en/W6xaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVf6/BTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432F6C4CED6;
	Wed, 26 Feb 2025 07:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740553474;
	bh=Cdk9MvMUW2TT8jgiIyxLp/6WErcMa8mAoOICUjgb/3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qVf6/BTbm1oF7OHumSQDhs9QWhBc+9D1OF0j/o7yV+gSanr3bxbWIR9yKq9BsEcVw
	 W/8r8SN+TA8DgxO2H53L/Ptmvm4y/+cCAqMTnC8PSwaCW4Gc5iVNnI9KDkfCo3By53
	 xnqibn4kx648hmnrbt3KSOdWtc8xX2AWnz+PfhmsEQ4mCwvWj3G+fkMeCKaYQSOh1z
	 HSX3HofPvqSKBZiT9cR0OFUipXz/lhVMcdhvvgDYbONsxXAuOB9KVG5rGKNJLvP/rf
	 8JkosOpwJhfDFwq9SQ4SL3jViacHWoUkKCwWE6h//DPPZ5klaPIgxlZa69AIgdm4Qq
	 4t5xNBTL4n+Rw==
Date: Wed, 26 Feb 2025 16:04:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Joel
 Granados <joel.granados@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt
 <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] samples: Add hung_task detector mutex blocking
 sample
Message-Id: <20250226160430.d74c50d370dcef2904417d1e@kernel.org>
In-Reply-To: <CAK1f24nLDHLChnwG14rNa5RYik-3+Sqz74OAR1PsWvg3Zu_2+w@mail.gmail.com>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
	<174046696281.2194069.4567490148001547311.stgit@mhiramat.tok.corp.google.com>
	<CAK1f24nLDHLChnwG14rNa5RYik-3+Sqz74OAR1PsWvg3Zu_2+w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 26 Feb 2025 09:50:32 +0800
Lance Yang <ioworker0@gmail.com> wrote:

> On Tue, Feb 25, 2025 at 3:02 PM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Add a hung_task detector mutex blocking test sample code.
> >
> > This module will create a dummy file on the debugfs. That file will
> > cause the read process to sleep for enough long time (256 seconds)
> > while holding a mutex. As a result, the second process will wait on
> > the mutex for a prolonged duration and be detected by the hung_task
> > detector.
> >
> > Usage is;
> >
> >  > cd /sys/kernel/debug/hung_task
> >  > cat mutex & cat mutex
> >
> > and wait for hung_task message.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  samples/Kconfig                     |    9 +++++
> >  samples/Makefile                    |    1 +
> >  samples/hung_task/Makefile          |    2 +
> >  samples/hung_task/hung_task_mutex.c |   66 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 78 insertions(+)
> >  create mode 100644 samples/hung_task/Makefile
> >  create mode 100644 samples/hung_task/hung_task_mutex.c
> >
> > diff --git a/samples/Kconfig b/samples/Kconfig
> > index 820e00b2ed68..09011be2391a 100644
> > --- a/samples/Kconfig
> > +++ b/samples/Kconfig
> > @@ -300,6 +300,15 @@ config SAMPLE_CHECK_EXEC
> >           demonstrate how they should be used with execveat(2) +
> >           AT_EXECVE_CHECK.
> >
> > +config SAMPLE_HUNG_TASK
> > +       tristate "Hung task detector test code"
> > +       depends on DETECT_HUNG_TASK && DEBUG_FS
> > +       help
> > +         Build a module which provide a simple debugfs file. If user reads
> > +         the file, it will sleep long time (256 seconds) with holding a
> > +         mutex. Thus if there are 2 or more processes read this file, it
> > +         will be detected by the hung_task watchdog.
> > +
> >  source "samples/rust/Kconfig"
> 
> I'm just wondering if we should also make the SAMPLE_HUNG_TASK
> depend on !PREEMPT_RT for now?

Yeah, I also have a question. This does not check the blocker,
but just providing the testing interface with mutex. So there is
no direct connection with DETECT_HUNG_TASK_BLOCKER. Thus I didn't
add the dependency.

Thank you,

> 
> Thanks,
> Lance
> 
> >
> >  source "samples/damon/Kconfig"
> > diff --git a/samples/Makefile b/samples/Makefile
> > index f24cd0d72dd0..bf6e6fca5410 100644
> > --- a/samples/Makefile
> > +++ b/samples/Makefile
> > @@ -42,3 +42,4 @@ obj-$(CONFIG_SAMPLE_FPROBE)           += fprobe/
> >  obj-$(CONFIG_SAMPLES_RUST)             += rust/
> >  obj-$(CONFIG_SAMPLE_DAMON_WSSE)                += damon/
> >  obj-$(CONFIG_SAMPLE_DAMON_PRCL)                += damon/
> > +obj-$(CONFIG_SAMPLE_HUNG_TASK)         += hung_task/
> > diff --git a/samples/hung_task/Makefile b/samples/hung_task/Makefile
> > new file mode 100644
> > index 000000000000..fe9dde799880
> > --- /dev/null
> > +++ b/samples/hung_task/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
> > \ No newline at end of file
> > diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/hung_task_mutex.c
> > new file mode 100644
> > index 000000000000..7a29f2246d22
> > --- /dev/null
> > +++ b/samples/hung_task/hung_task_mutex.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * hung_task_mutex.c - Sample code which causes hung task by mutex
> > + *
> > + * Usage: load this module and read `<debugfs>/hung_task/mutex`
> > + *        by 2 or more processes.
> > + *
> > + * This is for testing kernel hung_task error message.
> > + * Note that this will make your system freeze and maybe
> > + * cause panic. So do not use this except for the test.
> > + */
> > +
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +#include <linux/fs.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +
> > +#define HUNG_TASK_DIR   "hung_task"
> > +#define HUNG_TASK_FILE  "mutex"
> > +#define SLEEP_SECOND 256
> > +
> > +static const char dummy_string[] = "This is a dummy string.";
> > +static DEFINE_MUTEX(dummy_mutex);
> > +struct dentry *hung_task_dir;
> > +
> > +static ssize_t read_dummy(struct file *file, char __user *user_buf,
> > +                         size_t count, loff_t *ppos)
> > +{
> > +       /* If the second task waits on the lock, it is uninterruptible sleep. */
> > +       guard(mutex)(&dummy_mutex);
> > +
> > +       /* When the first task sleep here, it is interruptible. */
> > +       msleep_interruptible(SLEEP_SECOND * 1000);
> > +
> > +       return simple_read_from_buffer(user_buf, count, ppos,
> > +                               dummy_string, sizeof(dummy_string));
> > +}
> > +
> > +static const struct file_operations hung_task_fops = {
> > +       .read = read_dummy,
> > +};
> > +
> > +static int __init hung_task_sample_init(void)
> > +{
> > +       hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
> > +       if (IS_ERR(hung_task_dir))
> > +               return PTR_ERR(hung_task_dir);
> > +
> > +       debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir,
> > +                           NULL, &hung_task_fops);
> > +
> > +       return 0;
> > +}
> > +
> > +static void __exit hung_task_sample_exit(void)
> > +{
> > +       debugfs_remove_recursive(hung_task_dir);
> > +}
> > +
> > +module_init(hung_task_sample_init);
> > +module_exit(hung_task_sample_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Masami Hiramatsu");
> > +MODULE_DESCRIPTION("Simple sleep under mutex file for testing hung task");
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

