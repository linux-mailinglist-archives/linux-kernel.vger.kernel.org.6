Return-Path: <linux-kernel+bounces-212486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A6B9061A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797A7284265
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD67381B0;
	Thu, 13 Jun 2024 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm4L94B9"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7110A0E;
	Thu, 13 Jun 2024 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244822; cv=none; b=OuLwnfc5r0OQx+aXSiQ9TzKgXH0w+XTnf+b+zcFQLru+h8iL8XoELBPYQlraQsoI3m+8hXx0GzX3qHbhNYxtpFu+8MZ+An5pUYcn5HyqVAO6J3UrNaKFkd1/2H9NSBPWlV07PD615bIIPP3t3lq8YhwnymEfdkaVPKaDTCjKAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244822; c=relaxed/simple;
	bh=OUs3bx4Rf6RSfqYbMQWdIn94RCW0Mzixkm7cVScthN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjkjSMf6+fl8oMgzx6dTbXvBX8UyneYrY7DWUMNP6li478Nz8H33ABP6A6spJ0AQEi2N50BBJIKmznERsRzY8M9SX6UI3AD2w34sm205aMToRqTVVJV6bFR5/8Rpb41tvhLNI4CbG3bTCr8mRwmOkzS4TqB4WlerBvgvZOAxb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm4L94B9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfa682a4025so566458276.2;
        Wed, 12 Jun 2024 19:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718244820; x=1718849620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4650UPu7R/J8hSWinxrD7Lxf+FcBugDomSDA6g0oI/I=;
        b=lm4L94B9qVC60u+XFtfKPzfTKvYhy6ecfyh6dAF/dHi9g2eubHWtwkX7yRnSCf1Jty
         1DpCK8tSCoBiaTayon6bdYt4mn5yWDhCO3FOe5yPMch9R5pG4IcoInwSSBIL09YT34lt
         NiGIs6okSdJCrO5K+q5s5ORXjamBBqaYMk+s8gWufP9eJEPtXcWHZVX786Da/wNrVOXl
         lC5yvLAbFDXWt+Ad2eqaGCWzAnT7rJCMPocTAGYK7/M9QL9b47ePizpWZIusA4ulBa56
         GBOnRUIWWyYQm+gCNBjrmHCcvuOGXPhs1DW0TUbh5e6ePGoTVsI1jhSG2fICoGJTF4IV
         MKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718244820; x=1718849620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4650UPu7R/J8hSWinxrD7Lxf+FcBugDomSDA6g0oI/I=;
        b=pBRu1MqLcO+tCt0mHW3YFrlpOWXd5QDM23PNkhrBdZUHKAyynFUpheyf/US8qRS/VX
         n+uU+r9OgHrbgJIociN83fKKjN/ihJrqfTt7eXwz4gnwaJUyMVrCrMq32pwAz3gOkfxS
         DwsRq89HMLo7uhkDsPWwLmfyHZrN9bin69z7GvRuOga5d5A/sjLLtWn+gpgYj7zMV7eH
         GEGkfehhI2snOYAvx75y8Fy3+eLGZnOtpZ9LmnnCw2EL8ZVMr2ggUde0WdPriKg+n06O
         ADcJU7el0j0E1zpxExkSSmMYUD7sh6OKULyMacgvXMhH0YOsU+qfNhRRnwXvTjT6qYml
         jtnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1294J1JnH0qnd+RULF2wEWUoj4wPdm2EIuVQsKuY0gdVbEdOGULPMEMLYPvJmvn1UzjPPQ06xOjvIwiwV/KZ+5IOrEW/Jx95GkB2aQGJ4gqOG/ucU2zPvgOnfUAVAuCpyn5BRwruh
X-Gm-Message-State: AOJu0Ywx66rT+Nh1S+WhC/bplxkb7a06RfM9L81ORGI5H4uNnffSaViF
	w/bbYrcnu0T3lz7PKPO7RZhM5LgFM5yTM7Dr90WsVrey2MyjINMSvQcKbvPMKR7jfJEUmshRAuA
	c1gRnafcwE9P6uay33qaNcXRU9/Y=
X-Google-Smtp-Source: AGHT+IH79rROqNcavSMXsf+wfYIKr3IoiUhbmwvAnK/aIP2yy4o+3XclT5fVjjkOfSFC9OkXp5msM0Y696izruyL5u8=
X-Received: by 2002:a25:ae47:0:b0:dfa:ac81:38e8 with SMTP id
 3f1490d57ef6-dfe65e7ee45mr3107880276.6.1718244820063; Wed, 12 Jun 2024
 19:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-2-flintglass@gmail.com>
 <CAKEwX=P1Ojb71AEJ2gzQTrfWidFPcJZmoNxEwji7TceBN-szCg@mail.gmail.com>
 <CAPpoddeigM44jhTA8Ua=+J4MC1MikouBZVoPrCW2LZF+9r5YeA@mail.gmail.com> <CAJD7tkYp3GbuXV9G5bAZ1DetMmepV5ynciA+ukae7CKuxpXDJQ@mail.gmail.com>
In-Reply-To: <CAJD7tkYp3GbuXV9G5bAZ1DetMmepV5ynciA+ukae7CKuxpXDJQ@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Thu, 13 Jun 2024 11:13:29 +0900
Message-ID: <CAPpoddfj1EdfXfTUT8bLaNxat0hYiE4X9=qG38gPgRgmmVOjcw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=8813=E6=97=A5(=E6=9C=A8) 3:28 Yosry Ahmed <yosryahmed@=
google.com>:
>
> On Wed, Jun 12, 2024 at 11:16=E2=80=AFAM Takero Funaki <flintglass@gmail.=
com> wrote:
> >
> > 2024=E5=B9=B46=E6=9C=8812=E6=97=A5(=E6=B0=B4) 3:26 Nhat Pham <nphamcs@g=
mail.com>:
> >
> > >
> > > As I have noted in v0, I think this is unnecessary and makes it more =
confusing.
> > >
> >
> > Does spin_lock() ensure that compiler optimizations do not remove
> > memory access to an external variable? I think we need to use
> > READ_ONCE/WRITE_ONCE for shared variable access even under a spinlock.
> > For example,
> > https://elixir.bootlin.com/linux/latest/source/mm/mmu_notifier.c#L234
>
> In this example, it seems like mmu_interval_set_seq() updates
> interval_sub->invalidate_seq locklessly using WRITE_ONCE(). I think
> this is why READ_ONCE() is required in that particular case.
>
> >
> > isn't this a common use case of READ_ONCE?
> > ```c
> > bool shared_flag =3D false;
> > spinlock_t flag_lock;
> >
> > void somefunc(void) {
> >     for (;;) {
> >         spin_lock(&flag_lock);
> >         /* check external updates */
> >         if (READ_ONCE(shared_flag))
> >             break;
> >         /* do something */
> >         spin_unlock(&flag_lock);
> >     }
> >     spin_unlock(&flag_lock);
> > }
> > ```
> > Without READ_ONCE, the check can be extracted from the loop by optimiza=
tion.
>
> According to Documentation/memory-barriers.txt, lock acquiring
> functions are implicit memory barriers. Otherwise, the compiler would
> be able to pull any memory access outside of the lock critical section
> and locking wouldn't be reliable.

Ah, I understand now. The implicit barrier is sufficient as long as
all memory access occurs within the lock. It=E2=80=99s a fundamental rule o=
f
locking=E2=80=94facepalm.

I misread a module code, like in the link, where a lockless write
could invade a critical section. My example was in the opposite
direction, just wrong. Thank you so much for clarifying my
misunderstanding.

For now checking the patch, I suppose the locking mechanism itself is
not affected by my misunderstanding of READ_ONCE.

The corrected version of the cleaner should be:
```c
void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
{
        /* lock out zswap shrinker walking memcg tree */
        spin_lock(&zswap_shrink_lock);
        if (zswap_next_shrink =3D=3D memcg) {
                do {
                        zswap_next_shrink =3D mem_cgroup_iter(NULL,
                                        zswap_next_shrink, NULL);
                        spin_unlock(&zswap_shrink_lock);
                        spin_lock(&zswap_shrink_lock);
                        if (!zswap_next_shrink)
                                break;
                } while (!mem_cgroup_online(zswap_next_shrink));
        }
        spin_unlock(&zswap_shrink_lock);
}
```

Should we have a separate patch to fix the leak scenario?

