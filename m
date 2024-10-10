Return-Path: <linux-kernel+bounces-358726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C696C9982E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C01B23FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612921BD4FD;
	Thu, 10 Oct 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/bXI+Bj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA31B5EBC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554052; cv=none; b=Fu/+vDA7NAUQUEf2nSBmb6RZrIeR8OVMlYRJybGMT+0UWtpOvBHyjDlo90DIjPRTBRdKj1RBMmEfGUFDLA3FK/ntJsrVbu/Vu76vhIt10ljObUbTmqumKaKFeUNWtM3kFlAD9N0XgBExTGGoiIuEX+jYD1C8YSKupUdMPDOts2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554052; c=relaxed/simple;
	bh=O3nbX8UAA0TstzbhXFLc7a0+1PtpGI0VgNpanZB2LU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ji55tyrWkC4ZPYg3LJSXUxW+4Nuo+Q0dEyPxmErTmkpmuPUt3Jp0uXFTgNFwY+L7Eplw/7TRqtVVsZufye9ED+ykNbwn2g9k2ZfdUw4KkqDE486RPQxD1lj/RrDuPEL2I2QQeEZKgqMxYV4nBDdIqqsAewOrmcauvJ6LPQ9Ma3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/bXI+Bj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728554051; x=1760090051;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O3nbX8UAA0TstzbhXFLc7a0+1PtpGI0VgNpanZB2LU4=;
  b=i/bXI+BjK/bN2jxXhHkfIAFfAFcECo6ZWpWz/6IVN1Jk6pOHD64pvC6l
   kT7h0Zbs2NI63zfa2Y8UHqf2nIlr8VARPUf4jvbyZUDi9uKCe9x7ncl5O
   UifOvylxPA4+b4/beyWIHK7gvHaQLlwOps5YxVWAEO9ZLl1I1At5X4S0u
   /UNbDyvHvk8V5wewHCUO7JRlbnUZX/vuraMVbmB+BarDCBshb9BU00rii
   dfvyKhKYE2LyOoTU0W6grCe1uJPKFN0f3gKvQ4PGDJ4DTvmfSFpBF+JGk
   AWe9W2mivzVaQYiWeKD/5bJ9Of+uJ1huHCbKAEqRU0cShLBjs1f2KjeJu
   g==;
X-CSE-ConnectionGUID: /1C1OVJBQIeVDsFnsIuwiA==
X-CSE-MsgGUID: bN4eJ/mWTbW7TCgJPnUAIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28017653"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="28017653"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 02:54:11 -0700
X-CSE-ConnectionGUID: 0s5dN4WdQjOsJMQlbJXyFw==
X-CSE-MsgGUID: itj0rx8IQVeEjxXoClz3DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="76636292"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 02:54:09 -0700
Date: Thu, 10 Oct 2024 17:53:09 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: peterx@redhat.com
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, yi1.lai@intel.smtp.subspace.kernel.org
Subject: [Syzkaller & bisect] There is general protection fault in
 pgtable_trans_huge_withdraw
Message-ID: <ZwekBRr9YxDqMVfO@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter and maintainers,

Greetings!

I used Syzkaller and found that there is general protection fault in pgtable_trans_huge_withdraw in v6.12-rc1

After bisection and the first bad commit is:
"
75182022a043 mm/x86: support large pfn mappings
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/241002_002120_pgtable_trans_huge_withdraw
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/241002_002120_pgtable_trans_huge_withdraw/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/241002_002120_pgtable_trans_huge_withdraw/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/241002_002120_pgtable_trans_huge_withdraw/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/241002_002120_pgtable_trans_huge_withdraw/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/241002_002120_pgtable_trans_huge_withdraw/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241002_002120_pgtable_trans_huge_withdraw/bzImage_9852d85ec9d492ebef56dc5f229416c925758edc
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/241002_002120_pgtable_trans_huge_withdraw/9852d85ec9d492ebef56dc5f229416c925758edc_dmesg.log

"
[   23.482154] CPU: 0 UID: 0 PID: 919 Comm: repro Tainted: G        W          6.12.0-rc1-9852d85ec9d4 #1
[   23.482987] Tainted: [W]=WARN
[   23.483321] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   23.484601] RIP: 0010:pgtable_trans_huge_withdraw+0x279/0x410
[   23.485301] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 51 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 10 4d 8d 74 24 08 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 37 01 00 00 4d 8b 6c 24 08 4d 39 ee 0f 84 b0 00
[   23.487438] RSP: 0018:ffff8880137677d8 EFLAGS: 00010202
[   23.488072] RAX: dffffc0000000000 RBX: ffffea00004ec680 RCX: ffffffff81bd2a29
[   23.488913] RDX: 0000000000000001 RSI: ffffffff81bd2b3e RDI: ffffea00004ec690
[   23.489753] RBP: ffff8880137677f8 R08: 0000000000000000 R09: ffffed10025539b0
[   23.490593] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   23.491432] R13: 1ffffffff0d89ab5 R14: 0000000000000008 R15: ffff888012a9cd80
[   23.492273] FS:  0000000000000000(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
[   23.493222] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.493907] CR2: 00007eff39f3f658 CR3: 0000000012942002 CR4: 0000000000770ef0
[   23.494749] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.495591] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   23.496424] PKRU: 55555554
[   23.496763] Call Trace:
[   23.497068]  <TASK>
[   23.497336]  ? show_regs+0x6d/0x80
[   23.497778]  ? die_addr+0x45/0xb0
[   23.498199]  ? exc_general_protection+0x1ae/0x340
[   23.498804]  ? asm_exc_general_protection+0x2b/0x30
[   23.499406]  ? pgtable_trans_huge_withdraw+0x119/0x410
[   23.500042]  ? pgtable_trans_huge_withdraw+0x22e/0x410
[   23.500671]  ? pgtable_trans_huge_withdraw+0x279/0x410
[   23.501295]  ? pgtable_trans_huge_withdraw+0x22e/0x410
[   23.501926]  zap_huge_pmd+0x48e/0xd40
[   23.502294]  unmap_page_range+0x1ad7/0x4320
[   23.502723]  ? __pfx_unmap_page_range+0x10/0x10
[   23.503156]  ? __this_cpu_preempt_check+0x21/0x30
[   23.503617]  unmap_single_vma+0x1ac/0x2d0
[   23.504005]  unmap_vmas+0x210/0x470
[   23.504361]  ? __pfx_unmap_vmas+0x10/0x10
[   23.504751]  ? __pfx_lock_release+0x10/0x10
[   23.505148]  ? trace_lock_acquire+0x139/0x1b0
[   23.505571]  ? __pfx_folio_batch_move_lru+0x10/0x10
[   23.506033]  ? lock_acquire+0x80/0xb0
[   23.506387]  ? mlock_drain_local+0x27f/0x4b0
[   23.506906]  exit_mmap+0x19e/0xb10
[   23.507342]  ? __pfx_exit_mmap+0x10/0x10
[   23.507840]  ? trace_hardirqs_on+0x51/0x60
[   23.508263]  ? kasan_quarantine_put+0xa2/0x200
[   23.508697]  ? __khugepaged_exit+0x266/0x4c0
[   23.509116]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   23.509624]  __mmput+0xde/0x3a0
[   23.509937]  mmput+0x74/0x90
[   23.510242]  do_exit+0xa03/0x2a30
[   23.510573]  ? lockdep_hardirqs_on+0x89/0x110
[   23.511006]  ? trace_hardirqs_on+0x51/0x60
[   23.511403]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   23.511996]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   23.512583]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
[   23.513156]  ? __pfx_do_exit+0x10/0x10
[   23.513529]  ? __audit_syscall_entry+0x39c/0x500
[   23.514024]  __x64_sys_exit+0x50/0x60
[   23.514430]  x64_sys_call+0x20c9/0x20d0
[   23.514885]  do_syscall_64+0x6d/0x140
[   23.515352]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.515970] RIP: 0033:0x7eff39c3ee5d
[   23.516409] Code: Unable to access opcode bytes at 0x7eff39c3ee33.
[   23.517135] RSP: 002b:00007eff39f5fd98 EFLAGS: 00000202 ORIG_RAX: 000000000000003c
[   23.518031] RAX: ffffffffffffffda RBX: 00007eff39f60640 RCX: 00007eff39c3ee5d
[   23.518838] RDX: 00007eff39d13945 RSI: 0000000000000000 RDI: 0000000000000000
[   23.519490] RBP: 00007eff39f5fdb0 R08: 0000000000000000 R09: 0000000000000000
[   23.520262] R10: 0000000000000000 R11: 0000000000000202 R12: 00007eff39f60640
[   23.521103] R13: 0000000000000000 R14: 00007eff39c9f560 R15: 0000000000000000
[   23.521956]  </TASK>
[   23.522233] Modules linked in:
[   23.522797] ---[ end trace 0000000000000000 ]---
[   23.523360] RIP: 0010:pgtable_trans_huge_withdraw+0x279/0x410
[   23.524057] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 51 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 10 4d 8d 74 24 08 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 37 01 00 00 4d 8b 6c 24 08 4d 39 ee 0f 84 b0 00
[   23.526296] RSP: 0018:ffff8880137677d8 EFLAGS: 00010202
[   23.527042] RAX: dffffc0000000000 RBX: ffffea00004ec680 RCX: ffffffff81bd2a29
[   23.527890] RDX: 0000000000000001 RSI: ffffffff81bd2b3e RDI: ffffea00004ec690
[   23.528811] RBP: ffff8880137677f8 R08: 0000000000000000 R09: ffffed10025539b0
[   23.529787] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   23.530635] R13: 1ffffffff0d89ab5 R14: 0000000000000008 R15: ffff888012a9cd80
[   23.531477] FS:  0000000000000000(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
[   23.532432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.533155] CR2: 00007eff39f3f658 CR3: 0000000012942002 CR4: 0000000000770ef0
[   23.534008] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.534855] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   23.535702] PKRU: 55555554
[   23.536054] note: repro[919] exited with preempt_count 1
[   23.536692] Fixing recursive fault but reboot is needed!
[   23.537355] BUG: using smp_processor_id() in preemptible [00000000] code: repro/919
[   23.538260] caller is debug_smp_processor_id+0x20/0x30
[   23.538889] CPU: 0 UID: 0 PID: 919 Comm: repro Tainted: G      D W          6.12.0-rc1-9852d85ec9d4 #1
[   23.539988] Tainted: [D]=DIE, [W]=WARN
[   23.540438] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   23.541767] Call Trace:
[   23.542073]  <TASK>
[   23.542341]  dump_stack_lvl+0x121/0x150
[   23.542825]  dump_stack+0x19/0x20
[   23.543241]  check_preemption_disabled+0x168/0x180
[   23.543834]  debug_smp_processor_id+0x20/0x30
[   23.544372]  __schedule+0xa0/0x33a0
[   23.544812]  ? do_task_dead+0xa8/0x110
[   23.545273]  ? debug_smp_processor_id+0x20/0x30
[   23.545833]  ? rcu_is_watching+0x19/0xc0
[   23.546318]  ? lock_release+0x592/0x870
[   23.546803]  ? __pfx___schedule+0x10/0x10
"

I hope you find it useful.

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

