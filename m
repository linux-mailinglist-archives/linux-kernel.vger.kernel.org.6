Return-Path: <linux-kernel+bounces-182307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0D8C8979
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B751286DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D4512F597;
	Fri, 17 May 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oCzD0Rda"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8943E12F58E
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960463; cv=none; b=DnWuaJ+PnL4+O18CChslD8konsuLMVkybEAPuVaaef+d134qPPbCqeqcwl0Qr1xoibJV/k9nx0mV38iOMg/zmjN50ZP8K0Otv1xOgRIcjTsWQKc9aOYcmHmzhfl0RkIJuR70ijnusvaJH/o2n18BWo24H/N0VJBuDwgivw3paZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960463; c=relaxed/simple;
	bh=kbohzPnLDgM7IQeXd/1NEXoC927SZZmUiT2bGewMcxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qI6fv8pKqYmgLcAy/ToUKiX+spRp/UXxdIGP7x7G4QEsnwA5VV6lNeA6faNwCLSJ1Y81Wnhq3k6ALD9ibMNDBJWmYQ/f1NoCN70mHFLyuG1RWTPDNXbXqHVVkCC7gYicQ8mKFmNfJ2wIkh/z53/GvZecKqGuMyiw5z+594JNkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oCzD0Rda; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e576057c2bso31818971fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715960458; x=1716565258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g3uvQyOXC6DzeBtn7J3OOKoxKJZ1WzPonWgDGOVCz4o=;
        b=oCzD0Rda1SfrLYY31uuo5837EUhU6svEFFk/AHonTFSyLOHE/AmTA2L3S6Eu7V6Lxy
         bNBd/Hf21+V+sx7LMrpwnyeM8bPy4aTQWvQsRg3ZNhmJbFBOwdi0f3y8HLrxafGcDRb9
         q7JGTolMM9Iow49uIoXknaQhSesfe8+vagEes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715960458; x=1716565258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3uvQyOXC6DzeBtn7J3OOKoxKJZ1WzPonWgDGOVCz4o=;
        b=xLOzYtRVHwDOUsPQ73edvsUrWukYAAL3Tm04fktv3f/7hMA8bw4YJkX+tZp2rZuJ9T
         lBGzyJG4IFECf7wSHjBmqtzLuE7Wuu/phM4TrdvVus1DhqFY1+ZF6hrpEnmbaVfWazSz
         89UZrN7Hw6pJYkRqviiLaWf/cCbP9NHOR7mpugj8Wc/118W1J1d5M9BSr50/lBL0tghA
         5t4ge4v7nP2YqCpzLabeUcUwtYNJ0W77ea01fGMRT6EB7XZU40jiNrnvTmD+j1UaLcPl
         lyulGUxghOBeoFZEj1F9ANzK1yQaoTNQlPicb90ZeutUQsWDX6aAO/SDHtTxmIRsRhHM
         D/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSgs2lnhiR1gKJXkAR2ts9hngUpM6KwbYYVOOvqvFiYmpUgVp+KJ5W/URb4aDrqAWB6frWHbPBX7vqlwBy1qSWrbLgCq+iyRFh7qwI
X-Gm-Message-State: AOJu0YzR0oxLb72b1tEB3ENeMmO/NBkIOMkZNzKh2Ul83wGkU+vyZVhO
	kiyniLek/aY0SuWBZRvI6I+YBIMESOpbWrYgrp967/PljnQ5mmwZVdom+Xfyl7F1vTOXO7xmTee
	bifT8LxmfT/fi81NG38j3xo+63G961Ztjk9POcQ==
X-Google-Smtp-Source: AGHT+IHIxRZ5GfZcmKjumiPucJds6t+FhJ8wB4Mamt8S570wQWI0fT8nNgPZioDyP96HF/02QrdoeGI3bfESt/M+OG0=
X-Received: by 2002:a2e:d09:0:b0:2e5:2eaf:b09c with SMTP id
 38308e7fff4ca-2e52eafb202mr168442591fa.37.1715960458664; Fri, 17 May 2024
 08:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000141e8306185a0daa@google.com>
In-Reply-To: <000000000000141e8306185a0daa@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 17 May 2024 17:40:47 +0200
Message-ID: <CAJfpegtwuOgundfkCdh4c4-scJjBEgHjNzJ8Vq2VUxjxWWQPHQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_workdir_create (3)
To: syzbot <syzbot+8aa3f99a6acb9f8fd429@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 20:28, syzbot
<syzbot+8aa3f99a6acb9f8fd429@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    45db3ab70092 Merge tag '6.9-rc7-ksmbd-fixes' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=169b934c980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2f7a2b43b9e58995
> dashboard link: https://syzkaller.appspot.com/bug?extid=8aa3f99a6acb9f8fd429
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0c2a8034002c/disk-45db3ab7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/807e35e2b3a9/vmlinux-45db3ab7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4868b2eab91a/bzImage-45db3ab7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8aa3f99a6acb9f8fd429@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888077f311f0, owner = 0x0, curr 0xffff8880787ebc00, list empty

This is lock corruption on the upper filesystem, definitely not an
overlayfs issue.

#syz unset subsystems

Thanks,
Miklos

