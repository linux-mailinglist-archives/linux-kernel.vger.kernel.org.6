Return-Path: <linux-kernel+bounces-189472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929978CF076
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 19:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40285281B61
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645FB126F1B;
	Sat, 25 May 2024 17:37:31 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DE8562E
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716658650; cv=none; b=ckpwAd6Ha69DIKtPxRqipsku9MjLFww7sd5l1blzlpLK7XXiDaUU5OMha+DE05/iOTA2fjTyUk7PdEiA6uMFQTT/kPDpCbyzr5VmKdy0eUZXp9xwENY9zBrwv+hkp3gR2sk2zh+tFi+gQsKIAIYUuKzHEe1yZ8EtQkYfSMNIsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716658650; c=relaxed/simple;
	bh=dymEk7UzsFzhEBsmvHw0fIyLacTUFRLb/BoWOZz72b4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=okM/IWnWzWXQQ6o0zQq4kchbzrR4Zt1DKXEORdtI18x4phEVeGSVukgDhYIcqqiXXx/18lNbsR7HsewYUOXtBS8tSZmgRqzKV8SpKDqdEw3fV/LMlScDBdDPbMpJx5Bp023GIn4AT2l7j2cdUxxEEXHBxW5PD0CXT+WXpmD/xo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e21af40435so230788539f.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716658648; x=1717263448;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2gxWZWU3yuYPw5fRhn3advDM55MpASJpVtOwXu3qhs=;
        b=iDCT40JOSUktSC5/DFKLZaUXZsjCCxsHdfqmAxfSknY+iCEEodnhab/PqdAUZbK54/
         TSxX6XEGH0O3RBWKsqk3a6Vs/ik3zRiFu6iBpoBgVbqA1/W+IU3DGWGKfLDjWLostL9M
         ftagKqJNUHIdDl43sCo22aMmMvN3RgCKrFBDy9bQRLvf2K5HcSB5VboEGDnwfGYd8ytu
         4Ua8oTG1WYyWXPOWs8hPP1Pj8EJ3XIKBfti6V7+CgWCffc6Kw0xzu6wpJKbrF1fgWr97
         b4DtrLJVBaHv3rUBcEEthhFMlz3/HCR5uogMh2cXreuUQDbYortPjl+ZGPQUoffrFQp6
         5LAg==
X-Forwarded-Encrypted: i=1; AJvYcCWO16iP3Q/KmV1v9YSiEaaO+mIBtQfTqzQl8AI/vre6zuCdHCRmjHPw2AqmZyRIgv0qjJygLanvl8LXJdi/PdT2MbDVpB2mkLW2VJCw
X-Gm-Message-State: AOJu0YwlVQ6O75rfufALOZ1XvWiO4ypQdCm9Ca2N17r1JnUxHYZ5wM3s
	hSTmcVXmkfEJke4ulVlfi5NOTomIs9uverVMKPg6S7wxvbFVciGUTJwhvvsjzkTz4+dwvHaR36V
	+dtT4ErR01jNF1++8ErOFXkqo6U2JgQDrsgU84XMvFCuxlr6bz4GFW+8=
X-Google-Smtp-Source: AGHT+IGTqVwNmwRseGGSTjLyWrYeU5wQgffxKA7M9u9WkDMvKNIwNoGq3kIwVhorxx9hikA4stnrTuFfYxHm1Tgsd1cww0RM5/JA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:dd07:0:b0:7e2:481e:7dbe with SMTP id
 ca18e2360f4ac-7e76d31577dmr17655139f.1.1716658648708; Sat, 25 May 2024
 10:37:28 -0700 (PDT)
Date: Sat, 25 May 2024 10:37:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f508b006194abc11@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in __netif_napi_del (3)
From: syzbot <syzbot+0ba117466149911217d5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cdd544980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b8d1faad9ceb620
dashboard link: https://syzkaller.appspot.com/bug?extid=0ba117466149911217d5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-56fb6f92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65ffe3ca9bb3/vmlinux-56fb6f92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/354ef77a71b6/bzImage-56fb6f92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ba117466149911217d5@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 3 PID: 1086 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 3 PID: 1086 Comm: kworker/u32:5 Not tainted 6.9.0-syzkaller-12277-g56fb6f92854f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 48 53 0f fd 84 db 0f 85 66 ff ff ff e8 9b 58 0f fd c6 05 56 0f 4d 0b 01 90 48 c7 c7 20 57 8f 8b e8 87 db d1 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 78 58 0f fd 0f b6 1d 31 0f 4d 0b 31
RSP: 0018:ffffc90006c879d0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81510229
RDX: ffff888020412440 RSI: ffffffff81510236 RDI: 0000000000000001
RBP: ffffe8ffad34d889 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffffe8ffad34d889
R13: 0000000000000000 R14: 0000000000000005 R15: ffffe8ffad34d7a5
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f5e79000 CR3: 0000000061526000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 skb_unref include/linux/skbuff.h:1224 [inline]
 __kfree_skb_reason net/core/skbuff.c:1195 [inline]
 kfree_skb_reason+0x1e8/0x210 net/core/skbuff.c:1222
 kfree_skb include/linux/skbuff.h:1257 [inline]
 flush_gro_hash net/core/dev.c:6682 [inline]
 __netif_napi_del net/core/dev.c:6697 [inline]
 __netif_napi_del+0x311/0x570 net/core/dev.c:6688
 gro_cells_destroy net/core/gro_cells.c:117 [inline]
 gro_cells_destroy+0x10a/0x4d0 net/core/gro_cells.c:106
 ip_tunnel_dev_free+0x19/0x60 net/ipv4/ip_tunnel.c:1100
 netdev_run_todo+0x775/0x1250 net/core/dev.c:10692
 cleanup_net+0x591/0xbf0 net/core/net_namespace.c:636
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

