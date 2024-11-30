Return-Path: <linux-kernel+bounces-426063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F69DEE66
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326D7B22FF3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F6B132122;
	Sat, 30 Nov 2024 01:51:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA6E57C93
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931466; cv=none; b=u8pv2uUefPkdUJ51pFSWkoaikk8KZ+EqldAtE5aIoMu/3F9fl7Y9+jUPDAZVZNhNH2sM2xN92M1EOz2N98Yvy4WnVBhuK5917w7icNqItNpgNQEUPu03Hggn0zc967nGymPGDl+ZL7/agcC5tlgkNFpNElKN/3b3/NuMWzs/XB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931466; c=relaxed/simple;
	bh=NUbjVQgGoFqAnXA/IchsC9G2+649iBaX9zpc6YKoK04=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X3eJsKMQeH96hpcjJXSjNBzoOb+zDbQm1/w6W4Z5ZBtK3XdR/6oRgWhzCRwhPM7Kf4WPUswfBxceZIEmm4jS994DZoGZCH6584aqjLZbLrMZ9gT6YCVSIjfZI/gzAln1FBHh/G8tDrksMs74cTfpuaTcU8CfFLpB9dnhRezg8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a778ce76fbso22773605ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931464; x=1733536264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfRP17he4fRD3Fi6XiiwKiBdoJ3HW7GQoqniKTEAxDI=;
        b=f+vQV+LDMXQGy40GI8iBjqgW/meb6SaDfFq49p05OCIKFsKv/H3M7rOpgPEG+ryfS0
         MReBD689Rs70bkpeFT3wJ7MPipgs2QM1N90/d2ZCOWet0OI3Ubqe8vOhFTPQs/pVYLmB
         ESvVQ0nw4ou83qvyWGA66BGpdfd9rEHRXjmiC+v4XomWXJEm3WwuoY6sbVACH1zTyAcj
         rrSJZPMGpDfoo/vbkGCl4c5UOM8Igp/4Bx+d15hoC7+ph2xvd6EKDwYRCS9EDAfEeQkZ
         tz2axw7CNkloBqV98FWQA0VuHdqE1xP7trft5L6oM7Lfuum+FT0Lao33nmpNc7cv7hci
         RMIw==
X-Forwarded-Encrypted: i=1; AJvYcCXPCU6OYsjsCKU2XmTEiWchWrfumcsvrCKI7Cm0h2mZDl1nuGKSGdqVbwXBUm/5T0qM5EbBCNKIYzVhsyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdR6z6gp5zZYVSZW02JKR7gB0hrR7eiTETLV4iQ/QaiMr+LJjG
	/ClxN6oVJ+AR6+5+Hb0FvusJXXr89xBJMjBrRsEn6tc/w4OJa/qpMSUq0GF/c5lCosNgDiA0WcQ
	IihPEmlPA0y1wEPZOeVs3Df72ORdsKnRurQQqbAmzizB27wHePMwn8XY=
X-Google-Smtp-Source: AGHT+IGWvCi6MZhdxrapdtlirxLTp6zo0MxlEQi6Z6S1fxcH6GoBRYn2AapBStNo1CI/jCHuUxoGfQINBiAGJLKg1+Kar9y7JT70
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154b:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3a7c55eb884mr133715385ab.20.1732931463806; Fri, 29 Nov 2024
 17:51:03 -0800 (PST)
Date: Fri, 29 Nov 2024 17:51:03 -0800
In-Reply-To: <fcc3cf12-9ad3-49bf-9880-5e82dc7d7e99@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674a6f87.050a0220.253251.00d5.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
From: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org, 
	wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: MAX_LOCKDEP_KEYS too low!

BUG: MAX_LOCKDEP_KEYS too low!
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 11728 Comm: kworker/u8:10 Not tainted 6.12.0-rc7-syzkaller-00133-g17a4e91a431b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btrfs-cache btrfs_work_helper
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 register_lock_class+0x827/0x980 kernel/locking/lockdep.c:1328
 __lock_acquire+0xf3/0x2100 kernel/locking/lockdep.c:5077
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 process_one_work kernel/workqueue.c:3204 [inline]
 process_scheduled_works+0x950/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         17a4e91a btrfs: test if we need to wait the writeback ..
git tree:       https://github.com/adam900710/linux.git writeback_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=12c5ad30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4954ad2c62b915
dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

