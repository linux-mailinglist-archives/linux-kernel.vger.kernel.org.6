Return-Path: <linux-kernel+bounces-436196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600179E825D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94E118835F5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83671547E3;
	Sat,  7 Dec 2024 21:48:30 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58C28F5
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733608108; cv=none; b=fv8SuB8wstRhH5i9uxjhLau4V86SHzsEdToiimUtFna5wZfT3JqH4Q+/zuzFNdPqKzDeTZFjf94goOGzAcZx9qw534VZHrsMwhTlStVQ2bsviR6rRf98ZeCpy4xGkXKaPpxzRRfQK6M/kscMp5nKp1rbDxcTjOGfva42qdaY95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733608108; c=relaxed/simple;
	bh=zJUiTusf3xqxetP2HV8I83JAzf8QO4pTB4TgoLEMCqc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=llUD6Oq8kWh9U6yb2+3eGh829RhjRfwE7TnKM+U3QELHfESv/TmN4TwN4QRrMaQu7EALuvLFZxT9M1pMejbZduqv06QkTHiRDm6wEcFK9RzK0nPViwB0Ehtf01zPXs+hg71SuKxwzAcaAnHBJSeHpQyjWCBNK+9duvfh457kLHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-843eac1b9dbso291495139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 13:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733608103; x=1734212903;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZqEYSayk1a1dvyybsLY4vTX3BHy9erBRqGF2q30faI=;
        b=bF0OMtuDvHdMy64lNSydR5ZQtlL8mDoHXxTBCaGPWWMJ1TkGfAmqMBAC0he1DBO/QT
         QcDTtSHflCetYizVVU6qlFDlyU4KPNIvtnoUSEMkN2QxopxwN6YFfn6a1HsUS/VkxmnU
         pyBKP8kqp7BVmRXsJsp+w1aruJvlE8wdoR+XjTpOSkbqBz2i0loLwEr/JonSVegwXvq7
         /u5BGhG6tVLDHsZCcU42c3ZvkuRkmITjxtqXOhxDUgvWwA3AMf6XJDwlOlc2Ve6pYAgT
         uZOm5k4FqQqzcSR4U9KMjxwSy6d3phQxvYUv5pKG13vOmj8fs/h5pWg7BugUgwNt/45c
         6rUA==
X-Forwarded-Encrypted: i=1; AJvYcCUwWbl15O6ZCFyM89QGpjCRrYWJFVM3gK4C5wwiTTUoYo3pdisiVtifrgFofslfyQsttQqNbN1TNg+BsQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxybrKHbnexDWfwWJXtTq2rX9xkP2ZH3pm9lmOfm9w63+Ql9V+a
	fJXj74xrJs2V1Ws5HDCQNO54J1b5L/Ob0/+L0Y+fY7UL383TsgkjpXH50h3rWzmBQ5q4Iq/HMfv
	G4cjThVAbOfkXg+4qwEB1AtSjI9gL2wABDw+bARaUJNPPJPN+JTC5I+Q=
X-Google-Smtp-Source: AGHT+IFSCaP0kV7PncjIPfb7C6yUyvx8bpa4VqwpkdlS8G6FVBGrV83BSym6nHExIwZ6nI4cfyeHOuPOE8gK1FfvvbAy/QADGZaR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1706:b0:3a7:d792:d6c0 with SMTP id
 e9e14a558f8ab-3a811e81049mr99513025ab.20.1733608103529; Sat, 07 Dec 2024
 13:48:23 -0800 (PST)
Date: Sat, 07 Dec 2024 13:48:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6754c2a7.050a0220.a30f1.0168.GAE@google.com>
Subject: [syzbot] [mm?] WARNING: locking bug in on
From: syzbot <syzbot+26b2a1ac5eece2ea324f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    ceb8bf2ceaa7 module: Convert default symbol namespace to s.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D101fc330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6851fe4f6179203=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D26b2a1ac5eece2ea3=
24f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3cb9d026761/disk-=
ceb8bf2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e58198dd5761/vmlinux-=
ceb8bf2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04f343f707ca/bzI=
mage-ceb8bf2c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+26b2a1ac5eece2ea324f@syzkaller.appspotmail.com

Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received N[  69=
7.904801][    C1]=20
ULL device
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: l[  697.913199][    C1] =
[ BUG: Invalid wait context ]
ibudev: received[  697.913208][    C1] 6.13.0-rc1-syzkaller-00005-gceb8bf2c=
eaa7 #0 Not tainted
 NULL device
De[  697.913219][    C1] -----------------------------
c  4 01:13:29 sy[  697.913227][    C1] syz.0.4450/18007 is trying to lock:
zkaller daemon.e[  697.913237][    C1] ffff88813fffc298 (&zone->lock){-.-.}=
-{3:3}, at: rmqueue_bulk mm/page_alloc.c:2307 [inline]
zkaller daemon.e[  697.913237][    C1] ffff88813fffc298 (&zone->lock){-.-.}=
-{3:3}, at: __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
rr dhcpcd[5484]:[  697.913282][    C1] other info that might help us debug =
this:
 libudev: receiv[  697.913286][    C1] context-{2:2}
ed NULL device
Dec  4 01:13:29 [  697.913303][    C1]  #0: ffff8880b8744c58 (&pcp->lock){+=
.+.}-{3:3}, at: spin_trylock include/linux/spinlock.h:361 [inline]
Dec  4 01:13:29 [  697.913303][    C1]  #0: ffff8880b8744c58 (&pcp->lock){+=
.+.}-{3:3}, at: rmqueue_pcplist mm/page_alloc.c:3030 [inline]
Dec  4 01:13:29 [  697.913303][    C1]  #0: ffff8880b8744c58 (&pcp->lock){+=
.+.}-{3:3}, at: rmqueue mm/page_alloc.c:3074 [inline]
Dec  4 01:13:29 [  697.913303][    C1]  #0: ffff8880b8744c58 (&pcp->lock){+=
.+.}-{3:3}, at: get_page_from_freelist+0x350/0x2f80 mm/page_alloc.c:3471
syzkaller daemon[  697.913344][    C1] stack backtrace:
.err dhcpcd[5484[  697.913350][    C1] CPU: 1 UID: 0 PID: 18007 Comm: syz.0=
.4450 Not tainted 6.13.0-rc1-syzkaller-00005-gceb8bf2ceaa7 #0
]: libudev: rece[  697.913369][    C1] Hardware name: Google Google Compute=
 Engine/Google Compute Engine, BIOS Google 09/13/2024
ived NULL device[  697.913378][    C1] Call Trace:

Dec  4 01:13:2[  697.913384][    C1]  <TASK>
9 syzkaller daem[  697.913390][    C1]  __dump_stack lib/dump_stack.c:94 [i=
nline]
9 syzkaller daem[  697.913390][    C1]  dump_stack_lvl+0x116/0x1f0 lib/dump=
_stack.c:120
on.err dhcpcd[54[  697.913413][    C1]  print_lock_invalid_wait_context ker=
nel/locking/lockdep.c:4826 [inline]
on.err dhcpcd[54[  697.913413][    C1]  check_wait_context kernel/locking/l=
ockdep.c:4898 [inline]
on.err dhcpcd[54[  697.913413][    C1]  __lock_acquire+0x878/0x3c40 kernel/=
locking/lockdep.c:5176
84]: libudev: re[  697.913436][    C1]  ? instrument_atomic_read include/li=
nux/instrumented.h:68 [inline]
84]: libudev: re[  697.913436][    C1]  ? _test_bit include/asm-generic/bit=
ops/instrumented-non-atomic.h:141 [inline]
84]: libudev: re[  697.913436][    C1]  ? hlock_class+0x4e/0x130 kernel/loc=
king/lockdep.c:228
ceived NULL devi[  697.913457][    C1]  ? mark_lock+0xb5/0xc60 kernel/locki=
ng/lockdep.c:4727
ce
Dec  4 01:13[  697.913473][    C1]  ? __pfx___lock_acquire+0x10/0x10 kernel=
/locking/lockdep.c:4387
:29 syzkaller da[  697.913491][    C1]  ? __pfx_mark_lock+0x10/0x10 kernel/=
locking/lockdep.c:232
emon.err dhcpcd[[  697.913509][    C1]  lock_acquire.part.0+0x11b/0x380 ker=
nel/locking/lockdep.c:5849
5484]: libudev: [  697.913526][    C1]  ? rmqueue_bulk mm/page_alloc.c:2307=
 [inline]
5484]: libudev: [  697.913526][    C1]  ? __rmqueue_pcplist+0x6bb/0x1600 mm=
/page_alloc.c:3001
received NULL de[  697.913545][    C1]  ? __pfx_lock_acquire.part.0+0x10/0x=
10 kernel/locking/lockdep.c:122
vice
Dec  4 01:[  697.913564][    C1]  ? rcu_is_watching_curr_cpu include/linux/=
context_tracking.h:128 [inline]
Dec  4 01:[  697.913564][    C1]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tr=
ee.c:737
13:29 syzkaller [  697.913585][    C1]  ? trace_lock_acquire+0x14e/0x1f0 in=
clude/trace/events/lock.h:24
daemon.err dhcpc[  697.913608][    C1]  ? rmqueue_bulk mm/page_alloc.c:2307=
 [inline]
daemon.err dhcpc[  697.913608][    C1]  ? __rmqueue_pcplist+0x6bb/0x1600 mm=
/page_alloc.c:3001
d[5484]: libudev[  697.913625][    C1]  ? lock_acquire+0x2f/0xb0 kernel/loc=
king/lockdep.c:5820
: received NULL [  697.913641][    C1]  ? rmqueue_bulk mm/page_alloc.c:2307=
 [inline]
: received NULL [  697.913641][    C1]  ? __rmqueue_pcplist+0x6bb/0x1600 mm=
/page_alloc.c:3001
device
Dec  4 0[  697.913659][    C1]  __raw_spin_lock_irqsave include/linux/spinl=
ock_api_smp.h:110 [inline]
Dec  4 0[  697.913659][    C1]  _raw_spin_lock_irqsave+0x3a/0x60 kernel/loc=
king/spinlock.c:162
1:13:29 syzkalle[  697.913677][    C1]  ? rmqueue_bulk mm/page_alloc.c:2307=
 [inline]
1:13:29 syzkalle[  697.913677][    C1]  ? __rmqueue_pcplist+0x6bb/0x1600 mm=
/page_alloc.c:3001
r daemon.err dhc[  697.913699][    C1]  rmqueue_bulk mm/page_alloc.c:2307 [=
inline]
r daemon.err dhc[  697.913699][    C1]  __rmqueue_pcplist+0x6bb/0x1600 mm/p=
age_alloc.c:3001
pcd[5484]: libud[  697.913718][    C1]  ? __pfx_lock_acquire.part.0+0x10/0x=
10 kernel/locking/lockdep.c:122
ev: received NUL[  697.913736][    C1]  ? rcu_is_watching_curr_cpu include/=
linux/context_tracking.h:128 [inline]
ev: received NUL[  697.913736][    C1]  ? rcu_is_watching+0x12/0xc0 kernel/=
rcu/tree.c:737
L device
Dec  4[  697.913757][    C1]  ? trace_lock_acquire+0x14e/0x1f0 include/trac=
e/events/lock.h:24
 01:13:29 syzkal[  697.913778][    C1]  ? instrument_atomic_read_write incl=
ude/linux/instrumented.h:96 [inline]
 01:13:29 syzkal[  697.913778][    C1]  ? atomic_try_cmpxchg_acquire includ=
e/linux/atomic/atomic-instrumented.h:1301 [inline]
 01:13:29 syzkal[  697.913778][    C1]  ? queued_spin_trylock include/asm-g=
eneric/qspinlock.h:97 [inline]
 01:13:29 syzkal[  697.913778][    C1]  ? do_raw_spin_trylock+0xb1/0x180 ke=
rnel/locking/spinlock_debug.c:123
ler daemon.err d[  697.913799][    C1]  ? __pfx___rmqueue_pcplist+0x10/0x10=
 mm/page_alloc.c:2005
hcpcd[5484]: lib[  697.913816][    C1]  ? lock_acquire+0x2f/0xb0 kernel/loc=
king/lockdep.c:5820
udev: received N[  697.913832][    C1]  ? spin_trylock include/linux/spinlo=
ck.h:361 [inline]
udev: received N[  697.913832][    C1]  ? rmqueue_pcplist mm/page_alloc.c:3=
030 [inline]
udev: received N[  697.913832][    C1]  ? rmqueue mm/page_alloc.c:3074 [inl=
ine]
udev: received N[  697.913832][    C1]  ? get_page_from_freelist+0x350/0x2f=
80 mm/page_alloc.c:3471
ULL device
Dec [  697.913853][    C1]  rmqueue_pcplist mm/page_alloc.c:3043 [inline]
Dec [  697.913853][    C1]  rmqueue mm/page_alloc.c:3074 [inline]
Dec [  697.913853][    C1]  get_page_from_freelist+0x3d2/0x2f80 mm/page_all=
oc.c:3471
 4 01:13:29 syzk[  697.913878][    C1]  ? __pfx_get_page_from_freelist+0x10=
/0x10 arch/x86/include/asm/atomic64_64.h:15
aller daemon.err[  697.913896][    C1]  ? should_fail_alloc_page+0xee/0x130=
 mm/fail_page_alloc.c:44
 dhcpcd[5484]: l[  697.913918][    C1]  ? prepare_alloc_pages.constprop.0+0=
x16f/0x560 mm/page_alloc.c:4512
ibudev: received[  697.913936][    C1]  __alloc_pages_noprof+0x223/0x25b0 m=
m/page_alloc.c:4751
 NULL device
De[  697.913955][    C1]  ? __pfx___lock_acquire+0x10/0x10 kernel/locking/l=
ockdep.c:4387
c  4 01:13:29 sy[  697.913971][    C1]  ? instrument_atomic_read include/li=
nux/instrumented.h:68 [inline]
c  4 01:13:29 sy[  697.913971][    C1]  ? _test_bit include/asm-generic/bit=
ops/instrumented-non-atomic.h:141 [inline]
c  4 01:13:29 sy[  697.913971][    C1]  ? hlock_class+0x4e/0x130 kernel/loc=
king/lockdep.c:228
zkaller daemon.e[  697.913992][    C1]  ? mark_lock+0xb5/0xc60 kernel/locki=
ng/lockdep.c:4727
rr dhcpcd[5484]:[  697.914008][    C1]  ? instrument_atomic_read include/li=
nux/instrumented.h:68 [inline]
rr dhcpcd[5484]:[  697.914008][    C1]  ? _test_bit include/asm-generic/bit=
ops/instrumented-non-atomic.h:141 [inline]
rr dhcpcd[5484]:[  697.914008][    C1]  ? hlock_class+0x4e/0x130 kernel/loc=
king/lockdep.c:228
 libudev: receiv[  697.914030][    C1]  ? __pfx___alloc_pages_noprof+0x10/0=
x10 mm/page_alloc.c:3519
ed NULL device
Dec  4 01:13:29 [  697.914071][    C1]  ? rcu_lock_release include/linux/rc=
update.h:347 [inline]
Dec  4 01:13:29 [  697.914071][    C1]  ? rcu_read_unlock include/linux/rcu=
pdate.h:880 [inline]
Dec  4 01:13:29 [  697.914071][    C1]  ? is_bpf_text_address+0x8a/0x1a0 ke=
rnel/bpf/core.c:770
syzkaller daemon[  697.914093][    C1]  ? lock_acquire+0x2f/0xb0 kernel/loc=
king/lockdep.c:5820
.err dhcpcd[5484[  697.914110][    C1]  ? rcu_lock_acquire include/linux/rc=
update.h:337 [inline]
.err dhcpcd[5484[  697.914110][    C1]  ? rcu_read_lock include/linux/rcupd=
ate.h:849 [inline]
.err dhcpcd[5484[  697.914110][    C1]  ? is_bpf_text_address+0x30/0x1a0 ke=
rnel/bpf/core.c:768
]: libudev: rece[  697.914127][    C1]  ? bpf_ksym_find+0x127/0x1c0 kernel/=
bpf/core.c:737
ived NULL device[  697.914148][    C1]  ? __sanitizer_cov_trace_switch+0x54=
/0x90 kernel/kcov.c:351

Dec  4 01:13:2[  697.914170][    C1]  ? policy_nodemask+0xea/0x4e0 mm/mempo=
licy.c:2086
9 syzkaller daem[  697.914190][    C1]  alloc_pages_mpol_noprof+0x2c9/0x610=
 mm/mempolicy.c:2265
on.err dhcpcd[54[  697.914213][    C1]  ? __pfx_alloc_pages_mpol_noprof+0x1=
0/0x10 include/linux/bitmap.h:409
84]: libudev: re[  697.914239][    C1]  stack_depot_save_flags+0x566/0x8f0 =
lib/stackdepot.c:627
ceived NULL devi[  697.914265][    C1]  ? __lock_acquire+0xcc5/0x3c40 kerne=
l/locking/lockdep.c:5223
ce
Dec  4 01:13[  697.914284][    C1]  kasan_save_stack+0x42/0x60 mm/kasan/com=
mon.c:48
:29 syzkaller da[  697.914301][    C1]  ? kasan_save_stack+0x33/0x60 mm/kas=
an/common.c:47
emon.err dhcpcd[[  697.914318][    C1]  ? __kasan_record_aux_stack+0xba/0xd=
0 mm/kasan/generic.c:544
5484]: libudev: [  697.914339][    C1]  ? task_work_add+0xc0/0x3b0 kernel/t=
ask_work.c:77
received NULL de[  697.914355][    C1]  ? __run_posix_cpu_timers kernel/tim=
e/posix-cpu-timers.c:1223 [inline]
received NULL de[  697.914355][    C1]  ? run_posix_cpu_timers+0x69f/0x7d0 =
kernel/time/posix-cpu-timers.c:1422
vice
Dec  4 01:[  697.914378][    C1]  ? update_process_times+0x1a1/0x2d0 kernel=
/time/timer.c:2526
13:29 syzkaller [  697.914398][    C1]  ? tick_sched_handle kernel/time/tic=
k-sched.c:276 [inline]
13:29 syzkaller [  697.914398][    C1]  ? tick_nohz_handler+0x376/0x530 ker=
nel/time/tick-sched.c:297
daemon.err dhcpc[  697.914419][    C1]  ? __run_hrtimer kernel/time/hrtimer=
.c:1739 [inline]
daemon.err dhcpc[  697.914419][    C1]  ? __hrtimer_run_queues+0x5fb/0xae0 =
kernel/time/hrtimer.c:1803
d[5484]: libudev[  697.914439][    C1]  ? hrtimer_interrupt+0x392/0x8e0 ker=
nel/time/hrtimer.c:1865
: received NULL [  697.914459][    C1]  ? local_apic_timer_interrupt arch/x=
86/kernel/apic/apic.c:1038 [inline]
: received NULL [  697.914459][    C1]  ? __sysvec_apic_timer_interrupt+0x1=
0f/0x400 arch/x86/kernel/apic/apic.c:1055
device
Dec  4 0[  697.914478][    C1]  ? instr_sysvec_apic_timer_interrupt arch/x8=
6/kernel/apic/apic.c:1049 [inline]
Dec  4 0[  697.914478][    C1]  ? sysvec_apic_timer_interrupt+0x52/0xc0 arc=
h/x86/kernel/apic/apic.c:1049
1:13:29 syzkalle[  697.914495][    C1]  ? asm_sysvec_apic_timer_interrupt+0=
x1a/0x20 arch/x86/include/asm/idtentry.h:702
r daemon.err dhc[  697.914529][    C1]  __kasan_record_aux_stack+0xba/0xd0 =
mm/kasan/generic.c:544
pcd[5484]: libud[  697.914552][    C1]  task_work_add+0xc0/0x3b0 kernel/tas=
k_work.c:77
ev: received NUL[  697.914568][    C1]  ? __pfx_task_work_add+0x10/0x10 ker=
nel/task_work.c:13
L device
Dec  4[  697.914584][    C1]  ? lock_acquire.part.0+0x11b/0x380 kernel/lock=
ing/lockdep.c:5849
 01:13:29 syzkal[  697.914601][    C1]  ? find_held_lock+0x2d/0x110 kernel/=
locking/lockdep.c:5339
ler daemon.err d[  697.914624][    C1]  __run_posix_cpu_timers kernel/time/=
posix-cpu-timers.c:1223 [inline]
ler daemon.err d[  697.914624][    C1]  run_posix_cpu_timers+0x69f/0x7d0 ke=
rnel/time/posix-cpu-timers.c:1422
hcpcd[5484]: lib[  697.914648][    C1]  ? __pfx_run_posix_cpu_timers+0x10/0=
x10 include/linux/task_work.h:13
udev: received N[  697.914673][    C1]  ? instrument_atomic_read include/li=
nux/instrumented.h:68 [inline]
udev: received N[  697.914673][    C1]  ? atomic_read include/linux/atomic/=
atomic-instrumented.h:32 [inline]
udev: received N[  697.914673][    C1]  ? nohz_balancer_kick kernel/sched/f=
air.c:12299 [inline]
udev: received N[  697.914673][    C1]  ? sched_balance_trigger+0x225/0xea0=
 kernel/sched/fair.c:12885
ULL device
Dec [  697.914698][    C1]  ? __pfx_sched_balance_trigger+0x10/0x10 kernel/=
sched/fair.c:12670
 4 01:13:29 syzk[  697.914717][    C1]  ? sched_tick+0x286/0x4f0 kernel/sch=
ed/core.c:5672
aller daemon.err[  697.914736][    C1]  update_process_times+0x1a1/0x2d0 ke=
rnel/time/timer.c:2526
 dhcpcd[5484]: l[  697.914756][    C1]  ? __pfx_update_process_times+0x10/0=
x10 kernel/time/timer.c:2380
ibudev: received[  697.914775][    C1]  ? rdtsc_ordered arch/x86/include/as=
m/msr.h:217 [inline]
ibudev: received[  697.914775][    C1]  ? read_tsc+0x9/0x20 arch/x86/kernel=
/tsc.c:1133
 NULL device
De[  697.914795][    C1]  ? ktime_get+0x1ac/0x300 kernel/time/timekeeping.c=
:816
Dec  4 01:13:29 [  697.914811][    C1]  tick_sched_handle kernel/time/tick-=
sched.c:276 [inline]
Dec  4 01:13:29 [  697.914811][    C1]  tick_nohz_handler+0x376/0x530 kerne=
l/time/tick-sched.c:297
Dec  4 01:13:29 [  697.914835][    C1]  ? __pfx_tick_nohz_handler+0x10/0x10=
 include/linux/seqlock.h:226
syzkaller daemon[  697.914856][    C1]  __run_hrtimer kernel/time/hrtimer.c=
:1739 [inline]
syzkaller daemon[  697.914856][    C1]  __hrtimer_run_queues+0x5fb/0xae0 ke=
rnel/time/hrtimer.c:1803
.err dhcpcd[5484[  697.914881][    C1]  ? __pfx___hrtimer_run_queues+0x10/0=
x10 include/trace/events/timer.h:222
]: libudev: rece[  697.914901][    C1]  ? rdtsc_ordered arch/x86/include/as=
m/msr.h:217 [inline]
]: libudev: rece[  697.914901][    C1]  ? read_tsc+0x9/0x20 arch/x86/kernel=
/tsc.c:1133
ived NULL device[  697.914924][    C1]  hrtimer_interrupt+0x392/0x8e0 kerne=
l/time/hrtimer.c:1865

Dec  4 01:13:2[  697.914950][    C1]  local_apic_timer_interrupt arch/x86/k=
ernel/apic/apic.c:1038 [inline]
Dec  4 01:13:2[  697.914950][    C1]  __sysvec_apic_timer_interrupt+0x10f/0=
x400 arch/x86/kernel/apic/apic.c:1055
9 syzkaller daem[  697.914969][    C1]  instr_sysvec_apic_timer_interrupt a=
rch/x86/kernel/apic/apic.c:1049 [inline]
9 syzkaller daem[  697.914969][    C1]  sysvec_apic_timer_interrupt+0x52/0x=
c0 arch/x86/kernel/apic/apic.c:1049
on.err dhcpcd[54[  697.914988][    C1]  asm_sysvec_apic_timer_interrupt+0x1=
a/0x20 arch/x86/include/asm/idtentry.h:702
84]: libudev: re[  697.915009][    C1] RIP: 0033:0x7f65ee25faa9
ceived NULL devi[  697.915021][    C1] Code: 90 48 8b 0a 48 39 08 74 08 48 =
89 48 08 48 83 c0 08 48 83 c2 08 48 39 ea 75 e7 48 8d 68 08 e9 b8 fc ff ff =
4c 89 e6 49 83 c4 08 <48> 89 0e 49 39 ec 0f 85 7b ff ff ff e9 7a fc ff ff 4=
8 8d 0d 4f e4
ce
Dec  4 01:13[  697.915036][    C1] RSP: 002b:00007ffdb9c445f0 EFLAGS: 00000=
212
:29 syzkaller da[  697.915050][    C1] RAX: 00007f65ed656dc0 RBX: 00007f65e=
f075720 RCX: ffffffff8b2763d1
emon.err dhcpcd[[  697.915061][    C1] RDX: ffffffff8b2763d1 RSI: 00007f65e=
d656dc8 RDI: 00007f65ed5fd008
5484]: libudev: [  697.915072][    C1] RBP: 00007f65ed6574a8 R08: 00007f65e=
d5fd078 R09: 00007f65ee532000
received NULL de[  697.915083][    C1] R10: 00007f65ed5fd008 R11: 000000000=
0000012 R12: 00007f65ed656dd0
vice
Dec  4 01:[  697.915093][    C1] R13: 00007f65ee546118 R14: 000000000000003=
2 R15: 00007f65ed5fd008
13:29 syzkaller [  697.915107][    C1]  ? sprintf+0x91/0x110 lib/vsprintf.c=
:3048
Dec  4 01:13:29 [  697.915125][    C1]  ? sprintf+0x91/0x110 lib/vsprintf.c=
:3048
Dec  4 01:13:29 [  697.915144][    C1]  </TASK>
syzkaller daemon[  697.921895][T18008] syzkaller0: entered promiscuous mode
Dec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:1=
3:29 Dec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:29 syzkal=
ler daemon.err dhcpcd[5484]: libudev: received NULL device
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
eDec  4 01:13:29 Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev=
: received NULL device
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:[  698.706692][T18008] syzkaller0: entered allmulticast mode
13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL device
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.eDec  4 01:13:29 Dec  4 01:13:29 Dec  4 01=
:13:29 Dec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:29 Dec =
 4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:29=
 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL device
Dec  4 01:13:29 syzkaller daemDec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:=
29 Dec  4 01:13:29 Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libud=
ev: received NULL device
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
eDec  4 01:13:29 Dec  4 01:13:29 Dec  4 01:13:29 syzkaller daemon.err dhcpc=
d[5484]: libudev: received NULL device
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:29 syzkaller kern.warn kernel: [  697.904801][    C1]=20
Dec  4 01:13:29 syzkaller kern.warn kernel: [  697.908346][    C1] =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913199][    C1] [ BUG: I=
nvalid wait context ]
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913208][    C1] 6.13.0-r=
c1-syzkaller-00005-gceb8bf2ceaa7 #0 Not tainted
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913219][    C1] --------=
---------------------
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913227][    C1] syz.0.44=
50/18007 is trying to lock:
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913237][    C1] ffff8881=
3fffc298 (&zone->lock){-.-.}-{3:3}, at: rmqueue_bulk mm/page_alloc.c:2307 [=
inline]
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913237][    C1] ffff8881=
3fffc298 (&zone->lock){-.-.}-{3:3}, at: __rmqueue_pcplist+0x6bb/0x1600 mm/p=
age_alloc.c:3001
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913282][    C1] other in=
fo that might help us debug this:
Dec  4 01:13:30 syzkaller kern.warn kernel[  699.009473][T18005] kernel wri=
te not supported for file /asound/timers (pid: 18005 comm: syz.3.4449)
: [  697.913286][    C1] context-{2:2}
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913294][    C1] 1 lock h=
eld by syz.0.4450/18007:
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913303][    C1]  #0: fff=
f8880b8744c58 (&pcp->lock){+.+.}-{3:3}, at: spin_trylock include/linux/spin=
lock.h:361 [inline]
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913303][    C1]  #0: fff=
f8880b8744c58 (&pcp->lock){+.+.}-{3:3}, at: rmqueue_pcplist mm/page_alloc.c=
:3030 [inline]
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913303][    C1]  #0: fff=
f8880b8744c58 (&pcp->lock){+.+.}-{3:3}, at: rmqueue mm/page_alloc.c:3074 [i=
nline]
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913303][    C1]  #0: fff=
f8880b8744c58 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x350/0x=
2f80 mm/page_alloc.c:3471
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913344][    C1] stack ba=
cktrace:
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913350][    C1] CPU: 1 U=
ID: 0 PID: 18007 Comm: syz.0.4450 Not tainted 6.13.0-rc1-syzkaller-00005-gc=
eb8bf2ceaa7 #0
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.913369][    C1] Hardware=
 name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/1=
3/2024
Dec  4 01:13:30 syzkaller kern.warn kernel: [ Dec  4 01:13:30 Dec  4 01:13:=
30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 syzkaller kern.warn kern=
el: [  697.913799][    CDec  4 01:13:30 syzkaller kern.wDec  4 01:13:30 Dec=
  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 syzkaller kern=
.wDec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01=
:13:30 syzkaller kern.wDec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec =
 4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30=
 Dec  4 01:13:30 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL =
device
Dec  4 01:13:30 syzkaller kern.warn kernel: [  697.914601][    C1]  ? find_=
held_lock+0x2d/0x110 kernel/locking/lockdep.c:5339
Dec  4 01:13:30 syzkaller daemon.err dhcpcd[5Dec  4 01:13:30 Dec  4 01:13:3=
0 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01=
:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec =
 4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30=
 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:=
13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 syzka=
ller daemon.err dhcpcd[5484]: libudev: received NULL device
Dec  4 01:13:30 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:30 syzkaller daemon.err dhcpcd[Dec  4 01:13:30 Dec  4 01:13:30=
 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 syzkaller daemon.err dhcpc=
d[5484Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  =
4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 =
Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:1=
3:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4=
 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 D=
ec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13=
:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 =
01:13:30 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL device
Dec  4 01:13:30 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:13:30 syzkaller daemon.err dhcpcd[5484]: libudev: received NULL d=
evice
Dec  4 01:Dec  4 01:13:30 syzkaller daemonDec  4 01:13:30 Dec  4 01:13:30 D=
ec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13=
:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 =
01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 De=
c  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:=
30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 0=
1:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec=
  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:3=
0 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01=
:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec =
 4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30=
 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:=
13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  =
4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 Dec  4 01:13:30 =
Dec  4 01:13:30 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:1=
3:31 Dec  4 01:13:31 syzkaller daemonDec  4 01:13:31 Dec  4 01:13:31 Dec  4=
 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 D=
ec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13=
:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 =
01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 De=
c  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:=
31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 0=
1:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec=
  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:3=
1 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01=
:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec =
 4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31=
 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:=
13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  =
4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 =
Dec  4 01:13:31 syzkaller daemonDec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:1=
3:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 syzkal=
ler daemonDec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 D=
ec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13=
:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 =
01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 De=
c  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:=
31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 0=
1:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec=
  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:3=
1 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01=
:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec =
 4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31=
 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:=
13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  =
4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 =
Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:1=
3:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4=
 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 D=
ec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13=
:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 =
01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 De=
c  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 [  699.615304][   T29] kaudit=
d_printk_skb: 10172 callbacks suppressed
Dec  4 01:13:31 [  699.615318][   T29] audit: type=3D1400 audit(1733274811.=
579:973609): avc:  denied  { read } for  pid=3D5484 comm=3D"dhcpcd" scontex=
t=3Dsystem_u:system_r:dhcpc_t tcontext=3Dsystem_u:system_r:dhcpc_t tclass=
=3Dnetlink_kobject_uevent_socket permissive=3D0
Dec  4 01:13:31 Dec  4 01:13:31 [  699.647387][   T29] audit: type=3D1400 a=
udit(1733274811.579:973608): avc:  denied  { read } for  pid=3D5172 comm=3D=
"syslogd" name=3D"log" dev=3D"sda1" ino=3D1915 scontext=3Dsystem_u:system_r=
:syslogd_t tcontext=3Dsystem_u:object_r:var_t tclass=3Dlnk_file permissive=
=3D0
Dec  4 01:13:31 [  699.670887][   T29] audit: type=3D1400 audit(1733274811.=
607:973610): avc:  denied  { read } for  pid=3D5172 comm=3D"syslogd" name=
=3D"log" dev=3D"sda1" ino=3D1915 scontext=3Dsystem_u:system_r:syslogd_t tco=
ntext=3Dsystem_u:object_r:var_t tclass=3Dlnk_file permissive=3D0
Dec  4 01:13:31 [  699.693128][   T29] audit: type=3D1400 audit(1733274811.=
607:973611): avc:  denied  { read } for  pid=3D5484 comm=3D"dhcpcd" scontex=
t=3Dsystem_u:system_r:dhcpc_t tcontext=3Dsystem_u:system_r:dhcpc_t tclass=
=3Dnetlink_kobject_uevent_socket permissive=3D0
Dec  4 01:13:31 [  699.715616][   T29] audit: type=3D1400 audit(1733274811.=
607:973612): avc:  denied  { read } for  pid=3D5172 comm=3D"syslogd" name=
=3D"log" dev=3D"sda1" ino=3D1915 scontext=3Dsystem_u:system_r:syslogd_t tco=
ntext=3Dsystem_u:object_r:var_t tclass=3Dlnk_file permissive=3D0
Dec  4 01:13:31 [  699.740257][   T29] audit: type=3D1400 audit(1733274811.=
607:973613): avc:  denied  { read } for  pid=3D5172 comm=3D"syslogd" name=
=3D"log" dev=3D"sda1" ino=3D1915 scontext=3Dsystem_u:system_r:syslogd_t tco=
ntext=3Dsystem_u:object_r:var_t tclass=3Dlnk_file permissive=3D0
Dec  4 01:13:31 [  699.762864][   T29] audit: type=3D1400 audit(1733274811.=
607:973614): avc:  denied  { read } for  pid=3D5484 comm=3D"dhcpcd" scontex=
t=3Dsystem_u:system_r:dhcpc_t tcontext=3Dsystem_u:system_r:dhcpc_t tclass=
=3Dnetlink_kobject_uevent_socket permissive=3D0
Dec  4 01:13:31 [  699.762894][   T29] audit: type=3D1400 audit(1733274811.=
607:973615): avc:  denied  { read } for  pid=3D5172 comm=3D"syslogd" name=
=3D"log" dev=3D"sda1" ino=3D1915 scontext=3Dsystem_u:system_r:syslogd_t tco=
ntext=3Dsystem_u:object_r:var_t tclass=3Dlnk_file permissive=3D0
Dec  4 01:13:31 [  699.762921][   T29] audit: type=3D1400 audit(1733274811.=
607:973616): avc:  denied  { read } for  pid=3D5484 comm=3D"dhcpcd" scontex=
t=3Dsystem_u:system_r:dhcpc_t tcontext=3Dsystem_u:system_r:dhcpc_t tclass=
=3Dnetlink_kobject_uevent_socket permissive=3D0
Dec  4 01:13:31 [  699.762946][   T29] audit: type=3D1400 audit(1733274811.=
607:973618): avc:  denied  { read } for  pid=3D5484 comm=3D"dhcpcd" scontex=
t=3Dsystem_u:system_r:dhcpc_t tcontext=3Dsystem_u:system_r:dhcpc_t tclass=
=3Dnetlink_kobject_uevent_socket permissive=3D0
Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:1=
3:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4=
 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 D=
ec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13=
:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 =
01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 De=
c  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:=
31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 0=
1:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec=
  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:3=
1 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01=
:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec =
 4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31=
 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:=
13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  =
4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 =
Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:1=
3:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4=
 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 D=
ec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13=
:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 =
01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 De=
c  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:=
31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 0=
1:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec=
  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:3=
1 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01=
:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec =
 4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31=
 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:=
13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  =
4 01:13:31 syzkaller daemonDec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 =
Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:1=
3:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4=
 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 D=
ec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13=
:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 =
01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 De=
c  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:=
31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 0=
1:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec=
  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:3=
1 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01=
:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec =
 4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31=
 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:=
13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  =
4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 =
Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:1=
3:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4=
 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 D=
ec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13=
:31 Dec  4 01:13:31 Dec  4 01:13:31 syzkaller daemonDec  4 01:13:31 Dec  4 =
01:13:31 Dec  4 01:13:31 syzkaller daemon.err dhcpcd[5484Dec  4 01:13:31 sy=
zkaller daemon.err dhcpcd[5484]: libudev: received NULL deviceDec  4 01:13:=
31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 0=
1:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec=
  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:3=
1 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01=
:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec =
 4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31=
 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:=
13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  =
4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 =
Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:1=
3:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4=
 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 D=
ec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13=
:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 =
01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 De=
c  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:=
31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 0=
1:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec=
  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:3=
1 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01=
:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec =
 4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31=
 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:=
13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  =
4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 =
Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:1=
3:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4=
 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 D=
ec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13=
:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 =
01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 Dec  4 01:13:31 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01=
:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec =
 4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32=
 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:=
13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  =
4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 =
Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:1=
3:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4=
 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 D=
ec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13=
:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 =
01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01=
:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec =
 4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32=
 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:=
13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  =
4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 =
Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:1=
3:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4=
 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 D=
ec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13=
:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 =
01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01=
:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec =
 4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32=
 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:=
13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  =
4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 =
Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:1=
3:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4=
 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 D=
ec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13=
:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 =
01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01=
:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec =
 4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32=
 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:=
13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  =
4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 =
Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:1=
3:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4=
 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 D=
ec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13=
:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 =
01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01=
:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec =
 4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32=
 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:=
13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  =
4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 =
Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:1=
3:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4=
 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 D=
ec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13=
:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 =
01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01=
:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec =
 4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32=
 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:=
13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  =
4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 =
Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:1=
3:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4=
 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 D=
ec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13=
:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 =
01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01=
:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec =
 4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32=
 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:=
13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  =
4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 =
Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:1=
3:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4=
 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 D=
ec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13=
:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 =
01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01=
:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec =
 4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32=
 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:=
13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  =
4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 =
Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 syzkaller daemonDec  4 01:1=
3:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4=
 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 D=
ec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13=
:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 =
01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01=
:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec =
 4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32=
 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:=
13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  =
4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 =
Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:1=
3:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4=
 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 D=
ec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13=
:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 =
01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 syzkaller=
 daemonDec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec =
 4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32=
 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:=
13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  =
4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 =
Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:1=
3:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4=
 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 D=
ec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13=
:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 =
01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 De=
c  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:=
32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 0=
1:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec=
  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:32 Dec  4 01:13:3=
2 Dec  4 01:13:32 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  =
4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 =
Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:1=
3:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4=
 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 D=
ec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13=
:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 =
01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 De=
c  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:=
33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 0=
1:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec=
  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:3=
3 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 syzkaller daemonDec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  =
4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 =
Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:1=
3:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4=
 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 D=
ec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13=
:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 =
01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 De=
c  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:=
33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 0=
1:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec=
  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:3=
3 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  =
4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 =
Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:1=
3:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4=
 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 D=
ec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13=
:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 =
01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 De=
c  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:=
33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 0=
1:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec=
  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:3=
3 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  =
4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 =
Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:1=
3:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4=
 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 D=
ec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13=
:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 =
01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 De=
c  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:=
33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 0=
1:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec=
  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:3=
3 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  =
4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 =
Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:1=
3:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4=
 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 D=
ec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13=
:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 =
01:13:33 syzkaller daemonDec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 De=
c  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:=
33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 0=
1:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec=
  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:3=
3 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  =
4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 =
Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:1=
3:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4=
 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 D=
ec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13=
:33 syzkaller daemonDec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 =
01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 De=
c  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:=
33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 0=
1:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec=
  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:3=
3 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  =
4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 =
Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:1=
3:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4=
 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 D=
ec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13=
:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 =
01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 sy=
zkaller daemonDec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:=
33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 0=
1:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec=
  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:3=
3 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  =
4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 =
Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:1=
3:33 Dec  4 01:13:33 Dec  4 01:13:33 syzkaller daemonDec  4 01:13:33 Dec  4=
 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 D=
ec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13=
:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 =
01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 De=
c  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:=
33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 0=
1:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec=
  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:3=
3 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  =
4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 =
Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:1=
3:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4=
 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 D=
ec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13=
:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 =
01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 De=
c  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:=
33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 0=
1:13:33 Dec  4 01:13:33 Dec  4 01:13:33 syzkaller daemonDec  4 01:13:33 Dec=
  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:3=
3 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  =
4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 =
Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:1=
3:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4=
 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 D=
ec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13=
:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 =
01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 De=
c  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:=
33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 0=
1:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec=
  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:3=
3 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01=
:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec =
 4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33=
 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:13:33 Dec  4 01:=
13:33 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  =
4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 =
Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:1=
3:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4=
 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 D=
ec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13=
:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 =
01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 De=
c  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:=
34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 0=
1:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec=
  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:3=
4 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01=
:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec =
 4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 syzkaller daemonDec  4 01:13:34=
 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:=
13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  =
4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 =
Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:1=
3:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4=
 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 D=
ec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13=
:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 =
01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 De=
c  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:=
34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 0=
1:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec=
  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:3=
4 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01=
:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec =
 4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34=
 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:=
13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  =
4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 =
Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:1=
3:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4=
 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 D=
ec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13=
:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 =
01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 De=
c  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:=
34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 0=
1:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec=
  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:3=
4 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01=
:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec =
 4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34=
 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:=
13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  =
4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 =
Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:1=
3:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4=
 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 D=
ec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13=
:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 =
01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 De=
c  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:=
34 Dec  4 01:13:34 syzkaller daemonDec  4 01:13:34 Dec  4 01:13:34 Dec  4 0=
1:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec=
  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4 01:13:34 Dec  4=20

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

