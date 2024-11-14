Return-Path: <linux-kernel+bounces-408733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3348C9C82DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CDFB22D88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E311EABB7;
	Thu, 14 Nov 2024 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbjMKo+J"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A41E0E13;
	Thu, 14 Nov 2024 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731563945; cv=none; b=tPWYdyvDSQxbd0FQIhE288Ittf9BqZfvqCUgNbXCWJXFst/WIG2Zw1iolHpN2ne2YJ1tvJuh060+pnQXF2xiX3ZYS3qVb1008rDKkCT+l7QIy8RaU7jUls6O9RZ9ndGm/zuSwUzJRW7ava1S01N67/o6wEAex05duU/PZso5Nn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731563945; c=relaxed/simple;
	bh=m5RNQX589b8U5weqVXxx/5P0ZIM0GhikJRyrRUPshLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV9vwVqfqew2dnMkmiQuoxTK+TKiqDyx+2fehWTLZdDxkTcn8bV9herKGCcVe3+KYF3ARN2yUeLZPaInq1AKcT99qYmeKHWyMqgtH8jAm9guXhrpaSCZ1zGl5C9DfhRNpx2DVLsJw3vD3MWYmxnvBLXPHusd8HlJbbZohY351HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbjMKo+J; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so358766a12.0;
        Wed, 13 Nov 2024 21:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731563942; x=1732168742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7iq5uzJgMVgbSj4LhpTblR/TyuPEKIv+Cs9kUPLXUU=;
        b=NbjMKo+JYeMdVR+cDaqT52BGy4RUrik9PE4xfONCbOolC4yFy96EXnHjtw/7F2E7xA
         39hPiC+4bIXJzl48BUEy1Y0NxQJMKBm590IkbCzWskW4tHsl6W1tmbFzVHhTzcISNmtQ
         2SYjqxLTWpBqgSC2y5HIcBfqei5ToCpduF98lDw91FOK/0mGCDcs8ix2vuqNvALAY8gh
         CJx4G7J5asFOn4vYKnuNH4uaBBemCPiuh7F9hjmB+lLJ0fqGcowXCTfPrKCN83Hqd9YX
         4HoKzcXrjPWoxJ+e/v6MVTJ0cClKFuuA7kQa3nRt56dnsBD424+JeXWL/FAru6b1zy+Y
         uHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731563942; x=1732168742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7iq5uzJgMVgbSj4LhpTblR/TyuPEKIv+Cs9kUPLXUU=;
        b=xAq9llC+0s7i1tubd8li3+vZf+D51vs5Q0VP/A7Z2MdyGxcoLg8gT80tzNuEKGR2/D
         goPoVc6UnXARUFDqhjDrxWZ1YFrgX7ie2WVJitWclWMwlsqGgZ3pcagCDp+ff3SxSkF9
         g81iTkztH7azEct43FVWelf4GeZwNjBd23yZ4wal9b+IRM1Pnu8bqR0pAFeTxzx96P3p
         xamJyE/NEdkIVN/xpTOhPLlR+mwk+4k/yp8YyUKcadX/p+xrIB3KqvvSPdhXrs/agXrH
         hdR2CXuOlV3fw4avy4Vy57eS3q7UN/i6N+3Ljcvqm7vPYbHT4mxF3l78WCOQQx1vVFS/
         gqRA==
X-Forwarded-Encrypted: i=1; AJvYcCVTsZmb2CJ6z0EHYxyGzcTxjhUcjs4smvcuDYgcLBI3WC8Ugoy3xRiAbFPv1k+7qIzxd+0t67Rtx49MxCk=@vger.kernel.org, AJvYcCXDiaBGUHJe9w0d9lYguOZmyUEN2X02BkmWwVBtjFFIQZWsz8Mrsv/grNpTiGGIfpJGftEg57+9fo/t@vger.kernel.org
X-Gm-Message-State: AOJu0YzLuZp7ZmiShBuDAD0q0PF0TZ14BAhL76C78UAcEF8z+VAmKnsj
	YMKBL4e8Szn0Hk3Vo9/1jJVS27dZbdGan/wonAQAet/YQUcZ+fLFVD19Yd3d1YDp8MqgQJV0FgV
	lDTAaSKJ/n7y9GKOs+BxwjlcuTxEsXHPo
X-Google-Smtp-Source: AGHT+IEnSf5p9L9kegSOHMOBrRiVIK5eveo3tl44PinzfRB2O9Wy+pWJlPMq68sb2HypxtvP59ijsTsmBhoASids4T0=
X-Received: by 2002:a05:6402:2791:b0:5cf:3d14:b442 with SMTP id
 4fb4d7f45d1cf-5cf754bec6dmr1891219a12.4.1731563941671; Wed, 13 Nov 2024
 21:59:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024111232-relative-bottom-4995@gregkh> <20241112132931.3504749-1-snovitoll@gmail.com>
 <824e839d-ee72-4923-bc88-e9cc58201b07@rowland.harvard.edu>
 <CACzwLxgVJ2jROr8RWHXv++2m2tD9fvskp_MqTL7VhCPr-Eeeiw@mail.gmail.com> <4ea9e56b-0941-4ea4-8cf3-b62facdbff53@rowland.harvard.edu>
In-Reply-To: <4ea9e56b-0941-4ea4-8cf3-b62facdbff53@rowland.harvard.edu>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Thu, 14 Nov 2024 10:58:49 +0500
Message-ID: <CACzwLxihpmtmPgOq9tFoJB=t2QMfcrDaieAA5nuswwRsqUH3cA@mail.gmail.com>
Subject: Re: [PATCH v4] usb/cdc-wdm: fix memory info leak in wdm_read
To: Alan Stern <stern@rowland.harvard.edu>
Cc: oneukum@suse.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:25=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, Nov 13, 2024 at 12:30:08AM +0500, Sabyrzhan Tasbolatov wrote:
> > I've re-read your and Oliver's comments and come up with this diff,
> > which is the same as v4 except it is within a spinlock.
> >
> > diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
> > index 86ee39db013f..47b299e03e11 100644
> > --- a/drivers/usb/class/cdc-wdm.c
> > +++ b/drivers/usb/class/cdc-wdm.c
> > @@ -598,8 +598,11 @@ static ssize_t wdm_read
> >                 spin_unlock_irq(&desc->iuspin);
> >         }
> >
> > -       if (cntr > count)
> > -               cntr =3D count;
> > +       spin_lock_irq(&desc->iuspin);
> > +       /* Ensure cntr does not exceed available data in ubuf. */
> > +       cntr =3D min_t(size_t, count, desc->length);
> > +       spin_unlock_irq(&desc->iuspin);
> > +
> >         rv =3D copy_to_user(buffer, desc->ubuf, cntr);
> >         if (rv > 0) {
> >                 rv =3D -EFAULT;
>
> You seem to be stuck in a rut, doing the same thing over and over again
> and not realizing that it accomplishes nothing.  The spinlock here
> doesn't help; it merely allows you to avoid calling READ_ONCE.
>
> > > Since the new code does the same thing as the old code, it cannot
> > > possibly fix any bugs.
> >
> > Without the reproducer I can not confirm that this fixes the hypothetic=
al bug,
> > however here is my understand how the diff above can fix the memory inf=
o leak:
> >
> > static ssize_t wdm_read() {
> >         cntr =3D READ_ONCE(desc->length);
> >         if (cntr =3D=3D 0) {
> >                 spin_lock_irq(&desc->iuspin);
> >
> >                 /* can remain 0 if not increased in wdm_in_callback() *=
/
> >                 cntr =3D desc->length;
> >
> >                 spin_unlock_irq(&desc->iuspin);
> >         }
> >
> >         spin_lock_irq(&desc->iuspin);
> >         /* take the minimum of whatever user requests `count` and
> > desc->length =3D 0 */
> >         cntr =3D min_t(size_t, count, desc->length);
> >         spin_lock_irq(&desc->iuspin);
> >
> >         /* cntr is 0, nothing to copy to the user space. */
> >         rv =3D copy_to_user(buffer, desc->ubuf, cntr);
>
> This does not explain anything.  How do you think your change will avoid
> the memory info leak?  That is, what differences between the old code
> and the new code will cause the leak to happen with the old code and not
> to happen with your new code?

Let me get back to this once I understand how to work with the USB gadgets
to emulate a cdc-wdm device to develop a reproducer,
because I thought that there is the path to memory info leak and
Oliver confirmed it,
but now without a solid PoC, I can't proceed further.
Sorry for the confusion.

>
> Note that if cntr is 0 then nothing is copied to user space so there is
> no info leak.
>
> > > (Actually there is one other thing to watch out for: the difference
> > > between signed and unsigned values.  Here cntr and desc->length are
> > > signed whereas count is unsigned.  In theory that could cause problem=
s
> > > -- it might even be related to the cause of the original bug report.
> > > Can you prove that desc->length will never be negative?)
> >
> > desc->length can not be negative if I understand the following correctl=
y:
> >
> > static void wdm_in_callback(struct urb *urb)
> > {
> >         ...
> >         int length =3D urb->actual_length;
> >        ...
> >        if (length + desc->length > desc->wMaxCommand) {
> >               /* The buffer would overflow */
> >              ...
> >        } else {
> >               /* we may already be in overflow */
> >               if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
> >                      ...
> >                      desc->length +=3D length;
> >                      desc->reslength =3D length;
> >        }
> > }
> >
> > urb->actual_length is u32, actually, need to change `int length` to
> > `u32 length` though.
>
> You don't really need to change it.  urb->actual_length can never be
> larger than urb->length.

Ack.

>
> Alan Stern

