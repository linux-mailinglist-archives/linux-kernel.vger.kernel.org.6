Return-Path: <linux-kernel+bounces-350724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF7990896
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CA01F213A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5B1C3034;
	Fri,  4 Oct 2024 16:07:02 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89B15B0FF
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058022; cv=none; b=IBvjZ/eYDPiZUBto5CwaGOvSfxF78G2Cdhsmt8uhMqRp1GWw9RjGspUTjdEc0KD7tMPL8iTwFZYtBaiBT5j8tQ14hTU4C+r/uf8DPVa5OPGDzYwXJ18VK9yHwMzieJZ6ytuVTnoKm/Q2D9TvR/eZiWmsSIX+uOYLZiYfpIWlAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058022; c=relaxed/simple;
	bh=IV81TM1q/p60AHEBoWK4VmgWOqyKimZDTxbgd/TWzdc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k2w+8p24crXzQvRKwo+svPBQfHSv2YUIJAxgodyZDSDbfcq/HF55O7gjehCG3Vzy6PG8yRbzuwMRfwDTC3h0AiOLY2jeRUlREinESxxdKbsfT3WBv01Tl0bNBX4YZ1ZxVDWPhMn3EWYygpzF0wPTnYGX6tOUoI3HBdfDfwTHm4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a364ab1eedso20033475ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728058020; x=1728662820;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf6/W6MgIN36a+r3X9LYdgkddJ8csIvgvx8RKaA0Mcg=;
        b=eTNyqB9INkTWomctpR64pi89IyvT9s8yP3LOYqBYAg7ztd1oPE/1tjJMOzy62NYnMG
         tqKxVBfPU2pDRHw2HLftW5NoC9NFotg7N4obP5/7gv3m3ExZf2AMPNMSG+py7z3kEQ8P
         0g0GXH26ncDtGjqbSrgxWgRlwpodj/w0klWSJuVBX0fcxB5ZKM1nh5NxfZGTcK7CuJxV
         ZCevvDtaTHXU0sNpFO8Vu8SnPgwuRC+sN8Oi+USBkzOh0cmEWQHDjdUXvTkm/kwUP/h4
         qlDPxoYCONqP2+1Z0On9avhSuNDwBqqQjPvtT77cYHZkTFQfOZCJrmB6MC/gLcwpw/h4
         webQ==
X-Gm-Message-State: AOJu0YwKGVgmpGz9P7ltrEfegWFu+EWlaCoL7KEg0TI2IVQpIaM2tHBh
	xttBZZHH3pb5kTScQrSd7rsk+Q3hDPz9N7+LPONbaM3Y9FUaEmFTcrbcKRx6dGbx5JtKX22feOW
	4Oc1/COk3bM1ulCBXJatzKJSrtpUd5HLJ5Qj/sjQNPgJGPvISqNW5MX0=
X-Google-Smtp-Source: AGHT+IGaUaKqrNYpskEkMtSt1V2gGcgmPzdR2vmAXsO6yB5CnreXODyrNnFmWGT5nY5scq/OS+jay8PjIm2hUwB/d3xnHXTXHS4w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:3a2:76c9:f2b7 with SMTP id
 e9e14a558f8ab-3a375bda8e2mr30755545ab.24.1728058019602; Fri, 04 Oct 2024
 09:06:59 -0700 (PDT)
Date: Fri, 04 Oct 2024 09:06:59 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670012a3.050a0220.49194.0490.GAE@google.com>
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

On Thu, Oct 3, 2024 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Thu, Oct 3, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Thu, Oct 3, 2024 at 11:38=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > #syz test
> > > >
> > > > On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > #syz test
> > > > >
> > > > > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > >
> > > > > > > This makes use of disable_delayed_work_sync instead
> > > > > > > cancel_delayed_work_sync as it not only cancel the ongoing wo=
rk but also
> > > > > > > disables new submit which is disarable since the object holdi=
ng the work
> > > > > > > is about to be freed.
> > > > > > >
> > > > > > > In addition to it remove call to sco_sock_set_timer on __sco_=
sock_close
> > > > > > > since at that point it is useless to set a timer as the sk wi=
ll be freed
> > > > > > > there is nothing to be done in sco_sock_timeout.
> > > > > > >
> > > > > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmai=
l.com
> > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde7=
87116d465
> > > > > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with d=
elayed_work")
> > > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.c=
om>
> > > > > > > ---
> > > > > > >  net/bluetooth/sco.c | 13 +------------
> > > > > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > > > > >
> > > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > > index a5ac160c592e..2b1e66976068 100644
> > > > > > > --- a/net/bluetooth/sco.c
> > > > > > > +++ b/net/bluetooth/sco.c
> > > > > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn =
*hcon, int err)
> > > > > > >         }
> > > > > > >
> > > > > > >         /* Ensure no more work items will run before freeing =
conn. */
> > > > > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > > > > >
> > > > > > >         hcon->sco_data =3D NULL;
> > > > > > >         kfree(conn);
> > > > > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock=
 *sk)
> > > > > > >
> > > > > > >         case BT_CONNECTED:
> > > > > > >         case BT_CONFIG:
> > > > > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > > > > -                       sco_sock_set_timer(sk, SCO_DISCONN_TI=
MEOUT);
> > > > > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > > > > -                       hci_conn_drop(sco_pi(sk)->conn->hcon)=
;
> > > > > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > > > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > > > > > -               } else
> > > > > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > > > > -               break;
> > > > > > > -
> > > > > > >         case BT_CONNECT2:
> > > > > > >         case BT_CONNECT:
> > > > > > >         case BT_DISCONN:
> > > > > > > --
> > > > > > > 2.46.1
> > > > > > >
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

