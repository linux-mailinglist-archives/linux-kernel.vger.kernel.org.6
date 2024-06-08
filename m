Return-Path: <linux-kernel+bounces-207173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DBE901342
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 20:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB371C20AAF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC1C1865A;
	Sat,  8 Jun 2024 18:46:26 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F71BC46
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717872386; cv=none; b=Nk7ns2pJdyvikSdLgnt4I8TAGK3y6JfgnL8EYaekdjZmrQec2/GfNNYvSqh/s6knJZF431k33FBYOxQLxnCRyGNr6OHb5LzY6NvprRqMf0zbKmCfa8LcuEYxE3iIYB6BKPqFWoneM5wSKNiq6CVUwBiqkD1tXwMmGgBdxDlacWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717872386; c=relaxed/simple;
	bh=FTsEzVY//d7md9QNRchU+SR97aMGSsZHiNUNXTDniYA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hlDjGbod0i1SBbYOGjK4SMVmWslxDveuMFO1ApuRN+EMf2BFt0prGen/Qz4EAjMyUx3t1ngtJFCadGAx9YdoluS0hEtAA/6Bu9AaiudCjOHK2iplJkGZoUVctdYoVBpirqwJxBzFNwplCOmLwYLAvIetddinRJ7oAyg9MI7G7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eb50e42c6aso333596439f.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 11:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717872384; x=1718477184;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3hCt9io7wd14ZV/rqVycTDv82Iixo5e/5LYZfu/3ew=;
        b=WIqlQXVdB4nWTIqecyrXGR/GNwAXEB9w2tQzU22/mLW4t5FoRIWJj9zmd8Z2LAkG9S
         cxOZ//iZoFJxmZwp0cotOMezzBXzu5kKj97fHG3+YZwq2NHSEE5p28UxEEHP8V6lepei
         rNXNBIi6/hft3dt/TxCAmtP6Rgkzl04ZKcFTPEkaw1wSIDQnOfmZMakFvtgoMT9y7mhu
         tJ4t/8aifkTQQlUQT4zoJWxosh3nJBKjyrt8/mPpYwq2KVzp00bUMQJGwYUS9fOjoiX9
         9AEZGLGiUJUx5cksbwSzRSNOUnSftyOW0XO0yOEgYAxakHoQXEA2mTofVMGpfXhqQunF
         5alg==
X-Forwarded-Encrypted: i=1; AJvYcCVfKHZ2Qa0yIQTenfA/bTcUVij/nZIY1kT3kTKs5y8ekrP3gWNZZgTrucBfUvSKKiFbQTVwmkvBe+T2THUdNdEP1Y+tQpovbg6M5MlB
X-Gm-Message-State: AOJu0Yzs9SIJwHEQcXtUNxHM0E5ymBQS4Oq3RoxMNP4WirEMilgXgz08
	7ik4O2iRtQJ0zWJZHyPpxD7Jxf9aWV6lh6Xc+i0NOFfIMg1YrRr4r2eVaeEzr9ounAJWQBs7sul
	/rqNHCCwURvSYhbB4gHSdgMGd9QFLxsrUSymKt7mRjc8jKPPf3L03UjI=
X-Google-Smtp-Source: AGHT+IEVK4W5Nb1TYvUdWpQN+xS2zF4T97HCWd1Niuy5IUFg3CZraESdaOLnJfZCOch9d3QDhnPuUQgsx8a/2k7d8NNKJb1N/0OV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3790:b0:4b9:942:8f30 with SMTP id
 8926c6da1cb9f-4b90942968amr41609173.3.1717872383737; Sat, 08 Jun 2024
 11:46:23 -0700 (PDT)
Date: Sat, 08 Jun 2024 11:46:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033d195061a6555c8@google.com>
Subject: [syzbot] [bpf?] INFO: task hung in bpf_prog_dev_bound_destroy
From: syzbot <syzbot+638395cff1c05c4a0128@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8a92980606e3 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e0f5ba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=638395cff1c05c4a0128
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fa5a3bdc8575/disk-8a929806.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f37ced39a44/vmlinux-8a929806.xz
kernel image: https://storage.googleapis.com/syzbot-assets/604ed8ab462f/bzImage-8a929806.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+638395cff1c05c4a0128@syzkaller.appspotmail.com

INFO: task kworker/0:5:5177 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc2-syzkaller-00235-g8a92980606e3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:20752 pid:5177  tgid:5177  ppid:2      flags:0x00004000
Workqueue: events bpf_prog_free_deferred
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 bpf_prog_dev_bound_destroy+0x76/0x590 kernel/bpf/offload.c:386
 bpf_prog_free_deferred+0x3c5/0x710 kernel/bpf/core.c:2784
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor.2:12871 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc2-syzkaller-00235-g8a92980606e3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:24912 pid:12871 tgid:12870 ppid:12213  flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077


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

