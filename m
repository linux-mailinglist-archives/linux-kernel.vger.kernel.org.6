Return-Path: <linux-kernel+bounces-292040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C58E956A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D932841A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6537316B754;
	Mon, 19 Aug 2024 12:06:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B33216B74D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069164; cv=none; b=ffVrdz2zEXi5Xna9ehoO5qSABo2il2Xa6RkH41o3Ippwzsjz7d0Zf6nTKe9c7ghgluum83YLxrQCboUBENYIg0PoTcf0tJwjkJzv8sC5Y7/u4p7UHaxRlv77A/jKYvAQ3zsHmJVeKf9SIY2UAGA0avneDqI3My6MOEIsa7MU9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069164; c=relaxed/simple;
	bh=o2UdLZb9J4fCLkUdnezpS1wHU22qlAJcCMwWg28uq8Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rDbxHTCiKGNtYBoAiPdbAzoXuPGPiMxGEWcNHXv4LfhZQZGe7Kc1AFLLgUOlQ2Iv9d7aOPRB95Hv5RrZrSmlqXXtzsPv9cYr7Vj5io7dKO9tSgbh9cpYH5CSs4L8tACDz/F8gVGskiOxlsWZBKjgd7mldXaa/rDDhbAniMc6JIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d2044b532so36435895ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069162; x=1724673962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tt6WQZWM8gG2fOMf310V8ocdP34nI2krd59lTp6udA=;
        b=Eaw0A7dJQzec4XbCJoURz/CIP37CNYO6R1g+QzIrUxrmijW1om/6Ixw8T5TACrTcq6
         wB8X0CePNoedOLsBLZfdR3mN/es34aA8gX6f9Gmy+K6vl5xkS2XbUwF12V9aRfwHbdCm
         mYjDyeBseUydcCkTtMbEgI0EjOhh9hI6TIrCKm1/ok9iFPSoLWNVpH9AyT8+NNpwB4bu
         vA/ktKTeZR3G7xdWdXL4UCnsT8Pq2vlQIkJ94jYvg3ha1CVovxB4dmwPoUwW2QKP4gAX
         TtGfXqT/Z8xvkmSxrYgcMPui46o5lKbE0cjaR90Yd/tRtBTMavPuUM/lsZayKJ8AXRtS
         59oA==
X-Forwarded-Encrypted: i=1; AJvYcCXR2Pno8/KSRFrzeryYgzgoEvdjXtXQoFqVuwcJ7VIrtrS2/eK0Ft3fBkpUNplRqm2s7e5NoM3HGE2xTZiD7vlwlU9rtiIQI2XZK4pZ
X-Gm-Message-State: AOJu0YxrdFsh+t+kRLdfJtnoJsEcrsZXnAC4GAmJHCKqKqWAGmE0ffU0
	CNVtNobHg7SNe0IPwZMo8YKA8Tj8WKEE590EZy78PNVQso++648yfs33UGtzqH762D2e2oWMMJv
	Gc1fKFoXf4AEUQDplJP+rxIlefxTMWhx+KVoduWGC0iXwqBc9Opoq7P0=
X-Google-Smtp-Source: AGHT+IE1DsjcGMNbsfS78/I73f0BuOIgOgYSNTCEvwSOQNNjCzWY5WwEzkeAQaRDNOSGFIZl1GNfO9/d4YXFL/FOG3nC3Ia/t1V0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0a:b0:396:1fc1:7034 with SMTP id
 e9e14a558f8ab-39d26c2d8d4mr8857055ab.0.1724069162177; Mon, 19 Aug 2024
 05:06:02 -0700 (PDT)
Date: Mon, 19 Aug 2024 05:06:02 -0700
In-Reply-To: <tencent_E137D8972436B24AC274C1761367D83C5D09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fae86606200821e2@google.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] KASAN: null-ptr-deref Write in jbd2_journal_update_sb_log_tail
From: syzbot <syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ocfs2_cluster_unlock

(syz.0.15,5591,0):ocfs2_check_volume:2428 ERROR: ocfs2 journal load failed! -22
(syz.0.15,5591,0):ocfs2_check_volume:2484 ERROR: status = -22
(syz.0.15,5591,0):ocfs2_mount_volume:1821 ERROR: status = -22
------------[ cut here ]------------
kernel BUG at fs/ocfs2/dlmglue.c:862!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5591 Comm: syz.0.15 Not tainted 6.11.0-rc3-syzkaller-00338-gc3f2d783a459-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_dec_holders fs/ocfs2/dlmglue.c:862 [inline]
RIP: 0010:__ocfs2_cluster_unlock fs/ocfs2/dlmglue.c:1690 [inline]
RIP: 0010:ocfs2_cluster_unlock+0x3ea/0x400 fs/ocfs2/dlmglue.c:346
Code: 89 ef e8 09 09 79 fe e9 32 fe ff ff e8 5f c7 11 fe 90 0f 0b e8 57 c7 11 fe 90 0f 0b e8 4f c7 11 fe 90 0f 0b e8 47 c7 11 fe 90 <0f> 0b e8 3f c7 11 fe 90 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90
RSP: 0018:ffffc900022a6f50 EFLAGS: 00010093
RAX: ffffffff8381c3a9 RBX: 0000000000000246 RCX: ffff88801c05c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff110078e904d R08: ffffffff8381c0a0 R09: ffffffff8381c019
R10: 0000000000000002 R11: ffff88801c05c880 R12: ffff88803c74826c
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88803c748200
FS:  00007f63d75ff6c0(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559404ff8000 CR3: 0000000020252000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_journal_shutdown+0x53e/0xbe0 fs/ocfs2/journal.c:1102
 ocfs2_mount_volume+0x17cd/0x1ac0 fs/ocfs2/super.c:1845
 ocfs2_fill_super+0x483b/0x5880 fs/ocfs2/super.c:1084
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f63d7b7b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f63d75fee68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f63d75feef0 RCX: 00007f63d7b7b0ba
RDX: 0000000020004480 RSI: 00000000200044c0 RDI: 00007f63d75feeb0
RBP: 0000000020004480 R08: 00007f63d75feef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000200044c0
R13: 00007f63d75feeb0 R14: 0000000000004476 R15: 0000000020001200
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_dec_holders fs/ocfs2/dlmglue.c:862 [inline]
RIP: 0010:__ocfs2_cluster_unlock fs/ocfs2/dlmglue.c:1690 [inline]
RIP: 0010:ocfs2_cluster_unlock+0x3ea/0x400 fs/ocfs2/dlmglue.c:346
Code: 89 ef e8 09 09 79 fe e9 32 fe ff ff e8 5f c7 11 fe 90 0f 0b e8 57 c7 11 fe 90 0f 0b e8 4f c7 11 fe 90 0f 0b e8 47 c7 11 fe 90 <0f> 0b e8 3f c7 11 fe 90 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90
RSP: 0018:ffffc900022a6f50 EFLAGS: 00010093
RAX: ffffffff8381c3a9 RBX: 0000000000000246 RCX: ffff88801c05c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff110078e904d R08: ffffffff8381c0a0 R09: ffffffff8381c019
R10: 0000000000000002 R11: ffff88801c05c880 R12: ffff88803c74826c
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88803c748200
FS:  00007f63d75ff6c0(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559404ff8000 CR3: 0000000020252000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         c3f2d783 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11e793cb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=05b9b39d8bdfe1a0861f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c1eafd980000


