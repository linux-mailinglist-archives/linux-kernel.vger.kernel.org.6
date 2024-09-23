Return-Path: <linux-kernel+bounces-335457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6922097E5FD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3EA1C20831
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A7C18AE4;
	Mon, 23 Sep 2024 06:29:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97BDDD2
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727072962; cv=none; b=jHHhRHqxud3wJNDeq7Bf0xfDMlyx/kW2wVg68TZDzpScgnStvmxLac81000fMvMfKHJZTkaFgMK7u6AP7AwPuJ3gp7gI3gLVBvl+qwJi5MQg7Y8L4dyjq7+xJwSjLaZsdA4Kz8JDg96BZ/NCcNXkRk9zmMFpPHyrQQqG7Y3XCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727072962; c=relaxed/simple;
	bh=Kx2TQ68EgLTyrPdq9aPMZHinCZwxdZiZuzFAaa2+RNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FDbTnG7kpm2osP6+G3B61zzQcM5IfHOVNuw1icyjx2fjq+PIzGnmM2M4ZlMGSkTlISPplDgQ8m1bUKzmPpsrpcZMCQbr3MyT24iqIGVxUtd9rl1TmaAj899Z2Vhxf6JFCaqBNj2fve9IYZPxrVcpj3KubqefLdE5kv1YIvVS9RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f5605c674so64325605ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727072960; x=1727677760;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3eisFSRgCY6SMH0f8UYNrkNokbVueDFjny1BQQTsH4=;
        b=uVvfDGoJaM85uqC8FV1+vsnGJKEKpnfx8GkXT6wVe3rle/BbNB72vg2v53qnvOIsp9
         nE5n1E32R2aOHsVDMD7TzsrPD0m1kGl425r/KkNMDnxGWwsfxmGiadp3zNYP3lM0oKaU
         suy98oJRoIQ7ErUVzOVa/SxA4PZTWzjDYXvVf3jmhVNH+u98yON6yyaRzvTSE7cB1E/R
         BsutxNSQ97y+MUnnPZ6BY1Z0V6PXhe2ek+56ncKVhT0wDltgEfmkG86Axo+tq7y2M1qH
         wp2tIJFxXjEF1y+ofwUjA38cNvd71vrfAnM8oB5vjg6u0q5wuCQP1o4UUP6ZDDYV69Av
         KsMg==
X-Forwarded-Encrypted: i=1; AJvYcCV68yVWClgPEU0vg/KFbv5IncNmw47l7A6xCL0FMR7aqKig4fgv9B9FrFVgyJd4VDft8QEkXnvSzzjEeHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwhfn8e1SnKHO8Sg3ACLTQWrdgNg3DJzcpFs34fxK7Qq35FPKj
	mCKzN+81+0Iw+6f1GfHfERLxrBIJukMMjRckSYqgp9FbwEDSPlynKjVYjciu9sJ+z9Xk/nbeLqc
	D2dGazb5Vl9ih8fSnjAVXogru9Qm+4tzRxs0Z/Qo8XxUwnqLMkAGPHlk=
X-Google-Smtp-Source: AGHT+IG8Yx2EOLpckWvpFVzqGKecn74ALfi2WkCETiIB4ueMOGCM0jtAvUXAm60wGHP1fCOwJj6CTwCjcNTmlVZdvBwgoNRvNknu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c84:b0:3a0:98e9:1b7a with SMTP id
 e9e14a558f8ab-3a0c8c8e8b8mr80971335ab.2.1727072960585; Sun, 22 Sep 2024
 23:29:20 -0700 (PDT)
Date: Sun, 22 Sep 2024 23:29:20 -0700
In-Reply-To: <000000000000849b0606179c33b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f10ac0.050a0220.3eed3.0004.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bchfs_truncate
From: syzbot <syzbot+247ac87eabcb1f8fa990@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11e69c27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=247ac87eabcb1f8fa990
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a57480580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e69c27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/b790e8eefcc7/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/47201b805f63/mount_1.gz

The issue was bisected to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1077cf8a980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1277cf8a980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1477cf8a980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+247ac87eabcb1f8fa990@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

------------[ cut here ]------------
truncate spotted in mem i_size < btree i_size: 1 < 57344
WARNING: CPU: 0 PID: 6420 at fs/bcachefs/fs-io.c:447 bchfs_truncate+0x988/0xab0 fs/bcachefs/fs-io.c:444
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor335 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : bchfs_truncate+0x988/0xab0 fs/bcachefs/fs-io.c:444
lr : bchfs_truncate+0x988/0xab0 fs/bcachefs/fs-io.c:444
sp : ffff8000a4467300
x29: ffff8000a4467500 x28: ffff0000de380000 x27: 000000000000e000
x26: ffff0000de748da0 x25: dfff800000000000 x24: ffff70001488ce74
x23: 1fffe0001bce91b4 x22: ffff0000de748ca0 x21: ffff0000de3ca380
x20: ffff8000927b7000 x19: ffff0000de748760 x18: 0000000000000008
x17: 0000000000000000 x16: ffff800083032784 x15: 0000000000000001
x14: 1fffe000366d325a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : ab59bfad62359900
x8 : ab59bfad62359900 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a4466a58 x4 : ffff80008f65b620 x3 : ffff8000806051a0
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 bchfs_truncate+0x988/0xab0 fs/bcachefs/fs-io.c:444
 bch2_setattr+0x198/0x230 fs/bcachefs/fs.c:942
 notify_change+0x9f0/0xca0 fs/attr.c:503
 do_truncate+0x1c0/0x28c fs/open.c:65
 handle_truncate fs/namei.c:3381 [inline]
 do_open fs/namei.c:3731 [inline]
 path_openat+0x2388/0x29f8 fs/namei.c:3886
 do_filp_open+0x1bc/0x3cc fs/namei.c:3913
 do_sys_openat2+0x124/0x1b8 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1442
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 140
hardirqs last  enabled at (139): [<ffff800080388420>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (139): [<ffff800080388420>] __console_unlock kernel/printk/printk.c:2801 [inline]
hardirqs last  enabled at (139): [<ffff800080388420>] console_unlock+0x18c/0x3d4 kernel/printk/printk.c:3120
hardirqs last disabled at (140): [<ffff80008b3363f4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (8): [<ffff8000800307f8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (6): [<ffff8000800307c4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

