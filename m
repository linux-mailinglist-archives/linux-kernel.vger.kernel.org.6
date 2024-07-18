Return-Path: <linux-kernel+bounces-256645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCC9935174
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3291C22622
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100D3145A08;
	Thu, 18 Jul 2024 18:03:03 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25311145356
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721325782; cv=none; b=aDklZQI5dn0pT56znJ0FVauuWCUzPICbyAF1nY5u7FO4RgIok+9ZiGBHFkTwXQPugDcctB4JbNvxiuArbpXcmogVMQqDkoGwVqfdKETPwr/tLdAEyoKjV8trTbQPL1o65DP6F/DRrIOBPHH69bLhNYtnxoFEbMKY50VnzqbcPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721325782; c=relaxed/simple;
	bh=FHxbrmTw0dVAEXbFDVKzZm8aVaVDeImqbXiH++lXSSQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WNRQRaE6u/fVxztsJGN6a2oPHGzXdEab15ClzZ3prWmdctdYR3XWTsORPFTn4uqLmoSas78Alypx42mZ6Ern3VRxe94+xjLP4G/MS62DCj5lnOdqQ0aFwhi+ZZe952ugzsnWR9+tVMV0qPgJbLho/BIoyWDER1lWoJ+W3rkg/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3835c6e5763so14131195ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721325780; x=1721930580;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+aHBRBgAFqp3cCvMwZ5U6Apip/zL0Qr94huepps+kHc=;
        b=jDOKvSWhL5Y1/eXmiDGQZ9M0QLu5dzAmvmY8hxV/sztOjZAL1Dx3Ph5A3Wzb6853MH
         JJU7S07iLQuhxinf0qt25ygJpci/qaWi8fo7MsQGXwDVaH5drDrktq7oN7d/AoRwTvGb
         z9XNM2hGMdAusjDiHe023G+e0N7WnDlkfazRCnAyNAQg2o+yit4JMChf+yMZLYejLQMM
         x7/bDfTdDKaU+8EJWLLdgsuZrsGITAzGswLgC8zlVfsT+S6RhYvW+VzIag8KsH+rfqSi
         VrMdcjm8f1/j+64FnzraidxT5BssptP+qJDU1u9MUAHktDhEDz5hllk1uG3t2kXBe/FA
         +oEA==
X-Forwarded-Encrypted: i=1; AJvYcCWcoYs7Q3S8T/OhcJDDFboI9EcaqUD0oWZ4rs6JTGRoMr+WJSOaQokWD8jwgDepq1e4tu3SEnLFGOpwDMnEn0xphOZzeBqzTVgC0e7q
X-Gm-Message-State: AOJu0Yx3DheHb3MZsETTPZL8LlEc+aYCdq0YlZKgutXlohVsqvGEcQ9m
	odCk+PhevQ4wgZ4P0Bhi6aHa7OXMzgEQ2cQqf/ZBhpYjdtOCfH63hNxRO2pkIWERe55tdOr9zpJ
	YfHU+wNsXbvcVPztd27L65UuTfhp911ST7K9m65t4hXJjJA0vOTKfatA=
X-Google-Smtp-Source: AGHT+IExARHtw36AbOYPYSIsGgc5K0wOTD02RYbjVVAoQu8sLTtcwoYcCjxmXZrNkOohFZJqGBunDLc9teTF8O5IYgUpF3+yHLro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b24:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-3955523dd99mr5129945ab.1.1721325780368; Thu, 18 Jul 2024
 11:03:00 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:03:00 -0700
In-Reply-To: <d848129a-ed5e-46f5-ac17-add37d7799fd@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae9198061d896312@google.com>
Subject: Re: [syzbot] [io-uring?] general protection fault in __io_remove_buffers
From: syzbot <syzbot+2074b1a3d447915c6f1c@syzkaller.appspotmail.com>
To: asml.silence@gmail.com
Cc: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On 7/18/24 02:20, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    d67978318827 Merge tag 'x86_cpu_for_v6.11_rc1' of git://gi..
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1178e9e9980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e206d588252bd3ff
>> dashboard link: https://syzkaller.appspot.com/bug?extid=2074b1a3d447915c6f1c
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e07d9e980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16adf045980000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/f34b31760156/disk-d6797831.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/a92e51d8d32e/vmlinux-d6797831.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/000a6a162550/bzImage-d6797831.xz
>> 
>> The issue was bisected to:
>> 
>> commit 87585b05757dc70545efb434669708d276125559
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Wed Mar 13 02:24:21 2024 +0000
>> 
>>      io_uring/kbuf: use vm_insert_pages() for mmap'ed pbuf ring
> Easily reproducible, the diff helps
>
> #syz test:

want either no args or 2 args (repo, branch), got 4

>
>
> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> index d2945c9c812b..c95dc1736dd9 100644
> --- a/io_uring/kbuf.c
> +++ b/io_uring/kbuf.c
> @@ -657,8 +657,10 @@ static int io_alloc_pbuf_ring(struct io_ring_ctx *ctx,
>   	ring_size = reg->ring_entries * sizeof(struct io_uring_buf_ring);
>   
>   	bl->buf_ring = io_pages_map(&bl->buf_pages, &bl->buf_nr_pages, ring_size);
> -	if (!bl->buf_ring)
> +	if (IS_ERR(bl->buf_ring)) {
> +		bl->buf_ring = NULL;
>   		return -ENOMEM;
> +	}
>   
>   	bl->is_buf_ring = 1;
>   	bl->is_mmap = 1;
>

