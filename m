Return-Path: <linux-kernel+bounces-568105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A3A68E55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9D61882E33
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19914A629;
	Wed, 19 Mar 2025 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYwhu/hJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C232FC23
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392166; cv=none; b=L6Nk9lGGHprRTZtgJPft/+V5XQyXfE55IsD0spBFeqFjc7lkGntB7S87pXMwsqMBrvsiGftdx/tbO83c1FQQAfQkLDUGfgtPSxuUl/knJMHByqeBNy0PFxH2d0zwM+W2YmGfiR5wiKv9GYUtLZTVfbSWLUgHzcIl8kzljo0Nai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392166; c=relaxed/simple;
	bh=pgWwijm0LovwaYJuxuD0MGZaxNhaJkp8sqLy2ALn8LM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gFw75+LrfhtHfo+WuJn7WA/k96thGHQ9MJtbX3oR268ggvte60vMDpB4DrM+lL4eH1s3my1xx00TNUqqwnFr5sULLTi6oWCsi57Q91Qtd858T30ZZo2/YVXfNcnd7FesJYQ10/gm9XsOR3fQH+W4JArMnHBsWzaT+hmsCKoV1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYwhu/hJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8671AC4CEE4;
	Wed, 19 Mar 2025 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742392165;
	bh=pgWwijm0LovwaYJuxuD0MGZaxNhaJkp8sqLy2ALn8LM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TYwhu/hJ7El5dKS9pWJyC2Mc3DtomJ6tnfW0ghDpmUbFUN+xa6TZ9L8LS0XevrjdC
	 2l3jyHAw07hWR08nC/u6t2+16XLBWjfq7nuvu8WG0sVuH4U46M+qr2uNNTt+OHapiH
	 oUhE5VcfKUkNevc6uWLEqL732Zdno26QZ7AdKgfoiRkcqz8LscgClBpLtRFdNGAuhs
	 0B5Nz/Dld59FpWox2Xr/3kagVfKigVlb1eIar4BIe0d9duhgwevNmfjqEAUfD76E2O
	 NdmGdhICwfjFvW0ilFte9AGib6Jr7RkpRQJk2k2Nh6rpde3mMAlfZ32yN8vly4k7Fg
	 Qx/S6/4QPs3EQ==
Date: Wed, 19 Mar 2025 22:49:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org,
 mingo@redhat.com, longman@redhat.com, mhiramat@kernel.org,
 anna.schumaker@oracle.com, boqun.feng@gmail.com, joel.granados@kernel.org,
 kent.overstreet@linux.dev, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 senozhatsky@chromium.org, tfiga@chromium.org, amaindex@outlook.com,
 jstultz@google.com
Subject: Re: [PATCH v3 3/3] samples: extend hung_task detector test with
 semaphore support
Message-Id: <20250319224919.fc04fd8b804498e34486e772@kernel.org>
In-Reply-To: <20250319081138.25133-4-ioworker0@gmail.com>
References: <20250319081138.25133-1-ioworker0@gmail.com>
	<20250319081138.25133-4-ioworker0@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 16:11:38 +0800
Lance Yang <ioworker0@gmail.com> wrote:

> From: Zi Li <amaindex@outlook.com>
> 
> Extend the existing hung_task detector test module to support multiple lock
> types, including mutex and semaphore, with room for future additions (e.g.,
> spinlock, etc.). This module creates dummy files under <debugfs>/hung_task,
> such as 'mutex' and 'semaphore'. The read process on any of these files will
> sleep for enough long time (256 seconds) while holding the respective lock.
> As a result, the second process will wait on the lock for a prolonged
> duration and be detected by the hung_task detector.
> 
> This change unifies the previous mutex-only sample into a single,
> extensible hung_task_tests module, reducing code duplication and improving
> maintainability.
> 
> Usage is:
> 
> 	> cd /sys/kernel/debug/hung_task
> 	> cat mutex & cat mutex          # Test mutex blocking
> 	> cat semaphore & cat semaphore  # Test semaphore blocking
> 
> Update the Kconfig description to reflect multiple debugfs files support.
> 

This looks good to me. (but have a nit comment below)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> Signed-off-by: Zi Li <amaindex@outlook.com>
> ---
>  samples/Kconfig                     |  9 +--
>  samples/hung_task/Makefile          |  2 +-
>  samples/hung_task/hung_task_mutex.c | 66 --------------------
>  samples/hung_task/hung_task_tests.c | 97 +++++++++++++++++++++++++++++
>  4 files changed, 103 insertions(+), 71 deletions(-)
>  delete mode 100644 samples/hung_task/hung_task_mutex.c
>  create mode 100644 samples/hung_task/hung_task_tests.c
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 09011be2391a..753ed1f170b5 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -304,10 +304,11 @@ config SAMPLE_HUNG_TASK
>  	tristate "Hung task detector test code"
>  	depends on DETECT_HUNG_TASK && DEBUG_FS
>  	help
> -	  Build a module which provide a simple debugfs file. If user reads
> -	  the file, it will sleep long time (256 seconds) with holding a
> -	  mutex. Thus if there are 2 or more processes read this file, it
> -	  will be detected by the hung_task watchdog.
> +	  Build a module that provides debugfs files (e.g., mutex, semaphore,
> +	  etc.) under <debugfs>/hung_task. If user reads one of these files,
> +	  it will sleep long time (256 seconds) with holding a lock. Thus,
> +	  if 2 or more processes read the same file concurrently, it will
> +	  be detected by the hung_task watchdog.
>  
>  source "samples/rust/Kconfig"
>  
> diff --git a/samples/hung_task/Makefile b/samples/hung_task/Makefile
> index fe9dde799880..86036f1a204d 100644
> --- a/samples/hung_task/Makefile
> +++ b/samples/hung_task/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
> \ No newline at end of file
> +obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_tests.o
> diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/hung_task_mutex.c
> deleted file mode 100644
> index 7a29f2246d22..000000000000
> --- a/samples/hung_task/hung_task_mutex.c
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * hung_task_mutex.c - Sample code which causes hung task by mutex
> - *
> - * Usage: load this module and read `<debugfs>/hung_task/mutex`
> - *        by 2 or more processes.
> - *
> - * This is for testing kernel hung_task error message.
> - * Note that this will make your system freeze and maybe
> - * cause panic. So do not use this except for the test.
> - */
> -
> -#include <linux/debugfs.h>
> -#include <linux/delay.h>
> -#include <linux/fs.h>
> -#include <linux/module.h>
> -#include <linux/mutex.h>
> -
> -#define HUNG_TASK_DIR   "hung_task"
> -#define HUNG_TASK_FILE  "mutex"
> -#define SLEEP_SECOND 256
> -
> -static const char dummy_string[] = "This is a dummy string.";
> -static DEFINE_MUTEX(dummy_mutex);
> -struct dentry *hung_task_dir;

Note that Andrew already fixed this (static)

https://web.git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/samples-add-hung_task-detector-mutex-blocking-sample-fix.patch

Thank you,

> -
> -static ssize_t read_dummy(struct file *file, char __user *user_buf,
> -			  size_t count, loff_t *ppos)
> -{
> -	/* If the second task waits on the lock, it is uninterruptible sleep. */
> -	guard(mutex)(&dummy_mutex);
> -
> -	/* When the first task sleep here, it is interruptible. */
> -	msleep_interruptible(SLEEP_SECOND * 1000);
> -
> -	return simple_read_from_buffer(user_buf, count, ppos,
> -				dummy_string, sizeof(dummy_string));
> -}
> -
> -static const struct file_operations hung_task_fops = {
> -	.read = read_dummy,
> -};
> -
> -static int __init hung_task_sample_init(void)
> -{
> -	hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
> -	if (IS_ERR(hung_task_dir))
> -		return PTR_ERR(hung_task_dir);
> -
> -	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir,
> -			    NULL, &hung_task_fops);
> -
> -	return 0;
> -}
> -
> -static void __exit hung_task_sample_exit(void)
> -{
> -	debugfs_remove_recursive(hung_task_dir);
> -}
> -
> -module_init(hung_task_sample_init);
> -module_exit(hung_task_sample_exit);
> -
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Masami Hiramatsu");
> -MODULE_DESCRIPTION("Simple sleep under mutex file for testing hung task");
> diff --git a/samples/hung_task/hung_task_tests.c b/samples/hung_task/hung_task_tests.c
> new file mode 100644
> index 000000000000..a5c09bd3a47d
> --- /dev/null
> +++ b/samples/hung_task/hung_task_tests.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * hung_task_tests.c - Sample code for testing hung tasks with mutex,
> + * semaphore, etc.
> + *
> + * Usage: Load this module and read `<debugfs>/hung_task/mutex`,
> + *        `<debugfs>/hung_task/semaphore`, etc., with 2 or more processes.
> + *
> + * This is for testing kernel hung_task error messages with various locking
> + * mechanisms (e.g., mutex, semaphore, etc.). Note that this may freeze
> + * your system or cause a panic. Use only for testing purposes.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/semaphore.h>
> +
> +#define HUNG_TASK_DIR		"hung_task"
> +#define HUNG_TASK_MUTEX_FILE	"mutex"
> +#define HUNG_TASK_SEM_FILE	"semaphore"
> +#define SLEEP_SECOND		256
> +
> +static const char dummy_string[] = "This is a dummy string.";
> +static DEFINE_MUTEX(dummy_mutex);
> +static DEFINE_SEMAPHORE(dummy_sem, 1);
> +static struct dentry *hung_task_dir;
> +
> +/* Mutex-based read function */
> +static ssize_t read_dummy_mutex(struct file *file, char __user *user_buf,
> +				size_t count, loff_t *ppos)
> +{
> +	/* Second task waits on mutex, entering uninterruptible sleep */
> +	guard(mutex)(&dummy_mutex);
> +
> +	/* First task sleeps here, interruptible */
> +	msleep_interruptible(SLEEP_SECOND * 1000);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, dummy_string,
> +				       sizeof(dummy_string));
> +}
> +
> +/* Semaphore-based read function */
> +static ssize_t read_dummy_semaphore(struct file *file, char __user *user_buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	/* Second task waits on semaphore, entering uninterruptible sleep */
> +	down(&dummy_sem);
> +
> +	/* First task sleeps here, interruptible */
> +	msleep_interruptible(SLEEP_SECOND * 1000);
> +
> +	up(&dummy_sem);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, dummy_string,
> +				       sizeof(dummy_string));
> +}
> +
> +/* File operations for mutex */
> +static const struct file_operations hung_task_mutex_fops = {
> +	.read = read_dummy_mutex,
> +};
> +
> +/* File operations for semaphore */
> +static const struct file_operations hung_task_sem_fops = {
> +	.read = read_dummy_semaphore,
> +};
> +
> +static int __init hung_task_tests_init(void)
> +{
> +	hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
> +	if (IS_ERR(hung_task_dir))
> +		return PTR_ERR(hung_task_dir);
> +
> +	/* Create debugfs files for mutex and semaphore tests */
> +	debugfs_create_file(HUNG_TASK_MUTEX_FILE, 0400, hung_task_dir, NULL,
> +			    &hung_task_mutex_fops);
> +	debugfs_create_file(HUNG_TASK_SEM_FILE, 0400, hung_task_dir, NULL,
> +			    &hung_task_sem_fops);
> +
> +	return 0;
> +}
> +
> +static void __exit hung_task_tests_exit(void)
> +{
> +	debugfs_remove_recursive(hung_task_dir);
> +}
> +
> +module_init(hung_task_tests_init);
> +module_exit(hung_task_tests_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Masami Hiramatsu <mhiramat@kernel.org>");
> +MODULE_AUTHOR("Zi Li <amaindex@outlook.com>");
> +MODULE_DESCRIPTION("Simple sleep under lock files for testing hung task");
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

