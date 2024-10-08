Return-Path: <linux-kernel+bounces-354584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F86993FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373A91C21987
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9724F1C3037;
	Tue,  8 Oct 2024 06:51:22 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600681B4F37
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370282; cv=none; b=gL9nMh2msps0UAd6WbM/gRo8Hf/wfGVPo3xe+sU/P71CeUpGHDsTHiw/moRXcvL/PUH9SatNV+RLXPula9A6h+VGrkxpLZmmPuRgdxlxIcGtm/vxxnXSVq8T9rhFkGiclR4JkSWQFRvBP+RzJdEF5Gk9kDoyzBs/XldfdpiHedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370282; c=relaxed/simple;
	bh=LbQlu9YTC+SXYP1Zwn6Tr7S1F3vDSC01lCx3Hi8Qy4I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IspN0FfPEtsTCnP4LxstO6BbMhoFZYsRAMbj0Bn3Plagh7drZsnyE9B5c4ByofLp8obDlBT11gPXjNFnSegJecpFOHDo9kfr0hSfQp2CTW6YTzkH9ZFBw+c28XEP0kMKcK+BBUzXjNpsooFLeqgEp47xg0Y3o+/2fyU3bO+vE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a1a969fabfso65115885ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 23:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370279; x=1728975079;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91mhPcxxN5QgnmN57ERwmWQ64X0Whdu9PHF2f106hrc=;
        b=NuRTIt2/xQ3PcEF0xL14wi7VYQDcj4zwAb+aEP9cUbTMAm7jmPKoqdVnSVCcFZ5BM9
         IzyIN98B3zp1j1ijN2eLddT7geSAmOokz9l77jzPR+1NfUQKycjQ9rW4ijqjLunWcrfx
         PTjU7I86uTeHal+Sq7q9+Hoobd3WsymoglRxDAlnbIU5k8ZjUn2vum7ZUmsG+P4q2vK0
         uzZWaMLQpDO8lAcTdMz9Asi3+CUqYu8+CumM5ArTQUmcMCmyrKmQXiZfpWK3Fm3tIu8w
         V0JjExRDzIf1c8a3BRTVwt6INihsuK6OM4+RwA1f3wXsrIP9gcLqqliWe/yfwm7b4WUi
         k0VA==
X-Forwarded-Encrypted: i=1; AJvYcCUMIPby0iQPSqwJJNjnjRNontq2P5OYPfDZrSf0+nekXgl4M5FJIovNmzj5WRERPyvjYl8CmNg32nbP2Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSEfA3j0ssfSjVbcbcXa+XDu7icthA7qVw3k2aHHjRcSUVx/r
	rJQV67AXpNJtSXxCuHO28pOIP2buYixnjbMVHNw79yoi26tT7IAJpFOzj7ZNXattHpxjnJelI1q
	qY1I3y1ptCiNQN7TvBxB6olQMhVMKvcb/skyrb/l1gZZs5Y4cctJ2IGw=
X-Google-Smtp-Source: AGHT+IFSDgjcJlrhcsp+O5S7CLUUKtrxkIlWqmlwnnn/mcLzgpJdi2PaiAywJRbHj7+WsMh5J8G8uxs5izXbKV8UCxsZcnQQjUyS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca7:b0:3a0:9043:59ac with SMTP id
 e9e14a558f8ab-3a375be5b99mr139424285ab.25.1728370279696; Mon, 07 Oct 2024
 23:51:19 -0700 (PDT)
Date: Mon, 07 Oct 2024 23:51:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704d667.050a0220.1e4d62.0082.GAE@google.com>
Subject: [syzbot] [mm?] linux-next test error: kernel BUG in folio_add_new_anon_rmap
From: syzbot <syzbot+619c487ed60780dab217@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-next@vger.kernel.org, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    58ca61c1a866 Add linux-next specific files for 20241004
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1265e7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=619c487ed60780dab217
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ff0999f3e964/disk-58ca61c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0d9a5bad786/vmlinux-58ca61c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3b53cdc9ba34/bzImage-58ca61c1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+619c487ed60780dab217@syzkaller.appspotmail.com

cfg80211: Loading compiled-in X.509 certificates for regulatory database
Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
clk: Disabling unused clocks
ALSA device list:
  #0: Dummy 1
  #1: Loopback 1
  #2: Virtual MIDI Card 1
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT4-fs (sda1): mounted filesystem b4773fba-1738-4da0-8a90-0fe043d0a496 ro with ordered data mode. Quota mode: none.
VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 26720K
Write protecting the kernel read-only data: 219136k
Freeing unused kernel image (rodata/data gap) memory: 1108K
x86/mm: Checked W+X mappings: passed, no W+X pages found.
x86/mm: Checking user space page tables
x86/mm: Checked W+X mappings: passed, no W+X pages found.
Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
Run /sbin/init as init process
page: refcount:1 mapcount:1 mapping:0000000000000000 index:0x7fffffffe pfn:0x13fe93
memcg:ffff888140adc000
anon flags: 0x17ff00000020008(uptodate|swapbacked|node=0|zone=2|lastcpupid=0x7ff)
raw: 017ff00000020008 0000000000000000 dead000000000122 ffff888030587001
raw: 00000007fffffffe 0000000000000000 0000000100000000 ffff888140adc000
page dumped because: VM_BUG_ON_PAGE(PageAnonNotKsm(page))
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 1, tgid 1 (swapper/0), ts 14891998308, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3129/0x3270 mm/page_alloc.c:3493
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4769
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 folio_alloc_mpol_noprof mm/mempolicy.c:2283 [inline]
 vma_alloc_folio_noprof+0x12e/0x230 mm/mempolicy.c:2314
 folio_prealloc+0x31/0x170
 alloc_anon_folio mm/memory.c:4738 [inline]
 do_anonymous_page mm/memory.c:4795 [inline]
 do_pte_missing mm/memory.c:3971 [inline]
 handle_pte_fault+0x2518/0x6830 mm/memory.c:5778
 __handle_mm_fault mm/memory.c:5921 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6089
 faultin_page mm/gup.c:1187 [inline]
 __get_user_pages+0x1b16/0x48d0 mm/gup.c:1485
 __get_user_pages_locked mm/gup.c:1751 [inline]
 get_user_pages_remote+0x31e/0xb60 mm/gup.c:2618
 get_arg_page+0x266/0x580 fs/exec.c:225
 copy_string_kernel+0x148/0x1f0 fs/exec.c:684
 kernel_execve+0x5e2/0xa50 fs/exec.c:1999
 try_to_run_init_process init/main.c:1394 [inline]
 kernel_init+0xed/0x2b0 init/main.c:1522
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page_owner free stack trace missing
------------[ cut here ]------------
kernel BUG at include/linux/page-flags.h:1134!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1-next-20241004-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:SetPageAnonExclusive include/linux/page-flags.h:1134 [inline]
RIP: 0010:folio_add_new_anon_rmap+0x14d3/0x1fe0 mm/rmap.c:1442
Code: ff 0f 00 00 0f 84 9e 02 00 00 e8 28 91 a9 ff e9 fa ec ff ff e8 1e 91 a9 ff 48 8b 3c 24 48 c7 c6 e0 ff 15 8c e8 3e 13 f5 ff 90 <0f> 0b e8 06 91 a9 ff 48 89 ef 48 c7 c6 a0 00 16 8c e8 27 13 f5 ff
RSP: 0000:ffffc90000067348 EFLAGS: 00010246
RAX: 3219d577e7cba600 RBX: 0000000000000001 RCX: ffffc90000066f03
RDX: 0000000000000003 RSI: ffffffff8c0adc40 RDI: ffffffff8c610f60
RBP: 0000000000000000 R08: ffffffff901d2caf R09: 1ffffffff203a595
R10: dffffc0000000000 R11: fffffbfff203a596 R12: 00000007fffffffe
R13: 1ffff1100614ca00 R14: ffff888030587001 R15: ffff888030a65078
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_anonymous_page mm/memory.c:4841 [inline]
 do_pte_missing mm/memory.c:3971 [inline]
 handle_pte_fault+0x4aec/0x6830 mm/memory.c:5778
 __handle_mm_fault mm/memory.c:5921 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6089
 faultin_page mm/gup.c:1187 [inline]
 __get_user_pages+0x1b16/0x48d0 mm/gup.c:1485
 __get_user_pages_locked mm/gup.c:1751 [inline]
 get_user_pages_remote+0x31e/0xb60 mm/gup.c:2618
 get_arg_page+0x266/0x580 fs/exec.c:225
 copy_string_kernel+0x148/0x1f0 fs/exec.c:684
 kernel_execve+0x5e2/0xa50 fs/exec.c:1999
 try_to_run_init_process init/main.c:1394 [inline]
 kernel_init+0xed/0x2b0 init/main.c:1522
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:SetPageAnonExclusive include/linux/page-flags.h:1134 [inline]
RIP: 0010:folio_add_new_anon_rmap+0x14d3/0x1fe0 mm/rmap.c:1442
Code: ff 0f 00 00 0f 84 9e 02 00 00 e8 28 91 a9 ff e9 fa ec ff ff e8 1e 91 a9 ff 48 8b 3c 24 48 c7 c6 e0 ff 15 8c e8 3e 13 f5 ff 90 <0f> 0b e8 06 91 a9 ff 48 89 ef 48 c7 c6 a0 00 16 8c e8 27 13 f5 ff
RSP: 0000:ffffc90000067348 EFLAGS: 00010246
RAX: 3219d577e7cba600 RBX: 0000000000000001 RCX: ffffc90000066f03
RDX: 0000000000000003 RSI: ffffffff8c0adc40 RDI: ffffffff8c610f60
RBP: 0000000000000000 R08: ffffffff901d2caf R09: 1ffffffff203a595
R10: dffffc0000000000 R11: fffffbfff203a596 R12: 00000007fffffffe
R13: 1ffff1100614ca00 R14: ffff888030587001 R15: ffff888030a65078
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

