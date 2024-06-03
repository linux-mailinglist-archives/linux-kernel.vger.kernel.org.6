Return-Path: <linux-kernel+bounces-198619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15128D7B17
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A4A1C20CED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45710225D0;
	Mon,  3 Jun 2024 05:51:46 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5732D052
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 05:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717393905; cv=none; b=BU5NiFKSeSGtkA34K4vV/i8wE3Joe3L+8lXCb9nZuuHnin+p1ZYIBtYapB+o6jXEa9osoN4/wwo92im9KKtEYhXFpSu8s3f2084jGjsM5RiTlsw5/Ym9kgxsVH0lXdUvN+WLX82WsTA/5Gka28L+ZKDrWDfyWQNToSwZ/g/6HqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717393905; c=relaxed/simple;
	bh=ifa1sLf78sp50s1wC8ALXmCfuz1KXsibA0ZhprnTcxU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fmdhkuOGr9HDTP8HbxY0rzK4Trf8kQGlzfqS+xDFDnm88zvZjiphE3jClzLN9Y+x5NjKCaKiAenk+leVk4djs2roqSWlhGuSc9uGIDWmCwx250j9RCetLeT65cgA2w+3R0Tp1TXFf9zJj0pbmFvA/8K1D/m3z8AgENv4g8CMqSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37485947af7so35771095ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 22:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717393903; x=1717998703;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RehqrRcK6JX+jWybc9MqURkOSQysKFfU2/HSdU6dPCA=;
        b=SgKJKriE+beyzY77lPRJHraH01icCndSgm1o/x43rqBvpQDJgPHUFhahebFglagPfc
         imGfQxivMOrjiOI1gAeuDniGTESAvJKMlAi0fo9Hdtzby8yKf4VbH1cFQY3f0PcFPXx2
         8UvonVOplIWI4oZf3BFz5w6lMBjyg8JO5RG43Wr3IJZEai7XK4eRvQuW0Zt+b6geiqsz
         v6XQ7FjjWopRJQewxniLOmO8BC6xlQFpoInb54cBCvEcJfsaKRpcFsg2DLkHVxAq5ReE
         v1VZO5DuNb2NCy2gOC8jt3PCS2eD07T9iZSJfUCvNX0GyNXgQyEH81vhUw8SdBD1HNMg
         FP4w==
X-Gm-Message-State: AOJu0YzkoF+/KaeS6XQfUgHfJruYg0HyPpIMsNVRg5dDoqP6HTzA2wSO
	h+QduVx9qGOl92Sv1L69PCFZCUs6pmrrMBZI+/ZUSupCOXNkSmSdekGvfYQcygfB5e1JVnpRejT
	oVr4aqKQWvTRm3PTDVVofB0SFnN5oc3UKcMv36pE63PFmJ6c2kW4Bbq0=
X-Google-Smtp-Source: AGHT+IE8nqnqXqNnabt8fIEDUBBUZc8Ew25nZ+EUy/AyBysLc1hSxuA6HCxxk/a6rcd1YQCHqct3AJngX+hzxIumujrG7aXRvJHH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:374:9c67:1dea with SMTP id
 e9e14a558f8ab-3749c6721a2mr2527375ab.5.1717393903728; Sun, 02 Jun 2024
 22:51:43 -0700 (PDT)
Date: Sun, 02 Jun 2024 22:51:43 -0700
In-Reply-To: <000000000000a82e6e0619e9c192@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009246500619f5ed49@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] VFS: Close: file count is zero (use-after-free)
From: syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [squashfs?] VFS: Close: file count is zero (use-after=
-free)
Author: nightu.pwn@gmail.com

please test file uaf in udmabuf_create

#syz test
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
 0e1980c40b6e

---
 drivers/dma-buf/udmabuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index afa8bfd2a2a9..53035c601e92 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -382,6 +382,7 @@ static long udmabuf_create(struct miscdevice *device,

                kfree(folios);
                fput(memfd);
+               memfd =3D NULL;
        }

        flags =3D head->flags & UDMABUF_FLAGS_CLOEXEC ? O_CLOEXEC : 0;
--


syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com> =E4=BA=8E202=
4=E5=B9=B46=E6=9C=883=E6=97=A5=E5=91=A8=E4=B8=80
13:49=E5=86=99=E9=81=93=EF=BC=9A

> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file drivers/dma-buf/udmabuf.c
> patch: **** unexpected end of file in patch
>
>
>
> Tested on:
>
> commit:         861a3cb5 Add linux-next specific files for 20240603
> git tree:       linux-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd9c3ca4e54577=
b88
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Db2cfdac9ae5278d4b621
> compiler:
> patch:
> https://syzkaller.appspot.com/x/patch.diff?x=3D10a6e206980000
>
>

