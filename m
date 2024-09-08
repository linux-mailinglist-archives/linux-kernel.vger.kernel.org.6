Return-Path: <linux-kernel+bounces-320093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7897060F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9278C1F21E57
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88512AAE2;
	Sun,  8 Sep 2024 09:31:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F982E634
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725787864; cv=none; b=boC1oBQgiqJjWqNKJMd88p/AlHEyY1cDABq7Njd5QGto/MXsv/K1EpigVTmz+OMlAbpkDQUjcT7K91iNcpY4SR3ENK7lOaFfh4rBjANClK4oNFQ8k9+K4t8R2f2KW99+TjyUTqIjHkM8cyw098Ej4WAzq3LJy12dKlTidkwqAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725787864; c=relaxed/simple;
	bh=+K1CeprkEYFncv8fP5cBqE2BvCcDNsVvMJinBgwS2h0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LKUW55WmXM36l1QFgy8LXm0tJvRtox1pi9hGBIY8Vcf4eacMKl/NFZ5I0VtRidMBBZWGZQrH3V9Qp7+7C8q8v5/TVY5GhjdfEUTpPMuoH5iijQDfqURWe+0vIlyvwNiqUbLsAMb0DKtTrqmgeyhU7AeQDPK7R4AZvj/zYdjcrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a22983440so673897339f.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 02:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725787862; x=1726392662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWKWb5nnnWmAmtEdNfEmEa9zlDMIfHpbcift9Go+6ns=;
        b=Zu3f3joOKlCIC4c0qTRhMQqnV++pxh0BKOyBs7yC1+STFJ+u1QPt8YLt97Y3JiTzz/
         eMx/SxoqeDEBmt3C30+dyPq0VBg2u8dCjOIg5sNkoilyDNu4uNqNPn5/bn8Mve9Z+r8n
         2je1kNdmG6xsZapNc2QJspM0jFIBiF4Ya20Z93idywd+fyhrsP0KAY3kW7IoaX5CP5d9
         Xmfcj9QXdpLPmtAbhm6DM5xdH5OaVWn92ebT+jkvMP2G5U96ds6trmQKgyfc7eKyKz8n
         AifTkSv+QGrnkUyUWglwJkdSNT3WRIEy0Puz2M7Fb/u3rd65Uqlf+ygRpQZF4ZgXS5C5
         Exkw==
X-Forwarded-Encrypted: i=1; AJvYcCW3osAJHpD8XwT3L/asn8vZGLMgKfi5rF1rOAUlYlf6BJuYp3SdrmUgnki7c1G9Y2aPSGIaHfDNCcFZEcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsZUDEEImc445L5dbUjaFQDsAW4EAXCwBf9XpPiTQaAxSIcc9
	G5HS4WsknqMq+pLQ3kGGYqjuJm56kGhLz+oADqc49zvdIZOclQ9LW7OwxxuSruRSy5o72AHZK9Z
	e3lrmRyLKiZ9ZYAqXxr3ML++JhQdtOgJsP8BjNmGrpQArylV0Hp9AI8E=
X-Google-Smtp-Source: AGHT+IFm1nQfF2WaIzh7NoFvlT2YUZq2B8FwrC4UQEkJpPaTnYfwkiQG38oeNaSATaTGQoCsRrc1Oh3nPZxRl+rfDWjIOPIL/8bu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d2:b0:803:cc64:e0bf with SMTP id
 ca18e2360f4ac-82a96172f24mr1343650439f.2.1725787861897; Sun, 08 Sep 2024
 02:31:01 -0700 (PDT)
Date: Sun, 08 Sep 2024 02:31:01 -0700
In-Reply-To: <20240908081643.8511-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007766900621984c6d@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata

==================================================================
BUG: KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata

write to 0xffff88810062608c of 4 bytes by task 7571 on cpu 1:
 jbd2_journal_dirty_metadata+0x346/0x6d0 fs/jbd2/transaction.c:1560
 __ext4_handle_dirty_metadata+0xe6/0x470 fs/ext4/ext4_jbd2.c:354
 __ext4_new_inode+0x11fd/0x2200 fs/ext4/ialloc.c:1124
 ext4_create+0x172/0x2f0 fs/ext4/namei.c:2832
 lookup_open fs/namei.c:3578 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0xdbc/0x1f00 fs/namei.c:3883
 do_filp_open+0xf7/0x200 fs/namei.c:3913
 do_sys_openat2+0xab/0x120 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_open fs/open.c:1439 [inline]
 __se_sys_open fs/open.c:1435 [inline]
 __x64_sys_open+0xe6/0x110 fs/open.c:1435
 x64_sys_call+0x1321/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:3
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff88810062608c of 4 bytes by task 7575 on cpu 0:
 jbd2_journal_dirty_metadata+0xff/0x6d0 fs/jbd2/transaction.c:1516
 __ext4_handle_dirty_metadata+0xe6/0x470 fs/ext4/ext4_jbd2.c:354
 __ext4_new_inode+0x11fd/0x2200 fs/ext4/ialloc.c:1124
 ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
 vfs_symlink+0xca/0x1d0 fs/namei.c:4568
 do_symlinkat+0xe3/0x340 fs/namei.c:4594
 __do_sys_symlinkat fs/namei.c:4610 [inline]
 __se_sys_symlinkat fs/namei.c:4607 [inline]
 __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4607
 x64_sys_call+0x1dda/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:267
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 7575 Comm: syz-executor.5 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134f8877980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81d40b0108ea8fe
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15538877980000


