Return-Path: <linux-kernel+bounces-442585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 290D89EDEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8736F1889206
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ADF166308;
	Thu, 12 Dec 2024 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPslGBSn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD20158D80
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733979423; cv=none; b=ANVLHUKf8F7qfYHSwHE8wXeUhCjHQLB7UMtgDtn9yOVZltWZw3eart9d5e9r/Z8bdotVPpc39rN5cCOB7OX/LDFIGx50tpK6y07nTbFloVNovMVP0WH92ZkWkIBAAEU2VZtBcueUDiviqOqG3dHTUxjVGW1gMZjeiWxErRcw4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733979423; c=relaxed/simple;
	bh=UVWP856ZrRPRUpQkwy7I6ig3vPnnzTZzGOulz3raD6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iZSp53rdGqh4bu1ws9s06+eVOwylbEdScUH1FZcEigcWRYZM+nue4vzVQP6zbVMFJ1p1DnCT0pOg3nNXvdqF2VJ/UI7p+yW5lyByPJ3lZvbTzcVGkhAHyPhWMSHZ2GzFgCrxM/jcIcdMlDVt6PFXrkCzFM3Mc8F7KTcvwgsY0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPslGBSn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733979421; x=1765515421;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UVWP856ZrRPRUpQkwy7I6ig3vPnnzTZzGOulz3raD6s=;
  b=LPslGBSnrDSNiHxtqCBoJpyWNlifIWnTA6nZm/eMFOZioisL44jywYg+
   8ZVFWtmEDPFnhjN+XOAjpZPDOoMNX7udc5qaCbworGYMbceJQpm7ePFVK
   ynWVC1HUVjGWeeLrkHsWIOK01yeN7ga0xo3XGOuWspU9LmVAauss04dak
   UT7Mnn9glsyexFgV/W+zHKZPr5O31Iw14QXo0I2llrR2WvVLghaorBVBj
   NQkkmEKFlIPMc4W99cj4EYVxts5OlYRRwICHKv8PmQhrb0H9M+CaIafx1
   L3EnaUzx67154NccjdElvzLqgYCGj4bIbdzvL4mrNvm16PPD1uyx3VIjE
   A==;
X-CSE-ConnectionGUID: QoZRfYpOQ0iD7HjUGpxsjw==
X-CSE-MsgGUID: YtxAhWupRPq3w71BEqcwqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="33712037"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="33712037"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 20:57:01 -0800
X-CSE-ConnectionGUID: Rj9mlIbbQ0OH2ch4cfNyHg==
X-CSE-MsgGUID: 9jMMS0w3QHCCqpB4Awei6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101055783"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 20:56:39 -0800
Date: Thu, 12 Dec 2024 12:56:09 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: willy@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	syzkaller-bugs@googlegroups.com, yi1.lai@intel.com
Subject: There is WARNING in __alloc_frozen_pages_noprof in v6.13-rc2
Message-ID: <Z1ps6e3/2vT7QrYo@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew Wilcox,

Greetings!

I used Syzkaller and found that there is WARNING in __alloc_frozen_pages_noprof in linux v6.13-rc2.

After bisection and the first bad commit is:
"
9181a585d2d1 mm/page_alloc: add __alloc_frozen_pages()
"

The WARNING related to __alloc_frozen_pages_noprof and v9fs was also reported in https://syzkaller.appspot.com/bug?extid=03fb58296859d8dbab4d. I hope following trace can be insightful to you.

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/241211_183256___alloc_frozen_pages_noprof
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/241211_183256___alloc_frozen_pages_noprof/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/241211_183256___alloc_frozen_pages_noprof/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/241211_183256___alloc_frozen_pages_noprof/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/241211_183256___alloc_frozen_pages_noprof/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/241211_183256___alloc_frozen_pages_noprof/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241211_183256___alloc_frozen_pages_noprof/bzImage_d1486dca38afd08ca279ae94eb3a397f10737824
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/241211_183256___alloc_frozen_pages_noprof/d1486dca38afd08ca279ae94eb3a397f10737824_dmesg.log

"
[  189.747738] ------------[ cut here ]------------
         Stopping Security Auditing Service...
[  189.751119] WARNING: CPU: 0 PID: 238 at mm/page_alloc.c:4771 __alloc_frozen_pages_noprof+0x576/0x6f0
[  189.753512] Modules linked in:
[  189.754083] CPU: 0 UID: 0 PID: 238 Comm: auditd Not tainted 6.13.0-rc2-next-20241209-d1486dca38af #1
[  189.756130] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/014
[  189.759592] RIP: 0010:__alloc_frozen_pages_noprof+0x576/0x6f0
[  189.761360] Code: e8 af af ec ff e9 f7 fc ff ff 83 fe 0a 0f 86 7b fb ff ff 45 31 ff 80 3d 89 49 de 05 00 0f 85 f6 fd ff ff0
[  189.765443] RSP: 0018:ffff888012c1f658 EFLAGS: 00010246
[  189.766578] RAX: 0000000000000000 RBX: 1ffff11002583ed1 RCX: 0000000000000000
[  189.768810] RDX: 0000000000000000 RSI: 0000000000000014 RDI: 0000000000000000
[  189.771063] RBP: ffff888012c1f750 R08: 0000000000000000 R09: fffffbfff0f975c4
[  189.772519] R10: ffff888012c1f878 R11: 0000000000000001 R12: 0000000000040cc0
[  189.774822] R13: 0000000000000014 R14: ffff888012c1f728 R15: 0000000000000000
[  189.776145] FS:  00007fc6bb494880(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
[  189.778771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  189.780188] CR2: 00007fc6bb270a30 CR3: 0000000016aba002 CR4: 0000000000770ef0
[  189.781624] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  189.783966] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[  189.785798] PKRU: 55555554
[  189.786490] Call Trace:
[  189.787195]  <TASK>
[  189.787635]  ? show_regs+0x6d/0x80
[  189.788322]  ? __warn+0xf3/0x390
[  189.788888]  ? report_bug+0x25e/0x4b0
[  189.790113]  ? __alloc_frozen_pages_noprof+0x576/0x6f0
[  189.791759]  ? report_bug+0x2cb/0x4b0
[  189.792877]  ? print_usage_bug.part.0+0x5a0/0x610
[  189.794491]  ? __alloc_frozen_pages_noprof+0x576/0x6f0
[  189.796095]  ? __alloc_frozen_pages_noprof+0x577/0x6f0
[  189.797685]  ? handle_bug+0xf1/0x190
[  189.798919]  ? exc_invalid_op+0x3c/0x80
[  189.800138]  ? asm_exc_invalid_op+0x1f/0x30
[  189.801470]  ? __alloc_frozen_pages_noprof+0x576/0x6f0
[  189.802686]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[  189.804058]  ? __pfx___lock_acquire+0x10/0x10
[  189.804811]  __alloc_pages_noprof+0x16/0x80
[  189.805508]  ___kmalloc_large_node+0x96/0x150
[  189.806514]  __kmalloc_large_node_noprof+0x23/0x100
[  189.808223]  __kmalloc_noprof+0x3f3/0x560
[  189.809494]  ? audit_receive_msg+0xa72/0x2a90
[  189.810924]  ? ns_capable+0xec/0x130
[  189.812066]  audit_receive_msg+0xa72/0x2a90
[  189.813332]  ? audit_receive_msg+0xa72/0x2a90
[  189.814436]  ? __pfx_audit_receive_msg+0x10/0x10
[  189.815399]  ? __pfx___lock_acquire+0x10/0x10
[  189.816661]  ? __pfx___mutex_lock+0x10/0x10
[  189.817887]  ? __this_cpu_preempt_check+0x21/0x30
[  189.818987]  ? lock_release+0x441/0x870
[  189.820225]  audit_receive+0x282/0x450
[  189.821109]  ? __pfx_audit_receive+0x10/0x10
[  189.821842]  ? netlink_deliver_tap+0x1b9/0xca0
[  189.822626]  ? __kasan_check_write+0x18/0x20
[  189.823761]  netlink_unicast+0x5a3/0x870
[  189.824983]  ? __pfx_netlink_unicast+0x10/0x10
[  189.826359]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
[  189.827886]  ? __check_object_size+0x43/0x8e0
[  189.829290]  netlink_sendmsg+0x956/0xe80
[  189.830525]  ? __pfx_netlink_sendmsg+0x10/0x10
[  189.831367]  ? _copy_from_user+0x77/0xa0
[  189.832159]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[  189.833811]  __sys_sendto+0x563/0x5c0
[  189.835087]  ? __pfx___sys_sendto+0x10/0x10
[  189.836408]  ? lock_acquire+0x80/0xb0
[  189.837121]  ? __seccomp_filter+0x5f3/0x1160
[  189.837875]  ? __pfx___seccomp_filter+0x10/0x10
[  189.838646]  ? __x64_sys_rt_sigaction+0x215/0x370
[  189.839541]  __x64_sys_sendto+0xe9/0x1b0
[  189.840419]  ? syscall_trace_enter+0x9f/0x280
[  189.841791]  x64_sys_call+0x1df1/0x2140
[  189.843072]  do_syscall_64+0x6d/0x140
[  189.844244]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  189.845806] RIP: 0033:0x7fc6bb34faf6
[  189.847030] Code: c1 f4 ff 44 8b 4c 24 2c 4c 8b 44 24 20 41 89 c4 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 248
[  189.851934] RSP: 002b:00007fffdf8dd480 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
[  189.853337] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc6bb34faf6
[  189.855569] RDX: 0000000000000010 RSI: 00007fffdf8dd4f0 RDI: 0000000000000003
[  189.856912] RBP: 0000000000000010 R08: 00007fffdf8dd4dc R09: 000000000000000c
[  189.859108] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[  189.860685] R13: 00007fffdf8dd4f0 R14: 00007fffdf8dd4dc R15: 00000000000003f2
[  189.862615]  </TASK>
[  189.863375] irq event stamp: 49885
[  189.864295] hardirqs last  enabled at (49893): [<ffffffff8165f305>] __up_console_sem+0x95/0xb0
[  189.866318] hardirqs last disabled at (49900): [<ffffffff8165f2ea>] __up_console_sem+0x7a/0xb0
[  189.868457] softirqs last  enabled at (49914): [<ffffffff8148974e>] __irq_exit_rcu+0x10e/0x170
[  189.869882] softirqs last disabled at (49909): [<ffffffff8148974e>] __irq_exit_rcu+0x10e/0x170
[  189.871298] ---[ end trace 0000000000000000 ]---
"

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

