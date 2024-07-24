Return-Path: <linux-kernel+bounces-261228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD69B93B465
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A63C1C23908
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E97315E5CA;
	Wed, 24 Jul 2024 15:57:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442615CD60
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836624; cv=none; b=vFd5sNrxB1IXK4R3JqgOa/ZPDGz1kWEgbpJUqtry39wHhOlM1WjJgdTlFIavWo6IWjACVVIVm7aZvGSHxVpSdblpjV+mgMN4oSoZfVcQO4GgvJJcqDQNxwjH6r0/X37bu6x4RuTATcBT2+NNQk1DWlcW+jLrdQNvITHHTl+0PPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836624; c=relaxed/simple;
	bh=huFWRRP15akjkvn1gjHj80C2M7BSCzmCgfhqjRJDjso=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XWMLxMMmP+xsmf8D80nn6LiMpkYE7yFP2q8IiVTN6cL0UVBoVtjGNSYTF+fVrGY5UXDfcBUgidgRDr9F1EGEkcb/5NeuV1rGZ/RRRDg1VuZBmt8N43RmEXcVu9ovbn1mcIXnlyOW2Su5fdtw7ppGSYsWR80UH50VZaebTlbY+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f9a5529d33so1058646739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721836622; x=1722441422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHvWKFgSlIsjuAyfOIP7JYTHzAEthbwgA7GPCtkTGPM=;
        b=t668q57nERXaiPMYf8YpNAujmyDpDBKeK6QI3jiUCdtH7/NYHpmcKjtSit1IxJvzqy
         zxLdN4urxP9rC+DvLC929DgsHEZp9iC3HJ8vdh0P5aTl009hRT8boujRGsLOD+Z/6o2M
         UYbQyefDphpMRDd63WymtYyBbhT3sGV5iKbTm85+Lmk+WtuKPbZThYe1rY7bYz1w/5MH
         w9ptMC6JHyfrwIy9RTB0oixcLv9KGB40/CruBncsBJfo4cm9sHy0bTTAEwAWxDDgUw1U
         /3BTILA5ciq545OmHsGynrZJphK8ICl1uVQcipleaKD9r+J5N66g5ARolHRZRnh4W0UN
         lR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFScfDV5RUsGOHjMr9PRjZad7J6UTKI/hq72BmXJVhuJYQDLE0pjZxO4MBRnsZRgYxf0dQppTm+bDW7ZtE88ETX1x3K0uNtHkdPXY3
X-Gm-Message-State: AOJu0YxUqPR1A4ypUq9CZENRwHXRTXaRIdSfeJNkJt0fAfmQaihHGy9k
	FZw59wFRaWhgbvyPCXdPyqY25Ct5TIBX+Wp/tGJHfbYtTcGl6bqOPUJwONP+3L+JrpCZN/rvG1P
	7l4lIt8jZV428leeYve5TkrPDyuMQGnmMyPdc+xInpjk+Q85NnVmjGtM=
X-Google-Smtp-Source: AGHT+IH5wSi8nXp4+9dm5WZ//Vg2iOsnkEvj6KcvyNL/2Cssov8w1WGvqLSdHsJhfE2pLYhIrC1aMyQhRjJDYK9YZYmc4AyoE2M4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8403:b0:4c0:a90d:4a7c with SMTP id
 8926c6da1cb9f-4c23ffc473fmr930317173.6.1721836622306; Wed, 24 Jul 2024
 08:57:02 -0700 (PDT)
Date: Wed, 24 Jul 2024 08:57:02 -0700
In-Reply-To: <tencent_BDF63D63379896FC36DA4B94758377296609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bed92061e005442@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_task_work_add_remote
From: syzbot <syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in io_req_task_work_add_remote

=====================================================
BUG: KMSAN: uninit-value in io_req_local_work_add io_uring/io_uring.c:1192 [inline]
BUG: KMSAN: uninit-value in io_req_task_work_add_remote+0x588/0x5d0 io_uring/io_uring.c:1240
 io_req_local_work_add io_uring/io_uring.c:1192 [inline]
 io_req_task_work_add_remote+0x588/0x5d0 io_uring/io_uring.c:1240
 io_msg_remote_post io_uring/msg_ring.c:102 [inline]
 io_msg_data_remote io_uring/msg_ring.c:133 [inline]
 io_msg_ring_data io_uring/msg_ring.c:152 [inline]
 io_msg_ring+0x1c38/0x1ef0 io_uring/msg_ring.c:305
 io_issue_sqe+0x383/0x22c0 io_uring/io_uring.c:1710
 io_queue_sqe io_uring/io_uring.c:1924 [inline]
 io_submit_sqe io_uring/io_uring.c:2181 [inline]
 io_submit_sqes+0x1282/0x2f40 io_uring/io_uring.c:2296
 __do_sys_io_uring_enter io_uring/io_uring.c:3206 [inline]
 __se_sys_io_uring_enter+0x40c/0x3ca0 io_uring/io_uring.c:3143
 __x64_sys_io_uring_enter+0x11f/0x1a0 io_uring/io_uring.c:3143
 x64_sys_call+0x2d82/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4706
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page mm/slub.c:2304 [inline]
 allocate_slab+0x20a/0x1550 mm/slub.c:2467
 new_slab mm/slub.c:2520 [inline]
 ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3706
 __kmem_cache_alloc_bulk mm/slub.c:4750 [inline]
 kmem_cache_alloc_bulk_noprof+0x486/0x1330 mm/slub.c:4822
 __io_alloc_req_refill+0x84/0x560 io_uring/io_uring.c:940
 io_alloc_req io_uring/io_uring.h:393 [inline]
 io_submit_sqes+0x1744/0x2f40 io_uring/io_uring.c:2285
 __do_sys_io_uring_enter io_uring/io_uring.c:3206 [inline]
 __se_sys_io_uring_enter+0x40c/0x3ca0 io_uring/io_uring.c:3143
 __x64_sys_io_uring_enter+0x11f/0x1a0 io_uring/io_uring.c:3143
 x64_sys_call+0x2d82/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 5936 Comm: syz.0.15 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1286f1f1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bfb33a8ad10458f
dashboard link: https://syzkaller.appspot.com/bug?extid=82609b8937a4458106ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1302d5ad980000


