Return-Path: <linux-kernel+bounces-350158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7EB990098
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CE51C21E47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1040714A609;
	Fri,  4 Oct 2024 10:12:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844A146A6B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036746; cv=none; b=eC7E4ktnJedU63fPEaMnHLSrzvOoZGLpQDmgwHg1R0RVh79WVE0hXixFp2rXrHHY0txIdpHoKAdyIeBUqMtr3EyW5wUtizXyrIet4Wko9s7qKk18Bdm6IYZSeY3+heFBcwaXfmUjDDQ528xuquvHJ43SS/5hbYdrr/CgpAy1pKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036746; c=relaxed/simple;
	bh=pNf/rzJxe0Z06TkHyzNNz1wueA0KFpFvc6UU15JtpfI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KWe4XlKVrfLIgbrxZs3Xp/shBA+LjBNm3rH9RbU1zZIOfdwitthDCwUI8AFHL1O61Pgm5kiT0pJx8EG+9IFeOIiky2BTJxJQy2731mRwaGDsaBaeyGnAftVWVqffNfL6JJL9fqJ5U0rTsnMjOYqoqbklxRfpwlDivjpbSO311yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a342e872a7so22302505ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 03:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728036744; x=1728641544;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oW7MK9FY5Yv/AwRaCSoGhMGbAK/tZyV2Xtz+SqN4f7M=;
        b=MAetVBilp6qDAY2f9N35mxsZ6HN2vCA1uvPo6SHpZ0sWbsAMU4gT78QpM8f2s4TEzI
         D7E5Visg8Xvi1xvup7G2YzMcI39WoB9c0UN4lVmYDXTv6xHSPyt9dkcBU4O5EeYIVn7G
         0DCI1+BbuPmlhTJ5YMgrRY6hnbCzlEwUY+FL4rqHCsyPPmd1kOLhU67SYVEwIyy7MVf1
         8T81SR0X1F1Kx4qvSwrWUrekalVGt2TwMMqZUlHWwX/4vsD6tNo/MbRxhiR161+SM1CK
         I9O5Tu2lRCWYmQHX23cHJYTYyMHXQF8ivd1TyrifOrVwym007m2Tc7Xnhe+E5Yr5CBPY
         Sq5g==
X-Gm-Message-State: AOJu0Yycs6bL6ZpO+ockPzBnt8BYSitJleEinEQtnMh7L+L5XRz1C0B9
	cRVtbyWA8j82yQNAPmLgdZYh8f/Fsi9znVZ6c/PtfuYREvtsg4LowLKFVHbCoWZMum81vlCoqGs
	L0zdy2cmSQtR1/P8d5xPBLiZD2sqTXHBpsSxJR4mk0QpMTeRh/wl2RbQ=
X-Google-Smtp-Source: AGHT+IG5PPlvETmWcuYTrfEW7SxMz12lBRfQ0Heaz3w1SEiUOBcoRSF1Tmk+FneP9ppg9KuoLScqZl7Nkiu1VwwkYUyFIAArF2vG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cb:b0:3a3:49f0:f425 with SMTP id
 e9e14a558f8ab-3a3757d8767mr20109365ab.0.1728036744402; Fri, 04 Oct 2024
 03:12:24 -0700 (PDT)
Date: Fri, 04 Oct 2024 03:12:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ffbf88.050a0220.49194.0486.GAE@google.com>
Subject: [syzbot] [kernel?] KCSAN: data-race in do_mq_timedreceive /
 msg_insert (4)
From: syzbot <syzbot+2ba73bf53a28c019b9b1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0c559323bbaa Merge tag 'rust-fixes-6.12' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fc0d80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95098faba89c70c9
dashboard link: https://syzkaller.appspot.com/bug?extid=2ba73bf53a28c019b9b1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/415934cb0f6d/disk-0c559323.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19b092990019/vmlinux-0c559323.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e86fa4c4df0/bzImage-0c559323.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ba73bf53a28c019b9b1@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in do_mq_timedreceive / msg_insert

write to 0xffff888114787e90 of 8 bytes by task 9929 on cpu 1:
 msg_insert+0x10a/0x2e0 ipc/mqueue.c:212
 do_mq_timedsend+0x465/0xa00 ipc/mqueue.c:1162
 __do_sys_mq_timedsend ipc/mqueue.c:1295 [inline]
 __se_sys_mq_timedsend ipc/mqueue.c:1284 [inline]
 __x64_sys_mq_timedsend+0xca/0x150 ipc/mqueue.c:1284
 x64_sys_call+0x26c5/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:243
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888114787e90 of 8 bytes by task 9924 on cpu 0:
 do_mq_timedreceive+0x1fb/0x6d0 ipc/mqueue.c:1231
 __do_sys_mq_timedreceive ipc/mqueue.c:1309 [inline]
 __se_sys_mq_timedreceive ipc/mqueue.c:1298 [inline]
 __x64_sys_mq_timedreceive+0xca/0x150 ipc/mqueue.c:1298
 x64_sys_call+0xccf/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:244
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888134b65740 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 9924 Comm: syz.0.1959 Tainted: G        W          6.12.0-rc1-syzkaller-00125-g0c559323bbaa #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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

