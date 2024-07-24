Return-Path: <linux-kernel+bounces-261420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D293B71C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641931F24094
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225D16B722;
	Wed, 24 Jul 2024 18:59:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995381591F3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847546; cv=none; b=Ml2JsqLENLtxG/uREeUWiRwTwMTTW59DdoCxY2IbfzkTrUU3q/87Zr4pDvJl35X1yrxDLalznM+/36KqIBpOhcnzNNFNUYEH5Olo6CSMSJ4FsD0+BoUd2aHhJ9IXLNDKl5Pk6HxqZwaVCp3guJ1JtNDrzdIpGmy2v142qBtCCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847546; c=relaxed/simple;
	bh=7f7FtSv7nnQZMtXVfJa0ePVsJHkIWzVFFZA8MEbsHLE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lVkhRLhVodVQy3B5CaaPYpY1atbjHPvB1LLofLF3RK5Nc+Ws7u5iLJt+i3oBtIdA2hnkbE4B8fX6iIIGlBZGH0naDXJyMLEqLOg+70wSZ6MfYZkS4OA3cVkSfH1v9cDwWUo0XOi0aXufAR5jWHPE53vSefDGSvvyHypKXvjfrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81257dec573so19718339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721847544; x=1722452344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfdzvacuDV3CcT26JJD9v7jns+NQq86w7tti0drlXpY=;
        b=U/BZqW8D2XyGF5zNbuWhm8oqCIMvYlnyHT7AiuxSJiHsrtb2QOeFEaAZ7w9kVw+vSq
         t3xAUnvRtnHrgf7uCaj9iVngalaXyM++ZXMssaqePgQcSq+hM7w7ZwmsK0KpypxS+pqy
         zfGZwkSVQ/qw+xF0bSK4St7KuDcpE6Dh1KZ7I19D3dABGD7Hg8101vdvmyUrCUk3szX8
         zulUS3lckk/NAXIuCqEz9BEMR6T1FUcIyU4OZiuFN/k8HgJOgW9Z/1E6QkBCQIdlyy5l
         +md+xwtYyH1x2u1oC74UZBFH66t+mCgHxoyFu5Owsb1bwjiLcZN96XCKBTuDc94I42Ua
         XoiA==
X-Forwarded-Encrypted: i=1; AJvYcCXXDna+ZCHUP/bb0BytM4qW177hv09NMmUaN61XZOwTDLqB8gMorUOI6fETZfpRp9JNqU5gYuanMrPmS2ZM1DlNWCpqpLS4NYq0F2fs
X-Gm-Message-State: AOJu0YyCcXLWdc3lEjYp1xV6gJLfdBCVx14oEP2lCKgH51Zwtedxf9vg
	3l776//BLvpKevXnHPqvAGRe5s8slzqweQjYKHY3FdMlorBiYsd68p/91s2ECh0B9oNAyqMdpcM
	b7vvRnrDqXZjjF8sjIGsdlioEBi9deoFEu9pXp51riBBZZAypqTKi7I8=
X-Google-Smtp-Source: AGHT+IG0R1Og+dysLDHe5d/3/YBqGbJ+pY6Rqqiy5laFYf0wseOpwhzCIZGio6wZe5pmnw8vWceoXY/k+ubnGByr/mg786J2rbX7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:397:3e38:eb30 with SMTP id
 e9e14a558f8ab-39a2182abaemr382345ab.3.1721847543887; Wed, 24 Jul 2024
 11:59:03 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:59:03 -0700
In-Reply-To: <18c54a21-184c-4cde-811c-48c5c0e34f9b@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000360ee4061e02dffe@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_task_work_add_remote
From: syzbot <syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in io_req_task_work_add_remote

=====================================================
BUG: KMSAN: uninit-value in io_req_local_work_add io_uring/io_uring.c:1193 [inline]
BUG: KMSAN: uninit-value in io_req_task_work_add_remote+0x592/0x5e0 io_uring/io_uring.c:1241
 io_req_local_work_add io_uring/io_uring.c:1193 [inline]
 io_req_task_work_add_remote+0x592/0x5e0 io_uring/io_uring.c:1241
 io_msg_remote_post io_uring/msg_ring.c:102 [inline]
 io_msg_data_remote io_uring/msg_ring.c:133 [inline]
 io_msg_ring_data io_uring/msg_ring.c:152 [inline]
 io_msg_ring+0x1c38/0x1ef0 io_uring/msg_ring.c:305
 io_issue_sqe+0x383/0x22c0 io_uring/io_uring.c:1711
 io_queue_sqe io_uring/io_uring.c:1925 [inline]
 io_submit_sqe io_uring/io_uring.c:2181 [inline]
 io_submit_sqes+0x1259/0x2f20 io_uring/io_uring.c:2296
 __do_sys_io_uring_enter io_uring/io_uring.c:3206 [inline]
 __se_sys_io_uring_enter+0x40c/0x3ca0 io_uring/io_uring.c:3143
 __x64_sys_io_uring_enter+0x11f/0x1a0 io_uring/io_uring.c:3143
 x64_sys_call+0x2d82/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4719
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page mm/slub.c:2321 [inline]
 allocate_slab+0x203/0x1220 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3723
 __kmem_cache_alloc_bulk mm/slub.c:4759 [inline]
 kmem_cache_alloc_bulk_noprof+0x486/0x1330 mm/slub.c:4831
 __io_alloc_req_refill+0x84/0x560 io_uring/io_uring.c:940
 io_alloc_req io_uring/io_uring.h:393 [inline]
 io_submit_sqes+0x171b/0x2f20 io_uring/io_uring.c:2285
 __do_sys_io_uring_enter io_uring/io_uring.c:3206 [inline]
 __se_sys_io_uring_enter+0x40c/0x3ca0 io_uring/io_uring.c:3143
 __x64_sys_io_uring_enter+0x11f/0x1a0 io_uring/io_uring.c:3143
 x64_sys_call+0x2d82/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5924 Comm: syz.0.16 Not tainted 6.10.0-syzkaller-12268-g7a3fad30fd8b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


Tested on:

commit:         7a3fad30 Merge tag 'random-6.11-rc1-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a6fa19980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f26f43c6f7db5ad2
dashboard link: https://syzkaller.appspot.com/bug?extid=82609b8937a4458106ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178ca779980000


