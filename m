Return-Path: <linux-kernel+bounces-349320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA5998F44A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5919282D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3A1A7056;
	Thu,  3 Oct 2024 16:33:12 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413762E419
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973191; cv=none; b=BdSDfihYvDsXMMMPT622j2kOM0Iqb0/t3QQMDFQZsS5joE2dBS72yYovLBXgxYtnukgh1VfRyFEs6wIc81BgdSoZfWA6OamiKTuZguMF1RIl/XM7bh5VA27Vxmj/FtrgAYFlNheZnSNDpS3VFMTcK4fQAdja8mEdVACt9+Sf0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973191; c=relaxed/simple;
	bh=pdR9e8xDIeudWwkdO1B5HPM3fw/ka6VRpGi5Bauc8BQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IfGXuenSchU4JgJ4bLPn36WLWmoHbQRJztgQElPq4N+Z5CiZ8ijLgfGXclfhlYO07ojJWIJHzC+i5gF7hXTnwOIe9hyRBMVbUjhFuIRgPn49ZJLGTTvgWMpiFM2/0taBuZj/LqbMJDim2EoSZa1eZreYNQ7+mGJzoUaWc75J2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso14313915ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 09:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727973189; x=1728577989;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wVWwBM6Hg8rSmxqvFeB4cNtkTNdisnUmCVuuQkHjxY=;
        b=WLAj5AjL+/9VaROHI60C6XoEYvEezHeVdCt2kkePdweRbeVcV3Izb2G3/MU0F0G9x2
         LdGA5hX3GN9/rYSMUqi+My0JchJ1AOScveFR+PD9tpguUL8yS1kCsxBGCU87DjBPX6ea
         xZ2ibGUXSd3T1GV/FzzzBmigd3+/bmNXZeH3uzG29ZRA3HXE3CAtt3Mr9848Rtbm30a/
         q7xNivpzTA4MLDpE5mi+EElniRJ0vAfaCjfwSoO+xOE2RdMbMfdND6HFYqRVwq0g7S66
         Tm57gOIaW00LoMfyxLK6+r8bLse320gWOZmYBRC+OqRT5TBq0tm1QtaRPJrbYBh6Fhbp
         /yfg==
X-Gm-Message-State: AOJu0YyuD1z6tPyKrMhdma9BjuIaBJX1pv74RVOtzN2swyeR4wL6Xzuu
	i4KLsuXKZWab2FJBaRTl3snkorycBCeHxX4UaYeVxYMBlgGB7zqJ2UMSk3t623zJxfiW+Gh37Ff
	F1pEpOfUP3nO1D2T0e4mb5QqPF9Q80LiNmesI1ZY2a4UW3Am70H7ctVY=
X-Google-Smtp-Source: AGHT+IGyuosf9ZE9/5Mwr5DBXP/7AlQ3O5Pv16eY2PNoL23OGJiRFBudbrTWYKkWEf3VuFQXWsbUVJyMRJlP11Pli281O5sVvHBZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:3a0:a385:9128 with SMTP id
 e9e14a558f8ab-3a36591ad35mr69584825ab.6.1727973189358; Thu, 03 Oct 2024
 09:33:09 -0700 (PDT)
Date: Thu, 03 Oct 2024 09:33:09 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fec745.050a0220.9ec68.004c.GAE@google.com>
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

On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >
> > > > > This makes use of disable_delayed_work_sync instead
> > > > > cancel_delayed_work_sync as it not only cancel the ongoing work b=
ut also
> > > > > disables new submit which is disarable since the object holding t=
he work
> > > > > is about to be freed.
> > > > >
> > > > > In addition to it remove call to sco_sock_set_timer on __sco_sock=
_close
> > > > > since at that point it is useless to set a timer as the sk will b=
e freed
> > > > > there is nothing to be done in sco_sock_timeout.
> > > > >
> > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.co=
m
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde78711=
6d465
> > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delay=
ed_work")
> > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > ---
> > > > >  net/bluetooth/sco.c | 13 +------------
> > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > --- a/net/bluetooth/sco.c
> > > > > +++ b/net/bluetooth/sco.c
> > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hco=
n, int err)
> > > > >         }
> > > > >
> > > > >         /* Ensure no more work items will run before freeing conn=
. */
> > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > >
> > > > >         hcon->sco_data =3D NULL;
> > > > >         kfree(conn);
> > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk=
)
> > > > >
> > > > >         case BT_CONNECTED:
> > > > >         case BT_CONFIG:
> > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOU=
T);
> > > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > > -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> > > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > > > -               } else
> > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > -               break;
> > > > > -
> > > > >         case BT_CONNECT2:
> > > > >         case BT_CONNECT:
> > > > >         case BT_DISCONN:
> > > > > --
> > > > > 2.46.1
> > > > >
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

