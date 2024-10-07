Return-Path: <linux-kernel+bounces-353931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D74499349D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0173A1F24A29
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F101DD54A;
	Mon,  7 Oct 2024 17:16:36 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B571DD535
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321396; cv=none; b=JU8YT6ZWES8xDf52DB3xgM+7lQ4+w9aURtN0egFaBNsW9HqltJsevPorxFSO3hCKGTqVYBuaxwsOJpWgv1SOMOzctlElIWJMFXZgP186i2cJGv0+npPxKLCigPzifvV8/LguABYRCWZKCmAB+80i32PiOD1dwI6w38qYeS69TAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321396; c=relaxed/simple;
	bh=AAwz+Ta/N1Z9VvA4fHIrGhfrA5l9p3SUGD3B1eSz5nc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PHdyjlxOLCg4DMtgBqFLajPSxpeDAcUCc7KQnSL3koRVMeR31BHWWPuR6BSufyMELSCKlP+mj1FLJ+Y3ttYRfM+g65/rFmR0x42U/wxr6g8+w+N04mICR50ykJc8bw+oLbc/62rqptL4ruxcwovDSn7ZoBQI3UD3YKxVwwsNbQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3496b480dso41970885ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321393; x=1728926193;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM1Q7uZsW+DQxOD4j+gqIls+XcVZZqDQlann0qp6q/o=;
        b=JCUF9Mkoqnnb2UgHIGn7X2vK/h9M+GBJDjTtLmOCwsAvd2cu7qy3V9IRThBsr3NICM
         BxsOxXX0qfDKAQ8529Yj1cWxBQ440bnzWkfaTP0X13IbtQ1oi7jYmDqWM1mZ4F4HyXh5
         89uyFrfvmhw6SPVKEhFdujPonbzRvRtByNsJpMi8WYaKCSSO5Y5cMFYzBNqncuT/S64c
         wHkuJiSSVy0IG1KVGct3Pg6ltoNfD+GMneYokUvsWU6sjL97YSI2hRQcxFFqFetVW/oM
         zmYyhsJCjXQy+G9Xv8FmFeHu9GS7PCZ6INCvqWdcF4O5OvAs7rXQ0Ep3vPr6fieaIhih
         q42Q==
X-Gm-Message-State: AOJu0YzflF8rI8TmeeShXJL0jAmfEgAAfrDwysa2BUf/ZDfZhv0akuwQ
	JSYBVJAS2AEqKQtjXUSn2k4v6Mm60xcJBU+1c9oRLQ6JJUvhXNZIMCegDvpo7dm0rlD2eQbSJbQ
	XVa2A4E0QS+BjdrNUk6LD4F9MSsa0BPkBlE7T/OG35Fd4tWWqcqd60EA=
X-Google-Smtp-Source: AGHT+IFKzaPozVueM9/BkL4BcA7KWZqpE+uhJNcvYoJZYPJffOSjSU/x+UD8m96lh684kHYFqcGAoyfMnZ1fwVHAjzvVBALCOmaN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca9:b0:3a3:35f0:4c0c with SMTP id
 e9e14a558f8ab-3a375bb2b7emr109867845ab.18.1728321393483; Mon, 07 Oct 2024
 10:16:33 -0700 (PDT)
Date: Mon, 07 Oct 2024 10:16:33 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67041771.050a0220.49194.0511.GAE@google.com>
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

On Fri, Oct 4, 2024 at 1:24=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Fri, Oct 4, 2024 at 12:06=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > #syz test
> > > > > > >
> > > > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > #syz test
> > > > > > > >
> > > > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Den=
tz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > > >
> > > > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > > > cancel_delayed_work_sync as it not only cancel the ongoin=
g work but also
> > > > > > > > > disables new submit which is disarable since the object h=
olding the work
> > > > > > > > > is about to be freed.
> > > > > > > > >
> > > > > > > > > In addition to it remove call to sco_sock_set_timer on __=
sco_sock_close
> > > > > > > > > since at that point it is useless to set a timer as the s=
k will be freed
> > > > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > > > >
> > > > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspo=
tmail.com
> > > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4=
cde787116d465
> > > > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts wi=
th delayed_work")
> > > > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@int=
el.com>
> > > > > > > > > ---
> > > > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_c=
onn *hcon, int err)
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > >         /* Ensure no more work items will run before free=
ing conn. */
> > > > > > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > > > > > >
> > > > > > > > >         hcon->sco_data =3D NULL;
> > > > > > > > >         kfree(conn);
> > > > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct =
sock *sk)
> > > > > > > > >
> > > > > > > > >         case BT_CONNECTED:
> > > > > > > > >         case BT_CONFIG:
> > > > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > > > > -                       sco_sock_set_timer(sk, SCO_DISCON=
N_TIMEOUT);
> > > > > > > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > > > > > > -                       hci_conn_drop(sco_pi(sk)->conn->h=
con);
> > > > > > > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > > > > > > -                       sco_conn_unlock(sco_pi(sk)->conn)=
;
> > > > > > > > > -               } else
> > > > > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > > > > -               break;
> > > > > > > > > -
> > > > > > > > >         case BT_CONNECT2:
> > > > > > > > >         case BT_CONNECT:
> > > > > > > > >         case BT_DISCONN:
> > > > > > > > > --
> > > > > > > > > 2.46.1
> > > > > > > > >
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

