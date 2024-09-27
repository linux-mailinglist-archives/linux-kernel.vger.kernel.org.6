Return-Path: <linux-kernel+bounces-341992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BBA98895F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F62A1C229F2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FE11C1AA7;
	Fri, 27 Sep 2024 16:53:30 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72699139587
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456009; cv=none; b=BmWtktZFRw8RKYk6KrgAiC7l3sCwf5k1Uaf92p6K/TI/TQl/1Jf42eteh/Aow2HHz05BbmGvttxkCzNMp/QQlNZiax0XWazXOUYdG3f+x2Wucpl9fh65G6O+q4VqHFfPzumiupWq5bQ9VkBeCxqsVhStUTFABGBzQQbq96YheI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456009; c=relaxed/simple;
	bh=HbNSFkbC/4y/P9Ba5K39AMbcnzlPTdiRQBsZeQhkrv8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BEo9HVQqMpaa8REv0SP/0+7qjTN4hB8nHMbwwX5isgi2DjjS7oNqwb2NwyhHJQ547f/R7iP4oUCs1yHqkhWl4/exFFahoWn2dLADSV3aDtA9kEZdoscneID+EJQKNiGoLFhTMEdvBBaciWIJNCXdcZNJ7G3riZbi8gNBQ1gYzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cdb4971b9so248887139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727456007; x=1728060807;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgG/ygLGocIzopMcfdOssCN03xQrocYaesipZFj2uiI=;
        b=IzBEqYHwImTniFxa1zx51GVDhLAkJRsHrBbZ1xn8K2vUdYJxC8vOp76kAk8M0uFBI7
         xTQ74BQ7Wq+lZitDO0FeVlMBA0Pfteak5+muKkcv24V41LVbqcb97xdEV9+uEt3H3501
         CJmbPPiWKqA+kSRND87rKPi8Y4W4KAlE1E7cTGimHptSa+1dt+LRbSRSOuCBSENx02lQ
         fErPOCNF52Is+VlPr58hrGBlW8qeSjswYz2Wr1xM8a5Ny3Fm8Hgfs+PEkql79+Oa90Tg
         VauZkv/aQR+LiWrb6fJj3iIMuYNd7xy7C+maFL5uJn0uYFkymVH9anxRhPgSkPT0ji9w
         lJvA==
X-Forwarded-Encrypted: i=1; AJvYcCXF+HpcU5Mf0ja+Luo0GMPnrQH/r0IW35yPl9r5N01/iPfTZBG3G3I40UqZv3IkXAmXcrLymJVEGZq+e7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF5H39pSJwIsE2DvX+v5km/1tPQbmr5G9oswUnBOjCLON1aLFU
	/Yoju6q/xz4hVTVKBlrlq8mxC1XA7mewvQpwXDdh0RsZ3IVriOxvC0CtplxLs0SB75isgYE6haL
	mHg4LVMEEbG4lO4Ih3GUGFRPjKJH1Gq47+0nn6XWPDxyv5zvr95HrsH0=
X-Google-Smtp-Source: AGHT+IFLcsTwZkkrPecbB6b2x8xxn5b3sGmUMzGQ4h9C3xp8xEdNTP44IfHSYDBkGxlYjVO1w+LHh/ffAG4Kc/WUsfbl8O1dYX6n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ce:b0:3a0:9d2b:2420 with SMTP id
 e9e14a558f8ab-3a3452d1fa0mr30894455ab.25.1727456007561; Fri, 27 Sep 2024
 09:53:27 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:53:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6e307.050a0220.38ace9.002c.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in crda_timeout_work (8)
From: syzbot <syzbot+d41f74db64598e0b5016@syzkaller.appspotmail.com>
To: bristot@kernel.org, davem@davemloft.net, edumazet@google.com, 
	johannes@sipsolutions.net, juri.lelli@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, vineeth@bitbyteword.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aa486552a110 Merge tag 'memblock-v6.12-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ae0507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c71bad3e6ab6955
dashboard link: https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170c659f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a7caa9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c6beec63de3/disk-aa486552.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa35efb3dd39/vmlinux-aa486552.xz
kernel image: https://storage.googleapis.com/syzbot-assets/537d8ff45d85/bzImage-aa486552.xz

The issue was bisected to:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15684507980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17684507980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13684507980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d41f74db64598e0b5016@syzkaller.appspotmail.com
Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")

INFO: task kworker/1:1:46 blocked for more than 144 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:24304 pid:46    tgid:46    ppid:2      flags:0x00004000
Workqueue: events_power_efficient crda_timeout_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/25:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

