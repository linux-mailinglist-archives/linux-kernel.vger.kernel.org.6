Return-Path: <linux-kernel+bounces-335145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A6497E1D1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80B4B20C52
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0801B23D7;
	Sun, 22 Sep 2024 13:25:22 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6AC63C
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727011521; cv=none; b=FgfpNedwACZzj5lz1NVBMmxs7NpMg4TWyfadJuX2rv+mdkULwagv6Pkw1yh5SG6WmViC0PLbh59mfsnAZbLVTrPvodAKU+6XgeJ8711vx/44COrXt6ggYT45TWSPlLqMpwo4ZbTJWDLW+6OdNsKFInxxcNju5fH7rFv05e6RMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727011521; c=relaxed/simple;
	bh=eaYXHifQ/+gWRNQ0Bi6jr1etY9SrUpzXn3cwrC6C8pk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lCQvPS5eCHEPKs1RnlS/44u8CfwWypcbbJB6RP8eyyxhcYc4f1hA1InZtiw1P2IM9xDbMVGEwVnH6vhpAmSaNm/l/rmQCnxzTEAwa9W2MJz+L73ZmaGIGpMiOHMzPyjylhrkGo39MOFp+RtwqGuyrylAbjzuYNqnCj3UfVgZ50Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cd9c20b2bso488645039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 06:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727011519; x=1727616319;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+LFC3PUgiFcZNaAgxZJ2DmssPBnBLTVDgX3cD3qXGQ=;
        b=vDGNGLvqlCIUshC60lf1ulDNh7rp5WOXyGNcgeGoC/EvlMFMYAkxX6A2F8uTU76N8N
         6jL7QJEAd/grSgvfixCJhVtqLAhr/yTaEgopHQPIvNTWXhVZDTKurOZn7ZG+uXkX657Z
         /F0K2ff4SQm07xqVUotK/JNm6xgyvltfogDSbMql+BOu/SCm+jH+KCygAzBnMaMqCUrw
         gIQRAwrfJP6ddp1K0l5eRDhcCJLViYFmkrXv0sR3dwazE4NiXOg7PucILT4q/0pcqoSe
         8nDekPQRvJaOqiYVkR1tCyb22wK4Ts3UTZeoqOh2y+wK1dlfGoGycVX7fT4jp6vRTNjn
         AB9A==
X-Forwarded-Encrypted: i=1; AJvYcCXBw1lu6j3V63eWXT+Zk5BFNn/Sjw/cbP7FMxecSL2458fQxceSQAvnEq9F1e/e8aFk3vnSF/i8F49J2rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISxr7GNll15J6O7w8KX1HrrM5DEJcgNS+iBTkWwj5dZ7k4/bg
	BRavUzIfzw1dg5jcyW2hs4apgJXSYHWOVGZdW8k4CTFLzxNKU49DtraXMsk0LyIeZQRdl2bY20Q
	7DWPzLxBVPheBTdPwV+EUB3HBXqyRVXN6W2RzwB5Fkr5nlLx1FUD0wjM=
X-Google-Smtp-Source: AGHT+IFDrOLEYGsA9cGC3KqLc8OoQBfBVAO4cdxNstLNMP3NEXq7fmchGQ5UgJWGSVBtS3YOpcPk9B7uXgA4Sy5f5lOnYS1aVRBy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe2:b0:3a0:92b1:ec3c with SMTP id
 e9e14a558f8ab-3a0c8c6a51fmr67026745ab.4.1727011519015; Sun, 22 Sep 2024
 06:25:19 -0700 (PDT)
Date: Sun, 22 Sep 2024 06:25:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f01abe.050a0220.3195df.009d.GAE@google.com>
Subject: [syzbot] [bcachefs?] WARNING in bch2_fs_release
From: syzbot <syzbot+08d08d52c3a09bfc70f7@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=108f7500580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=08d08d52c3a09bfc70f7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148f7500580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/019ec069588b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08d08d52c3a09bfc70f7@syzkaller.appspotmail.com

------------[ cut here ]------------
online_reserved not 0 at shutdown: 4
WARNING: CPU: 1 PID: 7017 at fs/bcachefs/super.c:568 __bch2_fs_free fs/bcachefs/super.c:568 [inline]
WARNING: CPU: 1 PID: 7017 at fs/bcachefs/super.c:568 bch2_fs_release+0x6c4/0x720 fs/bcachefs/super.c:608
Modules linked in:
CPU: 1 UID: 0 PID: 7017 Comm: syz.4.63 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __bch2_fs_free fs/bcachefs/super.c:568 [inline]
pc : bch2_fs_release+0x6c4/0x720 fs/bcachefs/super.c:608
lr : __bch2_fs_free fs/bcachefs/super.c:568 [inline]
lr : bch2_fs_release+0x6c4/0x720 fs/bcachefs/super.c:608
sp : ffff80009b667500
x29: ffff80009b667520 x28: 00007dfe9b5f3270 x27: ffffffffffffffff
x26: dfff800000000000 x25: ffff0000f5f80000 x24: 0000000000000008
x23: 0000000000000004 x22: 1fffe0001ebf093e x21: ffff0000f5fca1e8
x20: 0000000000000008 x19: ffff0000f5f80068 x18: 1fffe000366d79ee
x17: ffff80008f56d000 x16: ffff800080347214 x15: 0000000000000001
x14: 1fffe00019a65a00 x13: 0000000000000000 x12: 0000000000000000
x11: ffff600019a65a01 x10: 1fffe00019a65a00 x9 : 8734dde5ec21bf00
x8 : 8734dde5ec21bf00 x7 : ffff8000802b7e24 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff8000802aa83c
x2 : 0000000000000001 x1 : 0000000000000004 x0 : 0000000000000001
Call trace:
 __bch2_fs_free fs/bcachefs/super.c:568 [inline]
 bch2_fs_release+0x6c4/0x720 fs/bcachefs/super.c:608
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2a8/0x41c lib/kobject.c:737
 bch2_fs_free+0x2c4/0x334 fs/bcachefs/super.c:672
 bch2_fs_stop+0x28/0x38 fs/bcachefs/super.c:678
 bch2_fs_get_tree+0xab0/0x1030 fs/bcachefs/fs.c:2041
 vfs_get_tree+0x90/0x28c fs/super.c:1800
 do_new_mount+0x278/0x900 fs/namespace.c:3472
 path_mount+0x590/0xe04 fs/namespace.c:3799
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount fs/namespace.c:3997 [inline]
 __arm64_sys_mount+0x45c/0x5a8 fs/namespace.c:3997
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 90582
hardirqs last  enabled at (90581): [<ffff8000802b7ec4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
hardirqs last  enabled at (90581): [<ffff8000802b7ec4>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:4942
hardirqs last disabled at (90582): [<ffff80008b3363f4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (90568): [<ffff8000801f8e88>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (90568): [<ffff8000801f8e88>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (90505): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
bcachefs: bch2_fs_get_tree() error: fsck_errors_not_fixed
syz.4.63 (7017): drop_caches: 2
syz.4.63 (7017): drop_caches: 2


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

