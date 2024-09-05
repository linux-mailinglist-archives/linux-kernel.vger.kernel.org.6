Return-Path: <linux-kernel+bounces-316543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACAD96D0F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C688B2279A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6431946A9;
	Thu,  5 Sep 2024 07:57:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6414EBE4A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523024; cv=none; b=lTVaDtpTb4rl+o+UL1GMrFLssyv13xXlgK9mrxzumyz4JF8kOl2aGFnTZN9jL41FjWgbWnmzvwfnCXNG3hvFnoEBf/7pAzhfOU8c6fLSl1nHNBfBEsi9Da2i4ToTh7koUOcKvGwuQAlGFHnOQzKxFuBqdDsYdt9TF12rpXjoZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523024; c=relaxed/simple;
	bh=hqQEZmtDxYnRFaRXYxmmExpheVlMmkQEBD9FWInRZi4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V01PbO5+DHymsaALRE/2n6EKhIQWaC+B4n+M0tcXHiNyeIX5kxaGQmlVEhzdwsfXFr8NHwL+DDbFZXSK/CL3p3wNVymbZkm23Do+IKtyEuYtbePd7nUbMfSMp9w2CTzUcYUzj/GONefH8XSv2V/ANWmO/08+y+6c4fnB6ABaTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a206312eeso86916739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523022; x=1726127822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWFRUKiYjgZhgwMHAzZEuCfAEAt5tf6gCveF2TlOveU=;
        b=PnJgP3z+X6DrZIXaGYuDszWygOLRldcwigiiIHJR/4LqjWoxchqeXPMijwQhljEkal
         yQ5xOgZ5PdIRYliPD8Dys10rROjtyScvH8oESXZYsLlukPKhrZFdRtkGZTPr5CqWCXKV
         ZGvLhXb488ZDXUEe78Qhh+NcIFtQX96hMUQHCVpg82zYPwGfvb/cCqMbEZZJBvR1IU/i
         spxmB4a+mPB6jQbBg+3KGKJknX0GAGIq84ii8cEvLhAggxGBXi/y7PmOrsXVJEYM7HUm
         BbwURkH0k2eaR8Oiayp97QkmwaXgtEobTf1yQwW9FDZu4YLv4hEpOI7HRnuo3wsMJ6PF
         IWRg==
X-Gm-Message-State: AOJu0YyyhI1GKs+tbohL9EId/yeolqqZ46EDhuXkLTwzfgkn1nWvIbqt
	40rBDFHDdVJABilwgnOsBYk66M+o9c52NJOdsfKLqiXiTuS6Pdhrkly0/zlaK42SA2GqQ34x3Zb
	4bXaCpKrjIQzW/Zkc/IGEGTgvUxJSV3wl4clzCAKlfxG+2NuTekakbDc=
X-Google-Smtp-Source: AGHT+IFwpBwBPgWDZN6ZbEnqVTl8zRIgYLM9s0heMikl6f1B1ghfOzcI4FJtZ4KIuaDuHVSkLL3QQo5/KVpHa9wy5mk05WMSBfLt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8720:b0:4bf:2453:3a48 with SMTP id
 8926c6da1cb9f-4d017edce7cmr714653173.5.1725523022588; Thu, 05 Sep 2024
 00:57:02 -0700 (PDT)
Date: Thu, 05 Sep 2024 00:57:02 -0700
In-Reply-To: <20240905071112.1621278-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d03df706215aa23c@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: kernel-usb-infoleak in usbtmc_write

=====================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x597/0x2350 drivers/usb/core/urb.c:430
 usb_submit_urb+0x597/0x2350 drivers/usb/core/urb.c:430
 usbtmc_write+0xc4f/0x1240 drivers/usb/class/usbtmc.c:1607
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
 usbtmc_write+0x3d3/0x1240 drivers/usb/class/usbtmc.c:1547
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
Memory access of size 16 starts at ffff88810a6a0000

CPU: 0 UID: 0 PID: 6214 Comm: syz.3.81 Not tainted 6.11.0-rc6-syzkaller-00070-gc763c4339688-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


Tested on:

commit:         c763c433 Merge tag 'bcachefs-2024-09-04' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13324667980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a7fd29980000


