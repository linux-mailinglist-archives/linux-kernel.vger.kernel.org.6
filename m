Return-Path: <linux-kernel+bounces-356647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E232E99648F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6982CB258A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E47189F5C;
	Wed,  9 Oct 2024 09:12:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F61898ED
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465128; cv=none; b=GxsQQRmHDptckctW8Hy8Ogb5t7DIT9qtfQhVZ8NYHWC+Q7GlxlxNp9Am83sh/poavmSG0wFGhoSzkRY7sqBIIMiYTF1xlFBdm7aSopBVPYKQa+rpQwr4zv9x8kdxP8abrOdZyF7ruwFvAZEgYa9UVfz/bkSdRAOHmfoJ9Ncpyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465128; c=relaxed/simple;
	bh=fBOsOdXdlrVQ81Ln0aH+LPfkJfHEU2KmXlLqLobigYU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CFMhCnW2P3Q8TUeq28UPSiMEzU+I4W/ABn1IyTy3TMgJ8CvUj/XlrzH8DdrDqVeXBqbfZoNcSXxT22AcxGwKmyZ83HTxISOwG6VDUFO5qPd2Wf/YmLOpKYv5b1pzoY/8KhADJO/FOFdSRXag2T6/Mqyvs53yFuQMTTfYjiqbEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a363981933so95439605ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 02:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728465126; x=1729069926;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvaf2LtqcasV3OXXCS39NCxcyuV8JcKiTMISyTMZ9ks=;
        b=v2toFde7Q7WsrClF+jQ1AWmXGu5aPWRha2Y2dXillIKCefzLEgnYN+oJvVqaxDZVqm
         Lvn8jXrC67pRC3o7QOerr1m6QoCIPmlfqDzq5Q9YqkpudnBdAi/Y8Lb9/SQjbbRRkey+
         8/n+I14AyeeVhK4Za+0ox/+u9zLlA8bCLPx7saP+/7hPE4Uo5ebafft8+To/F6UqoqqE
         wyjLT1SjlC0S2CyU0WFXsz0DNujeHQH04tjPhJLGQmqtWvmJ2C91lHneciUaK2b3OrPR
         o/PawtlPuCbLZzFYfNrBd8HRpZYGB5raWlxRH1fm+DdlgPtcVhpo7an+Z+AjfIVbrnBK
         DQBg==
X-Forwarded-Encrypted: i=1; AJvYcCUnKG4Qkx3Ur6CRsoIymV0TgJxztnovyesa3iSeuohMrd/cffWSoTueTZdJXKjN2xfGsuCfgFTV/2U8UnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8kAjMt81Mksh+RrtU0zvddyg3N8U+p220myn2hTs8Em+1zaQ4
	EZPPco5EGUzogxjSSogSRoeQgUkU+JCkEqth3fyBZJn/7bKG2xjhnonezVWJB/hW4sV+wreCIhZ
	COQ9+lE9lNmcsnL9RCfICed5sOVfUhlfadsMeC3rJPGM4QenhCrIiKQs=
X-Google-Smtp-Source: AGHT+IFYmWhgkLm6oNvarScgD7IMuzXM8XM6UET2xIt1wrsc403Wf5wjOEqDpAxYuI0kJ3e+rUJgn8g6ol8wAByCte6YP5+P5McM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:3a0:909c:812d with SMTP id
 e9e14a558f8ab-3a397d0a552mr14608035ab.11.1728465125755; Wed, 09 Oct 2024
 02:12:05 -0700 (PDT)
Date: Wed, 09 Oct 2024 02:12:05 -0700
In-Reply-To: <tencent_50D0A5FA0DA39222DD8A5DDF192D4FC80D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670648e5.050a0220.3f80e.0028.GAE@google.com>
Subject: Re: [syzbot] [usb?] possible deadlock in usb_deregister_dev (3)
From: syzbot <syzbot+1f8ca5ee82576ec01f12@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in chaoskey_release

============================================
WARNING: possible recursive locking detected
6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0 Not tainted
--------------------------------------------
syz.1.64/6626 is trying to acquire lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x15d/0x2c0 drivers/usb/misc/chaoskey.c:322

but task is already holding lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x7f/0x2c0 drivers/usb/misc/chaoskey.c:299

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(chaoskey_list_lock);
  lock(chaoskey_list_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz.1.64/6626:
 #0: ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x7f/0x2c0 drivers/usb/misc/chaoskey.c:299

stack backtrace:
CPU: 0 UID: 0 PID: 6626 Comm: syz.1.64 Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x2e3/0x410 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain kernel/locking/lockdep.c:3891 [inline]
 __lock_acquire+0x2185/0x3ce0 kernel/locking/lockdep.c:5202
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 chaoskey_release+0x15d/0x2c0 drivers/usb/misc/chaoskey.c:322
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x24e/0x260 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2a386fdff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff33961988 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000001f821 RCX: 00007f2a386fdff9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f2a388b7a80 R08: 0000000000000001 R09: 00007fff33961c7f
R10: 00007f2a38580000 R11: 0000000000000246 R12: 0000000000020419
R13: 00007fff33961a90 R14: 0000000000000bea R15: ffffffffffffffff
 </TASK>


Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13c19f67980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=1f8ca5ee82576ec01f12
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10089f9f980000


