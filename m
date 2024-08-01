Return-Path: <linux-kernel+bounces-271370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56706944D45
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC331F21A4B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844951A38C4;
	Thu,  1 Aug 2024 13:38:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD81A2C03
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519486; cv=none; b=IvI5/YrVQDTihOhzbrt3/ypUVaWm+qxC/kuJbUW+B2FYhXNgaKKS3apHSxtSjwH3QRIxGCXjjPJ9XZdsPH93hbNdeDR9mXFMRQ3adkUM43o7tHCPr3iqjF4jLlrmaLP+PHG442auX/ssYzApRuvaQ+MWNZg18ncvt0ddGplOwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519486; c=relaxed/simple;
	bh=46++KIrsEnYZcs0HLq8C2YF+vOwH7WgdlPb1A/2DPCo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X9SS7bxW/iH+zbZh+itdVhWCmDleUUthoCm5xtgZ+wGqcA+sBWTjczoxoLnvMYyIA/GruF7m2RPtOr1hmlDThT+f5H7wrL+Hv+NhPShH09Zs+LcsQQycQwa8ZJry5ZGyq5haaCtarI0FK6zKnnnhn+SIr52qtMJerc7HEFJ8kLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f93601444so990675139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722519483; x=1723124283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa3daMPEc4UafLdYf5eErxcO2bh5GPkwwkty4AiZj8M=;
        b=vwflIMPk4EPwmfPrmsdVj5fRmEdz2psN6QBy3yWjG9kiXdDFigmHLHsScbPLMEy04o
         0IjlxB5b63ERQiFSTBFHX0uzkO7MbDEMG8U0TUUj3FGzC0yRxQgI4glhT9aHBmdOUJPB
         CdyZ52V58NEHKebCzQ2RrPDSdgTWcKSoOpg0TQAhrcCIYFBOiABTrUq/FHt0a8Wzjy5X
         x1/jFVZvSGXjhEO5Fiw9yNZmYr7qefKmtmRhE2XnaXZpiSp6iB5KVh0vIf4pRxK2MBPc
         f//IWLpR4DOeT9uwQJI3Rl2M34LfrIfVkHcZFRFZCPVJ+FX/j9+YJx8XXJp0OuVmaavi
         46Kg==
X-Gm-Message-State: AOJu0YxuoMVNoL+38O1PNXdWRWHRQ8JBfmbW7Rv6cgQHgAK7Le9CL+ab
	5DvLqQ55xmqN5VC4fmLPJOCHa1a2fCT31fe3/PhXLx1cssSRjRJ8oA0YiygDkxJ2NLG2a8VTv38
	dDGx5JIFy2DObvEFAlpgUwXlXbNuy7brM+MDNdq5zTZktXwdb+dpZAkA=
X-Google-Smtp-Source: AGHT+IHZdm+d5Lui3EPNuFWaGyZ/blBY4xW7XvDDD8RWtfyBVP6i507QgQX78cKv6DeGJ/+Ea+ux3nAOrgiAQDvk9MPLmk58FdUO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cae:b0:397:5d37:61fa with SMTP id
 e9e14a558f8ab-39b1fb79788mr105495ab.2.1722519483617; Thu, 01 Aug 2024
 06:38:03 -0700 (PDT)
Date: Thu, 01 Aug 2024 06:38:03 -0700
In-Reply-To: <20240801130611.3460940-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0aac5061e9f5168@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in pick_link

loop0: detected capacity change from 0 to 8
err: 0, folio: ffffea0001294400, in: ffff888017408878, read_folio: ffffffff82fd66b0 do_read_cache_folio
folio: ffffea0001294400, isize: -419430361, idx: 0, squashfs_symlink_read_folio
error: 0, squashfs_symlink_read_folio
err: 0, folio: ffffea0001294400, folio uptod: 1, do_read_cache_folio
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
 do_read_cache_folio+0x11e/0x1260 mm/filemap.c:3753
 do_read_cache_page mm/filemap.c:3857 [inline]
 read_cache_page+0x63/0x1d0 mm/filemap.c:3866
 read_mapping_page include/linux/pagemap.h:907 [inline]
 page_get_link+0x76/0xf90 fs/namei.c:5272
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

CPU: 1 UID: 0 PID: 5944 Comm: syz.0.15 Not tainted 6.10.0-syzkaller-12708-g2f8c4f506285-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=126e41a1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a51be3980000


