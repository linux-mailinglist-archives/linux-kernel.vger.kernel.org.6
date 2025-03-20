Return-Path: <linux-kernel+bounces-570309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF00DA6AEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F048A68E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9BB227EBE;
	Thu, 20 Mar 2025 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3BFIAXho"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446D1E5B7E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499623; cv=none; b=TDbL5x1ueSmB5d0ZsqvPK2I7ACVrKlk7Lc4wQZj3KW4JD+p6G24+aDYIcZaaep5XGIAokuSU3gqnAOCxQ1+aR+jqXtA+ONRsF70msq2xajcqkfJiww1SMYxorqvz2RKwBfdTGy1v+LNvNFkXTI/r/LSd6wNXYod8aTq4vETyV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499623; c=relaxed/simple;
	bh=GyrHn2Q36DCOdqp/lWYZ4zGg35eIkUIDncKPpRXE02I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWHVRJMPcdTIf69cAa1qM4jL8V3whOwfKe7SrHlbJ8n5fMaCAH0vgir7Dvj9OfgCftRpWxLqIRdCtHjX64ZYCInP07nATcj3nPOiojlKYUa7Hnqmbt1w3WmCaAGnoXK1Ap4jVTY0qwOZMPm6vtYrrqpig7SpfHZ2JPr6FtGLBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3BFIAXho; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so2602a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742499620; x=1743104420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmTde3E0mIV4IDppSRwCJwI1Lsgc6deXbtCd3QdH7TA=;
        b=3BFIAXhoGg6aF76fEM15ECYjvK0pOFzpqZlFIOI/I1BLxWudOz8IsgbLHk75FvvXvk
         7AzhAFZCUh5jldOQ0cTeRaSIy4U53eypkj1pj+NVb4VRihNlRw0GWIiYHGc3MHwtiLp3
         LFxhUncVFY5lqSmQKqfSImdmq0A7bmTm0iHIOkN4wni+rtchpPVZTXGeeJk3HYyJBfVh
         QASICqZS/ZJ0xQVnP3NeKQFop/DnK+elpK1hhBqXyTBpJRCzbxYKujvMvNOYCV3aeJop
         3ArSqeG8Ed0gBL8rpYMdcp6ESvuzZ0PEJYZcxrY8/gyJ1W6kEoG3vmQXcEEfX3kVl0qr
         L8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499620; x=1743104420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmTde3E0mIV4IDppSRwCJwI1Lsgc6deXbtCd3QdH7TA=;
        b=ZaO2rsNPB+py8/00w2+uLg5+vq+AgsC+KR7dDUEEoez/RrZNTUmOOQKMtDFySsCC6D
         MIviXs7A5aL00gJkb9aUuuAJUNxSHP6pynvlTSHX2jNx0PVpDDcDUyrGxPzn1tpGt/bq
         hlaipl2fyJMGhZ4ekcTySacicp8L5BQFV1cxCIap2GcWA3QseqGqFJE9kdBQRcbbavHX
         dM82P8lRBntYISnlAm1Liz71+DSqEf025k0b8qfLeMb5TV3zM4LjyhJjLwyAx1oJ2SGd
         4hn/xIhEuD11psbIePZZcVF1BP3JF6UzN21vtz6a4zHANUAwVip6ohfQZls6UBGpXI8V
         T/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWB1aifzzGyxGzL5+ybJxdmhHk79auJO9DFqjCSk74FzroUESWXJwVoub0TdIh6RU6nn4yove42UHoHqk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+3y2F+T1u8lwfRCbEr3TcjEqr21zzKYFENqFr9CQ4x6SjOsi
	eaFWpS2s59MFBJmz8t6tHVjcLGbVvwh1fjxsiuEzQDbwqzfOJqTB6ZkF1onYtwM8J5czM3xRI5O
	L3xy5Nl7vNAAVb7JWyylCcoy/Lt29rjGDQCsp
X-Gm-Gg: ASbGnctLGWdUzrjdIJpHIof6ASVS4fWMpOcyNN1dObTAc89itTXZQdwdAEHOxliLctP
	vc/UhbS4e1Isit0Cvf+oDB8UPznTEevMWqIv1jAt7awQJE0R92uzQ4xJYV7uT2oPA+LWbulBHup
	1ZIUAtu0EuAkNY6+DgvA/wtaIO43w7DtrdUmnT4GXUxSh/b1tXNh73bw==
X-Google-Smtp-Source: AGHT+IGBHqk0AfWOW059A6NFKESPhUVlJt9LaG/o1/2eN1zg4AM3sh8WJlWqG0f603hZJlSz0QzfMD/axI3XqmhKGqc=
X-Received: by 2002:aa7:da08:0:b0:5e5:ba42:80a9 with SMTP id
 4fb4d7f45d1cf-5ebce235fd6mr13574a12.1.1742499619208; Thu, 20 Mar 2025
 12:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67abaeaf.050a0220.110943.0041.GAE@google.com>
In-Reply-To: <67abaeaf.050a0220.110943.0041.GAE@google.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 20 Mar 2025 20:39:43 +0100
X-Gm-Features: AQ5f1JpQxbgIR8T4tZX55dH8g9-koLrnu8nqHxKSHNrqLzHI7-H2bclULAbP4yk
Message-ID: <CAG48ez1X4TMPAFO4DLpMJ7JqAXRPMeTy5_BEGQ6nW1DJVi0biA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_lock_anon_vma_read
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Cc: syzbot <syzbot+402900951482ab0a6fcb@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+maintainers of Memory Mapping code

I was looking around on lore and stumbled over this syzbot report from
last month of an anon_vma UAF. I guess it kinda looks like we somehow
ended up with a folio whose mapcount is >0 and whose ->mapping still
points to an anon_vma that has already been freed?

(Note that this was caught with participation of the
slab_free_after_rcu_debug debugging mechanism that I introduced last
year - which I guess means there is also a chance that this is a bug
in the debugging mechanism. I don't think so, but I figured I should
at least mention the possibility...)

There was another bug report similar to this one a few days earlier,
see <https://lore.kernel.org/all/67a76f33.050a0220.3d72c.0028.GAE@google.co=
m/>.

Syzkaller hasn't found any reproducer for this yet, likely because you
only get a KASAN crash if the shrinker / compaction / ... happens to
run at exactly the right time. Do any of you have a good idea of what
bug this could be, or do we need to figure out some debug assertions
we can sprinkle in the code so that syzkaller can find a more reliable
reproducer in the future?

On Tue, Feb 11, 2025 at 9:10=E2=80=AFPM syzbot
<syzbot+402900951482ab0a6fcb@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bb066fe812d6 Merge tag 'pci-v6.14-fixes-2' of git://git.k=
e..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D170aa1b058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc48f582603dcb=
16c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D402900951482ab0=
a6fcb
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/988222f4ae63/dis=
k-bb066fe8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/41a93a7bd0c9/vmlinu=
x-bb066fe8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/99bd53f622e1/b=
zImage-bb066fe8.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+402900951482ab0a6fcb@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in folio_lock_anon_vma_read+0xc4e/0xd40 m=
m/rmap.c:559
> Read of size 8 at addr ffff888012dd7ee0 by task syz.0.7085/4643
>
> CPU: 1 UID: 0 PID: 4643 Comm: syz.0.7085 Not tainted 6.14.0-rc1-syzkaller=
-00081-gbb066fe812d6 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 12/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xc3/0x620 mm/kasan/report.c:489
>  kasan_report+0xd9/0x110 mm/kasan/report.c:602
>  folio_lock_anon_vma_read+0xc4e/0xd40 mm/rmap.c:559
>  rmap_walk_anon_lock mm/rmap.c:2579 [inline]
>  rmap_walk_anon+0x485/0x710 mm/rmap.c:2627
>  rmap_walk mm/rmap.c:2724 [inline]
>  rmap_walk mm/rmap.c:2719 [inline]
>  folio_referenced+0x2a8/0x5c0 mm/rmap.c:1015
>  folio_check_references mm/vmscan.c:896 [inline]
>  shrink_folio_list+0x1dee/0x40c0 mm/vmscan.c:1234
>  evict_folios+0x774/0x1ab0 mm/vmscan.c:4660
>  try_to_shrink_lruvec+0x5a2/0x9a0 mm/vmscan.c:4821
>  lru_gen_shrink_lruvec mm/vmscan.c:4970 [inline]
>  shrink_lruvec+0x313/0x2ba0 mm/vmscan.c:5715
>  shrink_node_memcgs mm/vmscan.c:5951 [inline]
>  shrink_node mm/vmscan.c:5992 [inline]
>  shrink_node+0x105c/0x3f20 mm/vmscan.c:5970
>  shrink_zones mm/vmscan.c:6237 [inline]
>  do_try_to_free_pages+0x35f/0x1a30 mm/vmscan.c:6299
>  try_to_free_mem_cgroup_pages+0x31a/0x7a0 mm/vmscan.c:6631
>  try_charge_memcg+0x356/0xaf0 mm/memcontrol.c:2255
>  try_charge mm/memcontrol-v1.h:19 [inline]
>  charge_memcg+0x8a/0x310 mm/memcontrol.c:4487
>  __mem_cgroup_charge+0x2b/0x1e0 mm/memcontrol.c:4504
>  mem_cgroup_charge include/linux/memcontrol.h:644 [inline]
>  shmem_alloc_and_add_folio+0x50a/0xc10 mm/shmem.c:1912
>  shmem_get_folio_gfp+0x689/0x1530 mm/shmem.c:2522
>  shmem_get_folio mm/shmem.c:2628 [inline]
>  shmem_write_begin+0x161/0x300 mm/shmem.c:3278
>  generic_perform_write+0x2ba/0x920 mm/filemap.c:4189
>  shmem_file_write_iter+0x10e/0x140 mm/shmem.c:3454
>  __kernel_write_iter+0x318/0xa90 fs/read_write.c:612
>  dump_emit_page fs/coredump.c:884 [inline]
>  dump_user_range+0x389/0x8c0 fs/coredump.c:945
>  elf_core_dump+0x2787/0x3880 fs/binfmt_elf.c:2129
>  do_coredump+0x304f/0x45d0 fs/coredump.c:758
>  get_signal+0x23f3/0x2610 kernel/signal.c:3021
>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> RIP: 0033:0x4021000
> Code: Unable to access opcode bytes at 0x4020fd6.
> RSP: 002b:000000000000000d EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 00007fc4c91a5fa0 RCX: 00007fc4c8f8cde9
> RDX: ffffffffffffffff RSI: 0000000000000005 RDI: 0000000000008001
> RBP: 00007fc4c900e2a0 R08: 0000000000000006 R09: 0000000000000000
> R10: ffffffffff600000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fc4c91a5fa0 R15: 00007ffdab469bf8
>  </TASK>
>
> Allocated by task 4636:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:319 [inline]
>  __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4115 [inline]
>  slab_alloc_node mm/slub.c:4164 [inline]
>  kmem_cache_alloc_noprof+0x1c8/0x3b0 mm/slub.c:4171
>  anon_vma_alloc mm/rmap.c:94 [inline]
>  anon_vma_fork+0xe6/0x620 mm/rmap.c:360
>  dup_mmap kernel/fork.c:711 [inline]
>  dup_mm kernel/fork.c:1700 [inline]
>  copy_mm+0x1b7b/0x2730 kernel/fork.c:1752
>  copy_process+0x3e6d/0x6f20 kernel/fork.c:2403
>  kernel_clone+0xfd/0x960 kernel/fork.c:2815
>  __do_sys_clone+0xba/0x100 kernel/fork.c:2958
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 4644:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2353 [inline]
>  slab_free_after_rcu_debug+0x115/0x340 mm/slub.c:4659
>  rcu_do_batch kernel/rcu/tree.c:2546 [inline]
>  rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2802
>  handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
>  __do_softirq kernel/softirq.c:595 [inline]
>  invoke_softirq kernel/softirq.c:435 [inline]
>  __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
>  instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
>  sysvec_call_function_single+0xa4/0xc0 arch/x86/kernel/smp.c:266
>  asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:709
>
> Last potentially related work creation:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_record_aux_stack+0xb8/0xd0 mm/kasan/generic.c:548
>  slab_free_hook mm/slub.c:2314 [inline]
>  slab_free mm/slub.c:4609 [inline]
>  kmem_cache_free+0x166/0x4d0 mm/slub.c:4711
>  anon_vma_free mm/rmap.c:137 [inline]
>  __put_anon_vma+0x114/0x3a0 mm/rmap.c:2568
>  put_anon_vma include/linux/rmap.h:116 [inline]
>  unlink_anon_vmas+0x58a/0x820 mm/rmap.c:444
>  free_pgtables+0x33c/0x950 mm/memory.c:408
>  exit_mmap+0x406/0xba0 mm/mmap.c:1295
>  __mmput+0x12a/0x410 kernel/fork.c:1356
>  mmput+0x62/0x70 kernel/fork.c:1378
>  exec_mmap fs/exec.c:1011 [inline]
>  begin_new_exec+0x152b/0x3800 fs/exec.c:1267
>  load_elf_binary+0x85c/0x4ff0 fs/binfmt_elf.c:1002
>  search_binary_handler fs/exec.c:1775 [inline]
>  exec_binprm fs/exec.c:1807 [inline]
>  bprm_execve fs/exec.c:1859 [inline]
>  bprm_execve+0x8dd/0x16d0 fs/exec.c:1835
>  do_execveat_common.isra.0+0x4a2/0x610 fs/exec.c:1966
>  do_execve fs/exec.c:2040 [inline]
>  __do_sys_execve fs/exec.c:2116 [inline]
>  __se_sys_execve fs/exec.c:2111 [inline]
>  __x64_sys_execve+0x8c/0xb0 fs/exec.c:2111
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff888012dd7ee0
>  which belongs to the cache anon_vma of size 208
> The buggy address is located 0 bytes inside of
>  freed 208-byte region [ffff888012dd7ee0, ffff888012dd7fb0)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888012dd=
7440 pfn:0x12dd7
> memcg:ffff88802647a401
> flags: 0xfff00000000200(workingset|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000200 ffff88801c282140 ffff88801b0937c8 ffffea0000c9a210
> raw: ffff888012dd7440 00000000000f000e 00000000f5000000 ffff88802647a401
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(=
GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5503, tgid 5503 (dhc=
pcd), ts 67849640029, free_ts 55595562609
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
>  prep_new_page mm/page_alloc.c:1559 [inline]
>  get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
>  __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4739
>  alloc_pages_mpol+0x1fc/0x540 mm/mempolicy.c:2270
>  alloc_slab_page mm/slub.c:2423 [inline]
>  allocate_slab mm/slub.c:2587 [inline]
>  new_slab+0x23d/0x330 mm/slub.c:2640
>  ___slab_alloc+0xbfa/0x1600 mm/slub.c:3826
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
>  __slab_alloc_node mm/slub.c:3991 [inline]
>  slab_alloc_node mm/slub.c:4152 [inline]
>  kmem_cache_alloc_noprof+0xeb/0x3b0 mm/slub.c:4171
>  anon_vma_alloc mm/rmap.c:94 [inline]
>  anon_vma_fork+0xe6/0x620 mm/rmap.c:360
>  dup_mmap kernel/fork.c:711 [inline]
>  dup_mm kernel/fork.c:1700 [inline]
>  copy_mm+0x1b7b/0x2730 kernel/fork.c:1752
>  copy_process+0x3e6d/0x6f20 kernel/fork.c:2403
>  kernel_clone+0xfd/0x960 kernel/fork.c:2815
>  __do_sys_clone+0xba/0x100 kernel/fork.c:2958
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5502 tgid 5502 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
>  __put_partials+0x14c/0x170 mm/slub.c:3153
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4115 [inline]
>  slab_alloc_node mm/slub.c:4164 [inline]
>  kmem_cache_alloc_node_noprof+0x1ca/0x3b0 mm/slub.c:4216
>  __alloc_skb+0x2b3/0x380 net/core/skbuff.c:668
>  alloc_skb include/linux/skbuff.h:1331 [inline]
>  netlink_alloc_large_skb+0x69/0x130 net/netlink/af_netlink.c:1196
>  netlink_sendmsg+0x689/0xd70 net/netlink/af_netlink.c:1867
>  sock_sendmsg_nosec net/socket.c:713 [inline]
>  __sock_sendmsg net/socket.c:728 [inline]
>  ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2568
>  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2622
>  __sys_sendmsg+0x16e/0x220 net/socket.c:2654
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff888012dd7d80: 00 00 fc fc fc fc fc fc fc fc fa fb fb fb fb fb
>  ffff888012dd7e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888012dd7e80: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
>                                                        ^
>  ffff888012dd7f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888012dd7f80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

