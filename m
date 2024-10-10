Return-Path: <linux-kernel+bounces-359250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7560899895A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B15A1F26EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECC71CF280;
	Thu, 10 Oct 2024 14:16:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3131CDFBD
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569766; cv=none; b=IXvfJxm44EjWPjEijSGtk+pmJmSqRvE2sa5nMtBDcfNj6ILM7wzPM3SaxaE/C7x0NE7xoDklaK24PfZ4VJRaxX1UIEFt3uEYdMdWi52gaPIUyPolrVgsDS4n9yc+8z1XeZcjTbthCz4mRgRR4uzhbt2x+Mm0WcvuXd3JN9RugLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569766; c=relaxed/simple;
	bh=wo1aqpD0fJx2ciqxxDy8ZSZ5yYdeEAeEXEqccPnZFUk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NIFZ0S7J54bJf0Bw/WKBN+9LbF803pybjI1ePIOHzLuFYmJJCjpVhGjE9KsfKrTmpMeTygA6an3jYv+rJll7w+dHuANrjna2PTXk6/f0uLf535mGof6emh6sHhT4AJ6SRLtYjmBKYU8PpArPYwwP8EQHh6jfrPj0ihS/2AGi/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ae3c2cacso8605725ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728569764; x=1729174564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgq60H82SiwsEEYyfETa4MwhBeXGmeG/1/Rkqw+PB7Y=;
        b=w1hyIVdxTqYBNfxSIh4qjjzol3txWo07zJpQGKBZ3MBtgiYVuWZHEkVgLgVLE4exf4
         H80o8qFL9cVCnw579RVT3m1FYocHLPQ9W+ds8+l9wGHN0yi8554cz+slkRgRW894S60J
         ejs0CpuruXWk87m02v6UdeW3kOyZFGkVk8dMPwNJb+dHecegfKcciJRqdUEx2XjjPc3V
         CEaab5UIOPDWzoXeBDuM9KnShogGSbXdU6iDDvhhKz/841UNIH/7UYURiDvqnS/lrSYX
         d/5orBpVyG8r2sukf5ZsyudxYBpAGer0u6Byso4ov+g1RLE9urfcIGKzvRbE5Aih6Aj7
         l4sw==
X-Forwarded-Encrypted: i=1; AJvYcCUeX8jOVhX82V1uxbYbe6nFDDQ/JmeWQA133+ppmVcZpzuG9GzJTHjW85j9R8VxJKZTfcKPkU5u+Owzmbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypgzcUWaK2mOuZbxt9xBzqOizGGmnjLMgrqnWRhKK6Lr1qGAYf
	FovA2iLZnOesbStrONAn6f4ksHDgUBBSERUopjPMmXsWxHXIb6M1EUNI6YTMsy2KZr5wP2kRjIX
	AQe3XUZLGWv79pFCNd6mQGWCF4RxB3WIs1DERCZ89nyGNehdEmPY41Vg=
X-Google-Smtp-Source: AGHT+IGyR/sLbWQK4QmtOec/SQH+sZL6vZpBJgNUN4MWA4vVduu4+9Z9or8U54sP7rLb2td24R/a8Yihjkcp40W99jiCXYw1Zaiy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0a:0:b0:3a1:a163:ba58 with SMTP id
 e9e14a558f8ab-3a397d1d064mr70988585ab.26.1728569764030; Thu, 10 Oct 2024
 07:16:04 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:16:03 -0700
In-Reply-To: <ZwfZkr_27ycafr7F@iZbp1asjb3cy8ks0srf007Z>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707e1a3.050a0220.8109b.0010.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __hfs_ext_cache_extent

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:163 [inline]
BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x779/0x7e0 fs/hfs/extent.c:179
 __hfs_ext_read_extent fs/hfs/extent.c:163 [inline]
 __hfs_ext_cache_extent+0x779/0x7e0 fs/hfs/extent.c:179
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_get_block+0x733/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
 notify_change+0x1a8e/0x1b80 fs/attr.c:503
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
 x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:77
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable fd.i created at:
 hfs_ext_read_extent fs/hfs/extent.c:193 [inline]
 hfs_get_block+0x295/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121

CPU: 1 UID: 0 PID: 5954 Comm: syz.0.15 Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         d3d15566 Merge tag 'mm-hotfixes-stable-2024-10-09-15-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17aecb27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1777005f980000


