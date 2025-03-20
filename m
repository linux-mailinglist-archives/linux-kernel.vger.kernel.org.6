Return-Path: <linux-kernel+bounces-570287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EBEA6AE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331079A2481
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3B6227E9F;
	Thu, 20 Mar 2025 19:09:39 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BC227B94
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497778; cv=none; b=XBByuNIzlEPe25jsekybijZVOh720ZM2wZbCPoepp+Hir6BaQUDsEmNYH9Uz68Hh+r3HD/JpnxQ8vAewUWUvfkqRWMQ0msbp9SEiJrh0pGDDjfKejOVroLfPL3y01l3qxCtYWv7DLYqByy1LLFaV65GLTN1yHzAJZ14cPe7K2mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497778; c=relaxed/simple;
	bh=XP2c0iOMlju/KaYPIMWGPY6gaj0IGteFbxfj+WLhYJA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qw9Ho4Gp0Hb7LLF+ZclJywBOx8nLt6n/K2OtwVN8eiANq8E+QwBJWtau9CXXkUgPVqiEIZM9eHedW79IFM7SgmKZx2RRgXcSTufnSc/Sj8WQjC4RW1aoTTzL7Ga6WWm3ueRXX/rx7i6Zz3lomAByQbCZWLyQN+cWC2+gMAkYOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b3a6c37e2so119135539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497776; x=1743102576;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJNBSRkCkwXpy3/GTKSlTshNCEplDM0arhTkqcmj6Y4=;
        b=L5hf+2reyrtfx18c6CEMcDj9msnIfh6DMYTAdfzG5vkNFobJH2UAzdi0a0jTLqLtfl
         5VEQiteLUoY7LC3hmmbH59V9DHkg6OEmh1Jxu+8uUH1IFsZfMRYIh1wyI58Aw6APbfbX
         szdWixiGKncDEO29bDBxmXamISgRDoLmMyeR41mK+SmBHjAsEwS1g1zZpSzFA5hBZwPu
         JBAMJDbhTqVhRwfA5OqCvRVb50bDHZoOxEMYneP2sgODXy9SfcxZtGwgzBvSMPRkjERK
         Yq41oSS/qttK9Au8HJ8qXhaRcm1hFxZ28QvsD+pqiUBmxMile4o9cIWzmaTTqjLiMrPp
         DNuw==
X-Forwarded-Encrypted: i=1; AJvYcCVD7J4Fa4AKTFmjCydxlZOtjfV9oVNtGS3142cgNwmzIWISkd9HmlAgKgQN4S/P/nT+Qrk/xozA49pmZgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxomliOEzeHVIIAKEf/K0qksZSOIchhOyggwNfGAolIqv3vCB7m
	Ip9O5Jj3EwqQwD2AlVs3V61N54aiIxta3/H++uD9ua0FDHvlxP21UpZwv1I7zMGk59bwJMyAMa7
	x7y0049s+zYMgNQ1ztoUtS2n7zbBg79fMWFZjFVuGQNgywB4GJACD4NU=
X-Google-Smtp-Source: AGHT+IFElqRZlDcgS4Dvjb+fprnftS6tMrdLBS/A7MAxW7UI0jTqmQo3MShpEuXyw3vp10MODOxisucR6/0VHyhajkYCzpkcGlBn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348b:b0:3d3:dd32:73d5 with SMTP id
 e9e14a558f8ab-3d5960cd11cmr8785025ab.4.1742497776240; Thu, 20 Mar 2025
 12:09:36 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:09:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs (4)
From: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a7f2e10ecd8f Merge tag 'hwmon-fixes-for-v6.14-rc8/6.14' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114fee98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f33d372c4021745
dashboard link: https://syzkaller.appspot.com/bug?extid=1c486d0b62032c82a968
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/614aabc71b48/disk-a7f2e10e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d47dd90a010a/vmlinux-a7f2e10e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/418d8cf8782b/bzImage-a7f2e10e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in bprm_execve / copy_fs

write to 0xffff8881044f8250 of 4 bytes by task 13692 on cpu 0:
 bprm_execve+0x748/0x9c0 fs/exec.c:1884
 do_execveat_common+0x769/0x7e0 fs/exec.c:1966
 do_execveat fs/exec.c:2051 [inline]
 __do_sys_execveat fs/exec.c:2125 [inline]
 __se_sys_execveat fs/exec.c:2119 [inline]
 __x64_sys_execveat+0x75/0x90 fs/exec.c:2119
 x64_sys_call+0x291e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:323
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881044f8250 of 4 bytes by task 13686 on cpu 1:
 copy_fs+0x95/0xf0 kernel/fork.c:1770
 copy_process+0xc91/0x1f50 kernel/fork.c:2394
 kernel_clone+0x167/0x5e0 kernel/fork.c:2815
 __do_sys_clone3 kernel/fork.c:3119 [inline]
 __se_sys_clone3+0x1c1/0x200 kernel/fork.c:3098
 __x64_sys_clone3+0x31/0x40 kernel/fork.c:3098
 x64_sys_call+0x2d56/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:436
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000001 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 13686 Comm: syz.1.3826 Not tainted 6.14.0-rc7-syzkaller-00074-ga7f2e10ecd8f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
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

