Return-Path: <linux-kernel+bounces-198625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2008D7B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0BB2814E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B395A23765;
	Mon,  3 Jun 2024 06:08:43 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D8B20DF7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717394923; cv=none; b=aB64t/aCy7QHLfzp/lMs6J3uyNvSmuggPJpP0wiyTZqwC3ys4kyB4BBfeRujtJrJClmKpgLqOjLHPrCIb6+2WKtlRsw3uIMxqQlp6p9iD6w+CgiVF+YjvGJ8loUKdd27diuR2V5XAgR2Qj9Nd1ghPb5rj7mKLN0gcY2Ggs9d2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717394923; c=relaxed/simple;
	bh=zHlh4bKRq2LBijEFUhBwYnGRQpZxs3DyZQZn9+zx2l4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=suBTC5qfkyTxa4+MKTjxKmj2qohqfOi9tOhJzlDdGXgCl2ZqYbIXqSR129kvSAq/2P2kN3sGNG+Wvxepcr6YRZT6M/Aodb4PPAH+rKVMZaC9b2koB3wCKskHzVnBqAVwHvThbu5wSxKX1/zXGALZiPPCK0ehKvlgAjLEqSAOr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e92491e750so372665839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 23:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717394921; x=1717999721;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLRG3RNn6axHhDL6EHJam2Pw75GmrrXwNjgsAijTp38=;
        b=R1rbgJhOAR2QNmujQm/jD/qSz4Vuy4+YnGdRVvBFiCHh1JxWwMTg75SnLq/fDjrR7G
         elqF7Vp6stBr+Z+dc8xA9jtSZXBQLtfForq2qCin8DuYAxcFj+3YCxYPgo+h7Jd4H4sJ
         sw8he68EVx9dhpQV17rqXDWaioDFbowhYyLLafXI8t/P5eUFMCt2naazMSnPdOlk1l0W
         B+/y2ozd90xfG0+QClP8VqUPawsXJ4G/XF/zQ0E11Na72hWSk0rxMw6XiwxdftUr2XBP
         Pw8d1yNZC0X1lACCyJfAKgj1vLfcBSWWKqnKcW9LNYcVK8HpskauvH5Kks9pI2JlgkTl
         upsw==
X-Forwarded-Encrypted: i=1; AJvYcCXXrrKq4MoMewyNRiEJA8QmOh9T88/UTAoF5FsRHUlRHubOYnhGKGQyjZOALI0XFvLlA/JdvhgRdxUuZcG6iPVW7rHh7W0XcZjAK6E7
X-Gm-Message-State: AOJu0Yxy9WQVB4BN5A5awixX9+//vaodTEeKRLIMMLUGbdcAPaAgRufi
	lM0Ao4/QuLVmtyxXgs42Infe0yb5FanEAQ9l8hQ0B5StD30ySeiMyCOZQuCL9UTPwnz84ea1z+u
	/YlS40v8FdCb60qLeAkG+p7JHg7O921/Bv1TOS9LRYczc0suahAf9OKU=
X-Google-Smtp-Source: AGHT+IFHALo8Me+kTCpckziJS/W5vC6AoxIejC5IrkjypEFFDIk2HP7+HJ42iYb6CaviwUost2XQPS2KqBlHtbXtHlqBdbFfs20B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9804:b0:4b5:a983:16bc with SMTP id
 8926c6da1cb9f-4b5a983182cmr327938173.1.1717394921145; Sun, 02 Jun 2024
 23:08:41 -0700 (PDT)
Date: Sun, 02 Jun 2024 23:08:41 -0700
In-Reply-To: <CAN-2BNQVPdaPb-LryqBLti2EEEm5Svgi559wGeuHN0MO6rr3fg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036d5100619f62aba@google.com>
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
>
>
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

