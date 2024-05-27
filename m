Return-Path: <linux-kernel+bounces-189911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582E18CF6FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF60C2817A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 00:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294032F46;
	Mon, 27 May 2024 00:19:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C03E20E6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716769145; cv=none; b=NzuIFIn0wkJqJgZVI4waF8K9TdJtkUmpe16GDfNhXBVvDjPv6hGsohfrjFt/HKl8aQK/W8kj/iPAkpo2cwkMNKb2+UuCNgczpFDvm1PDd1xmVSXKtWSRhNwCTslA9YNbGWGZDRPqym1EsdCrjvcS25RyEZCr8njCHmDspwTG7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716769145; c=relaxed/simple;
	bh=svu5RKUQp47i5LIbxN2nTIfdrDAvqzvQJFKr32LXFjw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qtXuxK91QPrMj4Xtw8o+8p47/spYNiyDz2IFpCZHWD5rGKU+dAs710WMIUgMq2a36wyVg9geL3xcojDMbcQVBz7LCOEYKYDRfn81nyjDeFESvjiPJ6jXl0h+MoPBhPpa3GheSQd8qclPnI/g1b/WQvYUJEWvUBMLrVHSpuIgC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ea27057813so191629439f.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 17:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716769142; x=1717373942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0tkuARHhm3KsgIYqN4KotlgUqddD92ScDqg/qkhOZU=;
        b=M9CLSBjDdVfOSHrkSc+DtsbQY0VnhVUqwl/ovWm0FrlvqctyyG0hyiwMXKc+4YqBiS
         DAv2uF4y1yg764HzW/RLYMAMQMAhgXkUM8qAnAy8TSvLVc/NoPpbE/G2rEkyya/h8U1P
         lPyVJjwvhHTv/MFm0DrwL0H9MFQl/eRqrr6Eb+4MhAiu7kIpV3Pc3xojAx9jwZjfoXfG
         FHCxUi0Wt0Q2Ot0OgsDK7HAO2Ck1Rwcgj3RA43r1f33kqOKueqaT2u+Z7AYBF07pd1Wt
         j9FYNvH69SnCEg86bjGw9C5CuL/x6b5wJaKw0NgSfzslohTS9ZgnSjVy01EIcsVvlQS6
         5cpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1thoWvf/fwKZC68PSYbEHw6bctRA4VxIvHOB3cE4hcn720xoxb6gUtM0s0ZEpRv4HPfJVgPQ0DbwB7hLAZQ0BOU/jM5x9KIxBFRIP
X-Gm-Message-State: AOJu0YxNKHai3yzPGdg0dzEVZfMD35VmmwTEE2iD60v2fnLzpv3N3FEe
	udTqZl3JILCAfnqtjMDggbGxYOlPnEcurmJxcZIEkmpm9PIkQIWJaYHJOg1EaEc4/yWjLSi6yQy
	nvXoTih9Z1olC6JImPGAaSpfARQ2Wmq2UpVS0dsHt5KmADDGR05J94pI=
X-Google-Smtp-Source: AGHT+IHSyc6kSzIGTMvKB3L1l9R+Uhyn7mcawPs26AXnCyz5xs2ZZNzMnzOdjOMWoFubH2CtKif2RYN2splkQ1vk+lQ9/v33nVOn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cd0a:0:b0:488:f465:f4cd with SMTP id
 8926c6da1cb9f-4b03f520d78mr449858173.1.1716769142462; Sun, 26 May 2024
 17:19:02 -0700 (PDT)
Date: Sun, 26 May 2024 17:19:02 -0700
In-Reply-To: <20240526232750.2504-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5e61b0619647659@google.com>
Subject: Re: [syzbot] [net?] WARNING in inet_csk_get_port (3)
From: syzbot <syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in inet_csk_get_port

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5606 at net/ipv4/inet_connection_sock.c:595 inet_csk_get_port+0xfae/0x2520 net/ipv4/inet_connection_sock.c:595
Modules linked in:
CPU: 1 PID: 5606 Comm: syz-executor.4 Not tainted 6.9.0-rc4-syzkaller-00266-g977b1ef51866-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:inet_csk_get_port+0xfae/0x2520 net/ipv4/inet_connection_sock.c:595
Code: 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 63 13 00 00 48 8b 83 40 06 00 00 48 89 44 24 20 e9 95 f2 ff ff e8 93 13 4b f8 90 <0f> 0b 90 e9 10 f9 ff ff e8 85 13 4b f8 49 8d 7f 48 e8 5c c5 5d 00
RSP: 0018:ffffc9000388fd38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88805c420698 RCX: ffffffff89429509
RDX: ffff88802b24bc00 RSI: ffffffff8942aebd RDI: ffff88805c4206a0
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000004e20
R13: ffff888025057000 R14: ffff88805c420000 R15: ffff88802b92d800
FS:  00007f9e62e756c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f86bdade048 CR3: 000000002c8ba000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inet_csk_listen_start+0x15e/0x390 net/ipv4/inet_connection_sock.c:1281
 inet_dccp_listen+0x1c5/0x220 net/dccp/proto.c:951
 __sys_listen+0x19b/0x280 net/socket.c:1881
 __do_sys_listen net/socket.c:1890 [inline]
 __se_sys_listen net/socket.c:1888 [inline]
 __x64_sys_listen+0x53/0x80 net/socket.c:1888
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e6207dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e62e750c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
RAX: ffffffffffffffda RBX: 00007f9e621abf80 RCX: 00007f9e6207dea9
RDX: 0000000000000000 RSI: 0000000020000005 RDI: 0000000000000003
RBP: 00007f9e620ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9e621abf80 R15: 00007ffc65e51748
 </TASK>


Tested on:

commit:         977b1ef5 Merge tag 'block-6.9-20240420' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=106b1344980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=2459c1b9fcd39be822b1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15314d92980000


