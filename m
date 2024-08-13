Return-Path: <linux-kernel+bounces-284379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7204C950057
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B7E2854DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5C17BB2F;
	Tue, 13 Aug 2024 08:50:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401F13B797
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539028; cv=none; b=IM77D2jg9LCL7YMkWm8+zMd+sWETUOmenFIF4RPTBdCXiDMYV9eSBxFGM15yVEtH6vTrxjSDZfdm+Ppbd4n9no1Njjx6FhXC74KLi6S+3HmFyJygThv3Y1/aqGxApYcrFu4NGwDqTQjbJA+jVWLtV4JF1ddKE+r03xLeeo6gRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539028; c=relaxed/simple;
	bh=4NxmO5ltZeGQXiAiJ+EcFxxc4454ZV8oqjSBB8jhoUU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BZOkJ1OrGHIgpcPPUj2gO1CJswT+PtCzjfpQ3MT0yoxMaU09+EhjrZ6nCe6vKQeyuXoiQTL2i+xbQqhUbVjwTRscRt0YDbweXtJpr0J+g+Upu9R49OkPXnjQk9r6eWAPxYI5nzhE7L5E/tS8NeSqRkg0ZJ2+eVe+pIlhBjM45hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b3cd1813aso64533375ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539026; x=1724143826;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBikLu0ZlOFa2v3oX/TYYq/extNaQfM31RVjvKEWsIQ=;
        b=NtsT43xEjK6AT16a30DH8790PGMPlsSbJOBGYTMR2Tvd6AQblffgbsamRQ0cF0q/rD
         QpuDvVX7mLr+Irmz7a2EqV7X09T2mBCciZSV6UiC9lS3fyL9DTV3n9bNu5l4xo5NOzW1
         AgSILqAHtnNHPUog+eUKLc2wWw+Dt6jxEx/7DK7aigAG26P55/BzQZoYW/hs5VepPNcd
         FAFK6+v7wFcpS8ROd6xrkG2LQtyTis/ZSfjcgSel8bXTXNRU2GMbIO+d660oAMhMuEjs
         HS8Ib4gKBdSDdYqM/unUFKyymnSXC0A7XCFZ+BfGUB1vcqqbpIOM7tof+BHhsuRRtDiS
         EGqw==
X-Forwarded-Encrypted: i=1; AJvYcCUFAGgzKxQ2nZT6zQVqkip/z+BKQUyx4QE1E7X0so/A+roJH9m1eAoHfzHoEMNeqMaaUHKIZt3LQcdwbtTr7FGjsSWiymgl73ACL6xv
X-Gm-Message-State: AOJu0YxqWwAYbIP/LuaFhvFZpH4piPKjcqvM6zFeWTm0PmbzH9Se5ZVC
	Ml9bk9P2VBfsd5IhND3L1XTIE6INsgCsqKDRiC/ux3jZ4mSV9sWQ0VwtYQx8xSNhzaOihq1gB9k
	/SBo82hcvHeoOiBj/zz+Jwth6oNKEKnQ79FOSKZgmrZ0jGJHjDHti1Oo=
X-Google-Smtp-Source: AGHT+IHYxS103QZdmH3b7TXqaMAVbjPo6XDAuJtWEeoQgNjF1CF4ijZnDdHSkyv84sjVMvE9W77gSKD9GSuNyCucrLaRmEKy0p4Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:397:b509:6441 with SMTP id
 e9e14a558f8ab-39c4783ec8fmr1455185ab.2.1723539025616; Tue, 13 Aug 2024
 01:50:25 -0700 (PDT)
Date: Tue, 13 Aug 2024 01:50:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060ef65061f8cb3d4@google.com>
Subject: [syzbot] [bcachefs?] Unable to handle kernel execute from
 non-executable memory at virtual address ADDR
From: syzbot <syzbot+8798e95c2e5511646dac@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c912bf709078 Merge remote-tracking branches 'origin/arm64-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11028061980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35545feca25ede03
dashboard link: https://syzkaller.appspot.com/bug?extid=8798e95c2e5511646dac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/caeac6485006/disk-c912bf70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/501c87f28da9/vmlinux-c912bf70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6812e99b7182/Image-c912bf70.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8798e95c2e5511646dac@syzkaller.appspotmail.com

Unable to handle kernel execute from non-executable memory at virtual address ffff0000f1a56540
KASAN: maybe wild-memory-access in range [0xfffc00078d2b2a00-0xfffc00078d2b2a07]
Mem abort info:
  ESR = 0x000000008600000f
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x0f: level 3 permission fault
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001aca1d000
[ffff0000f1a56540] pgd=0000000000000000, p4d=180000023ffff003, pud=180000023f41b003, pmd=180000023f28d003, pte=0068000131a56707
Internal error: Oops: 000000008600000f [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6849 Comm: bch-reclaim/loo Not tainted 6.10.0-rc7-syzkaller-gc912bf709078 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0xffff0000f1a56540
lr : __bch2_increment_clock+0x45c/0x4f8 fs/bcachefs/clock.c:152
sp : ffff8000a06c6510
x29: ffff8000a06c6540 x28: ffff0000f5200000 x27: dfff800000000000
x26: ffff0000f5204b78 x25: ffff0000f5204b80 x24: 0000000000000001
x23: ffff0000eb1e1008 x22: ffff0000f5204b30 x21: ffff0000f5204b18
x20: ffff8000a0417620 x19: ffff8000a0417620 x18: 1fffe000367a85de
x17: ffff80008f2dd000 x16: ffff80008032d32c x15: 0000000000000001
x14: 1fffe000367ab200 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 0000000000000001
x8 : ffff0000f1a56540 x7 : ffff8000802a3bb0 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000007 x1 : ffff80008b2c0360 x0 : ffff8000a0417620
Call trace:
 0xffff0000f1a56540
 bch2_increment_clock fs/bcachefs/clock.h:19 [inline]
 bch2_btree_node_alloc+0x874/0xd9c fs/bcachefs/btree_update_interior.c:427
 bch2_btree_node_alloc_replacement+0xf4/0x904 fs/bcachefs/btree_update_interior.c:448
 btree_split+0x1530/0x4c84 fs/bcachefs/btree_update_interior.c:1662
 bch2_btree_split_leaf+0x148/0x734 fs/bcachefs/btree_update_interior.c:1857
 bch2_trans_commit_error+0x2a4/0x1068 fs/bcachefs/btree_trans_commit.c:918
 __bch2_trans_commit+0x35e4/0x592c fs/bcachefs/btree_trans_commit.c:1138
 bch2_trans_commit fs/bcachefs/btree_update.h:170 [inline]
 wb_flush_one_slowpath+0x114/0x158 fs/bcachefs/btree_write_buffer.c:126
 wb_flush_one+0x870/0xd88 fs/bcachefs/btree_write_buffer.c:168
 bch2_btree_write_buffer_flush_locked+0x1200/0x243c fs/bcachefs/btree_write_buffer.c:347
 btree_write_buffer_flush_seq+0x6d0/0x7e8 fs/bcachefs/btree_write_buffer.c:442
 bch2_btree_write_buffer_journal_flush+0x58/0x94 fs/bcachefs/btree_write_buffer.c:457
 journal_flush_pins+0x524/0xa10 fs/bcachefs/journal_reclaim.c:553
 __bch2_journal_reclaim+0x71c/0x1024 fs/bcachefs/journal_reclaim.c:685
 bch2_journal_reclaim_thread+0x154/0x4b8 fs/bcachefs/journal_reclaim.c:727
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: ffffffff ffffffff 00000000 00000000 (ffffffff) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	ffffffff 	.inst	0xffffffff ; undefined
   4:	ffffffff 	.inst	0xffffffff ; undefined
* 10:	ffffffff 	.inst	0xffffffff ; undefined <-- trapping instruction


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

