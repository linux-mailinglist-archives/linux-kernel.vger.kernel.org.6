Return-Path: <linux-kernel+bounces-399026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1559BF9B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E4E9B226C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374F920C493;
	Wed,  6 Nov 2024 23:12:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8820C486
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934749; cv=none; b=fAI0WjCMN9q76eF0qzmhFDNXZ0zQUfniy6AMfF+aVRv83NfXhgIC93pH+jCTpv67oUe5WikPW2lcw7gvCF4rbauHT+y1dRmtebOIzGIZer3USvjXHRpFLY0qUtQtNW5jcPtdRn/eTnDR6xhGeXCZ09zgghiWvnJg3rSqMnvNjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934749; c=relaxed/simple;
	bh=BnA8H12WoqDL9sMC9X8zqhu57ttpVx929RSSSfMezwY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lmrt6cjdh1MPCuHAlZUI7HKfAnliLeTFYAJDrm/N8jD1mmESVnOiKGKMG7Wggz+FJ3Fm4HFltxCoqPRPiSOTUK60mP4kdQRGGlU+zl+CJxdQAF9x4CXLiROcJoorVit9vsv0vTx70VZBQzSQIOY8/rwU57liBiwA3IfjU+fHftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ac354a75fso53932239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 15:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730934747; x=1731539547;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2JEHNRaZMql+LRZzHBXb/M0b0iGfEmv5xlZNDfZIP0=;
        b=XWSeOoj70gpikz4iNycy+hvbfJoNAkXNa5+zOmmRK7/HXBBiNT/U/e9833u02mMJTg
         um3cYY8SPxAhtc0638AnlnI1pK4HRyJiItKhD9r4tGFXNxxlQEphEezy+quEbH7ZO8fQ
         xWPBl2SnE8/UgfSzYzkwYuh5o0rzP3tHgdqEqrwvW2kTBs4S6w/Ngdsfe9iATOpm0fNL
         PzSkStvxQdjZf3tGws/ApsWjsYYYaG1gcWd6oR/LdfE1UqnOuAtYdVDmULMjT0xGFZET
         hw6l11oK7GvNkazpVYX/QepcUB6QO7ykBNVRJiObHrHvUBrEtjuZzmj6WHGQS/yl3BAu
         bYlA==
X-Forwarded-Encrypted: i=1; AJvYcCXeg62NDxazKPXNpGK5AIBhByIk9biiqIZQvvQGp1MmhOSTLxotshLgZPqvZo9v9WBADdFB/enXmxNfW5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5m2GgQL471B4JQa6SdAKXvFkhsLWdSv1Ss3qcTQYlQS5D4J9
	WQLV8ANCBF8ZHRJu9LrSF38G8YM9uPwWfYW/LLgsF2B1FI5lGG0vqwUKw/yiQg+/UXSWZANIVOW
	CtojwYpYcPRBPuDuGFWCSQk+u7PL/4uN3m34gSmTMIhIoi2lw2UwvbnQ=
X-Google-Smtp-Source: AGHT+IFuJ5A+40gYI2Kk2aX3lTJiJ1nGb0W5AeuhwrmJ23F6Sza+q3IdneGxLDBZY3Y1u2MfFC804Im0V/Ll5mBgGxlsolIi4fhe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:3a3:e58d:cfe3 with SMTP id
 e9e14a558f8ab-3a6b027981dmr230612915ab.8.1730934747390; Wed, 06 Nov 2024
 15:12:27 -0800 (PST)
Date: Wed, 06 Nov 2024 15:12:27 -0800
In-Reply-To: <67253f50.050a0220.35b515.0179.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672bf7db.050a0220.350062.0281.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_reserve_suballoc_bits
From: syzbot <syzbot+fd05de09d1267725aa95@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7758b206117d Merge tag 'tracefs-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100d76a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=fd05de09d1267725aa95
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17984d87980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13745f40580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7758b206.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2bb57fc511dd/vmlinux-7758b206.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3cbc90748c2/bzImage-7758b206.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/6240dda90037/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/ee2f9e0a7c70/mount_8.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd05de09d1267725aa95@syzkaller.appspotmail.com

(syz-executor421,5309,0):ocfs2_prepare_inode_for_write:2273 ERROR: status = -30
(syz-executor421,5309,0):ocfs2_file_write_iter:2452 ERROR: status = -30
------------[ cut here ]------------
kernel BUG at fs/ocfs2/suballoc.c:804!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5309 Comm: syz-executor421 Not tainted 6.12.0-rc6-syzkaller-00099-g7758b206117d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_reserve_suballoc_bits+0x479b/0x4eb0 fs/ocfs2/suballoc.c:804
Code: e1 07 80 c1 03 38 c1 0f 8c 75 dd ff ff 48 8d bc 24 b0 01 00 00 e8 b5 b9 68 fe e9 63 dd ff ff e8 3b 4f 31 08 e8 e6 f2 fe fd 90 <0f> 0b e8 de f2 fe fd 48 c7 c7 20 ad e3 8e 48 8b 74 24 28 48 89 da
RSP: 0018:ffffc9000d0463c0 EFLAGS: 00010293
RAX: ffffffff8395e77a RBX: 00000000ffffffff RCX: ffff88801f0fc880
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc9000d0468b0 R08: ffffffff8395a255 R09: 1ffffffff203a11d
R10: dffffc0000000000 R11: fffffbfff203a11e R12: 1ffff92001a08cf8
R13: ffff888033156700 R14: ffff8880405a7e00 R15: dffffc0000000000
FS:  0000555588c64380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056114eea6000 CR3: 000000003a6b6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_reserve_cluster_bitmap_bits+0xc5/0x1d0 fs/ocfs2/suballoc.c:1132
 ocfs2_local_alloc_reserve_for_window fs/ocfs2/localalloc.c:1125 [inline]
 ocfs2_local_alloc_slide_window fs/ocfs2/localalloc.c:1261 [inline]
 ocfs2_reserve_local_alloc_bits+0x95e/0x2870 fs/ocfs2/localalloc.c:669
 ocfs2_reserve_clusters_with_limit+0x1b8/0xb60 fs/ocfs2/suballoc.c:1166
 ocfs2_convert_inline_data_to_extents+0x29d/0x17f0 fs/ocfs2/alloc.c:7078
 ocfs2_try_to_write_inline_data fs/ocfs2/aops.c:1561 [inline]
 ocfs2_write_begin_nolock+0x1c7b/0x4ec0 fs/ocfs2/aops.c:1668
 ocfs2_write_begin+0x205/0x3a0 fs/ocfs2/aops.c:1902
 generic_perform_write+0x344/0x6d0 mm/filemap.c:4054
 ocfs2_file_write_iter+0x17b1/0x1f50 fs/ocfs2/file.c:2467
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f986bf8f1b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffaa60abc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000204e RCX: 00007f986bf8f1b9
RDX: 0000000000000048 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f986c00c610 R08: 000000000000000a R09: 00007fffaa60ad98
R10: 00000000fffffa00 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffaa60ad88 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_reserve_suballoc_bits+0x479b/0x4eb0 fs/ocfs2/suballoc.c:804
Code: e1 07 80 c1 03 38 c1 0f 8c 75 dd ff ff 48 8d bc 24 b0 01 00 00 e8 b5 b9 68 fe e9 63 dd ff ff e8 3b 4f 31 08 e8 e6 f2 fe fd 90 <0f> 0b e8 de f2 fe fd 48 c7 c7 20 ad e3 8e 48 8b 74 24 28 48 89 da
RSP: 0018:ffffc9000d0463c0 EFLAGS: 00010293
RAX: ffffffff8395e77a RBX: 00000000ffffffff RCX: ffff88801f0fc880
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc9000d0468b0 R08: ffffffff8395a255 R09: 1ffffffff203a11d
R10: dffffc0000000000 R11: fffffbfff203a11e R12: 1ffff92001a08cf8
R13: ffff888033156700 R14: ffff8880405a7e00 R15: dffffc0000000000
FS:  0000555588c64380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056114eea6000 CR3: 000000003a6b6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

