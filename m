Return-Path: <linux-kernel+bounces-319236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B2296F993
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6941C23144
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7DC1D45E8;
	Fri,  6 Sep 2024 16:51:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98FE1CBE8A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725641465; cv=none; b=r9UCYW/xYZjIjLa/kDa7z0qRD9k2PktR3YEk//5YRAgdC3rGRcmusYpN+Uf3ZkJEQWTHS8a28f+IEP95iinPR4TBJg0D9gfrLUCnedOHagYSGlVICI/SucInJZXHQXPoXpytYge1pubRlPIcvFe/oKfDMCpb8WajC4rrhs2jOew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725641465; c=relaxed/simple;
	bh=A8Z0qfVWb0znSgQeTBj9gT455DG5EkKDRGtOsUjFHO8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UEgPqIbODBKFDHUMGCM1oM/REM/4qtuL/lnvRFQoq5lmBnna1igjuzxW3xHZx8Tk3mxMJkoWw7rdowtBRH/0j4/Diwk7iqwl01s1Saho0ZMBXiLxg1b86tTHweRnACnaiT8qrjQMipORmXls88qwlYuP1iTiKMgTFjWqMSm6vwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a321567d4so467535839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725641463; x=1726246263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbJNQTkd85EzoH1ufp/G7n58VdYkLrkbtEjaB+pBaLY=;
        b=KsZeRYILQ6veGVnmiCZeo7AWgrbhrJ9FDeQjMJ88S0arUzGthLOMiTbNWvZFfSBTXN
         Nl7xlDSFVTKJXBO/t6aEUQVrNAUnrl2gFKOdVEt/zsggRNViCUHrPl0WXV/iAKugW7IP
         hlRKiTSuErq4s7SlU4Dq7vHmk6VkzbiELLUojfGayidq71lJH+YO4sDIiuymBzRY/ow9
         Xq6s/F0njhqk/a8O+ICkEOInKo7qzzvdrbLHcSi7FEtLoEFhQMnOWIeQFG/Mdtx8aOHp
         SYGCJUsP39g7hmc6t/x1V9nYhhQfPDmpTi26U1x2J5wZyftykscxXYs5HpFY2AjZG66O
         WgZg==
X-Forwarded-Encrypted: i=1; AJvYcCXt4OU4J1Qyz4ruAN+oa0sx8lM8hlAJT84J5iHM24RFmQaJVXVZtxqdj8AVwpfzTbO3O4f9JLOEprUaLGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfI68U0rl5bx8H7DVFaPJTtTPTAAxFkAe9vOetCnsFBat2FAHJ
	SzdFTlvzJPKv1MDGNb4CrMUCpltPOtlasQwnyumEfiiEoPFIg/9V+DovCgTBi2ggkptpyoJa4iP
	ZCXY5j6Ua9Vas80H9wixQCGv9OtTmb6cSmIT/UuUI2WENAdtg6FUEd7A=
X-Google-Smtp-Source: AGHT+IGvI75tGK8NM+J8gAZSXsx5j+HxxEMsBujJFI4YfAkOVJqsIUkqjXMeRwHpAhvtNmPS5KZ9gL4kusCQT8HGoZ63rAmZj1kG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8707:b0:4ce:8f9d:30fb with SMTP id
 8926c6da1cb9f-4d085021f8dmr275533173.6.1725641462952; Fri, 06 Sep 2024
 09:51:02 -0700 (PDT)
Date: Fri, 06 Sep 2024 09:51:02 -0700
In-Reply-To: <f110db9e-16a5-4256-b0fd-980fda8a2cb0@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068ce8406217636c3@google.com>
Subject: Re: [syzbot] [usb?] WARNING in rtl8150_open/usb_submit_urb
From: syzbot <syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com, 
	srikarananta01@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in rtl8150_open/usb_submit_urb

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 2582 at drivers/usb/core/urb.c:503 usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 0 UID: 0 PID: 2582 Comm: dhcpcd Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Code: 84 3c 02 00 00 e8 45 c1 fc fc 4c 89 ef e8 fd 1e d7 fe 45 89 e0 89 e9 4c 89 f2 48 89 c6 48 c7 c7 e0 61 a0 87 e8 36 c2 c2 fc 90 <0f> 0b 90 90 e9 e9 f8 ff ff e8 17 c1 fc fc 49 81 c4 c0 05 00 00 e9
RSP: 0018:ffffc9000185f740 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88810a710f00 RCX: ffffffff811a9639
RDX: ffff88810f3157c0 RSI: ffffffff811a9646 RDI: 0000000000000001
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88811d1ea0a8 R14: ffff888109f221e0 R15: ffff88810a710f7c
FS:  00007f11f9604740(0000) GS:ffff8881f6200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fef9e900870 CR3: 000000010dfa2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rtl8150_open+0x300/0xe30 drivers/net/usb/rtl8150.c:733
 __dev_open+0x2d4/0x4e0 net/core/dev.c:1474
 __dev_change_flags+0x561/0x720 net/core/dev.c:8838
 dev_change_flags+0x8f/0x160 net/core/dev.c:8910
 devinet_ioctl+0x127a/0x1f10 net/ipv4/devinet.c:1177
 inet_ioctl+0x3aa/0x3f0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f11f96d2d49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffdef3c4138 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f11f96046c0 RCX: 00007f11f96d2d49
RDX: 00007ffdef3d4328 RSI: 0000000000008914 RDI: 0000000000000005
RBP: 00007ffdef3e44e8 R08: 00007ffdef3d42e8 R09: 00007ffdef3d4298
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdef3d4328 R14: 0000000000000028 R15: 0000000000008914
 </TASK>


Tested on:

commit:         b831f83e Merge tag 'bpf-6.11-rc7' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17f75c8b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e0217c0b2cf4322
dashboard link: https://syzkaller.appspot.com/bug?extid=d7e968426f644b567e31
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

