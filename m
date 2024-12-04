Return-Path: <linux-kernel+bounces-431392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B698D9E3CB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466FD16818E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A594209F51;
	Wed,  4 Dec 2024 14:29:26 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E83203704
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322566; cv=none; b=liptCIZCUBACW4PWJZM3YsCrrP80fM6ru1YKw9ADAoVpn5ozbXFzGdBEaZWOksKajUGwkQW/eGyWfGzorlzwXKOMM6VCQAfirh68pcshXlTMM+HhQJW0fUQ0vKA+fXJ+4WhdNtpHs6gMroSCE7OgW1HcQ7gCzFwB0deUeao8R/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322566; c=relaxed/simple;
	bh=LBwJ6bbAn80WcRPQJQHQ6y5sHV7eCBHAdt1sUqOU46E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KUop+oRaOH+0wdZvmlF7TZS1cA2Z63FM1E3DBd9rQ6z9JZXmUvNG+KdXCepb5A9/0G72vY2XI6P9YFVQaA71I3WC3u3FB3gUQwAzM6leoMItgFdXd9Ljk7kM0LOiwQaM+HNPClEQh6gfZZjW5QjPQaIlq+9GK3GGMeDdQ0erBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a794990ef3so9102865ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322563; x=1733927363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lps44A56g0pBgvkO1wGgc43RH5tdrqdgb7gfd2Q29F0=;
        b=Iv2mhMKxKy8UGzw5HUMVXvRF6yxrMXfGhB3Eq5eqrcFEdQjx5OOnbmi5m9Xum3+TaW
         O/LCibJ/VJQbqyBOLc+eBye4uAUjrpCIOCZXCmchyz+xqch+mmCthWG4XX+NanF3L1w+
         qAPnCtqGmFJmduhVI2N/DuW3NkUvKTSo2Wj8OP2YVFEyxqQ5m7D9JgANB60mOBzJcyZI
         zdT2D79uoiUe8KHdX+iUBfiYOD54Tp8CAs1AOpS6vnpYRP4ivFgl0zxqlqV8uvTED3oe
         Bnz9wcSqDrM7srL5wSsgUXvD3t7D6xrC31jAKigMUtfEo3JyCQzZD2EsAbMeaP0R7Qim
         pYIg==
X-Forwarded-Encrypted: i=1; AJvYcCXwk+UbROfJyO10uVQkqNfn2TiBHakL+DKqUUzFnHixyHBMi9OnlfeRxdkK6Q67Qo5kXbMuin9ricA4FM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyETU8yTa6WuI5XW0T1+6h8qJUQhHtsfrJY//PvTHrlSKeM5Kl8
	c1YoTf8WUKmo+PHpUf7M7fDnCyScmmKBRWMH6iwAWatMITPtbT0mTJVhMRKIApJC/sjReN34GDx
	7do4tXh1Z7J1fa3/FYTEMn1AxsL/E/3hxbTTGfcu9FdCegw8Buhm92UQ=
X-Google-Smtp-Source: AGHT+IFgTcMnqnLEchm6AYwwlMmWF4Isq8kow0RtCBzKXE7/a4W57FGYAcZ5duqwr3yHAHmI484RZkACbVkF70/zKndsj9DHWhvU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda4:0:b0:3a7:ca83:3f9 with SMTP id
 e9e14a558f8ab-3a7f9c1b5ddmr68369045ab.4.1733322563630; Wed, 04 Dec 2024
 06:29:23 -0800 (PST)
Date: Wed, 04 Dec 2024 06:29:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67506743.050a0220.17bd51.006e.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in
 dst_dev_put (2)
From: syzbot <syzbot+9911f8283beca191268b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b1d1d4cfac0 Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=114ca75f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfe1e340fbee3d16
dashboard link: https://syzkaller.appspot.com/bug?extid=9911f8283beca191268b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/354fe38e2935/disk-7b1d1d4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f12e0b1ef3fd/vmlinux-7b1d1d4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/291dbc519bb3/Image-7b1d1d4c.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9911f8283beca191268b@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000000
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000000] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-syzkaller-g7b1d1d4cfac0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dst_dev_put+0x2c/0x2bc net/core/dst.c:146
lr : dst_dev_put+0x28/0x2bc net/core/dst.c:145
sp : ffff8000979379a0
x29: ffff8000979379a0 x28: ffffffffffffffff x27: ffff80008f16a000
x26: 1ffff00011e2d466 x25: dfff800000000000 x24: dfff800000000000
x23: 0000000000000000 x22: dfff800000000000 x21: ffff80008f821110
x20: 00007dfe9b881038 x19: 0000000000000002 x18: ffff0001b364a9a8
x17: 0000000000000040 x16: ffff800080585eb0 x15: 0000000000000001
x14: 1fffe0001df07cc3 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001df07cc4 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c19e5ac0 x7 : ffff8000832ff164 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff800089f54340
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000002
Call trace:
 dst_dev_put+0x2c/0x2bc net/core/dst.c:146 (P)
 dst_dev_put+0x28/0x2bc net/core/dst.c:145 (L)
 rt_fibinfo_free_cpus net/ipv4/fib_semantics.c:206 [inline]
 fib_nh_common_release+0x1f4/0x440 net/ipv4/fib_semantics.c:217
 fib6_nh_release+0x3a0/0x40c net/ipv6/route.c:3668
 fib6_info_destroy_rcu+0xc8/0x214 net/ipv6/ip6_fib.c:177
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0x898/0x1b5c kernel/rcu/tree.c:2823
 rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2840
 handle_softirqs+0x2e0/0xbf8 kernel/softirq.c:554
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:949
 smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Code: aa0003f3 f2fbfff6 97a314b2 d343fe77 (38766ae8) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa0003f3 	mov	x19, x0
   4:	f2fbfff6 	movk	x22, #0xdfff, lsl #48
   8:	97a314b2 	bl	0xfffffffffe8c52d0
   c:	d343fe77 	lsr	x23, x19, #3
* 10:	38766ae8 	ldrb	w8, [x23, x22] <-- trapping instruction


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

