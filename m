Return-Path: <linux-kernel+bounces-310037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBA9673D5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 00:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C1B21D96
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0B1822F8;
	Sat, 31 Aug 2024 22:45:37 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427015E81
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725144336; cv=none; b=N6rD6RkGSeOq5N7lhMI4bciW9KuMiZiDUPGH3IxP7NTILsjSnA3lTXQ4C6JmteFeI4FUkFwQE6HhTqZPScotUWX/bUgufyf17uWu/lfGVNetLZ1X+mbasZvK9bYU5o11cp2eqqKN1BK23GU/1YFPQmxUJjYrHM00LIT0GowGR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725144336; c=relaxed/simple;
	bh=0Rh3qWPL/ug2+ckCd/0A9ZhssE1J9B6SY9t0f2Es0T8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NskS/oB0ywBNN3/jFWX9b+avesO4Defopv5ycPB6LTeVT3BStfqQdX/s2O03Xdsa6rF2QDSba1pEM2df7XZfIpWZHIjRE/A5tMdaGRwWeRv+d3bPjBaFVPnO1t+H2SxdL4DHll3hfLh98hOiBoajilNfGSvpseF9fEQLxGdi4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a246af0aaso242413039f.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 15:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725144334; x=1725749134;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhIHjEsEMtkfiHVdTrULiHNto0yhAZAnqMbP/zvdpE4=;
        b=sMqOzSAjvvV6OBjIsRRwCHr7K86DobZiyjnGYDmPmRXhiwFvnHva4CyVLSGTVRgOVc
         0SwQ5qNKX1+w228+JtiynT7hzEJw3k7bXaq+/8joma82VNHa609jjqBCmfS4QozyUkzC
         yCvT/hVKgmrtquvTAvFgExeB73mAGSFgMxL1xMhm052Kk9uGWD7bt3uhRQ1m7Vxzq5QQ
         A3OY5gGbdBw89OXzq3/jXpt50HlEBYNVOuBycSMoWqNuMTIldcarF86UCpSAhfoILme/
         Sif3X6otv/scc9OwRMlP3adUAQNp/vldsemz6Vi6oj2Q2tWcO1pq8UdM2HMpF3FafZOB
         tGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcDEY71ZUeBGAf7N2IqyRN0JAzphCTX49gbyTX8AOzgTekrdpoVZAOmM6LTn3skJ1voLCbp+GQm0A0Dn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8i2U3P4lObB63G0ywy7/9/YBE3eU5lKC9oozrD3W/aitNNTE6
	3/W0DVfDqodCWzmJpVitZo/Jfx+3E+L+wbAelP/Zp3WE2bgZ6KgGqg4GHgbyFznGiQtzYGw95y/
	F0inOHOiO6M4lYB3RE5gxYNzqgne9ESs1CltYggnzh668TQd4S/xbyDk=
X-Google-Smtp-Source: AGHT+IG653o8GC4w0Dxgft28rtaG8yFUQSi9+MH2IwOyAMGunMAjyB3ZYtiS8CuUYPgECVFK2Gxi6Wkke8ySUH/PI9c+G+vOD6lX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b04:b0:39f:5609:b36f with SMTP id
 e9e14a558f8ab-39f5609b554mr163405ab.3.1725144334581; Sat, 31 Aug 2024
 15:45:34 -0700 (PDT)
Date: Sat, 31 Aug 2024 15:45:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fd18f0621027756@google.com>
Subject: [syzbot] [bpf?] WARNING: locking bug in search_bpf_extables
From: syzbot <syzbot+b467973d2dd3b9deaa1f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6f923748057a Add linux-next specific files for 20240827
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=105f7791980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65c4a779aad2633f
dashboard link: https://syzkaller.appspot.com/bug?extid=b467973d2dd3b9deaa1f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4398d0ec73ed/disk-6f923748.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f7e004ef90a/vmlinux-6f923748.xz
kernel image: https://storage.googleapis.com/syzbot-assets/333e975a3aac/bzImage-6f923748.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b467973d2dd3b9deaa1f@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(chain_key != INITIAL_CHAIN_KEY)
WARNING: CPU: 0 PID: 5320 at kernel/locking/lockdep.c:5180 __lock_acquire+0x1659/0x2050 kernel/locking/lockdep.c:5180
Modules linked in:
CPU: 0 UID: 0 PID: 5320 Comm: syz.2.7 Not tainted 6.11.0-rc5-next-20240827-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__lock_acquire+0x1659/0x2050 kernel/locking/lockdep.c:5180
Code: 0f b6 04 08 84 c0 0f 85 e9 09 00 00 83 3d 0e 40 ac 0e 00 75 19 90 48 c7 c7 60 c9 0a 8c 48 c7 c6 a0 f2 0a 8c e8 88 7c e5 ff 90 <0f> 0b 90 90 90 45 31 f6 e9 aa fd ff ff 48 89 d3 e8 32 99 42 03 e8
RSP: 0018:ffffc900043d6ff0 EFLAGS: 00010046
RAX: 21b44eb71ffad700 RBX: ffff888020550ad0 RCX: ffff888020550000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888020550ae0 R08: ffffffff8155a5b2 R09: fffffbfff1cfa364
R10: dffffc0000000000 R11: fffffbfff1cfa364 R12: 0000000000000001
R13: ffff888020550ad8 R14: 58cce5e7c8d5ebdc R15: ffff888020550b00
FS:  0000000000000000(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000f0 CR3: 00000000662b2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 search_bpf_extables+0x42/0x3f0 kernel/bpf/core.c:788
 fixup_exception+0xaf/0x1cc0 arch/x86/mm/extable.c:320
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

