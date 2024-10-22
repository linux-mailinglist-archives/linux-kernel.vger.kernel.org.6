Return-Path: <linux-kernel+bounces-375968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FEC9A9DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753011F22D96
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA5194C9E;
	Tue, 22 Oct 2024 09:11:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1414B092
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588267; cv=none; b=ghajLQTaDzIdgvPBNXlJE9K6Jjtxzftgz0nlwhI7ScblHQPPI9SvaJsqNh1BCVYYshRxOOWsIiYbj5kfHclzpnmBadonwj2prtBcC2XIQjmoYVlVdfM9qOdw1QHKAfYXKxU1n6P5IZRJJ9nUFLcyvtK0//BdyTJtgTQqrdJbpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588267; c=relaxed/simple;
	bh=fVir4RupEiogdLAWJ6roLTRnecFEIeMgaKAQHMCB8ro=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pUY8VARNBxMwpNHjsWj7Sy2D0cZVYIHc//SmLBhaP6j5i7Ue+6z0hRYR68dJOLalP5KqU/X8EwpNtPN9AqEK9Bddb8dB3kbnsR1KhwJ/Qys0w0lFBxNs085pfpCbDvGkf1N5n0zJRRqUm6/XqAc3yvzhZ/HzU4fFjoc/BAfKWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ae775193so54126005ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588264; x=1730193064;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVI9rJKg+9HCnfgxADVe+7vFneV0nJDwC6aRzltn5Gg=;
        b=C8gzbHKBjl5ZHNSPYgtZCrCIZDLOovL295U+EoUg1uFuQ3zCdK5ruxoYqQZKg4Prfb
         4IV0rcR4KsWtnwNvdRw+kZwUPttAw1BfpwWzTYh2epRREkdC6F6tXuD0P527Cbtm2aEl
         UvUor+qLbp0rIvVPftimY70dE8T6W/j2fV694YP86advj/XBvd7TDZoZ53NZY6tY04Ic
         ORkqwLumNODxwh6U1fEv49v8FHu/IU325zVBDPN+HviJxK2QwifOYC98OLsDwrjbpbTU
         RAhthFmScm+Yb7y1TcPCgjca3FttUrqTRHt/rZABQvQyZC8RI1hemdJhm6/3k+6rvBi8
         mo1A==
X-Forwarded-Encrypted: i=1; AJvYcCU00dyVz/+L1vHzkItEzNJVF6k0B/FSXEnOE3m9wyqCDyswuBgs0yMjegL4gj8QAtT/3veex+CPs1HxfDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmHsddJ+VnQGJAES67KENdi/ue+XD6TfUHY0k/+27IP8don3K
	6AGxnhFSPBetpb1srPbGs+tqN0F5jgiJ+4ewqVP0Jt7J7HrvHYxLaOn4zZLSw2Nyv+ghfKD/Kr8
	zfot8Dzv1IQXNbag+rGZ4ugg7UWrj6ji6eUwY0GtNw/Tuz40CouSz5Ok=
X-Google-Smtp-Source: AGHT+IGy/IExqsal2sRybCVyodzxdb9wUJUua8IEZ+sEX8113oYd8BC4NKfdJSnF7Jwb7nxW+iwK3agYfS83wRkBDzIkzE/Fud90
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd83:0:b0:3a3:983a:874f with SMTP id
 e9e14a558f8ab-3a3f406fe3cmr121096485ab.12.1729588264315; Tue, 22 Oct 2024
 02:11:04 -0700 (PDT)
Date: Tue, 22 Oct 2024 02:11:04 -0700
In-Reply-To: <tencent_C037D4960236004B087403760766583DD909@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67176c28.050a0220.10f4f4.0116.GAE@google.com>
Subject: Re: [syzbot] [serial?] BUG: soft lockup in debug_check_no_obj_freed
From: syzbot <syzbot+a234c2d63e0c171ca10e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

dm_r:sysadm_t tcontext=3Dsystem_u:object_r:nsfs_t tclass=3Dfile permissive=
=3D1
[   48.861396][ T2667] BUG: sleeping function called from invalid context a=
t lib/debugobjects.c:980
[   48.877826][ T2667] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 2667, name: syz-executor
[   48.890544][ T2667] preempt_count: 1, expected: 0
[   48.898231][ T2667] RCU nest depth: 0, expected: 0
[   48.904686][ T2667] 4 locks held by syz-executor/2667:
[   48.911218][ T2667]  #0: ffff888114445278 (&type->i_mutex_dir_key#3){+++=
+}-{3:3}, at: do_lock_mount+0xb0/0x5b0
[   48.924655][ T2667]  #1: ffffffff89081290 (namespace_sem){++++}-{3:3}, a=
t: do_lock_mount+0xfc/0x5b0
[   48.935892][ T2667]  #2: ffffffff88c147d0 (mount_lock){+.+.}-{2:2}, at: =
attach_recursive_mnt+0x3c2/0x1390
[   48.948526][ T2667]  #3: ffffffff88c14788 (mount_lock.seqcount){+.+.}-{0=
:0}, at: graft_tree+0x189/0x210
[   48.960552][ T2667] Preemption disabled at:
[   48.960567][ T2667] [<0000000000000000>] 0x0
[   48.970864][ T2667] CPU: 0 UID: 0 PID: 2667 Comm: syz-executor Tainted: =
G        W          6.12.0-rc4-syzkaller-gc6d9e43954bf-dirty #0
[   48.985996][ T2667] Tainted: [W]=3DWARN
[   48.991724][ T2667] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[   49.005223][ T2667] Call Trace:
[   49.008776][ T2667]  <TASK>
[   49.012127][ T2667]  dump_stack_lvl+0x16c/0x1f0
[   49.018075][ T2667]  __might_resched+0x3c0/0x5e0
[   49.023869][ T2667]  ? __pfx___might_resched+0x10/0x10
[   49.029728][ T2667]  ? __pfx___lock_acquire+0x10/0x10
[   49.036238][ T2667]  debug_check_no_obj_freed+0x53c/0x630
[   49.043451][ T2667]  ? lock_acquire.part.0+0x11b/0x380
[   49.049655][ T2667]  ? find_held_lock+0x2d/0x110
[   49.054935][ T2667]  ? __pfx_debug_check_no_obj_freed+0x10/0x10
[   49.061395][ T2667]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   49.067070][ T2667]  ? lock_acquire+0x2f/0xb0
[   49.072430][ T2667]  kfree+0x294/0x480
[   49.077721][ T2667]  ? dput_to_list+0xcb/0x620
[   49.083416][ T2667]  ? attach_recursive_mnt+0x81e/0x1390
[   49.089902][ T2667]  attach_recursive_mnt+0x81e/0x1390
[   49.096318][ T2667]  ? __pfx_attach_recursive_mnt+0x10/0x10
[   49.102547][ T2667]  ? do_raw_spin_lock+0x12d/0x2c0
[   49.108084][ T2667]  ? rcu_is_watching+0x12/0xc0
[   49.113238][ T2667]  ? kfree+0x255/0x480
[   49.117674][ T2667]  ? lockref_get+0x15/0x50
[   49.122409][ T2667]  graft_tree+0x189/0x210
[   49.127635][ T2667]  do_add_mount+0x1ca/0x320
[   49.132594][ T2667]  path_mount+0x1a55/0x1f20
[   49.137597][ T2667]  ? kmem_cache_free+0x133/0x480
[   49.142592][ T2667]  ? __pfx_path_mount+0x10/0x10
[   49.148066][ T2667]  ? putname+0x12e/0x170
[   49.152345][ T2667]  __x64_sys_mount+0x294/0x320
[   49.157339][ T2667]  ? __pfx___x64_sys_mount+0x10/0x10
[   49.162856][ T2667]  do_syscall_64+0xcd/0x250
[   49.167666][ T2667]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   49.173754][ T2667] RIP: 0033:0x7fa944d2f79a
[   49.178378][ T2667] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1=
a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
[   49.199423][ T2667] RSP: 002b:00007fffc0b53128 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000a5
[   49.207960][ T2667] RAX: ffffffffffffffda RBX: 00007fa944da0685 RCX: 000=
07fa944d2f79a
[   49.216037][ T2667] RDX: 00007fa944db1e82 RSI: 00007fa944da0685 RDI: 000=
07fa944dd6142
[   49.224417][ T2667] RBP: 00007fffc0b531c0 R08: 0000000000000000 R09: 000=
0000000000000
[   49.232670][ T2667] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07fffc0b531c0
[   49.241111][ T2667] R13: 00007fffc0b531c8 R14: 0000000000000009 R15: 000=
0000000000000
[   49.250017][ T2667]  </TASK>
[   49.276465][   T29] audit: type=3D1400 audit(1729588219.617:104): avc:  =
denied  { open } for  pid=3D2667 comm=3D"syz-executor" path=3D"net:[4026531=
840]" dev=3D"nsfs" ino=3D4026531840 scontext=3Droot:sysadm_r:sysadm_t tcont=
ext=3Dsystem_u:object_r:nsfs_t tclass=3Dfile permissive=3D1
[   49.306676][   T29] audit: type=3D1400 audit(1729588219.617:105): avc:  =
denied  { mounton } for  pid=3D2667 comm=3D"syz-executor" path=3D"/" dev=3D=
"sda1" ino=3D2 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:object=
_r:root_t tclass=3Ddir permissive=3D1
[   49.330945][   T29] audit: type=3D1400 audit(1729588219.667:106): avc:  =
denied  { create } for  pid=3D2664 comm=3D"syz-executor" scontext=3Droot:sy=
sadm_r:sysadm_t tcontext=3Droot:sysadm_r:sysadm_t tclass=3Duser_namespace p=
ermissive=3D1
[   49.369864][   T29] audit: type=3D1400 audit(1729588219.667:107): avc:  =
denied  { sys_admin } for  pid=3D2664 comm=3D"syz-executor" capability=3D21=
  scontext=3Droot:sysadm_r:sysadm_t tcontext=3Droot:sysadm_r:sysadm_t tclas=
s=3Dcap_userns permissive=3D1
[   49.394939][   T29] audit: type=3D1400 audit(1729588219.677:108): avc:  =
denied  { mounton } for  pid=3D2667 comm=3D"syz-executor" path=3D"/root/syz=
kaller.BUEqlw/syz-tmp" dev=3D"sda1" ino=3D1945 scontext=3Droot:sysadm_r:sys=
adm_t tcontext=3Droot:object_r:user_home_t tclass=3Ddir permissive=3D1
[   49.436103][   T29] audit: type=3D1400 audit(1729588219.677:109): avc:  =
denied  { mount } for  pid=3D2667 comm=3D"syz-executor" name=3D"/" dev=3D"t=
mpfs" ino=3D1 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:object_=
r:tmpfs_t tclass=3Dfilesystem permissive=3D1
[   49.468685][   T29] audit: type=3D1400 audit(1729588220.087:110): avc:  =
denied  { mounton } for  pid=3D2670 comm=3D"syz-executor" path=3D"/root/syz=
kaller.Oc9e9i/syz-tmp/newroot/dev" dev=3D"tmpfs" ino=3D3 scontext=3Droot:sy=
sadm_r:sysadm_t tcontext=3Droot:object_r:user_tmpfs_t tclass=3Ddir permissi=
ve=3D1
[   49.528778][ T2670] soft_limit_in_bytes is deprecated and will be remove=
d. Please report your usecase to linux-mm@kvack.org if you depend on this f=
unctionality.
[   49.556665][   T29] audit: type=3D1400 audit(1729588220.097:111): avc:  =
denied  { mount } for  pid=3D2670 comm=3D"syz-executor" name=3D"/" dev=3D"p=
roc" ino=3D1 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:object_r=
:proc_t tclass=3Dfilesystem permissive=3D1
[   49.879856][ T2694] BUG: sleeping function called from invalid context a=
t lib/debugobjects.c:980
[   49.889038][ T2694] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 2694, name: syz-executor
[   49.898916][ T2694] preempt_count: 1, expected: 0
[   49.903970][ T2694] RCU nest depth: 0, expected: 0
[   49.909388][ T2694] 4 locks held by syz-executor/2694:
[   49.916059][ T2694]  #0: ffff888114446fe8 (&type->i_mutex_dir_key#3){+++=
+}-{3:3}, at: do_lock_mount+0xb0/0x5b0
[   49.927597][ T2694]  #1: ffffffff89081290 (namespace_sem){++++}-{3:3}, a=
t: do_lock_mount+0xfc/0x5b0
[   49.938187][ T2694]  #2: ffffffff88c147d0 (mount_lock){+.+.}-{2:2}, at: =
attach_recursive_mnt+0x3c2/0x1390
[   49.950112][ T2694]  #3: ffffffff88c14788 (mount_lock.seqcount){+.+.}-{0=
:0}, at: graft_tree+0x189/0x210
[   49.961153][ T2694] Preemption disabled at:
[   49.961167][ T2694] [<0000000000000000>] 0x0
[   49.971018][ T2694] CPU: 0 UID: 0 PID: 2694 Comm: syz-executor Tainted: =
G        W          6.12.0-rc4-syzkaller-gc6d9e43954bf-dirty #0
[   49.983652][ T2694] Tainted: [W]=3DWARN
[   49.988417][ T2694] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[   50.001247][ T2694] Call Trace:
[   50.006329][ T2694]  <TASK>
[   50.009559][ T2694]  dump_stack_lvl+0x16c/0x1f0
[   50.015178][ T2694]  __might_resched+0x3c0/0x5e0
[   50.020783][ T2694]  ? __pfx___might_resched+0x10/0x10
[   50.026571][ T2694]  ? __pfx___lock_acquire+0x10/0x10
[   50.032495][ T2694]  debug_check_no_obj_freed+0x53c/0x630
[   50.038401][ T2694]  ? lock_acquire.part.0+0x11b/0x380
[   50.043967][ T2694]  ? find_held_lock+0x2d/0x110
[   50.049009][ T2694]  ? __pfx_debug_check_no_obj_freed+0x10/0x10
[   50.056534][ T2694]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   50.063524][ T2694]  ? lock_acquire+0x2f/0xb0
[   50.069512][ T2694]  kfree+0x294/0x480
[   50.073942][ T2694]  ? dput_to_list+0xcb/0x620
[   50.078993][ T2694]  ? attach_recursive_mnt+0x81e/0x1390
[   50.084650][ T2694]  attach_recursive_mnt+0x81e/0x1390
[   50.090375][ T2694]  ? __pfx_attach_recursive_mnt+0x10/0x10
[   50.096406][ T2694]  ? do_raw_spin_lock+0x12d/0x2c0
[   50.101639][ T2694]  ? rcu_is_watching+0x12/0xc0
[   50.107048][ T2694]  ? kfree+0x255/0x480
[   50.111527][ T2694]  ? lockref_get+0x15/0x50
[   50.116322][ T2694]  graft_tree+0x189/0x210
[   50.120999][ T2694]  do_add_mount+0x1ca/0x320
[   50.125642][ T2694]  path_mount+0x1a55/0x1f20
[   50.130719][ T2694]  ? kmem_cache_free+0x133/0x480
[   50.136047][ T2694]  ? __pfx_path_mount+0x10/0x10
[   50.141031][ T2694]  ? putname+0x12e/0x170
[   50.145439][ T2694]  __x64_sys_mount+0x294/0x320
[   50.150405][ T2694]  ? __pfx___x64_sys_mount+0x10/0x10
[   50.155833][ T2694]  do_syscall_64+0xcd/0x250
[   50.160621][ T2694]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   50.166720][ T2694] RIP: 0033:0x7f0800fbf79a
[   50.171157][ T2694] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1=
a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
[   50.192471][ T2694] RSP: 002b:00007fffa61824c8 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000a5
[   50.201814][ T2694] RAX: ffffffffffffffda RBX: 00007f0801030685 RCX: 000=
07f0800fbf79a
[   50.210350][ T2694] RDX: 00007f0801041e82 RSI: 00007f0801030685 RDI: 000=
07f0801066142
[   50.218627][ T2694] RBP: 00007fffa6182560 R08: 0000000000000000 R09: 000=
0000000000000
[   50.226813][ T2694] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07fffa6182560
[   50.235377][ T2694] R13: 00007fffa6182568 R14: 0000000000000009 R15: 000=
0000000000000
[   50.244127][ T2694]  </TASK>
[   50.896859][ T2653] BUG: sleeping function called from invalid context a=
t lib/debugobjects.c:980
[   50.907013][ T2653] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pi=
d: 2653, name: syz-executor
[   50.916798][ T2653] preempt_count: 1, expected: 0
[   50.922192][ T2653] RCU nest depth: 0, expected: 0
[   50.927337][ T2653] 1 lock held by syz-executor/2653:
[   50.932920][ T2653]  #0: ffffffff88c0a098 (tasklist_lock){.+.+}-{2:2}, a=
t: release_task+0x20c/0x1b00
[   50.942394][ T2653] irq event stamp: 270764
[   50.946827][ T2653] hardirqs last  enabled at (270763): [<ffffffff86f0d6=
33>] _raw_spin_unlock_irq+0x23/0x50
[   50.957663][ T2653] hardirqs last disabled at (270764): [<ffffffff86f0da=
65>] _raw_write_lock_irq+0x45/0x50
[   50.967761][ T2653] softirqs last  enabled at (270736): [<ffffffff861312=
d8>] tcp_sendmsg+0x38/0x50
[   50.977328][ T2653] softirqs last disabled at (270734): [<ffffffff85d196=
9b>] __release_sock+0x28b/0x400
[   50.987418][ T2653] Preemption disabled at:
[   50.987427][ T2653] [<0000000000000000>] 0x0
[   50.996480][ T2653] CPU: 0 UID: 0 PID: 2653 Comm: syz-executor Tainted: =
G        W          6.12.0-rc4-syzkaller-gc6d9e43954bf-dirty #0
[   51.009719][ T2653] Tainted: [W]=3DWARN
[   51.013983][ T2653] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[   51.024137][ T2653] Call Trace:
[   51.027455][ T2653]  <TASK>
[   51.030617][ T2653]  dump_stack_lvl+0x116/0x1f0
[   51.035498][ T2653]  __might_resched+0x3c0/0x5e0
[   51.040663][ T2653]  ? __pfx___might_resched+0x10/0x10
[   51.046499][ T2653]  debug_check_no_obj_freed+0x53c/0x630
[   51.052798][ T2653]  ? __pfx_debug_check_no_obj_freed+0x10/0x10
[   51.059186][ T2653]  ? find_held_lock+0x2d/0x110
[   51.065306][ T2653]  ? release_task+0xd24/0x1b00
[   51.071852][ T2653]  kmem_cache_free+0x27d/0x480
[   51.076943][ T2653]  ? __cleanup_sighand+0x73/0xa0
[   51.082519][ T2653]  __cleanup_sighand+0x73/0xa0
[   51.087562][ T2653]  release_task+0xd2c/0x1b00
[   51.093620][ T2653]  ? __pfx_release_task+0x10/0x10
[   51.098928][ T2653]  ? trace_lock_acquire+0x14a/0x1d0
[   51.104523][ T2653]  wait_consider_task+0x1812/0x4100
[   51.109776][ T2653]  ? rcu_is_watching+0x12/0xc0
[   51.115012][ T2653]  ? __pfx_wait_consider_task+0x10/0x10
[   51.120889][ T2653]  ? do_wait+0x1e9/0x570
[   51.125215][ T2653]  __do_wait+0x744/0x890
[   51.129478][ T2653]  ? do_wait+0x1e9/0x570
[   51.133950][ T2653]  do_wait+0x219/0x570
[   51.138247][ T2653]  kernel_wait4+0x16c/0x280
[   51.142849][ T2653]  ? __pfx_kernel_wait4+0x10/0x10
[   51.147984][ T2653]  ? __pfx_child_wait_callback+0x10/0x10
[   51.153757][ T2653]  __do_sys_wait4+0x15f/0x170
[   51.158549][ T2653]  ? __pfx___do_sys_wait4+0x10/0x10
[   51.163781][ T2653]  do_syscall_64+0xcd/0x250
[   51.168601][ T2653]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   51.174804][ T2653] RIP: 0033:0x7fd1d73a4213
[   51.179334][ T2653] Code: 00 00 0f 1f 44 00 00 31 c9 e9 09 00 00 00 66 0=
f 1f 84 00 00 00 00 00 80 3d 31 83 19 00 00 49 89 ca 74 14 b8 3d 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 5d c3 0f 1f 40 00 48 83 ec 28 89 54 24 14 48
[   51.199767][ T2653] RSP: 002b:00007ffeeea6b488 EFLAGS: 00000202 ORIG_RAX=
: 000000000000003d
[   51.209094][ T2653] RAX: ffffffffffffffda RBX: 000055559498b650 RCX: 000=
07fd1d73a4213
[   51.217993][ T2653] RDX: 0000000040000000 RSI: 00007ffeeea6b49c RDI: 000=
0000000000a67
[   51.227133][ T2653] RBP: 000055559498c030 R08: 0000000000000007 R09: 000=
055559498bdc0
[   51.235697][ T2653] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
07ffeeea6b49c
[   51.243852][ T2653] R13: 0000555594998340 R14: 0000000000000004 R15: 000=
055559498b650
[   51.253794][ T2653]  </TASK>


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
 -ffile-prefix-map=3D/tmp/go-build162586199=3D/tmp/go-build -gno-record-gcc=
-switches'

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
/usr/bin/ld: /tmp/cc2MMZ1Z.o: in function `test_cover_filter()':
executor.cc:(.text+0x1424b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/cc2MMZ1Z.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D109ac640580000


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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D111102879800=
00


