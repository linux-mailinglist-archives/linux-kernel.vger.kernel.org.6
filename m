Return-Path: <linux-kernel+bounces-198633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A446C8D7B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47757281BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB923748;
	Mon,  3 Jun 2024 06:19:49 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7581862
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395588; cv=none; b=mHn4m0LtOsFI1jntKgnw7zija+11GbOB+6s3Zcw3QqWrs1ob/OvBjoLk333WeGA+8IAULA9doSRuzmY16UBfuqpqIG0/TlYDT0xpOK3DvLLfbV5CDkAqNJa6zGxZEDTk0CScu/quNvNZvM5NCCPtEIZm2l0eRiwiSuujHuyhVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395588; c=relaxed/simple;
	bh=ERpoqRuEgORZysCLk8j55EXajPRul8XJuKC6ZTZrYB4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YSo3tJqLnrEpyF4mLwc6hZxSmYsVDyE/kaSk1G/atD9g5Ug0w/agv4MJtZtPcGfyO/85RG/SzgNGn2dca8DibueGW0fKyz4d2k0irphJLFjFy7q4c5Bvc7BlyUPAsO+pyk8lxu6jhOHIV5tJ9Q9ztkNofaFhGwFf0YtdzJlhnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37497a1aff0so12004465ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 23:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717395586; x=1718000386;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S60wj1E9PIFQ4v7IFpqz93cVCy0cxZgNjz23WFAjpzE=;
        b=njmPu2lh9VsdI5ypZtnFBdVnhyzXmcGlj0hD45q7wN4x6B8Qj8oK+Z7OwjXBYaBkf/
         WeEmU/qJaO1DL8QzEshvmlUfXmDbv7eZxhEb36F0ULW5R2v2GYiH65tk7BI/TeXuvFqv
         LVfIcFviSzOgy+S5mJRwHOMWCynkJO/jpkXia+1kkMMV3GK4Hhr/Hp+4BOIPaZiRSb2+
         zDt3IB+D/Vfs8/znztjbU3ziAmvRr+sPvJnaW0fMZf3JRTIFEDAOJQtzXT3SyP9Dm9NT
         zIuJLlumhZ/NNFzrskmazXJgA6IHp8drqQqP0MMqVyX9Yb7Vr32t9CatYWT/2atgBnSH
         xJNA==
X-Gm-Message-State: AOJu0YxDdC99+amWIZM+JrcNgyeIJbotJOjRbw+rFo1zSrFxvLw5Tveu
	zJWdjxX4/8rHUOx831c/1d04ykgiGrzlErFlkaCzO84X1FcVksOSjc2nx1DQI1IwOVGIS3TQ4RB
	xZ2aArR2an00079wssesOEur+1OVXQ2A8br01/bWLwr4JJRmJlNaM7DA=
X-Google-Smtp-Source: AGHT+IGmWTxSBFCulhzNPbvFleywuj967c1HWLXTIbtvk1F8z93ITsxy68rITkORqpkugtgyvdhDVNEfZYbIx1NeBHfxmQ69a/vC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1887:b0:374:9aa2:9155 with SMTP id
 e9e14a558f8ab-3749aa2952bmr3312215ab.2.1717395586780; Sun, 02 Jun 2024
 23:19:46 -0700 (PDT)
Date: Sun, 02 Jun 2024 23:19:46 -0700
In-Reply-To: <000000000000a82e6e0619e9c192@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e39ee90619f65123@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] VFS: Close: file count is zero (use-after-free)
From: syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [squashfs?] VFS: Close: file count is zero (use-after-free)
Author: nightu.pwn@gmail.com

please test file uaf in udmabuf_create

#syz test

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
+               memfd = NULL;
        }

        flags = head->flags & UDMABUF_FLAGS_CLOEXEC ? O_CLOEXEC : 0;
--

