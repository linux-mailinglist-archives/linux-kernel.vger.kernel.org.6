Return-Path: <linux-kernel+bounces-429510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F6A9E2001
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B282AB3CCF2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE791EC013;
	Tue,  3 Dec 2024 13:08:31 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525F1B395E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231311; cv=none; b=sEdhYZM6o0y6QyxyPce7Wr4RRyQY9py9nRVXGkmNUhQGNb+ICZRfwf/AahlDPBhwgCOfVRWvzHLd06sUk6WSr+KeRdiHHS4/TYdVL1ZqRCYu/EIVf4tJ4bQW+ykS51nFXFIGGKscaaAw9jEl8rQwvrRodftZHoe1QEwZgGiKVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231311; c=relaxed/simple;
	bh=vGDZ5a1Q9Hh9JgMzGSHw4TZBkZV536Fv41g6ORIPJlc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t8gmiBnHmLvippBE266JgbPnyN6UK3Ga8gg4Ln/w3XVjXlZgo1q2cSxtDSIItJ+7npCT9ddpnbRwatFJ0R9hpu8zzrysQLscP7MhIh1S+qdAeVuP1KGO0KPledHgfS6xt9+8RkvaCcLM8IZOIDvbJA7pX9OqHmZUP2TN/cf8I28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7a5031e75so55239995ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231308; x=1733836108;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBb0U+F+KUxkPpCJ5iyX5UXZFFi1a97FCbwzdF+xKEQ=;
        b=wKkEix0komnAbhr2rW9vpx+I1IiU9K6LrTgnJhpmQY1JpBmkL36zuvvYkKVc4VtaUP
         srv1VPnMP/iFoPrUFc9Yrc+wLjUimNwlodctbV3AvIYtxfLaZ8ntsR+5pTmsZ67F7FLX
         XgGS7CQ/YV+RexYOXnTtyFLipJB0HAlPj8UwqfWKYU2O0ga8/Z+q6fJsSQZ/pRq0csvz
         HZNDI2UmDsXgK55FHC5JBVAk0nLYUAdVC4SZOy3FS66bFRLX5kL5yyaki6t/FhFk+B3W
         EsxsG348SuY/C8SYA8L1bNl6gginI4wpurPcFBXg9r0dLRHK/1yc1BSQCejX4I3mVrHT
         8E6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsusQI6ESynEBAsJejXSYc/DVEVA51oRTpLL6jGhx8BN/W8hBTpK01gcXDnFW0y3FY0ecru0mjChbDoq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjo2yMg3tJ+saiLjWDV0w/f06yStiwi0U6xnOWqfSLtDhQ5p/j
	ncEuwNqz4ss3cA4lGEH6dKThzIK9ICrcn60Qyo2WVLBOK19bI4YSAKDNfV3k/aKkTNoaKGWVX9Q
	thq+i1TcnFBfWNQnO1MAkAzC0tJ3WM1iwt3RWYfYs+YsJSORyn7ICY4U=
X-Google-Smtp-Source: AGHT+IFE1XaMIZwc0ANnN4ty/B6qkOve2dzXO0FRwxgcrzg8DdT0Mma8qxYQttomDT18tktWvnM0iwPtbPO0L51Pm4tUX4khNs+f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe7:b0:3a7:e436:5e00 with SMTP id
 e9e14a558f8ab-3a7f9a558c8mr30345085ab.14.1733231307978; Tue, 03 Dec 2024
 05:08:27 -0800 (PST)
Date: Tue, 03 Dec 2024 05:08:27 -0800
In-Reply-To: <67436e63.050a0220.1cc393.0048.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f02cb.050a0220.48a03.0037.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in flush_tlb_func
From: syzbot <syzbot+2f32bc207cbe5ca4b7a2@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f24330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=2f32bc207cbe5ca4b7a2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c16fc0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beb58ebb63cf/disk-f486c8aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b241b5609e64/vmlinux-f486c8aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9d817f665f2/bzImage-f486c8aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f32bc207cbe5ca4b7a2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6867 at arch/x86/mm/tlb.c:817 flush_tlb_func+0x631/0x700 arch/x86/mm/tlb.c:817
Modules linked in:
CPU: 0 UID: 0 PID: 6867 Comm: syz.0.220 Not tainted 6.12.0-next-20241128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:flush_tlb_func+0x631/0x700 arch/x86/mm/tlb.c:817
Code: e9 16 fb ff ff 90 0f 0b 90 e9 76 fb ff ff 45 31 f6 49 bc 00 00 00 00 00 fc ff df e9 53 ff ff ff 90 0f 0b 90 e9 8f fc ff ff 90 <0f> 0b 90 e9 a8 fc ff ff 90 0f 0b 90 e9 d5 fb ff ff 90 0f 0b 90 e9
RSP: 0018:ffffc9000bba66c0 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff8880b863d7c0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88802887ae88
RBP: ffffc9000bba67b0 R08: ffff88802887ae8f R09: 1ffff1100510f5d1
R10: dffffc0000000000 R11: ffffed100510f5d2 R12: 1ffff110170c7afb
R13: 00000000000000f2 R14: 00000000000000f1 R15: ffff8880b863d7d8
FS:  00007f9f571dd6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000003394a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 csd_do_func kernel/smp.c:134 [inline]
 smp_call_function_many_cond+0x1760/0x2c60 kernel/smp.c:875
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1051
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:939 [inline]
 flush_tlb_mm_range+0x329/0x5c0 arch/x86/mm/tlb.c:1025
 flush_tlb_page arch/x86/include/asm/tlbflush.h:254 [inline]
 ptep_clear_flush+0x11a/0x170 mm/pgtable-generic.c:101
 page_vma_mkclean_one+0x58a/0x9a0 mm/rmap.c:1051
 page_mkclean_one+0x280/0x420 mm/rmap.c:1092
 rmap_walk_file+0x52f/0x9f0 mm/rmap.c:2708
 rmap_walk mm/rmap.c:2726 [inline]
 folio_mkclean+0x262/0x440 mm/rmap.c:1124
 folio_clear_dirty_for_io+0x22b/0xd00 mm/page-writeback.c:3033
 mpage_submit_folio+0x88/0x230 fs/ext4/inode.c:1913
 mpage_process_page_bufs+0x6c9/0x8d0 fs/ext4/inode.c:2045
 mpage_prepare_extent_to_map+0xec7/0x1c80 fs/ext4/inode.c:2546
 ext4_do_writepages+0xc4d/0x3d10 fs/ext4/inode.c:2688
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
RIP: 0033:0x7f9f57f7ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9f571dd058 EFLAGS: 00000246 ORIG_RAX: 000000000000001a
RAX: ffffffffffffffda RBX: 00007f9f58146160 RCX: 00007f9f57f7ff19
RDX: 0000000000000004 RSI: 087abbe8d1cc6ad9 RDI: 0000000020952000
RBP: 00007f9f57ff3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9f58146160 R15: 00007ffe71c92b58
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

