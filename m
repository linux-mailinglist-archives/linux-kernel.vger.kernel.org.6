Return-Path: <linux-kernel+bounces-183000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7718C930B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 01:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E72281C8C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E686E60E;
	Sat, 18 May 2024 23:30:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F326CDC4
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716075007; cv=none; b=cDP32te24qSpqVQd/3yyNiuI57IWDyG1iau2uAIrHSNbdwRHvk/bQEz4+Tnu/K8i9dBxlUAPH1Li7w461WTI7y7vQS+HH83wJKuRVREcpPs8Ez0XGrbsk9Gu0V9bUL1JAhmwN2ZlSUQ1Fv/O2r4ThirxiYvMJ+Pel/rzkgfm3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716075007; c=relaxed/simple;
	bh=OHVcrpRG/Ff/JDJx+TE6LDvHPDydBIpW7rZTfwVCXFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dN2AcfHU+I3PzA2ci/7PlcwYA4rziAXondutx662Neb/Hm8f4zxX+qAy7OoFcBooQb6AY+MQ16EctKpsGFkgd1a24jb/vzaI6jwY41vqOlfHoeJw9jSeaNvRRCcxw7B3s/sfSjTvAVrLtUulQQoW28hNZolhb2zFQchUxkDU99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da52a99cbdso1164555039f.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 16:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716075005; x=1716679805;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmZPJvCOB284UidVulrQfEAbqoiZMSa7YRxF5qwhJtM=;
        b=QIhNfJEFQEgx1sm8g9LhpBn7so89gD7WvYmHkaEuPKGCpiQ6wEgiGAiDk+GC2j+Rms
         dFO5O5VH5pfWi9BkblmEjkPsIxtqYlzXx+gUoG7r54wey9VujlZ9EpL5lcYY/F5iWJZm
         296v1OLGJsPFuysEDR+RRVtk/BBGIme3ca8sdYaPmNYd+6BgouJHV2qpJUXyUmNyw5yE
         wrmhFWmOmKFGPXN8RxJaVAZ4hlYaibygAzgT6/oZIUV/qs1bsTNJcUtaYc3kVu7Blw3z
         8s1jfHe7Ef0r/r4DBU2xFsp0ihRuKIkniyLelMqOCQgibwZWS9wcknwuI3OTvBEsy9ty
         mXzg==
X-Forwarded-Encrypted: i=1; AJvYcCWpzzZRIprsuTAe3OzgCk7n3lqrset4NGN61+vnXZ15ML4i1rq1ePtD9Y+OjbDnughYvRbHmVlGO1jo1b89SEPucK9Zh361PrsA2Va1
X-Gm-Message-State: AOJu0Yx07A06q18lCZmyj3ZPga7NvbYSu7GEnr2cx6P1NBvJ8naILMTB
	BPMFFIIJ3NBH32Ci/2KPP6M8MY9YwiUw2vYVfsNe2XVCTqaZj/vXoicAQSjMGCUVrGJA/EcqaE6
	+iO9B58dLPWOTFF59NoDJMuePfYnye4uF3v5O5FVqTBOrVJ4z5RHvtXw=
X-Google-Smtp-Source: AGHT+IGXZIOSfjDHJYyZP4eexv/KeRfbYfdBkPBgdWidFwL6WV7WmuHVRr7q6EirNQRtRm5Ai0Jdk9EvSWC5qs+WpnFwtwSss9+8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:484:b0:7de:e2d3:20ba with SMTP id
 ca18e2360f4ac-7e1b500ced1mr93771839f.0.1716075004968; Sat, 18 May 2024
 16:30:04 -0700 (PDT)
Date: Sat, 18 May 2024 16:30:04 -0700
In-Reply-To: <20240518230811.1915-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000144f280618c2d9e9@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
From: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in p9_req_put

9pnet: Found fid 3 not clunked
9pnet: Tag 0 still in use
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 3 PID: 5345 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 3 PID: 5345 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-08284-gea5f6ad9ad96-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 98 2d 0d fd 84 db 0f 85 66 ff ff ff e8 0b 33 0d fd c6 05 97 cc 4c 0b 01 90 48 c7 c7 00 24 8f 8b e8 f7 47 cf fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 e8 32 0d fd 0f b6 1d 72 cc 4c 0b 31
RSP: 0018:ffffc900037bfc78 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814ff319
RDX: ffff88801f798000 RSI: ffffffff814ff326 RDI: 0000000000000001
RBP: ffff88802c045108 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802b369870
R13: ffff88802c045108 R14: ffff88802b369800 R15: ffff888025704c80
FS:  000055556f75f480(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555569357788 CR3: 00000000278a4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 p9_req_put+0x1f4/0x250 net/9p/client.c:402
 p9_tag_cleanup net/9p/client.c:429 [inline]
 p9_client_destroy+0x219/0x540 net/9p/client.c:1077
 v9fs_session_close+0x49/0x2d0 fs/9p/v9fs.c:506
 v9fs_kill_super+0x4d/0xa0 fs/9p/vfs_super.c:196
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f936f47e217
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffeefbb92f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f936f47e217
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffeefbb93b0
RBP: 00007ffeefbb93b0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffeefbba470
R13: 00007f936f4c8336 R14: 000000000001951c R15: 0000000000000005
 </TASK>


Tested on:

commit:         ea5f6ad9 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14b71442980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1cd4092753f97c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c7a495a5e466c031b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160f3b68980000


