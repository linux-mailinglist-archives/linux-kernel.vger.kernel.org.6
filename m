Return-Path: <linux-kernel+bounces-251753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAEC93095C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 10:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529DB1C20A97
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7541F5FF;
	Sun, 14 Jul 2024 08:47:22 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A288F5C
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720946841; cv=none; b=kdFPMsFcRTe0tAb4e5cd5PLZqsErmYnClRY9RxEI7AF62Cv+83YqTWSNCFn3bqf7rjrmVq6zuvQm//4G4yRwoYGEOizMqwAAUdBTq1J6R8muThU23nCjVxwbqbuBeAwVfV84B6rYUMdk6s9OdHy8BrukGN1LjUPSyAr7FXznZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720946841; c=relaxed/simple;
	bh=iZ8itSxzZ8LNzIvS1ZPDsTzVZOc3UpfdCWcZDb+SkdE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BQNDS9H4oyoFnUYrb3Xs90Pl9D6WnmZ4453a8UV7htgPq6XC3Q9b5grJI++iA7Z7j7ERh1+yxY/w+Lncv29JU8N309bZYHQV8JCLAId1UTjOFhFhCMlcqfzYRFrNduwpyDXd+z5+I1xITEisXit9OOJoBSzePMRgEAT5nCTcyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f682fb3b16so374037839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 01:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720946839; x=1721551639;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMTnYIDsOUbdl7uAX2U3dCzk6gPmvHIUuMwUiHoF0ko=;
        b=cRUlEIK3wrMp/IBZJxlHxa8vHuk/ncWeQbdgUdJPnCkftUqqiIpmNC5CHHR5vkTeWy
         tUJ5k6y/qQcNUo2xQKxMZpIJGI+u5gs3uyeADQPeCTfqj7WHIFsPzZbOKsmDDlGZSvwA
         XsytecBAaqdVetITTo5xfnHbxlQhmsu1MFCG1jP85IktBYlErU/mqnJcFoQBSw7+m7Es
         VV2cJWspTaTU5daaatZaYWhihiWDmIsKWDOSrvXm/N8RYtBbxnVBWjh+wPXppYJS0bL8
         CkLD1Wdy9OaCgjEL9ZWb6w2ro7OditLQgD5VKTaPfE+cDIzeH6SXCBp0ifjzdQSNhV8g
         98rw==
X-Forwarded-Encrypted: i=1; AJvYcCWmU/c1wKJhnYrWINs0wBoOAhnZVCrxNB/cRdRZihChQAKqslmKRY5Hjcwi8n8beqGqVJC2ziFcln3hojWuT2E6pdi0EY3ucAxThQtZ
X-Gm-Message-State: AOJu0Yy6whn2cqRVRpLWTR2CP4yRpSzHjPRxO5h9+qWhzaoLO2AHgsEw
	ax8sEY3R7Haw4WjhIiD0mNxH1YjpRCsYJY4aKleMn+qKUP5KWBiHBoDk6GXJ6SSpsrCD/lBAnIr
	QPo9ZPtCF9hckClTLCKz3DG+0FFQwh65uBgyd7IWfE/zO5+ah/bKbF9E=
X-Google-Smtp-Source: AGHT+IEycSoUQJsasckuF9+gK0XeHudJpLv45dqk8vAaeMuv5QQ8hU6fvK5txjwVdt72zyi/XhDfxHvrewVctmXx8gUi0NgSAmM0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a0:b0:4c0:7f0f:b42e with SMTP id
 8926c6da1cb9f-4c0b2869cd4mr1203360173.1.1720946839340; Sun, 14 Jul 2024
 01:47:19 -0700 (PDT)
Date: Sun, 14 Jul 2024 01:47:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009577a061d31290e@google.com>
Subject: [syzbot] [usb?] WARNING in kcov_remote_start (5)
From: syzbot <syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d0d0cd380055 Merge tag '6.10-rc7-smb3-client-fix' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d79221980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=2388cdaeb6b10f0c13ac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/13bfa3c3abc3/disk-d0d0cd38.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/43a37a3557bb/vmlinux-d0d0cd38.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6e4daed3b84/bzImage-d0d0cd38.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7419 at kernel/kcov.c:871 kcov_remote_start+0x5a2/0x7e0 kernel/kcov.c:871
Modules linked in:
CPU: 1 PID: 7419 Comm: syz.0.607 Not tainted 6.10.0-rc7-syzkaller-00256-gd0d0cd380055 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:kcov_remote_start+0x5a2/0x7e0 kernel/kcov.c:871
Code: 24 00 00 00 00 9c 8f 04 24 f7 04 24 00 02 00 00 0f 85 a6 01 00 00 41 f7 c6 00 02 00 00 0f 84 93 fa ff ff fb e9 8d fa ff ff 90 <0f> 0b 90 e8 06 8e e7 09 89 c0 48 c7 c7 c8 d4 02 00 48 03 3c c5 e0
RSP: 0018:ffffc90000a170d0 EFLAGS: 00010002
RAX: 0000000000010303 RBX: ffff888029a45a00 RCX: 0000000000000002
RDX: dffffc0000000000 RSI: ffffffff8bcaccc0 RDI: ffffffff8c1f5540
RBP: 0100000000000005 R08: ffffffff92f765f7 R09: 1ffffffff25eecbe
R10: dffffc0000000000 R11: fffffbfff25eecbf R12: ffffffff819630de
R13: ffff88807cde8900 R14: 0000000000000006 R15: ffff8880b952d4c8
FS:  00007f5c47b256c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3a730c5e0 CR3: 0000000022982000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 kcov_remote_start_usb include/linux/kcov.h:55 [inline]
 kcov_remote_start_usb_softirq include/linux/kcov.h:89 [inline]
 __usb_hcd_giveback_urb+0x405/0x6e0 drivers/usb/core/hcd.c:1649
 dummy_timer+0x830/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:preempt_count_sub+0x0/0x170 kernel/sched/core.c:5892
Code: 8c 77 ff ff ff 48 c7 c7 60 9b ac 8f e8 59 08 93 00 e9 66 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 41 56 53 89 fb 48 c7 c0 e0 e6 76 94 48 c1 e8 03 49 be
RSP: 0018:ffffc90000a17868 EFLAGS: 00000246
RAX: ffffffff8180144d RBX: 00007f5c46d75bd9 RCX: 0000000000040000
RDX: ffffc90002311000 RSI: 00000000000008ef RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffff81800e58 R09: ffffffff8141095f
R10: 0000000000000003 R11: ffff888029a45a00 R12: 0000000000000000
R13: ffffffff8181dd10 R14: 00007f5c46d75bd9 R15: 1ffff92000142f29
 is_module_text_address+0x10f/0x190 kernel/module/main.c:3335
 kernel_text_address+0x96/0xe0 kernel/extable.c:119
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x5d/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4123 [inline]
 __kmalloc_noprof+0x1f9/0x400 mm/slub.c:4136
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ieee802_11_parse_elems_full+0xd5/0x2870 net/mac80211/parse.c:880
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2332 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2339 [inline]
 ieee80211_inform_bss+0x15f/0x1080 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x1121/0x2360 net/wireless/scan.c:2293
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3117
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3207
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5222 [inline]
 ieee80211_rx_list+0x2b00/0x3780 net/mac80211/rx.c:5459
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5482
 ieee80211_rx include/net/mac80211.h:5093 [inline]
 ieee80211_handle_queued_frames+0xe7/0x1e0 net/mac80211/main.c:438
 tasklet_action_common+0x321/0x4d0 kernel/softirq.c:785
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 ieee80211_tx_skb_tid+0x264/0x420 net/mac80211/tx.c:6131
 ieee80211_mgmt_tx+0x1b46/0x2170 net/mac80211/offchannel.c:989
 rdev_mgmt_tx net/wireless/rdev-ops.h:762 [inline]
 cfg80211_mlme_mgmt_tx+0x950/0x16a0 net/wireless/mlme.c:937
 nl80211_tx_mgmt+0xb0d/0x1190 net/wireless/nl80211.c:12655
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c46d75bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5c47b25048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5c46f03f60 RCX: 00007f5c46d75bd9
RDX: 0000000000000000 RSI: 0000000020000440 RDI: 000000000000000b
RBP: 00007f5c46de4e60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5c46f03f60 R15: 00007fff16883af8
 </TASK>
----------------
Code disassembly (best guess), 5 bytes skipped:
   0:	48 c7 c7 60 9b ac 8f 	mov    $0xffffffff8fac9b60,%rdi
   7:	e8 59 08 93 00       	call   0x930865
   c:	e9 66 ff ff ff       	jmp    0xffffff77
  11:	0f 1f 40 00          	nopl   0x0(%rax)
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
* 25:	f3 0f 1e fa          	endbr64 <-- trapping instruction
  29:	41 56                	push   %r14
  2b:	53                   	push   %rbx
  2c:	89 fb                	mov    %edi,%ebx
  2e:	48 c7 c0 e0 e6 76 94 	mov    $0xffffffff9476e6e0,%rax
  35:	48 c1 e8 03          	shr    $0x3,%rax
  39:	49                   	rex.WB
  3a:	be                   	.byte 0xbe


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

