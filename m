Return-Path: <linux-kernel+bounces-402602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA19C298A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E731F22AE1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF487581F;
	Sat,  9 Nov 2024 02:42:30 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95914438B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731120149; cv=none; b=PFZ34s8RHTsq4UjdxWtxLi4kuSnl7Cx63CkAFJtFhfwZm+3FEb2LkAcqcRo7m0+kxG4yyNdcFAI+EZgaiJH1D/UoHXLOqH5isWtC73+B3Ucl8WeVr4KNlyeJloWlckEn7qy6E7xsqiVReYYGQ6qgrSLZtSVgyXC2pHP40PsR0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731120149; c=relaxed/simple;
	bh=wA1VYEI8BNpgiaIqBy/M4RJmP5Q2tpsjN1f9DK3bVGQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JY5lvWqilTc//SgzUdcKAN/8WAVWhL5SZvWxmlumWtBmVXZWnZMAl+dMTm6x0ELUypcOxVU0psBGLt4KYon0aMoEW3R7gArwxp/lvfs+rrWesAfB6ji8p8VGQ0oAWaYKnNtmUtOJErabO2be3EpOFcpWofZPPmR1OPkcQKSMjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6c355b3f5so30329525ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 18:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731120147; x=1731724947;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NapeQfZdEOZA23KK4MZzlHL9K2BnlokyMdzzqWPJ3U=;
        b=PR131j4liu604SPd9ni0E3rLCJ4P2WpB3aGw1HOGauQxapWcKb0hKBOSSjLhk+JgCv
         YYkr735AL6bZ/avQO25bqMU9GBr/vt+deh4RpaRKqFoZuk8Os9pTZTvfkQr0ULicndZS
         dJ7JNBESOMi7K3pQ7kGYrhmHoN6En6Cc94VswBrcUcnOFwsfmBNkYG/qlxsnqfKaWPDZ
         5ipEafJC22SAQdW3Yb/9x7H6D097CxPyt55mP6IhmVrJmcCAPHVZNUltf0LEs1ZDmOpZ
         KVUMlEhmlN2BHMiP2EUt3lv8pqv9tnbBF1aC0k2kZEXjeoQwgYxyhNXPkCNyhu422HYN
         vuuA==
X-Forwarded-Encrypted: i=1; AJvYcCVNweIzWUdR2T4pQgesKtNLqMDbf5XwOyakL9xAgeUW62F3zaNAdk/yKec26XYkVVDwXOI77qRIldY/qMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHA7B+XpGcSc+9oSo64F5Vrbhhw8xxQurVF71k5szcsr7p0whH
	/EcQuphrZyvLnWI1bNHzbquek4YXssHor2vUE2hhAC6V5gGtbD084UMxYLlUZgEU2bqt6NxjvVu
	NA0UsKvVheH2ynA7gBHF6+NoPeyIyCtVSWTAongaipGcA9lyrQiFbQi8=
X-Google-Smtp-Source: AGHT+IGFHqo45XHLTXzittKnZ0Fe5W55Rug4VSxnLKO/SQeXsalZm1TWCTLkRSl5tE2ohSFTjkkSGiLyZ2+L4CW6rKc6lFSGqdT0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:3a6:b445:dc9e with SMTP id
 e9e14a558f8ab-3a6f198f219mr64887625ab.4.1731120147041; Fri, 08 Nov 2024
 18:42:27 -0800 (PST)
Date: Fri, 08 Nov 2024 18:42:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ecc13.050a0220.138bd5.0038.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11361d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fdf74cce377223b
dashboard link: https://syzkaller.appspot.com/bug?extid=8689d10f1894eedf774d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12348f40580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e7b587980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08456e37db58/disk-2e1b3cc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc957f7ba80b/vmlinux-2e1b3cc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7579fe72ed89/bzImage-2e1b3cc9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5903d7d7fe58/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
BUG: KMSAN: uninit-value in __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
BUG: KMSAN: uninit-value in rhashtable_lookup include/linux/rhashtable.h:646 [inline]
BUG: KMSAN: uninit-value in rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
BUG: KMSAN: uninit-value in bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
BUG: KMSAN: uninit-value in bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
BUG: KMSAN: uninit-value in bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:221
 rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
 rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
 bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
 bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:221
 bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:381
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable b205.i created at:
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
 bch2_copygc+0x15b3/0x58f0 fs/bcachefs/movinggc.c:221
 bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:381

CPU: 0 UID: 0 PID: 5796 Comm: bch-copygc/loop Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================
Kernel panic - not syncing: kmsan.panic set ...
CPU: 0 UID: 0 PID: 5796 Comm: bch-copygc/loop Tainted: G    B              6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x216/0x2d0 lib/dump_stack.c:120
 dump_stack+0x1e/0x30 lib/dump_stack.c:129
 panic+0x4e2/0xcf0 kernel/panic.c:354
 kmsan_report+0x2c7/0x2d0 mm/kmsan/report.c:218
 __msan_warning+0x95/0x120 mm/kmsan/instrumentation.c:318
 rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
 rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
 bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
 bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:221
 bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:381
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

