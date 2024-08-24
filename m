Return-Path: <linux-kernel+bounces-300029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1BE95DDCA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0341C1C21161
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135016E886;
	Sat, 24 Aug 2024 12:16:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91038154BFF
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501765; cv=none; b=P6Q5pRyPyrjXMikxfKg8aPinv6tReW7IUVJndlaloWsjqYp13FG5D/ZqQk+mAxcUaTxZzCQskt5BWn7SWWkyxc+cVRbGdEIKtc1oz+u/l9ACfG9lpIm2A9pfajTVMnjMwyNPy70Hz078okCGoB7D7Hg0FStBLh+1epsNo24mnvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501765; c=relaxed/simple;
	bh=CGwX9ZyW/Tldx86jxXVzGqsqzxV+3C4zz2wDmv5b9n0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HJqimoke3bQtfs6FZ307PqoM7kg1u1pKUWh4cBRHOGJYeQVfDs8Q3J5MAiKgbVKQU775zt3E2cl2QgfI7CrbbpE9zyf7SwgoBDiInPZn0WE87MP965rTQn1kL8fPmS1DbMnmojB2BRWDnJwcgDkJsFAXF3s7kR48wx3198u0XL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so285409839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 05:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724501761; x=1725106561;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7GggwJk7a2Gq/yaC4R+wWXvb15PdcynScIpzqYvhJA=;
        b=iJmZylEjX9Vqjdcd7UBXDciYBUvk2KoLFDrw36FvADcx5oAdBexjX3mBDiTGWVXAYE
         OA7YEIpnduBw7397tR+kjekzyIMS2+x0P6z168BWtVArDmGVAN+q5aVct2pzEpcrMh/+
         anG0VupXcOhlGVIKVdazmnwEhHhJHXCPqSAArHuh8EGpLtMuYsFCBMN2iv4R3SpEdXEn
         DOhuGJ9aBjH329D7Cq85m3O3McYw36C4i9HwHe9/Hss+5YFDmjGPBRcrOmv7OJ3uSMSN
         MXw5/CZeKSgpkUytCfDv9GXR7Cg7dmcEuGUNS6nErfP/vcGHFPSipRR5iiFeb6AVsWLu
         GmUw==
X-Forwarded-Encrypted: i=1; AJvYcCU91tQuo9n/qN1ZznbkdbED4d6UiBHHmN1aoa997Fce1YTFs477efAmaUAVowrxPzJxSGmjrgc7eIChdBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGa28nz7vZrcMJom9YOgMP8iRIS5T/MlshO7sD5UXkj0+AVoH
	mchUPG5LCN2uBO6LzioC23LCFvWiLBwLmg9wu+PKw1M085m6PuVEqcEC/YHZo6kXrjMWSEDMxB7
	DkQZ2OJRnsibhi1zO3fX4e3eZemwSEesFWipApc62EaR+ETun9Kht4ww=
X-Google-Smtp-Source: AGHT+IHPHwgGXQxi3ltHtr4MCBBx/p4JUoQM9ekgwf6bq8CBG9MBv5F6VJPAC5VKcy6jk0/6NE+g3lkZSDJQmAKgctBOd+flQi7B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:148a:b0:822:45d1:5d82 with SMTP id
 ca18e2360f4ac-82787134e39mr21432639f.0.1724501761648; Sat, 24 Aug 2024
 05:16:01 -0700 (PDT)
Date: Sat, 24 Aug 2024 05:16:01 -0700
In-Reply-To: <20240824115705.1267-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eafa8106206cda75@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_close (2)
From: syzbot <syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in sock_map_link

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6104 at net/core/sock_map.c:206 sock_map_init_proto net/core/sock_map.c:206 [inline]
WARNING: CPU: 0 PID: 6104 at net/core/sock_map.c:206 sock_map_link+0xd6e/0xe40 net/core/sock_map.c:311
Modules linked in:
CPU: 0 UID: 0 PID: 6104 Comm: syz.0.15 Not tainted 6.11.0-rc3-syzkaller-00508-gd785ed945de6-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:sock_map_init_proto net/core/sock_map.c:206 [inline]
RIP: 0010:sock_map_link+0xd6e/0xe40 net/core/sock_map.c:311
Code: ff ff e9 65 f9 ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 34 f3 ff ff 48 89 df e8 4d 90 5a f8 e9 27 f3 ff ff e8 23 4b f3 f7 90 <0f> 0b 90 e9 d9 fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c a0 f6
RSP: 0018:ffffc90002d57a60 EFLAGS: 00010293
RAX: ffffffff89a03e4d RBX: ffffffff95312d30 RCX: ffff88802034da00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88807dbfda08
RBP: ffffc90002d57b60 R08: ffff88807dbfda0f R09: 1ffff1100fb7fb41
R10: dffffc0000000000 R11: ffffed100fb7fb42 R12: ffff88802b274000
R13: 1ffff920005aaf58 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f4ea726e6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000440 CR3: 00000000791a4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sock_hash_update_common+0xd1/0xa30 net/core/sock_map.c:1014
 sock_map_update_elem_sys+0x5a4/0x910 net/core/sock_map.c:598
 map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1654
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5698
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5815
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4ea6579e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4ea726e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f4ea6715f80 RCX: 00007f4ea6579e79
RDX: 0000000000000020 RSI: 0000000020000180 RDI: 0000000000000002
RBP: 00007f4ea65e7916 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4ea6715f80 R15: 00007ffcfb2f8928
 </TASK>


Tested on:

commit:         d785ed94 net: wwan: t7xx: PCIe reset rescan
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=148d382b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=8dbe3133b840c470da0e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f06d5b980000


