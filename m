Return-Path: <linux-kernel+bounces-420235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7B9D773D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 19:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D8C161F56
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D07D13774D;
	Sun, 24 Nov 2024 18:20:22 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCE3201
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732472422; cv=none; b=FwdpGj0bpPo8isABdqqI6+kCW2hf5cI1xbNUDeTkQn7ICfF6iH0pRUgIL0FgsAjp+xjRoZVlsN5oCwo84AawXNJ11g0bCYK23DVldLdYcqQBDfGENOcGwcNti8bZJwPIxwYoEF8+Tu9G4R2cvomNxFnRC2UVJFNNbhIoXnHL2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732472422; c=relaxed/simple;
	bh=A/o+t7X5zW6prUgnMbzv7u7tC3FBzrjA/KB/3rYLB44=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JdcPFMrw+S2WcmOrCNv5vgp/Ls2UPQ2BMmsTFgoUOJGdnIv2daD1KzDDjAiduml2L4pBoOnFZzmXlmD2au02DP8rk/6mRMVcJVEVPIwGhGGgKBq+5tzfgjKqinN6jrvkofiDaxiRFPAZFcw6G4uMCU9dhbb9vNcd4YdHaT1nncQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a778ce76fbso43027995ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732472420; x=1733077220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/6Vq4W8NwunC2xKF+nMlvwvY5rpDEJHKxrND8ruiEQ=;
        b=nwNB/0w812LMm94eEUpiJEK5R0a/64NRFX3F47rjtgmLjsLqTHbY+w10LfcmBY4hpK
         gzHlqmNB6HlAuAlR757gxjKTBleOyt/y6zqxHWAQcxlgqWCVNehs0ZEPdvul1h1uaPyE
         UCsD+rWF5pJft54CLtI2Da/f978Mipjy5w6KQUHQQmF0PSKZtj412I3vT3PBC2F7dIgy
         0ad8buDIu+vepJsI6orF3dfgDeckj/uVCOS44O2gwOHMZMTbPd3k4lAT8CDiWSqSbiwG
         rw/KNsF2vkMMtT2BiGE0phNiLu89Kr1xw0nQ5DXtXzCGyC/LfiPP4z1V0r8iQJxTEzT+
         O44w==
X-Forwarded-Encrypted: i=1; AJvYcCVkYvjQmDoeNqVrJz/Rs9/uiyiWcMTkGv0s0z78p4hg3R5ORLt/X+FBd+WUGODYxyAgwjsORSq8EzjB+AM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZbykcO4VfoJ3qfZmzV+oHtBiHEcE47gwVc4xY8g2TGSl3A4u
	Tf+BijGHRVnOZaBs+NAFxm4x7OfHFbX123qtDcdahtWetwYKHciekiI1ItxRLtL3g4Yz3iLkroZ
	4RxRZfyRYSdoxuiSjRHW+8b5sh1PS/rISCjxO1KnvN3LouxI1NjyEvbc=
X-Google-Smtp-Source: AGHT+IG63NQKW5l+TFX3jZ1P9X6G+vCMEPT25pCVvIGcSsHpff6grHN2h1picU+rHRJ3rT596QJmZZlXQ5ep6XKBEs6DLg8x9iGm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c9:b0:3a7:8720:9dec with SMTP id
 e9e14a558f8ab-3a79acf154dmr89172995ab.2.1732472419826; Sun, 24 Nov 2024
 10:20:19 -0800 (PST)
Date: Sun, 24 Nov 2024 10:20:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67436e63.050a0220.1cc393.0048.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in flush_tlb_func
From: syzbot <syzbot+2f32bc207cbe5ca4b7a2@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac24e26aa08f Add linux-next specific files for 20241120
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=136a1930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=2f32bc207cbe5ca4b7a2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c6bcf3605c7/disk-ac24e26a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ce96eb398a9/vmlinux-ac24e26a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a22aac22c90/bzImage-ac24e26a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f32bc207cbe5ca4b7a2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5987 at arch/x86/mm/tlb.c:816 flush_tlb_func+0x631/0x700 arch/x86/mm/tlb.c:816
Modules linked in:
CPU: 0 UID: 0 PID: 5987 Comm: syz.4.29 Not tainted 6.12.0-next-20241120-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:flush_tlb_func+0x631/0x700 arch/x86/mm/tlb.c:816
Code: e9 16 fb ff ff 90 0f 0b 90 e9 76 fb ff ff 45 31 f6 49 bc 00 00 00 00 00 fc ff df e9 53 ff ff ff 90 0f 0b 90 e9 8f fc ff ff 90 <0f> 0b 90 e9 a8 fc ff ff 90 0f 0b 90 e9 d5 fb ff ff 90 0f 0b 90 e9
RSP: 0018:ffffc900044fea20 EFLAGS: 00010016
RAX: dffffc0000000000 RBX: ffff8880b863d7c0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8880290b9a88
RBP: ffffc900044feb10 R08: ffff8880290b9a8f R09: 1ffff11005217351
R10: dffffc0000000000 R11: ffffed1005217352 R12: 1ffff110170c7afb
R13: 000000000000001a R14: 0000000000000019 R15: ffff8880b863d7d8
FS:  00007fcd5b0116c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8e8dc656c0 CR3: 000000005fae2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 csd_do_func kernel/smp.c:134 [inline]
 smp_call_function_many_cond+0x1760/0x2ca0 kernel/smp.c:875
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1051
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:938 [inline]
 flush_tlb_mm_range+0x329/0x5c0 arch/x86/mm/tlb.c:1024
 flush_tlb_page arch/x86/include/asm/tlbflush.h:254 [inline]
 ptep_clear_flush+0x11a/0x170 mm/pgtable-generic.c:101
 page_vma_mkclean_one+0x58a/0x9a0 mm/rmap.c:1051
 page_mkclean_one+0x280/0x420 mm/rmap.c:1092
 rmap_walk_file+0x52f/0x9f0 mm/rmap.c:2708
 rmap_walk mm/rmap.c:2726 [inline]
 folio_mkclean+0x262/0x440 mm/rmap.c:1124
 folio_clear_dirty_for_io+0x22b/0xd00 mm/page-writeback.c:3033
 mpage_submit_folio+0x88/0x230 fs/ext4/inode.c:1913
 mpage_map_and_submit_buffers fs/ext4/inode.c:2178 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2310 [inline]
 ext4_do_writepages+0x1d15/0x3d10 fs/ext4/inode.c:2735
 ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2824
 do_writepages+0x35f/0x880 mm/page-writeback.c:2702
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 file_write_and_wait_range+0x2a3/0x3c0 mm/filemap.c:787
 ext4_sync_file+0x25d/0xb90 fs/ext4/fsync.c:158
 __do_sys_msync mm/msync.c:96 [inline]
 __se_sys_msync+0x3d7/0x5a0 mm/msync.c:32
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd5a17e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcd5b011038 EFLAGS: 00000246 ORIG_RAX: 000000000000001a
RAX: ffffffffffffffda RBX: 00007fcd5a335fa0 RCX: 00007fcd5a17e819
RDX: 0000000000000004 RSI: 087abbe8d1cc6ad9 RDI: 0000000020952000
RBP: 00007fcd5a1f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fcd5a335fa0 R15: 00007ffc671020c8
 </TASK>


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

