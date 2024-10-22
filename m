Return-Path: <linux-kernel+bounces-375899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B299A9C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256831C23D29
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3563B15666C;
	Tue, 22 Oct 2024 08:31:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56C155A53
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585866; cv=none; b=n6D9171Gfd+JNiMRZMJt60i4gEWo/6jEkvzjaPWYw81vzASauVq+8oUxvOxFBlGbmtpnQ40b1FzI5qaxVpOsWiP9FG34FmUUVeGoKoyDZAqdmLMG3rJvQfd9K1Km2jIl1dpcMyU1CJk6eKbvEx+ktxMG48+NliS/PAPRZqDzOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585866; c=relaxed/simple;
	bh=EDWeIKVYFaW9TplsDVFCg8+g25Y/iilxGubn4Czl5U0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f5KZTJo0B546tgQd2JEBwBsRMPsR+PhO7U61vgyfLoWQbfebQynxDjGzhbQE6VnTEpFxkxw6RUk22UhCovXYxLmvlpWfBnl0F/fXVK9EIlQFf7FCnB5vueOeFJBpxYk14fETShiiKgqKHkeJ43R8cvNHa+2DLSLPyZvirvVFmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abf723da3so313340739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729585863; x=1730190663;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjElZkHSLxsVhvl+fMVEl5HlfY3NP0pMwsSMioPk900=;
        b=NFSiH/0HleRq95Rob5HQbSraBVxEPZiCmYYTf46CIzzzjZ+wi6VTkB7jPWWVGCMvZa
         lz5gSOYtxf2WLuHx4UoC8o9v2I9XQyPjzKVz3Bggt7elK1gYIZ75ZeT/tlP5D8zU9+XZ
         e5fKRebz+3rBR6PIryCehQ8Oj0hfruffz3qd0Z7bTl6gjW5Yp8Y5OxYlzRqYTpolML1g
         7k7BOlG2nRI79IX+mGJ4pzWs5KHBlOtMVXvmkzbheyrtCWL0foq9M8esAanwjsD92/st
         E4OgOA763v2CorZ7771DJ2z41uf1o2hjTpSvyl4/hMehRarwhvZ09xBr3QLtRt38mOvG
         mwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsA/Ujn5rY7KwV93JZv/SthNu8IxBGX+kVtnMvUeIf8iMFQ5rdXtyHwljtuDNoVQn9c0U0TbNa4faNF20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPa6WJHEaSf3MBI9cpMFWg2yoeuTz+DZC8Otk1VOUC9E6miBIa
	Yp/2wjLQmW1KA+X/zNyTcqSImtruXyb6F4CloWsGK6v2nmoEIPBPikk///ihkkbTrn6d2xQr66w
	M1LLuFlmtqE3GF81Pb/MoAOxv2HoYkteIXrqPEKVw9PyKhqWez9HdTeM=
X-Google-Smtp-Source: AGHT+IH9st9jnQkgbFatDRqFg8/kXESnU687fFuIPuK2EHPygOO2G9/WH4GJZOPLL2RKZWud6T2NsdGhtmwm/rPd3oZAOuTwHICZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150b:b0:83a:b7e8:a684 with SMTP id
 ca18e2360f4ac-83aba645ebdmr1153769339f.11.1729585863497; Tue, 22 Oct 2024
 01:31:03 -0700 (PDT)
Date: Tue, 22 Oct 2024 01:31:03 -0700
In-Reply-To: <tencent_4DCD74787E6FAC2F296C109468E8F6EEDE0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671762c7.050a0220.10f4f4.0114.GAE@google.com>
Subject: Re: [syzbot] [serial?] BUG: soft lockup in debug_check_no_obj_freed
From: syzbot <syzbot+a234c2d63e0c171ca10e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

653] 1 lock held by syz-execprog/2653:
[   61.434232][ T2653]  #0: ffff888112418958 (&sighand->siglock){....}-{2:2=
}, at: get_signal+0x25a/0x2770
[   61.443766][ T2653] irq event stamp: 48556
[   61.448017][ T2653] hardirqs last  enabled at (48555): [<ffffffff86eea63=
3>] irqentry_exit_to_user_mode+0x113/0x240
[   61.458527][ T2653] hardirqs last disabled at (48556): [<ffffffff86f0d36=
5>] _raw_spin_lock_irq+0x45/0x50
[   61.468174][ T2653] softirqs last  enabled at (48542): [<ffffffff811caf8=
3>] handle_softirqs+0x5a3/0x8d0
[   61.477893][ T2653] softirqs last disabled at (48537): [<ffffffff811cb9e=
c>] irq_exit_rcu+0xac/0x110
[   61.487192][ T2653] Preemption disabled at:
[   61.487201][ T2653] [<0000000000000000>] 0x0
[   61.496255][ T2653] CPU: 1 UID: 0 PID: 2653 Comm: syz-execprog Tainted: =
G        W          6.12.0-rc4-syzkaller-gc6d9e43954bf-dirty #0
[   61.508883][ T2653] Tainted: [W]=3DWARN
[   61.512710][ T2653] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[   61.522769][ T2653] Call Trace:
[   61.526056][ T2653]  <TASK>
[   61.528996][ T2653]  dump_stack_lvl+0x116/0x1f0
[   61.533718][ T2653]  __might_resched+0x3c0/0x5e0
[   61.538585][ T2653]  ? mark_lock+0xb5/0xc60
[   61.542930][ T2653]  ? __pfx___might_resched+0x10/0x10
[   61.548267][ T2653]  ? __pfx_mark_lock+0x10/0x10
[   61.553043][ T2653]  debug_check_no_obj_freed+0x1d9/0x620
[   61.558627][ T2653]  ? __pfx_debug_check_no_obj_freed+0x10/0x10
[   61.564815][ T2653]  ? put_ucounts+0x1e4/0x290
[   61.569459][ T2653]  kmem_cache_free+0x27d/0x480
[   61.574418][ T2653]  ? collect_signal+0x315/0x630
[   61.579304][ T2653]  collect_signal+0x315/0x630
[   61.584620][ T2653]  dequeue_signal+0x27e/0x720
[   61.589657][ T2653]  ? do_raw_spin_lock+0x12d/0x2c0
[   61.594772][ T2653]  ? __pfx_dequeue_signal+0x10/0x10
[   61.600066][ T2653]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   61.605530][ T2653]  ? lock_acquire+0x2f/0xb0
[   61.610044][ T2653]  ? get_signal+0x25a/0x2770
[   61.614641][ T2653]  get_signal+0x5fb/0x2770
[   61.619071][ T2653]  ? __pfx_get_signal+0x10/0x10
[   61.624016][ T2653]  ? ktime_get+0xfb/0x1a0
[   61.628439][ T2653]  arch_do_signal_or_restart+0x90/0x7e0
[   61.634093][ T2653]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[   61.640364][ T2653]  irqentry_exit_to_user_mode+0x136/0x240
[   61.646182][ T2653]  asm_sysvec_reschedule_ipi+0x1a/0x20
[   61.651680][ T2653] RIP: 0033:0x41a8cb
[   61.655579][ T2653] Code: 8b 50 20 48 c1 e2 0d 48 89 d6 48 c1 ea 06 48 8=
b 78 68 48 c1 ef 03 4c 8b 40 18 4c 01 c6 48 29 d6 4c 29 c3 48 89 d9 48 c1 e=
b 09 <48> c1 e9 03 48 89 ca 83 e2 3f 4c 8d 04 3a 4c 8d 0c de 90 90 48 8d
[   61.675288][ T2653] RSP: 002b:000000c001e35e58 EFLAGS: 00000207
[   61.681359][ T2653] RAX: 00007ffa93044e58 RBX: 0000000000000009 RCX: 000=
00000000013e0
[   61.689336][ T2653] RDX: 0000000000000080 RSI: 000000c002547f80 RDI: 000=
0000000000006
[   61.697310][ T2653] RBP: 000000c001e35e70 R08: 000000c002546000 R09: 000=
000c000066508
[   61.705378][ T2653] R10: 000000c001ca5800 R11: 0000000000000024 R12: 000=
000c001e35f00
[   61.713369][ T2653] R13: 0000000000000001 R14: 000000c001c77c00 R15: 000=
000c0020bd0e8
[   61.721354][ T2653]  </TASK>
[   61.893622][   T29] kauditd_printk_skb: 9 callbacks suppressed
[   61.893645][   T29] audit: type=3D1400 audit(1729585852.299:102): avc:  =
denied  { execmem } for  pid=3D2660 comm=3D"syz-executor" scontext=3Droot:s=
ysadm_r:sysadm_t tcontext=3Droot:sysadm_r:sysadm_t tclass=3Dprocess permiss=
ive=3D1
[   61.969213][   T29] audit: type=3D1400 audit(1729585852.359:103): avc:  =
denied  { read } for  pid=3D2665 comm=3D"syz-executor" dev=3D"nsfs" ino=3D4=
026531840 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:object_r:ns=
fs_t tclass=3Dfile permissive=3D1
[   62.017211][   T29] audit: type=3D1400 audit(1729585852.359:104): avc:  =
denied  { open } for  pid=3D2665 comm=3D"syz-executor" path=3D"net:[4026531=
840]" dev=3D"nsfs" ino=3D4026531840 scontext=3Droot:sysadm_r:sysadm_t tcont=
ext=3Dsystem_u:object_r:nsfs_t tclass=3Dfile permissive=3D1
[   62.097311][   T29] audit: type=3D1400 audit(1729585852.359:105): avc:  =
denied  { mounton } for  pid=3D2665 comm=3D"syz-executor" path=3D"/" dev=3D=
"sda1" ino=3D2 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:object=
_r:root_t tclass=3Ddir permissive=3D1
[   62.169505][   T29] audit: type=3D1400 audit(1729585852.379:106): avc:  =
denied  { create } for  pid=3D2664 comm=3D"syz-executor" scontext=3Droot:sy=
sadm_r:sysadm_t tcontext=3Droot:sysadm_r:sysadm_t tclass=3Duser_namespace p=
ermissive=3D1
[   62.196383][ T2665] soft_limit_in_bytes is deprecated and will be remove=
d. Please report your usecase to linux-mm@kvack.org if you depend on this f=
unctionality.
[   62.237242][   T29] audit: type=3D1400 audit(1729585852.399:107): avc:  =
denied  { sys_admin } for  pid=3D2664 comm=3D"syz-executor" capability=3D21=
  scontext=3Droot:sysadm_r:sysadm_t tcontext=3Droot:sysadm_r:sysadm_t tclas=
s=3Dcap_userns permissive=3D1
[   62.298760][   T29] audit: type=3D1400 audit(1729585852.419:108): avc:  =
denied  { mounton } for  pid=3D2665 comm=3D"syz-executor" path=3D"/root/syz=
kaller.CmWlf6/syz-tmp" dev=3D"sda1" ino=3D1945 scontext=3Droot:sysadm_r:sys=
adm_t tcontext=3Droot:object_r:user_home_t tclass=3Ddir permissive=3D1
[   62.363987][   T29] audit: type=3D1400 audit(1729585852.419:109): avc:  =
denied  { mount } for  pid=3D2665 comm=3D"syz-executor" name=3D"/" dev=3D"t=
mpfs" ino=3D1 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:object_=
r:tmpfs_t tclass=3Dfilesystem permissive=3D1
[   62.408172][   T29] audit: type=3D1400 audit(1729585852.419:110): avc:  =
denied  { mounton } for  pid=3D2665 comm=3D"syz-executor" path=3D"/root/syz=
kaller.CmWlf6/syz-tmp/newroot/dev" dev=3D"tmpfs" ino=3D3 scontext=3Droot:sy=
sadm_r:sysadm_t tcontext=3Droot:object_r:user_tmpfs_t tclass=3Ddir permissi=
ve=3D1
[   62.416550][ T1356] BUG: sleeping function called from invalid context a=
t lib/debugobjects.c:978
[   62.442502][ T1356] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pi=
d: 1356, name: kworker/u8:7
[   62.451716][ T1356] preempt_count: 1, expected: 0
[   62.456779][ T1356] RCU nest depth: 0, expected: 0
[   62.461726][ T1356] 3 locks held by kworker/u8:7/1356:
[   62.467108][ T1356]  #0: ffff888100089148 ((wq_completion)events_unbound=
){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0
[   62.478473][ T1356]  #1: ffffc900026afd80 ((work_completion)(&sub_info->=
work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0
[   62.490007][ T1356]  #2: ffffffff88c0a098 (tasklist_lock){.+.+}-{2:2}, a=
t: release_task+0x20c/0x1b00
[   62.499451][ T1356] irq event stamp: 15692
[   62.503787][ T1356] hardirqs last  enabled at (15691): [<ffffffff86f0d63=
3>] _raw_spin_unlock_irq+0x23/0x50
[   62.513611][ T1356] hardirqs last disabled at (15692): [<ffffffff86f0da6=
5>] _raw_write_lock_irq+0x45/0x50
[   62.523347][ T1356] softirqs last  enabled at (7630): [<ffffffff811caf83=
>] handle_softirqs+0x5a3/0x8d0
[   62.532827][ T1356] softirqs last disabled at (7533): [<ffffffff811cb9ec=
>] irq_exit_rcu+0xac/0x110
[   62.541954][ T1356] Preemption disabled at:
[   62.541965][ T1356] [<0000000000000000>] 0x0
[   62.550730][ T1356] CPU: 1 UID: 0 PID: 1356 Comm: kworker/u8:7 Tainted: =
G        W          6.12.0-rc4-syzkaller-gc6d9e43954bf-dirty #0
[   62.563074][ T1356] Tainted: [W]=3DWARN
[   62.566885][ T1356] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[   62.576956][ T1356] Workqueue: events_unbound call_usermodehelper_exec_w=
ork
[   62.584103][ T1356] Call Trace:
[   62.587392][ T1356]  <TASK>
[   62.590335][ T1356]  dump_stack_lvl+0x116/0x1f0
[   62.595041][ T1356]  __might_resched+0x3c0/0x5e0
[   62.599838][ T1356]  ? __pfx___might_resched+0x10/0x10
[   62.605599][ T1356]  debug_check_no_obj_freed+0x1d9/0x620
[   62.611180][ T1356]  ? __pfx_debug_check_no_obj_freed+0x10/0x10
[   62.617279][ T1356]  ? find_held_lock+0x2d/0x110
[   62.622068][ T1356]  ? release_task+0xd24/0x1b00
[   62.626860][ T1356]  kmem_cache_free+0x27d/0x480
[   62.631646][ T1356]  ? __cleanup_sighand+0x73/0xa0
[   62.636613][ T1356]  __cleanup_sighand+0x73/0xa0
[   62.641397][ T1356]  release_task+0xd2c/0x1b00
[   62.646017][ T1356]  ? __pfx_release_task+0x10/0x10
[   62.651067][ T1356]  ? mark_held_locks+0x9f/0xe0
[   62.655952][ T1356]  wait_consider_task+0x1812/0x4100
[   62.661187][ T1356]  ? rcu_is_watching+0x12/0xc0
[   62.665972][ T1356]  ? __pfx_wait_consider_task+0x10/0x10
[   62.671565][ T1356]  ? do_wait+0x1e9/0x570
[   62.675838][ T1356]  __do_wait+0x744/0x890
[   62.680131][ T1356]  ? do_wait+0x1e9/0x570
[   62.684493][ T1356]  do_wait+0x219/0x570
[   62.688588][ T1356]  kernel_wait+0xa0/0x160
[   62.693208][ T1356]  ? __pfx_kernel_wait+0x10/0x10
[   62.698178][ T1356]  ? __pfx_child_wait_callback+0x10/0x10
[   62.703948][ T1356]  ? lock_acquire+0x2f/0xb0
[   62.708481][ T1356]  call_usermodehelper_exec_work+0xf1/0x170
[   62.714439][ T1356]  process_one_work+0x9c5/0x1ba0
[   62.719521][ T1356]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   62.725190][ T1356]  ? __pfx_process_one_work+0x10/0x10
[   62.730949][ T1356]  ? assign_work+0x1a0/0x250
[   62.735658][ T1356]  worker_thread+0x6c8/0xf00
[   62.740297][ T1356]  ? __kthread_parkme+0x148/0x220
[   62.745435][ T1356]  ? __pfx_worker_thread+0x10/0x10
[   62.750664][ T1356]  kthread+0x2c1/0x3a0
[   62.754751][ T1356]  ? _raw_spin_unlock_irq+0x23/0x50
[   62.759972][ T1356]  ? __pfx_kthread+0x10/0x10
[   62.764597][ T1356]  ret_from_fork+0x45/0x80
[   62.769132][ T1356]  ? __pfx_kthread+0x10/0x10
[   62.773833][ T1356]  ret_from_fork_asm+0x1a/0x30
[   62.779002][ T1356]  </TASK>
[   62.782387][   T29] audit: type=3D1400 audit(1729585852.429:111): avc:  =
denied  { mount } for  pid=3D2665 comm=3D"syz-executor" name=3D"/" dev=3D"p=
roc" ino=3D1 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:object_r=
:proc_t tclass=3Dfilesystem permissive=3D1
[   63.412330][ T2647] BUG: sleeping function called from invalid context a=
t lib/debugobjects.c:978
[   63.421682][ T2647] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 2647, name: syz-execprog
[   63.430982][ T2647] preempt_count: 1, expected: 0
[   63.435870][ T2647] RCU nest depth: 0, expected: 0
[   63.440891][ T2647] no locks held by syz-execprog/2647.
[   63.446309][ T2647] Preemption disabled at:
[   63.446326][ T2647] [<ffffffff86ef85c0>] schedule+0xe0/0x350
[   63.456663][ T2647] CPU: 0 UID: 0 PID: 2647 Comm: syz-execprog Tainted: =
G        W          6.12.0-rc4-syzkaller-gc6d9e43954bf-dirty #0
[   63.469062][ T2647] Tainted: [W]=3DWARN
[   63.472905][ T2647] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[   63.483092][ T2647] Call Trace:
[   63.486409][ T2647]  <TASK>
[   63.489380][ T2647]  dump_stack_lvl+0x16c/0x1f0
[   63.494153][ T2647]  __might_resched+0x3c0/0x5e0
[   63.498995][ T2647]  ? __pfx___might_resched+0x10/0x10
[   63.504347][ T2647]  debug_check_no_obj_freed+0x1d9/0x620
[   63.509957][ T2647]  ? page_ext_put+0x3e/0xd0
[   63.514521][ T2647]  ? __pfx_debug_check_no_obj_freed+0x10/0x10
[   63.520741][ T2647]  ? page_ext_put+0x48/0xd0
[   63.525322][ T2647]  free_unref_page+0x1cc/0xb50
[   63.530155][ T2647]  __mmdrop+0xd5/0x460
[   63.534294][ T2647]  finish_task_switch.isra.0+0x584/0xa40
[   63.539995][ T2647]  ? __switch_to+0x749/0x1180
[   63.544828][ T2647]  __schedule+0x1067/0x34b0
[   63.549406][ T2647]  ? __pfx___schedule+0x10/0x10
[   63.554322][ T2647]  ? schedule+0x298/0x350
[   63.558719][ T2647]  ? __pfx_lock_release+0x10/0x10
[   63.563806][ T2647]  ? trace_lock_acquire+0x14a/0x1d0
[   63.569156][ T2647]  ? lock_acquire+0x2f/0xb0
[   63.573822][ T2647]  ? schedule+0x1fd/0x350
[   63.578214][ T2647]  ? do_nanosleep+0x18a/0x510
[   63.583000][ T2647]  schedule+0xe7/0x350
[   63.587126][ T2647]  do_nanosleep+0x216/0x510
[   63.591767][ T2647]  ? __pfx___debug_object_init+0x10/0x10
[   63.597475][ T2647]  ? __pfx_do_nanosleep+0x10/0x10
[   63.602559][ T2647]  ? __asan_memset+0x23/0x50
[   63.607303][ T2647]  ? __hrtimer_init+0x106/0x2c0
[   63.612237][ T2647]  hrtimer_nanosleep+0x146/0x370
[   63.617262][ T2647]  ? __pfx_hrtimer_nanosleep+0x10/0x10
[   63.622788][ T2647]  ? __pfx_hrtimer_wakeup+0x10/0x10
[   63.628143][ T2647]  ? __pfx_get_timespec64+0x10/0x10
[   63.633406][ T2647]  ? __x64_sys_futex+0x1e1/0x4c0
[   63.638398][ T2647]  ? __x64_sys_futex+0x1ea/0x4c0
[   63.643396][ T2647]  __x64_sys_nanosleep+0x21d/0x2b0
[   63.648582][ T2647]  ? __pfx___x64_sys_nanosleep+0x10/0x10
[   63.654297][ T2647]  do_syscall_64+0xcd/0x250
[   63.658881][ T2647]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   63.664844][ T2647] RIP: 0033:0x475d57
[   63.668792][ T2647] Code: 8b 44 24 20 b9 40 42 0f 00 f7 f1 48 89 04 24 b=
8 e8 03 00 00 f7 e2 48 89 44 24 08 48 89 e7 be 00 00 00 00 b8 23 00 00 00 0=
f 05 <48> 83 c4 10 5d c3 cc cc cc b8 ba 00 00 00 0f 05 89 44 24 08 c3 cc
[   63.688549][ T2647] RSP: 002b:000000c00005ff18 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000023
[   63.697029][ T2647] RAX: ffffffffffffffda RBX: 0000000000002710 RCX: 000=
0000000475d57
[   63.705056][ T2647] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
000c00005ff18
[   63.713088][ T2647] RBP: 000000c00005ff28 R08: 0000000000001c52 R09: 000=
07ffad9faf080
[   63.721114][ T2647] R10: 0000000000000001 R11: 0000000000000202 R12: 000=
000c00005ff18
[   63.729176][ T2647] R13: 000000c00007c008 R14: 000000c000006540 R15: 0ff=
fffffffffffff
[   63.737225][ T2647]  </TASK>


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.22.7'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1854706326=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at cd6fc0a301
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dcd6fc0a3018e5d793bdcca6530622493f5e88307 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241018-123137'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"cd6fc0a3018e5d793bdcca6530622493f5=
e88307\"
/usr/bin/ld: /tmp/ccRbnj4N.o: in function `test_cover_filter()':
executor.cc:(.text+0x1424b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccRbnj4N.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D17f28a5f980000


Tested on:

commit:         c6d9e439 Merge 6.12-rc4 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.=
git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4a2bb21f91d75c6=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da234c2d63e0c171ca=
10e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13a390a79800=
00


