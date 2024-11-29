Return-Path: <linux-kernel+bounces-426011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815999DEDBB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D05281D69
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB97132103;
	Sat, 30 Nov 2024 00:00:51 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59033BA45
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732924851; cv=none; b=in5zif+/68YQn+51+TXM0ElOlLXXRQHKl6nbK6nAnJ/rQkjZEDl7lVKsbmJ2caiCky8WBiXxdqOwIh1YGwRQziGy3dS0D77sqFdRSmQYgsmYwXKqfgkxKQXrb7lMKzehP2wiFP8XfUN6GTOx8ztVksB0yBcGV2WZsY+U9WPW9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732924851; c=relaxed/simple;
	bh=09bEussHxUAV3cOmDbWiHlgo9iV5iQfyUuucrotFwsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+/CWyecyYRfFW3mDbE9sbQcyjOboDuCIUrOOHwfyPRpmVYz13GTe6HHBoZl8fPDSi51OTYjcwjCcLwCVuSKxRMjyfDGoxzmdVWmvgZe/MtNQ/bQBw4r6GUXpdoEAGrzzcd8YwWkLkT584Wp+094sQV2G7/y+xfdRdXGlP2xhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.216])
	by sina.com (10.185.250.21) with ESMTP
	id 674A551000003F22; Fri, 30 Nov 2024 07:58:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6514623408373
X-SMAIL-UIID: C78C7330846E4034920DE679090D4BE3-20241130-075813-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f8761b2f358f6a1dec5e@syzkaller.appspotmail.com>
Cc: frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Nogikh <nogikh@google.com>,
	Tejun Heo <tj@kernel.org>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in kick_pool / wq_worker_running
Date: Sat, 30 Nov 2024 07:58:00 +0800
Message-Id: <20241129235800.2177-1-hdanton@sina.com>
In-Reply-To: <6749d1e2.050a0220.253251.00b7.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 29 Nov 2024 06:38:26 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    7af08b57bcb9 Merge tag 'trace-v6.13-2' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10a39f5f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=77174711582263a3
> dashboard link: https://syzkaller.appspot.com/bug?extid=f8761b2f358f6a1dec5e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/13ed5c4111d5/disk-7af08b57.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b14531c093bd/vmlinux-7af08b57.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0ddfac565b6b/bzImage-7af08b57.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f8761b2f358f6a1dec5e@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in kick_pool / wq_worker_running
> 
> read-write to 0xffff888237d2e8a4 of 4 bytes by task 3377 on cpu 1:
>  wq_worker_running+0x98/0x130 kernel/workqueue.c:1400
>  schedule_timeout+0xb8/0x160 kernel/time/sleep_timeout.c:99
>  do_wait_for_common kernel/sched/completion.c:95 [inline]
>  __wait_for_common kernel/sched/completion.c:116 [inline]
>  wait_for_common+0xfb/0x1c0 kernel/sched/completion.c:127
>  usb_start_wait_urb+0xdc/0x190 drivers/usb/core/message.c:64
>  usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
>  usb_control_msg+0x182/0x240 drivers/usb/core/message.c:154
>  get_port_status drivers/usb/core/hub.c:604 [inline]
>  hub_ext_port_status+0xbf/0x480 drivers/usb/core/hub.c:621
>  usb_hub_port_status drivers/usb/core/hub.c:671 [inline]
>  port_event drivers/usb/core/hub.c:5714 [inline]
>  hub_event+0x538/0x2910 drivers/usb/core/hub.c:5903
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
>  worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
>  kthread+0x1d1/0x210 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> read to 0xffff888237d2e8a4 of 4 bytes by task 3399 on cpu 0:
>  need_more_worker kernel/workqueue.c:934 [inline]

/*
 * Need to wake up a worker?  Called from anything but currently
 * running workers.
 *
 * Note that, because unbound workers never contribute to nr_running, this
 * function will always return %true for unbound pools as long as the
 * worklist isn't empty.
 */
static bool need_more_worker(struct worker_pool *pool)
{
	return !list_empty(&pool->worklist) && !pool->nr_running;
}

Given bound workers only considered wrt nr_running, this report can be 
safely dropped/ignored as data race is ruled out for them.

>  kick_pool+0x4d/0x2c0 kernel/workqueue.c:1240
>  __queue_work+0x8bb/0xb40 kernel/workqueue.c:2340
>  queue_work_on+0xd3/0x180 kernel/workqueue.c:2390
>  wg_queue_enqueue_per_peer_tx+0x124/0x260 drivers/net/wireguard/queueing.h:188
>  wg_packet_encrypt_worker+0xa00/0xbb0 drivers/net/wireguard/send.c:305
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
>  worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
>  kthread+0x1d1/0x210 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> value changed: 0x00000000 -> 0x00000001
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 3399 Comm: kworker/0:4 Not tainted 6.12.0-syzkaller-10689-g7af08b57bcb9 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: wg-crypt-wg1 wg_packet_encrypt_worker
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

