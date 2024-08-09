Return-Path: <linux-kernel+bounces-280607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F08E94CCC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0B81F21DE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932718FC68;
	Fri,  9 Aug 2024 08:56:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273B129E9C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193764; cv=none; b=oaK/XtMYP4hgSh6MXyfD2ceiYXfg86G0RKgnqdmsxIUWu7FpYB5t7zgWEICPTPTHfjnvaNzQgXsvHfx2ycqNo0p39Lnw1k2XIUxw4EJBGw7ibw0kXxVRkt1XHLc9+La6akKz99C/ZrUKTbQ27uCneulT6hl0EEqEFi3vb1OhrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193764; c=relaxed/simple;
	bh=bbZgZIoiG27SFmYN/lsacOlLUj58fCfeMZXNrYP+rDQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f1dF1MIQmYYWiCwzPjwwGjoe+0q+2ejMSrKf7DFJpHRCF/SRKTOL2lYOgHXxhMKTk+nbI9wWFxvgp8eIvnbkbSnfuGs5iua2FcHZDMXohuOKGR7EoZJiAa/Ix/FiB4/T+agqahcEVJBPpiLcKyLhtsVEo9fJQeDWCsIr1oq9eHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39915b8e08dso25482145ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723193762; x=1723798562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zq/3p0txHm2fdfnRa+7KgJfvchkPRGb/K8AQIJnimgY=;
        b=YwibV4G5hTjZ/xs2pztbR0YsBwzMYdtIwirt61nMwLmuyzXBCx1N9R9wnh/cX2+amb
         eY/DfPwX87uThAvqgF6ELNGgL90qhN2UyZrX8o2UP+dD+uF096c/VIF4YW86GsWokRju
         U3sRvz+tCfq2zvL4SGxnMvtoz76vUdstIs4xOTiD5MhMxHB3JGEh6I2ONlMFpacExw+F
         0l5nIbB4UZNkSadPAoXqlylrbpnKRdQGVwJvi+VSBFrUSWZblU9JqhAvClVprYpiRn9N
         823a84G+xqNBmvfWnWIghJ76xLDG2DAgAHXJdxOvWCppZy3c+J+5xTeXXRbkFm3g5PHo
         WnDw==
X-Gm-Message-State: AOJu0YwdV4Po2V6/7AuzV/S3YYE289OJF37ZBTkiwZb0r1RNJgLNPq33
	k/VBHyeU/N8E1/L5MhS33JhnQNJxjENaWtg0nkHMYuVKKiBwem/27QXiSE3ClMWaEAeowBEYyJW
	l0rsZKS0qAdOmaqisIsVODe5GI0d+TuYi4UauKwi/kOchMhbIhRchn6w=
X-Google-Smtp-Source: AGHT+IG3vg+1Uaz9jnJEPVNRkl78vAqczCRKpMYJsYE/PhVeggnxpCjQKHkHsWgzDxusdk7Zdl8ApDD5xS/HTvIG1s9CvBeZsgWn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ca:b0:375:a55e:f5fc with SMTP id
 e9e14a558f8ab-39b7484d58cmr750985ab.1.1723193762198; Fri, 09 Aug 2024
 01:56:02 -0700 (PDT)
Date: Fri, 09 Aug 2024 01:56:02 -0700
In-Reply-To: <20240809083558.2702436-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000135217061f3c503c@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901336
WARNING: CPU: 2 PID: 609 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
WARNING: CPU: 2 PID: 609 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Modules linked in:
CPU: 2 UID: 0 PID: 609 Comm: kworker/u32:5 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-21)
RIP: 0010:v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
RIP: 0010:v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 66 48 8b 73 40 48 c7 c7 20 9a 8e 8b e8 51 4a 0d fe 90 <0f> 0b 90 90 e9 62 ff ff ff e8 32 2b a8 fe e9 51 ff ff ff e8 98 2a
RSP: 0018:ffffc90003f3f480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880321a6d70 RCX: ffffffff814cc379
RDX: ffff88801f710000 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802eb42408
R13: dffffc0000000000 R14: ffffc90003f3f840 R15: ffff88802eb42658
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000740 CR3: 000000004221c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x656/0xde0 fs/netfs/write_issue.c:534
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x611/0x1150 fs/fs-writeback.c:1947
 wb_writeback+0x199/0xb50 fs/fs-writeback.c:2127
 wb_do_writeback fs/fs-writeback.c:2274 [inline]
 wb_workfn+0x28d/0xf40 fs/fs-writeback.c:2314
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13b83d11980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10689dbd980000


