Return-Path: <linux-kernel+bounces-349753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E046298FAFB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C73D282AFA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66B1D131D;
	Thu,  3 Oct 2024 23:45:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC21D12E4
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999128; cv=none; b=bjvGAhPEQzggXwfViRLkHo9l2W1cm/yTVQo1R1LTI1k6J3wT49nruthNgpfVOC1cN4hWqtb3xImRtGyFNRlSJxw4Fi+R2B0Z6hGNWyDIBYjIpaWgV2ZB8MjCwRdzwzMfKH0BVbsR6EW9TMQHNhlws5wP78DCrf0cUEoJ+d9d7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999128; c=relaxed/simple;
	bh=pOxWILqBUKwlAHJpW9iLZQH13Z7lcJeo6TeYfT8ZyIU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ma54ytnvexfkO5YY0iNVlQkd2XOHjJJdQ3c+h27BJtLQysa83PO0SjeHnNudYYZJNAU7k1mdn2TrCfTM/ubJ0LBuAitpM/1997bfXC2eaVH1D1MNxNwq397E4DvLZTHryQ0raNsLNZisiDtOH6z9Fqso4i68j9Pp/hJ9I9RptWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cd682f1d2so170797339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999126; x=1728603926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wU0gF7EA/2IK/D5KjJouvQIiV98fKjtQHk2tZX2MV+A=;
        b=X5bS8o8UxCFOaNqv310hmdtjtOgrGjczPGemuenaS7gMzNxOEWnWRkAr3Z/NIfylba
         ObUc6srhAbZ9rOaxUawbXsXtt9dnYlhKVFJigflgfm2qgWlYBtljmSGD/HwmD2TfqGZ7
         3n0AgFua4KftmZ7uuxU5YNRZmYkiBhjfVw3v2kZX6JW19aWMYZcH3GHmXgt4jVg/KQUl
         N7uN0YtR2aZAJlWDd4cOZmMSM2KByTMd4AJf/A5bO9KZr1it74/zwfQmmPuWsaUOAAgm
         yGsHqQfYqnTdqPsi4loqsBbRzhN7deBFKqpCvYPN+4mluRhtsP1/X9WzlczThBaGcCGl
         af6g==
X-Forwarded-Encrypted: i=1; AJvYcCVpsP5RAudRzYFXd08YZJPBxZlw6AHU6jtTYMZNnvZSl0Slizo6wRIT+5dmxS3XlTuDLnCKWx7eJSg05BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLfBOzVooTxgTyWe1St8/Inc17CtWOR2IxJiPEMKzlwYrLjF+K
	hq+vjPLVbLNd99RVBCH96ZE99675quVU6X80WaO+NVKczFoYi2e0Y20LQEGpdvXDdAp8xvygmi2
	ptYgPh43PCkoxb5zLFOEpMvIPDck/0pnIHwbI+7+VXy0aAxTnbqHdnPE=
X-Google-Smtp-Source: AGHT+IFNI8PX+LYN4LPandKAyFZfECm0eLUoc28odb3rYSqUO9hkRuHi3kqSIGkpXkjn1KOFuIoHCiPYfKLptFPpcuuW/CnNj8cQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a375bd5b8dmr9801415ab.23.1727999125725; Thu, 03 Oct 2024
 16:45:25 -0700 (PDT)
Date: Thu, 03 Oct 2024 16:45:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ff2c95.050a0220.49194.03e9.GAE@google.com>
Subject: [syzbot] [exfat?] KMSAN: uninit-value in vfat_rename2
From: syzbot <syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e7ed34365879 Merge tag 'mailbox-v6.12' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b54ea9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92da5062b0d65389
dashboard link: https://syzkaller.appspot.com/bug?extid=ef0d7bc412553291aa86
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b7ed07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101dfd9f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/66cc3d8c5c10/disk-e7ed3436.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7769a88b445/vmlinux-e7ed3436.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1fe4c6ee436/bzImage-e7ed3436.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2ab98c65fd49/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/7ffc0eb73060/mount_5.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com

Buffer I/O error on dev loop4, logical block 34, lost sync page write
FAT-fs (loop4): unable to read inode block for updating (i_pos 548)
=====================================================
BUG: KMSAN: uninit-value in vfat_rename fs/fat/namei_vfat.c:1038 [inline]
BUG: KMSAN: uninit-value in vfat_rename2+0x3dda/0x3de0 fs/fat/namei_vfat.c:1174
 vfat_rename fs/fat/namei_vfat.c:1038 [inline]
 vfat_rename2+0x3dda/0x3de0 fs/fat/namei_vfat.c:1174
 vfs_rename+0x1d9d/0x2280 fs/namei.c:5013
 do_renameat2+0x18cc/0x1d50 fs/namei.c:5170
 __do_sys_rename fs/namei.c:5217 [inline]
 __se_sys_rename fs/namei.c:5215 [inline]
 __x64_sys_rename+0xe8/0x140 fs/namei.c:5215
 x64_sys_call+0x1e4d/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:83
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable sinfo.i created at:
 vfat_rename fs/fat/namei_vfat.c:937 [inline]
 vfat_rename2+0x124/0x3de0 fs/fat/namei_vfat.c:1174
 vfs_rename+0x1d9d/0x2280 fs/namei.c:5013

CPU: 1 UID: 0 PID: 5211 Comm: syz-executor818 Not tainted 6.11.0-syzkaller-12113-ge7ed34365879 #0
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

