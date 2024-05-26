Return-Path: <linux-kernel+bounces-189773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504508CF4BD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 17:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C3C280FDC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6038179BC;
	Sun, 26 May 2024 15:26:26 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4AF175A1
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716737186; cv=none; b=ZjzLl0+59v+mGNjjt2rmUhUYnkvkEgLp2FjNENUz6nnHRHknvRt/m7dqH/hHQwiNXhuBPnMC1c/2hrqzkpyxVO4Nz/vrs/0D/gDLiTv4o6HT67IXm7BA+fYGFkHnDjOPJpv24enQsVUMb/85/cFLCWGrB8A1/Co1FCdQHg+UzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716737186; c=relaxed/simple;
	bh=N4QhkZlmhiWBIA76nnMvdwLsXocaeGKo8ROxH4U65Zg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dP9/MgkEpUH8m5n3p3djO+EgPq6s2Y3Sb4klbXCwP7HkZnOjX0RSKCSM5XWzlq94qNPXlSsASze2ZuSATUYGTFb/zAtczYs7G1KcnvLIwtMOqWHuWgSL+98DWCTNSqPg1lBxiX8EbnRUHxeHQPLIR7oabyakCLDR1rhyW5LZz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1db7e5386so541082539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 08:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716737183; x=1717341983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vvfJnAuJ923mX1QXdJCIt4B8R1jVzhwLu0cni6wyq4=;
        b=YCR6wVvq31Slza+pVdzaOoSGjdekjGL4VEEbPwLEJLTbMP6bm2VH+JELE3MVGvuP3x
         DqzUcNdh5SOIhRVM7BzmPXRak1NVKND4zpqtYSp2dqEI29AIAqzURZ5e8siX27HwAhmJ
         qICdmFQVXcZsYuv6e2m19KVG+M269nUzZHOp2mw0svdLTiQ3tz2tmYjywLpwf2llDUuQ
         fcYPqzoQZDHFTblG+dbXVJgl38EgXr4Qq4RfgzVhqkCtggEYxljcrRgJiX8FkTGzh/qs
         waMmtVqfhrELndFVry8CZByZ8XrhJAgmqCtPlMaq4Tr4R4aFcD8vcZ3GHlM4g+c6uWFn
         wf3w==
X-Forwarded-Encrypted: i=1; AJvYcCWGi5dU7oHuCC4uA9Mf6lU3fRO9Ay/TSXtczZM/gMfTdhPO2GsvC2vyvuSB/7AZmmA+a1hprgqrKkcYS8koAgcfUF/zwAe4lzF9LaPu
X-Gm-Message-State: AOJu0YzGSl6R54ta+eilyEB5EMkAZrfJaJ6u1LmOlaCnOmn+z9jZRn8x
	K8xsGuhEWTAKKl4ksTcGBN61zCS49Jsk/PxEc9K0YBx8NgDQdC+woQ2dC9yfSf4skNZ7fnhD4nI
	QuJ6T/GnfhN/sruOwDNn3EcVErdsqMOkSFJaEXwrZJ/LXiFP6lrVTFdw=
X-Google-Smtp-Source: AGHT+IGxckMjc+vVFuHa/WvqrlGNNuCFhKyovWe0vrmGsUE4tHJNm4DXWfk+H/wYtMEXbk3OrAU96TPTkJjpu1SCm79MyuGP/7yw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cf0a:0:b0:374:491c:6567 with SMTP id
 e9e14a558f8ab-374491c6d53mr1121595ab.5.1716737183245; Sun, 26 May 2024
 08:26:23 -0700 (PDT)
Date: Sun, 26 May 2024 08:26:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fafe0906195d0585@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in bch2_fallocate_dispatch
From: syzbot <syzbot+0527f53d2da9f65d41cb@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1566f392980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34e05c35ec964e75
dashboard link: https://syzkaller.appspot.com/bug?extid=0527f53d2da9f65d41cb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/99e44ece48d2/disk-56fb6f92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2997a3e91a46/vmlinux-56fb6f92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f788e8712a0/bzImage-56fb6f92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0527f53d2da9f65d41cb@syzkaller.appspotmail.com

INFO: task syz-executor.1:11146 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-12277-g56fb6f92854f #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:26640 pid:11146 tgid:11124 ppid:10161  flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 inode_lock include/linux/fs.h:791 [inline]
 bch2_fallocate_dispatch+0x295/0x3810 fs/bcachefs/fs-io.c:774
 vfs_fallocate+0x564/0x6c0 fs/open.c:330
 do_vfs_ioctl+0x2592/0x2e50 fs/ioctl.c:886


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

