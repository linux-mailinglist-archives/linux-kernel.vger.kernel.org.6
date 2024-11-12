Return-Path: <linux-kernel+bounces-405498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BB49C5224
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C861F20357
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D743620EA23;
	Tue, 12 Nov 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0aYpzg4"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6720DD78;
	Tue, 12 Nov 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404069; cv=none; b=WOzz79AaHpKyDI1TfehZHEx6UgXNm2ehyxthb8djQC93X7j2QgFTnE572OVLYdm3RZdlymL2d/0+pQaMhIyBSxSk/7OzH2ACIlLJsGzmF2phAkXFhSQn82+v5pKK/BM77rkzpurad6vwefU5hPHDPKpdPWVfThohlReeAFdyljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404069; c=relaxed/simple;
	bh=SHes6OGRvq8oLwDJGfMDAR3qR6dDumBKkf+y1CWPlq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyZoqsJCyw9x109rGzD0DazwjA4ZdYDQWGUjckywWdwySfo9NtJZj+gPW6n1GN8tt7r59IMa4W5lEmGyUnlmN/27tdavQQQfdLhpNG4SlsAmSpJ8Fz9W6Tes9JaswjW406V2mDaPvbUbLq+stnEI3iNoloeeIa0JnhAFlv0ILWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0aYpzg4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so6617329a12.2;
        Tue, 12 Nov 2024 01:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731404066; x=1732008866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veWI0wzxeXxsm+t2SNseiFfdJ4cLJENyf0HANu/LsHU=;
        b=f0aYpzg4plPOL+kpB3FyVxIu4Q7WvqOjAzBZJ49OKnLShTM4rjnqTgaDKxrtmAmD1i
         xretEndnJYAIQQkC52be0+kf8zkTUpY6TvEo07H73PJFOSaJxelr8Qh+w627h/nVlgmn
         RwNuQ8RVIRAiNbyk4bHksCFfBnFXi9YGexjo5Kf+nHVwYkpgJXaml2ypXCLv7PpHilq9
         l4jFqnnd3LKfZiqjjVFHaZQtXrAb8iSaYtvp8R4Sxx1yO8LL8IuqkkjDWDEt3jguGmSM
         hb+6Kw2E1gc+tV46dkg0n7PhB5cqsV2dilsd/4J5UzXUWpg/qogJbg+HoiljZBsxo25M
         gilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404066; x=1732008866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veWI0wzxeXxsm+t2SNseiFfdJ4cLJENyf0HANu/LsHU=;
        b=C1ZG0s2lfqfM3cL+vwKd5wy59OW5kLhIY9YxYtZ7E5x5SzJz8fETJJmgOnL0DRormB
         DhCoq0v317jcVtelgpbe193eOCh4FK2F5R93xp2ho/DN0Bc9nYLVg6NBsWlMvnpnnUMG
         +mzNDvhoqU47BI5iian5EGABSqgHgqhuns00OW47gH+AXW+Ht0fU3w6d8nh46C8BAtn1
         ymjruVCJ0XapbdAM/WPpAIIuWwk/1hrFYk0ipCND4NhhL6FQo1lQUcimNf1H7c5Yyf5Z
         J3LwfXBTnC09PehxzvL03opNArT7B/jgnPcs0xZZ6YJ4XkjeTxbtvygzc9Hz53MhEBLX
         x+cw==
X-Forwarded-Encrypted: i=1; AJvYcCUSIOPWhoJDUtRKaFT6k9kzHQCYJwYKblkAhfgfMGTY3bavAJK0rCtExRXf5IqjJkvJZ1eYjW2jnsYS@vger.kernel.org, AJvYcCWrdUmkfEwMKjtpZE4ka3/Djt3rvuGG6OVQavTA3C8Lg252otdwX6RWSMAp4Ii9AuvxYECSbNJarJAgDd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzethQ3fxUaSXu/1BhIjDELQHX68toscVV0xleVN88WbPBy8tNc
	RAtgP5DgC9iYYeZ2BWS+CQSsHMJmZK4vKhTI96x6jd0Y2MkvuufK+WqJZbxp/cRj28Xv3GMXJeT
	iCkdbdSQgvU86Vr1xPMtf4aN1PHU=
X-Google-Smtp-Source: AGHT+IFhgvqEmLV3+B88dauhpYClk2Y78ALxpG/mB5y3fHyWQAhHl48zUbKsMkX3L1y8LUpLEH+7Q+6qUFmMbisMUsM=
X-Received: by 2002:a05:6402:13d1:b0:5cf:451b:36c7 with SMTP id
 4fb4d7f45d1cf-5cf451b3743mr4133124a12.32.1731404065367; Tue, 12 Nov 2024
 01:34:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e875fa0620253803@google.com> <20241109152821.3476218-1-snovitoll@gmail.com>
 <825be5e2-31b2-4cd6-a283-05935ea6161f@suse.com> <9447f943-5172-4386-b159-f6b37735fe13@rowland.harvard.edu>
In-Reply-To: <9447f943-5172-4386-b159-f6b37735fe13@rowland.harvard.edu>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 12 Nov 2024 14:34:13 +0500
Message-ID: <CACzwLxht_ACYD4QdDqSWfYkZ7+0a+z8DWMt15KhGCF4E1g9-Lw@mail.gmail.com>
Subject: Re: [PATCH] usb/cdc-wdm: fix memory leak of wdm_device
To: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>
Cc: syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:29=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Mon, Nov 11, 2024 at 10:44:43AM +0100, Oliver Neukum wrote:
> > On 09.11.24 16:28, Sabyrzhan Tasbolatov wrote:
> >
> > Hi,
> >
> > > syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is=
 no
> > > reproducer and the only report for this issue. This might be
> > > a false-positive, but while the reading the code, it seems,
> > > there is the way to leak kernel memory.
> >
> > As far as I can tell, the leak is real.
> >
> > > Here what I understand so far from the report happening
> > > with ubuf in drivers/usb/class/cdc-wdm.c:
> > >
> > > 1. kernel buffer "ubuf" is allocated during cdc-wdm device creation i=
n
> > >     the "struct wdm_device":
> >
> > Yes
> > [..]
> >
> > > 2. during wdm_create() it calls wdm_in_callback() which MAY fill "ubu=
f"
> > >     for the first time via memmove if conditions are met.
> >
> > Yes.
> > [..]
> >
> > > 3. if conditions are not fulfilled in step 2., then calling read() sy=
scall
> > >     which calls wdm_read(), should leak the random kernel memory via
> > >     copy_to_user() from "ubuf" buffer which is allocated in kmalloc-2=
56.
> >
> > Yes, sort of.
> >
> > > -   desc->ubuf =3D kmalloc(desc->wMaxCommand, GFP_KERNEL);
> > > +   desc->ubuf =3D kzalloc(desc->wMaxCommand, GFP_KERNEL);
> > >     if (!desc->ubuf)
> > >             goto err;
> >
> > No. I am sorry, but the fix is wrong. Absolutely wrong.
> >
> > Let's look at the code of wdm_read():
> >
> >                 cntr =3D desc->length;
> > Here the method determines how much data is in the buffer.
> > "length" initially is zero, because the descriptor itself
> > is allocated with kzalloc. It is increased in the callback.
> >
> >                 spin_unlock_irq(&desc->iuspin);
> >         }
> >
> >         if (cntr > count)
> >                 cntr =3D count;
> >
> > This is _supposed_ to make sure that user space does not get more
> > than we have in the buffer.
> >
> >         rv =3D copy_to_user(buffer, desc->ubuf, cntr);
> >         if (rv > 0) {
> >                 rv =3D -EFAULT;
> >                 goto err;
> >         }
> >
> >         spin_lock_irq(&desc->iuspin);
> >
> >         for (i =3D 0; i < desc->length - cntr; i++)
> >                 desc->ubuf[i] =3D desc->ubuf[i + cntr];
> >
> >         desc->length -=3D cntr;
> >
> > Here we decrease the count of what we have in the buffer.
> >
> > Now please look at the check again
> >
> > "cntr" is what we have in the buffer.
> > "count" is how much user space wants.
> >
> > We should limit what we copy to the amount we have in the buffer.
> > But that is not what the check does. Instead it makes sure we never
> > copy more than user space requested. But we do not check whether
> > the buffer has enough data to satisfy the read.
>
> I don't understand your analysis.  As you said, cntr is initially set to
> the amount in the buffer:
>
>         If cntr <=3D count then cntr isn't changed, so the amount of data
>         copied to the user is the same as what is in the buffer.
>
>         Otherwise, if cntr > count, then cntr is decreased so that the
>         amount copied to the user is no larger than what the user asked
>         for -- but then it's obviously smaller than what's in the buffer.
>
> In neither case does the code copy more data than the buffer contains.

Hello,
I've sent the v3 patch [1] per Oliver's explanation if I interpreted
it correctly.
I don't have the reproducer to verify if the patch solves the problem.
If the analysis or patch is not right, please let me know.

[1] https://lore.kernel.org/all/20241111120139.3483366-1-snovitoll@gmail.co=
m/

>
> Alan Stern

