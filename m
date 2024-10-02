Return-Path: <linux-kernel+bounces-348173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F25E98E3AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D680A1F23E84
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B4215F77;
	Wed,  2 Oct 2024 19:47:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE318AE4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898425; cv=none; b=rTj7WqSrk1FQM5m8oNau3O+Dbz6UqR2nN3tMgNf3u4j5SWXV7r9Idjg0/YkXtzkGTY59+/ep9TIoUbN5ZkT+lAtj5q3bfMQwrJYk8VflYzOO79GjLU7gsByixAPA1odrpp+7FGBc1+gkvFqY2XfRg34h8LNsn+BZh4K+U4u+yfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898425; c=relaxed/simple;
	bh=qrbxtLHe5suQPlKW6F1J1QcnYHxjFAIDsGArZrYJkdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=orLzVuewOjj3ToGB2lsja4Pfdx8lsYO6lL716IjxOVX7QxeTWKFntwHnoy6BYNKRYF9uhiMONF/Eaia9tZbqcl/oraMKaHZDmfDl6iPZzPTxABBQTpdyrjAYVOfGk00+zo5o+nFMCkhk7CfD3xbI9YzRHb5XfKc2OcFjeCio62o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a2762bfcbbso2226195ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 12:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727898423; x=1728503223;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ4wb4RltlgnGTZlKXrtgdBCeaiC0nd+LLykSP6xLio=;
        b=Qe+QP6HBOuktBCMWljyvFZPsdLJYSw7gLvb6XxMv3XcFU3ydoq6ICm34p4b9u2NBCt
         /iVgFrxpzVZ7CRTdC5LQqqN4jR/HGH4u138TNrPHBBUsP7snZ45eb5PdTGLwcOUX2Gh6
         DxqNiFWnrCOdGm4EP1iahEsOmiawQCiPaeNLflUhWJVXo7EMJ4zwSHRlV4yCmAIJCTia
         V0m0H1rVBHs7J7QhOz8edMsk2AjSpBBY7tapAEvKAfLs08RZwlTjqdqb8/rdJMwyu3iQ
         R2BWJfg8OW2rPcYzdY8wACz48RufBt/91VNRP6scjx8U6mZTQoJVzQlPKGMJ94qZNsv2
         ECAQ==
X-Gm-Message-State: AOJu0Yz1d54uX6Y6NgsB0VACxGQVWH3i4WKDYS+RjR6nl1uND8dsix40
	ZsX+T7p9SnTbzfh386A+xtdIWtUm73FsitVhOclSyKnQe9fHtr9OgRvB89pK/G9i9TiUi0glbMa
	KHmo48O8RaHiW3aG9+DSTR7ymnsDzmmfjmvD+gFW3PaMp0Nlha1IhUPI=
X-Google-Smtp-Source: AGHT+IHJWb5HwEXrsKOoyFRr407kdppO0ajedKzyybrBCoBWicMmlh99QO/6iQvnGsbwIvehbAP0mtibmu4U0/c6R7TdNr4vz81v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24e:0:b0:3a1:a26e:81a with SMTP id
 e9e14a558f8ab-3a36591ae72mr47489945ab.7.1727898423101; Wed, 02 Oct 2024
 12:47:03 -0700 (PDT)
Date: Wed, 02 Oct 2024 12:47:03 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fda337.050a0220.9ec68.002c.GAE@google.com>
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

On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This makes use of disable_delayed_work_sync instead
> > cancel_delayed_work_sync as it not only cancel the ongoing work but als=
o
> > disables new submit which is disarable since the object holding the wor=
k
> > is about to be freed.
> >
> > In addition to it remove call to sco_sock_set_timer on __sco_sock_close
> > since at that point it is useless to set a timer as the sk will be free=
d
> > there is nothing to be done in sco_sock_timeout.
> >
> > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d465
> > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_wor=
k")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/sco.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index a5ac160c592e..2b1e66976068 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, int=
 err)
> >         }
> >
> >         /* Ensure no more work items will run before freeing conn. */
> > -       cancel_delayed_work_sync(&conn->timeout_work);
> > +       disable_delayed_work_sync(&conn->timeout_work);
> >
> >         hcon->sco_data =3D NULL;
> >         kfree(conn);
> > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk)
> >
> >         case BT_CONNECTED:
> >         case BT_CONFIG:
> > -               if (sco_pi(sk)->conn->hcon) {
> > -                       sk->sk_state =3D BT_DISCONN;
> > -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
> > -                       sco_conn_lock(sco_pi(sk)->conn);
> > -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > -               } else
> > -                       sco_chan_del(sk, ECONNRESET);
> > -               break;
> > -
> >         case BT_CONNECT2:
> >         case BT_CONNECT:
> >         case BT_DISCONN:
> > --
> > 2.46.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

