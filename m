Return-Path: <linux-kernel+bounces-403886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513C59C3C46
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754A21C20B42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20C219F487;
	Mon, 11 Nov 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YchZsoqs"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53119F420;
	Mon, 11 Nov 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321645; cv=none; b=KzUO2zwpqUiE730fkxLrs6vZMNIdSVVjoBZjD1QFBUb7oggRS7l+3kQopJ9RezFiddZfayYUFMRde79qw0LWc7j4oxCpvxRZpz9SKJIooMCxv1PuxMWCknU2yRoF5xr4kjtFsto5jbuuoskxPa3HOjPDJQ2qOzxX61ldO47XI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321645; c=relaxed/simple;
	bh=jv2DZ19yaMjVseg6iQ4GWFVJ/Fuy5glx/d6raEdpvdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IINb1FaAmPlk3grVNuQm21GT1vZPg8dBaDpMVtsV+5vdFiqIA9/ypgWIr805Zbei/D+wE760Y19K97T/H0WoVhMJbI1mcQ1LWS34D6dzUwrT/H+Cat3ZzMJRSdvlXYH4CRIIwunhrjskyZogPebQQUlCbtXKIx3plV7dNpgJ2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YchZsoqs; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a5f555cfbso370606966b.1;
        Mon, 11 Nov 2024 02:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731321642; x=1731926442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrm+GMT1CtZHN9Uz86HTtLBJfm9E+g1tBhx+pDkuNsY=;
        b=YchZsoqsAqAdlr0A7qy4iSEWPD96C2/qgPH9r+YAnm04l7WeIF6l/5Mb4PnRJcER84
         uqfgbMxvpFUEcINQo4/MUBTxNrRyXjWgqkG+Rk+km+mv3hC/P0L4k+i3as+ye5h+Nmtn
         rBqVB1cOeiq1CAhwzUfmNQ9LXjvmU0cbJUjBb34RtcFb5vicOIN30wSVNl5kzGtKK3Ix
         CDq9bEpinVmPrph4DnoQmZxYhNVgtlEl4Rt+bL1FpkaC4UbGbE3pNgCXXQdCaRjD0mrp
         zA3W6YYEQT5ztJYFIkqpi5YhmF2KpmDwVUOsw2AlFYYEG1ajx5kF45Zdgs4mAA4FWkxH
         EkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321642; x=1731926442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrm+GMT1CtZHN9Uz86HTtLBJfm9E+g1tBhx+pDkuNsY=;
        b=LSVgdip8d04wlICatRJiUZ3B5osXOBBjXVbpP9TQei/oYHe7uvEczG4rAPhKJqFoKa
         8iL88sGoWtvI9t+S20Pg+CeSnSThH00CnTZ2T2u0sij60Ov77X4pKepGd4APo3ERmT9y
         0/ZIfxBnAFjs5wsx/3JT2zpqkmX0/r4dtXiHfsiF90lwRHvT3Pjc4X7/9SUGE1Mhvio0
         JPb1qbBWuDqEAF5jCanPoKf34MJr2Pn6JeTGCYGsqn+X+AYC0lSjtP+NkJNovFvvoc/T
         XZznbZNaNx8C7u3ykKxI0hnTr+Z7F3s5ycvF93buLMqbOEDTNioiGyE7WqSxpxexlz/7
         JLgA==
X-Forwarded-Encrypted: i=1; AJvYcCUufEyOcw0Wq2ej2SkE+GGSfQJ5iv/LvmrEE/QA+Lruv4TnqTZEvs+ZCUpfXsk7o6qNdDu7gq2Xyt/9ifY=@vger.kernel.org, AJvYcCVH5fDoXIErvu8yo/PyFaoEvh5x7hcu6iyDM3UF8W7hsyPY+kxJHpPF6mDJIoIe8cF+KBwPv59w4k2w@vger.kernel.org
X-Gm-Message-State: AOJu0YxCes1g+kD3R0lVbiD6IGejwyPL6SsfX2V+vTQqBeN/oQbPnc5B
	kABb5OOxTu1VKoCiO/+Ad89o8bpgvADu5H96R+w4dS1DFRRk1zrOmXv7I+3Y1Rv0ZtWQQLvMql0
	fIHOUpo51yjAu7jXEe2TyK1AEYxA=
X-Google-Smtp-Source: AGHT+IFUDpcCuDu28ASGE2Y72OHPWYh7NPOsuQDmAt7iWee1QqQSXjb5CnzP9LiPrI6sy+H2injQyM71zXHe3J5Idgw=
X-Received: by 2002:a05:6402:2689:b0:5ce:fa33:6c9f with SMTP id
 4fb4d7f45d1cf-5cf0a43f2ecmr18339695a12.27.1731321641411; Mon, 11 Nov 2024
 02:40:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e875fa0620253803@google.com> <20241109152821.3476218-1-snovitoll@gmail.com>
 <825be5e2-31b2-4cd6-a283-05935ea6161f@suse.com>
In-Reply-To: <825be5e2-31b2-4cd6-a283-05935ea6161f@suse.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Mon, 11 Nov 2024 15:40:29 +0500
Message-ID: <CACzwLxjD0PceaD27Ya6fFxKnSQZajtG2sEArqX6toS8SjNcinw@mail.gmail.com>
Subject: Re: [PATCH] usb/cdc-wdm: fix memory leak of wdm_device
To: Oliver Neukum <oneukum@suse.com>
Cc: syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:44=E2=80=AFPM Oliver Neukum <oneukum@suse.com> wr=
ote:
>
> On 09.11.24 16:28, Sabyrzhan Tasbolatov wrote:
>
> Hi,
>
> > syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is n=
o
> > reproducer and the only report for this issue. This might be
> > a false-positive, but while the reading the code, it seems,
> > there is the way to leak kernel memory.
>
> As far as I can tell, the leak is real.
>
> > Here what I understand so far from the report happening
> > with ubuf in drivers/usb/class/cdc-wdm.c:
> >
> > 1. kernel buffer "ubuf" is allocated during cdc-wdm device creation in
> >     the "struct wdm_device":
>
> Yes
> [..]
>
> > 2. during wdm_create() it calls wdm_in_callback() which MAY fill "ubuf"
> >     for the first time via memmove if conditions are met.
>
> Yes.
> [..]
>
> > 3. if conditions are not fulfilled in step 2., then calling read() sysc=
all
> >     which calls wdm_read(), should leak the random kernel memory via
> >     copy_to_user() from "ubuf" buffer which is allocated in kmalloc-256=
.
>
> Yes, sort of.
>
> >
> > -     desc->ubuf =3D kmalloc(desc->wMaxCommand, GFP_KERNEL);
> > +     desc->ubuf =3D kzalloc(desc->wMaxCommand, GFP_KERNEL);
> >       if (!desc->ubuf)
> >               goto err;
>
> No. I am sorry, but the fix is wrong. Absolutely wrong.
>
> Let's look at the code of wdm_read():
>
>                  cntr =3D desc->length;
> Here the method determines how much data is in the buffer.
> "length" initially is zero, because the descriptor itself
> is allocated with kzalloc. It is increased in the callback.
>
>                  spin_unlock_irq(&desc->iuspin);
>          }
>
>          if (cntr > count)
>                  cntr =3D count;
>
> This is _supposed_ to make sure that user space does not get more
> than we have in the buffer.
>
>          rv =3D copy_to_user(buffer, desc->ubuf, cntr);
>          if (rv > 0) {
>                  rv =3D -EFAULT;
>                  goto err;
>          }
>
>          spin_lock_irq(&desc->iuspin);
>
>          for (i =3D 0; i < desc->length - cntr; i++)
>                  desc->ubuf[i] =3D desc->ubuf[i + cntr];
>
>          desc->length -=3D cntr;
>
> Here we decrease the count of what we have in the buffer.
>
> Now please look at the check again
>
> "cntr" is what we have in the buffer.
> "count" is how much user space wants.
>
> We should limit what we copy to the amount we have in the buffer.
> But that is not what the check does. Instead it makes sure we never
> copy more than user space requested. But we do not check whether
> the buffer has enough data to satisfy the read.
>
> You have discovered the bug. If you want to propose a fix, the honor is y=
ours.
> Or do you want me to fix it?
>
> tl;dr: Excellent catch, wrong fix

Hi, thanks for the comments.

Let me try to come up with a fix with your explanation in a few hours,
this will help me understand this bug research as the complete experience.

BTW, I couldn't make a reproduction to create /dev/cdc-wdm0 device to
read from it
via dummy_hdc, USB raw gadget (learning in this part as well), to
verify the fix.

I also wanted to request a CVE for my CV
after the fix is released per kernel.org CNA rules :) but it's not so impor=
tant.

>
>         Regards
>                 Oliver
>

