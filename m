Return-Path: <linux-kernel+bounces-376845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325E39AB6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB5A1C23264
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB631CB30A;
	Tue, 22 Oct 2024 19:19:56 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3621C9DD8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624796; cv=none; b=bC7LbKthxGH5VtiIYy+ShcdYrGwrq32vq1o+ehPqUiBEY9MH5yQ4c3WYdR2FOE/PhXWKUPZR7xtxBnhp4ffs5HJtz59BwyZMy3HSuoDjyThVhEVtgUexmUivzo0DZfHbkpixdcXspVUS62ZRdQxzA75ivlNsDI8vpz78MpSPbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624796; c=relaxed/simple;
	bh=wshjq/oxHWC7mtxx3lsUikYyyMnLYQh5pu/b/Vxt1QI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MIFij16lMk20rc9umNBOPCj6juQoPcf3KSmls/EoonfZ8Uz0pn3iVAnU/VzsEFwVg1fcBMhyQK8nQrvw9b2J0L0L2C8+BbwIgFYr2DYU0oySoNL1vHM6svLcHbpj0g6N5Sw5prXbMBr0x2EszrvzJd9Nuz+w8Yy+yjUU1vNCuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3e1ef9102so61090985ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729624793; x=1730229593;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j03T2wlfYmatPG5AVeoste/ARfMJozjZtqiBQvfIvw=;
        b=X71IY8tYRsxHVKohLye9c0F5MB4oNK37uTDO/0Dqil3sY9OxLEflZKqSFO+7QptvK2
         QXh5tqmfb6KHjA3vEh70O/yy4XLYztq+3YgjaQawksgww5lOFIydtdgZvah3Y3ehXQDD
         +IbpfkZImGpQOaCUlN0hGCGSLvXO6yKNbklEJWgrQDgCb97Idh0hop3F2zvIzETUwuf2
         hFTHkH85M8Pm62AVT9ykqM4yrEsUR4BTIm5IPPqJPoBf+ouWRIMh9xZsYHCrTRwi9r2F
         nngtilDUrLGMXcstOTzGrZLQmd5knBEI0cFwKu9XdfrjMy5tPfJTegAfI7qyxq+zRotv
         deBA==
X-Gm-Message-State: AOJu0Yx7VPOGdN1UC4dbChevIuyW9NRcaIejbb1y1bui5dGun1GuL3JX
	zVQT7aP0FnBG0zrSph1L8RdWxDxrM8pYND0wD7yyGtX6tDDGXYq5OoC9kZYinh4U+HGMo06uGCk
	B2L8t3AMcWehLWrIFlNEH84YrdLNyZM+7BFpVW9bAMUPztyVHcYpHJDk=
X-Google-Smtp-Source: AGHT+IHc5hSkQ14ZGbtXAqNKEtDK9a6JSIu5KMIytV+osWW30EREKjpZDdsQSI9TQ3lXlsIsbG9/1LQdqZFuL3/1WDGO3GBCIi3Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180a:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a4d592e278mr2298515ab.3.1729624793495; Tue, 22 Oct 2024
 12:19:53 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:19:53 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6717fad9.050a0220.10f4f4.016c.GAE@google.com>
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

On Tue, Oct 22, 2024 at 12:44=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Mon, Oct 7, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Mon, Oct 7, 2024 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Fri, Oct 4, 2024 at 1:24=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Fri, Oct 4, 2024 at 12:06=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > #syz test
> > > > > > >
> > > > > > > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dent=
z
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > #syz test
> > > > > > > >
> > > > > > > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Den=
tz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > #syz test
> > > > > > > > >
> > > > > > > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von D=
entz
> > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > #syz test
> > > > > > > > > >
> > > > > > > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von=
 Dentz
> > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > #syz test
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto v=
on Dentz
> > > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.=
com>
> > > > > > > > > > > >
> > > > > > > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > > > > > > cancel_delayed_work_sync as it not only cancel the =
ongoing work but also
> > > > > > > > > > > > disables new submit which is disarable since the ob=
ject holding the work
> > > > > > > > > > > > is about to be freed.
> > > > > > > > > > > >
> > > > > > > > > > > > In addition to it remove call to sco_sock_set_timer=
 on __sco_sock_close
> > > > > > > > > > > > since at that point it is useless to set a timer as=
 the sk will be freed
> > > > > > > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > > > > > > >
> > > > > > > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.=
appspotmail.com
> > > > > > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4=
c0d0c4cde787116d465
> > > > > > > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeo=
uts with delayed_work")
> > > > > > > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.den=
tz@intel.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sc=
o.c
> > > > > > > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct=
 hci_conn *hcon, int err)
> > > > > > > > > > > >         }
> > > > > > > > > > > >
> > > > > > > > > > > >         /* Ensure no more work items will run befor=
e freeing conn. */
> > > > > > > > > > > > -       cancel_delayed_work_sync(&conn->timeout_wor=
k);
> > > > > > > > > > > > +       disable_delayed_work_sync(&conn->timeout_wo=
rk);
> > > > > > > > > > > >
> > > > > > > > > > > >         hcon->sco_data =3D NULL;
> > > > > > > > > > > >         kfree(conn);
> > > > > > > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(s=
truct sock *sk)
> > > > > > > > > > > >
> > > > > > > > > > > >         case BT_CONNECTED:
> > > > > > > > > > > >         case BT_CONFIG:
> > > > > > > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > > > > > > -                       sk->sk_state =3D BT_DISCONN=
;
> > > > > > > > > > > > -                       sco_sock_set_timer(sk, SCO_=
DISCONN_TIMEOUT);
> > > > > > > > > > > > -                       sco_conn_lock(sco_pi(sk)->c=
onn);
> > > > > > > > > > > > -                       hci_conn_drop(sco_pi(sk)->c=
onn->hcon);
> > > > > > > > > > > > -                       sco_pi(sk)->conn->hcon =3D =
NULL;
> > > > > > > > > > > > -                       sco_conn_unlock(sco_pi(sk)-=
>conn);
> > > > > > > > > > > > -               } else
> > > > > > > > > > > > -                       sco_chan_del(sk, ECONNRESET=
);
> > > > > > > > > > > > -               break;
> > > > > > > > > > > > -
> > > > > > > > > > > >         case BT_CONNECT2:
> > > > > > > > > > > >         case BT_CONNECT:
> > > > > > > > > > > >         case BT_DISCONN:
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.46.1
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > >
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

