Return-Path: <linux-kernel+bounces-316675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB4896D2A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A34EB250A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28861953A3;
	Thu,  5 Sep 2024 08:59:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A697194AD9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526744; cv=none; b=oWeWO3Y8k7WCD/ZIjzxOpY39c1biGcHeHs/eiFVdezbbfBGIz7qwlkzJJ57X9tnwmRJicYGpEGNMCUAHHqYkAdYTYHXKmSMWd/eBh+QDdrSP1KXharzmjT+XbwNP8a+ZYzZsm0EnrtzKUThjLikjLLnmy9l3nM5gAWgkQeVVLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526744; c=relaxed/simple;
	bh=l66u4E+lkBWOoNopOzdJgLyeEmtmPPebVNnzWNz4drA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hKXv9L2hw80zCD2jNDxe/4bGgXZ02Am0hOqwv1Wdy+7NWrZ5xeAOXvv6zRkinVFOBeyAwiNeVS3tDAmaPEU1iXPvrd3jEdqKrOq5KIZGyvO9rrh5ivGHIqH9XDhGz8r7Vh/pGkVhNPCrD8retP9kevsWHMtUrFqXIuEP6wr/dVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a045e7ed57so10319425ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725526742; x=1726131542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7qskDsSLaJJiLOOgHZ+8hAGxQjTCnIvNsAeyHhTViA=;
        b=sHp0Zln/JvwCg0xYurN7x2EySVx43NLvmmvSyHs+3uKP1h8OjXro+bglZG+cB2DDwI
         AIIRCoCNzLjkVJgKJCpWzWIygXkjtcZ4w36QExnIL8DLAm356uSk5A4mTyqcetWpYgZc
         mqpm++L4GtXXQ/mM5yhl14e4PifWyqI4lYTEG1lw/6rERdEEH1RWzdroex/ZIm2JnXjj
         zfTd3WsPmqdea+fk4KzX700Jew3XGZEA/61ZhAUTAEMeEXva89EUg0cVG4gRsASdu5ki
         /0yc/VeIN4X0HOnyT3AlTu8GJ1UuqNtHZXVk3HV02ojjQRohOCsveMTFLkEeGmxBocRZ
         9gRA==
X-Gm-Message-State: AOJu0Yxi6MzuFw+Tv6Obbm83hKZHWK3e4gMfyxkCbRzczhUZGaKX224w
	WXBbPwqx22UhdQQcBk93MdASqnjVto3PQ+pppXdtUyTlZRzo8d1NdfBw4WABiKtF6D+yTJLzU39
	NctP1UvL/u5MigodI7xTqhmaZkHmTpH04KFQs1DAi3zdw5iQ5gLOuP5c=
X-Google-Smtp-Source: AGHT+IFAkdQK3XtbYLTtOLnYzXAKHxWmD+hxOgPSMU9sC8qlK/UrJigkRBPK+9LJzh2jfKBq8B3i95zsLgY+5inanGldJWE2TjjX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:39f:5b92:15f8 with SMTP id
 e9e14a558f8ab-39f73bafccamr4566315ab.5.1725526742288; Thu, 05 Sep 2024
 01:59:02 -0700 (PDT)
Date: Thu, 05 Sep 2024 01:59:02 -0700
In-Reply-To: <20240905082935.2536851-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086587a06215b80e5@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: kernel-usb-infoleak in usbtmc_write

xf size: 3, count: 3, usbtmc_write
=====================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x597/0x2350 drivers/usb/core/urb.c:430
 usb_submit_urb+0x597/0x2350 drivers/usb/core/urb.c:430
 usbtmc_write+0xb26/0x1270 drivers/usb/class/usbtmc.c:1608
 vfs_write+0x493/0x1550 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3998 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 __kmalloc_cache_noprof+0x4f0/0xb00 mm/slub.c:4188
 kmalloc_noprof include/linux/slab.h:681 [inline]
 usbtmc_create_urb drivers/usb/class/usbtmc.c:757 [inline]
 usbtmc_write+0x3d3/0x1270 drivers/usb/class/usbtmc.c:1547
 vfs_write+0x493/0x1550 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Byte 15 of 16 is uninitialized
Memory access of size 16 starts at ffff888117169000

CPU: 0 UID: 0 PID: 6369 Comm: syz.1.63 Not tainted 6.11.0-rc6-syzkaller-00070-gc763c4339688-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


Tested on:

commit:         c763c433 Merge tag 'bcachefs-2024-09-04' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143420b3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1055bd97980000


