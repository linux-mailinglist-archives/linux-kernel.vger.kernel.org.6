Return-Path: <linux-kernel+bounces-361069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D199A302
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90E6B2322D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD5216A11;
	Fri, 11 Oct 2024 11:51:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E620A5E3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647485; cv=none; b=EMNWx6fX91P+oatbQMUkLVW6D401G4YLbAywd8x8be+RBdzsa+KQ82dtD+F3qbfA+Pfc4l2IVdXZV/d1xFy99a7pT7bI2/ZTQJBHH+R8TfUEZ3Od7zKXQLlFZwsTy/7mPOR2pJE9SMtLG7hFAQQecZayZT8d9I97bEdc3y7pmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647485; c=relaxed/simple;
	bh=9O7BztCHO3KtV0SdChqcEH5ondx/3hwV164O7Oa05NA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tDxhJncjuysb4nKhH3gSTj67JHNocT3N7qPjp+MdVujT2rOQos2TMuwMiy5Z3d04LmnaSYJzpTCV5iUlpfQ0w7VpCSRl9K7IP4AYWVGrB4vCSx1OcTWsPEzr71Bk6TmlhJPLlYkl1Jfw9rUCLT1R3/xuyuxsTFISDoeX3FQuaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a392e9a8a4so23015965ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728647484; x=1729252284;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEDDXhRBsKWXoiInxqiJ4ScpciEaFalrxT16qh3qfqo=;
        b=DfiUbtF87DVL0qL2eUpcnh1FngeKrWJkeV6EB+A/MTd5CVO4hKK3Zqa+jwKJ6CG/lo
         sXm6cHI3Cup8D+KKe389rNUqdI0hqLpsuKCBY9frAw4LMZxZgyLrEEZ0wNyGALy906O3
         dwu+GurHXXYrqP0wVZNm6XxHwG0HESi0OZJgRk+Dm1F/WQIk6fXgdKi+JK3L75r+fNxl
         MG3o9Fj5lwB5JQN9alAT4WcSQBn/oAx4S3XzE23ebnT6Vbb1GlMSO1pB7Lcv69iUH+wG
         ZE3Ccnbwm+4rY5ynX687g3ntLL4663eYZ+D0/cFP60/otIF7EeU2W7Hg3kgU5j7RTIWA
         XXVw==
X-Forwarded-Encrypted: i=1; AJvYcCUMHW30hl9N/QGYkj6U49tTWbhA4vW1MLYdWXNyaKGJtKT2JpcsAMB89gVNfBWpAViCfwT8DRIPEVLzanM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq2yAGYAo9twucT4FzjEPr8Yuleejk45TFIF5G5QpgQk2H8zc8
	EBPLO0U+PoYmJ14dwm7YT+InUGAv+rFO9j455Im90agZ5DItSqM4j7UbYJDiwN29qlQcJ8MTT+S
	DNNpUUoBSJTS7gSFoA8vzZ/+QUDm6tE4mwyYCTQN5X28TZbzBt++M9sY=
X-Google-Smtp-Source: AGHT+IE1Dp7Kc13iub8S0zyHAHgCX/IWIH+GiwadtRoRAvR+gfvYitKqBvz+V+HKCxTswK8eKcjpCbJATswT8QsabgdhtCnXwg3S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c9:b0:3a0:bd91:3842 with SMTP id
 e9e14a558f8ab-3a3b5fe9b56mr15811205ab.24.1728647483675; Fri, 11 Oct 2024
 04:51:23 -0700 (PDT)
Date: Fri, 11 Oct 2024 04:51:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6709113b.050a0220.4cbc0.0003.GAE@google.com>
Subject: [syzbot] [usb?] WARNING: ODEBUG bug in corrupted (3)
From: syzbot <syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a9fe2a8ac53 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10b02707980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=90f31ac02b7ae5e8b578
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1597a7d0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/883c5319cb52/disk-4a9fe2a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4421ed2ef/vmlinux-4a9fe2a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8e3beb01d49/bzImage-4a9fe2a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88811dc037c8 object type: timer_list hint: rtl_ips_nic_off_wq_callback+0x0/0x680 drivers/net/wireless/realtek/rtlwifi/ps.c:283
WARNING: CPU: 1 PID: 5503 at lib/debugobjects.c:514 debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

