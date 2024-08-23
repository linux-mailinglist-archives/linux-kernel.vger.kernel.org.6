Return-Path: <linux-kernel+bounces-298478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3327195C7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574551C25922
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9643B14387B;
	Fri, 23 Aug 2024 08:15:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D86BFA5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400927; cv=none; b=OqRKuqISGck6m8H8mRno40q/sMLVpU8JI0LQyRbuQRT3cz3KnvvK8lyNfmbWsh35x5qqKOmoxTJjO/fUJGkRaTyzqgSoLnjPXCADP13djwCEiwPAvN0aV29dBXBYp+k7C+igqRweuYwpVvRR3cw8CtI7n8ZXL95FWKQp+mHralA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400927; c=relaxed/simple;
	bh=fza9SUlY/fYm2LJp1NJE3IlBYIobs6R61347dV6ePwU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LOmqRpS+5mdx0TKr26Q9i7SU87kud+Y+7OBTvVAq0f5KGW7Xzk7KjybvlfWJg2YVx7uJU/t5lfnYJzew7TunPzk5og+aMFWyucHPFyq8/sYIqB1GY7V7pIElXUY8xRufJzaHcg0oaKIhEY1HFKRadbGHdMcqByxmVKq6YZCJc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f7fa42463so144001939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724400925; x=1725005725;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opqIjgLOpo4TFy8UCPig7PrgbF9WMRL24VPubk6tA0U=;
        b=B3EbYlGGO3BHPFqgfqnnsPc94yowsJiGKipda5AneswtUdfW/B9Ql2EvYHVUoKLGWJ
         qNU48PiF67j9ZKGJvJwFIL/Fz3TxvDuizC1k98V1aG1w06F+gj/PuMAkeub6aKFGtC1z
         SnSwipB/Krv/nfLnWeCKjuLS6BBBBdADbV+LKNksmhDGz5glIBJR6UWSk2iKqo1/R9wx
         nsbpPwYKP/eSQQCBlLid/TdbJOs+bJZ6TDeUpUwp9SjnKBC2opVYrOp/ajsVna2ylMWS
         ZfrT2bWwwWcfjOwmiIJGkewDtQRnKAQqwcEUnZLFMYaxnZCmTrYEvE79Z5b76kZuBh5N
         n2qw==
X-Gm-Message-State: AOJu0YxFd2igJ1wXcohVy7yj3hClzb2j9bGauNswkjEnSBsFuvtMnpU0
	SuD0kFbKaXsEydbnn3MmojaKOw67IS8nvddw2XtcyG1IGMM2WxCoYPnYJxN0J4onelUkEdtSfxL
	W4oTmF56Ds98m49dCg5C8OkX6E6YTT5HiQlqurnwvnz4UpmojZLfomUM=
X-Google-Smtp-Source: AGHT+IFUpqfgGaMC5MaoyTlDoqQhnWSJHGNFUdqeTRR1YDKJIx3iJcZo+B1oV4RLZv0fSKIyyN6jP5Poyc2trTpQKI6CuOFOJN/w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8904:b0:4cc:d5e0:a114 with SMTP id
 8926c6da1cb9f-4ce81c3e3a7mr95351173.2.1724400924791; Fri, 23 Aug 2024
 01:15:24 -0700 (PDT)
Date: Fri, 23 Aug 2024 01:15:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092a8070620556089@google.com>
Subject: [syzbot] [selinux?] KCSAN: data-race in inode_doinit_with_dentry / selinux_file_open
From: syzbot <syzbot+319ed1769c0078257262@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aa0743a22936 Merge tag 'net-6.11-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12609bd5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3aa0f597417bf8c7
dashboard link: https://syzkaller.appspot.com/bug?extid=319ed1769c0078257262
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5e2399df8c24/disk-aa0743a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32d04570bb63/vmlinux-aa0743a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/153aaf559bf9/bzImage-aa0743a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+319ed1769c0078257262@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in inode_doinit_with_dentry / selinux_file_open

write to 0xffff888114a3392a of 1 bytes by task 5741 on cpu 0:
 inode_doinit_with_dentry+0x29c/0x840 security/selinux/hooks.c:1443
 __inode_security_revalidate security/selinux/hooks.c:295 [inline]
 inode_security security/selinux/hooks.c:320 [inline]
 selinux_file_open+0x101/0x3b0 security/selinux/hooks.c:3979
 security_file_open+0x3a/0x70 security/security.c:2988
 do_dentry_open+0x22e/0xa50 fs/open.c:946
 vfs_open+0x3b/0x1f0 fs/open.c:1089
 dentry_open+0x4a/0x90 fs/open.c:1112
 pidfs_alloc_file+0xe6/0x150 fs/pidfs.c:404
 __pidfd_prepare kernel/fork.c:2013 [inline]
 pidfd_prepare+0xa0/0x120 kernel/fork.c:2074
 pidfd_create kernel/pid.c:608 [inline]
 __do_sys_pidfd_open kernel/pid.c:644 [inline]
 __se_sys_pidfd_open+0x123/0x240 kernel/pid.c:629
 __x64_sys_pidfd_open+0x31/0x40 kernel/pid.c:629
 x64_sys_call+0x2873/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:435
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888114a3392a of 1 bytes by task 5740 on cpu 1:
 __inode_security_revalidate security/selinux/hooks.c:286 [inline]
 inode_security security/selinux/hooks.c:320 [inline]
 selinux_file_open+0xce/0x3b0 security/selinux/hooks.c:3979
 security_file_open+0x3a/0x70 security/security.c:2988
 do_dentry_open+0x22e/0xa50 fs/open.c:946
 vfs_open+0x3b/0x1f0 fs/open.c:1089
 dentry_open+0x4a/0x90 fs/open.c:1112
 pidfs_alloc_file+0xe6/0x150 fs/pidfs.c:404
 __pidfd_prepare kernel/fork.c:2013 [inline]
 pidfd_prepare+0xa0/0x120 kernel/fork.c:2074
 pidfd_create kernel/pid.c:608 [inline]
 __do_sys_pidfd_open kernel/pid.c:644 [inline]
 __se_sys_pidfd_open+0x123/0x240 kernel/pid.c:629
 __x64_sys_pidfd_open+0x31/0x40 kernel/pid.c:629
 x64_sys_call+0x2873/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:435
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00 -> 0x01

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 5740 Comm: syz.0.725 Not tainted 6.11.0-rc4-syzkaller-00135-gaa0743a22936 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================
netlink: 16 bytes leftover after parsing attributes in process `syz.0.725'.


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

