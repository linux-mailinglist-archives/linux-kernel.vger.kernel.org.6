Return-Path: <linux-kernel+bounces-292202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2691A956C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5156F1C21E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1C16CD02;
	Mon, 19 Aug 2024 13:42:34 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7516C84A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074953; cv=none; b=P4F0OQ96bmonbD1l6/zBBY2RG3vTHL/BuBrAYVIji7hIuVpYwoHAuQ/nR7AgsGbbo88UZFQvkx/T3PMX/qhJ8JOLmLV8O2hQNZQ3/ZeGp4UQUlsgR1kehT4EDTOlKTEBlAgX7jUGMpEwBAZ2v5bI/vzad4//MLwfxtHj6kg4EjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074953; c=relaxed/simple;
	bh=n055YP4UpwSx4MsWTuk5objkjsFP6bUCrLVCQsPaisA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kC/CVV3AOdQpJFRTYRSKpwtXI9q8ZrqdeKI6LLzJoOVRnhtTpGAiNvX54Fnf8mHuB3g66/RC6XkIKVYWKReYZzLDwWdK0rzrExhJbm/bOAKpx6pgry6jBLIWvQ3mN2623W6ivlXekHUmUc2RKISfSMgj5GtULTfA0RgfxJ581aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f897b8b56so314176039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724074951; x=1724679751;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yb2ABfIEAQrnVUVakDimCyPOI0QvhxH1i+Tk0ohSf9w=;
        b=v3vmYlegeQZKJOIymbYXH0HJNqM8PJkNRQti26MvOMMS2k4LrtoFdhujjkfQ41/GzD
         h7yAZu7HQJ82RuR6flYdoOqf0nA/RcCzAzkN1bbFunXlhhL5m/dgah3+mkj+QeeWBhoY
         YX4SohwCBG8BAnmhSqeHIbvxuscJD0VF1xghmu0Ny5WwpF8k80R+NbtsjOskkBIShjkk
         w2cija0LL8+GAjGqwMcbm+OGYCFLIFZyTsyESAhlLXZNt2tCDQIFToW1+qs51sLbKdrZ
         HYRmYgdm+1bC6fkXdehC8gutzTJfw8HUAv5idYraHC8bMVB7E6ErjCHXRR8WiNBbrbq+
         Q64Q==
X-Forwarded-Encrypted: i=1; AJvYcCULGj0TH9e4q4SOjCeOL1KyJ/ZBjNnK6xOpZGAnfO9pVf6+N+XcawSdLtMzpBcgw+3TMyjkJ9RykLkfN+NVhVTFpRJI9IFZZJ6Xg2JJ
X-Gm-Message-State: AOJu0YwhBsh9Jr4GaJcCvQbro5daqKv3jUyMIRXXs6ZhTEG3P2q7O4Fa
	/CjqoX8mPbpUHj2IL6i9XpS/Nwbmva32cF3VoXN3Xtu3dV9wHhipwizVBPWgpeqxeoCA9CmjwPY
	r6aYwwnOFEBrBMLk48iuX2mHpaLDuC+sRend8ViXiNkykDMF2wunzSWk=
X-Google-Smtp-Source: AGHT+IE5rrDf70i/p1FbD9QFwTTP3OA7yraQQQy5xyKeucd1SSix0wNLxYR435ikpe3Pq6IV6eWLI3HP1US1yJpuHQhQ6ZySnb2J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8709:b0:4c2:31f5:3137 with SMTP id
 8926c6da1cb9f-4cce0d85575mr518009173.0.1724074951314; Mon, 19 Aug 2024
 06:42:31 -0700 (PDT)
Date: Mon, 19 Aug 2024 06:42:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a1b9a0620097bad@google.com>
Subject: [syzbot] [serial?] KMSAN: uninit-value in n_tty_receive_buf_closing (3)
From: syzbot <syzbot+dd514b5f0cf048aec256@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1fb918967b56 Merge tag 'for-6.11-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10383409980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=836be0e882e376f7
dashboard link: https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c4ce70611394/disk-1fb91896.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/014bed8fa88a/vmlinux-1fb91896.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8aa322233dc/bzImage-1fb91896.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd514b5f0cf048aec256@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in n_tty_receive_char_closing drivers/tty/n_tty.c:1454 [inline]
BUG: KMSAN: uninit-value in n_tty_receive_buf_closing+0x539/0xb40 drivers/tty/n_tty.c:1567
 n_tty_receive_char_closing drivers/tty/n_tty.c:1454 [inline]
 n_tty_receive_buf_closing+0x539/0xb40 drivers/tty/n_tty.c:1567
 __receive_buf drivers/tty/n_tty.c:1630 [inline]
 n_tty_receive_buf_common+0x196b/0x2490 drivers/tty/n_tty.c:1739
 n_tty_receive_buf2+0x4c/0x60 drivers/tty/n_tty.c:1785
 tty_ldisc_receive_buf+0xd0/0x290 drivers/tty/tty_buffer.c:387
 tty_port_default_receive_buf+0xdf/0x190 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x473/0xdb0 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:180 [inline]
 __tty_buffer_request_room+0x36e/0x6d0 drivers/tty/tty_buffer.c:273
 __tty_insert_flip_string_flags+0x140/0x570 drivers/tty/tty_buffer.c:309
 tty_insert_flip_char include/linux/tty_flip.h:77 [inline]
 uart_insert_char+0x39e/0xa10 drivers/tty/serial/serial_core.c:3568
 serial8250_read_char+0x1a7/0x5d0 drivers/tty/serial/8250/8250_port.c:1743
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1760 [inline]
 serial8250_handle_irq+0x77a/0xb80 drivers/tty/serial/8250/8250_port.c:1924
 serial8250_default_handle_irq+0x120/0x2b0 drivers/tty/serial/8250/8250_port.c:1949
 serial8250_interrupt+0xc5/0x360 drivers/tty/serial/8250/8250_core.c:86
 __handle_irq_event_percpu+0x118/0xca0 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xef/0x2c0 kernel/irq/handle.c:210
 handle_edge_irq+0x340/0xfb0 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0x97/0x1f0 arch/x86/kernel/irq.c:285
 common_interrupt+0x8f/0xa0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693

CPU: 1 UID: 0 PID: 3148 Comm: kworker/u8:16 Not tainted 6.11.0-rc3-syzkaller-00066-g1fb918967b56 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events_unbound flush_to_ldisc
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

