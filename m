Return-Path: <linux-kernel+bounces-271164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6614F944A40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985491C20E19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07255189BAE;
	Thu,  1 Aug 2024 11:21:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B8189BA0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511265; cv=none; b=YOllZn7KVFCGWNOtVIFu5UJ/xBUj0gEyM/W5PgYn6lLGJgczUi1EDRe/tLNLk/L8YUtoQbJTyVoKvjOAOdIL8UNiiqMhFAKU6sRvnq9VkB0AiPfvf/V3UGFnNMxql965eWGQnYMhOn7vhi/ea360RtuQv9dHWSxYA3++4Pu5BoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511265; c=relaxed/simple;
	bh=t/qTzkznLocZGKmH0f6UN2PI4opU3S7RVyDVos+suoI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ilgBMgwxl5JpgR1lzFeo5+UCdG7cBJ3KCQUXPii83zw/wh95obDAniLexe5pa9wlka+mXQZWCheDKq9EZWLPWNe0Kn5daPuH8o0bbgG7GgMpLweNXRqdlDdMhkK5jM46p9jpIrCYIMkxctXnkcIPuV8enAPd4vrQlIDLdv0gzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3962d4671c7so103191485ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722511263; x=1723116063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGR2bRjeAehL7VeNquYItORYpN2Wu5qxJiqzMHLgDco=;
        b=Nv46euRyTO/8rUjiYQ9fPUJyLqx//tgTpu3AQMBXRQST6LxNjpjsoNWOMvCd7bGkyV
         NFOjN+66i4Qgg5vtEFjhAE0H1c2U9tAWzCJ9wtzQlFOuZM3lJwG4njsn+2GyQrhkuMmW
         XSVN2vW8MJwK4vhH0WXL/F9tB7TMtaCJ5ULrSh9MUEoIBkSX5DVCjt0oZP1ZHW3M3p/E
         TSLwqPWmmZE8VRPmBpWAb9bKQ/9O7q7Mz/2xXqLheYsk00+q4JtO1OSYmOKIi3gSxU5v
         RtOOds5lFbmFvYxB9SzwbeKMCN+C8hYcralbDzS1xFgxwH9lWDJms7d1wKEQMaPyMo8r
         a7lQ==
X-Gm-Message-State: AOJu0YwsNza3sWRs9pyRjgl5CBANVoRJVcYplGEsjvBddz8eWP1HCWdI
	cfJ3EZemX1Sxb5aSXI9h2SEOauC2ooOIdrNtB61g2wesqYV4O3x9a5zhq+6Io4sDLuLOJHvmlQk
	prWCh0rGpGiu2uUVxwAvgpCzK1BOTxErVn+QLNLWB7LvJTK3YPDRw/R0=
X-Google-Smtp-Source: AGHT+IHWFIM7rrUn2tYVcK/tsWFs6SNcjVAskj2wDG0phwkizSGQ8xq7TH0INHcN08WDy+1g+hg3RalZvC79hIJt2Nag561vClOq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:396:1fc1:7034 with SMTP id
 e9e14a558f8ab-39b182d06bcmr2103875ab.0.1722511263264; Thu, 01 Aug 2024
 04:21:03 -0700 (PDT)
Date: Thu, 01 Aug 2024 04:21:03 -0700
In-Reply-To: <20240801090658.1894596-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f80371061e9d679a@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in pick_link

loop0: detected capacity change from 0 to 8
err: 0, folio: ffffea0000780a50, in: ffff88801768c878, do_read_cache_folio
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
 do_read_cache_folio+0x131/0x1260 mm/filemap.c:3753
 do_read_cache_page mm/filemap.c:3859 [inline]
 read_cache_page+0x63/0x1d0 mm/filemap.c:3868
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

CPU: 1 UID: 0 PID: 5934 Comm: syz.0.15 Not tainted 6.10.0-syzkaller-12708-g2f8c4f506285-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17d732bd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107ea623980000


