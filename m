Return-Path: <linux-kernel+bounces-348229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FFF98E45E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C981C22AB2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C86121731C;
	Wed,  2 Oct 2024 20:46:57 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E621730B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902016; cv=none; b=sDRSZ+MAGu3iQDbnWXA5A6aGriyCV1EfNLauaXakl1d5mgFjRIKIhN4Q8gN8jA0sesJ3oXPP9Ndm587xstWB0DP+JmYO6HE7fH/pICAp8TQTV351AkHu+4l9rnWCP24vYTSmMEfyJrszz8tVG++JVKHOEj7+O+EXdWsXmGUZk/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902016; c=relaxed/simple;
	bh=t4q/FPmpB3LC+u6icpVhTZrl7sKpENMEbSUQOqPFk6I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lyn1c7m/80k5uT/vAEinXE0oEABKIwYB6VdKv1XcDM8FDzJQZafrAOVENdHuqTcJWzTJP5YzDJbdXR2hN4Xip9/1CBmjWQ7fqCngB72voDyxboV30PYWZWMDScgN/PV90dfW2pcIpRyD3IoMFhOV/5pnvUSNH9TtN+q9WomlVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so2672515ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727902014; x=1728506814;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u/6MTApAUCzbiZRbKsCSUotnaXE21i7acFtjGdoQBw=;
        b=LsWbkl3Z4QKq5shI0cgCrMFnKaP7zA2BuEVN1Pn+K65+iHRfOWj04IhNx8X4FAx/nN
         85N6l1wu65BdPZYFYqpXJ+2P7+GTYOuDblM6TXNUrhZ6ktEe6tE8uhTCucOud4ZG+cKe
         8Di75CYbop+ykMwf34YADsB/VNwHqbipentocujbqKzPc7xKgLbRCyuolorUuGdmMB72
         m2ymC2QxkAxshsX/opf5mJPZ8+paiqUUgT7vsPO5fZkil6/AMfJDdBKc/F025F/APMTK
         6bkxvPTav7Rx5TLyyx0MizEy+EGemm7ZnHa+Avc8lX4yt6SAXY3AZ23aImVLNr8qATQ8
         q2JA==
X-Gm-Message-State: AOJu0Yzt6RBShh0Rr0uy/7d+kf7w/Pxz7aa75NW7T8xDIgCCz8LQpDHi
	EHNoquPG6xWtiQIhVuF6bk20cOd8SxbcvObpzQJTWKehtGK/PqxMiokgV6JihplPrgGXzygvPA8
	orO0W9jGjK335kA0vSB4A3+riibMbS8vmK27CRd6AMk2s7UjRTIvqw24=
X-Google-Smtp-Source: AGHT+IHLdTHxAPEgztnEkBCPcu0mNsLFx3he/ORXKCr6rmY0827FQvbUORAUY0titALUM3GCLv3nqR+/hyGh/F7yNElodpBw9zrd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c47:b0:3a1:d180:15b4 with SMTP id
 e9e14a558f8ab-3a36595476amr36985405ab.23.1727902014605; Wed, 02 Oct 2024
 13:46:54 -0700 (PDT)
Date: Wed, 02 Oct 2024 13:46:54 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fdb13e.050a0220.9ec68.002e.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
Author: luiz.dentz@gmail.com

#syz test

On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This makes use of disable_delayed_work_sync instead
> > > cancel_delayed_work_sync as it not only cancel the ongoing work but a=
lso
> > > disables new submit which is disarable since the object holding the w=
ork
> > > is about to be freed.
> > >
> > > In addition to it remove call to sco_sock_set_timer on __sco_sock_clo=
se
> > > since at that point it is useless to set a timer as the sk will be fr=
eed
> > > there is nothing to be done in sco_sock_timeout.
> > >
> > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d46=
5
> > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_w=
ork")
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  net/bluetooth/sco.c | 13 +------------
> > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > >
> > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > index a5ac160c592e..2b1e66976068 100644
> > > --- a/net/bluetooth/sco.c
> > > +++ b/net/bluetooth/sco.c
> > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, i=
nt err)
> > >         }
> > >
> > >         /* Ensure no more work items will run before freeing conn. */
> > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > +       disable_delayed_work_sync(&conn->timeout_work);
> > >
> > >         hcon->sco_data =3D NULL;
> > >         kfree(conn);
> > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk)
> > >
> > >         case BT_CONNECTED:
> > >         case BT_CONFIG:
> > > -               if (sco_pi(sk)->conn->hcon) {
> > > -                       sk->sk_state =3D BT_DISCONN;
> > > -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
> > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > -               } else
> > > -                       sco_chan_del(sk, ECONNRESET);
> > > -               break;
> > > -
> > >         case BT_CONNECT2:
> > >         case BT_CONNECT:
> > >         case BT_DISCONN:
> > > --
> > > 2.46.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

