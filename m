Return-Path: <linux-kernel+bounces-272245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E194592F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1F0286CF6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58E148FFC;
	Fri,  2 Aug 2024 07:50:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D13D6A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585025; cv=none; b=ToVxe+1m6fhw5nWAgEB89btIr7IMButnFKgdI4uf6OpdHDhsZS00SJTrt21UNFOpwysGLkHX2qKbGeFEw+xYbcuyqgFtKTo8gdkkTO50BxKBxHjipHXFTMJe4i6ABEF7oZ55yQCE/bVRWj5tY95P0rgnmpVEyeYCWwsqKXJn754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585025; c=relaxed/simple;
	bh=ni8r2yWVcA8u8avfF7jU/Icnz+RqEtsEmwuPWJ/eQT8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aBLRPGAxqYSnWSZtzm3V6y+26oBbBQRNhjNF2zrv/7VilKKjaUWJ56GrUSzLeliwvTNUQsq9S96BSK3LbcqNcu9AZbaiw2HutWN7qCpyiqfPdogoucYtFWyb+pV2XnvTBmcvCB9CDpKexmIXx7kuYltuVLFsh8MmzMsTw3e3qJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f81dcb634so1090663639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585023; x=1723189823;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/KctRx5AV4LYpiHBuA8VxA2oulvhDuXSnHn+3sp+YQ=;
        b=qdXh0zs/DZdRmdcFCI+b0IdW3w4iNQPW014sihL7jqoyq9XyAJCro6MzdnQDzA6aoO
         HQTvJzsg2MHNT9nGsn839LETZPvjsFxZqVd6pEc3yDreDJA3sKPvaJo58a1seu570YxR
         u3TkzOgcpsMex4qJV3XNBCBKD8CdiB7hW3aLgphXW8qfNDGLMFlbPgKGVIIO9V2HRHDy
         dBkM7kgr3yl9WUhILJZ9VMjSPWGIRDxL1g3WxSRUj0unlBf+qEe8qpBVaBoG1lfS4HUO
         /MF5UH8h7H3Dv8bh4+CIqNqQMKtItR0DIz9sNyLQMXW282bMQKz00DxHnyS7k6v/Ut1/
         YX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWm4JaIQSiJyI+bgZ8SVmOR0Iq8G+ZGV23vxl4gGeWVCt5r5YvU3Ci36iXr03UCtHk3aEua5L/skFNR8Nv18s8Yu3WABYPKQGFsBCHV
X-Gm-Message-State: AOJu0YzCtgtoTJ8yDRpvmTwShVlmwZdI0LWjJ2DUirFo16+7CJm2uEXL
	SVqrxk3aOmjwmiAfY0nQyZi3h22sEgu4aSW1rGD/w0NmWxPzhNX0jmCUeFmvVz7K1l/EKG8fxY3
	mGNyDcgaR8ISk7SVjqlbsc8yyAytlJfAQJPb1nxbzfvgPoTMKmvl+83I=
X-Google-Smtp-Source: AGHT+IHT0hjoN1rZ2iXPY8kIIav7lX7Tq9IBC/hkDgFnTC4OmGLl/fkHbDgLaoaLmtndlx9d+L/G4JcP+bE4evIO5a/rI7RqnDNC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4e:b0:381:24e:7a85 with SMTP id
 e9e14a558f8ab-39b1fb6b9damr1969315ab.1.1722585023060; Fri, 02 Aug 2024
 00:50:23 -0700 (PDT)
Date: Fri, 02 Aug 2024 00:50:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000652bb9061eae94a2@google.com>
Subject: [syzbot] [ext4?] KCSAN: data-race in generic_buffers_fsync_noflush /
 writeback_single_inode (3)
From: syzbot <syzbot+35257a2200785ea628f5@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    183d46ff422e Merge tag 'net-6.11-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1275c375980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d16924117a4f7e9
dashboard link: https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1a0d5d40de3d/disk-183d46ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aaf4a529fd3b/vmlinux-183d46ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e92264424f5/bzImage-183d46ff.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35257a2200785ea628f5@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode

write to 0xffff88810692fca0 of 8 bytes by task 3596 on cpu 1:
 writeback_single_inode+0x10e/0x4a0 fs/fs-writeback.c:1769
 sync_inode_metadata+0x5c/0x90 fs/fs-writeback.c:2842
 generic_buffers_fsync_noflush+0xe4/0x130 fs/buffer.c:610
 ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
 ext4_sync_file+0x20b/0x6c0 fs/ext4/fsync.c:151
 vfs_fsync_range+0x122/0x140 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2816 [inline]
 ext4_buffered_write_iter+0x338/0x380 fs/ext4/file.c:305
 ext4_file_write_iter+0x29f/0xe30
 iter_file_splice_write+0x5e6/0x970 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x16c/0x2c0 fs/splice.c:1164
 splice_direct_to_actor+0x305/0x670 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0xd7/0x150 fs/splice.c:1233
 do_sendfile+0x3ab/0x950 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64 fs/read_write.c:1348 [inline]
 __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1348
 x64_sys_call+0xfc3/0x2e00 arch/x86/include/generated/asm/syscalls_64.h:41
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88810692fca0 of 8 bytes by task 3592 on cpu 0:
 generic_buffers_fsync_noflush+0x89/0x130 fs/buffer.c:605
 ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
 ext4_sync_file+0x20b/0x6c0 fs/ext4/fsync.c:151
 vfs_fsync_range+0x122/0x140 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2816 [inline]
 ext4_buffered_write_iter+0x338/0x380 fs/ext4/file.c:305
 ext4_file_write_iter+0x29f/0xe30
 iter_file_splice_write+0x5e6/0x970 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x16c/0x2c0 fs/splice.c:1164
 splice_direct_to_actor+0x305/0x670 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0xd7/0x150 fs/splice.c:1233
 do_sendfile+0x3ab/0x950 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64 fs/read_write.c:1348 [inline]
 __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1348
 x64_sys_call+0xfc3/0x2e00 arch/x86/include/generated/asm/syscalls_64.h:41
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000005 -> 0x0000000000000080

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3592 Comm: syz.3.57 Not tainted 6.11.0-rc1-syzkaller-00151-g183d46ff422e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
==================================================================


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

