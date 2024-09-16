Return-Path: <linux-kernel+bounces-330669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8637397A27C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A956D1C21761
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F4315575B;
	Mon, 16 Sep 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIJN6Ws7"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555714EC5B;
	Mon, 16 Sep 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490682; cv=none; b=IMY5vaHTaekT5rzITmabnrhbvLXnn8EByGEA7KvarkkTx0jjuwIC87GTwBqUt18OtRkfd7Dl1pzV7ii2Ksz3HigzXvst0prhmVrn52Eno3EoKVixb2m3CCbOF5HGu9V7P6Anw8R2wb4MrmngF7G/Jrp966L4+elqbuv0dqBibzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490682; c=relaxed/simple;
	bh=bheAwwYKEF9jdayvrWrIhKvlIL364z6xyhpEHC0Mk/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLzTszSGmocHuPanE4uOfwsAnKIi2xMbP2KofJtBNKLJ02K+/uFjDqmcZEGYohLGkgyVCNzx51rZMDtXoPoGvXexwqLUsr7ThNfZcV1LD6Skp1bTdeY8cpXjdyCMNb8RIjk6kgY/gnUAcqM2fHHKK/6xDbHDtnDnwf8IT8ZaD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIJN6Ws7; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so3333517a12.3;
        Mon, 16 Sep 2024 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726490680; x=1727095480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B86QunxMGfb+fh94/UdDGBoKMwXBvb8I5JYFZKksx3w=;
        b=fIJN6Ws7KbmWfmVCO+GY02RzF6xuSLNitNwx+0F+tBkcD4uOdTBjPdNNlul8lAIxwA
         1UlWJr2C3LqsOBAyqYkrTfDe3kUB98wRb2BreFkhWSxBamhV5FM/zxs1wvmA8mRncgr6
         RVdCqYPjN9lyXh7WLQlEDrWdC51V3aGPe2hRAsu/OfY/fVpDSjj+Kk8MKL3NG/fxlPoi
         L2Y+WVvfF0weMKVsw2dGUsvFE8tUPKvBX6RHWOKQLOxye31xM3DpUN6Qw/yUO5YR0oKm
         chTvMMfvFEZOAfFk20XsA0WQuo3Yhe9HXk+2ls5MlI9T7GrW3heVyB/Dnn8nX5t8uy4A
         pfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726490680; x=1727095480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B86QunxMGfb+fh94/UdDGBoKMwXBvb8I5JYFZKksx3w=;
        b=IUfuG4xfyfB5izcq8YirXYG3i/FEOA//xXukRSsAC90S1cccxbCNINyg+zDAgXdJ9f
         I2IveNaLHNOUk0C4YtwaL3i3gF1eRtheVdF2Gd/r6voojym+YGohonCLp/+m8R8dXOGR
         ls82tMqLEQ9P3yg2zGZ7sV5n37jJzSDTiQY+CkCwZQpEvnRMRzU2imAZyOSklu1CiulM
         UXr/SvdgLk16BLpVuUXheiSTdzUEFMqmiEbZxl4U7YK7nfG7BqLYx8jaN0ueh69GFkjc
         xPw+8bxgsvS/tbBpj3OhSjOd+iDAyNUxwP6WK0fpvN8lgu87Pt9FWXeBGsIqFDQv7+z/
         Z23g==
X-Forwarded-Encrypted: i=1; AJvYcCUYQvMjFo7OcijaqyOtUlqyJAsrWaCRFagrsGZHhp400lW1EqAh0kR+5DAjWXofHXSTwH6CAGsG48xHjZs=@vger.kernel.org, AJvYcCW0hUbiSfHedaOh4jYbkmlhopfe9m1YDYTdjScr1PI100e1HKMe02HcvQp+t56oRStWj+S1We2JZkvt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DboRKbASiBja129DapJXs44F9Out2zEutKcWtJru2hcevwQ1
	fP0Zk2WgqPxJBAryEDWnTjzZ0Ig8zJzooQFh/CywLiTJ15v78vRWE3JjcNGaGmgOFWMmj2de39u
	M4zMKJhbY0cfqb1kvQ1EEgbj1Mzc=
X-Google-Smtp-Source: AGHT+IER1M6K9eOZWTNzSbC1+DwM5j+7eWDNKlezTwrscP6Iauu1UZ0r0grYobbxUSEmrSmBGtY8F+qcBYD0KJ6uNSQ=
X-Received: by 2002:a17:90b:906:b0:2d8:ca33:42a5 with SMTP id
 98e67ed59e1d1-2dba0068174mr15974458a91.40.1726490680209; Mon, 16 Sep 2024
 05:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916040629.28750-1-aha310510@gmail.com> <2024091648-excusable-unfilled-83de@gregkh>
 <15bc0f3a-5433-43e0-b0b0-8b9c26dec165@suse.com>
In-Reply-To: <15bc0f3a-5433-43e0-b0b0-8b9c26dec165@suse.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 16 Sep 2024 21:44:28 +0900
Message-ID: <CAO9qdTHrbG-aWetpM_e7zHUhrwPD=7uCHPbWSMoorgnwjKEOmA@mail.gmail.com>
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, colin.i.king@gmail.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oliver Neukum <oneukum@suse.com> wrote:
>
>
>
> On 16.09.24 06:15, Greg KH wrote:
> > On Mon, Sep 16, 2024 at 01:06:29PM +0900, Jeongjun Park wrote:
> >> Currently, iowarrior_read() does not provide any protection for the
> >> iowarrior structure, so the iowarrior structure is vulnerable to data-race.
> >>
> >> Therefore, I think it is appropriate to protect the structure using
> >> mutex_lock in iowarrior_read().
> >>
> >> Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
> >> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> >> ---
> >>   drivers/usb/misc/iowarrior.c | 42 +++++++++++++++++++++++++++---------
> >>   1 file changed, 32 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> >> index 6d28467ce352..7f3d37b395c3 100644
> >> --- a/drivers/usb/misc/iowarrior.c
> >> +++ b/drivers/usb/misc/iowarrior.c
> >> @@ -277,28 +277,41 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
> >>      struct iowarrior *dev;
> >>      int read_idx;
> >>      int offset;
> >> +    int retval = 0;
> >>
> >>      dev = file->private_data;
> >>
> >> +    if (!dev) {
> >
> > How can this happen?  How was this tested?
>
> It cannot happen.
>
> [..]
> >> +    mutex_lock(&dev->mutex);
> >
> > Please use the guard() form here, it makes the change much simpler and
> > easier to review and maintain.
>
> That would break the O_NONBLOCK case.
>
> Looking at the code it indeed looks like iowarrior_read() can race
> with itself. Strictly speaking it always could happen if a task used
> fork() after open(). The driver tries to restrict its usage to one
> thread, but I doubt that the logic is functional.
>
> It seems to me the correct fix is something like this:

Well, I don't know why it's necessary to modify it like this.
I think it would be more appropriate to patch it to make it
more maintainable by using guard() as Greg suggested.


>
>  From 1627bc3a8e9aae60bdfc85430db2a44283e71a68 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oneukum@suse.com>
> Date: Thu, 12 Sep 2024 12:47:33 +0200
> Subject: [PATCH] iowarrior: fix read racing against itself case
>
> In a multithreaded application iowarrior_read() can race against itself.
> It needs to take the mutex.
>
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>   drivers/usb/misc/iowarrior.c | 33 ++++++++++++++++++++++++++-------
>   1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> index 6d28467ce352..3b49d6c7b569 100644
> --- a/drivers/usb/misc/iowarrior.c
> +++ b/drivers/usb/misc/iowarrior.c
> @@ -277,6 +277,8 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
>         struct iowarrior *dev;
>         int read_idx;
>         int offset;
> +       int result;
> +       bool nonblock = file->f_flags & O_NONBLOCK;
>
>         dev = file->private_data;
>
> @@ -292,14 +294,25 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
>             && (count != (dev->report_size + 1)))
>                 return -EINVAL;
>
> +       if (nonblock) {
> +               result = mutex_trylock(&dev->mutex);
> +               if (!result)
> +                       return -EAGAIN;
> +               result = 0;
> +       } else {
> +               result = mutex_lock_interruptible(&dev->mutex);
> +               if (result < 0)
> +                       return -EINTR;
> +       }
>         /* repeat until no buffer overrun in callback handler occur */
>         do {
>                 atomic_set(&dev->overflow_flag, 0);
>                 if ((read_idx = read_index(dev)) == -1) {
>                         /* queue empty */
> -                       if (file->f_flags & O_NONBLOCK)
> -                               return -EAGAIN;
> -                       else {
> +                       if (nonblock) {
> +                               result = -EAGAIN;
> +                               goto out;
> +                       } else {
>                                 //next line will return when there is either new data, or the device is unplugged
>                                 int r = wait_event_interruptible(dev->read_wait,
>                                                                  (!dev->present
> @@ -309,14 +322,17 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
>                                                                   -1));
>                                 if (r) {
>                                         //we were interrupted by a signal
> -                                       return -ERESTART;
> +                                       result = -ERESTART;
> +                                       goto out;
>                                 }
>                                 if (!dev->present) {
>                                         //The device was unplugged
> -                                       return -ENODEV;
> +                                       result = -ENODEV;
> +                                       goto out;
>                                 }
>                                 if (read_idx == -1) {
>                                         // Can this happen ???
> +                                       mutex_unlock(&dev->mutex);
>                                         return 0;
>                                 }
>                         }
> @@ -324,13 +340,16 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
>
>                 offset = read_idx * (dev->report_size + 1);
>                 if (copy_to_user(buffer, dev->read_queue + offset, count)) {
> -                       return -EFAULT;
> +                       result = -EFAULT;
> +                       goto out;
>                 }
>         } while (atomic_read(&dev->overflow_flag));
>
>         read_idx = ++read_idx == MAX_INTERRUPT_BUFFER ? 0 : read_idx;
>         atomic_set(&dev->read_idx, read_idx);
> -       return count;
> +out:
> +       mutex_unlock(&dev->mutex);
> +       return result < 0 ? result : count;
>   }
>
>   /*
> --
> 2.45.2
>
>

