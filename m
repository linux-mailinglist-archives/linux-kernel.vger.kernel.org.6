Return-Path: <linux-kernel+bounces-441122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EF99EC9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E8C1886C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F821D9359;
	Wed, 11 Dec 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpJu6qiG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19A236F98
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911593; cv=none; b=Bh2ZwyMnYZzAqihqa9bnnJtzf9MqdSCkz4mC4fk6K3rqtsabe80HgX2Osnojkgf49Vd5UBLeNoV6W9Y1v7cJTNmLKJTtktHDo6MceYJf3ZMG/SAw9cQ3v6g/h1uT5DeJYGJp1ba8VFsaUpfXF/h9KqBYzmPaCxDkA8wZW2YPNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911593; c=relaxed/simple;
	bh=0isxWpA+zgkmKDqSnMRo0k2BirwXEsV2aMv/27MvAaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Nq+tEl0TxrzsDwoBehP/i1ibGrFs3HNsYo5wtb2zdWuv5uq+/el8GDgjevboCjtPu8Z80lGjfJA0BUDYFNHQUBOvOOzLrmtnl+sTGwbGm3oo68t8Cb/Hx7mal7Va4F3xPxJODUElfbTDnXTCvUKrPTfaj1Ho9xQCQy2D38oy9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpJu6qiG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733911589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZfQrsyTgkHIVgiu42pO4lY6StrbSM00QmMuRgb4ukgA=;
	b=TpJu6qiGtS5K0biLEvcW/9Epz2l/aP7K375IRI74hRc4kQ36n9gRakh93FBTLu+X4KxV4T
	K9vbLo7OPvcl9Rn2lqY+3nlQvfgqBV2VUCmLpJfWwPApj7nHGRLN9zTkUeaCbK6OZcrVtb
	z1DhwrWSevXUl1qZScrUKPBMkl1mSGg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-shlYhEFlOWWnohuqeVUQ8Q-1; Wed, 11 Dec 2024 05:06:28 -0500
X-MC-Unique: shlYhEFlOWWnohuqeVUQ8Q-1
X-Mimecast-MFC-AGG-ID: shlYhEFlOWWnohuqeVUQ8Q
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4676f54b46cso48495381cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911588; x=1734516388;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfQrsyTgkHIVgiu42pO4lY6StrbSM00QmMuRgb4ukgA=;
        b=BybAQw9DgdzndZc3WqkeSM2liZJj9NxCeDKEJDDW5pVzR6YWacQU2rRuLfH++mOf0z
         c/OMCn8uYspiBjt3UY4caNO/tRoYVUCBkgoFV7oNuMSMP4r7b6m9mkrW/1xgqMD9Vutl
         stJD3mOUFeaKX0Ywaoirq+HQcfeppaajXnZARJjbrFT90ORdEEvvazXCBneKhQBe/zwF
         W39iOo9ybJyQaFMIuvZb0B5b/zxx2+Y+vBmTbQc/Z/pNJPPVgPxgcu+1/ZNwMI6CTiXh
         v5RNJT6tBH7icePKiet6P1fVqp3YCD6In92D3GP4dCcLBrnOyy2yG9RzaznP1IifJ8Oc
         ul4w==
X-Forwarded-Encrypted: i=1; AJvYcCUKBL2WjO40h+QLnU4lRLI0CATaPz0D/tVi4RljLHlxOzWIBbpMFUU18SPiiQpuTdFg9urtTMKlN1+OxVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMR49/QIzNa7QAGkVGBCWF99URWS/eV8PuxQcW3iBTEMh+vteT
	T58+T9jpV+9ytrhmdlmfAC9yZ+aInNHVaeirQkJluzIG8UFqOC0yJ/mPQ/DWaZS3lWMfUDXO8j4
	/Kjo9GV14wC3+vV9DkjUS3HwpcOyF36miibJR9jJ7JPFQhGJt4/uchPVfifZXJg==
X-Gm-Gg: ASbGnctj+jsUai3rO38YNwzmJejwUIf2zpPzI/a1kYmPFZ0RXdBrs4FNz3XBhF3pjza
	kGx/MJIttlwtkBu/sNWhWrZOtxM3PsG6reVblkcfWTnSFDw+F9nruNT2uBnrdewjmF3ZjIFwEz6
	ZT9+KVkb3kT7CXCXi8/rkDNHpfvcL1hqYNrC19Kd5SBIgOKMFqQr33KzT+DNwBSgxJYqsbHTlZ4
	o6wQxIRmH0wLQJUswQJToBhaw9DwNe42MxiaWxWV4ETba2ExcR/2OWufWPmvlf0FoehZTvQhg/E
X-Received: by 2002:a05:622a:353:b0:467:5531:cc62 with SMTP id d75a77b69052e-467892b8042mr47061081cf.18.1733911588280;
        Wed, 11 Dec 2024 02:06:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElMpr/F6NomY4lPXCQDcCJQT0mfSu1Qt54qGwc/mHW9a3TTymQtu6cmD6hJ23BuBWxKHnf9w==
X-Received: by 2002:a05:622a:353:b0:467:5531:cc62 with SMTP id d75a77b69052e-467892b8042mr47060711cf.18.1733911587859;
        Wed, 11 Dec 2024 02:06:27 -0800 (PST)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467867dc781sm9652341cf.68.2024.12.11.02.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 02:06:27 -0800 (PST)
Message-ID: <cd1ad87e-1298-413c-9ce7-1ec88d370fda@redhat.com>
Date: Wed, 11 Dec 2024 11:06:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks (2)
To: syzbot <syzbot+c0673e1f1f054fac28c2@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <6758f0cc.050a0220.17f54a.0001.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Cc: Matthew Wilcox <willy@infradead.org>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6758f0cc.050a0220.17f54a.0001.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.12.24 02:54, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b8f52214c61a Merge tag 'audit-pr-20241205' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164958df980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c579265945b98812
> dashboard link: https://syzkaller.appspot.com/bug?extid=c0673e1f1f054fac28c2
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/27d16eb66738/disk-b8f52214.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4e6e3d3856a3/vmlinux-b8f52214.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e4a9277cf155/bzImage-b8f52214.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c0673e1f1f054fac28c2@syzkaller.appspotmail.com
> 
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 1 tgid 1 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1127 [inline]
>   free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
>   free_contig_range+0x133/0x3f0 mm/page_alloc.c:6630
>   destroy_args+0xa87/0xe60 mm/debug_vm_pgtable.c:1017
>   debug_vm_pgtable+0x168e/0x31a0 mm/debug_vm_pgtable.c:1397
>   do_one_initcall+0x12b/0x700 init/main.c:1266
>   do_initcall_level init/main.c:1328 [inline]
>   do_initcalls init/main.c:1344 [inline]
>   do_basic_setup init/main.c:1363 [inline]
>   kernel_init_freeable+0x5c7/0x900 init/main.c:1577
>   kernel_init+0x1c/0x2b0 init/main.c:1466
>   ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 10473 at ./include/linux/rmap.h:217 __folio_rmap_sanity_checks+0x356/0x540 include/linux/rmap.h:217

That is:

VM_WARN_ON_FOLIO(page_folio(page + nr_pages - 1) != folio, folio);

Meaning, nr_pages crosses our folio, which is bad.

Note that

VM_WARN_ON_FOLIO(page_folio(page) != folio, folio);

Held.

(doing the page arithmetic will work as we are not crossing memory 
section boundaries with any pages we expect in here right now)

> Modules linked in:
> CPU: 0 UID: 0 PID: 10473 Comm: syz.3.899 Not tainted 6.13.0-rc1-syzkaller-00182-gb8f52214c61a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:__folio_rmap_sanity_checks+0x356/0x540 include/linux/rmap.h:217
> Code: d2 b0 ff 49 8d 6f ff e8 28 d2 b0 ff 48 39 eb 0f 84 53 fe ff ff e8 1a d2 b0 ff 48 c7 c6 20 ac 7a 8b 48 89 df e8 db fb f6 ff 90 <0f> 0b 90 e9 36 fe ff ff e8 fd d1 b0 ff 49 89 ec 31 ff 41 81 e4 ff
> RSP: 0018:ffffc900036b75d8 EFLAGS: 00010246
> RAX: 0000000000080000 RBX: ffffea0001108000 RCX: ffffc9000de50000
> RDX: 0000000000080000 RSI: ffffffff81e933a5 RDI: ffff88802e0d8444
> RBP: ffffea000111ffc0 R08: 0000000000000000 R09: fffffbfff20be52a
> R10: ffffffff905f2957 R11: 0000000000000006 R12: 0000000000000000
> R13: 0000000000000410 R14: 0000000000000000 R15: dead000000000100
> FS:  00007ffb8d5086c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1678a23712 CR3: 0000000068232000 CR4: 0000000000350ef0
> Call Trace:
>   <TASK>
>   __folio_add_rmap mm/rmap.c:1170 [inline]
>   __folio_add_file_rmap mm/rmap.c:1489 [inline]
>   folio_add_file_rmap_ptes+0x72/0x310 mm/rmap.c:1511

So set_pte_range() is already called with a wrong page + nr combination 
I suspect.



>   set_pte_range+0x135/0x520 mm/memory.c:5065
>   filemap_map_folio_range mm/filemap.c:3572 [inline]
>   filemap_map_pages+0xb5a/0x16b0 mm/filemap.c:3681
>   do_fault_around mm/memory.c:5280 [inline]
>   do_read_fault mm/memory.c:5313 [inline]
>   do_fault mm/memory.c:5456 [inline]
>   do_pte_missing+0xdae/0x3e70 mm/memory.c:3979
>   handle_pte_fault mm/memory.c:5801 [inline]
>   __handle_mm_fault+0x103c/0x2a40 mm/memory.c:5944
>   handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6112
>   faultin_page mm/gup.c:1187 [inline]
>   __get_user_pages+0x8d9/0x3b50 mm/gup.c:1485
>   populate_vma_page_range+0x27f/0x3a0 mm/gup.c:1923
>   __mm_populate+0x1d6/0x380 mm/gup.c:2026
>   mm_populate include/linux/mm.h:3386 [inline]
>   vm_mmap_pgoff+0x293/0x360 mm/util.c:585
>   ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
>   __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
>   __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
>   __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ffb8c77fed9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffb8d508058 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007ffb8c946080 RCX: 00007ffb8c77fed9
> RDX: 0000000000000002 RSI: 0000000000b36000 RDI: 0000000020000000
> RBP: 00007ffb8c7f3cc8 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000028011 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000001 R14: 00007ffb8c946080 R15: 00007ffd68dca078
>   </TASK>
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


-- 
Cheers,

David / dhildenb


