Return-Path: <linux-kernel+bounces-332966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2FB97C198
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5561F23113
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D41CB316;
	Wed, 18 Sep 2024 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QkN+j48F"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857C18A6C5
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726696526; cv=none; b=RXtGUoWOu6oLKsBL+8VOne0B6FnzbF4WpNadDqGtXJ/7Trbbcc+ykFjt7msHI7PEuAuTnDQq4J0A6l9bFOYrXG9o2oHj6Hww33qBkxwQ45/5jp7YhANSIy1YYYmSQyMG7yaBoL0aC6wicFl5n0WQIF7KCcq0pWthz3uNXG851so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726696526; c=relaxed/simple;
	bh=eTVDU7gdmzphlUVUnE1G3vcvGab9WiL8zZ2pPLS5S9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KytjlgW/UG4B7e7GP1w5SgpxRwLMEVQVTMFt+nACVpe2H8I2MjjCTUKcK/+qzw+a/cb//Y+/sC66OBSLtoTc48+TqvNKXdMSQMg38VygZINHU5R3AFxqwWjV8yo8L4wd5k8EwAipQOFLNRymQgJ8ArWNgKWq3aSBVnPSFjqp26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QkN+j48F; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2053616fa36so3260335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726696524; x=1727301324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb+nSJOyGZJxQJ4PFOQ+I8GbkeQ4WRp9g2iNj4fVmx4=;
        b=QkN+j48FkOdns26Tu+BD2K9PS0TQV9utkVcTNIruvrilqdsSFXOLYxQ9QH9Du7pwB5
         RnuTYbKBI+V5ZbkzpFlOp6rAt/+G9E5uKnXpJKwElxAu+XYe1n6T4zv4BIgUwDMJksnd
         3HfoU5dGtmyZYMvy25fp8JkvfVLS99dg8bYRLAQJwnn10fNK28SK8lHztrbbbhQwCMEA
         rF/RtnWn6mvWIvYQ2nEE+tL+KW+6qwt8S6GjQSdpWqnk9clueXAH6EEO0p+4snb76MGs
         LSzZOUhPk6oUYrDAuUqv6wFjm5IvxRXdI8CV8ZFnZKQEg3ILibdis5vgA6vdG4wl8hjj
         SBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726696524; x=1727301324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb+nSJOyGZJxQJ4PFOQ+I8GbkeQ4WRp9g2iNj4fVmx4=;
        b=OAysdUM9Lkt4Y1Jz2xOZ/vdJ2QC42L5hpRDs2BECSsFAQqGh1DfTIbV4cXHChPv6Dx
         0Sln1IvcyxmaZ55wc12lqp5pZaeZbhhl853XSBTChTaxE0NBe3FU+yAp4esmdkOWJapN
         Iidey1HWS9tbQ503rntH1kpKWNm32L+vzM2cvJj2iMkHqYw9KnATuc1vtN2Pc7XXhCOS
         eSzXWudLPEzxHxuzk46ElpOoo2pGWT69bo/urp/ANwxXSHLiYM9Gs89NuqvNCBm7UrwY
         DzuaZoDXZlBAAOOuxa/bwtpmSmIfMbrpmGh6Nl38MiydcMTi5s9XV3IQSLXmON/Aha3G
         CO8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUThl8cPrUL1RSL3FIdkKUV+/hhqksdJeMdYjtp+vmxXVaMOGQjVARigrMO4OKJSBYIfYGC4OCSXqC9Mt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoosbq32tcO/56D0ZY3G70Dkdc7sk8RToLVyc+ZrFp1rxePhVs
	TTuQYodYSkev9cXdLGj6qn+BKTRUETQxHwiFliAsw4PlY+0FA+9uBtUjchyPqhk=
X-Google-Smtp-Source: AGHT+IEXu7SW+MwUsZbSMxUt2YNTqyySvhhz1IG1jWJmv5uwIXZpvEb6GtBpxr1ML4AHKkasodh2LA==
X-Received: by 2002:a17:903:18b:b0:205:5005:957b with SMTP id d9443c01a7336-2076e3ea9cdmr329560285ad.37.1726696523665;
        Wed, 18 Sep 2024 14:55:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49924501sm8083413a12.53.2024.09.18.14.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 14:55:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sr2dr-006yQV-03;
	Thu, 19 Sep 2024 07:55:19 +1000
Date: Thu, 19 Sep 2024 07:55:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+6926ab9f6f7d7b50002e@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
	syzkaller-bugs@googlegroups.com, zhengqi.arch@bytedance.com,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in shrinker_free
Message-ID: <ZutMRnQagGIkHT2F@dread.disaster.area>
References: <00000000000089afe20622674444@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000089afe20622674444@google.com>

On Wed, Sep 18, 2024 at 09:26:27AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    57719771a244 Merge tag 'sound-6.11' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=122c17c7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=96be9a618e50f19f
> dashboard link: https://syzkaller.appspot.com/bug?extid=6926ab9f6f7d7b50002e
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1559749f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1359749f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/87498efcab61/disk-57719771.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5703d19e746c/vmlinux-57719771.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3744ba66862a/bzImage-57719771.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6926ab9f6f7d7b50002e@syzkaller.appspotmail.com
> 
> svc: failed to register nfsdv3 RPC service (errno 512).
> svc: failed to register nfsaclv3 RPC service (errno 512).
> ==================================================================
> BUG: KASAN: slab-use-after-free in shrinker_free+0x3b7/0x430 mm/shrinker.c:775
> Read of size 4 at addr ffff8880206cbb1c by task syz-executor313/5320
> 
> CPU: 0 UID: 0 PID: 5320 Comm: syz-executor313 Not tainted 6.11.0-rc7-syzkaller-00145-g57719771a244 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0xc3/0x620 mm/kasan/report.c:488
>  kasan_report+0xd9/0x110 mm/kasan/report.c:601
>  shrinker_free+0x3b7/0x430 mm/shrinker.c:775
>  nfsd_file_cache_shutdown+0xbc/0x480 fs/nfsd/filecache.c:891
>  nfsd_shutdown_generic fs/nfsd/nfssvc.c:329 [inline]
>  nfsd_shutdown_generic fs/nfsd/nfssvc.c:323 [inline]
>  nfsd_startup_net fs/nfsd/nfssvc.c:444 [inline]
>  nfsd_svc+0x6d4/0x970 fs/nfsd/nfssvc.c:817
>  nfsd_nl_threads_set_doit+0x52c/0xbc0 fs/nfsd/nfsctl.c:1714

This looks like an issue with nfsd startup error handling (maybe
resulting in a double free?) and not a shrinker issue as such.
CC'ing the NFS people.

-Dave.

>  genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9b4/0xb50 net/socket.c:2597
>  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
>  __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f51ae6e5ab9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f51ae634158 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f51ae768438 RCX: 00007f51ae6e5ab9
> RDX: 0000000000000004 RSI: 0000000020000280 RDI: 0000000000000003
> RBP: 00007f51ae768430 R08: 0000000000000008 R09: 0000000000000000
> R10: 0000000000000003 R11: 0000000000000246 R12: 00007f51ae76843c
> R13: 000000000000006e R14: 00007ffc1415e4a0 R15: 00007ffc1415e588
>  </TASK>
> 
> Allocated by task 5309:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
>  kmalloc_noprof include/linux/slab.h:681 [inline]
>  kzalloc_noprof include/linux/slab.h:807 [inline]
>  shrinker_alloc+0xf8/0xb00 mm/shrinker.c:683
>  nfsd_file_cache_init+0x152/0x450 fs/nfsd/filecache.c:743
>  nfsd_startup_generic fs/nfsd/nfssvc.c:307 [inline]
>  nfsd_startup_net fs/nfsd/nfssvc.c:402 [inline]
>  nfsd_svc+0x542/0x970 fs/nfsd/nfssvc.c:817
>  nfsd_nl_threads_set_doit+0x52c/0xbc0 fs/nfsd/nfsctl.c:1714
>  genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9b4/0xb50 net/socket.c:2597
>  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
>  __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 0:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
>  poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
>  __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2256 [inline]
>  slab_free mm/slub.c:4477 [inline]
>  kfree+0x12a/0x3b0 mm/slub.c:4598
>  rcu_do_batch kernel/rcu/tree.c:2569 [inline]
>  rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2843
>  handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:637 [inline]
>  irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>  sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> 
> Last potentially related work creation:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
>  __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:3106
>  shrinker_free+0xfe/0x430 mm/shrinker.c:807
>  nfsd_file_cache_shutdown+0xbc/0x480 fs/nfsd/filecache.c:891
>  nfsd_shutdown_generic fs/nfsd/nfssvc.c:329 [inline]
>  nfsd_shutdown_generic fs/nfsd/nfssvc.c:323 [inline]
>  nfsd_startup_net fs/nfsd/nfssvc.c:444 [inline]
>  nfsd_svc+0x6d4/0x970 fs/nfsd/nfssvc.c:817
>  nfsd_nl_threads_set_doit+0x52c/0xbc0 fs/nfsd/nfsctl.c:1714
>  genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9b4/0xb50 net/socket.c:2597
>  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
>  __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff8880206cbb00
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 28 bytes inside of
>  freed 192-byte region [ffff8880206cbb00, ffff8880206cbbc0)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x206cb
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xfdffffff(slab)
> raw: 00fff00000000000 ffff88801ac413c0 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 4560085887, free_ts 0
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
>  prep_new_page mm/page_alloc.c:1508 [inline]
>  get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
>  __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x4e/0xf0 mm/slub.c:2325
>  allocate_slab mm/slub.c:2488 [inline]
>  new_slab+0x84/0x260 mm/slub.c:2541
>  ___slab_alloc+0xdac/0x1870 mm/slub.c:3727
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3817
>  __slab_alloc_node mm/slub.c:3870 [inline]
>  slab_alloc_node mm/slub.c:4029 [inline]
>  __kmalloc_cache_noprof+0x2c5/0x310 mm/slub.c:4188
>  kmalloc_noprof include/linux/slab.h:681 [inline]
>  kzalloc_noprof include/linux/slab.h:807 [inline]
>  call_usermodehelper_setup+0x9a/0x340 kernel/umh.c:363
>  kobject_uevent_env+0xde3/0x1670 lib/kobject_uevent.c:628
>  kset_register+0x1b6/0x2b0 lib/kobject.c:877
>  class_register+0x22e/0x340 drivers/base/class.c:203
>  typec_init+0x63/0x110 drivers/usb/typec/class.c:2518
>  do_one_initcall+0x128/0x630 init/main.c:1267
>  do_initcall_level init/main.c:1329 [inline]
>  do_initcalls init/main.c:1345 [inline]
>  do_basic_setup init/main.c:1364 [inline]
>  kernel_init_freeable+0x660/0xc50 init/main.c:1578
>  kernel_init+0x1c/0x2b0 init/main.c:1467
> page_owner free stack trace missing
> 
> Memory state around the buggy address:
>  ffff8880206cba00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8880206cba80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff8880206cbb00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                             ^
>  ffff8880206cbb80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff8880206cbc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
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

-- 
Dave Chinner
david@fromorbit.com

