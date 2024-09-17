Return-Path: <linux-kernel+bounces-331572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707AA97AE67
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3280728700E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69D16130C;
	Tue, 17 Sep 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx2O5rXO"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53A1BF24;
	Tue, 17 Sep 2024 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567308; cv=none; b=A5doW1WFdD1gbOaCXPTBOPSqadDWA2YsIn2oWUAplqoHn29FU3CmdhsD36dV+Qunxf3srdpO7WgVeEJ+McFphRlPfUYiB+yKDeLB6csmuODnrIYbvLtZAMzHwN9O3GL38sUIbVRBxYrr811IYn6CDn2BcuJiTPvB8058aL0bxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567308; c=relaxed/simple;
	bh=WdZbC4xC2N1aKtvrdJPt0oA9qnr6HeespGb7Br57/zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4xl3UaiPl+NH8Tdsjlv8UkixG4CahR/Ax55A5r0BUdXfuHsweUSCZOIC16csXt564NfW/sMb2e+rZXsSxvYKZm8sjvVcjfXbaXQb0B1lns7gXs/du173cyHYlGqO0rt1e3HhVl7Wj7SGQhr+AO504Q8yJxmp075BwKiRvyltLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx2O5rXO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso3404440a12.3;
        Tue, 17 Sep 2024 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726567306; x=1727172106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4DHtwYBbM0sOjga2wfGnDyYSgFCfAU3tu7m455ZVE8c=;
        b=Hx2O5rXOJ0ubZi0cR0rVCDlFMjV44BPZIBZDt+PA5hECUZkAXCS/UFW8XTBHZH9Ia2
         XVsEjkw6eh4XXoU7hGjHkwiLowQJewhkK70l80PSzj50OcdV2QsLJRVkjqdSkQzyK+Ib
         e5rDUgAlXgLZyPlnoo12sYmUk96zl/lEwRxaX76E2e/XV0gn0Gn0jesK7CasupYV4G8/
         DjZIsmrFn4p3vpCq4cOGQs+UUdhOimSrs9kr5wwtk7hH7xfwzchV0lHuolej9Ql12AdU
         ecZ1y1jXgFxRlH6hO6S7PPqbPOnj7Hf9RC8pGD9N1Ups4QyHv9OHf3o4I6ES49eRtJra
         il7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726567306; x=1727172106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DHtwYBbM0sOjga2wfGnDyYSgFCfAU3tu7m455ZVE8c=;
        b=bjOEY7yqLxZqb2rILcvHYuKZdEIVI2UTeUbkEm2GH5kMzrzNRwG6nE0QRq+XFoNXGy
         e+rHg0ykV+/rHQC1TLJt/ak1qpiWP46zW9q/MNCBtU4/KhE1D4/7WVtXp65qQXO4+Q4j
         x6a0o27EqtrDvppd35qeAYm2n8ZhoiT1eq+04dDfMz4FV7lMU2b8nc2A9q533/rES3J6
         Wx1vC+SYrs9O5xgaK23/bOrJ9Vm0FdJlmHLQhF3BhhGhfJsHHExJlqr6x6jurn3ri6EY
         THB3dlcrtdLuJOif9Jo1L1RWtXjOJp8S9vHVw5G4RkFWy+7fw4WSR7wM15fb0TW2whkV
         WHlw==
X-Forwarded-Encrypted: i=1; AJvYcCUGZVKIP8rAQlfKVs1vNrVnPnIY/XOPAomL/cBXLbB8GK8H1RtoJFkuVeNPOuV2hbHk8EFJ3k5gdo5INz0=@vger.kernel.org, AJvYcCVG7cjTr7E0PbfZhLBEYmsvV6cWlYnduOdtBHCM8rEB5lFHC4WYTJpxU8ky7cHs6VGsWGuJmAg4upei@vger.kernel.org
X-Gm-Message-State: AOJu0YxAshc7+d0uWASqeIgU/SH1zofmMW9ei38VBogr5HSzz3w/Eua7
	NIKgtnl2/gT+U0gqa5iD6TiAiRbaFQlJQPCffOcRYNYa4/MwRBZYCchF9wUCV6k/4ZBNQmfLG2P
	T4idgINxjd9ztn90iyp5v64BtRkI=
X-Google-Smtp-Source: AGHT+IFfBdHVrZzk+3LfT6kPSTUxjmW5AG3HHb3/lMnpikf6mm2Pg/QHYd3khZmyctdBjCrIeSG9N96Ej4tI4e8+Y3I=
X-Received: by 2002:a17:90a:ce06:b0:2ca:5a46:cbc8 with SMTP id
 98e67ed59e1d1-2dbb9f3a7e4mr17398317a91.26.1726567306453; Tue, 17 Sep 2024
 03:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916040629.28750-1-aha310510@gmail.com> <2024091648-excusable-unfilled-83de@gregkh>
 <15bc0f3a-5433-43e0-b0b0-8b9c26dec165@suse.com> <CAO9qdTHrbG-aWetpM_e7zHUhrwPD=7uCHPbWSMoorgnwjKEOmA@mail.gmail.com>
 <bf971924-9d91-40a3-a4c2-5b518e2ce2fd@suse.com> <CAO9qdTHWfYv8u-gJqGkuG_OSdkU9c=qZSnEbE+zCYWG5bT6r+Q@mail.gmail.com>
 <c96e95c2-aa59-4ef0-b211-c1cea71519ea@suse.com>
In-Reply-To: <c96e95c2-aa59-4ef0-b211-c1cea71519ea@suse.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 17 Sep 2024 19:01:35 +0900
Message-ID: <CAO9qdTH_+syAOBXUYT61VZMovDJYjCD1b-Who16Aqj4BXq8GLA@mail.gmail.com>
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, colin.i.king@gmail.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oliver Neukum <oneukum@suse.com> wrote:
>
> On 17.09.24 08:23, Jeongjun Park wrote:
> > Oliver Neukum <oneukum@suse.com> wrote:
>
> > Okay. But O_NONBLOCK flag check already exists, and I don't know
> > if we need to branch separately to mutex_trylock just because O_NONBLOCK
> > flag exists. I think mutex_lock_interruptible is enough.
>
> It will still block.
>
> > And the point of locking is too late. I think it would be more appropriate to
> > read file->private_data and then lock it right away.
>
> You are right. dev->present should be checked under the lock only.
>
> > I think this patch is a more appropriate patch:
> >
> > ---
> >   drivers/usb/misc/iowarrior.c | 41 +++++++++++++++++++++++++++---------
> >   1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> > index 6d28467ce352..6fb4ecebbc15 100644
> > --- a/drivers/usb/misc/iowarrior.c
> > +++ b/drivers/usb/misc/iowarrior.c
> > @@ -277,28 +277,40 @@ static ssize_t iowarrior_read(struct file *file,
> > char __user *buffer,
> >      struct iowarrior *dev;
> >      int read_idx;
> >      int offset;
> > +   int retval = 0;
> >
> >      dev = file->private_data;
> >
> > +   if (mutex_lock_interruptible(&dev->mutex)) {
>
> This blocks. To quote the man page:
>
>         O_NONBLOCK or O_NDELAY
>                When  possible,  the file is opened in nonblocking mode.
>                 Neither the open() nor any subsequent I/O operations on the file descriptor which is
>                returned will cause the calling process to wait.
>
>

Okay, I understand. Then I think it would be appropriate to do
the patch below to prevent blocking, but I have one question.

Currently, many misc usb drivers do not seem to handle the
O_NONBLOCK flag when using mutex_lock. If this is really
necessary code, I think it would require code modifications to
other functions inside iowarrior and many misc usb drivers.

What do you think about this?

Regards,
Jeongjun Park

---
drivers/usb/misc/iowarrior.c | 46 ++++++++++++++++++++++++++++--------
1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..dbf0ed04f7c3 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -277,28 +277,45 @@ static ssize_t iowarrior_read(struct file *file,
char __user *buffer,
struct iowarrior *dev;
int read_idx;
int offset;
+ int retval = 0;
dev = file->private_data;
+ if (file->f_flags & O_NONBLOCK) {
+ retval = mutex_trylock(&dev->mutex);
+ if (!retval)
+ return -EAGAIN;
+ } else {
+ retval = mutex_lock_interruptible(&dev->mutex);
+ if (retval)
+ return -ERESTARTSYS;
+ }
+
/* verify that the device wasn't unplugged */
- if (!dev || !dev->present)
- return -ENODEV;
+ if (!dev->present) {
+ retval = -ENODEV;
+ goto exit;
+ }
dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
dev->minor, count);
/* read count must be packet size (+ time stamp) */
if ((count != dev->report_size)
- && (count != (dev->report_size + 1)))
- return -EINVAL;
+ && (count != (dev->report_size + 1))) {
+ retval = -EINVAL;
+ goto exit;
+ }
/* repeat until no buffer overrun in callback handler occur */
do {
atomic_set(&dev->overflow_flag, 0);
if ((read_idx = read_index(dev)) == -1) {
/* queue empty */
- if (file->f_flags & O_NONBLOCK)
- return -EAGAIN;
+ if (file->f_flags & O_NONBLOCK) {
+ retval = -EAGAIN;
+ goto exit;
+ }
else {
//next line will return when there is either new data, or the device
is unplugged
int r = wait_event_interruptible(dev->read_wait,
@@ -309,28 +326,37 @@ static ssize_t iowarrior_read(struct file *file,
char __user *buffer,
-1));
if (r) {
//we were interrupted by a signal
- return -ERESTART;
+ retval = -ERESTART;
+ goto exit;
}
if (!dev->present) {
//The device was unplugged
- return -ENODEV;
+ retval = -ENODEV;
+ goto exit;
}
if (read_idx == -1) {
// Can this happen ???
- return 0;
+ retval = 0;
+ goto exit;
}
}
}
offset = read_idx * (dev->report_size + 1);
if (copy_to_user(buffer, dev->read_queue + offset, count)) {
- return -EFAULT;
+ retval = -EFAULT;
+ goto exit;
}
} while (atomic_read(&dev->overflow_flag));
read_idx = ++read_idx == MAX_INTERRUPT_BUFFER ? 0 : read_idx;
atomic_set(&dev->read_idx, read_idx);
+ mutex_unlock(&dev->mutex);
return count;
+
+exit:
+ mutex_unlock(&dev->mutex);
+ return retval;
}
/*
--

>
> [..]
> > +unlock_exit:
> > +   mutex_unlock(&dev->mutex);
> > +exit:
> > +   return retval;
>
> The rest looks good to me.
>
>         Regards
>                 Oliver
>

