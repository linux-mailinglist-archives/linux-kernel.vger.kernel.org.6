Return-Path: <linux-kernel+bounces-271427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10315944E17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4247D1C25893
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B31A4884;
	Thu,  1 Aug 2024 14:32:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8FA31
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522725; cv=none; b=aXAH9v5MddDjj/Keeq5rqyMrNyZh9xfexUJDeslBhvHDUai+ZQVmfihiQ8nY4tGHRKM9GOT+DvR4fONHt368f3YQBqFgT/KGVgUeUF0KGkJeOzfFJ+S0yRwaX2dI6VieuKura3j/MzBXibnPzDZksj3SrFjjdFR7z20EhDT4Im0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522725; c=relaxed/simple;
	bh=l4EvegK1lsFwFDQfIc+o40erRJ6PPV4WVQsiZBgyQGU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Myu0NssfrDqOfaUMypegxETP5VNXVWIgn0uud6iPZRx5R/K1DTKptaFCcGYcE3L6M0RG915svLmylWyfrtUQUwitaiDPBr9bG18JUBZyl6PyG51XGLbSocAUFPmi3E1+9LCgadjxYfp37/tkfxmxcyyPZGmNHg3cLuJn+R/csPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso247950439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522723; x=1723127523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXi5Lq8SwcfEB1RXy/HrPbEs38KKL+G4IWf6H0HvFGQ=;
        b=QK2mzeL+D2K3ZfYEz9JZV68dIWewO1iAk8bu1nf5K1Vt7gOZrLhOKL5lUgRPxNYUl0
         CkyA6cFLo7OjOOKiK0e+URlUlLme09g4Jtqssc5MnWnIvyDj0MFCEMKx/++5pyDgNrGJ
         riyYbR2BaBLmwKQI4ewXC1ZPK5lcurrVhDQZSezUZ66J4VB9NtUMO2s0xabLFfslZX9G
         750g9/uWk5thI2yFqlC3sIklDxAnOthgmd6Mi2VNuwhZH/auuRrEoLRhc3EhiRw0kXta
         SwbW8wwmeyvp/xh56g8s++HlPWvKGi1JST8YjR+VfngVnMEgmt/ZJ/P4mfPGWQ5QkYaL
         ol0Q==
X-Gm-Message-State: AOJu0Yx4+TrDBl2wdl8KCDItksJDk1M5ep4GMvuU44BbCEur9Aj3dyas
	MT8bhkYollI++4jIOvPfJE0xN6UTlq+/dOm6Mj4OOCJbtRa+QHHnLEqYK30cMDx7z9JhR9gAaBm
	CO8y9MQm6CS7cFaLN7Tl7amG2ohJPgFYqsKyCLAsYoERT1FSzPUy36pE=
X-Google-Smtp-Source: AGHT+IFW4veIBzLOSyalqSwjCPXnf/yAIoqbNboxXXSSRMWOmneU1anHyF6GlemZMq6C8YUCdLwLDdE4LQXvodTU4ML25yw2fMW6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9816:b0:4c2:31f5:3137 with SMTP id
 8926c6da1cb9f-4c8d5154edfmr3656173.0.1722522722928; Thu, 01 Aug 2024 07:32:02
 -0700 (PDT)
Date: Thu, 01 Aug 2024 07:32:02 -0700
In-Reply-To: <20240801140831.4016416-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000049cf7061ea01333@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in pick_link

loop0: detected capacity change from 0 to 8
folio: ffffea0001163860, isize: -419430361, idx: 0, length: -419430361, squashfs_symlink_read_folio
error: 0, squashfs_symlink_read_folio
err: 0, folio: ffffea0001163860, folio uptod: 1, do_read_cache_folio
=====================================================
BUG: KMSAN: uninit-value in pick_link+0xd8c/0x1690 fs/namei.c:1850
 pick_link+0xd8c/0x1690 fs/namei.c:1850
 step_into+0x156f/0x1640 fs/namei.c:1909
 open_last_lookups fs/namei.c:3674 [inline]
 path_openat+0x39da/0x6100 fs/namei.c:3883
 do_filp_open+0x20e/0x590 fs/namei.c:3913
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1442
 x64_sys_call+0x1fe/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4719
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2263
 alloc_pages_noprof mm/mempolicy.c:2343 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2350
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1008
 do_read_cache_folio+0x121/0x10c0 mm/filemap.c:3753
 do_read_cache_page mm/filemap.c:3856 [inline]
 read_cache_page+0x63/0x1d0 mm/filemap.c:3865
 read_mapping_page include/linux/pagemap.h:907 [inline]
 page_get_link+0x73/0xab0 fs/namei.c:5272
 pick_link+0xd6c/0x1690
 step_into+0x156f/0x1640 fs/namei.c:1909
 open_last_lookups fs/namei.c:3674 [inline]
 path_openat+0x39da/0x6100 fs/namei.c:3883
 do_filp_open+0x20e/0x590 fs/namei.c:3913
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1442
 x64_sys_call+0x1fe/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5977 Comm: syz.0.15 Not tainted 6.10.0-syzkaller-12708-g2f8c4f506285-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1192af45980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137d83bd980000


