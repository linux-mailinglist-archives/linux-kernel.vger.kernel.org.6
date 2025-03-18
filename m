Return-Path: <linux-kernel+bounces-565288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05630A66532
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA1118847D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F5A126BFA;
	Tue, 18 Mar 2025 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW6anMGH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D217DA95
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261780; cv=none; b=gHgS8DA6BtgE0g4LsDk/NyXSmyDSk9bZgSGvp3hCpeqfCwG50X5w6iZjFsVYoq2zelrRSl9ZICfuzTABCNDrAzIeX/wwAINyLuIU6IFkJrjjxArcDanRs0dBbedM+GDkPr9uIfaLHIyh6dVyq9h8NODvCUN3FncLaup1iAe4P8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261780; c=relaxed/simple;
	bh=xRgrtSlTVUH38VM7vMVSlPuxOGEcYb77gGh6swohSAE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NeB3ByKCaoQ3AjrGNqrWB6ZYm0HzSUvBYQV2DCgVc194z6i/Wo4/H9mdJEVeFu8amvKpvdfyPeY9ekYu+mr2/7YgZPuyk+nFqMJUjWT0fWidrVQtKFK3WMc1OznFUaiFxMtYDsqtgwnHq/ct2GgPRKY2aJqUvDpOS83fsePyPMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sW6anMGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF7CC4CEED;
	Tue, 18 Mar 2025 01:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742261779;
	bh=xRgrtSlTVUH38VM7vMVSlPuxOGEcYb77gGh6swohSAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sW6anMGHVrMRfLawDJqD9EzPM6tWDM2P0cj7jrpT0HP0JX6zX5cuPx/nLlzu92arR
	 37QfyxDlMceNz3mVQWQPJHvO2S5dCRsi6OEVtf8j3Oru07+xubVqp9yDg1Vi7238Uy
	 cXDt2kzU7gXfToAKQ9Vj8e3SsAKBexmUnRdQdk5UvIorMgjDkKSsTr354Z3rGd3RX6
	 UuRZA3Jw5d+RHCh+FFV62Cdnf1bw4zypPdYxBBmbw3B2KspSkUb+cxm2dvf8OXeNGj
	 rlp78pEBWC4yZCe9jjt0QbPapHOStkCLyYDhimNIQB3QhJ4+uGLc2GV3HGfQHEe6ua
	 B90KjVocp5LnA==
Date: Tue, 18 Mar 2025 10:36:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org,
 mingo@redhat.com, longman@redhat.com, mhiramat@kernel.org,
 anna.schumaker@oracle.com, boqun.feng@gmail.com, joel.granados@kernel.org,
 kent.overstreet@linux.dev, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 senozhatsky@chromium.org, tfiga@chromium.org, amaindex@outlook.com
Subject: Re: [PATCH RESEND v2 3/3] samples: add hung_task detector semaphore
 blocking sample
Message-Id: <20250318103615.bce4a3291786c2bd525f0f02@kernel.org>
In-Reply-To: <20250314144300.32542-4-ioworker0@gmail.com>
References: <20250314144300.32542-1-ioworker0@gmail.com>
	<20250314144300.32542-4-ioworker0@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 22:43:00 +0800
Lance Yang <ioworker0@gmail.com> wrote:

> From: Zi Li <amaindex@outlook.com>
> 
> Add a hung_task detector semaphore blocking test sample code.
> 
> This module will create a dummy file on the debugfs. That file will cause
> the read process to sleep for a sufficiently long time (256 seconds)
> while holding a semaphore. As a result, the second process will wait on
> the semaphore for a prolonged duration and be detected by the hung_task
> detector.
> 
> Usage is;
> 
>  > cd /sys/kernel/debug/hung_task
>  > cat semaphore & cat semaphore
> 
> and wait for hung_task message.

Thanks for updating the sample code. BTW, do we need to have almost same
2 samples? I think we can unify it (one module provides both "mutex" and
"semaphre" test files.) to "hung_task_tests.c"

That will help us to extend it for other types easier (and less code).

Thank you,

> 
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> Signed-off-by: Zi Li <amaindex@outlook.com>
> ---
>  samples/Kconfig                         | 11 ++--
>  samples/hung_task/Makefile              |  3 +-
>  samples/hung_task/hung_task_mutex.c     | 20 ++++---
>  samples/hung_task/hung_task_semaphore.c | 74 +++++++++++++++++++++++++
>  4 files changed, 96 insertions(+), 12 deletions(-)
>  create mode 100644 samples/hung_task/hung_task_semaphore.c
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 09011be2391a..3a073d6b848b 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -304,10 +304,13 @@ config SAMPLE_HUNG_TASK
>  	tristate "Hung task detector test code"
>  	depends on DETECT_HUNG_TASK && DEBUG_FS
>  	help
> -	  Build a module which provide a simple debugfs file. If user reads
> -	  the file, it will sleep long time (256 seconds) with holding a
> -	  mutex. Thus if there are 2 or more processes read this file, it
> -	  will be detected by the hung_task watchdog.
> +	  Build multiple modules to test the hung task detector. Each module
> +	  provides a simple debugfs file corresponding to a specific
> +	  synchronization primitive (e.g., mutex, semaphore, etc.). When the
> +	  file is read, the module will sleep for a long time (256 seconds)
> +	  while holding the respective synchronizer. If multiple processes
> +	  attempt to read these files concurrently, the hung_task watchdog
> +	  can detect potential hangs or deadlocks.
>  
>  source "samples/rust/Kconfig"
>  
> diff --git a/samples/hung_task/Makefile b/samples/hung_task/Makefile
> index fe9dde799880..7483c2c0a0ef 100644
> --- a/samples/hung_task/Makefile
> +++ b/samples/hung_task/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
> \ No newline at end of file
> +obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
> +obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_semaphore.o
> \ No newline at end of file
> diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/hung_task_mutex.c
> index 7a29f2246d22..e4d1d69618b8 100644
> --- a/samples/hung_task/hung_task_mutex.c
> +++ b/samples/hung_task/hung_task_mutex.c
> @@ -22,7 +22,7 @@
>  
>  static const char dummy_string[] = "This is a dummy string.";
>  static DEFINE_MUTEX(dummy_mutex);
> -struct dentry *hung_task_dir;
> +static struct dentry *hung_task_dir;
>  
>  static ssize_t read_dummy(struct file *file, char __user *user_buf,
>  			  size_t count, loff_t *ppos)
> @@ -43,19 +43,25 @@ static const struct file_operations hung_task_fops = {
>  
>  static int __init hung_task_sample_init(void)
>  {
> -	hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
> -	if (IS_ERR(hung_task_dir))
> -		return PTR_ERR(hung_task_dir);
> +	hung_task_dir = debugfs_lookup(HUNG_TASK_DIR, NULL);
> +	if (!hung_task_dir) {
> +		hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
> +		if (IS_ERR(hung_task_dir))
> +			return PTR_ERR(hung_task_dir);
> +	}
>  
> -	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir,
> -			    NULL, &hung_task_fops);
> +	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir, NULL,
> +			    &hung_task_fops);
>  
>  	return 0;
>  }
>  
>  static void __exit hung_task_sample_exit(void)
>  {
> -	debugfs_remove_recursive(hung_task_dir);
> +	debugfs_lookup_and_remove(HUNG_TASK_FILE, hung_task_dir);
> +
> +	if (simple_empty(hung_task_dir))
> +		debugfs_remove(hung_task_dir);
>  }
>  
>  module_init(hung_task_sample_init);
> diff --git a/samples/hung_task/hung_task_semaphore.c b/samples/hung_task/hung_task_semaphore.c
> new file mode 100644
> index 000000000000..a5814971bfb8
> --- /dev/null
> +++ b/samples/hung_task/hung_task_semaphore.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * hung_task_semaphore.c - Sample code which causes hung task by semaphore
> + *
> + * Usage: load this module and read `<debugfs>/hung_task/semaphore`
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
> +#include <linux/semaphore.h>
> +
> +#define HUNG_TASK_DIR   "hung_task"
> +#define HUNG_TASK_FILE  "semaphore"
> +#define SLEEP_SECOND 256
> +
> +static const char dummy_string[] = "This is a dummy string.";
> +static DEFINE_SEMAPHORE(dummy_sem, 1);
> +static struct dentry *hung_task_dir;
> +
> +static ssize_t read_dummy(struct file *file, char __user *user_buf,
> +			  size_t count, loff_t *ppos)
> +{
> +	/* If the second task waits on the semaphore, it is uninterruptible sleep. */
> +	down(&dummy_sem);
> +
> +	/* When the first task sleep here, it is interruptible. */
> +	msleep_interruptible(SLEEP_SECOND * 1000);
> +
> +	up(&dummy_sem);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, dummy_string,
> +				       sizeof(dummy_string));
> +}
> +
> +static const struct file_operations hung_task_fops = {
> +	.read = read_dummy,
> +};
> +
> +static int __init hung_task_sample_init(void)
> +{
> +	hung_task_dir = debugfs_lookup(HUNG_TASK_DIR, NULL);
> +	if (!hung_task_dir) {
> +		hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
> +		if (IS_ERR(hung_task_dir))
> +			return PTR_ERR(hung_task_dir);
> +	}
> +
> +	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir, NULL,
> +			    &hung_task_fops);
> +
> +	return 0;
> +}
> +
> +static void __exit hung_task_sample_exit(void)
> +{
> +	debugfs_lookup_and_remove(HUNG_TASK_FILE, hung_task_dir);
> +
> +	if (simple_empty(hung_task_dir))
> +		debugfs_remove(hung_task_dir);
> +}
> +
> +module_init(hung_task_sample_init);
> +module_exit(hung_task_sample_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zi Li");
> +MODULE_DESCRIPTION("Simple sleep under semaphore file for testing hung task");
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

