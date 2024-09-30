Return-Path: <linux-kernel+bounces-343576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8E989CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B311F2234C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F081F17A5A4;
	Mon, 30 Sep 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdTGEC2C"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A717C7B6
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685168; cv=none; b=JbzGxNGY2LNO/iHiYVqAAB/YwcHlGDVJELK6+9qhYSW0kh2oNI7sqO1x2cz1PGosBqr3CFmlMETCjkScXTn0Kqc63wB6EOpMGlreBPXWevtosL1qYP8nD61u1+s/XCFl6TJCQjPRFgyMt3k7KLaRmqr/D3la5R26x8AImfTQdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685168; c=relaxed/simple;
	bh=4oAH2q5LgJa77lDdUdO3au+RMnFwx2NeZPL/DDhrb4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+kWujFzqiws/OrtdHlJyPOrivAw1JFraVH3e7yejYC5fGrCtkz0D1gDx9E1cGo/M7gh0tFqkJgDC66Jo78c5xwz4YhL8Ua/PSDD4aUh3KY/f4g6DDYZ6l+OplTr9hSw5bUdFdeVelaHfdlYCpULC0KwTGcLUU4+yTZZtDuZit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IdTGEC2C; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso5908589a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727685165; x=1728289965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqQ+dGZVfXuccLMYgvXwuvTtFXbCCzWXTKFzhu6C6Ww=;
        b=IdTGEC2CYCPfh5D8x4awd/THJzOrVBNCIPP5VDBKdICE+SrfZjv324OKd5lwaLKViU
         mxPLDPlX/D6Xw8+XR+flIzIZP3JzqwX08qqds7FMaUc+3VxvbsrjsWGZIgz2QY94N4tk
         rvLLkltqlRwH+jna0vLse6JzcalyVGqVmknbW6JEOYX0zpJTvQoym7EZ/qeipr7Orwnd
         XiUsjEiygesVlmDrSTr36SwZOi050wAv02/7FlMTfoXO4TuP9NLLYhWxkGDKHL02CbHC
         lvRqD5OHCNlxWaZbZID2i2hBMEC+tEjoaR1WLZt+R3Q1W93MlDIzunWaTT0XmLJjivDf
         +13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727685165; x=1728289965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqQ+dGZVfXuccLMYgvXwuvTtFXbCCzWXTKFzhu6C6Ww=;
        b=UqJFYXCFvJZjlidfKsgJjD6Kl3niV7028/6wfpBejbjNjwqBy7zPv3TaaP77lYulJf
         4v9rs/bi8OsZhCU99tXMYqIlJimR9Gq6VmBf9h1QAomUEPERIvuCotrpIrwW1S4KgtXE
         MviYKEMR9M0VWkCmITAYSELRgnKJ8MM+femj08E+mZbNQSj2DYGg+0aYgZbW7O2Fy9TL
         ATmKom3w1VZ5zBxjCjOoPYwpVIncPxLZohPtrwqXQQ5PKdtei+6QqbQqPmB6uCSvONKi
         7DosEbs8g0AEj351TiWhR9rH/9Nzcfr1Tg6CiZBM1E0M7LaB3TcqCZNLdqL03o9jqEml
         ObVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuW6T8TAXFB/aJYJoZb9qgs4HahnpgclUvDOyCT7G2K8mwfiR3BtvGGBLEIZqON086dZuSqRRmJhY51GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfkpDqvDmvw/+KBGMPUIoWYYp7XUPbm5bUr0gYZtfT/VmJdXR
	5rf3SQ6Q/hgUu1IvWK1Qhm452oCKNvWwrXWeWJKVssGigpu6hnFl9OKtg1K+eaD1NQSIlwePCqs
	v8SVHZvGPJb9jHn1yub1bTFwlj2E+spwj4wXy
X-Google-Smtp-Source: AGHT+IHy8XeDUIiNC3SMc95v5D9yjZVVtIWK2fvcVeyJ1gkoxKp4d4Qxyo4bJzl+valSUmsdQ6necbmuLeN+6grlt18=
X-Received: by 2002:a05:6402:42cd:b0:5c3:cc6d:19df with SMTP id
 4fb4d7f45d1cf-5c8825fd803mr11505417a12.28.1727685164365; Mon, 30 Sep 2024
 01:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000657ecd0614456af8@google.com> <3483096f-4782-4ca1-bd8a-25a045646026@suse.de>
 <20240928122112.1412-1-hdanton@sina.com> <20240929114601.1584-1-hdanton@sina.com>
In-Reply-To: <20240929114601.1584-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Sep 2024 10:32:32 +0200
Message-ID: <CANn89iJwe-Q2Ve3O1OP4WTVuD6eawFvV+3eDvuvs4Xk=+j5yBg@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
To: Hillf Danton <hdanton@sina.com>
Cc: Denis Kirjanov <dkirjanov@suse.de>, 
	syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Boqun Feng <boqun.feng@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 1:46=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Sat, 28 Sep 2024 20:21:12 +0800 Hillf Danton <hdanton@sina.com>
> > On Mon, 25 Mar 2024 14:08:36 +0100 Eric Dumazet <edumazet@google.com>
> > > On Mon, Mar 25, 2024 at 1:10=E2=80=AFPM Denis Kirjanov <dkirjanov@sus=
e.de> wrote:
> > > >
> > > > Hmm, report says that we have a net_device freed even that we have =
a dev_hold()
> > > > before __ethtool_get_link_ksettings()
> > >
> > > dev_hold(dev) might be done too late, the device is already being dis=
mantled.
> > >
> > > ib_device_get_netdev() should probably be done under RTNL locking,
> > > otherwise the final part is racy :
> > >
> > > if (res && res->reg_state !=3D NETREG_REGISTERED) {
> > >      dev_put(res);
> > >      return NULL;
> > > }
> >
> > Given paranoia in netdev_run_todo(),
> >
> >               /* paranoia */
> >               BUG_ON(netdev_refcnt_read(dev) !=3D 1);
> >
> > the claim that dev_hold(dev) might be done too late could not explain
> > the success of checking NETREG_REGISTERED, because of checking
> > NETREG_UNREGISTERING after rcu barrier.
> >
> >       /* Wait for rcu callbacks to finish before next phase */
> >       if (!list_empty(&list))
> >               rcu_barrier();
> >
> >       list_for_each_entry_safe(dev, tmp, &list, todo_list) {
> >               if (unlikely(dev->reg_state !=3D NETREG_UNREGISTERING)) {
> >                       netdev_WARN(dev, "run_todo but not unregistering\=
n");
> >                       list_del(&dev->todo_list);
> >                       continue;
> >               }
> >
> As simply bumping kref up could survive the syzbot reproducer [1], Eric's=
 reclaim
> is incorrect.

I have about 50 different syzbot reports all pointing to netdevsim and
sysfs buggy interaction.

We will see if you can fix all of them :)

>
> --- l/drivers/infiniband/core/verbs.c
> +++ v/drivers/infiniband/core/verbs.c
> @@ -1979,6 +1979,7 @@ int ib_get_eth_speed(struct ib_device *d
>         netdev =3D ib_device_get_netdev(dev, port_num);
>         if (!netdev)
>                 return -ENODEV;
> +       dev_hold(netdev);
>
>         rtnl_lock();
>         rc =3D __ethtool_get_link_ksettings(netdev, &lksettings);
> @@ -1995,6 +1996,7 @@ int ib_get_eth_speed(struct ib_device *d
>                                 netdev->name, netdev_speed);
>         }
>
> +       dev_put(netdev);
>         ib_get_width_and_speed(netdev_speed, lksettings.lanes,
>                                speed, width);
>
> --
> syzbot has tested the proposed patch and the reproducer did not trigger a=
ny issue:
>
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Tested-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
>
> [1] https://lore.kernel.org/lkml/66f9372f.050a0220.aab67.001a.GAE@google.=
com/

