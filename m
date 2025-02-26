Return-Path: <linux-kernel+bounces-533711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F09A45E09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BEB168B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A4216E19;
	Wed, 26 Feb 2025 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDjKYinm"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868020FA9B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571173; cv=none; b=PZNJ7GKUCnxBvzBNSlwdZNsLsNqGwbvoCeak1BndHXj+ZzqR+3eGx+biTMRd9tzYYAuMscvD3ogbeo/kWiHrznu/0jV1FrJ95b+egf8IMLlnkUgIRw7+jGpxZ0EXUNtLworPNNPb6ykyyZrX07ju9jSD/IL4f9S0b52JTLIRwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571173; c=relaxed/simple;
	bh=wGnukQhR2QhljytURepf3EufgeXZDFqXbjMvgVXQqMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1sXwVW557ZJ9TxDH7SfP09PGEAeif5c54NEBe07fc1KHwxBRVgiQyc0ePgZCJ0xKp3jEN4KtH8iRSflCGgCvP6oV2L/0vgRvWuRgohJrVnLtc/BzcRYqcrQevFXlWKu2cBrXwVkn2QjOim22TjCNhmlgEVNg70GXnAgkj1/dNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDjKYinm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so12107846a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740571170; x=1741175970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/W5mwtTdTD8JMvIPP0BI1RyPCYrFx4H9xPGAr7zJIo=;
        b=BDjKYinm954dAfc3v9ki6K6KBDICYWul5m0Zu1mnERvPA+zcQibF+mRmqiyTzQ07UJ
         ID9F+qNt5Nvlh3BIP6eja8LadIAOU+dO1pGd1FXv0S2bWqDjZckJnB51IPHDwuyRInrF
         AiBIWyhA2wLViv8qRUe2vvYWFBPiP7VkH9HreN1LSjVa2jupO6C+MN7CU1lU4Cf32Rlw
         dwyzXuaM5/4wrAUqkcSCLuZbbnHYY3hxZEd3uev0wdOx+Cyr5ioGbpUjJfNivTv+0M0Z
         RR+mPzHl0JvMpitVg1U63CTbxYP82ulpXP5IL95fz3gK4i6CqsUFrwzeR1fVo5vo4GCO
         QnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740571170; x=1741175970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/W5mwtTdTD8JMvIPP0BI1RyPCYrFx4H9xPGAr7zJIo=;
        b=ctlb758so8F3+MXt269a8WDQ8mleIyArCwF3vkB6mJclVyoe4ZohJoX4GsXr3/4zjb
         utQYMtz/7s64ZBAxYyft19h6A4DXmlmfE4S3n8vke5ouGA6ER9tLnJU2yLVLIMAsQsqp
         q+hk0yhPbJWGD6nC8gilqyRODVurWc3Ft3qJUfNVrvo4xKFfrqo2ARtzf65zyF7d7/8f
         +RC2j3CMlB+m1OXuhNPgJ6E2l44fdJyrbzmkXOKs4xYBs7LdwkGo9drYatdYt/cEjhhO
         +Urnd2nvozzNylTcgEkDbC2fwkicAjbQ/PpQVPhtar4fX2QW2SOPFz8U6VyGW1BtG0Rt
         e/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpVnKlDkdpAqsvwFgSMyIiJYOgSIeU6jEQpY6UuXRualVrmD+e/aTsqUJiI3GZ5yaot4acTWKJ0sXzHso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2N5ReXMjCvtwfJIa2jyQyIDXnhUGF4xEytT3m1Aht8yHu0j0O
	Y/JfCr0MF4biznNJvMW5dXm9AZ6n5yfgaRyVJoUiCu1QYcnR3Zt1ihxBw6Zcy2VWmGSCJLYmwON
	5iQ2oyIJFizgp/bx1VdwLv3XbWlM=
X-Gm-Gg: ASbGncsLdfDs3rOWTiXfDWH9luCFPEhMhnbI4pCAXCtj7XGtQ58xGa8boQEHWf+TpCN
	6HzCpuH0awaMwwigIjk7hguRqPIDSRm247lXq683Yr4OviatQ0J2XVZUBuFmDP9r/cujkTsjdGk
	moNzyyueg=
X-Google-Smtp-Source: AGHT+IHz4RylapGCWcnGCMPGfbq6hzXERu4tsSGNx+8NouGQZrd1vZx2txwZDn9MPoXk8ZfBHHfNKG3Fpgd5XgnRZbU=
X-Received: by 2002:a05:6402:13d2:b0:5e0:2ce6:3d50 with SMTP id
 4fb4d7f45d1cf-5e4a0dfc587mr3173966a12.23.1740571169735; Wed, 26 Feb 2025
 03:59:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046696281.2194069.4567490148001547311.stgit@mhiramat.tok.corp.google.com>
 <CAK1f24nLDHLChnwG14rNa5RYik-3+Sqz74OAR1PsWvg3Zu_2+w@mail.gmail.com> <20250226160430.d74c50d370dcef2904417d1e@kernel.org>
In-Reply-To: <20250226160430.d74c50d370dcef2904417d1e@kernel.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 26 Feb 2025 19:58:53 +0800
X-Gm-Features: AQ5f1JqzrqsoNM7Dr113XXBqLg8znNCCu8wZNF7vNmbnHOqSQu8_4MqH88kw7F8
Message-ID: <CAK1f24mb82Q33Bd-LyJwi7D8gcd1QNAycYgjAT00=_EC=Gxu0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] samples: Add hung_task detector mutex blocking sample
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:04=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 26 Feb 2025 09:50:32 +0800
> Lance Yang <ioworker0@gmail.com> wrote:
>
> > On Tue, Feb 25, 2025 at 3:02=E2=80=AFPM Masami Hiramatsu (Google)
> > <mhiramat@kernel.org> wrote:
> > >
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > Add a hung_task detector mutex blocking test sample code.
> > >
> > > This module will create a dummy file on the debugfs. That file will
> > > cause the read process to sleep for enough long time (256 seconds)
> > > while holding a mutex. As a result, the second process will wait on
> > > the mutex for a prolonged duration and be detected by the hung_task
> > > detector.
> > >
> > > Usage is;
> > >
> > >  > cd /sys/kernel/debug/hung_task
> > >  > cat mutex & cat mutex
> > >
> > > and wait for hung_task message.
> > >
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > >  samples/Kconfig                     |    9 +++++
> > >  samples/Makefile                    |    1 +
> > >  samples/hung_task/Makefile          |    2 +
> > >  samples/hung_task/hung_task_mutex.c |   66 +++++++++++++++++++++++++=
++++++++++
> > >  4 files changed, 78 insertions(+)
> > >  create mode 100644 samples/hung_task/Makefile
> > >  create mode 100644 samples/hung_task/hung_task_mutex.c
> > >
> > > diff --git a/samples/Kconfig b/samples/Kconfig
> > > index 820e00b2ed68..09011be2391a 100644
> > > --- a/samples/Kconfig
> > > +++ b/samples/Kconfig
> > > @@ -300,6 +300,15 @@ config SAMPLE_CHECK_EXEC
> > >           demonstrate how they should be used with execveat(2) +
> > >           AT_EXECVE_CHECK.
> > >
> > > +config SAMPLE_HUNG_TASK
> > > +       tristate "Hung task detector test code"
> > > +       depends on DETECT_HUNG_TASK && DEBUG_FS
> > > +       help
> > > +         Build a module which provide a simple debugfs file. If user=
 reads
> > > +         the file, it will sleep long time (256 seconds) with holdin=
g a
> > > +         mutex. Thus if there are 2 or more processes read this file=
, it
> > > +         will be detected by the hung_task watchdog.
> > > +
> > >  source "samples/rust/Kconfig"
> >
> > I'm just wondering if we should also make the SAMPLE_HUNG_TASK
> > depend on !PREEMPT_RT for now?
>
> Yeah, I also have a question. This does not check the blocker,
> but just providing the testing interface with mutex. So there is
> no direct connection with DETECT_HUNG_TASK_BLOCKER. Thus I didn't
> add the dependency.

Yep, whether we add it or not is not a big deal ;)

Thanks,
Lance

>
> Thank you,
>
> >
> > Thanks,
> > Lance
> >
> > >
> > >  source "samples/damon/Kconfig"
> > > diff --git a/samples/Makefile b/samples/Makefile
> > > index f24cd0d72dd0..bf6e6fca5410 100644
> > > --- a/samples/Makefile
> > > +++ b/samples/Makefile
> > > @@ -42,3 +42,4 @@ obj-$(CONFIG_SAMPLE_FPROBE)           +=3D fprobe/
> > >  obj-$(CONFIG_SAMPLES_RUST)             +=3D rust/
> > >  obj-$(CONFIG_SAMPLE_DAMON_WSSE)                +=3D damon/
> > >  obj-$(CONFIG_SAMPLE_DAMON_PRCL)                +=3D damon/
> > > +obj-$(CONFIG_SAMPLE_HUNG_TASK)         +=3D hung_task/
> > > diff --git a/samples/hung_task/Makefile b/samples/hung_task/Makefile
> > > new file mode 100644
> > > index 000000000000..fe9dde799880
> > > --- /dev/null
> > > +++ b/samples/hung_task/Makefile
> > > @@ -0,0 +1,2 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +obj-$(CONFIG_SAMPLE_HUNG_TASK) +=3D hung_task_mutex.o
> > > \ No newline at end of file
> > > diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/=
hung_task_mutex.c
> > > new file mode 100644
> > > index 000000000000..7a29f2246d22
> > > --- /dev/null
> > > +++ b/samples/hung_task/hung_task_mutex.c
> > > @@ -0,0 +1,66 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * hung_task_mutex.c - Sample code which causes hung task by mutex
> > > + *
> > > + * Usage: load this module and read `<debugfs>/hung_task/mutex`
> > > + *        by 2 or more processes.
> > > + *
> > > + * This is for testing kernel hung_task error message.
> > > + * Note that this will make your system freeze and maybe
> > > + * cause panic. So do not use this except for the test.
> > > + */
> > > +
> > > +#include <linux/debugfs.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +
> > > +#define HUNG_TASK_DIR   "hung_task"
> > > +#define HUNG_TASK_FILE  "mutex"
> > > +#define SLEEP_SECOND 256
> > > +
> > > +static const char dummy_string[] =3D "This is a dummy string.";
> > > +static DEFINE_MUTEX(dummy_mutex);
> > > +struct dentry *hung_task_dir;
> > > +
> > > +static ssize_t read_dummy(struct file *file, char __user *user_buf,
> > > +                         size_t count, loff_t *ppos)
> > > +{
> > > +       /* If the second task waits on the lock, it is uninterruptibl=
e sleep. */
> > > +       guard(mutex)(&dummy_mutex);
> > > +
> > > +       /* When the first task sleep here, it is interruptible. */
> > > +       msleep_interruptible(SLEEP_SECOND * 1000);
> > > +
> > > +       return simple_read_from_buffer(user_buf, count, ppos,
> > > +                               dummy_string, sizeof(dummy_string));
> > > +}
> > > +
> > > +static const struct file_operations hung_task_fops =3D {
> > > +       .read =3D read_dummy,
> > > +};
> > > +
> > > +static int __init hung_task_sample_init(void)
> > > +{
> > > +       hung_task_dir =3D debugfs_create_dir(HUNG_TASK_DIR, NULL);
> > > +       if (IS_ERR(hung_task_dir))
> > > +               return PTR_ERR(hung_task_dir);
> > > +
> > > +       debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir,
> > > +                           NULL, &hung_task_fops);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void __exit hung_task_sample_exit(void)
> > > +{
> > > +       debugfs_remove_recursive(hung_task_dir);
> > > +}
> > > +
> > > +module_init(hung_task_sample_init);
> > > +module_exit(hung_task_sample_exit);
> > > +
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_AUTHOR("Masami Hiramatsu");
> > > +MODULE_DESCRIPTION("Simple sleep under mutex file for testing hung t=
ask");
> > >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

