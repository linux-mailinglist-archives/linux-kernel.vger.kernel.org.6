Return-Path: <linux-kernel+bounces-330153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA978979A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2AF1F2343C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB2224FD;
	Mon, 16 Sep 2024 04:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLrVCw/D"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502441C71;
	Mon, 16 Sep 2024 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726461816; cv=none; b=WSZSK8mpjB7AfGNTAcC4JQg5KLGyS4gSciVBvdKV10Sl7N4+9R+U374rnGPLiCX4Tbbyfqt94IrdAScOZu4FGOsZ/Qw9cJZMFADqD8GQl5KQqaqlmHNCKiXipJ7C4L4jCsq01m8W77cWc7ZSc+SyEYUAFhrZjYLwjBgd2fVMqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726461816; c=relaxed/simple;
	bh=ZeZmp2jaqMB+hbBlYQkjKDos43cdAC6oZwwwcJ8/rwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYs7m68Pf7DpVnJa6hiCrhsm993sH4kQNiZNW331Wkz4s3Tzlzef9sTbJ4K97VMVHlhAtMTT3y6nq4eBqvFi1pkC7RH+1D83cLH8XizSp5NBCAI9P46UDMr7sJX8JpF8e7hBiSUiMcbYbTK+wn2IFtQsMQWV9ICP6NxNEZbGE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLrVCw/D; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so3550186a91.1;
        Sun, 15 Sep 2024 21:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726461815; x=1727066615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jc4DBkxkMDzV5V8zKj5Rd2iVFxJc77hDWl6rcVj69Aw=;
        b=JLrVCw/DKlOfckBsOUowOT3CkM1RAxMhNTQK+EA/dN5vKKn7EPDL1aKuP47SzzKzhK
         6YgyoghG4FfXVlPHYhX5SCqWUF+KLInNBSG3vKbwglw1SHS+4w1qubhpQt5cVIUrDnWl
         l4+wqs6wsKFPvPKA7QArSQwnCt0vqeVSBxSHKs+tLKz6YiFXSCAbPI7unzDjMzvyJgWN
         9TAhMOAfglIMzbLzqVC8iCP92cMHetk2zPde/XALiPwLYIH1w8/0lS9xHAjM0TXW2yjw
         dBv6iHTRq+BhUtKL8prhdJNEv/rePZ6rK/1Re0H3UxA88QcSNkNpZGy8TO5o+NNK8Twv
         rCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726461815; x=1727066615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jc4DBkxkMDzV5V8zKj5Rd2iVFxJc77hDWl6rcVj69Aw=;
        b=crkPZBB4BvfrCU/iKY2bw12t6OfBLDSVqt7ub1zoiF7Qyl2CrhtqLX2KpxHvEeLICz
         kpdgE8z+qYOnE6CjEFQfQqavgBNlnCqwjkyzgLeExX/3SHu7qRv2+5SNfFCrE6wb6f6I
         mdDEvyETcJ//0YQDEGLW/1KXqSbMWkE7uQ1pr8zd5W0udYdRY+FfQtJTQaQnRI7FArHr
         9GevtFe1fnjRthef3WBtgp579bAGRdKS1TCApw8W0D4oUdj6kwNc1F5xzgV/y46/xlB5
         sGzON7ePCchGtaSvZZZjT09gHHX35eyeWXmRiOEQ4Y9Dn/4hXImX5Z7xPXqpVLQw2pb6
         hn0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYc6YSc0+qghUKwC6UWEyq+jYUNP7cFESIVSOQJfQeckG8Bfz2knp5WfjX1PA5uMBx2NMup20G3SmqmFk=@vger.kernel.org, AJvYcCVNE1HzTs9ZmxVnhO79Bbzw4uvsg+FBV5nBtiHrbgJ25XPKD0XNJzCbEG4Sok2ZZggmxcvH1Oiff9MH@vger.kernel.org
X-Gm-Message-State: AOJu0YxEWYJ1pUeqoWGGXfmarxULVubgQ32GxC7RYC5gMr+Y9MtY0ZoO
	flUE2Dr3+gEU9F32Bv7C4ROXx2GezgoNkqRxka36ABUwcTdaYz3oZ9R3SWuDDswepD7427QnpAt
	iy2vmxbzSl6Wkb1ruIBklV9mHFy5ZhNUY
X-Google-Smtp-Source: AGHT+IFVkEmZ9LA3nWy1Uwdnipyak8kl47qIzEVnN5pQT/FFXyK/ln/KY4JeG1Za8apUWqNoR2TdY1rOOfLGLI8Ilh0=
X-Received: by 2002:a17:90b:2285:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2db9fc1bf48mr21436914a91.3.1726461814523; Sun, 15 Sep 2024
 21:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916040629.28750-1-aha310510@gmail.com> <2024091648-excusable-unfilled-83de@gregkh>
In-Reply-To: <2024091648-excusable-unfilled-83de@gregkh>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 16 Sep 2024 13:43:22 +0900
Message-ID: <CAO9qdTHPA6cUWc+T8pcO8_tUpJ5PZ4UgmyP6oA+R5bEH8nX5pQ@mail.gmail.com>
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: colin.i.king@gmail.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 16, 2024 at 01:06:29PM +0900, Jeongjun Park wrote:
> > Currently, iowarrior_read() does not provide any protection for the
> > iowarrior structure, so the iowarrior structure is vulnerable to data-race.
> >
> > Therefore, I think it is appropriate to protect the structure using
> > mutex_lock in iowarrior_read().
> >
> > Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  drivers/usb/misc/iowarrior.c | 42 +++++++++++++++++++++++++++---------
> >  1 file changed, 32 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> > index 6d28467ce352..7f3d37b395c3 100644
> > --- a/drivers/usb/misc/iowarrior.c
> > +++ b/drivers/usb/misc/iowarrior.c
> > @@ -277,28 +277,41 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
> >       struct iowarrior *dev;
> >       int read_idx;
> >       int offset;
> > +     int retval = 0;
> >
> >       dev = file->private_data;
> >
> > +     if (!dev) {
>
> How can this happen?  How was this tested?
>
> And you didn't mention this in your changelog, why?

There is no separate reproduction code or bug report. However, all other
functions in iowarrior use mutex_lock to protect the iowarrior structure.
Only iowarrior_read does not use mutex_lock, which could potentially cause
bugs.

There is no reason why this function should not use mutex_lock,
so I think adding a lock is appropriate.

>
> > +             retval = -ENODEV;
> > +             goto exit;
> > +     }
>
> What prevents dev from becoming invalid after it is checked here?

I'm not sure what this means. Can you explain it in more detail?

>
> > +
> > +     mutex_lock(&dev->mutex);
>
> Please use the guard() form here, it makes the change much simpler and
> easier to review and maintain.

I didn't know such a convenient function existed. It certainly seems like
it would make maintenance easier, but it also seems like it would be a
good idea to consistently replace all mutex_locks in iowarrior.c with guard().

What do you think?

Regards,
Jeongjun Park

>
> thanks,
>
> greg k-h

