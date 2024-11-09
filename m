Return-Path: <linux-kernel+bounces-402814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E79C2CD4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 13:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8371F21926
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83701741D2;
	Sat,  9 Nov 2024 12:18:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5B126C02
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731154685; cv=none; b=qDA9qORHFe+CQ06Z+u0kUw2CdFrjovtamr+cKp2SyssMOXE3DN1Ih7NqNTS78wkrUFYRoEscwgctU9N0/f6NgViHYiFeR58xxaA5PdhlIJdUU9MjZSh7yGFwuqMDsiHjsmZU+YV9NVGA9x4uHstOsHx3wf3n1yXUC3mUzEQtE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731154685; c=relaxed/simple;
	bh=cebx7/1DGF0xoCSIhARVSdMEaiSa85FiyAtz1hRkaAo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JZEUrHRQ1v2yqAijDX6sjssxg0kyH/yniaf2lENU6/NcnZgUs9BxbJsUZ+/bG2suYE2nX1+3EoKsLDHyXesR06C47SQkXIjX2DDu/qbRk9y/TywZK+tycBmC6Z7qMtTsJfAUs0f39Kbh4DVtRZsZXjp2lltt08BXseMNLmG8UR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aae46538bso335798639f.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 04:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731154683; x=1731759483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfFOSUBZlPmuZ4bJrN8Xu5uxVmnHcEEpoRpF+vMTQkk=;
        b=kD5zyb5Ldl5ACv2MykkD3zUCISpXfqSm3OetPSycryQ+2Uzd0KfErRq5UONDzAY9Yw
         hiMCShPosUgEvRt4yJ8lVztOQUu32pNu6SRSaydRLtS4xbNSDlVcQEoqAw4d2Hqus+XU
         rFqymC+YN5TrwQWY/ycfBCGB1RkH2utvYBgUj4jmVFkCxn1cQiPD3md4xgYcn6wwdwXD
         LoAKrwKZ+pxnD2gvGZSeOzoeLGRx793Qp7t+Y/iBm7ZFLp2vC4gvJ7KUybYn1p0pRgLh
         u0mNxoTTw48q+Czcv3k708X/J/uMoRtEYrF/GmKMXDHbDsWl2ytv+OIvyIKqTmihVj6e
         ZVrA==
X-Gm-Message-State: AOJu0YwmNXXc/NpcO+CsZoiS3/a4YVDKNqzY0+P1G4F59ppHIHjbQz9M
	rbSEJ0RuZD5iZIs5c1HyXPNi2izWIop8mkOt2d30xzCJ0IoLjJYIh2+WsTNd5wp+pI2D/xPmI+0
	lmMTL4GwMkmvjh8XAPg7YJ7GF+r5fly4t9Z43Pfk7N2zuEJWSsJTtBAc=
X-Google-Smtp-Source: AGHT+IH8rs0mbMLaYSPoFYg8gCjAyOQ3E7XVollIwtb/Lpxc7H7bJhqGUpu2l/P6KTkb+cL+QcBvvB4rQSRy6gm8yZfWo9rQxN8a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a6f1a59322mr63579515ab.23.1731154683010; Sat, 09 Nov 2024
 04:18:03 -0800 (PST)
Date: Sat, 09 Nov 2024 04:18:02 -0800
In-Reply-To: <CAHiZj8jg7wD9ppGg8yT_XPY3+SRo6ibbHEwvpoQUvNPaJONQiQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672f52fa.050a0220.320e73.0313.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in bch2_copygc

=====================================================
BUG: KMSAN: uninit-value in rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
BUG: KMSAN: uninit-value in __rhashtable_lookup include/linux/rhashtable.h:612 [inline]
BUG: KMSAN: uninit-value in rhashtable_lookup include/linux/rhashtable.h:651 [inline]
BUG: KMSAN: uninit-value in rhashtable_lookup_fast include/linux/rhashtable.h:677 [inline]
BUG: KMSAN: uninit-value in bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
BUG: KMSAN: uninit-value in bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
BUG: KMSAN: uninit-value in bch2_copygc+0x1d5d/0x5940 fs/bcachefs/movinggc.c:221
 rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:612 [inline]
 rhashtable_lookup include/linux/rhashtable.h:651 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:677 [inline]
 bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
 bch2_copygc+0x1d5d/0x5940 fs/bcachefs/movinggc.c:221
 bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:381
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable b205.i created at:
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
 bch2_copygc+0x15b3/0x5940 fs/bcachefs/movinggc.c:221
 bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:381

CPU: 0 UID: 0 PID: 6565 Comm: bch-copygc/loop Not tainted 6.12.0-rc6-syzkaller-00272-gda4373fbcf00-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
=====================================================
Kernel panic - not syncing: kmsan.panic set ...
CPU: 0 UID: 0 PID: 6565 Comm: bch-copygc/loop Tainted: G    B              6.12.0-rc6-syzkaller-00272-gda4373fbcf00-dirty #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x216/0x2d0 lib/dump_stack.c:120
 dump_stack+0x1e/0x30 lib/dump_stack.c:129
 panic+0x4e2/0xcf0 kernel/panic.c:354
 kmsan_report+0x2c7/0x2d0 mm/kmsan/report.c:218
 __msan_warning+0x95/0x120 mm/kmsan/instrumentation.c:318
 rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:612 [inline]
 rhashtable_lookup include/linux/rhashtable.h:651 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:677 [inline]
 bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
 bch2_copygc+0x1d5d/0x5940 fs/bcachefs/movinggc.c:221
 bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:381
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         da4373fb Merge tag 'thermal-6.12-rc7' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1497c35f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4580d62ee1893a5
dashboard link: https://syzkaller.appspot.com/bug?extid=8689d10f1894eedf774d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1329b9f7980000


