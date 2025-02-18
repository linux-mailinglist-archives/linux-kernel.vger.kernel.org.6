Return-Path: <linux-kernel+bounces-519941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966EA3A3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9923B2D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C007F270EB5;
	Tue, 18 Feb 2025 17:09:50 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82742246348
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898590; cv=none; b=fvF0VtNKBxGeW1f7mi2cmMIaDO9bOV03rdOeo5p73RvxfuBCSS8ijvalgKT4wy5rTTQVBkX2aISj0R+cnS5UGSLtj/6y8l7TsIF5iCCbHlwXrEwnGbCLWJ70XLg5cyFXXuIA/aRON/aMTvRSKgbYZjzPMTjMP2ds0UtHJMNVKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898590; c=relaxed/simple;
	bh=sBV/WcofJKam2IMsw/1jxc5PtZILhZ4nVzpPmFm1b+c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cpu0J9dKEPRlPWmNgGwn2II06EyAqkGmqhGc0+bI7/KYiRPHwULtx2esDuTcyD0ebQ/lQRQBESeZKIUM8t+L9W7QZpv4HzBjY+46OQ4De4aUtimbJiQRhtaAciLDoP9ZaZzGH/2Nmc6YYMAKuwfPaZyAeR1V1PiSvY/6eEPD/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d13fb2256fso41694855ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898587; x=1740503387;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QYzh5JNrD+POVaC/PLtYqyDylw1+68FYp4uLYraOsE=;
        b=GaIVrdIm70t1vrbw4aWhzcZoKRIkEvLkWJ2Zd8NPTTTMa3xrt0B08kW3IKLzNE5XQk
         RNSo4LR9IP2+6eI/sSAmSim7hXkl/LGhG8GKp1/AmzfT2ommewlygnrJlnjhijgw0LkL
         Wl51MrlvIiQJg50FwXD2pp617qovvo16DWdO9/6Wk2ltUybtfq4GorH2hsc1lgz9MFPF
         NLhaXvzoEQNPtIllf4JRq8LEdUPrxWVRJNmREsD+FR3s/obf+gFI4eD8jY15qqql8Cn+
         xxMP9FlmldtaVSD2arUkuM9u9WnFbcELhBqK+ts4JyObN21ourDcNYeJqLp2bva1lwZS
         TXew==
X-Gm-Message-State: AOJu0YxyM8i7zhN9KLT9ykCF+HRBdxdk+0lQYpeM1YbcxKwNb879W9fw
	LB/3Ejib/2TM5FxnEfR4HlkSLm2rRviT70MMHiqPeIWtXoaDvOy/bEwfVvrPkE0g9UOOTlJpdB/
	OA0ivyX3eZK+E/GTg768nZyKZIanLDF/WvCrtYn3vgI/oQhA+l6L28hDrIg==
X-Google-Smtp-Source: AGHT+IEbNI89s66FHO+zLaNxCriIFN2SCOBsHJdk5W/aGixCh7jCASOXP3N670Im63i9gSqpPJjPcmfz7ljsUaXbWC5qbE6/IGXP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:3d0:101e:4609 with SMTP id
 e9e14a558f8ab-3d2b535a908mr2752135ab.15.1739898587460; Tue, 18 Feb 2025
 09:09:47 -0800 (PST)
Date: Tue, 18 Feb 2025 09:09:47 -0800
In-Reply-To: <675d01e9.050a0220.37aaf.00be.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b4bedb.050a0220.6ca4a.0002.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [mm?] [bcachefs?] WARNING in lock_list_lru_of_memcg
From: syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [mm?] [bcachefs?] WARNING in lock_list_lru_of_memcg
Author: mmpgouride@gmail.com

#syz test

diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index e71b278672b6..80a0094be356 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -997,7 +997,7 @@ static int validate_bset_keys(struct bch_fs *c, struct btree *b,
               }
got_good_key:
               le16_add_cpu(&i->u64s, -next_good_key);
-               memmove_u64s_down(k, bkey_p_next(k), (u64 *) vstruct_end(i) - (u64 *) k);
+               memmove_u64s_down(k, (u64 *) k + next_good_key, (u64 *) vstruct_end(i) - (u64 *) k);
               set_btree_node_need_rewrite(b);
       }
fsck_err:

> On Feb 15, 2025, at 02:11, syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com> wrote:
> 
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    128c8f96eb86 Merge tag 'drm-fixes-2025-02-14' of https://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=148019a4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c776e555cfbdb82d
> dashboard link: https://syzkaller.appspot.com/bug?extid=38a0cbd267eff2d286ff
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12328bf8580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-128c8f96.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a97f78ac821e/vmlinux-128c8f96.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f451cf16fc9f/bzImage-128c8f96.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/a7da783f97cf/mount_3.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5459 at mm/list_lru.c:96 lock_list_lru_of_memcg+0x39e/0x4d0 mm/list_lru.c:96
> Modules linked in:
> CPU: 0 UID: 0 PID: 5459 Comm: syz-executor Not tainted 6.14.0-rc2-syzkaller-00185-g128c8f96eb86 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:lock_list_lru_of_memcg+0x39e/0x4d0 mm/list_lru.c:96
> Code: e9 19 fe ff ff e8 72 f2 b5 ff 4c 8b 7c 24 08 45 84 f6 0f 84 40 ff ff ff e9 22 01 00 00 e8 5a f2 b5 ff eb 05 e8 53 f2 b5 ff 90 <0f> 0b 90 eb 97 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 71 fd ff ff 48
> RSP: 0018:ffffc9000d70f3a0 EFLAGS: 00010293
> RAX: ffffffff820bc50d RBX: 0000000000000000 RCX: ffff8880382d4880
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff8880351ac054 R08: ffffffff820bc49f R09: 1ffffffff2079b8e
> R10: dffffc0000000000 R11: fffffbfff2079b8f R12: ffffffff820bc19e
> R13: ffff88801ee9a798 R14: 0000000000000000 R15: ffff8880351ac000
> FS:  000055557d70b500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff6826de40 CR3: 000000005680c000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> list_lru_del+0x58/0x1f0 mm/list_lru.c:202
> list_lru_del_obj+0x17b/0x250 mm/list_lru.c:223
> d_lru_del fs/dcache.c:481 [inline]
> to_shrink_list+0x136/0x340 fs/dcache.c:904
> select_collect+0xce/0x1b0 fs/dcache.c:1472
> d_walk+0x1f5/0x750 fs/dcache.c:1295
> shrink_dcache_parent+0x144/0x3b0 fs/dcache.c:1527
> d_invalidate+0x11c/0x2d0 fs/dcache.c:1632
> proc_invalidate_siblings_dcache+0x3fb/0x6e0 fs/proc/inode.c:142
> release_task+0x168e/0x1830 kernel/exit.c:279
> wait_task_zombie kernel/exit.c:1249 [inline]
> wait_consider_task+0x1a14/0x2e60 kernel/exit.c:1476
> do_wait_thread kernel/exit.c:1539 [inline]
> __do_wait+0x1b0/0x850 kernel/exit.c:1657
> do_wait+0x1e9/0x550 kernel/exit.c:1691
> kernel_wait4+0x2a7/0x3e0 kernel/exit.c:1850
> __do_sys_wait4 kernel/exit.c:1878 [inline]
> __se_sys_wait4 kernel/exit.c:1874 [inline]
> __x64_sys_wait4+0x134/0x1e0 kernel/exit.c:1874
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f93f3983057
> Code: 89 7c 24 10 48 89 4c 24 18 e8 45 1b 03 00 4c 8b 54 24 18 8b 54 24 14 41 89 c0 48 8b 74 24 08 8b 7c 24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24 10 e8 95 1b 03 00 8b 44
> RSP: 002b:00007fff6826e9b0 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
> RAX: ffffffffffffffda RBX: 0000000000000019 RCX: 00007f93f3983057
> RDX: 0000000040000001 RSI: 00007fff6826ea1c RDI: 00000000ffffffff
> RBP: 00007fff6826ea1c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000001388
> R13: 00000000000927c0 R14: 000000000002f011 R15: 00007fff6826ea70
> </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 


