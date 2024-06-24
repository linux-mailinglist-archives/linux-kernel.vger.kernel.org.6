Return-Path: <linux-kernel+bounces-226504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C01913F52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4251C213F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73964646;
	Mon, 24 Jun 2024 00:04:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C621621
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719187445; cv=none; b=G5mslnQs/McIYM51Nf4Urtca/RwxB/QUi6e03DA31gzbsFOG3LbQ0L4GrU++tOo7SUSSR3kK7ZKgcwmnH1TNlPNXI8RNOgne/AJABsQoTDsW0nDx3UPi/ekd5mQkDLk7Yxwi00uUGhmo6Ni7Vr6RBlDD3hJflecugOaaWVB0was=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719187445; c=relaxed/simple;
	bh=lRCL7kCbJRKVd5KBd4JU9ER9KMb9sHUSlBP9m53zUZE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d6TdWbeeCmooR8BU9QJVM9qC9dQsn/fQwz6k/2+Ot9OREF9XDaLBLn/Ft1ZBMjtGSDQ9hnTYki7eKmOSo8UEahFhGDvvEaEv9DgIQxy8Mv/mMXGn9IeYfQACV+r7Kl1HPqz0T4Y2Y18xD1t2tr7/obR4+8m2cJMia2C3+hWTpUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ebcbef22c8so474010139f.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719187442; x=1719792242;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CaZZG+uCkzBtjIA2jB86wHklrhG1G9CcjFYXLEIeI0=;
        b=pgLiUGwr5bdg9JCyJs/1x295v3mXkUcTvUm5QEdDFeFRRJmVUEqNt/gs2uUAYqNeQO
         8ckb2y4UUTcKcHwIUJhMEhkwaRqCgraKcJvcI07+E36Entpg0Bt+SqknMJNNCOimXzTI
         viNu3aBLweDFFBFZiaxQ4E0RSoNrFF7AUaNyW/yFjf5qpQww+6hBiPu+rYFXi14Z95pN
         KnrvjVZ36Q8WFaxfehes8B+LM9RyTmR4g7Oe1EMFN4XSDd2kdHv8QPc/1nC6tNjlC2c8
         qTWQkyB2NQQ2S4BL/snpG/4ZmlwAGrvTNReLoSYmGHNvy8bpOjAk+LYiy/1XIv/5oFqU
         N6PA==
X-Forwarded-Encrypted: i=1; AJvYcCX8nmc3NmY2r7tgg/qjT/ACKL1Z6LHASOjggYRQDw0KKfYBwuKnWLnsF+s4SS2wDWkjRAt3y+MnQYr47z2LBdEp9WxBLblU3ENhgoid
X-Gm-Message-State: AOJu0YxRcd21L+TQlfNaHQeky9fO8DkZmuYDVZWgXXDw+EDGzgYuhYOy
	R5xBrl1VlItI2AgxQP3ntOzpPepry+BC2D3iDTzQgpfgKImTgYQph/0qDMeC/kTwZXUZYCgoi8r
	qgHUVs2Ffd4eu8s2fv8iZy68p+l0pTuSYQL9shpuvAtb+b6F9YEYOfyk=
X-Google-Smtp-Source: AGHT+IGrRcTwwgU4SKIIyJSnXC5tTVOs0dxKJi/NDqSy+k7i8wFofAV5Kzd28HR0a/XNLSJC0SukXk818RugdMuAdqejV5l9nVSn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8303:b0:4b9:eee6:40d with SMTP id
 8926c6da1cb9f-4b9efba18a1mr46832173.4.1719187442612; Sun, 23 Jun 2024
 17:04:02 -0700 (PDT)
Date: Sun, 23 Jun 2024 17:04:02 -0700
In-Reply-To: <dc7a754f-fb0b-4767-a649-1f8717ece5bd@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1cedb061b978414@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work (2)
From: syzbot <syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com>
To: jain.abhinav177@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

]   #0: Dummy 1
[   50.290416][    T1]   #1: Loopback 1
[   50.294263][    T1]   #2: Virtual MIDI Card 1
[   50.304625][   T43] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   50.314614][   T43] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   50.324047][    T1] md: Waiting for all devices to be available before a=
utodetect
[   50.331941][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   50.338762][    T1] md: Autodetecting RAID arrays.
[   50.343816][    T1] md: autorun ...
[   50.347560][    T1] md: ... autorun DONE.
[   50.453970][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   50.467611][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   50.480291][    T1] devtmpfs: mounted
[   50.746398][    T1] Freeing unused kernel image (initmem) memory: 37044K
[   50.758376][    T1] Write protecting the kernel read-only data: 262144k
[   50.805347][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1804K
[   52.468982][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   52.479558][    T1] x86/mm: Checking user space page tables
[   53.988075][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   53.997244][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   54.019291][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   54.031476][    T1] Run /sbin/init as init process
[   55.633180][ T4452] mount (4452) used greatest stack depth: 8144 bytes l=
eft
[   55.708282][ T4453] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   56.045994][ T4456] mount (4456) used greatest stack depth: 5568 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   59.872511][ T4486] udevd[4486]: starting ve=
rsion 3.2.11
[   63.427094][ T4487] udevd[4487]: starting eudev-3.2.11
[   63.439898][ T4486] udevd (4486) used greatest stack depth: 5312 bytes l=
eft
[   75.915745][ T4504] v4l_id (4504) used greatest stack depth: 5040 bytes =
left
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:98:24:4c:28:99:7c:d9:70:fe:51:ca:fe:56:33:2c:7d
forked to background, child pid 4700
[  111.302294][ T4701] 8021q: adding VLAN 0 to HW filter on device bond0
[  111.356959][ T4701] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
[  111.675306][   T43] cfg80211: failed to load regulatory.db
Starting sshd: OK
[  113.974849][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  113.982193][    C0] BUG: KMSAN: uninit-value in receive_buf+0x2620/0x607=
0
[  113.989359][    C0]  receive_buf+0x2620/0x6070
[  113.994223][    C0]  virtnet_poll+0xd1c/0x23c0
[  113.999046][    C0]  __napi_poll+0xe7/0x980
[  114.003560][    C0]  net_rx_action+0x82a/0x1850
[  114.008538][    C0]  handle_softirqs+0x1ce/0x800
[  114.013480][    C0]  __irq_exit_rcu+0x68/0x120
[  114.018306][    C0]  irq_exit_rcu+0x12/0x20
[  114.022880][    C0]  common_interrupt+0x94/0xa0
[  114.027696][    C0]  asm_common_interrupt+0x2b/0x40
[  114.033033][    C0]  filter_irq_stacks+0xde/0x1a0


[  114.038201][    C0]  stack_depot_save_flags+0x2c/0x6e0
[  114.043785][    C0]  stack_depot_save+0x12/0x20
syzkaller[  114.048885][    C0]  kmsan_internal_poison_memory+0x5d/0x90

[  114.055418][    C0]  kmsan_slab_alloc+0xdf/0x160

syzkaller login[  114.060451][    C0]  kmem_cache_alloc_noprof+0x637/0xb20
: [  114.067309][    C0]  vm_area_dup+0x5c/0x620
[  114.072098][    C0]  copy_mm+0x1951/0x3ca0
[  114.076529][    C0]  copy_process+0x26f7/0x5b90
[  114.081439][    C0]  kernel_clone+0x401/0x1040
[  114.086216][    C0]  __x64_sys_clone+0x25c/0x360
[  114.091237][    C0]  x64_sys_call+0x2a45/0x3b90
[  114.096111][    C0]  do_syscall_64+0xcd/0x1e0
[  114.100832][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.107039][    C0]=20
[  114.109519][    C0] Uninit was created at:
[  114.113933][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  114.119382][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  114.125055][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  114.130351][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  114.135882][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  114.140928][    C0]  try_fill_recv+0x3f0/0x2f50
[  114.145767][    C0]  virtnet_open+0x1cc/0xb00
[  114.150504][    C0]  __dev_open+0x546/0x6f0
[  114.154987][    C0]  __dev_change_flags+0x309/0x9a0
[  114.160485][    C0]  dev_change_flags+0x8e/0x1d0
[  114.165494][    C0]  devinet_ioctl+0x13ec/0x22c0
[  114.170508][    C0]  inet_ioctl+0x4bd/0x6d0
[  114.175025][    C0]  sock_do_ioctl+0xb7/0x540
[  114.179744][    C0]  sock_ioctl+0x727/0xd70
[  114.184245][    C0]  __se_sys_ioctl+0x261/0x450
[  114.189151][    C0]  __x64_sys_ioctl+0x96/0xe0
[  114.193930][    C0]  x64_sys_call+0x18c0/0x3b90
[  114.198943][    C0]  do_syscall_64+0xcd/0x1e0
[  114.203635][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.209795][    C0]=20
[  114.212287][    C0] CPU: 0 PID: 4798 Comm: dhcpcd-run-hook Not tainted 6=
.10.0-rc5-syzkaller-gf2661062f16b-dirty #0
[  114.223065][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  114.233500][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.240777][    C0] Disabling lock debugging due to kernel taint
[  114.246986][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  114.253452][    C0] CPU: 0 PID: 4798 Comm: dhcpcd-run-hook Tainted: G   =
 B              6.10.0-rc5-syzkaller-gf2661062f16b-dirty #0
[  114.265699][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  114.275830][    C0] Call Trace:
[  114.279210][    C0]  <IRQ>
[  114.282205][    C0]  dump_stack_lvl+0x216/0x2d0
[  114.287023][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.292958][    C0]  dump_stack+0x1e/0x30
[  114.297237][    C0]  panic+0x4e2/0xcd0
[  114.301260][    C0]  ? kmsan_get_metadata+0x51/0x1d0
[  114.306661][    C0]  kmsan_report+0x2d5/0x2e0
[  114.311406][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.316739][    C0]  ? __msan_warning+0x95/0x120
[  114.321632][    C0]  ? receive_buf+0x2620/0x6070
[  114.326511][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  114.331381][    C0]  ? __napi_poll+0xe7/0x980
[  114.336102][    C0]  ? net_rx_action+0x82a/0x1850
[  114.341086][    C0]  ? handle_softirqs+0x1ce/0x800
[  114.346134][    C0]  ? __irq_exit_rcu+0x68/0x120
[  114.351082][    C0]  ? irq_exit_rcu+0x12/0x20
[  114.355691][    C0]  ? common_interrupt+0x94/0xa0
[  114.360663][    C0]  ? asm_common_interrupt+0x2b/0x40
[  114.365979][    C0]  ? filter_irq_stacks+0xde/0x1a0
[  114.371122][    C0]  ? stack_depot_save_flags+0x2c/0x6e0
[  114.376810][    C0]  ? stack_depot_save+0x12/0x20
[  114.381868][    C0]  ? kmsan_internal_poison_memory+0x5d/0x90
[  114.387980][    C0]  ? kmsan_slab_alloc+0xdf/0x160
[  114.393063][    C0]  ? kmem_cache_alloc_noprof+0x637/0xb20
[  114.398930][    C0]  ? vm_area_dup+0x5c/0x620
[  114.403560][    C0]  ? copy_mm+0x1951/0x3ca0
[  114.408257][    C0]  ? copy_process+0x26f7/0x5b90
[  114.413209][    C0]  ? kernel_clone+0x401/0x1040
[  114.418183][    C0]  ? __x64_sys_clone+0x25c/0x360
[  114.423314][    C0]  ? x64_sys_call+0x2a45/0x3b90
[  114.428288][    C0]  ? do_syscall_64+0xcd/0x1e0
[  114.433083][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.439278][    C0]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  114.446250][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.451579][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.456996][    C0]  ? page_to_skb+0xdae/0x1620
[  114.461963][    C0]  __msan_warning+0x95/0x120
[  114.466645][    C0]  receive_buf+0x2620/0x6070
[  114.471342][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.476662][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.481407][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  114.486598][    C0]  __napi_poll+0xe7/0x980
[  114.491088][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.496605][    C0]  net_rx_action+0x82a/0x1850
[  114.501407][    C0]  ? sched_clock_cpu+0x55/0x870
[  114.506377][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  114.511576][    C0]  handle_softirqs+0x1ce/0x800
[  114.516463][    C0]  __irq_exit_rcu+0x68/0x120
[  114.521162][    C0]  irq_exit_rcu+0x12/0x20
[  114.525580][    C0]  common_interrupt+0x94/0xa0
[  114.530379][    C0]  </IRQ>
[  114.533378][    C0]  <TASK>
[  114.536354][    C0]  asm_common_interrupt+0x2b/0x40
[  114.541507][    C0] RIP: 0010:filter_irq_stacks+0xde/0x1a0
[  114.547378][    C0] Code: 00 20 d9 0f 85 8e 00 00 00 20 d0 0f 85 86 00 0=
0 00 45 84 f6 0f 85 9a 00 00 00 48 c7 c2 00 da 8b 8f 49 39 d7 0f 93 c1 49 3=
9 d4 <0f> 93 c0 30 c8 49 39 d5 0f 93 c1 48 c7 c6 2a da 8b 8f 49 39 f7 0f
[  114.567111][    C0] RSP: 0018:ffff8881193af590 EFLAGS: 00000206
[  114.573266][    C0] RAX: ffff888118baf600 RBX: ffff8881193af600 RCX: 000=
0000118faf601
[  114.581326][    C0] RDX: ffffffff8f8bda00 RSI: ffffffff8fa01830 RDI: 000=
0000000000000
[  114.589376][    C0] RBP: ffff8881193af5e0 R08: ffffea000000000f R09: fff=
f8881193ac000
[  114.597436][    C0] R10: ffff8881193af568 R11: ffffffff81935550 R12: fff=
fffff8fa00130
[  114.605587][    C0] R13: ffffffff8fa00130 R14: 0000000018faf600 R15: fff=
fffff8fa00130
[  114.613839][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.620124][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.626504][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.632816][    C0]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  114.639139][    C0]  ? __lock_text_end+0x7/0x7
[  114.643855][    C0]  ? asm_sysvec_kvm_asyncpf_interrupt+0x30/0x30
[  114.650338][    C0]  stack_depot_save_flags+0x2c/0x6e0
[  114.655772][    C0]  ? stack_trace_save+0xb5/0xe0
[  114.660782][    C0]  stack_depot_save+0x12/0x20
[  114.665789][    C0]  kmsan_internal_poison_memory+0x5d/0x90
[  114.671640][    C0]  ? kmsan_internal_poison_memory+0x49/0x90
[  114.677660][    C0]  ? kmsan_slab_alloc+0xdf/0x160
[  114.682719][    C0]  ? kmem_cache_alloc_noprof+0x637/0xb20
[  114.688546][    C0]  ? vm_area_dup+0x5c/0x620
[  114.693160][    C0]  ? copy_mm+0x1951/0x3ca0
[  114.697671][    C0]  ? copy_process+0x26f7/0x5b90
[  114.702623][    C0]  ? kernel_clone+0x401/0x1040
[  114.707494][    C0]  ? __x64_sys_clone+0x25c/0x360
[  114.712540][    C0]  ? x64_sys_call+0x2a45/0x3b90
[  114.717614][    C0]  ? do_syscall_64+0xcd/0x1e0
[  114.722445][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.728653][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.733972][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.739443][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.745375][    C0]  ? kmem_cache_alloc_noprof+0x67/0xb20
[  114.751025][    C0]  ? filter_irq_stacks+0x164/0x1a0
[  114.756260][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.761588][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.767673][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.773074][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.779113][    C0]  kmsan_slab_alloc+0xdf/0x160
[  114.784111][    C0]  kmem_cache_alloc_noprof+0x637/0xb20
[  114.789862][    C0]  ? vm_area_dup+0x5c/0x620
[  114.794498][    C0]  vm_area_dup+0x5c/0x620
[  114.798938][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.804919][    C0]  copy_mm+0x1951/0x3ca0
[  114.809322][    C0]  copy_process+0x26f7/0x5b90
[  114.814163][    C0]  kernel_clone+0x401/0x1040
[  114.818876][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.824179][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.829512][    C0]  ? __msan_memset+0xf5/0x1b0
[  114.834295][    C0]  __x64_sys_clone+0x25c/0x360
[  114.839200][    C0]  x64_sys_call+0x2a45/0x3b90
[  114.844021][    C0]  do_syscall_64+0xcd/0x1e0
[  114.848674][    C0]  ? clear_bhb_loop+0x25/0x80
[  114.853671][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.859833][    C0] RIP: 0033:0x7ff7d4148a12
[  114.864486][    C0] Code: 41 5d 41 5e 41 5f c3 64 48 8b 04 25 10 00 00 0=
0 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 e7 43 0f 00 f7 d8 64 89 02 48 83
[  114.884483][    C0] RSP: 002b:00007ffedc1768e8 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000038
[  114.893097][    C0] RAX: ffffffffffffffda RBX: 000055b417f4a901 RCX: 000=
07ff7d4148a12
[  114.901171][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000001200011
[  114.909328][    C0] RBP: 000055b417f4bb70 R08: 0000000000000000 R09: 3c0=
0000000001001
[  114.917758][    C0] R10: 00007ff7d400e650 R11: 0000000000000246 R12: 000=
055b417f58640
[  114.925841][    C0] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
[  114.933934][    C0]  </TASK>
[  114.937451][    C0] Kernel Offset: disabled
[  114.942128][    C0] Rebooting in 86400 seconds..


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
GOVERSION=3D'go1.21.4'
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
 -ffile-prefix-map=3D/tmp/go-build2361823076=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 121701b623
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
/syzkaller/prog.GitRevision=3D121701b62358a454bbfdccfadfcce9bb843602d6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240605-134717'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D121701b62358a454bbfdccfadfcce9bb843602d6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240605-134717'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"121701b62358a454bbfdccfadfcce9bb84=
3602d6\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D177d808e980000


Tested on:

commit:         f2661062 Linux 6.10-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D246bf67bb6aae1e=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3da70a0abd7f5765b=
6ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1506683e9800=
00


