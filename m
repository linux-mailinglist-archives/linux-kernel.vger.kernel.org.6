Return-Path: <linux-kernel+bounces-346172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3EA98C0E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299D71C2347B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A701C9B81;
	Tue,  1 Oct 2024 14:58:38 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0B1C9B76
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794718; cv=none; b=UM9OAvpv6r9AovLsMhO1HUn8tG9QCFO2jep0/Eck4r0uPhOJg+PXnFLSGUb6eO3Rb4osCNuESRdOacVCWUmVj+xgK02usYewnt1opmJz8+6Hhm1MeWNQmVhzUrAMZHZaaDIybzz66B/eLLlKu8V9OmF+2s504FKGhJXczQ66bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794718; c=relaxed/simple;
	bh=js2/T/VTt9Ab9Z8U5ec16C37voyABfxC/c1mjybg9h8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vEVPJmdMRKMksKprR0qjVyI4FBkiVFYXnN8GdnFQEgCTsYlyPHwhNMpGvEItyEiio/e1mxhGnIQy/ip4e9WcAwBlI7D1qXhFfRcilq35v65s+QflEeCceTMw2ZWKiKOZ934lq+2VJGQ4XLDOCK8HB1PE6OihsroLHjRyXNeAt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a342620f50so55405555ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727794716; x=1728399516;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0xFSqkHlAgMSYh47/xtUEjbOnB2jeVJx3U8ehulrxo=;
        b=goKJtmNzyLNaQWM3WE0p8uCIuk6T0E/W1CvZWbNx8jL1WoorBokpbhOndpDgqsKmHP
         3WE/oGpAGa3z9stm52rJe6QOfDZQMPs1PhnwvKrQ9o43wMyC9aKxdJJPXNk/f44DxD+n
         1C6AaZenUvnna11S9rLEGRM5WyOD+P/SXDP0DntAM2Uvj4byM989G2aK85ezLJ1lDqo+
         +CXCXZMnA2jmzqT0NldD0MJPjN5wY2/CnbSc10zrc+9lYlf5hcDI4GJsbdIkqi9mqhU1
         Pgr2jvU/ndoHr3MVPyJWxGjM/MBMtkb0mrGo3nTn5A05Xx/viqYKYhwmDfkKjlUcpVKk
         rDxA==
X-Gm-Message-State: AOJu0Ywz7Zw4i60KJeoJI+qf35YwvkUAuoFfPr4D4Vic7Tq07cIXRTTj
	w5S+AORFRS6EAJn0ViNBj2KufcsAHuaB3TSx+ww3EYcIG/t53nGZfeWiOxqNa7h1mRCtCAjV/vw
	v9zA7XdDqgW/MvAh98m9nkXEVsl6SavWXC7LtX8/f+EAKjoVTdlSAzE4=
X-Google-Smtp-Source: AGHT+IHg7F/BzFH7livt5gzNIqQ6mlwRAQPqRUzBFdCjqZJEvdoO6rwUm45T7KGla5LvK4OpqZlHhxDQVD/SDdPw7HVvzx8D1rvl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:3a0:ac0d:22b9 with SMTP id
 e9e14a558f8ab-3a345166d4dmr142155345ab.6.1727794716075; Tue, 01 Oct 2024
 07:58:36 -0700 (PDT)
Date: Tue, 01 Oct 2024 07:58:36 -0700
In-Reply-To: <00000000000061641905cbd98d7b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc0e1c.050a0220.f28ec.04aa.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH v1] Bluetooth: RFCOMM: FIX possible deadlock
 in rfcomm_sk_state_change
From: syzbot <syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH v1] Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_=
sk_state_change
Author: luiz.dentz@gmail.com

#syz test

On Mon, Sep 30, 2024 at 4:36=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> On Mon, Sep 30, 2024 at 3:30=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > rfcomm_sk_state_change attempts to use sock_lock so it must never be
> > called with it locked but rfcomm_sock_ioctl always attempt to lock it
> > causing the following trace:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> > ------------------------------------------------------
> > syz-executor386/5093 is trying to acquire lock:
> > ffff88807c396258 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at:=
 lock_sock include/net/sock.h:1671 [inline]
> > ffff88807c396258 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at:=
 rfcomm_sk_state_change+0x5b/0x310 net/bluetooth/rfcomm/sock.c:73
> >
> > but task is already holding lock:
> > ffff88807badfd28 (&d->lock){+.+.}-{3:3}, at: __rfcomm_dlc_close+0x226/0=
x6a0 net/bluetooth/rfcomm/core.c:491
> >
> > Reported-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dd7ce59b06b3eb14fd218
> > Fixes: 3241ad820dbb ("[Bluetooth] Add timestamp support to L2CAP, RFCOM=
M and SCO")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/rfcomm/sock.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> > index 37d63d768afb..f48250e3f2e1 100644
> > --- a/net/bluetooth/rfcomm/sock.c
> > +++ b/net/bluetooth/rfcomm/sock.c
> > @@ -865,9 +865,7 @@ static int rfcomm_sock_ioctl(struct socket *sock, u=
nsigned int cmd, unsigned lon
> >
> >         if (err =3D=3D -ENOIOCTLCMD) {
> >  #ifdef CONFIG_BT_RFCOMM_TTY
> > -               lock_sock(sk);
> >                 err =3D rfcomm_dev_ioctl(sk, cmd, (void __user *) arg);
> > -               release_sock(sk);
> >  #else
> >                 err =3D -EOPNOTSUPP;
> >  #endif
> > --
> > 2.46.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

