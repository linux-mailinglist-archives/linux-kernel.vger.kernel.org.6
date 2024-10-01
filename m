Return-Path: <linux-kernel+bounces-346373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D9D98C403
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583CE2819C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB09B1CB520;
	Tue,  1 Oct 2024 16:56:38 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9B1C8FC1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801798; cv=none; b=B5JpEUM4I0QpXS1EVL4RIwqMaAS3T5E53PKta8C6WLLvwOHxTJbMl3Qy5lTN5TfT+yba5+5QxpByAyl/P3bM7zPHWQADcptJfrBBowwXOjNjyGDOv3w6sBzamOXt65tdkn6oKGtDGlHN0qGlWh7WtYQ7IESnNnNPn5L08C29Ab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801798; c=relaxed/simple;
	bh=LrL4NDg9qghYwrCT/VKjknFsR3pPYmf3ivPk7EQpF/k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nSm6JEa5FK4wtGK4SJMakAUIIZFiyYR/2yj4eM/tQFB9qUGWTJLXaZSZ7OiT/DPu/1WpN+Q2ma67/VxPwdxqILvCGyCAr1IBht2NRfdBrQHGY/QLEAUO2FL5ELGE8M9ZzIqkmKFvgR1jJMeVDKXVR9PgWU23mocVITQsrMkQsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a363981933so7770215ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 09:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801796; x=1728406596;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXzSIn7RK9nrN2d0BAWEc8JSidJBOXThBoGuNF4xRXo=;
        b=dYlIKUP3IZlTQ4ciPedBjLwBAv5NbmYZX/Pk8h80NXQ61EHDljWL/lXhiY2ILif/4H
         F4XUHUCFrzV4noevhfMNf41Ki+/ak3RlkqPBoF55GSk+6cL2Skhs1+h3rKoGP6zxwrmg
         4W1Fv5FmhDfNP9DYmAWRdr3MxDu0/l5gppK3uI6g1DvTCzwwfS9S1ATS8/j2ZzqbqzPb
         T7aOY0Iy/LVXRy9Rh6aDgiUR+TIlrHeI5+3QIKAdeVa6Vkhj6QQBl3XG//T1ZEExOZHk
         PNJJUbyjAc82o2P4vXFYxg7YFwZ8Q8tSKqEMDCb5xBIYaFyS+xqtj0NINF656RHb32GF
         NeVQ==
X-Gm-Message-State: AOJu0YzjTgVWdPyf2OAWYL8pK9vHpQ4VV25Yp+6SN+7oMVFuZyNZxfD/
	kNuMP1q4AaAXJu0YidX1LBcWlQsvxi1y94kKc4+dGmleU9PhGDjTYIFro8rLhXg04JsaaQc6Jsi
	0SVuCPD0P899OCPDxrQz0gQxU4LcjWXzU5uYfkvOXGgtV3GMv1qytNSQ=
X-Google-Smtp-Source: AGHT+IFWC02YmIVdkNZXbwuC0to33C/XQqO6eJGMiZgZdL6Pkj3H7LC8AtbIqwJXYp1GANYz4E1mh2pNOJIo9RXo8pfpc9cQT5fu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1748:b0:3a0:9cd5:931c with SMTP id
 e9e14a558f8ab-3a365949f54mr1400435ab.20.1727801796279; Tue, 01 Oct 2024
 09:56:36 -0700 (PDT)
Date: Tue, 01 Oct 2024 09:56:36 -0700
In-Reply-To: <0000000000007450a405abd572a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc29c4.050a0220.f28ec.04bc.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH v1] Bluetooth: hci_conn: Use disable_delayed_work_sync
From: syzbot <syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH v1] Bluetooth: hci_conn: Use disable_delayed_work_sync
Author: luiz.dentz@gmail.com

On Tue, Oct 1, 2024 at 12:50=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes use of disable_delayed_work_sync instead
> cancel_delayed_work_sync as it not only cancel the ongoing work but also
> disables new submit which is disarable since the object holding the work
> is about to be freed.
>
> Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
> Closes: Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.co=
m
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_conn.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 0c01ece500a9..fb0946eac8a4 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1124,9 +1124,9 @@ void hci_conn_del(struct hci_conn *conn)
>
>         hci_conn_unlink(conn);
>
> -       cancel_delayed_work_sync(&conn->disc_work);
> -       cancel_delayed_work_sync(&conn->auto_accept_work);
> -       cancel_delayed_work_sync(&conn->idle_work);
> +       disable_delayed_work_sync(&conn->disc_work);
> +       disable_delayed_work_sync(&conn->auto_accept_work);
> +       disable_delayed_work_sync(&conn->idle_work);
>
>         if (conn->type =3D=3D ACL_LINK) {
>                 /* Unacked frames */
> --
> 2.46.1
>

#syz test

--=20
Luiz Augusto von Dentz

