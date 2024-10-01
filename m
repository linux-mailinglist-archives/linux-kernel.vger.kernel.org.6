Return-Path: <linux-kernel+bounces-345948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03A798BD47
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA20283AEA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0DC121;
	Tue,  1 Oct 2024 13:17:37 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3C1C32E1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788657; cv=none; b=LGxGj+ZWeXQuoO4azSLuGuTdPY0iTVqo4VlFbY3TOXKGpquifVXByxVj0q3LJ+Kz5f1YX28eafcjANTUio9LGgYRQBqns4RIwWcZeATx78TcLdBzDXQ8cAc07k4d+Qd1I7qxkh0/v1PAbXzC77PcRfuRlG8jjWEmGY0Sv5N2ySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788657; c=relaxed/simple;
	bh=FnFUu9XC9QNnJqoNKrEVUaPHNyoYjxai+b3EEZLfDy8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Lv/5K0/VfwcZW98bVyj2USVeQGWEjh/CdfR6jUaIXZqcpiF7DlrWB3T5sQVi2cTzTiCQao/2YvVsW0fF8uyyHLaQwQfVnkVs+BS29objYDqVzl5b6woX0ihQO/iKWyo0wlfMycwDAgUoh3b38WuQOalJbRvw15wyhRd4mbGPQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a19665ed40so45192345ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788654; x=1728393454;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q13La4msEZcPMtJwBs3HNtiznclbBGxW7loTOyVunzg=;
        b=IFlnsPrORRnWLw2P5AeRcq2AOZf0M4/I92i4wTKxS1c9GoqC+pt8hWKr///cIFAXWR
         R+5Zbkktt+hrv5KY4JndG71JclvzY6EpRpwwkNto/8K/h5nGF2qMXQrioqobBzrlCQmI
         r78zUIL2tja0Ed2w9LwXbY3a3azmdZrAk4qlvI4Msmdujtu1KsirEGbfEqNJ/K8w7v0+
         8jCZtgTzJk7bKfj3eTGOdE6TCtiQRQdRPgMaEEdGRo3Nz1P7O1ahMtpyXJGPOkHVWS45
         SgqTn/erQTqMf2BxxxGcA5HQIN2LjvHry9/iIdLmM/8FU+wBt+sKyjsuvXI4e+DDfPj0
         9zfA==
X-Forwarded-Encrypted: i=1; AJvYcCUF07mBKd7zl/ebwymwFWuBSdNfn2RNjikqxbLBLO4kXvxqXs3FN9eDmwgJ0VPLbKWUuqQ4CYuVbflHH9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdvHBeHNyFz4gBWhU1cn/wRqq+pnJxAue8QtIe+s+gYNP5vVcz
	k0oocUuOzqmG3FxnveGAvaGMN0Guw1QBhrPPP9mrtsjlfwAyyUIC8HS77lO91hnxEleZsaQJ4R4
	n9HIFv1bgc5Qrr+WzqKmQF/rIr0uJBNDQOeuQkfrvjwdG6cXaW/d7fyA=
X-Google-Smtp-Source: AGHT+IEoQJQWTp+5a7H1HtdbYTziT2BHaW1eIeh0YoxGxorrTwRDYgBhdjZ3wFuhhMLYXxA/qjXA/tGhJt3iKIRmDonFLa2eHvEd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4d:0:b0:3a0:b0dc:1910 with SMTP id
 e9e14a558f8ab-3a35eb3a2a5mr21600175ab.13.1727788654322; Tue, 01 Oct 2024
 06:17:34 -0700 (PDT)
Date: Tue, 01 Oct 2024 06:17:34 -0700
In-Reply-To: <CAHiZj8jFpERHN8xUkMibnpjjAbROC8KN=TBfD4veJCPdWTk8jg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fbf66e.050a0220.f28ec.04a2.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_sock_ready_cb (2)
From: syzbot <syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com>
To: surajsonawane0215@gmail.com
Cc: surajsonawane0215@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This fix ensures that the parent socket is valid and not marked as dead
> before invoking sk_data_ready, preventing potential slab-use-after-free
> issues. It adds a check for SOCK_DEAD to avoid accessing freed or invalid
> memory.
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
> ---
>  net/bluetooth/l2cap_sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index ba437c6f6..fa9d6dd7e 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1666,7 +1666,7 @@ static void l2cap_sock_ready_cb(struct l2cap_chan
> *chan)
>   sk->sk_state =3D BT_CONNECTED;
>   sk->sk_state_change(sk);
>
> - if (parent)
> + if (parent && sock_flag(parent, SOCK_DEAD) =3D=3D 0)
>   parent->sk_data_ready(parent);
>
>   release_sock(sk);
> --=20
> 2.34.1
>
> On Tue, Oct 1, 2024 at 3:45=E2=80=AFPM syzbot <
> syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com> wrote:
>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kerne=
lci
>> git tree:       git://
>> git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D128819805800=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddedbcb1ff438=
7972
>> dashboard link:
>> https://syzkaller.appspot.com/bug?extid=3D9265e754091c2d27ea29
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
>> Debian) 2.40
>> userspace arch: arm64
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image:
>> https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.=
raw.xz
>> vmlinux:
>> https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f5673=
60.xz
>> kernel image:
>> https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360=
.gz.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the
>> commit:
>> Reported-by: syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com
>>
>> kobject: kobject_add_internal failed for hci0:201 with -EEXIST, don't tr=
y
>> to register things with the same name in the same directory.
>> Bluetooth: hci0: failed to register connection device
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> BUG: KASAN: slab-use-after-free in l2cap_sock_ready_cb+0xc4/0x130
>> net/bluetooth/l2cap_sock.c:1670
>> Read of size 8 at addr ffff0000da74b188 by task kworker/u9:6/6425
>>
>> CPU: 0 UID: 0 PID: 6425 Comm: kworker/u9:6 Not tainted
>> 6.11.0-rc7-syzkaller-g5f5673607153 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 08/06/2024
>> Workqueue: hci0 hci_rx_work
>> Call trace:
>>  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
>>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
>>  __dump_stack lib/dump_stack.c:93 [inline]
>>  dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
>>  print_address_description mm/kasan/report.c:377 [inline]
>>  print_report+0x198/0x538 mm/kasan/report.c:488
>>  kasan_report+0xd8/0x138 mm/kasan/report.c:601
>>  __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
>>  l2cap_sock_ready_cb+0xc4/0x130 net/bluetooth/l2cap_sock.c:1670
>>  l2cap_chan_ready net/bluetooth/l2cap_core.c:1256 [inline]
>>  l2cap_le_start+0xa6c/0x1384 net/bluetooth/l2cap_core.c:1368
>>  l2cap_conn_ready net/bluetooth/l2cap_core.c:1624 [inline]
>>  l2cap_connect_cfm+0x57c/0xe24 net/bluetooth/l2cap_core.c:7286
>>  hci_connect_cfm+0xa0/0x13c include/net/bluetooth/hci_core.h:1960
>>  le_conn_complete_evt+0xa1c/0xf0c net/bluetooth/hci_event.c:5761
>>  hci_le_conn_complete_evt+0x114/0x404 net/bluetooth/hci_event.c:5787
>>  hci_le_meta_evt+0x2a4/0x478 net/bluetooth/hci_event.c:7135
>>  hci_event_func net/bluetooth/hci_event.c:7443 [inline]
>>  hci_event_packet+0x890/0x106c net/bluetooth/hci_event.c:7498
>>  hci_rx_work+0x318/0xa80 net/bluetooth/hci_core.c:4023
>>  process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
>>  process_scheduled_works kernel/workqueue.c:3312 [inline]
>>  worker_thread+0x978/0xec4 kernel/workqueue.c:3389
>>  kthread+0x288/0x310 kernel/kthread.c:389
>>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
>>
>> Allocated by task 6795:
>>  kasan_save_stack mm/kasan/common.c:47 [inline]
>>  kasan_save_track+0x40/0x78 mm/kasan/common.c:68
>>  kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:565
>>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>>  __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:387
>>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>>  __do_kmalloc_node mm/slub.c:4162 [inline]
>>  __kmalloc_noprof+0x2a4/0x498 mm/slub.c:4174
>>  kmalloc_noprof include/linux/slab.h:685 [inline]
>>  sk_prot_alloc+0xc4/0x1f0 net/core/sock.c:2096
>>  sk_alloc+0x44/0x3f0 net/core/sock.c:2149
>>  bt_sock_alloc+0x4c/0x304 net/bluetooth/af_bluetooth.c:148
>>  l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1877 [inline]
>>  l2cap_sock_create+0x140/0x2b8 net/bluetooth/l2cap_sock.c:1917
>>  bt_sock_create+0x14c/0x248 net/bluetooth/af_bluetooth.c:132
>>  __sock_create+0x43c/0x884 net/socket.c:1571
>>  sock_create net/socket.c:1622 [inline]
>>  __sys_socket_create net/socket.c:1659 [inline]
>>  __sys_socket+0x134/0x340 net/socket.c:1706
>>  __do_sys_socket net/socket.c:1720 [inline]
>>  __se_sys_socket net/socket.c:1718 [inline]
>>  __arm64_sys_socket+0x7c/0x94 net/socket.c:1718
>>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>>
>> Freed by task 6794:
>>  kasan_save_stack mm/kasan/common.c:47 [inline]
>>  kasan_save_track+0x40/0x78 mm/kasan/common.c:68
>>  kasan_save_free_info+0x54/0x6c mm/kasan/generic.c:579
>>  poison_slab_object+0x128/0x180 mm/kasan/common.c:240
>>  __kasan_slab_free+0x3c/0x70 mm/kasan/common.c:256
>>  kasan_slab_free include/linux/kasan.h:184 [inline]
>>  slab_free_hook mm/slub.c:2256 [inline]
>>  slab_free mm/slub.c:4477 [inline]
>>  kfree+0x154/0x3e0 mm/slub.c:4598
>>  sk_prot_free net/core/sock.c:2132 [inline]
>>  __sk_destruct+0x4b8/0x74c net/core/sock.c:2224
>>  sk_destruct net/core/sock.c:2239 [inline]
>>  __sk_free+0x388/0x4f4 net/core/sock.c:2250
>>  sk_free+0x60/0xc8 net/core/sock.c:2261
>>  sock_put include/net/sock.h:1884 [inline]
>>  l2cap_sock_kill+0x12c/0x234 net/bluetooth/l2cap_sock.c:1250
>>  l2cap_sock_release+0x138/0x1b4 net/bluetooth/l2cap_sock.c:1421
>>  __sock_release net/socket.c:659 [inline]
>>  sock_close+0xa4/0x1e8 net/socket.c:1421
>>  __fput+0x1bc/0x774 fs/file_table.c:422
>>  ____fput+0x20/0x30 fs/file_table.c:450
>>  task_work_run+0x230/0x2e0 kernel/task_work.c:228
>>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>  do_notify_resume+0x178/0x1f4 arch/arm64/kernel/entry-common.c:151
>>  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
>>  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
>>  el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
>>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>>
>> The buggy address belongs to the object at ffff0000da74b000
>>  which belongs to the cache kmalloc-2k of size 2048
>> The buggy address is located 392 bytes inside of
>>  freed 2048-byte region [ffff0000da74b000, ffff0000da74b800)
>>
>> The buggy address belongs to the physical page:
>> page: refcount:1 mapcount:0 mapping:0000000000000000
>> index:0xffff0000da74e000 pfn:0x11a748
>> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>> flags: 0x5ffc00000000240(workingset|head|node=3D0|zone=3D2|lastcpupid=3D=
0x7ff)
>> page_type: 0xfdffffff(slab)
>> raw: 05ffc00000000240 ffff0000c0002000 fffffdffc369c610 fffffdffc3093810
>> raw: ffff0000da74e000 0000000000080006 00000001fdffffff 0000000000000000
>> head: 05ffc00000000240 ffff0000c0002000 fffffdffc369c610 fffffdffc309381=
0
>> head: ffff0000da74e000 0000000000080006 00000001fdffffff 000000000000000=
0
>> head: 05ffc00000000003 fffffdffc369d201 ffffffffffffffff 000000000000000=
0
>> head: 0000000000000008 0000000000000000 00000000ffffffff 000000000000000=
0
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffff0000da74b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff0000da74b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> >ffff0000da74b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                       ^
>>  ffff0000da74b200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff0000da74b280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>>
>> --
>> You received this message because you are subscribed to the Google Group=
s
>> "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n
>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/syzkaller-bugs/66fbcbc0.050a0220.6bad9=
.0058.GAE%40google.com
>> .
>>

