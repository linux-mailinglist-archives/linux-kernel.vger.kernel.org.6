Return-Path: <linux-kernel+bounces-426426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8E39DF2DD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 20:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1913228124B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51E1A76CD;
	Sat, 30 Nov 2024 19:55:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F16139579
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732996529; cv=none; b=FnuUeJAh5QEdLQMF7NSuSdBLqnYXqKCSYvho7Tm87HSjM9p4cjrD+iwVnFRnXziIKHHsf743xXg0uULeqWU/UTQIuYTecXK29RIJQWAEf0MGX+M5QgGxTkGcEm/yVjqy09ULHRFoJY51kqsuDAiRfPmw0v8bq4jc5H/a2QIS5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732996529; c=relaxed/simple;
	bh=8Xb8dc5W1OVfb4SyUJ2sRpNQaZyUdnqMowgn3Luzl1c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VbEWwgiDk91iG2zxwk1jgbaR8uzGCRqavGfK3oggVC7MyQueBQnPKU9YEDohVP2F4El/vFcULK+taEl4goUGP5LYG7W3O6Zek5WwSkLE09PSMdzEK5GGCFixyh23NAa0PogCHytlbkKorTI1gDyoo8gqgE8Y38VM6uaOCRWqIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a79afe7a0bso35570735ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 11:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732996527; x=1733601327;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3MGNedngZW8LYXo//0pHRzhZsyCDjUrOn5DgJSX8jM=;
        b=bs//SQxoWIoxWigjtVtF8SlX15Mc1MRI/Vtf2jVyEhCNIdzgnQwdD0yEFXR9H54Fnq
         I8F5/dEoxV+nI9aYUZ3EN2/uW/8YgXVa+cinzQ/Oeof4qpKANLDcecm8kG0z4bOL+HSE
         XWvA4QVHIrpmRjNAJgC/cPYEvTooZXPJqshbl7QZvQa98l1qQySNR+5ZmmUNFXupHKkk
         Mje5f/QmEw008VDj02rXvsbethgt9mEvx2ondP12LtYW0UzPkN1h096so7LWtY7VN37+
         XvYDxWQZm/HA2DJYEiO7lfnYM5sgWJpqX2bWqIgTZPlE8X07R8Lf7yg1TNGqdE2Pj3fi
         dY4A==
X-Forwarded-Encrypted: i=1; AJvYcCUGYsEZHG6HQCMTbzMq9ulV0K3dD1DHwkl6zke1GMV1QlamGnTH7o95tVP0KGBCWyskzSgQlTbv8+TRurk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxChc97b+OdnkBCdxmNb9pkVMiYz5YMUtcd82apU0zq8mTUZdgT
	YC76Oxihfkso74tdm5u2ZEXq5VzAK07/Z/WU+u2GsdXql3kgRZ4/ftkLRoEGBnkPJ/y+1YpBSe3
	ibEieIjTPpXMK+66DnoPhYjKN8LMeF2dUn4qlHpi82hLOnkUJwYzprMk=
X-Google-Smtp-Source: AGHT+IGtS0xTjRJDW15NrnI0Fzbu8Q0S9T3o0mti+BpuGsWzTtdgiZSdrEG68YEB5Zsgw2tDwMnPYbWzuAZIcT4c7yJ4QQYOOoV/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1786:b0:3a7:1bfc:97c6 with SMTP id
 e9e14a558f8ab-3a7c55d6862mr150481965ab.16.1732996526872; Sat, 30 Nov 2024
 11:55:26 -0800 (PST)
Date: Sat, 30 Nov 2024 11:55:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674b6dae.050a0220.253251.00e3.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_dirent_validate
From: syzbot <syzbot+652199d534e8c0a1c0ac@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7af08b57bcb9 Merge tag 'trace-v6.13-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167b4d30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d66c9f9a88c492bd
dashboard link: https://syzkaller.appspot.com/bug?extid=652199d534e8c0a1c0ac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c3165413ea6/disk-7af08b57.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdc591e3d285/vmlinux-7af08b57.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bef82d827bd2/bzImage-7af08b57.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+652199d534e8c0a1c0ac@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bch2_dirent_name_bytes fs/bcachefs/dirent.c:27 [inline]
BUG: KMSAN: uninit-value in bch2_dirent_get_name fs/bcachefs/dirent.c:37 [inline]
BUG: KMSAN: uninit-value in bch2_dirent_validate+0x5ee/0xc30 fs/bcachefs/dirent.c:107
 bch2_dirent_name_bytes fs/bcachefs/dirent.c:27 [inline]
 bch2_dirent_get_name fs/bcachefs/dirent.c:37 [inline]
 bch2_dirent_validate+0x5ee/0xc30 fs/bcachefs/dirent.c:107
 bch2_bkey_val_validate+0x2b5/0x440 fs/bcachefs/bkey_methods.c:143
 bset_key_validate fs/bcachefs/btree_io.c:841 [inline]
 validate_bset_keys+0x1531/0x2080 fs/bcachefs/btree_io.c:910
 validate_bset_for_write+0x142/0x290 fs/bcachefs/btree_io.c:1942
 __bch2_btree_node_write+0x53df/0x6830 fs/bcachefs/btree_io.c:2152
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2284
 btree_node_write_if_need fs/bcachefs/btree_io.h:151 [inline]
 __btree_node_flush+0x606/0x680 fs/bcachefs/btree_trans_commit.c:252
 bch2_btree_node_flush1+0x38/0x60 fs/bcachefs/btree_trans_commit.c:266
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:565
 __bch2_journal_reclaim+0xda8/0x1670 fs/bcachefs/journal_reclaim.c:698
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:740
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_u64s_small fs/bcachefs/util.h:393 [inline]
 bkey_p_copy fs/bcachefs/bkey.h:47 [inline]
 bch2_sort_keys_keep_unwritten_whiteouts+0x12d5/0x19d0 fs/bcachefs/bkey_sort.c:187
 __bch2_btree_node_write+0x3ae8/0x6830 fs/bcachefs/btree_io.c:2095
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2284
 btree_node_write_if_need fs/bcachefs/btree_io.h:151 [inline]
 __btree_node_flush+0x606/0x680 fs/bcachefs/btree_trans_commit.c:252
 bch2_btree_node_flush1+0x38/0x60 fs/bcachefs/btree_trans_commit.c:266
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:565
 __bch2_journal_reclaim+0xda8/0x1670 fs/bcachefs/journal_reclaim.c:698
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:740
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4238
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4255
 __do_kmalloc_node mm/slub.c:4271 [inline]
 __kmalloc_node_noprof+0xc96/0x1250 mm/slub.c:4289
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:650
 btree_bounce_alloc fs/bcachefs/btree_io.c:124 [inline]
 btree_node_sort+0x78a/0x1d30 fs/bcachefs/btree_io.c:323
 bch2_btree_post_write_cleanup+0x1b0/0xf20 fs/bcachefs/btree_io.c:2248
 bch2_btree_node_write+0x21c/0x2e0 fs/bcachefs/btree_io.c:2289
 btree_node_write_if_need fs/bcachefs/btree_io.h:151 [inline]
 __btree_node_flush+0x606/0x680 fs/bcachefs/btree_trans_commit.c:252
 bch2_btree_node_flush0+0x35/0x60 fs/bcachefs/btree_trans_commit.c:261
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:565
 __bch2_journal_reclaim+0xda8/0x1670 fs/bcachefs/journal_reclaim.c:698
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:740
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 0 UID: 0 PID: 6699 Comm: bch-reclaim/loo Not tainted 6.12.0-syzkaller-10689-g7af08b57bcb9 #0
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

