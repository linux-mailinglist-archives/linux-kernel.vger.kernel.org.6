Return-Path: <linux-kernel+bounces-406619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A7A9C6176
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2151F220BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE02185B8;
	Tue, 12 Nov 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRctDRDp"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E902003DD;
	Tue, 12 Nov 2024 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439824; cv=none; b=A84xQTZPH1NnuABUcHJCHqRm9V/tU734aQ45exzrHCvkuprT5v5ORXB6FWq45E8U53teUZsPTAWq5c9FrE+ub9dDLy3wh80BOcfXXObxRELsv+W6L4Ye7yZij+vzpvMRievzuAsth2UivAY90g4i7c6cX3wwE19QCltnLPqwouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439824; c=relaxed/simple;
	bh=fgE12BIwlMY7+KjyhOKwQsf0m/eIuliOwPbr2ir8Rl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyh423wfdk/IsQaChvNE1P+VrEDjnvQmF7l6WnUj7r8YsvPWR+atf3S4ckDQS34UoNs3n2h9SVVKG8Ja6yOvI03pbETpw6Az0QKQFm/ab0UVMm0ZlCggKT8nJLP0Z2rI0HuNAkn8M141pjmSDA7owDKuIQef+HEn7ubURm7zj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRctDRDp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d47eff9acso3687971f8f.3;
        Tue, 12 Nov 2024 11:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731439821; x=1732044621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l16f6QkdDHbu8NPQbi3zmZKB+rCbrufL1Zvvzn8jeo4=;
        b=DRctDRDpp1nMiyaSvtYQo+Qm5Vyo7PD9lOFLaA7oG6DVt9TlBc9dT4w9lPAvrwufkF
         I0jhBeRKcFfdSZ6LFKQNyxWkrXUO5Yhgaq5m3ffQMa23kQ4VBhHrElZDxM66tExpb5vD
         bIUblk/FxhrdnHGLi4QXRPVig/iXE/KekENDSm+K5ki40yCBejo/hLoQHoQ9Lxp/13N/
         fnfgMjSxuEh1nGtmwkD3ZVQh4YEzcZtQP0MYy10Tg2el7U+km8itJOzoL+kf6ebGlvE3
         unmtGq/F7OF9ljvGlWSJh66NxFa0Xk2oOCD3YR2vGuO6HSsXJJARFnTIwyJMsYSq2L5V
         z0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731439821; x=1732044621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l16f6QkdDHbu8NPQbi3zmZKB+rCbrufL1Zvvzn8jeo4=;
        b=xJJ49kMk03DtYC2qpU0aaK38xiOoQinC64xCWSGzabZpvOlAcCjYZYqIH2yeV9RH+v
         bQbFpCu6chbNEY8DhFJCOU/VoYfhlvr5XR/a2NKYdWIrw5cfNbd7pG5G//ifIFIbTbO8
         3YzuL6jcjxV4XEerwabmtUb0cKMBQneDRCdSK2te90hYEguLQiMlC3/tGxfJ23jHISmG
         bvj8NIb9fgf9A57SCTdtTjI1uzWEZClhL2tpKARqa54VH8kgtFH0EJHgBp4doy1VYnuO
         RoIBj8coUxTZPnzBL42bs7YLcJHhjUKnPdVFyF+MdAuvnUlJe9XcYBcPsAe64v9Qwoir
         xHgg==
X-Forwarded-Encrypted: i=1; AJvYcCU3BTUg4MMdtkYgRXKS1UZgAOHQWysShPOc6vETlhP/tZGwMeO6+Q2RYPxPBVyy5KDrjxSbNEJKtDu1Cik=@vger.kernel.org, AJvYcCXhnZVVY6o9aGOGBErcRI9X5QOJfY02Dv9HSnPzPnt+gwhkPiyRAQ4fBxJ3D5BhJVJo8p3DQX+HFnwZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcjV+9acU/m+zpNF1LxEJQDZGj4voZKtn8EsjRtLcCVjMJ2GR
	REXT3sLIEt3jYWG+4lOPNGY9mGKZThxnOxsPyRo2weLDjiXv/HbgKTYzz3MMTRYPbPPx8sSioz1
	irE3Jn/2rKmcngaE6lPkb3pJWGGU=
X-Google-Smtp-Source: AGHT+IFwjFIsgpZQKzg8L4z2NM2FpJthfQ7fgjGpHDUe7iTEaYDD6h81rM9zbdkLpcHXF5PhFDanTHZv28KSbawmqYw=
X-Received: by 2002:a5d:5f42:0:b0:37d:4436:4505 with SMTP id
 ffacd0b85a97d-381f186ccdemr14970057f8f.32.1731439820582; Tue, 12 Nov 2024
 11:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024111232-relative-bottom-4995@gregkh> <20241112132931.3504749-1-snovitoll@gmail.com>
 <824e839d-ee72-4923-bc88-e9cc58201b07@rowland.harvard.edu>
In-Reply-To: <824e839d-ee72-4923-bc88-e9cc58201b07@rowland.harvard.edu>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 13 Nov 2024 00:30:08 +0500
Message-ID: <CACzwLxgVJ2jROr8RWHXv++2m2tD9fvskp_MqTL7VhCPr-Eeeiw@mail.gmail.com>
Subject: Re: [PATCH v4] usb/cdc-wdm: fix memory info leak in wdm_read
To: Alan Stern <stern@rowland.harvard.edu>, oneukum@suse.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:52=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Tue, Nov 12, 2024 at 06:29:31PM +0500, Sabyrzhan Tasbolatov wrote:
> > syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is n=
o
> > reproducer and the only report for this issue.
> >
> > The check:
> >
> >       if (cntr > count)
> >               cntr =3D count;
> >
> > only limits `cntr` to `count` (the number of bytes requested by
> > userspace), but it doesn't verify that `desc->ubuf` actually has `count=
`
> > bytes. This oversight can lead to situations where `copy_to_user` reads
> > uninitialized data from `desc->ubuf`.
> >
> > This patch makes sure `cntr` respects` both the `desc->length` and the
> > `count` requested by userspace, preventing any uninitialized memory fro=
m
> > leaking into userspace.
>
> > ---
> >  drivers/usb/class/cdc-wdm.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
> > index 86ee39db013f..5a500973b463 100644
> > --- a/drivers/usb/class/cdc-wdm.c
> > +++ b/drivers/usb/class/cdc-wdm.c
> > @@ -598,8 +598,9 @@ static ssize_t wdm_read
> >               spin_unlock_irq(&desc->iuspin);
> >       }
>
> Note that the code immediately before the "if" statement which ends here
> does:
>
>         cntr =3D READ_ONCE(desc->length);
>
> And the code at the end of the "if" block does:
>
>                 cntr =3D desc->length;
>
> (while holding the spinlock).  Thus it is guaranteed that either way,
> cntr is equal to desc->length when we reach this point.
>
> >
> > -     if (cntr > count)
> > -             cntr =3D count;
> > +     /* Ensure cntr does not exceed available data in ubuf. */
> > +     cntr =3D min_t(size_t, count, desc->length);
>
> And therefore this line does exactly the same computation as the code
> you removed.  Except for one thing: At this point the spinlock is not
> held, and your new code does not call READ_ONCE().  That is an
> oversight.

I've re-read your and Oliver's comments and come up with this diff,
which is the same as v4 except it is within a spinlock.

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 86ee39db013f..47b299e03e11 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -598,8 +598,11 @@ static ssize_t wdm_read
                spin_unlock_irq(&desc->iuspin);
        }

-       if (cntr > count)
-               cntr =3D count;
+       spin_lock_irq(&desc->iuspin);
+       /* Ensure cntr does not exceed available data in ubuf. */
+       cntr =3D min_t(size_t, count, desc->length);
+       spin_unlock_irq(&desc->iuspin);
+
        rv =3D copy_to_user(buffer, desc->ubuf, cntr);
        if (rv > 0) {
                rv =3D -EFAULT;

>
> Since the new code does the same thing as the old code, it cannot
> possibly fix any bugs.

Without the reproducer I can not confirm that this fixes the hypothetical b=
ug,
however here is my understand how the diff above can fix the memory info le=
ak:

static ssize_t wdm_read() {
        cntr =3D READ_ONCE(desc->length);
        if (cntr =3D=3D 0) {
                spin_lock_irq(&desc->iuspin);

                /* can remain 0 if not increased in wdm_in_callback() */
                cntr =3D desc->length;

                spin_unlock_irq(&desc->iuspin);
        }

        spin_lock_irq(&desc->iuspin);
        /* take the minimum of whatever user requests `count` and
desc->length =3D 0 */
        cntr =3D min_t(size_t, count, desc->length);
        spin_lock_irq(&desc->iuspin);

        /* cntr is 0, nothing to copy to the user space. */
        rv =3D copy_to_user(buffer, desc->ubuf, cntr);

>
> (Actually there is one other thing to watch out for: the difference
> between signed and unsigned values.  Here cntr and desc->length are
> signed whereas count is unsigned.  In theory that could cause problems
> -- it might even be related to the cause of the original bug report.
> Can you prove that desc->length will never be negative?)

desc->length can not be negative if I understand the following correctly:

static void wdm_in_callback(struct urb *urb)
{
        ...
        int length =3D urb->actual_length;
       ...
       if (length + desc->length > desc->wMaxCommand) {
              /* The buffer would overflow */
             ...
       } else {
              /* we may already be in overflow */
              if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
                     ...
                     desc->length +=3D length;
                     desc->reslength =3D length;
       }
}

urb->actual_length is u32, actually, need to change `int length` to
`u32 length` though.

>
> Alan Stern

Please let me know if the diff makes sense and I will proceed with v5.

Thanks

