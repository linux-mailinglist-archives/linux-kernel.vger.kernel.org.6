Return-Path: <linux-kernel+bounces-376638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB509AB444
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA26D1F2424F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BAC1BD018;
	Tue, 22 Oct 2024 16:45:02 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D411BD003
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615502; cv=none; b=G1AEUj8zR0pJHZ7++c3N4rHw3vyDqtE7VPDgb2LUYqiCHpnD3sScMY6FxF/CDlUnaifD8OYoWH9itawjT8Jl2iH52s888YrI9ePln2qHFKZ0dQZld6DgsVvBYTXKmi4t3NS87TSNrddF7pD2oZ0nu9KiNE7PLs/OvD8NvoprujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615502; c=relaxed/simple;
	bh=iNilycJqDygru7KgwoqY7bsRlE5bJZAei+MFGmalAW4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rp4A9eQv9adhjnJDbSTTLp3rapFer4RRMVxuK0ys3otmK1LSJol7i6ZAOZFFZqCcjz+CANofB7XSZQ1IWrN5e4e1aKeUj2f9UPAbD7z5HZyGLGON3XzQEOzb0xTZF8ukYWEkekZfhBHBSRe6fIWD1uZU0gSpTHKcbN9Oz/xusXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3cd35858aso52722185ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615498; x=1730220298;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seizxTUznAKa7Hmqom5Il2G97kVHCLlHnh6VPKVQ4T4=;
        b=dpMIpHs3rzKFvBnVgeCWySSmmu6pL4T/G0fIx43xHwrnnp5nirdKOCoGOAFIq3SisL
         OdIyuGt4J35Om/y/pzMCs7PYg3Hl6UGg+bENcVRY2SUaSC7woYl0Gnzpdh9pMUzeGyjP
         2j6hCPh/Ir+cZfDlKCYoz1alYmqc0cbbko7Pzhbl7R0YbGDvG3YHMZXF0YfFAIgD4bo5
         ye9JdV/paQVBrLehwPkyeJnQh6gPfp3O9m955HKX94ini1a1Dc3B7z8g9PX9HOd0WEuS
         jQzZxec6u2QEY1UtKImYXtqFa6v2parlHLu7klw/4PE515BM2x9bNzFfg7ld0tG0tZbb
         UdWQ==
X-Gm-Message-State: AOJu0YwkUJ/LeJMKxpjBmsiy55xzQ9L2UnIMUIinM9KY1+SEk76Avk3s
	+myD/KiRqsMMDnii8IACQzsCLMD8CI7TzPnMbXCcO4wvcjok44dpT6yqSIX9HksP6zXYbBwXwNR
	SBqmrPFZ/hWQAsPI+L8Cw78ywQfTkceYTtxYDYPiZgVi2DNaCk5kKTZg=
X-Google-Smtp-Source: AGHT+IFht6qGBxyqbzWao3lsxdSoHNJIaq9/iRD5YKgsC7H+ohMuc8+PucSFCaeyvglafcQ4laoSuM6pYkqMcZ6RZMme6JE5MlJZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e07:b0:3a0:be93:e8d5 with SMTP id
 e9e14a558f8ab-3a3f406fd70mr147999415ab.11.1729615498398; Tue, 22 Oct 2024
 09:44:58 -0700 (PDT)
Date: Tue, 22 Oct 2024 09:44:58 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6717d68a.050a0220.10f4f4.015e.GAE@google.com>
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

On Mon, Oct 7, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Mon, Oct 7, 2024 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Fri, Oct 4, 2024 at 1:24=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Fri, Oct 4, 2024 at 12:06=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > #syz test
> > > > > > >
> > > > > > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > #syz test
> > > > > > > >
> > > > > > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Den=
tz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > #syz test
> > > > > > > > >
> > > > > > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von D=
entz
> > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > #syz test
> > > > > > > > > >
> > > > > > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von=
 Dentz
> > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.co=
m>
> > > > > > > > > > >
> > > > > > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > > > > > cancel_delayed_work_sync as it not only cancel the on=
going work but also
> > > > > > > > > > > disables new submit which is disarable since the obje=
ct holding the work
> > > > > > > > > > > is about to be freed.
> > > > > > > > > > >
> > > > > > > > > > > In addition to it remove call to sco_sock_set_timer o=
n __sco_sock_close
> > > > > > > > > > > since at that point it is useless to set a timer as t=
he sk will be freed
> > > > > > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > > > > > >
> > > > > > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.ap=
pspotmail.com
> > > > > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0=
d0c4cde787116d465
> > > > > > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeout=
s with delayed_work")
> > > > > > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz=
@intel.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.=
c
> > > > > > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct h=
ci_conn *hcon, int err)
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > >         /* Ensure no more work items will run before =
freeing conn. */
> > > > > > > > > > > -       cancel_delayed_work_sync(&conn->timeout_work)=
;
> > > > > > > > > > > +       disable_delayed_work_sync(&conn->timeout_work=
);
> > > > > > > > > > >
> > > > > > > > > > >         hcon->sco_data =3D NULL;
> > > > > > > > > > >         kfree(conn);
> > > > > > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(str=
uct sock *sk)
> > > > > > > > > > >
> > > > > > > > > > >         case BT_CONNECTED:
> > > > > > > > > > >         case BT_CONFIG:
> > > > > > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > > > > > > -                       sco_sock_set_timer(sk, SCO_DI=
SCONN_TIMEOUT);
> > > > > > > > > > > -                       sco_conn_lock(sco_pi(sk)->con=
n);
> > > > > > > > > > > -                       hci_conn_drop(sco_pi(sk)->con=
n->hcon);
> > > > > > > > > > > -                       sco_pi(sk)->conn->hcon =3D NU=
LL;
> > > > > > > > > > > -                       sco_conn_unlock(sco_pi(sk)->c=
onn);
> > > > > > > > > > > -               } else
> > > > > > > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > > > > > > -               break;
> > > > > > > > > > > -
> > > > > > > > > > >         case BT_CONNECT2:
> > > > > > > > > > >         case BT_CONNECT:
> > > > > > > > > > >         case BT_DISCONN:
> > > > > > > > > > > --
> > > > > > > > > > > 2.46.1
> > > > > > > > > > >
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

