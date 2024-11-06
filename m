Return-Path: <linux-kernel+bounces-397612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527AC9BDE06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC67B2196F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BFC18FDD0;
	Wed,  6 Nov 2024 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNOEvHrA"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0276035;
	Wed,  6 Nov 2024 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730868098; cv=none; b=UkHoCjYv985JFwqfGW2F2aKb8JzXoh98ZdA/XWjK0qtw/qESgryPXSC0dJ4mOK81hn/6qWzzCjiqeGGWofeG4E4gBHuVnZ9G4qZ76NQnRf8JMa+LAMp1EeulEQeTYpc4ozGGf59ZYBMP0wjKZVFAOxNfYxh61HUgLKroaNTgqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730868098; c=relaxed/simple;
	bh=a3kPPYjIRIN/3QOvg0X/FZ1sOzZHClzrBy1WZEtiVbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUp/NWwTaC+xbxaDXDsnLhbDZTpdsssiOmeghl0oK22WFy7jSb5lfBOC4h3tgHiXw41ThT3FqsRtqY8keNDi/2eEe9vj/yi2XEUO8oXdy6hJCf5YgLg5kwv3H/FGoda7AznANgEZbfIwbL0Ou3qBnKvZF/0dPFRr6WPHDNiebFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNOEvHrA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso4804830a91.0;
        Tue, 05 Nov 2024 20:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730868095; x=1731472895; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xSt1Z8nH5i3zaXssa4lfvezrmeVDrRGTixwKKJ1lv+0=;
        b=jNOEvHrATrhSSNEmtGDH4TUk3JENuKCT3vmidDIxuB0mqcVQ/oQat//BUFOetWb9FP
         cGBPGdQMbzEwF1awX/xCntPcu7dM+lDpixe3Tre7cYBuGjlp0bkNl3MnJyZbiosO4vF1
         reabiJ3nhZi7nKW0s0bGOWLavJWDAkEOhr6bDPnAgxhJYGMaZBzPYsV/+/UGOUYgTmT7
         wZJPS0xTFgdr51SvP04hxGZAxF6xA9JCrn+a8RZxHCMwlEvRf7spoPQ8mEmXjM0auwYC
         svw8WWLQcP3t9SYxsPP5zxdgt1pE69bpA4tSuq50wkkJRcNDvykxK+LEoLvy5Auju4AL
         YpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730868095; x=1731472895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSt1Z8nH5i3zaXssa4lfvezrmeVDrRGTixwKKJ1lv+0=;
        b=TfXt3IguD2apbllvchw4RqQL8glOWS57xHqnMNnWm0kYABPTqLM1qA21sRw3MYo9IC
         hGBeZGOBFpbSb5ppoJMwkoMtQDYPkyI1FxGp+OTuMvoN6SV8CIagSfEpZpOeZiS5iUkl
         4QSRwBIyoeiwUO1OmRKha58CCC4u5bGx9bKscey6y0cJjFjVXqmQQ41W6fTsVT2nLpSM
         r33eCGwGYpmEZSK6OvpHeSVmsbwt//vGbM/QpaM/m5LTbtWYHG0VrQvnb0rDhkumhUlP
         GoHaIMejxksL6ODsUcnn7hac1MlKmhjGVQlErr/gEIyokEBmH7aybS9Zim6FvbqIcjtY
         6rnA==
X-Forwarded-Encrypted: i=1; AJvYcCVZFRnvp0YmtN9LnNBvSs/10q2Ymvys/cj0K9umO2grEFzA64fCMaPwRUbrqIVoPNLSWI3m1iSprg9BsVk=@vger.kernel.org, AJvYcCWciphUcbAOd9drS4AaotwAOGktL6lPbLMi9C4dwcIuc0X7azirU1lQx5/eEBzhi/ZlKFt+mIG6zhcb@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhhoAHapp/2SDPUoBeSVHUxsZ/NB2Bbf0RD6vKXEx9xnxG/zP
	2jmH5h+v/FqciLJVIMZU1rjyIdIxFjfkrNTKQSaptiOPtwMc5qvA
X-Google-Smtp-Source: AGHT+IHXNq8MOh7oKgc6IryARd09Yz5IZxKtUEnfc4FT5qo7ZMc+Kb1X4jR6PtRgYzebIlZbYNjQxw==
X-Received: by 2002:a05:6a20:6a04:b0:1db:eecb:f7a1 with SMTP id adf61e73a8af0-1dbeecbf839mr7831274637.17.1730868094773;
        Tue, 05 Nov 2024 20:41:34 -0800 (PST)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d380fsm86999455ad.240.2024.11.05.20.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 20:41:34 -0800 (PST)
Date: Tue, 5 Nov 2024 20:41:32 -0800
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
	skhan@linuxfoundation.org,
	syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: raw_gadget: Add debug logs to a troubleshoot a
 double-free bug in raw_release.
Message-ID: <ZyrzfBtNhPjwRFZk@gmail.com>
References: <Zyrsg3bvNu1rswqb@gmail.com>
 <CA+fCnZeThG-J7kCraPbr4NCpys=jne3dD4sOLT_0h6iPw2YZEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZeThG-J7kCraPbr4NCpys=jne3dD4sOLT_0h6iPw2YZEw@mail.gmail.com>

On Wed, Nov 06, 2024 at 01:35:27PM +0900, Andrey Konovalov wrote:
> On Wed, Nov 6, 2024 at 1:11 PM Chang Yu <marcus.yu.56@gmail.com> wrote:
> >
> > syzkaller reported a double free bug
> > (https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c) in
> > raw_release.
> >
> > From the stack traces it looks like either raw_release was invoked
> > twice or there were some between kref_get in raw_ioctl_run and
> > kref_put raw_release. But these should not be possible. We need
> > more logs to understand the cause.
> >
> > Make raw_release and raw_ioctl_run report the ref count before
> > and after get/put to help debug this.
> >
> > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> > Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
> > ---
> >  drivers/usb/gadget/legacy/raw_gadget.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > index 112fd18d8c99..ac4e319c743f 100644
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -194,6 +194,8 @@ static struct raw_dev *dev_new(void)
> >                 return NULL;
> >         /* Matches kref_put() in raw_release(). */
> >         kref_init(&dev->count);
> > +       dev_dbg(dev->dev, "%s kref count initialized: %d\n",
> > +               __func__, kref_read(&dev->count));
> >         spin_lock_init(&dev->lock);
> >         init_completion(&dev->ep0_done);
> >         raw_event_queue_init(&dev->queue);
> > @@ -464,13 +466,21 @@ static int raw_release(struct inode *inode, struct file *fd)
> >                         dev_err(dev->dev,
> >                                 "usb_gadget_unregister_driver() failed with %d\n",
> >                                 ret);
> > +               dev_dbg(dev->dev, "%s kref count before unregister driver put: %d\n",
> > +                               __func__, kref_read(&dev->count));
> >                 /* Matches kref_get() in raw_ioctl_run(). */
> >                 kref_put(&dev->count, dev_free);
> > +               dev_dbg(dev->dev, "%s kref count after unregister driver put: %d\n",
> > +                               __func__, kref_read(&dev->count));
> >         }
> >
> >  out_put:
> > +       dev_dbg(dev->dev, "%s kref count before final put: %d\n",
> > +                       __func__, kref_read(&dev->count));
> >         /* Matches dev_new() in raw_open(). */
> >         kref_put(&dev->count, dev_free);
> > +       dev_dbg(dev->dev, "%s kref count after final put: %d\n",
> > +                       __func__, kref_read(&dev->count));
> >         return ret;
> >  }
> >
> > @@ -603,8 +613,12 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
> >         }
> >         dev->gadget_registered = true;
> >         dev->state = STATE_DEV_RUNNING;
> > +       dev_dbg(dev->dev, "%s kref count before get: %d\n",
> > +                       __func__, kref_read(&dev->count));
> >         /* Matches kref_put() in raw_release(). */
> >         kref_get(&dev->count);
> > +       dev_dbg(dev->dev, "%s kref count after get: %d\n",
> > +                       __func__, kref_read(&dev->count));
> >
> >  out_unlock:
> >         spin_unlock_irqrestore(&dev->lock, flags);
> > --
> > 2.47.0
> >
> 
> Hi Chang,
> 
> This patch looks very specific to the bug we're trying to debug - I
> don't think it makes sense to apply it to the mainline.
> 
> What you can do instead is ask syzbot to run the reproducer it has
> with this patch applied via the #syz test command.
> 
> Thank you!
Thank you for the tips, Andrey. I will do that. My apologies for the
rookie mistake. I'm pretty new to kernel patching/debugging and I'm
still learning the correct way to do stuff.

Thank you again for your help!

