Return-Path: <linux-kernel+bounces-350823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A69990A16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FAE1C220E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46711CACDE;
	Fri,  4 Oct 2024 17:24:18 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81A157492
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062658; cv=none; b=Lec5zLRQztMHsSAKO44BXrIXwwsKHXKwHRz/AJbR03cWt7I+Bzu8klSFFRc/snAkl/PoC5GXntTNAVDkKtM8Nc2Mg68JykDSqqcyw7wDAYfyNQP2Acc/SQAIfOI2Elqk9+46Xk9RJsK/XN99sgHK7xSuaEXbMH4fFQmhLgIZP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062658; c=relaxed/simple;
	bh=EmoHa8FaFyVL7Z1GSWqvvyNiResVTgGVxkK+1B2SBaU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hRzVBl9fVuKFEU8hsOt8Dj0fDplIp4cfGmlFD3vVn2mEc8iN5yCQA5mfhoY/BuQGQI7uKF1GSp+yCNZOvi+wgEl1bNk8XNgCr9z//zBSyMCFE0n1FSjN3GZkgqgIALJ2CFDUxfo/W+HPLUovqOyUXEzRAWECj7N4ZjX4giHbeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a342e872a7so27388515ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 10:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728062656; x=1728667456;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFJi+zD7QTScJAa7VViMozX/t6MTB1OGWcLLN5k1oyg=;
        b=dMZaf7YyIhFcgFy85eFReHTqdf64RF92IVXioqbnURDTEv2gfoF4BqYbL5G6fP0p59
         ZoW6U8+H8KzCHyKV7OIPk6aAeEPo8mt2v5eZGsf2v6kZ1mfihLAaslKewq7rQ5KM7uch
         g7U/Mh4sioaXid8pgb2SWx6bzLMNC6uhzRaerQQnXG/jz6PwpP3C+3Qh6FJRSfT0wy50
         y2dh2sv8xvTPUp0gG8Xe/nDfH3NUoE5cWo5dUnnG0NSoFVBn8CDuMYuqWBelvF6CvBJB
         HPPd/n2gW6I05gJnj4+VGyBGtOWou8ZbOFk7vaN7rlEXt3E4TiQBgRVahb8XoIMrxMSg
         qFcg==
X-Gm-Message-State: AOJu0YyI0KBiY0jXdSn88eRGMgrQloDmHsROSirvdQO0MYiCqkV74dEy
	m9K+KbK7Fdcdozic8BPadM7BLgAwUhD4w1R4YBWUvI1tBHAdZFcsNPhBZeTGQ5owTxCbMtMZVIy
	rEICA6/7FBCBF8jf0mE8jM0M+AfFGFhccHTKorLpJweqaawA6ph74bgA=
X-Google-Smtp-Source: AGHT+IEA72hEupiTV0Hw0dPbeG7j0tr9d60tvqasfKq4R+eQZbAaE5Yw4JPI2YruV+TS4D4bcv/4ynaTAdDg0rtf8CoAEJXtJbIS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a375997255mr35986755ab.7.1728062656092; Fri, 04 Oct 2024
 10:24:16 -0700 (PDT)
Date: Fri, 04 Oct 2024 10:24:16 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670024c0.050a0220.49194.0494.GAE@google.com>
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

On Fri, Oct 4, 2024 at 12:06=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > #syz test
> > > > > > >
> > > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > >
> > > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > > cancel_delayed_work_sync as it not only cancel the ongoing =
work but also
> > > > > > > > disables new submit which is disarable since the object hol=
ding the work
> > > > > > > > is about to be freed.
> > > > > > > >
> > > > > > > > In addition to it remove call to sco_sock_set_timer on __sc=
o_sock_close
> > > > > > > > since at that point it is useless to set a timer as the sk =
will be freed
> > > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > > >
> > > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotm=
ail.com
> > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cd=
e787116d465
> > > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with=
 delayed_work")
> > > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel=
.com>
> > > > > > > > ---
> > > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_con=
n *hcon, int err)
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         /* Ensure no more work items will run before freein=
g conn. */
> > > > > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > > > > >
> > > > > > > >         hcon->sco_data =3D NULL;
> > > > > > > >         kfree(conn);
> > > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct so=
ck *sk)
> > > > > > > >
> > > > > > > >         case BT_CONNECTED:
> > > > > > > >         case BT_CONFIG:
> > > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > > > -                       sco_sock_set_timer(sk, SCO_DISCONN_=
TIMEOUT);
> > > > > > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > > > > > -                       hci_conn_drop(sco_pi(sk)->conn->hco=
n);
> > > > > > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > > > > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > > > > > > -               } else
> > > > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > > > -               break;
> > > > > > > > -
> > > > > > > >         case BT_CONNECT2:
> > > > > > > >         case BT_CONNECT:
> > > > > > > >         case BT_DISCONN:
> > > > > > > > --
> > > > > > > > 2.46.1
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Luiz Augusto von Dentz
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
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

