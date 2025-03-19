Return-Path: <linux-kernel+bounces-568261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9BA692E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959951BA563E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E719F1DE2CD;
	Wed, 19 Mar 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0Z+yTVC"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31241DE2D8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396397; cv=none; b=CU37DoDic4e9f++cuM9198uL7vgC165wAEyaYa9215kpxHK93uUyb3lAEw/ltsAj5mmyWg9mLiiekHwOXEK5OjjtYMyjovRLYgx3iLsJ6hdQqky6s/wOiyN/GB27rY3YcjyB3p0THy4gj06SO5n2PT/ic1wLmNDXRIxKGYaJlV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396397; c=relaxed/simple;
	bh=WlR77enonMqev7HxHqnkD+Y8VObMYyGBjkIhs9GLYG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgk1GUvIaFuBehFI8JHVbOx0jXuykkGfEHfSevhjeeqZKBbNvq4/MItabLUPb0Q2bT0kY0qzydwZoiHbBcHgQ36LEackbwO6MZrAyQafsOQgorbbkAFeQ88d6FbK7HZRieAIooxLqc8E6Lp53pva4uoVmcjmOzf7BaNKJwETq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0Z+yTVC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so1753783a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742396393; x=1743001193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XWIa1P8Y6YFjoshoFcetUMXosVdfwSUAmv2Z94aGdE=;
        b=j0Z+yTVCwGRS+smVRq1j0xq95QTa0TuMtjqesRXj1Y7tIZZcQ9Tw6mAClqAEAz5EBM
         DeV6a5hAf6z5N8KPrHl3ALg1f9YxLvZxVncaABGRrvz9G45jns3hLEfpBcsPpfv9Izi6
         lyTOTp1pQdDF7AHJQ8mukQxSj5tOpVQVg8yl7C/IOpnUGju+IqIrnI+ixwyYFOrh33CG
         vuoXaM7TZTPrSqzE+QY4gBjZZWQWofVA5fjW1ZyBYJMStftqdhUmq9fxCkDv54U3XBuV
         KYVzsznLVMlxtARXXItuLMWWElzlLUK+U5KfGk3nkW6H7mIRAdWH1c1bJ9uwymfnFLcp
         n1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396393; x=1743001193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XWIa1P8Y6YFjoshoFcetUMXosVdfwSUAmv2Z94aGdE=;
        b=r7xqzDhGMDP31IdtGT+Hefx/Yb8q514vPw40iID9fwF0yQEyFFfFzA5pC/+HOmGdwT
         krqmLazZ1UxtPfqACDYLGba6uq0Av6kN16z9ag2HKUqIlAGvHNLnMMhL1KxOWEl4Va8Z
         LxcoNqKCGra6Flfe2fZKwtkvYY2ljBcAHSXr8zUKzjA8LIJVcrFlYLzkWAq7d8q8QTpV
         3HgIoaU18NwjYesJopTQqdtyGFY7tklP4PswxYy4ta6Qf8rjXFeruUX5b2TEk26llFga
         R8rLY1cEhW5KsaBiibCgz9srnat5mKrZq25CVQA5zkcpEKubRZPTEbJsNRXT1MH6tlcV
         8zBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6q+PKs9BO22AHaKYi1JW4NtXqAluER3ORQSaveU9frRPJ9rGSXTjKRpIP90sqkS1TPBGNhKi8oEliXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxegyslwltGZhNxxgXnkgi0ltoglNywBgLeXmsz1IPfBCUIVS3b
	SHrRS/QJT6GAcj4r2/LoHZIz6LDD7vZXQDzH7V9+iFEq1Zt6ulYHttRofd3sGY5Qju/5J0pcUu1
	i+pGyHNomlykZI8eo+nwZzNVKkM0=
X-Gm-Gg: ASbGncu6KNISyjcZeA+K0C0dVN1ZYaWFidJ6fM1HcPGk+j3g4Cgy2qNPoeBnfZpUg4m
	nYHxDNLeOWBu0hhRaB8kEpV2XqNsH8WOhpgRcJhkhvlLqxQFn6hIfpTFkrrfoC9yyoZGO0ckOvQ
	qSMd/HjlSb01KFj1XNmfUQYW1eng==
X-Google-Smtp-Source: AGHT+IHuj+GlGD1ekcvnnir9SCuCCwaxFfasY+E8yxbS/mUC0gAyCw2XFHo+9rSGSVWy7qwfH2VtEddv7cxX9vxrms8=
X-Received: by 2002:a05:6402:1ed4:b0:5e0:6e6c:e2b5 with SMTP id
 4fb4d7f45d1cf-5eb1f027e71mr7879166a12.9.1742396392904; Wed, 19 Mar 2025
 07:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319081138.25133-1-ioworker0@gmail.com> <20250319081138.25133-4-ioworker0@gmail.com>
 <20250319224919.fc04fd8b804498e34486e772@kernel.org>
In-Reply-To: <20250319224919.fc04fd8b804498e34486e772@kernel.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 19 Mar 2025 22:59:16 +0800
X-Gm-Features: AQ5f1JoUAUVQXDdvIoYq9Fs8uoZ9c9sB7N3HEGpv9mNkIOxxQklm7T1i4Mav-74
Message-ID: <CAK1f24n441sk1p16dkU3GmWZz3R5y_ki_QeH7zH6tdkCKrGT_Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] samples: extend hung_task detector test with
 semaphore support
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, longman@redhat.com, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, joel.granados@kernel.org, kent.overstreet@linux.dev, 
	leonylgao@tencent.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, amaindex@outlook.com, 
	jstultz@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 9:49=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 19 Mar 2025 16:11:38 +0800
> Lance Yang <ioworker0@gmail.com> wrote:
>
> > From: Zi Li <amaindex@outlook.com>
> >
> > Extend the existing hung_task detector test module to support multiple =
lock
> > types, including mutex and semaphore, with room for future additions (e=
.g.,
> > spinlock, etc.). This module creates dummy files under <debugfs>/hung_t=
ask,
> > such as 'mutex' and 'semaphore'. The read process on any of these files=
 will
> > sleep for enough long time (256 seconds) while holding the respective l=
ock.
> > As a result, the second process will wait on the lock for a prolonged
> > duration and be detected by the hung_task detector.
> >
> > This change unifies the previous mutex-only sample into a single,
> > extensible hung_task_tests module, reducing code duplication and improv=
ing
> > maintainability.
> >
> > Usage is:
> >
> >       > cd /sys/kernel/debug/hung_task
> >       > cat mutex & cat mutex          # Test mutex blocking
> >       > cat semaphore & cat semaphore  # Test semaphore blocking
> >
> > Update the Kconfig description to reflect multiple debugfs files suppor=
t.
> >
>
> This looks good to me. (but have a nit comment below)
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks a lot for taking time to review!

>
> > Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > Signed-off-by: Zi Li <amaindex@outlook.com>
> > ---
> >  samples/Kconfig                     |  9 +--
> >  samples/hung_task/Makefile          |  2 +-
> >  samples/hung_task/hung_task_mutex.c | 66 --------------------
> >  samples/hung_task/hung_task_tests.c | 97 +++++++++++++++++++++++++++++
> >  4 files changed, 103 insertions(+), 71 deletions(-)
> >  delete mode 100644 samples/hung_task/hung_task_mutex.c
> >  create mode 100644 samples/hung_task/hung_task_tests.c
> >
> > diff --git a/samples/Kconfig b/samples/Kconfig
> > index 09011be2391a..753ed1f170b5 100644
> > --- a/samples/Kconfig
> > +++ b/samples/Kconfig
> > @@ -304,10 +304,11 @@ config SAMPLE_HUNG_TASK
> >       tristate "Hung task detector test code"
> >       depends on DETECT_HUNG_TASK && DEBUG_FS
> >       help
> > -       Build a module which provide a simple debugfs file. If user rea=
ds
> > -       the file, it will sleep long time (256 seconds) with holding a
> > -       mutex. Thus if there are 2 or more processes read this file, it
> > -       will be detected by the hung_task watchdog.
> > +       Build a module that provides debugfs files (e.g., mutex, semaph=
ore,
> > +       etc.) under <debugfs>/hung_task. If user reads one of these fil=
es,
> > +       it will sleep long time (256 seconds) with holding a lock. Thus=
,
> > +       if 2 or more processes read the same file concurrently, it will
> > +       be detected by the hung_task watchdog.
> >
> >  source "samples/rust/Kconfig"
> >
> > diff --git a/samples/hung_task/Makefile b/samples/hung_task/Makefile
> > index fe9dde799880..86036f1a204d 100644
> > --- a/samples/hung_task/Makefile
> > +++ b/samples/hung_task/Makefile
> > @@ -1,2 +1,2 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -obj-$(CONFIG_SAMPLE_HUNG_TASK) +=3D hung_task_mutex.o
> > \ No newline at end of file
> > +obj-$(CONFIG_SAMPLE_HUNG_TASK) +=3D hung_task_tests.o
> > diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/hu=
ng_task_mutex.c
> > deleted file mode 100644
> > index 7a29f2246d22..000000000000
> > --- a/samples/hung_task/hung_task_mutex.c
> > +++ /dev/null
> > @@ -1,66 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-or-later
> > -/*
> > - * hung_task_mutex.c - Sample code which causes hung task by mutex
> > - *
> > - * Usage: load this module and read `<debugfs>/hung_task/mutex`
> > - *        by 2 or more processes.
> > - *
> > - * This is for testing kernel hung_task error message.
> > - * Note that this will make your system freeze and maybe
> > - * cause panic. So do not use this except for the test.
> > - */
> > -
> > -#include <linux/debugfs.h>
> > -#include <linux/delay.h>
> > -#include <linux/fs.h>
> > -#include <linux/module.h>
> > -#include <linux/mutex.h>
> > -
> > -#define HUNG_TASK_DIR   "hung_task"
> > -#define HUNG_TASK_FILE  "mutex"
> > -#define SLEEP_SECOND 256
> > -
> > -static const char dummy_string[] =3D "This is a dummy string.";
> > -static DEFINE_MUTEX(dummy_mutex);
> > -struct dentry *hung_task_dir;
>
> Note that Andrew already fixed this (static)
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/=
patches/samples-add-hung_task-detector-mutex-blocking-sample-fix.patch

Good catch! I=E2=80=99ll rebase this patch on that.

Thanks again for your time!
Lance

>
> Thank you,
>
> > -
> > -static ssize_t read_dummy(struct file *file, char __user *user_buf,
> > -                       size_t count, loff_t *ppos)
> > -{
> > -     /* If the second task waits on the lock, it is uninterruptible sl=
eep. */
> > -     guard(mutex)(&dummy_mutex);
> > -
> > -     /* When the first task sleep here, it is interruptible. */
> > -     msleep_interruptible(SLEEP_SECOND * 1000);
> > -
> > -     return simple_read_from_buffer(user_buf, count, ppos,
> > -                             dummy_string, sizeof(dummy_string));
> > -}
> > -
> > -static const struct file_operations hung_task_fops =3D {
> > -     .read =3D read_dummy,
> > -};
> > -
> > -static int __init hung_task_sample_init(void)
> > -{
> > -     hung_task_dir =3D debugfs_create_dir(HUNG_TASK_DIR, NULL);
> > -     if (IS_ERR(hung_task_dir))
> > -             return PTR_ERR(hung_task_dir);
> > -
> > -     debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir,
> > -                         NULL, &hung_task_fops);
> > -
> > -     return 0;
> > -}
> > -
> > -static void __exit hung_task_sample_exit(void)
> > -{
> > -     debugfs_remove_recursive(hung_task_dir);
> > -}
> > -
> > -module_init(hung_task_sample_init);
> > -module_exit(hung_task_sample_exit);
> > -
> > -MODULE_LICENSE("GPL");
> > -MODULE_AUTHOR("Masami Hiramatsu");
> > -MODULE_DESCRIPTION("Simple sleep under mutex file for testing hung tas=
k");
> > diff --git a/samples/hung_task/hung_task_tests.c b/samples/hung_task/hu=
ng_task_tests.c
> > new file mode 100644
> > index 000000000000..a5c09bd3a47d
> > --- /dev/null
> > +++ b/samples/hung_task/hung_task_tests.c
> > @@ -0,0 +1,97 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * hung_task_tests.c - Sample code for testing hung tasks with mutex,
> > + * semaphore, etc.
> > + *
> > + * Usage: Load this module and read `<debugfs>/hung_task/mutex`,
> > + *        `<debugfs>/hung_task/semaphore`, etc., with 2 or more proces=
ses.
> > + *
> > + * This is for testing kernel hung_task error messages with various lo=
cking
> > + * mechanisms (e.g., mutex, semaphore, etc.). Note that this may freez=
e
> > + * your system or cause a panic. Use only for testing purposes.
> > + */
> > +
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +#include <linux/fs.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/semaphore.h>
> > +
> > +#define HUNG_TASK_DIR                "hung_task"
> > +#define HUNG_TASK_MUTEX_FILE "mutex"
> > +#define HUNG_TASK_SEM_FILE   "semaphore"
> > +#define SLEEP_SECOND         256
> > +
> > +static const char dummy_string[] =3D "This is a dummy string.";
> > +static DEFINE_MUTEX(dummy_mutex);
> > +static DEFINE_SEMAPHORE(dummy_sem, 1);
> > +static struct dentry *hung_task_dir;
> > +
> > +/* Mutex-based read function */
> > +static ssize_t read_dummy_mutex(struct file *file, char __user *user_b=
uf,
> > +                             size_t count, loff_t *ppos)
> > +{
> > +     /* Second task waits on mutex, entering uninterruptible sleep */
> > +     guard(mutex)(&dummy_mutex);
> > +
> > +     /* First task sleeps here, interruptible */
> > +     msleep_interruptible(SLEEP_SECOND * 1000);
> > +
> > +     return simple_read_from_buffer(user_buf, count, ppos, dummy_strin=
g,
> > +                                    sizeof(dummy_string));
> > +}
> > +
> > +/* Semaphore-based read function */
> > +static ssize_t read_dummy_semaphore(struct file *file, char __user *us=
er_buf,
> > +                                 size_t count, loff_t *ppos)
> > +{
> > +     /* Second task waits on semaphore, entering uninterruptible sleep=
 */
> > +     down(&dummy_sem);
> > +
> > +     /* First task sleeps here, interruptible */
> > +     msleep_interruptible(SLEEP_SECOND * 1000);
> > +
> > +     up(&dummy_sem);
> > +
> > +     return simple_read_from_buffer(user_buf, count, ppos, dummy_strin=
g,
> > +                                    sizeof(dummy_string));
> > +}
> > +
> > +/* File operations for mutex */
> > +static const struct file_operations hung_task_mutex_fops =3D {
> > +     .read =3D read_dummy_mutex,
> > +};
> > +
> > +/* File operations for semaphore */
> > +static const struct file_operations hung_task_sem_fops =3D {
> > +     .read =3D read_dummy_semaphore,
> > +};
> > +
> > +static int __init hung_task_tests_init(void)
> > +{
> > +     hung_task_dir =3D debugfs_create_dir(HUNG_TASK_DIR, NULL);
> > +     if (IS_ERR(hung_task_dir))
> > +             return PTR_ERR(hung_task_dir);
> > +
> > +     /* Create debugfs files for mutex and semaphore tests */
> > +     debugfs_create_file(HUNG_TASK_MUTEX_FILE, 0400, hung_task_dir, NU=
LL,
> > +                         &hung_task_mutex_fops);
> > +     debugfs_create_file(HUNG_TASK_SEM_FILE, 0400, hung_task_dir, NULL=
,
> > +                         &hung_task_sem_fops);
> > +
> > +     return 0;
> > +}
> > +
> > +static void __exit hung_task_tests_exit(void)
> > +{
> > +     debugfs_remove_recursive(hung_task_dir);
> > +}
> > +
> > +module_init(hung_task_tests_init);
> > +module_exit(hung_task_tests_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Masami Hiramatsu <mhiramat@kernel.org>");
> > +MODULE_AUTHOR("Zi Li <amaindex@outlook.com>");
> > +MODULE_DESCRIPTION("Simple sleep under lock files for testing hung tas=
k");
> > --
> > 2.45.2
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

