Return-Path: <linux-kernel+bounces-440125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE59EB934
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F862284284
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9711B5ED1;
	Tue, 10 Dec 2024 18:20:29 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0723ED59
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854828; cv=none; b=LnePWNd71Sdjc36/rLxcHMVk/7xZlbqjSDHEUOVU3Cego42bfZ6Y90AkmwEe/EHsx8gmrhoWgrwIOu7RBuHQ4SqZxgfTuhPsGZK9XO12F4/Yg6NvBwIhJBy8E/mWPY8a7tJKC3k5c0FscvwLviRRMeNcyoFcDcYfkc6z4suCyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854828; c=relaxed/simple;
	bh=8X1cBbSjsVYSPA7/TPd/8Ejxj0AiaZ6jDoWQMyiylYk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XymHcgCts18BbEsxo9E2ZN5gI1R4PjnGWeB7jUT+r7bgmWKiIF3em+XSin1XQAVrKM0JcjAokpJBovO+2MZpcxNrhnVkc7ci+xpB6YCn1LtMjh1t7PPq7AlPgypN2gCTd0C/2xkF8UaE0TQjR1I0/GRFYpogfnW50bvN7w+mrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7cf41b54eso111971555ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733854826; x=1734459626;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3iz0LvI06t2t+5BKL+U3ZhKEcCP4S3jXRHl4/Yuwiew=;
        b=okZU6W0hJyzNpe/fF+pZIZrazEdvPZST0gXO6tkPuPcPUIhMIq8DIb8qOMq6zJ8zKI
         1iBPQWNzVb7KmsRIwvUoZ1wHmBmvVMikUdVqngMG27tWN5lB/dW5cn+aGEhDBQXeRsx5
         dGvdf4nVMwREz7yc8E17rFG/R8eDhFZwX1gk+JlwN+hNVrcBwnjRwlRHl1zHE+TJWYeZ
         bzpOKH2vS3hQTGWJWOdz7YSYtvUUTIKjz309Sb8uJgTQJQnEiAID9FUutYVsuoihT3BI
         WbZjxBhMc7yfW2C+7YQ1HdTStO7meQnNCqponRTpyGl5BhKTyw4JInsbJUuAFXrzw2Tc
         9i6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVonojkRu0u3pnfHnZk37A2WQb8XKAb3gkp4gMRXZLZ4taSC4XUBl3xzmWtBOZU9GLLh5MJX2RNbWYCA1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0NdYWc89ZUurnSbqyty5vxYTQsg0oiupgwO/2bQpYiUe5AS7
	wJcFPZOMyDNUQ6QW9FMyPCRADaLQX/GfCCBB0aDInw1azLPbPNl81WNnYAhuByDvQ3/XUVEapQE
	dEIljoHUKX+9CTrFQnysBcTy+CgaxCRkkkSMBoZ0BGHSfsnKCz4EJYyU=
X-Google-Smtp-Source: AGHT+IH2RRMbbOZIOE8hFuP0Wd1SNGiEHsu/laAOuXeblnP25CD61Pi1qXmCn2f4vjfiAfGdcy8yjYvlYxl9Z/d52rd01iylXKg0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1547:b0:3a7:6e72:fbb3 with SMTP id
 e9e14a558f8ab-3a811d774c1mr164591175ab.4.1733854826338; Tue, 10 Dec 2024
 10:20:26 -0800 (PST)
Date: Tue, 10 Dec 2024 10:20:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6758866a.050a0220.a30f1.01d9.GAE@google.com>
Subject: [syzbot] [kernel?] KMSAN: uninit-value in timerqueue_add (2)
From: syzbot <syzbot+8974d7bf41172a2b0729@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b8f52214c61a Merge tag 'audit-pr-20241205' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b6d330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcc2c6db74766fbc
dashboard link: https://syzkaller.appspot.com/bug?extid=8974d7bf41172a2b0729
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/961b446be7db/disk-b8f52214.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f408f31c5b2/vmlinux-b8f52214.xz
kernel image: https://storage.googleapis.com/syzbot-assets/97900576aa59/bzImage-b8f52214.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8974d7bf41172a2b0729@syzkaller.appspotmail.com

ffff88813fd05fc0: ffff888031cf2978 (0xffff888031cf2978)
ffff88813fd05fc8: 0000000000000000 ...
ffff88813fd05fe8: ffff888031cf2968 (0xffff888031cf2968)
ffff88813fd05ff0: ffffffff8fe8d40e (instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline])
ffff88813fd05ff0: ffffffff8fe8d40e (sysvec_apic_timer_interrupt+0x7e/0x90 arch/x86/kernel/apic/apic.c:1049)
ffff88813fd05ff8: ffff888031cf2958 (0xffff888031cf2958)
BUG: KMSAN: uninit-value in rb_add_cached include/linux/rbtree.h:172 [inline]
BUG: KMSAN: uninit-value in timerqueue_add+0x20b/0x3d0 lib/timerqueue.c:40
 rb_add_cached include/linux/rbtree.h:172 [inline]
 timerqueue_add+0x20b/0x3d0 lib/timerqueue.c:40
 enqueue_hrtimer+0x189/0x3a0 kernel/time/hrtimer.c:1084
 __run_hrtimer kernel/time/hrtimer.c:1756 [inline]
 __hrtimer_run_queues+0x64d/0xe40 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x41b/0xb10 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0xa7/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x7e/0x90 arch/x86/kernel/apic/apic.c:1049

Uninit was created at:
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4774
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2344
 alloc_slab_page mm/slub.c:2408 [inline]
 allocate_slab+0x320/0x12e0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3815
 __slab_alloc mm/slub.c:3905 [inline]
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_node_noprof+0x84a/0xe00 mm/slub.c:4205
 __alloc_skb+0x1e9/0x7b0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1323 [inline]
 new_skb+0x46/0x560 drivers/block/aoe/aoecmd.c:66
 aoecmd_cfg_pkts drivers/block/aoe/aoecmd.c:430 [inline]
 aoecmd_cfg+0x2c0/0xac0 drivers/block/aoe/aoecmd.c:1370
 discover_timer+0x62/0x80 drivers/block/aoe/aoemain.c:25
 call_timer_fn+0x49/0x580 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1844 [inline]
 __run_timers kernel/time/timer.c:2418 [inline]
 __run_timer_base+0x84e/0xe90 kernel/time/timer.c:2430
 run_timer_base kernel/time/timer.c:2439 [inline]
 run_timer_softirq+0x3a/0x70 kernel/time/timer.c:2449
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:554
 __do_softirq+0x14/0x1a kernel/softirq.c:588

CPU: 1 UID: 0 PID: 8505 Comm: syz.1.784 Not tainted 6.13.0-rc1-syzkaller-00182-gb8f52214c61a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

