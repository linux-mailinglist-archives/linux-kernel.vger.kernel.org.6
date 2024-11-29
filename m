Return-Path: <linux-kernel+bounces-413229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84579D1566
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4222AB2AB6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214141B219F;
	Mon, 18 Nov 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PPv4clqf"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108E1B3921
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947446; cv=none; b=g/ovqcyWBBfETWCgPoavZTlhDzlAncWZNL65qHp9hYuu636mAIqrYoDWkq7oMcFSHoa8/W0QjmKJ0gL1j0D0Ww81ESPl749hmtXOdr22qtY0tvT5epfqL22AR2vSRJ6BjLdNi4+wdX/OChiTjYxS1sq03SWuni/cekP1kggvePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947446; c=relaxed/simple;
	bh=IJoU35jpQsTwkghmyLbZTbZzQYBZiz03ntghFK8GclI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QnTK1Z/YauR1WJjgYN7cmf25j0UJp2+AxPWQa7UCNrW0BZfz3G4xLHW5scHM0dQAe80rB6MYQ1dhNk84jPcr+GSRUQF+Oasf3XxVh6x42BbPHkNmXRMpCWeiMIr3Kynwrpjm6tnfp+XAwOsyguAwMQE6pxkrNsWHmLPcqseAvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PPv4clqf; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bfba9e82-1ccb-41ef-bbfc-0de73a048d6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731947441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrO5qHZH2ecdowF+8JHQsynxKFmeV6EoFX2P0Az1SD4=;
	b=PPv4clqfoJAZH5TO7TI70rK0KeM7LStpKp7QZZh0auWFD/LKxNy1cSSWkMZ7YpuwCoJhPL
	N+x+n/VLPvNg9uThTJtA7gu8MjyyiD0x0i8ViqVbwrN+j6LM+f/5HQUxMuXZHH9d0W8+0W
	5Ly/AvxRNLy3MjnjmZDqPj8sEFFf2Fo=
Date: Mon, 18 Nov 2024 08:30:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] BUG: using smp_processor_id() in preemptible code
 in bpf_mem_alloc
Content-Language: en-GB
To: syzbot <syzbot+fd2873203c2ed428828a@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
 syzkaller-bugs@googlegroups.com
References: <673b14e8.050a0220.87769.0029.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <673b14e8.050a0220.87769.0029.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


#syz fix: bpf: Add necessary migrate_disable to range_tree.


On 11/18/24 2:20 AM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    379d5ee624ed Merge branch 'bpf-range_tree-for-bpf-arena'
> git tree:       bpf-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=115ecb5f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
> dashboard link: https://syzkaller.appspot.com/bug?extid=fd2873203c2ed428828a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12636ce8580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f0f4c0580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e83cf63a68cf/disk-379d5ee6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ff1f89f228ad/vmlinux-379d5ee6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8a715c466ecd/bzImage-379d5ee6.xz
>
> The issue was bisected to:
>
> commit b795379757eb054925fbb6783559c86f01c1a614
> Author: Alexei Starovoitov <ast@kernel.org>
> Date:   Fri Nov 8 02:56:15 2024 +0000
>
>      bpf: Introduce range_tree data structure and use it in bpf arena
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b2ab5f980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b2ab5f980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14b2ab5f980000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fd2873203c2ed428828a@syzkaller.appspotmail.com
> Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")
>
> BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor373/5838
> caller is bpf_mem_alloc+0x117/0x220 kernel/bpf/memalloc.c:903
> CPU: 1 UID: 0 PID: 5838 Comm: syz-executor373 Not tainted 6.12.0-rc7-syzkaller-g379d5ee624ed #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   check_preemption_disabled+0x10e/0x120 lib/smp_processor_id.c:49
>   bpf_mem_alloc+0x117/0x220 kernel/bpf/memalloc.c:903
>   range_tree_set+0x971/0x1830 kernel/bpf/range_tree.c:238
>   arena_map_alloc+0x36f/0x440 kernel/bpf/arena.c:137
>   map_create+0x946/0x11c0 kernel/bpf/syscall.c:1441
>   __sys_bpf+0x6d1/0x810 kernel/bpf/syscall.c:5741
>   __do_sys_bpf kernel/bpf/syscall.c:5866 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5864 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5864
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5cb29a1329
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffee3bcaa18 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007ffee3bcabf8 RCX: 00007f5cb29a1329
> RDX: 0000000000000048 RSI: 0000000020003940 RDI: 0000000000000000
> RBP: 00007f5cb2a14610 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffee3bcabe8 R14: 0000000000000001 R15: 0000000000000001
>   </TA
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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


