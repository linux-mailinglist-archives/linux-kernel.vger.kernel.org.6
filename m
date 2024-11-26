Return-Path: <linux-kernel+bounces-422512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E79D9A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80791645B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724131D63E6;
	Tue, 26 Nov 2024 15:40:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912171CD219
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635630; cv=none; b=IF4dUIFzNd0xQXmqZLXpunEOMO0ecLA69FbzMdAqzE6xujSTAuWgjTtKJyxqNCIw2IwuBpcLACRruidsuUKA0Q4HdU1dQ2F3mcXXM7uaL8jn6GW9ibQXXKopP1SyQ0Z01qJsScNA+zx+mZaZFGNc8RJ09NXXBconzA5GpkguGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635630; c=relaxed/simple;
	bh=W8YjC2DyqMXnbXnURBuez3FEKX7yhXHR64tiytMcwo4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VIh9r/lKUFB5bYsgJpCRswnBbvHy8frCkWci5wjD3nkFskr22niNfwwW6KuIl05eukZemXyVch+FSCNAN0z8y7ZyXNk0L6cjXpvXHXbONrmAW4CoiK7ctAICyo1zUcgCnrcWEl0XU7K4d4T6nBScwUa8p4Rg7j1cwMU5+/xzVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a79039ae30so60242875ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 07:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732635627; x=1733240427;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4QBDfWEQeb8YUkuhnZ6Q5DhtW2P4YOASMyrlS+sQXg=;
        b=RXnRIxGarllogygqKQoSy7yM6eqns/5VDoOZAqxtgva+x8Pajh3l9by3v1rwGxkuLM
         smnXUiJqEJMW4Elmuus7DNT7D3pszgGfSwciNt9adPsMQkKxZDgiNFxyN8td9HCm9fl5
         eQuun866FRzwIMu25ffMYUNn8yqOo6QptJdm250LP+RvAQ+MOclkR4wTj23eo9Rq0ieS
         5FhaPne8eEmKokl7zqzoMCCEPVSXeOTD9zSBk1WM6FTU/VqVvPStWK/H1GnmYyHNlA9N
         rguxsDlWKBJFsSG/RCiQzOx6diMhDXVvLAyxxS5Rq2ZAqkusvJNpKTOwFlVoC1CBo8kq
         WAEA==
X-Forwarded-Encrypted: i=1; AJvYcCXJEJm+d3FGqk8LMxKHhVLoRdlXwSROu4c/fvadOCLJYMr/g5q62ROmvx5iTAHPSbT3Tq7nS9ZZxalQ2yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMx6qj72LetmEpORlP6md1qp291nynH/DAVQG/+K1QPNldD7fi
	I8nzMNlXTWUoEpVpXKLmpSbfSx/W23o7GwvSy9MFElfsH+Szzlaaw0vtf95oSMACyLrKLzj9J8I
	xRXJjuejJHFG1B2g7W1ecm2Y/xTWKo8i8O+PIq563GQFDdcQHi9WhEkE=
X-Google-Smtp-Source: AGHT+IHKDaAZbHO3wvggDIf5bxCayMcjPpK0wV3kgAF/t/qqDTCmnWW572bIUSIb+1qNzK8yrB7ay7zk+9Zzoptpa6FPqIwktPkC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:3a7:86ab:bebe with SMTP id
 e9e14a558f8ab-3a79af75dc2mr178942175ab.16.1732635627585; Tue, 26 Nov 2024
 07:40:27 -0800 (PST)
Date: Tue, 26 Nov 2024 07:40:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6745ebeb.050a0220.21d33d.001a.GAE@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in add_missing_indices
From: syzbot <syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28eb75e178d3 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ad3930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=b974bd41515f770c608b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3c9c97af7d9/disk-28eb75e1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e22f3d29103/vmlinux-28eb75e1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ff56ec30fa6/bzImage-28eb75e1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:2649:28
index -128 is out of range for type 'struct dtslot[128]'
CPU: 1 UID: 0 PID: 9494 Comm: syz.7.422 Not tainted 6.12.0-syzkaller-07749-g28eb75e178d3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 add_missing_indices+0x824/0xbf0 fs/jfs/jfs_dtree.c:2649
 jfs_readdir+0x1fc5/0x3c50 fs/jfs/jfs_dtree.c:3019
 wrap_directory_iterator+0x91/0xd0 fs/readdir.c:65
 iterate_dir+0x571/0x800 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:403 [inline]
 __se_sys_getdents64+0x1e2/0x4b0 fs/readdir.c:389
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbaf317e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbaf3f2d038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fbaf3335fa0 RCX: 00007fbaf317e819
RDX: 0000000000001000 RSI: 0000000020000f80 RDI: 0000000000000004
RBP: 00007fbaf31f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbaf3335fa0 R15: 00007fff928fc148
 </TASK>
---[ end trace ]---


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

