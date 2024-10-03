Return-Path: <linux-kernel+bounces-349225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED85C98F2B6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8152281E69
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268791A3A9A;
	Thu,  3 Oct 2024 15:38:51 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420FD1A072B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969930; cv=none; b=sV7039cOvwMBQ7YZS4XfwGcGg9guxbyxmt6T5ZARNOM3g5fakcE8eufGTIBdZegbcHPPQr3xh3qy2Ag0C6Jjiksi00p++2SViJjFzyPGdJolofZB3sDS3+WTyy7jtqBo1aB1QazrOMpsHAXb3w9LjPC+AEuxzuJpCpS2zM9OTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969930; c=relaxed/simple;
	bh=aDu5jgfoLgLfpBnvqjfglMotLVHMDXsNk1NW7ea3NZU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uro3WBzL8KdZims4RkY+e/IvReKXGvKI5EXMhlYyJgHatexZP/w+DBaHKwAMsCWlzPnjG7MTy455y45tKKZ4RlMJ1c2rR6RlSaZzMEbtmIhX+X9rXTDwapROWmzQNQPvHlo4VhQ+ppfcgncD4xJBQcLYtt8b0RteJGXS2V/o0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a343860e72so12284565ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 08:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727969928; x=1728574728;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weNd/O6EUTBtdEeGI+g909EZ3kVgXUX+X78PBbEInIw=;
        b=M6s0fL8d53NQP2nC7gnAPOGScZGwLrrEc2mPYjkxUboF2qmSfSGWD0VIA2+WacBDfn
         tpuDX7/sklDsnMJexds75d3tlWJtUDgHIzVsukuEACkJuU8iM9ZvqKtElPpyv7MxVmlo
         BNWxFj3uSZK3MhgMsoPwOS2KmIekGXr/PGULK2GY6MmI3Z4H3qHvHB0iwI/PeteI4IvZ
         noLVYfMAhspkyuzywVIkTTtnPgRXIzySRULdlFiR7IZRQtug+j+fzwTW1PdKX9qH5N9C
         Trn1U+NraUP0jJ3MYYjmdBytXvLCQf4fy294qYTrEoTbYRTroVTcpcuNmLx/O+lbROnl
         mgHA==
X-Gm-Message-State: AOJu0YzItbIABxxFIrDTQ5ZVF66RGAGk1JcK2qZToxtHv4WmtomI6/hZ
	TDx4NuVgfWH3gY3XnS3Eu5is5wG1KcvvwUlPJmVR+LObErtS/ealq4ZYu8FcKP/HfvcJxYtQo3f
	EH3mYQU691e5b0HXQ1EfljWfjNxWIQNWeTL8kCrHhCX9JySABZ1z7Bio=
X-Google-Smtp-Source: AGHT+IEYlBl+aiYbR+ACqVeU7jphv00avhGC9jq863jtFliV2lYGYlQX58aWzSXlBEqqIZmUgN84QRN8Ggoq4l92boejOVSCUcj6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1806:b0:3a0:9f85:d74e with SMTP id
 e9e14a558f8ab-3a365944fa0mr64919845ab.16.1727969928421; Thu, 03 Oct 2024
 08:38:48 -0700 (PDT)
Date: Thu, 03 Oct 2024 08:38:48 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66feba88.050a0220.9ec68.0044.GAE@google.com>
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

On Wed, Oct 2, 2024 at 4:46=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Wed, Oct 2, 2024 at 3:46=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Wed, Oct 2, 2024 at 3:19=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > #syz test
> > >
> > > On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This makes use of disable_delayed_work_sync instead
> > > > cancel_delayed_work_sync as it not only cancel the ongoing work but=
 also
> > > > disables new submit which is disarable since the object holding the=
 work
> > > > is about to be freed.
> > > >
> > > > In addition to it remove call to sco_sock_set_timer on __sco_sock_c=
lose
> > > > since at that point it is useless to set a timer as the sk will be =
freed
> > > > there is nothing to be done in sco_sock_timeout.
> > > >
> > > > Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d=
465
> > > > Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed=
_work")
> > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > ---
> > > >  net/bluetooth/sco.c | 13 +------------
> > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > >
> > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > index a5ac160c592e..2b1e66976068 100644
> > > > --- a/net/bluetooth/sco.c
> > > > +++ b/net/bluetooth/sco.c
> > > > @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon,=
 int err)
> > > >         }
> > > >
> > > >         /* Ensure no more work items will run before freeing conn. =
*/
> > > > -       cancel_delayed_work_sync(&conn->timeout_work);
> > > > +       disable_delayed_work_sync(&conn->timeout_work);
> > > >
> > > >         hcon->sco_data =3D NULL;
> > > >         kfree(conn);
> > > > @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk)
> > > >
> > > >         case BT_CONNECTED:
> > > >         case BT_CONFIG:
> > > > -               if (sco_pi(sk)->conn->hcon) {
> > > > -                       sk->sk_state =3D BT_DISCONN;
> > > > -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT)=
;
> > > > -                       sco_conn_lock(sco_pi(sk)->conn);
> > > > -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> > > > -                       sco_pi(sk)->conn->hcon =3D NULL;
> > > > -                       sco_conn_unlock(sco_pi(sk)->conn);
> > > > -               } else
> > > > -                       sco_chan_del(sk, ECONNRESET);
> > > > -               break;
> > > > -
> > > >         case BT_CONNECT2:
> > > >         case BT_CONNECT:
> > > >         case BT_DISCONN:
> > > > --
> > > > 2.46.1
> > > >
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

