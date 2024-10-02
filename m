Return-Path: <linux-kernel+bounces-348152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F19498E361
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071F21F20C85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264522141CE;
	Wed,  2 Oct 2024 19:20:12 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92A12CD88
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896811; cv=none; b=QKBKpND8FbcpflKCniZu0uXA3RfAyhWu8IsZiyDPNQ0GsFeGNLuzavU1mc1rDB12507aXUVVxSrxBwYF3PnS70qId1av9ir1qcRxoUyjuMFXWcSAhewyeASOUU5oiYfc4T4ubXLoN2uoTlCr5/+CxUcOPGSsZFWOFWi3mJ1d8/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896811; c=relaxed/simple;
	bh=5qmWyKpRe0snNil9D/18vGdhypVImpuMuuwYtrpovpU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z+r5u/amjQW1eeX0dLjZGFx3ujBiUtHkexNJHzWrU8+uyXeB61hrIvl4P8rveuhyrfFgIr2yzx9KlB4o6io99vQ74Hihm2SjMEqv56nWy2ut9feeUqXdKPFvg+Uu9pIscEgjIfv12OOkscuCrH7wMM8AJW4FBW3dQNq5UwGKoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso1687595ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 12:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727896809; x=1728501609;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtl4F5OX2atmH5yaWlb11lC+rEQRY5zOI+L38R8Qs3M=;
        b=MsdvNL1O9/Rs0IcGICBYNRCODkxhR6hVZkH5c2L51oaRXqGw9VcgUF9wf4KAFsn7KU
         KCj1TrqjjyxgHpYLJinKMXVxsaOMvqltQgK5ITne5+dsDIBmaZIXkBDd+Q0JFwr9QPHV
         NupKzo/fyUu8n3xtOWEaFbcSsEwo27Vs2gy9qJl7FRd4TpwY/r7ZB3AjW3NnjiU8V7kt
         gALBsZ+plurCv29vg1l2GfQwrKAIVnrKwMMB5KwE47OOLDiYZeUOU0BejLkeiUOj6NpE
         y+tvF2SDD8EZ22GGd8Ti46KqGAZy/QHhR6CFiHVl2Ab9RmnQe4SXw5+pX85VKqcA3tDn
         PlKg==
X-Gm-Message-State: AOJu0YwjrU7MoNhbJxbzgfBcD8QpAk11arUba9Wr9GrlCYDsOQb3bhYO
	vfqwhuQlBa3UXeEevB45zQbp6ijtXVVal8n+fxCGdLpWL1gt65XwqfZp/kUQGDMK384V16y2l+T
	zBxQXdtb7HHQcX3wQ512Vk7KjDaMLNjlz2bWgFAacqkb6EG+KI1RnnvA=
X-Google-Smtp-Source: AGHT+IGzVUaW1AjKFIt40ppJTsAPfO4bBCztCdNkytBdDeVBBBEV1kR0D5F0CXYcNEKCykb/1MbTlWj4+W2P1MGh8QohEL/NH8Tk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e08:b0:3a3:4122:b56e with SMTP id
 e9e14a558f8ab-3a365959bd9mr42770505ab.26.1727896809648; Wed, 02 Oct 2024
 12:20:09 -0700 (PDT)
Date: Wed, 02 Oct 2024 12:20:09 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fd9ce9.050a0220.9ec68.002a.GAE@google.com>
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

On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes use of disable_delayed_work_sync instead
> cancel_delayed_work_sync as it not only cancel the ongoing work but also
> disables new submit which is disarable since the object holding the work
> is about to be freed.
>
> In addition to it remove call to sco_sock_set_timer on __sco_sock_close
> since at that point it is useless to set a timer as the sk will be freed
> there is nothing to be done in sco_sock_timeout.
>
> Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d465
> Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work"=
)
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/sco.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index a5ac160c592e..2b1e66976068 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, int e=
rr)
>         }
>
>         /* Ensure no more work items will run before freeing conn. */
> -       cancel_delayed_work_sync(&conn->timeout_work);
> +       disable_delayed_work_sync(&conn->timeout_work);
>
>         hcon->sco_data =3D NULL;
>         kfree(conn);
> @@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk)
>
>         case BT_CONNECTED:
>         case BT_CONFIG:
> -               if (sco_pi(sk)->conn->hcon) {
> -                       sk->sk_state =3D BT_DISCONN;
> -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
> -                       sco_conn_lock(sco_pi(sk)->conn);
> -                       hci_conn_drop(sco_pi(sk)->conn->hcon);
> -                       sco_pi(sk)->conn->hcon =3D NULL;
> -                       sco_conn_unlock(sco_pi(sk)->conn);
> -               } else
> -                       sco_chan_del(sk, ECONNRESET);
> -               break;
> -
>         case BT_CONNECT2:
>         case BT_CONNECT:
>         case BT_DISCONN:
> --
> 2.46.1
>


--=20
Luiz Augusto von Dentz

