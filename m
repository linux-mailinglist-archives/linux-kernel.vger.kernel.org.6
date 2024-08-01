Return-Path: <linux-kernel+bounces-271188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60EB944A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90944284DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E3A1917DB;
	Thu,  1 Aug 2024 11:44:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04FD189B95
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512646; cv=none; b=Aw46IW5KGNuYvdO5HXrnNZnLsyrQ2xdvmx1By6dkrtNzmKaCjyJwNBjvrWZifyCMCGOlUZj6d/F46m5MrtKux+MIs5WVE1jYyM/uncx1Zr2t9IhskoTC1qH2/4s+3ShTB7IUHQMsBpRS1MY8HU9lftJ+uIdPhdFBnWq/o9sXQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512646; c=relaxed/simple;
	bh=3+ImdkhwLyVDnnGq9YkEM+bJ25pPtqdt6AhOle8uago=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=St4iXiUbiihj+K70fCya79Qptg4DIMD4k3ZfUMLGiz/fLUTB/snj3//9oJd3CHT61LophxW5CHH/eFUDy1zUF7Sk9bIROJPyvEZf9TEZzw114Wke4xiCOtkGt5TswpexJKguQNUpkS7uwRjzlTlz6ERiEWYHJ/K3+GMB7MO/oL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-397a7f98808so140458045ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722512644; x=1723117444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hJ9vfNM6KRL/IOW0H4GTKldHeNk39XO/IjMPkJp+Ho=;
        b=XTMVZ6iCSeBOLd+2irCEC71y/b2zYcK4PQlkK3bpIWG8wzhzVJ+WS/wfN/rTBgI9O6
         DvWQelW1Dz7hNiQcBStUbi85t5gdG/SG5CHqCUq62nvYYRhC/zAcO29oEXEkJN6EWsFc
         rjRnsac2+eV4w1bPnSCPjD5kEyuRJYTw4oqJ6ZCrvC+o2RGBaZEpU7Sky8IcR7qD7C6G
         6u+F7vjN3mIzPXn0zVvuOv1BfzwYgRKI0mefJBoouVl0bM1oTLcfzB5nW7Xt6JiuJqRi
         XxWqlaSufvNBL0zTek09cPojoU+4ESf29CDUofBwt18esBd0w8XeVKJrJPmde1V8rqmG
         so1Q==
X-Gm-Message-State: AOJu0YxXjvEnQRZt0W6kCY5uVS2ZC0vQLDKsbENXaKqgEJlHYXx6JTfc
	12J+mSiI179bVxTvfOBBI6UmiauSfCaTg94hwyNHSENKBttNKdXga9rct2O1rIgHezmevJGcKto
	W1b4y9ARl21HtgeC+B3pWu81KVMLtY79zekL4QWaLX/DtJyzjmJsGDV0=
X-Google-Smtp-Source: AGHT+IHE31Fa4p36oDJoBo4BhxfV+IhE27iN+f4uo73NKFiPw0hD2nqzTu5n89k6A7ezHyfsE2HdNbAorIc92gOxZicUXjDkxloZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:382:6a83:f4fc with SMTP id
 e9e14a558f8ab-39b183caca7mr1541825ab.5.1722512644164; Thu, 01 Aug 2024
 04:44:04 -0700 (PDT)
Date: Thu, 01 Aug 2024 04:44:04 -0700
In-Reply-To: <20240801092733.1243313-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046def5061e9dba03@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in pick_link

loop0: detected capacity change from 0 to 8
err: 0, folio: ffffea00057726d0, in: ffff888121ab45b8, do_read_cache_folio
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
 do_read_cache_folio+0x134/0x1300 mm/filemap.c:3753
 do_read_cache_page mm/filemap.c:3860 [inline]
 read_cache_page+0x63/0x1d0 mm/filemap.c:3869
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

CPU: 1 UID: 0 PID: 5981 Comm: syz.0.15 Not tainted 6.10.0-syzkaller-12708-g2f8c4f506285-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=169f9b03980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cdd19d980000


