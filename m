Return-Path: <linux-kernel+bounces-442772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26EA9EE160
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813A71638A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB520D501;
	Thu, 12 Dec 2024 08:35:30 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE720B21D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992529; cv=none; b=YvH5nxnh2MxnR2svzrmj6FtWX/G6JiXLkuhRLPy9Fzcfzv4GoJL2MOLgHD6MJKLaSEs9LEH8sqSlOHA1OlsKIsU2jtU54aWZA4L9h43kukYru/MsqsFAgNXQ9dydWl7x35ozbqDTchihaAi5aVm9XDRfuGsnXD1w1zUDvjG9M54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992529; c=relaxed/simple;
	bh=1uQyb0fyFHZWvZlk+o2GTg1a512RhpEyP+IbAz0kJfc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lIrSjQK1kj6hIfAcXWAdrIRJKRe4Oc4HFMbaJnHKLVPOmwRwn+M+QgHX7+SyJlnUcGG0fbgePeNOC1i7EM7rmusECYWbI7RVzibL0fy/y/baYs0JT0YJEASry9QajaPFSpxkfMEQVBZGD0t9H4CMQVOYkVznfIhgGZXtlmZWgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so3416955ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733992527; x=1734597327;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2z0khIIhP8/UZ3BXerT67wZzUu41LWFs8goIzSaBFXo=;
        b=kRmp62j/tFh5lRINCL+kVtuXDYKzNUsnHS0thPAtg2P2jDQZCSYM9DQiWAehVfUwJT
         DwZrBrM9W3mDmS+BQpfSNUhCMsd+hdTFoAma36hOLpnpb0zuZhp6lDAiUtZh0A72WWWO
         PYMM/thOajgFsTF6R7rF30uoTqgw/ofAkrwQk8tmFm+B2nOdpIuLuAJDN+xDRZ8IJHeK
         xJSKedCHxwDidssOPNJL/VPyXSQGNiGZnkuW70lyZEIX42TjXrr0+8Jq4lYOBl35cj/n
         uY+PNEiP8g+BQJCBGe1tTcqLEj5sZHWnhec40f261PX9hgkvwnkBdi5PTHCLFkabWkjJ
         DSIA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Yn4uLZjnZ1ta+r6E7QpY34j9qqMGgQvH+VKol1aY6vqatKeG2YyTyoD10nQnr0TDF/R2vr76kUVm+8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/Z0MIX4D6LYtBQo6CKrjlERU7Sib7V3SfXfD5UpdANf9LiD2
	5Mkd1dnXtX32mnXPAXyFn9JJTnk6AmJ5v8ax1t/oOGvZcVUzOrtx6+8QVXp1MRh35ZQxISCTVXc
	ApdTs5m/4RdiILbPAtK/AQGWl81tPKsmNJPGEeGGoTyq656HjEwYOMQ4=
X-Google-Smtp-Source: AGHT+IHcMlK6fpbC/Gou1uGX/RARv4ECgV0j/HudfQRw2rDjrvFkAIwpk+ylQ/yuTB0VQMAvt6DR9gcjeYlHd+bTLXcw/Xx0M9R8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198f:b0:3a7:8040:5962 with SMTP id
 e9e14a558f8ab-3ac41e2ab70mr23598505ab.0.1733992527024; Thu, 12 Dec 2024
 00:35:27 -0800 (PST)
Date: Thu, 12 Dec 2024 00:35:27 -0800
In-Reply-To: <672dbff0.050a0220.69327.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675aa04e.050a0220.17f54a.0083.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in mark_as_free_ex (2)
From: syzbot <syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    231825b2e1ff Revert "unicode: Don't special case ignorable..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1635ebe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=8df514c431bd240c5644
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128e6cdf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1784b20f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dc23b60ff29a/disk-231825b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/377c8f65d53a/vmlinux-231825b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09bc1abb7c7a/bzImage-231825b2.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/fe1662038b98/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/5c6aa5da5c24/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com

ntfs3(loop3): Mark volume as dirty due to NTFS errors
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc2-syzkaller-00036-g231825b2e1ff #0 Not tainted
------------------------------------------------------
syz-executor149/6544 is trying to acquire lock:
ffff88807e17a270 (&wnd->rw_lock){++++}-{4:4}, at: mark_as_free_ex+0x3e/0x390 fs/ntfs3/fsntfs.c:2484

but task is already holding lock:
ffff8880705e43c8 (&ni->file.run_lock#2){++++}-{4:4}, at: ntfs_truncate fs/ntfs3/file.c:505 [inline]
ffff8880705e43c8 (&ni->file.run_lock#2){++++}-{4:4}, at: ntfs_setattr+0x6d3/0xb80 fs/ntfs3/file.c:824

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->file.run_lock#2){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       run_unpack_ex+0x55e/0x9e0 fs/ntfs3/run.c:1119
       ntfs_read_mft fs/ntfs3/inode.c:401 [inline]
       ntfs_iget5+0x1f9a/0x37b0 fs/ntfs3/inode.c:537
       ntfs_dir_emit fs/ntfs3/dir.c:335 [inline]
       ntfs_read_hdr+0x700/0xb80 fs/ntfs3/dir.c:383
       ntfs_readdir+0x91f/0xf00 fs/ntfs3/dir.c:494
       iterate_dir+0x571/0x800 fs/readdir.c:108
       __do_sys_getdents64 fs/readdir.c:403 [inline]
       __se_sys_getdents64+0x1e2/0x4b0 fs/readdir.c:389
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&wnd->rw_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
       mark_as_free_ex+0x3e/0x390 fs/ntfs3/fsntfs.c:2484
       run_deallocate_ex+0x244/0x5f0 fs/ntfs3/attrib.c:122
       attr_set_size+0x168d/0x4300 fs/ntfs3/attrib.c:753
       ntfs_truncate fs/ntfs3/file.c:506 [inline]
       ntfs_setattr+0x7a4/0xb80 fs/ntfs3/file.c:824
       notify_change+0xbca/0xe90 fs/attr.c:552
       do_truncate+0x220/0x310 fs/open.c:65
       handle_truncate fs/namei.c:3449 [inline]
       do_open fs/namei.c:3832 [inline]
       path_openat+0x2e1e/0x3590 fs/namei.c:3987
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_open fs/open.c:1425 [inline]
       __se_sys_open fs/open.c:1421 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1421
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->file.run_lock#2);
                               lock(&wnd->rw_lock);
                               lock(&ni->file.run_lock#2);
  lock(&wnd->rw_lock);

 *** DEADLOCK ***

4 locks held by syz-executor149/6544:
 #0: ffff888079980420 (sb_writers#11){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff8880705e45b0 (&sb->s_type->i_mutex_key#19){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #1: ffff8880705e45b0 (&sb->s_type->i_mutex_key#19){+.+.}-{4:4}, at: do_truncate+0x20c/0x310 fs/open.c:63
 #2: ffff8880705e4318 (&ni->ni_lock#2/5){+.+.}-{4:4}, at: ni_lock fs/ntfs3/ntfs_fs.h:1110 [inline]
 #2: ffff8880705e4318 (&ni->ni_lock#2/5){+.+.}-{4:4}, at: ntfs_truncate fs/ntfs3/file.c:503 [inline]
 #2: ffff8880705e4318 (&ni->ni_lock#2/5){+.+.}-{4:4}, at: ntfs_setattr+0x6bf/0xb80 fs/ntfs3/file.c:824
 #3: ffff8880705e43c8 (&ni->file.run_lock#2){++++}-{4:4}, at: ntfs_truncate fs/ntfs3/file.c:505 [inline]
 #3: ffff8880705e43c8 (&ni->file.run_lock#2){++++}-{4:4}, at: ntfs_setattr+0x6d3/0xb80 fs/ntfs3/file.c:824

stack backtrace:
CPU: 1 UID: 0 PID: 6544 Comm: syz-executor149 Not tainted 6.13.0-rc2-syzkaller-00036-g231825b2e1ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
 mark_as_free_ex+0x3e/0x390 fs/ntfs3/fsntfs.c:2484
 run_deallocate_ex+0x244/0x5f0 fs/ntfs3/attrib.c:122
 attr_set_size+0x168d/0x4300 fs/ntfs3/attrib.c:753
 ntfs_truncate fs/ntfs3/file.c:506 [inline]
 ntfs_setattr+0x7a4/0xb80 fs/ntfs3/file.c:824
 notify_change+0xbca/0xe90 fs/attr.c:552
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3449 [inline]
 do_open fs/namei.c:3832 [inline]
 path_openat+0x2e1e/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_open fs/open.c:1425 [inline]
 __se_sys_open fs/open.c:1421 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1421
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f17dc4ac879
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc503e84b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f17dc4ac879
RDX: 00000000000001d8 RSI: 0000000000147383 RDI: 0000000020000240
RBP: 00007ffc503e84ec R08: 000000000001f216 R09: 0000000020000880
R10: 00007ffc503e8380 R11: 0000000000000246 R12: 00007ffc503e8540
R13: 00007ffc503e8500 R14: 0000000000024ec5 R15: 0000000000000090
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

