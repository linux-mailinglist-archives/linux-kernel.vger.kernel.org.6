Return-Path: <linux-kernel+bounces-320109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BD9970646
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98772282A35
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7D554670;
	Sun,  8 Sep 2024 09:45:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A2158207
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788704; cv=none; b=o1EbiF/+6i8W+upKQP+ksJ9mZmJ9RJ/24WkwCqlCTlpAdviQd3ltpeWzBj+FUA7HtjuwGXBrgSPZmS7k7DbW6GhUqPO+bjmY0UGsakVuXSBG3FQ7H5dggK//CFtLIf0pyYJkFh5N3s2J8LSl+SqHJNtixg4nro3D5Rw0fhQRJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788704; c=relaxed/simple;
	bh=61reWQDKxpfmsR/u0PqzlttIfFWd4ZKg9Dfwj5Zw0YA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EBMyz7GXH3J405kstNAQZZhHCFFRCqRDRtTm6IZ23qMj7TD+OQZ0D5yXCyz0/0PgdB997F96ZC+buEezCoxyHaU28jm3QV4RtzfGeUgpOxah9VUlX86RSq2jY9w+uF8PD4ctXsmPZPX6ZxGAFzy8NkixYSL9sxqp+7lXEOCDRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a217cec1fso733204439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 02:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725788702; x=1726393502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhfFEVpCGjjY3Z3tffN1F5mWLMdyW9WlNRoyo1aP5t8=;
        b=B1gzmpxRURwyOGdRdsA5Yjn1HaxRKTX3SDRNtqkMSwkFdmufSXgsUFOboRVYXauhF9
         fzhcxQjr2v9bGv8bC2wPDINeJePrbvM7vLz87wiiX8uZQd0XyOUjn0m1pPrYn28+Sdto
         Xixz0tMsPO8aNoU3HbIsj/wKjxGIv9lu3u1AJYl66ltvkRgXcJl9FZOtc6baDIsRkMiw
         8+sS2njOaUl2eDuMvLzwzUPWOrxP5XcwhEf5o+/TWm90YGc+WEIJT04/e0GvUexloxXj
         VoTVMBFq36YujIkYFoZpMUH8EHX5NQxSsKnI28JupNC1RCBxuEuYznrRnhyrpF0eMdcw
         uymQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5iJfoYrr20Yx89sPJz9Bli8tAfeLjMub5G0SKkgG25A/fZ3yt8RQwCwXJ2sEA/XSWZeharfJ5xd5gqLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HXnVfqo+YyYNQsQSOQRP6vFAwd6qCA3hl3Sbw7CmJ6M1IYYO
	a8yvKHnm/nMf89v7tnzo//yx5dF5gXGUSycP8sAnGaXzWc+KZp3OaQs2jxUYjyubvP1KBmIxFEP
	+rFJTh8adk8cayjFT4OTz7jGGg7hus94tbBiUx21W6iAeZTfMdTX6q6Q=
X-Google-Smtp-Source: AGHT+IG04E0I2OSYz3vs2Z508RfSo4r5XguHthBnWZHOMpbT6dAN9qe8dt8OnsTNjTy/NrAacGRz3+jTWXNJUy/Rewrw18vju0ni
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:341b:b0:825:1f11:5996 with SMTP id
 ca18e2360f4ac-82a9622213dmr777444039f.13.1725788702607; Sun, 08 Sep 2024
 02:45:02 -0700 (PDT)
Date: Sun, 08 Sep 2024 02:45:02 -0700
In-Reply-To: <20240908083424.13212-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009399860621987ead@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KCSAN: data-race in generic_fillattr / inode_set_ctime_current

==================================================================
BUG: KCSAN: data-race in generic_fillattr / inode_set_ctime_current

write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
 inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
 inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
 shmem_mknod+0x117/0x180 mm/shmem.c:3443
 shmem_create+0x34/0x40 mm/shmem.c:3497
 lookup_open fs/namei.c:3578 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0xdbc/0x1f00 fs/namei.c:3883
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

read to 0xffff888102eb3260 of 4 bytes by task 3498 on cpu 0:
 inode_get_ctime_nsec include/linux/fs.h:1623 [inline]
 inode_get_ctime include/linux/fs.h:1629 [inline]
 generic_fillattr+0x1dd/0x2f0 fs/stat.c:62
 shmem_getattr+0x17b/0x200 mm/shmem.c:1157
 vfs_getattr_nosec fs/stat.c:166 [inline]
 vfs_getattr+0x19b/0x1e0 fs/stat.c:207
 vfs_statx_path fs/stat.c:251 [inline]
 vfs_statx+0x134/0x2f0 fs/stat.c:315
 vfs_fstatat+0xec/0x110 fs/stat.c:341
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat+0x58/0x260 fs/stat.c:499
 __x64_sys_newfstatat+0x55/0x70 fs/stat.c:499
 x64_sys_call+0x141f/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:263
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x2755ae53 -> 0x27ee44d3

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3498 Comm: udevd Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165f8877980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81d40b0108ea8fe
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1363abc7980000


