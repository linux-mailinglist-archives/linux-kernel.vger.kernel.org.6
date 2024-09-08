Return-Path: <linux-kernel+bounces-320008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254C970500
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 05:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8166BB21FCE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 03:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6158628DD0;
	Sun,  8 Sep 2024 03:58:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9ED272
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725767885; cv=none; b=J6Lf2iC40ADJmzmh/lE1iehsEJVeH1uXQJhqjF0+7kOsZSKQKhhY7OWUxtIFyDK5/mNIXMe8q7CDNfiZ8dKcHcxjYllAhyC2Tv33pyh5GCJ+0Fl/uMd7esII886VAp8kq9L5HZnWxgeVQ5pSMwRJundlXrZnWQN2yL4zjPGSVq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725767885; c=relaxed/simple;
	bh=sb8/1hyBdJeHgPK+JHbNtcNL/yyzWlbQY5ZjI3QSoXQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dBvqhlmMFfjX4LU3Xo/DeeKG+yh1nSNcU2VWAYL3PJrLCZ52xqvQ6dixO7+XHCKMGPn9eDVhLGLmvu8SU7yezib82+rvOJiwx/vammKdo4PKmq4h4BOW3FvQbwTly51JlNjvaCxYZYlyL7TJCBCSMKfddK2UZw9/Yac1+HXDwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa94d4683so137939839f.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 20:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725767882; x=1726372682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXTNnT0jAnyYAYa1VaX0AKdN0AG3WIlR0bL42caiXTs=;
        b=alzk27piXDBpYQoYZvI9XwShr5qccfz+HdumHTGzE9HeVMzNxVrmXidpCagf6vQOwp
         LowVgk+93o8Q8We3heziZWxFp/k0dPiEGj7cK2cFezkIIKV2r6eO/hYb+TiBr/cOd1EH
         aXtKyf0HWn83RpGZhSmkXkpLNCxk7HHi0n1DyjUUiyF9tXWeDURDKEzHKuQauUVqVE+t
         BjNE7V0AFOKnIlOo0tVTIZlXBR4O6JOosYolWnruNlCa7W1BX2/8uOHSM7COscrd4THF
         v9Gskjy99lnemQ+csBrKp73yOK2dCfncvxGWWagNDoXVpaRCWBC38k0phFOZLLOW/S2O
         T7qA==
X-Forwarded-Encrypted: i=1; AJvYcCXpcvmuh11dSScUVNvTztQdsOAzZD8H7rgCnXoAsrh85/hy2Ikr45DkLwWN44svHcPLFTShu1eZAZ6CgPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDG9vdQmwC90b8s0gkwU//qkhhAbuDelbGwtJPI4+3pMtV0VX
	2d+wDgV15iqzVRUH7qtAAZZT5qPcxvnv0uhUNR4N/jaWKnGMeVHX9cK2apT9PRANUCgVomLeKHC
	7W419eXOxlIthIvCD7PIoqPg1X9R27NbMtMaOjWEB00h5UtVfVJgUkEQ=
X-Google-Smtp-Source: AGHT+IGlj8EUGudSN9lAMe25eZitnBf0Bk2rZqom24BnXE1O4BkYMUo0G/dAOo90hOQ1jxyz0gSx1eINNoc3MkcSTdYObjbL8dAg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6347:b0:82a:a43f:5bcc with SMTP id
 ca18e2360f4ac-82aa43f5c16mr430727839f.7.1725767882588; Sat, 07 Sep 2024
 20:58:02 -0700 (PDT)
Date: Sat, 07 Sep 2024 20:58:02 -0700
In-Reply-To: <tencent_716CE97A03B68449F760577CC6C6336E2305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b550d062193a529@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in l2cap_recv_frame

Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
============================================
WARNING: possible recursive locking detected
6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0 Not tainted
--------------------------------------------
kworker/u9:1/4615 is trying to acquire lock:
ffff888062afc078 (&hdev->lock){+.+.}-{3:3}, at: l2cap_connect_req net/bluetooth/l2cap_core.c:4075 [inline]
ffff888062afc078 (&hdev->lock){+.+.}-{3:3}, at: l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
ffff888062afc078 (&hdev->lock){+.+.}-{3:3}, at: l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
ffff888062afc078 (&hdev->lock){+.+.}-{3:3}, at: l2cap_recv_frame+0xe9d/0x8eb0 net/bluetooth/l2cap_core.c:6825

but task is already holding lock:
ffff888062afc078 (&hdev->lock){+.+.}-{3:3}, at: hci_acldata_packet net/bluetooth/hci_core.c:3783 [inline]
ffff888062afc078 (&hdev->lock){+.+.}-{3:3}, at: hci_rx_work+0x96b/0x1610 net/bluetooth/hci_core.c:4029

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&hdev->lock);
  lock(&hdev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/u9:1/4615:
 #0: ffff8880301df948 ((wq_completion)hci2#2){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000d83fd80 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff888062afc078 (&hdev->lock){+.+.}-{3:3}, at: hci_acldata_packet net/bluetooth/hci_core.c:3783 [inline]
 #2: ffff888062afc078 (&hdev->lock){+.+.}-{3:3}, at: hci_rx_work+0x96b/0x1610 net/bluetooth/hci_core.c:4029

stack backtrace:
CPU: 0 UID: 0 PID: 4615 Comm: kworker/u9:1 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci2 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain kernel/locking/lockdep.c:3855 [inline]
 __lock_acquire+0x2167/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 l2cap_connect_req net/bluetooth/l2cap_core.c:4075 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0xe9d/0x8eb0 net/bluetooth/l2cap_core.c:6825
 l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3790 [inline]
 hci_rx_work+0xaa1/0x1610 net/bluetooth/hci_core.c:4029
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1656abc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165a0e00580000


