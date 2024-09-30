Return-Path: <linux-kernel+bounces-344965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C780A98B0B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B2C282CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5D188A17;
	Mon, 30 Sep 2024 23:18:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925F5339F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738305; cv=none; b=c/XUqmXSKK7z+DEfF8P8J1Fs/7Mb80nKjPux4HZDHv4y06W9vSTEcP13GasF4CZgpNLjKiOwy7gWUlWSKzcDt5tKDG3hiNlN/LtJWhn2kEQZL9QTkGyaG2PzvKsq8EhlFBTO5F1hAYYMsVVFcUjXPPTz7kei6Or6yibcwi2l8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738305; c=relaxed/simple;
	bh=lYSfcOeL+V1cwr3k3udletdUznko80vLkvqxOKfeSVM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ak9OYzWKIap4CD7krFLS1mwc1ShQlD8od1bHi9k5nqHZCEuB4z7h5+ur7atLl1d7ssutV2EfUHoEWI7yKeN0jCHMxRoddOX5rd+6iyaVQDu5T8Ot0ny8qaJiTMS4n8wog33AqUaRZ/XOmUEQtTZSnKZ88g2zFH8IeOdLlkVQDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3496b480dso34839465ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738303; x=1728343103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BL/akqr0deBZImvpvkuvpugvj/LkMhDf8lCR1uhO034=;
        b=Gjfb9sTnu8e6TE//ovG1xm+dRZ9v+MnMF1SwxiGhMI4bTxLuC3I2iCLNQDU/CxHPfg
         VOuMWU2ZA7Hlj5NTJGFtcJEbZHXmiK2uaS4YUOt7EjkX51Ie6gQhZ8aLePhwsGBeZbxd
         NZixepT/o1n/VDofyorYbyuUUwluUvaJL9VlgEcp5N8UJiRSHp9lfELawyBAgLcbXsnY
         1Z+QFCrajM3rIRiE645r7Le6bjZnDZtr7TrbV8LevlIBY3tYe8xrdT50FhNt8du4Lgu3
         hriAitnrIAgT27I0RDj9KIxOQXvtjy383ptYfpH9ImCUx0GJXqLjZ6Tq+FisKACWPTng
         5NJg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Att1B6NQfwqTrVboC8FhQ5oVlnY5phyK2nOouFOvFzPqs+YVOgyCxxkKRqifRVrhd3okIPfqJAioiLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKR4+fGjZJU6mBfGP52ZxBGCVLxKht7jlHJ+V/mn6Owi0oIryg
	qL8ItrGqJZ22LXrJnU0GuVZNbmXgF3yr7l/qRg2pbyws2K56RLJ50PCqjsTdVaEDsJ1AgnN2Kpy
	vhhCGqI90UahJHCKLzVcvKtEXv0VmFWZbT5sgJaDGNjH/j062ykcxzXk=
X-Google-Smtp-Source: AGHT+IHgEXVmXvg4us0DXFmOfew5JJbOY+h0PbiM3uJT/6VBbaQbvbtJ8yPaDNMFxjaBy/4tMNvqm9xfZyskmnXv2I5XbKfzlplv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:3a0:a3f0:ff57 with SMTP id
 e9e14a558f8ab-3a34517c867mr119944885ab.15.1727738303045; Mon, 30 Sep 2024
 16:18:23 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:18:23 -0700
In-Reply-To: <00000000000094071d061e9d0f66@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fb31bf.050a0220.6bad9.0044.GAE@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_wait_one_vblank (2)
From: syzbot <syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com>
To: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, simona@ffwll.ch, syzkaller-bugs@googlegroups.com, 
	tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9852d85ec9d4 Linux 6.12-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=131f5dd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ae7d07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124e1980580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da91d5641713/disk-9852d85e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5fc1f1ed3252/vmlinux-9852d85e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5affad2001eb/bzImage-9852d85e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com

platform vkms: [drm] vblank wait timed out on crtc 0
WARNING: CPU: 1 PID: 5311 at drivers/gpu/drm/drm_vblank.c:1307 drm_wait_one_vblank+0x97c/0xa00 drivers/gpu/drm/drm_vblank.c:1307
Modules linked in:
CPU: 1 UID: 0 PID: 5311 Comm: syz-executor171 Not tainted 6.12.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:drm_wait_one_vblank+0x97c/0xa00 drivers/gpu/drm/drm_vblank.c:1307
Code: 80 3c 08 00 74 08 4c 89 ff e8 c0 51 94 fc 49 8b 1f 48 c7 c7 40 96 73 8c 4c 89 f6 48 89 da 8b 5c 24 0c 89 d9 e8 c5 9c eb fb 90 <0f> 0b 90 90 49 be 00 00 00 00 00 fc ff df e9 68 fb ff ff 44 89 e9
RSP: 0018:ffffc900037cfac0 EFLAGS: 00010246
RAX: 080b7da53130ae00 RBX: 0000000000000000 RCX: ffff88804f0bda00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900037cfc00 R08: ffffffff8155daa2 R09: fffffbfff1cf9fd8
R10: dffffc0000000000 R11: fffffbfff1cf9fd8 R12: 1ffff920006f9f64
R13: 0000000000000ed5 R14: ffffffff8c86d500 R15: ffff888025074010
FS:  00007faa906a96c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faa9075a366 CR3: 000000004f7a8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_fb_helper_ioctl+0x114/0x140 drivers/gpu/drm/drm_fb_helper.c:1093
 do_fb_ioctl+0x40a/0x7b0 drivers/video/fbdev/core/fb_chrdev.c:155
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa906f6109
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faa906a9208 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007faa907783e8 RCX: 00007faa906f6109
RDX: 0000000000000000 RSI: 0000000040044620 RDI: 0000000000000003
RBP: 00007faa907783e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffb0
R13: 0000000000000000 R14: 3062662f7665642f R15: 6d6f692f7665642f
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

