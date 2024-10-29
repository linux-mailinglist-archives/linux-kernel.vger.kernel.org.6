Return-Path: <linux-kernel+bounces-387454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2BA9B518B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E1B28380A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A011E883F;
	Tue, 29 Oct 2024 18:07:37 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8B1CC17A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225257; cv=none; b=qUEDjCSe/7hlsIPef7IXbLbU98hhOi/q8qMAZYCijvn7dBn88HkRDmUsGgxLhOPha/mQ9g0rbpKpfGFI61xsA63/fWk3XENmFnzRjABvwipw9FXxxUzyVd6tJ7aLHIiWjuuWBArO1s+HZ9EXoKccBkbaFtPBJyYYJEagkuSwu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225257; c=relaxed/simple;
	bh=lyc//tRZ3h5BN3hUpjX0thNYWX5LvgJTypVOx8uWeZo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D7vWco5V8fruBngw9F1mNJGCm+HgCyUOdn1RVFGaKQi/zc+fKw4SNuk5dgDF7q0EBWygIXW6v787Z/dOtLMDynRmOS8ZngvcnHgjBXCVwYk70F3YsKMn5AT4tfTWJYUWIle7nZlhf9TavFmI6NeCu+2iG3etMDOCfIhL97w2Z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3e1ef9102so58786715ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730225254; x=1730830054;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bx2vTST5OInC4SnAK0To7h7zrS6Xfw6UVx9K6oh8eEI=;
        b=l/HpNOTJsn0ZdOBAP1ToK26FKEEvqFIE/Bf7E2cy/k0r/M0c6VG6tXRcmQ+kzF6wHx
         b95wIwpt0yvYjKGFPmU1TCPnmoMByLwPYt6aNzo9hwbrMnJTkpsjVmCMwgZpRhKoj1Ox
         Z2a0d9ylhLjhLhsHOscZsJ6hR6AD31h5N+xu+noMwlKAdBzgT3OUr8Br3GPKhpiy/uPV
         +BK2Bp5UHksY1qj7vMSfQoykKcK0yvfsgpJwIAs9S7oGBuDpNi0+fKW0cUfN/2UfHsYa
         kGLg929pmaT29htgPCz7RgYfofe82zSl21B5RPnMX8SjRRCq33cZCDjTXPwdqr4MNmB5
         9+lw==
X-Forwarded-Encrypted: i=1; AJvYcCWCzdOa12TuyloO0/KP+fD8x1Y5xJ4xuN7Rd04Y2LiAFTRMvJSRBh8Cy90aHvgp+xem8hi9MvvBiN2FpE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoNJNIHArGwLQ4C9qUwgLnWwbozntmIunSeK1Y+2uq/l6hn2v
	wUAZPpESWxXrWoBAmboHCRMlYzrmVVvse9xhLQsYzc2um8C32H1Mj56CNHG+lQsTjz3gaea1Kry
	j7+wjAyOiv5hKpdOzL7JTbs83jZ0gig0rJNUrJ5VDrDgAVE0pipQfNMw=
X-Google-Smtp-Source: AGHT+IE1nuVQz2gIc/wBO7ngKXOwNm6k9OG5oUitV2Yh5laZVwloKwjqxfMg6wMpdCt2Lch93tG1yiDkqHLwtQb7SPTZ1RY6bXKw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cf:b0:3a0:9238:d38 with SMTP id
 e9e14a558f8ab-3a4ed293143mr120662855ab.10.1730225254109; Tue, 29 Oct 2024
 11:07:34 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:07:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67212466.050a0220.4735a.0261.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_mark_sta_auth
From: syzbot <syzbot+542f74e8fc8361630178@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    94c11e852955 usb: add support for new USB device ID 0x17EF..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1112615f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=542f74e8fc8361630178
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17914540580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1512615f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/86f5604d3b74/disk-94c11e85.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8be1f807098d/vmlinux-94c11e85.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c343d3004f40/bzImage-94c11e85.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+542f74e8fc8361630178@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan1: STA 08:02:11:00:00:00 not found
WARNING: CPU: 1 PID: 3541 at net/mac80211/mlme.c:4264 ieee80211_mark_sta_auth+0x36c/0x400 net/mac80211/mlme.c:4264
Modules linked in:
CPU: 1 UID: 0 PID: 3541 Comm: kworker/u8:12 Not tainted 6.12.0-rc4-syzkaller-00174-g94c11e852955 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_mark_sta_auth+0x36c/0x400 net/mac80211/mlme.c:4264
Code: 90 0f 0b 90 e9 8a fd ff ff e8 d0 6c 46 f6 c6 05 f0 66 b8 04 01 90 48 c7 c7 c0 39 2b 8d 48 8b 34 24 4c 89 fa e8 65 66 07 f6 90 <0f> 0b 90 90 eb 8e 48 c7 c1 7c 32 1d 90 80 e1 07 80 c1 03 38 c1 0f
RSP: 0018:ffffc9000ceaf5a0 EFLAGS: 00010246
RAX: c531a4dfe0f61700 RBX: 00000000ffffa569 RCX: ffff8880328f0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00000000ffffa755 R08: ffffffff8155d402 R09: fffffbfff1cf9fe0
R10: dffffc0000000000 R11: fffffbfff1cf9fe0 R12: ffff8880300e8cc0
R13: 00000000ffffa755 R14: dffffc0000000000 R15: ffff888021b19bb0
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555876caca8 CR3: 0000000034b10000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_rx_mgmt_auth net/mac80211/mlme.c:4370 [inline]
 ieee80211_sta_rx_queued_mgmt+0x2527/0x4d40 net/mac80211/mlme.c:7475
 ieee80211_iface_process_skb net/mac80211/iface.c:1600 [inline]
 ieee80211_iface_work+0x762/0xf20 net/mac80211/iface.c:1657
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

