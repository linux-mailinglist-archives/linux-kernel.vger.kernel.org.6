Return-Path: <linux-kernel+bounces-349496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E59398F6F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62CC1F226D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD65B1ABEDA;
	Thu,  3 Oct 2024 19:21:53 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4738DE0
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983313; cv=none; b=iWjhc5qICIHZP6v7jVFbfE6Upx3tM5pZx9TQTTzkKwRkZOxVn7PKyFN+fcdMAHe8clpVIc55NxrlZMnOLNFI6by5APsFMYDsOY4EuZYjzfigyAChW1oHNeM4enxJ1IO2lePATjK4GYYnr7KnnasOm9qwRMUq+gJyGUdzarrY4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983313; c=relaxed/simple;
	bh=A6kDslUmefRS6QJsoOkG7iwOp6O9HMCkaug+MKRHGOo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GcFLZvKO4BHg3zbeufJPwMv7Q0kOmznn9f4YXrE/Vfa9dAyZQ5FbuQvfNIzLhAwGNwCeQBaalEpUKDd63R7+6qYsUfrH1JJ+8x2SWw7PNpeyJPRa1HFm6hQqZ2o6nGWlAGWICT8bdCxMZAVbeM6WtXplt0n06lA09stimpyAM4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3440fc2d3so14896895ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 12:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727983311; x=1728588111;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHuZLbykB745Z9hSwLMFeBUoCZCiCLIo/dPAMLU1ApE=;
        b=EOpQdXx3SUoc9AgM8ykMTymkE3mB3iS1WZ8tjG0D2Osp6bU0WXsH+IkWkoTjdn0tev
         CuU0kGnUhOmJ+qLNQy4hMeZQUHdmjHO9ha07aZTP6liOVg/9GleN65ryHQcGsZwu6632
         Rkp8jj9/wdCDmQ96apeYAIpFFraV91bQ5XqBRZotN7gciFutrq5A9Cx7sQ/T4x2qdNjQ
         rAdKEba3KXX55P4SUoE80Jo7DqfzFBAzu4nxtaYKNXO/MDPEfMXQfF+wyZAFnDo8ZwOh
         YqCykHN0snZEIa+5zP1y5A7WVtXqbHcaI6nw/wyedRnHsoaX8DuU+nRBjbW1DxBVXnYs
         cRHQ==
X-Gm-Message-State: AOJu0Yz4ysD1kgEvjlXdq1BfcHfmnz1RvRgbTHZzwoCU7NyX20k0vzXc
	esPXkXa1nMsEKkyR4DTTlFRPrMFF/7Z/l6jnSx7lsjW0J0PakJxm9YQ5zUFgXnF1TnnBwsFC0Zc
	kLjcMG633Le7f4hOIN4cCEYjQkzvLus8wpWsSHYYGgi6BKJKuRKE6XL0=
X-Google-Smtp-Source: AGHT+IF2nNl9gfGXfs3f+dMJ3FTQhF2qo38KBUEQrQ7hxPd7sxOvda+OtuvX1JuMFw6zdUCKYhHSzq7knqkJRZs08LWPpDH6/tTr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c8:b0:39d:25f4:bed3 with SMTP id
 e9e14a558f8ab-3a37597d61bmr3915185ab.5.1727983310775; Thu, 03 Oct 2024
 12:21:50 -0700 (PDT)
Date: Thu, 03 Oct 2024 12:21:50 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66feeece.050a0220.9ec68.005a.GAE@google.com>
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

On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > >
> > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > cancel_delayed_work_sync as it not only cancel the ongoing work=
 but also
> > > > > > disables new submit which is disarable since the object holding=
 the work
> > > > > > is about to be freed.
> > > > > >
> > > > > > In addition to it remove call to sco_sock_set_timer on __sco_so=
ck_close
> > > > > > since at that point it is useless to set a timer as the sk will=
 be freed
> > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > >
> > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.=
com
> > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787=
116d465
> > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with del=
ayed_work")
> > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com=
>
> > > > > > ---
> > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > --- a/net/bluetooth/sco.c
> > > > > > +++ b/net/bluetooth/sco.c
> > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *h=
con, int err)
> > > > > >         }
> > > > > >
> > > > > >         /* Ensure no more work items will run before freeing co=
nn. */
> > > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > > >
> > > > > >         hcon->sco_data =3D NULL;
> > > > > >         kfree(conn);
> > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *=
sk)
> > > > > >
> > > > > >         case BT_CONNECTED:
> > > > > >         case BT_CONFIG:
> > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > -                       sco_sock_set_timer(sk, SCO_DISCONN_TIME=
OUT);
> > > > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > > > -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> > > > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > > > > -               } else
> > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > -               break;
> > > > > > -
> > > > > >         case BT_CONNECT2:
> > > > > >         case BT_CONNECT:
> > > > > >         case BT_DISCONN:
> > > > > > --
> > > > > > 2.46.1
> > > > > >
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

