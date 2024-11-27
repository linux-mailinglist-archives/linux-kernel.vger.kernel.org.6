Return-Path: <linux-kernel+bounces-423093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A579DA2B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578D128434D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BA514A604;
	Wed, 27 Nov 2024 07:07:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60392142E67
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691247; cv=none; b=KR/H78Os6NbbwwIIFJ7WnCkIydzV322Tijoo7KM6PuFHVxks6FzJeQuuY2VaJMUO4OcYl1Ctc6jPqdJVCQj3ky/IbwLQi4c9uetr0uIvv3+RPhxcNewRwJKtas+SdJ8mlrLv4Vjqu2lA8i5839Q/T7clgNXvd1ZYcrvyYKMESR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691247; c=relaxed/simple;
	bh=mQORrIwZGz7Zr+OjzT+J+5MEvwUl8Vdqpq8/n7AkTW8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VmVcxZ9kstnGjkcLh0FbBcZpYXR6ofaFxo4a0xQGSHasELhYYvU5mA2rsz4FRmczRjVgACFQciEB7k21AAuOc9PVotyz2dDFk/cv0ltXSvNcieW/x9z3YCsjRyL+envl1HcIqYnFuBmFWXYGo8AQwcQIHYvG0uRVVj/4v+2ScQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8419946e077so339248439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732691245; x=1733296045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5KthtyKRybJ876UXRDCDjbm/kWEfQCxBVVuiSQ+NY0=;
        b=Lxx0Myldwfnn6ZPmWXCCyEvl79aaFD//aAfaeYB68dRa7qBdDu/mro4+WWhKY7wdul
         9crxlf0IzSvcMsbwyMF9jiw/5qRS1d9mgCHFYtnWQJCPuB0HtndXs1vSoDyBCcnbFWi9
         uSgJnod53TKKcsPm7O0Yv3HyIzbPX3vCxzcQmBAxWkQvjAkCCz6dsxEm28BxWoUxJxPc
         yDP+C09o8GPHS8PbBRoHkRxuocgWCV7UKvO9Q+f4An9JGYGc1AANob7JanCpDQcxjGPQ
         rNO1rhJRtTJd04Fcpw5beQGO2kq/3QNSCnHVp1/f42Q0rfdoWYsyE3JlG09hHvjIfmah
         gIsg==
X-Forwarded-Encrypted: i=1; AJvYcCVNKTlliT0OTDOiaXT0aPlBmmMoGyP6fKBesc6l1JedHXHITXzb0uv83WjnMyc4/xSHQzwRvLGcIkfFu2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8bl4Bjs8XGUFykgkMJ3SnvihgWg6cfZ1F1eBU8lWvROdl4xk
	YYwkKVi4UN9tBokokkgPL4aHt++Iskgb7KyDa8JXIYZQOQLXMR+dEfkfjVDzGXkDqFuNZNPPAmL
	ujfPu3OY5on/EgiBUULl0HZ4t01Tr9c2wQW1zaRnFwoLHTy2U2cWryy8=
X-Google-Smtp-Source: AGHT+IEBikNMR7IPvV/flgd35QMVjl7+CfdgtLdrPKd4lwNtuuTz+hh0vD782jXMUmEN4AkpY+fWZTK3rlKjKdGUNYjHAySYHgEL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e01:b0:3a7:7ee3:108d with SMTP id
 e9e14a558f8ab-3a7c55f2783mr20838965ab.23.1732691245571; Tue, 26 Nov 2024
 23:07:25 -0800 (PST)
Date: Tue, 26 Nov 2024 23:07:25 -0800
In-Reply-To: <66f62bf3.050a0220.38ace9.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746c52d.050a0220.1286eb.002b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] BUG: MAX_STACK_TRACE_ENTRIES too low! (4)
From: syzbot <syzbot+c6c4861455fdd207f160@syzkaller.appspotmail.com>
To: andrii@kernel.org, asml.silence@gmail.com, ast@kernel.org, axboe@kernel.dk, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mingo@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	riel@redhat.com, sdf@fomichev.me, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, wander@redhat.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    445d9f05fa14 Merge tag 'nfsd-6.13' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1693d530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c44a32edb32752c
dashboard link: https://syzkaller.appspot.com/bug?extid=c6c4861455fdd207f160
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15abb778580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11977ff7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-445d9f05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a928f58090e0/vmlinux-445d9f05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4212b152a056/bzImage-445d9f05.xz

The issue was bisected to:

commit 893cdaaa3977be6afb3a7f756fbfd7be83f68d8c
Author: Wander Lairson Costa <wander@redhat.com>
Date:   Wed Jun 14 12:23:22 2023 +0000

    sched: avoid false lockdep splat in put_task_struct()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a00127980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a00127980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a00127980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6c4861455fdd207f160@syzkaller.appspotmail.com
Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")

BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 5965 Comm: sshd Not tainted 6.12.0-syzkaller-09734-g445d9f05fa14 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 save_trace+0x78f/0xb60 kernel/locking/lockdep.c:579
 check_prev_add kernel/locking/lockdep.c:3222 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x312a/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
 htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
 bpf_prog_2c29ac5cdc6b1842+0x43/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
 bpf_trace_run3+0x240/0x5a0 kernel/trace/bpf_trace.c:2393
 trace_kmem_cache_free include/trace/events/kmem.h:114 [inline]
 kmem_cache_free+0x200/0x4c0 mm/slub.c:4699
 skb_kfree_head net/core/skbuff.c:1084 [inline]
 skb_kfree_head net/core/skbuff.c:1081 [inline]
 skb_free_head+0x18a/0x1d0 net/core/skbuff.c:1098
 skb_release_data+0x560/0x730 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb+0x4f/0x70 net/core/skbuff.c:1204
 tcp_wmem_free_skb include/net/tcp.h:306 [inline]
 tcp_rtx_queue_unlink_and_free include/net/tcp.h:2091 [inline]
 tcp_clean_rtx_queue net/ipv4/tcp_input.c:3436 [inline]
 tcp_ack+0x1eb7/0x5ba0 net/ipv4/tcp_input.c:4032
 tcp_rcv_established+0xcab/0x20f0 net/ipv4/tcp_input.c:6173
 tcp_v4_do_rcv+0x5ca/0xa90 net/ipv4/tcp_ipv4.c:1916
 sk_backlog_rcv include/net/sock.h:1121 [inline]
 __release_sock+0x31b/0x400 net/core/sock.c:3083
 release_sock+0x5a/0x220 net/core/sock.c:3637
 tcp_sendmsg+0x38/0x50 net/ipv4/tcp.c:1359
 inet_sendmsg+0xb9/0x140 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 sock_write_iter+0x4ac/0x5b0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x207/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f850c116bf2
Code: 89 c7 48 89 44 24 08 e8 7b 34 fa ff 48 8b 44 24 08 48 83 c4 28 c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 6f 48 8b 15 07 a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fffe9a02c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000034 RCX: 00007f850c116bf2
RDX: 0000000000000034 RSI: 0000559808160970 RDI: 0000000000000004
RBP: 0000559808169290 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00005597d5bb7aa4
R13: 00000000000000f4 R14: 00005597d5bb83e8 R15: 00007fffe9a02ce8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

