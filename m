Return-Path: <linux-kernel+bounces-330248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CAD979B84
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF66281090
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0630084D34;
	Mon, 16 Sep 2024 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1D/ZAl0R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E6537F5;
	Mon, 16 Sep 2024 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469413; cv=none; b=XN870FYbJ865MCJJJTa82kTUHIq9XHxp28+jFbz7Jqv75VJvUpInjwqNkshqcaB8t4e5ojU4xgZeum4hoy+/GzruKpEKFa2LTVSvypxmonVCxd3dOCqAQZM+dEvrYOVkt4OVSnVd9d+6rCXRZlcjsSvaQoIklyb7HFHHo8IqYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469413; c=relaxed/simple;
	bh=GxHk/xrFXYov3d1t2q6REcdnGozK9lGHAQk2s4rVGv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaFiFoONkax6jHmarYdwae6u0t1TYtEvdLHppclYrOS94nylziJB4QVtPbQYPRwpefYmSwD47vICKfmGnl3nMDfYdL+nUCdY1T55A37ininDsFsq7rKAyvRi0ietAnz3o5Eg68iiW1E6tBwbjSJAM+wUm0ZJ8JH6UdLPaUOGu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1D/ZAl0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC52C4CEC4;
	Mon, 16 Sep 2024 06:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726469412;
	bh=GxHk/xrFXYov3d1t2q6REcdnGozK9lGHAQk2s4rVGv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1D/ZAl0RVmtqm9US99vyDuECyGRRRgVIfnIFnwGU5H58vcajQ8KZ4X4L7WK7n+FXT
	 uLowrq1KQ8SkfQbDkJnUQ2Bg9qo2rVCYJ4Ld5X38vU8c9CKYMH8vRZS87spWszqvtW
	 Gh2ny002nw9WJBoqcRMIaOASrs6S+dxa2/EkfCAI=
Date: Mon, 16 Sep 2024 08:50:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: colin.i.king@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
Message-ID: <2024091659-showing-bulge-196b@gregkh>
References: <20240916040629.28750-1-aha310510@gmail.com>
 <2024091648-excusable-unfilled-83de@gregkh>
 <CAO9qdTHPA6cUWc+T8pcO8_tUpJ5PZ4UgmyP6oA+R5bEH8nX5pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9qdTHPA6cUWc+T8pcO8_tUpJ5PZ4UgmyP6oA+R5bEH8nX5pQ@mail.gmail.com>

On Mon, Sep 16, 2024 at 01:43:22PM +0900, Jeongjun Park wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Sep 16, 2024 at 01:06:29PM +0900, Jeongjun Park wrote:
> > > Currently, iowarrior_read() does not provide any protection for the
> > > iowarrior structure, so the iowarrior structure is vulnerable to data-race.
> > >
> > > Therefore, I think it is appropriate to protect the structure using
> > > mutex_lock in iowarrior_read().
> > >
> > > Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
> > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > ---
> > >  drivers/usb/misc/iowarrior.c | 42 +++++++++++++++++++++++++++---------
> > >  1 file changed, 32 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> > > index 6d28467ce352..7f3d37b395c3 100644
> > > --- a/drivers/usb/misc/iowarrior.c
> > > +++ b/drivers/usb/misc/iowarrior.c
> > > @@ -277,28 +277,41 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
> > >       struct iowarrior *dev;
> > >       int read_idx;
> > >       int offset;
> > > +     int retval = 0;
> > >
> > >       dev = file->private_data;
> > >
> > > +     if (!dev) {
> >
> > How can this happen?  How was this tested?
> >
> > And you didn't mention this in your changelog, why?
> 
> There is no separate reproduction code or bug report. However, all other
> functions in iowarrior use mutex_lock to protect the iowarrior structure.
> Only iowarrior_read does not use mutex_lock, which could potentially cause
> bugs.

But if you don't have a report, and don't have this device, how can you
test this to make sure?

> There is no reason why this function should not use mutex_lock,
> so I think adding a lock is appropriate.

Fair enough, but do it properly please.

> > > +             retval = -ENODEV;
> > > +             goto exit;
> > > +     }
> >
> > What prevents dev from becoming invalid after it is checked here?
> 
> I'm not sure what this means. Can you explain it in more detail?

What happens if the private_data pointer becomes "stale" right after
checking it is not NULL?  You need to explain how it is safe, if it is,
to do this.

Actually, what ever sets this to NULL?  I think this check isn't needed
at all from looking at the code (hint, think about the lifetime of the
file pointer...)

> > > +     mutex_lock(&dev->mutex);
> >
> > Please use the guard() form here, it makes the change much simpler and
> > easier to review and maintain.
> 
> I didn't know such a convenient function existed. It certainly seems like
> it would make maintenance easier, but it also seems like it would be a
> good idea to consistently replace all mutex_locks in iowarrior.c with guard().
> 
> What do you think?

Unless you have the hardware to test this, I would not worry about doing
conversions like this.  I think I have this device somewhere around in
my "big box of USB devices", but testing any driver changes for it will
take a while before I can find it.

Actually, in looking at the code further, I think the lock is not taken
on purpose, so if you want to change this, you will have to document why
it is now really needed and what will happen if it is not.

thanks,

greg k-h

