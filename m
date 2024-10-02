Return-Path: <linux-kernel+bounces-348091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2A198E26A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163BC1F23FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0685212F11;
	Wed,  2 Oct 2024 18:27:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57E212F0C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893628; cv=none; b=FM5q7bzfqusDPJiAR+v6rdIi2gC0lOuWKRIehnCpmR2XUfcYQWPvy3hfaBY0ghjMpXwRCGSWE994tBD+Mhy/Pxc9mEFeNEUhFeYPgi5Bw6WDkdGyrsnTZF24j7N3B/1tmgj4bY/4uhsnE1awPdX/sa240kqrj0k03BnroN22LvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893628; c=relaxed/simple;
	bh=mHesJVt4/V5EDyyYmds7jaBclbFAXszl0Bbv/UwXtAg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VeQgY0sh7EF+png3uwTg2DaTofNZcXpwOkhBt5JqNt934JxtltpNKBFfDHN/8KkvUpx+l/gZPyAcasckcptNoEmyDk75mWZIdhTRi7GbUhOGbPCEI1mtCHnsgKzoWo8Y0b1UbIiHmtuSBf6indiCGXG5G+dDb2TccZyp01fKClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a364ab1eedso994665ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727893626; x=1728498426;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW74V9YPDlEbmdeczWN93FQnOFiXlRfvTMWQhSUdCcA=;
        b=FfieDQ/f4lpraZVcACA85S/QHkXJIY42Xpvp9aTUZVQ7qh0B1CEikVvP8RhF8S7cVV
         YPPH6FFUyAuP+Jf+cM0B2dGfLyig3mrvNmXRnzDWhvmDUS4nHfhCkisZpRs6EhoZ49XH
         6sd8wcUgp+9fup60GszCJndIfl3HXqElsXeywqhFRsyOHi9KvnML+N4RtmOOqnHXddFg
         diOfxfYWmAd1yZjRZkujAaImGzDj30b+S02jfhnGvrA6nHyeOqzCQNkF98TI03wWqTMc
         VgZhGVij/D81TUdoWxIhRkwzbvYptmMW8/PtPcdC8JIsHpzZw47LC4Qdn43xV7rykuYe
         fWDw==
X-Gm-Message-State: AOJu0YzeRWSpQXGpnaokhM+XTo+yZ+meXLFksbhF801lKdnvh9AV0Qwb
	PXN6g8ko49SauF2+l4Ucqk0DFe3KK0b4YylGdpQcCxTjn02P5tMPrEP3IxwyGNdhLBRQezMB4jL
	0XVdW5eqMLD0GAloMVLAZ4RiSw7S4P/BaGVaoiU1TJcLXwdYi7kUhx5o=
X-Google-Smtp-Source: AGHT+IE7xP06nVjlgwzvR8kt84TIBSo7Ct5h76if/4GGcmhS6VPbX2LxSZYxumku8SWjl1XQpvB409D6q7TmJiMRZfvdQ2fNYXKC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2a:b0:3a1:a69f:939a with SMTP id
 e9e14a558f8ab-3a36594249bmr40781055ab.13.1727893625931; Wed, 02 Oct 2024
 11:27:05 -0700 (PDT)
Date: Wed, 02 Oct 2024 11:27:05 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fd9079.050a0220.40bef.0021.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH v2] Bluetooth: SCO: Use disable_delayed_work_sync
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH v2] Bluetooth: SCO: Use disable_delayed_work_sync
Author: luiz.dentz@gmail.com

#syz test

On Wed, Oct 2, 2024 at 11:40=E2=80=AFAM Luiz Augusto von Dentz
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
>  net/bluetooth/sco.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index a5ac160c592e..8dfb53dabbd7 100644
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
> @@ -444,7 +444,6 @@ static void __sco_sock_close(struct sock *sk)
>         case BT_CONFIG:
>                 if (sco_pi(sk)->conn->hcon) {
>                         sk->sk_state =3D BT_DISCONN;
> -                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
>                         sco_conn_lock(sco_pi(sk)->conn);
>                         hci_conn_drop(sco_pi(sk)->conn->hcon);
>                         sco_pi(sk)->conn->hcon =3D NULL;
> --
> 2.46.1
>


--=20
Luiz Augusto von Dentz

