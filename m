Return-Path: <linux-kernel+bounces-401375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B4D9C195E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286AD1F244C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642B11E1059;
	Fri,  8 Nov 2024 09:38:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487F81E0DEC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058686; cv=none; b=D3/GGZDINnqi8xI99g6XMjkyI8EcTEzK13c7T/rv/U7/3lh+kRIqS+XK3AY39y4L4RVKBinQ0awba6B+uJYgkXBQQj8NOhSRC7X058ySskt/KgTF4OmTxtfvkoSQIIuTIXnP8VvZVxzfJp33UWuKjDLCCOwQg7EiQxkXX9lm0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058686; c=relaxed/simple;
	bh=bVhf3y6rOQP0rOZKIfMiTJNhiObq6QHeyoLDPwuXVD0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ng5+f7KJfX04LzpEtW2q++y6mMwU6paxgTvRQP/mz8RdFSYWDeKWlr7JJOA6F01Jw1WegfdNu45oJitibMQ96R28mtbzt4j/nkJZTJn+86u7NOVi0rpyKV+46qUw0RicKALmR/wPdM72TCJhKx8qYOBJfjE2dmN7S09xl7fVVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso24339625ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731058684; x=1731663484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OIETPoGV4hQWaUrJ6aC8PI9V4UYZtJK8FrbXwWGfcE=;
        b=cZlnTOOGAEyDCSuatXZ2p9OqIJDKYVTqEUcerT4daU88hOPyEeoHDFbcTfpg8KioyS
         0MQgeKh30v5NKk4FrOJDQx+1sjPGZHCOpO4se0X+aEPQZc/lW+4YnJKNHckoceBWAqL0
         I2FjDHduH3iklwpsgTyMbzfR+tbgQPH/ZGNOWYEsvoj7ZLrCajYyd4wE6Pv08oHLK4q+
         85pUzFR7dw7OvzD77MTT96pdoyeGdQSCfzwFT6//m/nlweJgLekSzmpcyKkP79HgI/l8
         9RdYItOfXy9TJK4XYqIx+6PMKYf0OhlrdOHZU893gCkB8GRULfh2vG+xxSpYMK6DRKbu
         J7mA==
X-Forwarded-Encrypted: i=1; AJvYcCU1tBB+YzPz3HS6khQcGlk/pYKUhX+u66FLWh0ZTj/PMBJ1hj3jXydKluWxYuvytJDkfRfVh54/LioKUI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8hXpD8j+s/VaxGDdlPswMSo2G+rtjf0pvcsCwGrzXjyp4Ds0
	9r9hX43aYYsMaSkVcm7Y0tLCmF6vcGrXkhbbAKQAINSGLVfjmGBEAf0JpIWxpVtOXn3vctRZ/RJ
	+DX3AnBpmSvgs21Kui2acGTyaOS/n2yq3fDI3v1SZHo9nh2tghM5+008=
X-Google-Smtp-Source: AGHT+IFaH0hJNB+V95LbVFfov1qIMTZP8U1tVYBrceOgx6rsmAEgAgycZ6/N9nxBFhBVwGG3RxV6tUVm3tFU1APktvdaG7aZHrYV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:3a6:a9bd:84bc with SMTP id
 e9e14a558f8ab-3a6f1a6eceemr25525365ab.18.1731058683360; Fri, 08 Nov 2024
 01:38:03 -0800 (PST)
Date: Fri, 08 Nov 2024 01:38:03 -0800
In-Reply-To: <173105740149.2293654.8622543419878528605@GCRAZCDL0021.westus2.cloudapp.azure.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ddbfb.050a0220.3d9cb.000b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data_end (2)
From: syzbot <syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com>
To: crashfixer001@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ext4_write_inline_data_end

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:235!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6674 Comm: syz-executor.4 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:ext4_write_inline_data fs/ext4/inline.c:235 [inline]
RIP: 0010:ext4_write_inline_data_end+0xea2/0x1020 fs/ext4/inline.c:774
Code: 31 ff e8 e1 b8 37 ff 48 89 d8 48 25 ff 0f 00 00 74 70 e8 f1 b3 37 ff e9 12 f8 ff ff e8 e7 b3 37 ff 90 0f 0b e8 df b3 37 ff 90 <0f> 0b 48 8b 5c 24 18 48 89 df be 08 00 00 00 e8 ca 81 a1 ff 48 c1
RSP: 0018:ffffc9000a277860 EFLAGS: 00010293
RAX: ffffffff825cffc1 RBX: 000000000000003c RCX: ffff888027cf1e00
RDX: 0000000000000000 RSI: 000000000000003c RDI: 000000000000084c
RBP: ffffc9000a277988 R08: ffffffff825cf51a R09: 1ffff1100fd48070
R10: dffffc0000000000 R11: ffffed100fd48071 R12: ffff888061e6085a
R13: 000000000000000c R14: 000000000000084c R15: 0000000000000ff4
FS:  00007f5978d5b6c0(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1b72ca0000 CR3: 000000007fb3e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 generic_perform_write+0x4dd/0x6d0 mm/filemap.c:4069
 ext4_buffered_write_iter+0xc5/0x350 fs/ext4/file.c:299
 ext4_file_write_iter+0x1dd/0x1a20
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaed/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f597807dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5978d5b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f59781ac050 RCX: 00007f597807dda9
RDX: 000000000208e24b RSI: 00000000200007c0 RDI: 0000000000000005
RBP: 00007f59780ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f59781ac050 R15: 00007ffe99c38908
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data fs/ext4/inline.c:235 [inline]
RIP: 0010:ext4_write_inline_data_end+0xea2/0x1020 fs/ext4/inline.c:774
Code: 31 ff e8 e1 b8 37 ff 48 89 d8 48 25 ff 0f 00 00 74 70 e8 f1 b3 37 ff e9 12 f8 ff ff e8 e7 b3 37 ff 90 0f 0b e8 df b3 37 ff 90 <0f> 0b 48 8b 5c 24 18 48 89 df be 08 00 00 00 e8 ca 81 a1 ff 48 c1
RSP: 0018:ffffc9000a277860 EFLAGS: 00010293
RAX: ffffffff825cffc1 RBX: 000000000000003c RCX: ffff888027cf1e00
RDX: 0000000000000000 RSI: 000000000000003c RDI: 000000000000084c
RBP: ffffc9000a277988 R08: ffffffff825cf51a R09: 1ffff1100fd48070
R10: dffffc0000000000 R11: ffffed100fd48071 R12: ffff888061e6085a
R13: 000000000000000c R14: 000000000000084c R15: 0000000000000ff4
FS:  00007f5978d5b6c0(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020658000 CR3: 000000007fb3e000 CR4: 0000000000350ef0


Tested on:

commit:         906bd684 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154ccea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef3e3033284fe956
dashboard link: https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

