Return-Path: <linux-kernel+bounces-198627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53518D7B5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B217281574
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545932C6BB;
	Mon,  3 Jun 2024 06:10:13 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090B225D0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395012; cv=none; b=I8ioBCKXSKSUxZkdC8i+UfLmWbC57RBokLXEWua3PmM1Dm99dlo6evIIv9qnG0tF9AEZ46sz6DQRHMPqn8rF4q+bxce7loPXPXwXKhBLjXoKOgDWl6mXYdVGlBInph+UB4nE7ATH+JCTC3h1an33wLc9YArcgzrtzuN+FalPQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395012; c=relaxed/simple;
	bh=8WOPf9qIsxW5og6IlljYCj9Fs7TTg2dwUY7dqAx2E74=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=qAqS1+Y/SygIJywvnoGFAofrTWyzEy/wXhjl8qdUrYRBejJdU0XiV7mlbJjhHcYrjJXUakChissj4UtQeMDmjXBLQLyKRzDUgkH1YnXxVYIi5VOsWVIN4sAiePANpSp8uJK2wIjoFnZzdYt/ujhkBXbW5ZAvQQ9xvwMLiQExi1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e212ee8008so519652839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 23:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717395011; x=1717999811;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cz7X8uNk+8jyAa6VNM49BWlTMNepaFxmAju8d8ai4Jc=;
        b=A3Xp5h4fbTtlbXqebbcced9gZEgyC3qVjrkJD53k3Xf43SzzDg0cToMJSKhqvuVN3K
         x+wmdS+n42O0phpuRS8fNsA5j41C2R5xspb0Lsi1ujc2RR3i5U2fD3RdWtQW2ibFivdV
         Hx1saZ1qIgbPz0RWrQTdEkFxtLBh1abby0PDOYezoJE1MsLjUSj3rL3hQwozAifjEabH
         amPJTYj4YMyYFDu+z3zTgKLefKPGiG3hQil/WipWCm+vsdASbUB1sZLkf8bYO8TOVJC3
         c1b5lzmx0omY+dfTWFLAbLDH+9Kv8taoVkRlQiMhaTxutBDL1LaxC33JASf0XSDH5M6Z
         eoSA==
X-Forwarded-Encrypted: i=1; AJvYcCUF9rwowtxhBKCg7MkmCMOrKvVaordQgOB72QdUHflMMerfe9V1VqtcAQtAP40IJ15l8HFXKOgTesuBxF/LUNb+SKP+qIPlTh9ymsjk
X-Gm-Message-State: AOJu0YwETQSM8UGZbfHNUpaEuR5J26Da8DqMVJIeIBK5yqrkS1tmPYpv
	FB6oLS/e6EymykYuNppjmp8+KE9fa8ZvRg3KH11o60cSKbwFudJhO6Uu5kjO4K1md91F8ZpklF+
	X1QaNg1JN4iyC+cjjwNUbaX1WIgF+8kpiNWy6IM3wMcCc4hM02NM2iHs=
X-Google-Smtp-Source: AGHT+IHWa0E9forE5Lkei0xrBFlXrqXeGE2569rDRDyR4o8KYwkxPK7A+0tlTg8bZ6PavG93HpC48owsYRsKtffjy5NV7GGBHZwz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c1b:b0:7cc:cc9:4332 with SMTP id
 ca18e2360f4ac-7eafff60694mr49900039f.4.1717395010831; Sun, 02 Jun 2024
 23:10:10 -0700 (PDT)
Date: Sun, 02 Jun 2024 23:10:10 -0700
In-Reply-To: <CAN-2BNQfJF3b-Li56Nu13JxHKu3oMSetiPiEWzYa=HzSAAdkHQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f57d70619f62fe8@google.com>
Subject: Re: [syzbot] [squashfs?] VFS: Close: file count is zero (use-after-free)
From: syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com>
To: nightu.pwn@gmail.com
Cc: nightu.pwn@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> please test file uaf in udmabuf_create
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

want either no args or 2 args (repo, branch), got 1

> 0e1980c40b6e
> ---
>  drivers/dma-buf/udmabuf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index afa8bfd2a2a9..53035c601e92 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -382,6 +382,7 @@ static long udmabuf_create(struct miscdevice *device,
>
>                 kfree(folios);
>                 fput(memfd);
> +               memfd = NULL;
>         }
>
>         flags = head->flags & UDMABUF_FLAGS_CLOEXEC ? O_CLOEXEC : 0;
> --

