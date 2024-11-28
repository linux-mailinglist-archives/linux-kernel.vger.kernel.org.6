Return-Path: <linux-kernel+bounces-424687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3F29DB815
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119C2B21D27
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C919F416;
	Thu, 28 Nov 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv/BSkpO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A25196C7C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798684; cv=none; b=CKcHRearn1oELciYxv9PEOCMfQU0aPTRjD9N3prffegzD46p6jaFmpkye/+X2sioCW6D+LSAAOl6iOIkCDhq52ye2Y+Qgm3JAeyC6EV6PZzmI3/dlFo/o/6MPgHeWX4yLEj9rg95mUjbKhlcKiSy1sxBPfKjnVP8BxxOe9QWneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798684; c=relaxed/simple;
	bh=s3cyCQj48XHqjFB7u/VjWmMB78qcjO/f9/5CbNS5iL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b3nIvIPDJ1Y6s7LZUf6my7/uLhQOc0Lcdb4Ka+5b9AIx1TonHw7/lNZc2mx88JUJPxJhG+gyZsZ/JoSvXH1sIeU/34kbQLwBdIsiS0ivTw0z95isGlRmaP4Sn8woqp5FQiebXfKxYhfYh0EyUJMqyIgnArefJQwu2sURS3RD918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sv/BSkpO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732798680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gAD8aLbmkBBezh666a5YPENhZ30dBeVWFCdAqUsOblw=;
	b=Sv/BSkpOLw1L0r1hpxgn5QuBtMHozkdTfpD+7tP97sI8Z1XayKPDgGSjDNHhjcNRUCxiEK
	f7vYGHO0jKsSbxNnTjgqYl8FlpCPvyolF9N+7d0KYQm4B7TQzMKDpq+er07Dne/sr7QABX
	LksFW6J1D+Cv7+4dbF6R3tZ4FDPq8T0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-_wtanJzqPyudFtR0xRTtRQ-1; Thu, 28 Nov 2024 07:57:59 -0500
X-MC-Unique: _wtanJzqPyudFtR0xRTtRQ-1
X-Mimecast-MFC-AGG-ID: _wtanJzqPyudFtR0xRTtRQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434ad71268dso4871155e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798678; x=1733403478;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAD8aLbmkBBezh666a5YPENhZ30dBeVWFCdAqUsOblw=;
        b=EjO+AqrNYF/9mr6DQeLJm4oO/CwxnQt+UEuZkm3AfBA2RCjr0ZLxKaikzr1sWzWJxS
         xCuB4EM12uunVllI9+xJ9xDrZe2T9xmCSKS9TegEzwh6yj0hFwjTe7jujJMQkudcuwYS
         UUF2avA+ViQKGq3SdIbFoo2EgFrhFiK673FVuN+T9EnDf5vx/K0uJJe+MquFcJNrBFrQ
         AY37iNoSjeFclBS6vHF3n3GevQPIWmWuxs4Yt625wIx3jfddLb2S0VPFLbsaABQbG341
         M2hXqCjWMU3/V5c9BSgWjEA0uvhGxEFd81MjiazYx+2PN0WKY1SojUPhPzYJqW9K8pqD
         MrOw==
X-Forwarded-Encrypted: i=1; AJvYcCWouQdMZiFvqBYQRBFk5YluMU6J8lE0IqrBgOsqULIlqtaw2ohSBFNmotQEgcggPnlxuhR2nABMDQBtuYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIT5FDosAyE794xXoR60Pg2Qr3xsKtk5ECH/v/mnaJgKNSoxlR
	onvOsIb7PzVQxjo2yd0y4peFy5hOqR9xUzMS3ftBIIZHUkM+KOZLLTUnLCKCMmFHaPQPZt3fAs1
	iCImKNLx2VuiJBG5d19GzzrQgpdwxTFrw1GW7RJYulj9+0uZYkwCYw8PpAvt3zQ==
X-Gm-Gg: ASbGnctNLbmpVknkfwuYOmLH/Kai8t264bgT17MXFuYwtmYxNtlw+wdeDQ8NYQe8oRt
	//I0gKhwoAzQKT3nwUcrrYLyDZGtlzN1adBORrpkI6eDa1u/8iArX86vSwyTJAwPtSKn1BtJ+41
	UwCLwV1+b81FZxC3GsogXvBgAJVpTZY2JaYdqmCVS47v6hozruy5eReVmQ85Q55l+4odxxNdcdz
	vZDaak4gAsL0dTzsgTmO2BtvmhYgBvOF0quc9221rmpAjLhRhGKlGdQRaDq8kB8Ft281NZE2p6V
	H/A6o+LgijPhj7qX8tH9qtx5nm6j5nJwWt9e9e2L2mUHDXORzUJKWcztidVNnwSfRK5qgqQgKCU
	=
X-Received: by 2002:a05:600c:6c8a:b0:434:8e8a:d4ec with SMTP id 5b1f17b1804b1-434afc3b6e1mr27446345e9.13.1732798678312;
        Thu, 28 Nov 2024 04:57:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGatBJvY3K5egcgDnkH1KE6IU3FApFvtFFDXObR4JHFqf6BRZQnNBK02nuB8+m5eB549NnV7A==
X-Received: by 2002:a05:600c:6c8a:b0:434:8e8a:d4ec with SMTP id 5b1f17b1804b1-434afc3b6e1mr27446125e9.13.1732798677920;
        Thu, 28 Nov 2024 04:57:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:1600:f3b:67cc:3b88:620e? (p200300cbc71416000f3b67cc3b88620e.dip0.t-ipconnect.de. [2003:cb:c714:1600:f3b:67cc:3b88:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf9f5sm21443275e9.16.2024.11.28.04.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 04:57:56 -0800 (PST)
Message-ID: <57f0859b-4c30-4c72-9796-e8e6f836e509@redhat.com>
Date: Thu, 28 Nov 2024 13:57:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
To: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <674184c9.050a0220.1cc393.0001.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <674184c9.050a0220.1cc393.0001.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.11.24 08:31, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9fb2cfa4635a Merge tag 'pull-ufs' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10042930580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c4515f1b6a4e50b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105ff2e8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7c0c61a15f60/disk-9fb2cfa4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3363d84eeb74/vmlinux-9fb2cfa4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2b1a270af550/bzImage-9fb2cfa4.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com
> 
>   madvise_pageout_page_range mm/madvise.c:609 [inline]
>   madvise_pageout+0x326/0x820 mm/madvise.c:636
>   madvise_vma_behavior+0x58c/0x19e0 mm/madvise.c:1045
>   madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1274
>   do_madvise+0x29d/0x700 mm/madvise.c:1461
>   __do_sys_madvise mm/madvise.c:1477 [inline]
>   __se_sys_madvise mm/madvise.c:1475 [inline]
>   __x64_sys_madvise+0xa9/0x110 mm/madvise.c:1475
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> ------------[ cut here ]------------
> kernel BUG at include/linux/page-flags.h:309!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 7269 Comm: syz.1.183 Not tainted 6.12.0-syzkaller-00233-g9fb2cfa4635a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> RIP: 0010:const_folio_flags.constprop.0+0x12e/0x150 include/linux/page-flags.h:309
> Code: 86 cb ff e8 f4 86 cb ff 48 8d 45 ff 48 39 c3 0f 84 38 ff ff ff e8 e2 86 cb ff 48 c7 c6 00 19 58 8b 48 89 df e8 e3 4b 11 00 90 <0f> 0b e8 6b 0d 2d 00 e9 f1 fe ff ff e8 61 0d 2d 00 eb a3 48 89 df
> RSP: 0018:ffffc9000c55ee30 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0000496f80 RCX: ffffc9000c55ecd8
> RDX: ffff88805f401e00 RSI: ffffffff81c1362d RDI: ffff88805f402244
> RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff203a591
> R10: ffffffff901d2c8f R11: 0000000000000001 R12: 00000000000014df
> R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920018abdf4
> FS:  00007f08b31bc6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c0025ff000 CR3: 00000000341ce000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   folio_test_locked include/linux/page-flags.h:509 [inline]
>   next_uptodate_folio+0xac/0x4b0 mm/filemap.c:3505
>   filemap_map_pages+0x1c6/0x16a0 mm/filemap.c:3647
>   do_fault_around mm/memory.c:5255 [inline]
>   do_read_fault mm/memory.c:5288 [inline]
>   do_fault mm/memory.c:5431 [inline]
>   do_pte_missing+0xdae/0x3e70 mm/memory.c:3965
>   handle_pte_fault mm/memory.c:5766 [inline]
>   __handle_mm_fault+0x100a/0x2a10 mm/memory.c:5909
>   handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077
>   faultin_page mm/gup.c:1187 [inline]
>   __get_user_pages+0x8d9/0x3b50 mm/gup.c:1485
>   __get_user_pages_locked mm/gup.c:1751 [inline]
>   get_dump_page+0xfb/0x220 mm/gup.c:2269
>   dump_user_range+0x135/0x8c0 fs/coredump.c:943
>   elf_core_dump+0x2766/0x3840 fs/binfmt_elf.c:2121
>   do_coredump+0x2c42/0x4160 fs/coredump.c:758
>   get_signal+0x237c/0x26d0 kernel/signal.c:2903
>   arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
>   exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>   exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>   irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
>   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> RIP: 0033:0x1000
> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 002b:000000000000010c EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00007f08b41363b8 RCX: 00007f08b3f7e759
> RDX: ffffffffff600000 RSI: 0000000000000104 RDI: 8000000000000000
> RBP: 00007f08b3ff175e R08: 0000000100000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f08b41363b8 R15: 00007fff7656a008
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:const_folio_flags.constprop.0+0x12e/0x150 include/linux/page-flags.h:309
> Code: 86 cb ff e8 f4 86 cb ff 48 8d 45 ff 48 39 c3 0f 84 38 ff ff ff e8 e2 86 cb ff 48 c7 c6 00 19 58 8b 48 89 df e8 e3 4b 11 00 90 <0f> 0b e8 6b 0d 2d 00 e9 f1 fe ff ff e8 61 0d 2d 00 eb a3 48 89 df
> RSP: 0018:ffffc9000c55ee30 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0000496f80 RCX: ffffc9000c55ecd8
> RDX: ffff88805f401e00 RSI: ffffffff81c1362d RDI: ffff88805f402244
> RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff203a591
> R10: ffffffff901d2c8f R11: 0000000000000001 R12: 00000000000014df
> R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920018abdf4
> FS:  00007f08b31bc6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff76568ff8 CR3: 00000000341ce000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

#syz test https://github.com/davidhildenbrand/linux.git filemap_test_locked

-- 
Cheers,

David / dhildenb


