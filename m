Return-Path: <linux-kernel+bounces-254935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C2E933973
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572261F22AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239345BEF;
	Wed, 17 Jul 2024 08:55:22 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD93D3BF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206521; cv=none; b=cM0Q9PGQzW0ZC0sS71bikdDE1XqxKiv1DzNBZ9pHDo+em/wTThbKA2OsY4AcZnxbCveMWuj4eDjj2s7jTM14peYvXH3ZV0vbfGkEJy36k/g5bIXP1UHC10p9gDYD0EvXLPX/PTv4ffNHXfwEpR2cyRlqN21kdn7MwGKnLwjy+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206521; c=relaxed/simple;
	bh=1o9NnCS5PFgehegy/2iCaP/tZvyPdrd9+bHy87ixTrA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sSztFXKY1xiRjKbJxuVTkrRxMEpBJ3pdlCZPK05mRURilb7Eou2Sy1hbUFmh/3uCKu4i6y29HwXJJchMLdJvn3BoJ0abcKQ9tea/jScauQSnq6ZHIr85nW2gZbUPykKLsbph+dCL2Vqrl/DqOYxBAERO10Vn4FFGdRQeMkiiKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8045e14c387so144609939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721206519; x=1721811319;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdDPjV/eZIgLnqahMbmgyG641NqS6NNL12DNmPmds4A=;
        b=WuYa0HtAhbsDnwdFFEbhAHjDQsniPT59VWN8k+fyX8vAoLb5ouslg8fjjh9uuU1x6b
         DtUQUHAoleFzL50GpLHzW9OUhMt+doOrYEH8HvoxeWDcy+2zp4v0YrSe4HrDzWjRZNKy
         UFDUuVNKlEY2GqMclzQ0iyW1WGoq2TicjZol5n8JBmE3Q6rNvt/4H9folZyGn3BqL/eE
         bJHXQOb9ZS64T7vOy66vptsqmOBwMB93Th75nVvOg8bKKSFozbWlT/Y8mNnX5k/jlGGU
         a8lWd2De4oxThYmgAr50GYKmDgj24E7EwjjJGByXjLedisECWrKpzDuExccTgY6XFVlw
         KXzw==
X-Forwarded-Encrypted: i=1; AJvYcCWWT7shKME6AO8f9+N9CperuBy0F4C2YVub53eN6zVD2dGBDbG8p0i5FsldpZNwFcdujokVx08ewnpri5B3NGf+uaZrUIhexkcsRgJ8
X-Gm-Message-State: AOJu0YzBUn5QCS44UNzJs0pSWfr2OMDa489GoEiqb4iwNm+SGKiblYuf
	uuslKhWZkJGzQ3ZiqNOdjjj0+SHYgEPLnMqMp778QmFCQGof7gsa9AsXfDtB7yplQGRManAk8nD
	lyoVioqqxFQMhGAnp9LXCgScEo96jy3SAok/0WwctCKz076/URoYUnfo=
X-Google-Smtp-Source: AGHT+IHxVUdQxdjp7BOCw87PPq2Jugv5RDYoWPi4+D9EoJEGYyQgZrDe6jH2oUBnr22TyhVbs0JLmqFH1tl+kbNusX0rihz+k0i4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:b0:4bb:5dc8:5a77 with SMTP id
 8926c6da1cb9f-4c21567f207mr30170173.0.1721206519255; Wed, 17 Jul 2024
 01:55:19 -0700 (PDT)
Date: Wed, 17 Jul 2024 01:55:19 -0700
In-Reply-To: <0000000000000346a6061cc5b897@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a80cf061d6d9f16@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in __cfg80211_bss_update (2)
From: syzbot <syzbot+1a797e1c81be78a2ace7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    58f9416d413a Merge branch 'ice-support-to-dump-phy-config-..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14cae9e9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=1a797e1c81be78a2ace7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152be1fd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16446b4e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3fb480f5ebf6/disk-58f9416d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a62eb04b3aa/vmlinux-58f9416d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67d14a897f84/bzImage-58f9416d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a797e1c81be78a2ace7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 24 at net/wireless/scan.c:1743 cfg80211_combine_bsses net/wireless/scan.c:1743 [inline]
WARNING: CPU: 1 PID: 24 at net/wireless/scan.c:1743 __cfg80211_bss_update+0x1b4a/0x2170 net/wireless/scan.c:1983
Modules linked in:
CPU: 1 PID: 24 Comm: ksoftirqd/1 Not tainted 6.10.0-rc6-syzkaller-01414-g58f9416d413a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:cfg80211_combine_bsses net/wireless/scan.c:1743 [inline]
RIP: 0010:__cfg80211_bss_update+0x1b4a/0x2170 net/wireless/scan.c:1983
Code: e1 07 fe c1 38 c1 0f 8c 44 fb ff ff 48 8b 7c 24 70 e8 ba 04 24 f7 e9 35 fb ff ff e8 80 e6 bd f6 90 0f 0b 90 e9 bb fb ff ff 90 <0f> 0b 90 48 89 ef e8 7b 9a de f9 84 c0 0f 84 9f 00 00 00 e8 5e e6
RSP: 0018:ffffc900001e6db8 EFLAGS: 00010287
RAX: ffff888024282410 RBX: ffff888024282810 RCX: dffffc0000000000
RDX: ffff8880176f8000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: ffff88802a031810 R08: ffffffff8ad83d6b R09: 0245006400000000
R10: 0000505050505050 R11: 0003000000000000 R12: ffff88802a031800
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888024282800
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066ab50 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cfg80211_inform_single_bss_data+0xd51/0x2030 net/wireless/scan.c:2331
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3159
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3249
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5223 [inline]
 ieee80211_rx_list+0x2b02/0x3780 net/mac80211/rx.c:5460
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5483
 ieee80211_rx include/net/mac80211.h:5132 [inline]
 ieee80211_handle_queued_frames+0xe7/0x1e0 net/mac80211/main.c:439
 tasklet_action_common+0x321/0x4d0 kernel/softirq.c:785
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

