Return-Path: <linux-kernel+bounces-358367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69576997DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE881C23D14
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D12E1B1422;
	Thu, 10 Oct 2024 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POY0Y5kS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7E405F7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543362; cv=none; b=lzTWUmMwD5IQvWg+1OUKUQ+y7tSo8j3u687XhixQGU8BiNQuP3ruPZhKW66H2Z8i031LR82ZxHtcPT2s8zPJ02LI6EGkROxAzE4II97SS1FFmcNpXpeQ+7T3k+1bPPCDIQd3RGCzLrj23InsRH/Cx+/78gzg5ZpCUkfgW0xaWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543362; c=relaxed/simple;
	bh=GE3cN8XKUsb50L8TY8wE/OA6CSMrpVvX3vdbqnIjhL8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aQjDxeEmElEEOM9VpuYKrHUlnBa8apYdYMtYySbHQ5vvy2YuvpDeA75rB5bwOsJ/9NpHsWIso3e1OtwOF+ltbuvGrLlvh2UvbW2F2n2PR9nRAXz65f3w0bhKtCyGjWHbVPEKvO+fJkj66Nk4BCzLYpQ+xcj+DveV1t0MhHwUQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=POY0Y5kS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728543361; x=1760079361;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GE3cN8XKUsb50L8TY8wE/OA6CSMrpVvX3vdbqnIjhL8=;
  b=POY0Y5kS2Ycg4C61J03oNH6egLuU8mf+xdbzZ2c+bY2eo19T3aL5tc6b
   QKzcEftZGYvmDY4i07QhJ6Oo9ksfBHO9nJMfxpj45hLpZoeZh7KwzWCtt
   43zGB8KixLOVNCThzYIyKI7T87h95JsSY1/fieI2qHjQihELL5b1JN9aj
   MmvdfixGHnnuQHrDKBX+DcM30vtG7k4QuHtxBrWT+XzsXEUChGjuGgEu7
   qBQOTvdrLno3SDa57IaYYc5ElG3PbpYheFocKSVbMzPk7HJrXgS/uJvQq
   hrCEea66QASqDm9IFUOg4dkd0Bye5WO4VvKnyMVcRTVJo2Ggc+2LlURGn
   Q==;
X-CSE-ConnectionGUID: 9AZUiI/QRIazbFtZb8IPzg==
X-CSE-MsgGUID: RcwMxeBdT+Wu3kVuMyDymA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45358337"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="45358337"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:56:00 -0700
X-CSE-ConnectionGUID: NT1KxAQwSwifoq35GRfjDQ==
X-CSE-MsgGUID: kWXJEQ98R52dZIhx8PprDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="76151548"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:55:58 -0700
Date: Thu, 10 Oct 2024 14:54:59 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: willy@infradead.org
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [Syzkaller & bisect] There is possible deadlock in
 __bpf_ringbuf_reserve
Message-ID: <Zwd6Qw9ZBBDC1cjy@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

linux-kernel@vger.kernel.org,syzkaller-bugs@googlegroups.com,yi1.lai@intel.com
Bcc: 
Subject: [Syzkaller & bisect] There is possible deadlock in
 __bpf_ringbuf_reserve in linux next
Reply-To: 

Hi Matthew,

Greetings!

I used Syzkaller and found that there is possible deadlock in __bpf_ringbuf_reserve in Linux-next tree

After bisection and the first bad commit is:
"
cb995f4eeba9 filemap: Handle sibling entries in filemap_get_read_batch()
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/241001_120142___bpf_ringbuf_reserve
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/241001_120142___bpf_ringbuf_reserve/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/241001_120142___bpf_ringbuf_reserve/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/241001_120142___bpf_ringbuf_reserve/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/241001_120142___bpf_ringbuf_reserve/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/241001_120142___bpf_ringbuf_reserve/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241001_120142___bpf_ringbuf_reserve/bzImage_9852d85ec9d492ebef56dc5f229416c925758edc
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/241001_120142___bpf_ringbuf_reserve/9852d85ec9d492ebef56dc5f229416c925758edc_dmesg.log

"
[   17.246785] 6.12.0-rc1-9852d85ec9d4 #1 Not tainted
[   17.247068] --------------------------------------------
[   17.247361] repro/753 is trying to acquire lock:
[   17.247639] ffffc9000135c0d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x386/0x460
[   17.248186]
[   17.248186] but task is already holding lock:
[   17.248531] ffffc900014fa0d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x386/0x460
[   17.249053]
[   17.249053] other info that might help us debug this:
[   17.249435]  Possible unsafe locking scenario:
[   17.249435]
[   17.249783]        CPU0
[   17.249936]        ----
[   17.250090]   lock(&rb->spinlock);
[   17.250303]   lock(&rb->spinlock);
[   17.250516]
[   17.250516]  *** DEADLOCK ***
[   17.250516]
[   17.250866]  May be due to missing lock nesting notation
[   17.250866]
[   17.251267] 5 locks held by repro/753:
[   17.251496]  #0: ffffffff87172f68 (tracepoints_mutex){+.+.}-{3:3}, at: tracepoint_probe_unregister+0x39/0xc70
[   17.252099]  #1: ffffffff87172f20 (tracepoints_mutex.wait_lock){+.+.}-{2:2}, at: __mutex_lock+0x100e/0x1490
[   17.252697]  #2: ffffffff8705c9c0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1b7/0x5a0
[   17.253217]  #3: ffffc900014fa0d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x386/0x460
[   17.253766]  #4: ffffffff8705c9c0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1b7/0x5a0
[   17.254284]
[   17.254284] stack backtrace:
[   17.254551] CPU: 0 UID: 0 PID: 753 Comm: repro Not tainted 6.12.0-rc1-9852d85ec9d4 #1
[   17.255020] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.255686] Call Trace:
[   17.255844]  <TASK>
[   17.255980]  dump_stack_lvl+0xea/0x150
[   17.256223]  dump_stack+0x19/0x20
[   17.256434]  print_deadlock_bug+0x3c5/0x680
[   17.256700]  __lock_acquire+0x2a85/0x5c90
[   17.256954]  ? __pfx___lock_acquire+0x10/0x10
[   17.257224]  ? __kasan_check_read+0x15/0x20
[   17.257486]  ? __lock_acquire+0xd87/0x5c90
[   17.257741]  ? __pfx_mark_lock.part.0+0x10/0x10
[   17.258023]  lock_acquire.part.0+0x142/0x390
[   17.258289]  ? __bpf_ringbuf_reserve+0x386/0x460
[   17.258574]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   17.258868]  ? __lock_acquire+0xd87/0x5c90
[   17.259131]  ? debug_smp_processor_id+0x20/0x30
[   17.259414]  ? rcu_is_watching+0x19/0xc0
[   17.259669]  ? trace_lock_acquire+0x139/0x1b0
[   17.259956]  lock_acquire+0x80/0xb0
[   17.260178]  ? __bpf_ringbuf_reserve+0x386/0x460
[   17.260472]  _raw_spin_lock_irqsave+0x52/0x80
[   17.260754]  ? __bpf_ringbuf_reserve+0x386/0x460
[   17.261050]  __bpf_ringbuf_reserve+0x386/0x460
[   17.261339]  ? trace_lock_acquire+0x139/0x1b0
[   17.261629]  bpf_ringbuf_reserve+0x63/0xa0
[   17.261898]  bpf_prog_9efe54833449f08e+0x2e/0x48
[   17.262200]  bpf_trace_run2+0x238/0x5a0
[   17.262454]  ? __pfx_bpf_trace_run2+0x10/0x10
[   17.262734]  ? __lock_acquire+0x1b0f/0x5c90
[   17.263016]  ? pndisc_destructor+0x1c0/0x250
[   17.263301]  ? __pfx___bpf_trace_contention_end+0x10/0x10
[   17.263628]  __bpf_trace_contention_end+0xf/0x20
[   17.263914]  __traceiter_contention_end+0x66/0xb0
[   17.264204]  trace_contention_end.constprop.0+0xdc/0x140
[   17.264534]  __pv_queued_spin_lock_slowpath+0x29a/0xc80
[   17.264881]  ? __pfx___pv_queued_spin_lock_slowpath+0x10/0x10
[   17.265247]  do_raw_spin_lock+0x1fb/0x280
[   17.265506]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   17.265792]  ? lock_acquire+0x80/0xb0
[   17.266029]  ? __bpf_ringbuf_reserve+0x386/0x460
[   17.266329]  _raw_spin_lock_irqsave+0x5a/0x80
[   17.266604]  ? __bpf_ringbuf_reserve+0x386/0x460
[   17.266891]  __bpf_ringbuf_reserve+0x386/0x460
[   17.267180]  ? trace_lock_acquire+0x139/0x1b0
[   17.267463]  bpf_ringbuf_reserve+0x63/0xa0
[   17.267720]  bpf_prog_9efe54833449f08e+0x2e/0x48
[   17.268003]  bpf_trace_run2+0x238/0x5a0
[   17.268244]  ? __pfx_bpf_trace_run2+0x10/0x10
[   17.268521]  ? __kasan_check_write+0x18/0x20
[   17.268784]  ? do_raw_spin_lock+0x141/0x280
[   17.269046]  ? __pfx___bpf_trace_contention_end+0x10/0x10
[   17.269375]  __bpf_trace_contention_end+0xf/0x20
[   17.269661]  __traceiter_contention_end+0x66/0xb0
[   17.269952]  trace_contention_end+0xc5/0x120
[   17.270218]  ? __mutex_lock+0x1035/0x1490
[   17.270468]  __mutex_lock+0x6bd/0x1490
[   17.270705]  ? tracepoint_probe_unregister+0x39/0xc70
[   17.271021]  ? __pfx___mutex_lock+0x10/0x10
[   17.271281]  ? delete_node+0x219/0x750
[   17.271529]  ? __pfx_bpf_link_release+0x10/0x10
[   17.271816]  mutex_lock_nested+0x1f/0x30
[   17.272062]  ? mutex_lock_nested+0x1f/0x30
[   17.272318]  tracepoint_probe_unregister+0x39/0xc70
[   17.272618]  ? __pfx_bpf_link_release+0x10/0x10
[   17.272900]  ? __pfx___bpf_trace_contention_end+0x10/0x10
[   17.273228]  ? __pfx_bpf_link_release+0x10/0x10
[   17.273510]  bpf_probe_unregister+0x5b/0x90
[   17.273773]  bpf_raw_tp_link_release+0x3f/0x80
[   17.274050]  bpf_link_free+0x139/0x2d0
[   17.274288]  bpf_link_release+0x68/0x80
[   17.274530]  __fput+0x414/0xb60
[   17.274737]  ____fput+0x22/0x30
[   17.274938]  task_work_run+0x19c/0x2b0
[   17.275185]  ? __pfx_task_work_run+0x10/0x10
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

