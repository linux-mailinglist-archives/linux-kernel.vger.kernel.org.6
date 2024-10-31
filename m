Return-Path: <linux-kernel+bounces-390079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2E49B753C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634D3283409
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9450B14B08C;
	Thu, 31 Oct 2024 07:19:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC101494C2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359145; cv=none; b=r0g3Q8eV8sRiGjUYOVPB7hm9a4sj4k5KI2/+w7Vy1ShFEYVqXMsnlKIutZjATGSjiOi1Os6cLDOCiPgwknL2ZWsGBf/AIgX/k9YjeArtQMxpHmDM3D42X3iijZlg0d69mQUtKgyZXUGOeYQsgzH5b+NPlvNII35EwBdcyYL6kX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359145; c=relaxed/simple;
	bh=zYn+qeJNUUHBmGKBXESogHvm1pLByeP4l9hmZDBPGIU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H40QBQoatIDIEkIw3MKttOvfIOC5C/+/NEtisRryEj/j6PtUrQd+JEnKCpiexF1gNEdQRQ3VrjMxYKP+pPzzW4wlg8qWYGEep5h2f3vEAUl1dfHF1PRXFds/yPppx83J3CfqWLRkegeo65WhWJOYEIR9SrGhLugOLx0WCMQBO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aac7e7fd7so65352839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359142; x=1730963942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHvKAKa+97eVElF4YHGqNWULEJo8LYTR1hwiZiV4XZk=;
        b=EPaTbyJJDRIoE2S9jy5G7ux4msabZw5qYVNyda9eWbYtNpjNS8qOHU2YlYY4ccBeVA
         v3Y4c1J3qc0ryTvFZ1jhk8dPSBamSdorRyk4ElkYd+ys0TvDZ5/lfqSEuBT2T+jZaFDS
         /b/GpLSLb3BKmrR51Qi+6INMFJ+XxU65vdX7+NfhOSogTOnbVRuI1oAM34NfObOsW+Rt
         bhOWlH60s5Ld2uxFqTC+WzYa5leJ3Uyl9OI1bnL4hpGbw01HchQNcgnZEAYrrFZeH2mM
         zso6mIv9hfp4ivVwJKE8U8YE3frtmaDBwbHsDC6G91BMVwOW6s/j+gBNVAEvyz2ekVq0
         +XLg==
X-Forwarded-Encrypted: i=1; AJvYcCVPDaMGsUuf/6hkTNOvY2p0/eiyXZ++aWhRW0FJI+CQK98kXfzzVM/N9Dq2Gar2eo3bDeOGJ5eZ0wQv+Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7cI9AKMfYsAC+aLCnoItgj38tgtZ0WCKZVnY6nV8OaBirVYY
	S3iHQQGUa2rdQ+SfzZceDPX5mqKumMnBeMe+v9lVMJs9NLW4iLHxiOPE464GF8FgE7u1olbmGKG
	BqAOY2KJDZx1BaCJY1i3CB8ExJv/z0IxgCv+5KzGY4kXqoOKIYcT05V8=
X-Google-Smtp-Source: AGHT+IGNMDrKF4RGHe9GLb32dJtPGuA+SHYbgW+EoarPQgYBQF0bDKTRoF0yq5O5va97hOX/4o8xqr/BD6eJ/9JdnhrUSTtBBrIc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3a5:e5cf:c5b6 with SMTP id
 e9e14a558f8ab-3a5e5cfc68bmr46178025ab.10.1730359141951; Thu, 31 Oct 2024
 00:19:01 -0700 (PDT)
Date: Thu, 31 Oct 2024 00:19:01 -0700
In-Reply-To: <noznkuwmznodskgral7ttq7dvncygedxuvuzq5xk5boldtqr7f@k75s5ldxcfxy>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67232f65.050a0220.3c8d68.0667.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in __bkey_unpack_pos
From: syzbot <syzbot+4d722d3c539d77c7bc82@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __bkey_unpack_pos

bcachefs (loop0): accounting_read... done
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read...
------------[ cut here ]------------
kernel BUG at fs/bcachefs/bkey.c:297!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5828 Comm: syz.0.15 Not tainted 6.12.0-rc5-syzkaller-g0fc810ae3ae1-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__bkey_unpack_pos+0x779/0x790 fs/bcachefs/bkey.c:297
Code: b4 e4 00 e9 ad fb ff ff e8 e4 df 83 fd 48 c7 c7 c0 b2 f3 8e 4c 89 e6 48 89 da e8 c2 b4 e4 00 e9 f4 fc ff ff e8 c8 df 83 fd 90 <0f> 0b e8 c0 df 83 fd 90 0f 0b e8 b8 df 83 fd 90 0f 0b 0f 1f 44 00
RSP: 0018:ffffc9000cc6e360 EFLAGS: 00010293
RAX: ffffffff8410fa58 RBX: 0000000000000001 RCX: ffff888000b48000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 0000000000000000 R08: ffffffff8410f388 R09: 0000000000000000
R10: ffffc9000cc6e400 R11: fffff5200198dc82 R12: ffffc9000cc6e400
R13: dffffc0000000000 R14: 0000000000000001 R15: ffffc9000cc6e840
FS:  00007fcbcb3da6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d92780f000 CR3: 000000004e52e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bkey_unpack_pos_format_checked fs/bcachefs/bkey.h:456 [inline]
 __bch2_bkey_cmp_left_packed_format_checked fs/bcachefs/bkey.c:1028 [inline]
 __bch2_bkey_cmp_left_packed+0xed/0x790 fs/bcachefs/bkey.c:1048
 bkey_cmp_left_packed fs/bcachefs/bkey.h:88 [inline]
 bch2_bkey_pack_pos_lossy+0xa08/0x1990 fs/bcachefs/bkey.c:532
 bch2_btree_node_iter_init+0x894/0x4280 fs/bcachefs/bset.c:1313
 __btree_path_level_init fs/bcachefs/btree_iter.c:615 [inline]
 bch2_btree_path_level_init+0x4d2/0x9f0 fs/bcachefs/btree_iter.c:635
 btree_path_lock_root fs/bcachefs/btree_iter.c:769 [inline]
 bch2_btree_path_traverse_one+0x10de/0x2940 fs/bcachefs/btree_iter.c:1170
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:247 [inline]
 __bch2_btree_iter_peek fs/bcachefs/btree_iter.c:2197 [inline]
 bch2_btree_iter_peek_upto+0xb58/0x70e0 fs/bcachefs/btree_iter.c:2297
 bch2_btree_iter_peek_upto_type fs/bcachefs/btree_iter.h:685 [inline]
 bch2_snapshots_read+0x4ac/0x15f0 fs/bcachefs/snapshot.c:1785
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:185
 bch2_run_recovery_passes+0x387/0x870 fs/bcachefs/recovery_passes.c:232
 bch2_fs_recovery+0x25cc/0x39c0 fs/bcachefs/recovery.c:862
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2170
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcbca57feba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcbcb3d9e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fcbcb3d9ef0 RCX: 00007fcbca57feba
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007fcbcb3d9eb0
RBP: 00000000200058c0 R08: 00007fcbcb3d9ef0 R09: 0000000001000000
R10: 0000000001000000 R11: 0000000000000246 R12: 0000000020005900
R13: 00007fcbcb3d9eb0 R14: 000000000000594c R15: 0000000020000280
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bkey_unpack_pos+0x779/0x790 fs/bcachefs/bkey.c:297
Code: b4 e4 00 e9 ad fb ff ff e8 e4 df 83 fd 48 c7 c7 c0 b2 f3 8e 4c 89 e6 48 89 da e8 c2 b4 e4 00 e9 f4 fc ff ff e8 c8 df 83 fd 90 <0f> 0b e8 c0 df 83 fd 90 0f 0b e8 b8 df 83 fd 90 0f 0b 0f 1f 44 00
RSP: 0018:ffffc9000cc6e360 EFLAGS: 00010293
RAX: ffffffff8410fa58 RBX: 0000000000000001 RCX: ffff888000b48000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 0000000000000000 R08: ffffffff8410f388 R09: 0000000000000000
R10: ffffc9000cc6e400 R11: fffff5200198dc82 R12: ffffc9000cc6e400
R13: dffffc0000000000 R14: 0000000000000001 R15: ffffc9000cc6e840
FS:  00007fcbcb3da6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d92780f000 CR3: 000000004e52e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         0fc810ae x86/uaccess: Avoid barrier_nospec() in 64-bit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16942e87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=4d722d3c539d77c7bc82
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11afc630580000


