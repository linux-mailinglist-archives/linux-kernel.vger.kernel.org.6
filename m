Return-Path: <linux-kernel+bounces-320146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FBD9706AC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF7C2821EA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025191509BF;
	Sun,  8 Sep 2024 10:44:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31B148828
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725792244; cv=none; b=IDJdT9E4ZIIeFKt2YPspZlRn+60178AE6Vzg7x5cIEoo7CFvmZ/Uo3QI13ie+sU43untJRqTvKp6bWMtSLgTbkPny9ry/XbN1Gb3t2uqG8USjZAaWy/Rmsa1H8+qqzaxnepCZhE5tOSOvumq4TP1tgmGNmT5WR1s08mbirdI/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725792244; c=relaxed/simple;
	bh=vJ5A+bZx4EHd4oy8YkgNGSS7Y+DI8Iwe7U0/S4IpFJY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ihs703cq7HIvZXjegZPVf5tZYik/olAaf2uvoqtxSAqipviq75tFo8mLhW5ZNqueHkhkk7vN6RNRWDtFFNkEQ+XVbzvTc0Gsc7m5GecI0FWyEMqgsriS8dGwGBhZOgecYTsW8SFEzY6vWMk+wpfB8an4nRZn/qCm9lpiE80zM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82b930cd6b2so156562839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 03:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725792242; x=1726397042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZDUnJNz1Sni9j4jon0Z02e8bEXNh5mS4eFCffhJmU4=;
        b=nYjNEQzNWHhdGckgAxd7EOrRMKK7x7RRaRPqfzf5+m+rMGxYY4dKdOx6mbhJ7/3ZSk
         Rv0f2h7N6GBbxy3WjQYbDY5XK1/dFlddLD696kKTozQY3dUH+wM5SWMQp/CS76XjW2Bq
         nYxdHQLsjICDcu7ny/zmtyqyABpojcmCY/xGE07AcGwA5kPGpNuQe9PKbHYl09uOSdiu
         KcTvk+xkU+Ire3GU5C2N6j3w2R8aj66cv6d45c5QWjMK08OsGRWEgGjZoi0EXcr4IK2W
         ZT5UrcSATkaBX/+jSEq69gY1zFNyyDluOq5BHOeaXxZ+FvDbfLYK0g9k+XlbeuBM8hSg
         Wurw==
X-Forwarded-Encrypted: i=1; AJvYcCUbPOgacU26IsBjz7dmNMbEmy0SNpyOuoj+5sBt6sZjJjLLVDNlIMzopWIXa3XoeqQpQbZAd6zTvFVXLWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEx5GCwRNT1hjjPwKBm9o8+dRTEOuXuTmr4SZBeeeA5fhN0NMF
	GcK2K49/8exq4u7iojn+Ih0wSC8ggBRg1+TOxqhaQeTlPZsvH5KT/50tFquAX9U0cIGUBCsaS34
	a1QqmAkUsVnp/MtYpRxcSZJVmPFT2M/iluI8VMWpVxZ0HqISr2J8oAxA=
X-Google-Smtp-Source: AGHT+IGZq25FllB+kkH7lCtAHGEX/kfOIVTe8S9KsU0bn1pIY3wwxvPEm5jP4qBc+u6DGH/XvMrCJ2EoRaNhpSL/vs7IvFcYI+xa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2c:b0:398:36c0:7968 with SMTP id
 e9e14a558f8ab-3a04f0758camr96064475ab.6.1725792241791; Sun, 08 Sep 2024
 03:44:01 -0700 (PDT)
Date: Sun, 08 Sep 2024 03:44:01 -0700
In-Reply-To: <20240908102751.14188-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000874d270621995192@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KCSAN: data-race in __fsnotify_parent / fsnotify_put_mark

==================================================================
BUG: KCSAN: data-race in __fsnotify_parent / fsnotify_put_mark

write to 0xffff888101229cf0 of 4 bytes by task 3493 on cpu 0:
 fsnotify_detach_connector_from_object fs/notify/mark.c:330 [inline]
 fsnotify_put_mark+0x2db/0x5d0 fs/notify/mark.c:393
 __do_sys_inotify_rm_watch fs/notify/inotify/inotify_user.c:819 [inline]
 __se_sys_inotify_rm_watch+0x105/0x180 fs/notify/inotify/inotify_user.c:793
 __x64_sys_inotify_rm_watch+0x31/0x40 fs/notify/inotify/inotify_user.c:793
 x64_sys_call+0x1ae0/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:256
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff888101229cf0 of 4 bytes by task 3339 on cpu 1:
 fsnotify_object_watched fs/notify/fsnotify.c:198 [inline]
 __fsnotify_parent+0xd4/0x380 fs/notify/fsnotify.c:228
 fsnotify_parent include/linux/fsnotify.h:96 [inline]
 fsnotify_file include/linux/fsnotify.h:131 [inline]
 fsnotify_open include/linux/fsnotify.h:401 [inline]
 vfs_open+0x1be/0x1f0 fs/open.c:1096
 do_open fs/namei.c:3727 [inline]
 path_openat+0x1a1e/0x1f00 fs/namei.c:3886
 do_filp_open+0xf7/0x200 fs/namei.c:3913
 do_sys_openat2+0xab/0x120 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0xf3/0x120 fs/open.c:1442
 x64_sys_call+0x1025/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x00002008 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 3339 Comm: syz-executor.2 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169a589f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81d40b0108ea8fe
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142a589f980000


