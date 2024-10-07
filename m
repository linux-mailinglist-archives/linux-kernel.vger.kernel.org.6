Return-Path: <linux-kernel+bounces-354166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2A993897
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B410284FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B10A1DD86A;
	Mon,  7 Oct 2024 20:54:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BE81727
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334464; cv=none; b=fN42u8ZAYjxNmWdZV++OlLbxNtQ35/PVyOumdNMP9kuYqHtvXKRlnqWeos8nCS4Gpb4X4Ezhdo3m/2Ip3MXFii+Wejy2K+EeIm7yVnZgaA2MIryiPwSBRrYGYh10OYXyJXNN2pSAqUWJzdbbzsXDDRZGWKt8FJX5sDOE6wlGiKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334464; c=relaxed/simple;
	bh=rr6m0w3DL39bN6kD+FkMM3xt5Xbi3zEQzMeCqYJjMME=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uz3xcCuYSyHbrVK1w75D0KqazNaIDC1qOOGc49yp7aVf6I/nj3JaW6ZtWVv20/03zAYeMzcjnC/uAKaFs5wTj+hXxW2Hn/2dbl39dqKAuo2fkXL0m+4qJFzj/HPIMI2PgtEbMYlRTJpKfL+sLtxfjiAc8PAVcbs81X0xh0iteTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa499f938so437109439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728334462; x=1728939262;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNsrv5NW0cUZtvXJAaT0IwGXqMqed/zaJY15Wr/EyEE=;
        b=piXNd9pqgtgFzc/bBvMuy4iNTF/KUyOz5uV9MQrhtc8SWjyK2nFXXufazr6ckGZLJ8
         IfTsjIiGLfreW3L7lntsENRNCFeaRtwXnJz6bad+6/JXvSMGXLOoaaZAAgSKOtGhsrqF
         Lfm2VDYrAWgurIu/ScS4woIpL5iEoyPRKalnUxDw2N6QxhVfSfQWQvgCKV/oEvYLyqOU
         GD6K59lGXo1UtPcdXSZmf5GIXyvHc+uggOo65c7A5npuMHcOEsasosOFhmEP2iwL5erw
         7Qg6pPFWRoQyzqVO+a4IJ+f0kfXgdmwLBwKK0/FJ8NTgpxCfiYuHxpZ82mkGQfjpbqa0
         R8PQ==
X-Gm-Message-State: AOJu0YwW/cHH56XgwwiO/YRFBojZ0y8FCdrCR1zOTLLH8GjQE5YW1yUa
	VGaB+8F8tx9dOvax8wAYvVd1SJh2q6gVd4Nc2GCZE41oFOKGGF/CoHAuEHiUl1zIrXzflnwRqR0
	O4Zi4wGG9hitVkX5+QB+xeV/cejbookQe58ekw4Mw72Av2aNwkXZnehE=
X-Google-Smtp-Source: AGHT+IE68towaS9fxcOJbmYhd7A1Mgq7QCTrNj28+qJ7WjiJ5BuE2gOoy3KiknyLQKB428jCD69rv5WaPf5Ji+GZgqQitLw7gNnZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:3a0:9f36:6bf1 with SMTP id
 e9e14a558f8ab-3a38af6a33fmr7485905ab.9.1728334461808; Mon, 07 Oct 2024
 13:54:21 -0700 (PDT)
Date: Mon, 07 Oct 2024 13:54:21 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67044a7d.050a0220.49194.051a.GAE@google.com>
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

On Mon, Oct 7, 2024 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Fri, Oct 4, 2024 at 1:24=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Fri, Oct 4, 2024 at 12:06=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > #syz test
> > > > > > >
> > > > > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > #syz test
> > > > > > > >
> > > > > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Den=
tz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > #syz test
> > > > > > > > >
> > > > > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von D=
entz
> > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > > > >
> > > > > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > > > > cancel_delayed_work_sync as it not only cancel the ongo=
ing work but also
> > > > > > > > > > disables new submit which is disarable since the object=
 holding the work
> > > > > > > > > > is about to be freed.
> > > > > > > > > >
> > > > > > > > > > In addition to it remove call to sco_sock_set_timer on =
__sco_sock_close
> > > > > > > > > > since at that point it is useless to set a timer as the=
 sk will be freed
> > > > > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > > > > >
> > > > > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.apps=
potmail.com
> > > > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0=
c4cde787116d465
> > > > > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts =
with delayed_work")
> > > > > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@i=
ntel.com>
> > > > > > > > > > ---
> > > > > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci=
_conn *hcon, int err)
> > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > >         /* Ensure no more work items will run before fr=
eeing conn. */
> > > > > > > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > > > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > > > > > > >
> > > > > > > > > >         hcon->sco_data =3D NULL;
> > > > > > > > > >         kfree(conn);
> > > > > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struc=
t sock *sk)
> > > > > > > > > >
> > > > > > > > > >         case BT_CONNECTED:
> > > > > > > > > >         case BT_CONFIG:
> > > > > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > > > > > -                       sco_sock_set_timer(sk, SCO_DISC=
ONN_TIMEOUT);
> > > > > > > > > > -                       sco_conn_lock(sco_pi(sk)->conn)=
;
> > > > > > > > > > -                       hci_conn_drop(sco_pi(sk)->conn-=
>hcon);
> > > > > > > > > > -                       sco_pi(sk)->conn->hcon =3D NULL=
;
> > > > > > > > > > -                       sco_conn_unlock(sco_pi(sk)->con=
n);
> > > > > > > > > > -               } else
> > > > > > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > > > > > -               break;
> > > > > > > > > > -
> > > > > > > > > >         case BT_CONNECT2:
> > > > > > > > > >         case BT_CONNECT:
> > > > > > > > > >         case BT_DISCONN:
> > > > > > > > > > --
> > > > > > > > > > 2.46.1
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Luiz Augusto von Dentz
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Luiz Augusto von Dentz
> > > > > > >
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

