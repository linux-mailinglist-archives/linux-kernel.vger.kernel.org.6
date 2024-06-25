Return-Path: <linux-kernel+bounces-228511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248819160FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476711C221DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7569C1474AF;
	Tue, 25 Jun 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyu8LFsz"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67A41482E2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303758; cv=none; b=CIK3IB2IopDkBZrleoCMknJd5tk4tYfBd0WlfXaYIEORhzFaimkMhjQDoWDGBN0fST12LWyMbdt1PV4LSEMwlk0TIZbi2m/WchT69WlVeS+mIZVlas1auwSgdTxuXGvATPqOu2TZi0ejfmAW+8pbkocQCw0g2g1bAaQaNFV6BkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303758; c=relaxed/simple;
	bh=q3E3dGdtCM71+QRRx3SHcZEfir1hEQDIXUBtIQmv9Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQKWlKDbGXshOs7mblhM17C3GmJo2kxzHA/zoSEMzCOJLIhu0ZZSfFmAq4MZ1FbxGQQjj7R5+xV55B2D/yqCj+noAoLr2P3z5HwrvnUV3WLao2IAn/h2CNDs3AfZjyb7xnpxRpGhXE9VLB7PlT2nX2OdEctcsuQ/Ec6H20bwF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gyu8LFsz; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4ef7fc70bdeso615938e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719303756; x=1719908556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qEP05P40nk7SAgQxi5RiMfzgaHpEMg1zIMuHf+ke+YY=;
        b=gyu8LFszGLM9T1WySBWEffClVeUTWJjdc9/ASIJXoOkLQELGKRAsSL7v7vJMC4ALWN
         o6hnGD8Bi2DCTkI7Sq1h+43CAkxtliFJJZIx8eZ8Y7zBIcG3D0w3nwaS0dstFdgIkHjc
         2uHf6Z5Yf9bnZaqkA/a2DmCj8B+WO+MFwUcnNBmqsI8vmv6PGsOw1EGCxms/ETHdVEKc
         GEP/aFKrPygogJ5iU0KihJb9iY/z3WRY6+/Gwywvg9FakqOiWodUF4UgMejHQy9DepES
         vznSCkELt5cJDFU+vufoDjUeXjPctOBcKr2P4wJU0Xwxzr++zQUjUELNc5y3kHbe/hMG
         Q3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719303756; x=1719908556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEP05P40nk7SAgQxi5RiMfzgaHpEMg1zIMuHf+ke+YY=;
        b=hTiognd4U0Q0pD2MDCXzv0MV+MLiutdZElx6gMt/ayESaUfNiPa/6y1ctNpuS3Xa6Q
         Ugm0IYMCvo3aEJb5DFJDNSAj4V35jPPYTvnS8QnECChw0gVgLwz+JIMnKnUGIvariRVZ
         HLr2nktRYGGMJOhawHvLeThukLcDTz7JHD84huCZ7iFfxHVlEQeSyuqZ94YjY1cIN+Kf
         rdLrhI8JINkSu7mhWg9kmJItfeEhPgGVcU6Aynfm7qpB6b0fcLvvdk/yOBxPl77fPEIm
         p5nK23TAUPn0InxBaISIoDOI6ZUJV1JrA+bmqbCxyIx3aoQL56jVPki3kjgS3z1k/hwv
         6D0A==
X-Forwarded-Encrypted: i=1; AJvYcCXkQCYlHLoret7perDZPyjMO/g5OGnb9tpJODXggO/eeG1vmtNG2AkCLqo12/sjEyC0tVnpQ3x0PRQjJPGvBrL5LTxTIath1FROPrE4
X-Gm-Message-State: AOJu0YyDsEHbhGR8QHOskRqRpwrxvzcD9m5tmvSGOW6SNxt/d2J+fETU
	UgqycvjDagm1pMX7ikPHKNJIGUtskfuRg9idl91YOTNfTrYwopT4oQS59YskfD2BomcDVbRnRLQ
	HlgbIVj61hfQBCb9PQPCFtqmWZfoRMYR5XEgN
X-Google-Smtp-Source: AGHT+IEy9AYuGGnXoDB2FdmBMb20N9x2ECobhyXY92CuRxn0cRwTW2HO8/NjYwjxLO8bw0y/xuLgNGUoA+k9MHv2oVc=
X-Received: by 2002:a05:6122:1ad0:b0:4eb:12da:14c7 with SMTP id
 71dfb90a1353d-4ef6d8042f5mr5497809e0c.6.1719303755431; Tue, 25 Jun 2024
 01:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZnooRgso2Y6RKwp9@xpf.sh.intel.com>
In-Reply-To: <ZnooRgso2Y6RKwp9@xpf.sh.intel.com>
From: Marco Elver <elver@google.com>
Date: Tue, 25 Jun 2024 10:21:57 +0200
Message-ID: <CANpmjNPODYdQ0mdPCF5-K5wdWZdUdRhYKsxH7vtxokeQjiZHxw@mail.gmail.com>
Subject: Re: [Syzkaller & bisect] There is BUG: MAX_LOCKDEP_KEYS too low! in
 v6.10-rc5 kernel
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: andreyknvl@gmail.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 04:15, Pengfei Xu <pengfei.xu@intel.com> wrote:
>
> Hi Andrey,
>
> Greeting!
>
> There is BUG: MAX_LOCKDEP_KEYS too low! in v6.10-rc5 kernel.
>
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240624_120854__MAX_LOCKDEP_KEYS_too_low
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/repro.c
> Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/repro.prog
> Mount img: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/mount_0.gz
> Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/repro.report
> Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/bisect_info.log
> v6.10-rc5 dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/f2661062f16b2de5d7b6a5c42a9a5c96326b8454_dmesg.log
>
> Bisected and found related commit:
> cc478e0b6bdf kasan: avoid resetting aux_lock

This is known to trigger on heavily instrumented kernels.

On syzbot we just increase CONFIG_LOCKDEP_BITS and friends [1]. See [2].

[1] https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/lockdep.yml
[2] https://github.com/torvalds/linux/blob/55027e689933ba2e64f3d245fb1ff185b3e7fc81/lib/Kconfig.debug#L1505

I don't see it set in your config. You should probably enable it on
heavily instrumented builds.

> "
> [  157.974013] BUG: MAX_LOCKDEP_KEYS too low!
> [  157.974233] turning off the locking correctness validator.
> [  157.974459] CPU: 1 PID: 736 Comm: repro Tainted: G        W          6.10.0-rc5-f2661062f16b+ #1
> [  157.974864] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [  157.975392] Call Trace:
> [  157.975502]  <TASK>
> [  157.975600]  dump_stack_lvl+0xea/0x150
> [  157.975786]  dump_stack+0x19/0x20
> [  157.975937]  register_lock_class+0xaee/0x10d0
> [  157.976136]  ? __pfx_register_lock_class+0x10/0x10
> [  157.976351]  ? __pfx_mark_lock.part.0+0x10/0x10
> [  157.976553]  __lock_acquire+0xfe/0x5ca0
> [  157.976727]  ? __pfx_mark_lock.part.0+0x10/0x10
> [  157.976929]  ? __pfx_register_lock_class+0x10/0x10
> [  157.977140]  ? __kasan_check_read+0x15/0x20
> [  157.977325]  ? __pfx___lock_acquire+0x10/0x10
> [  157.977517]  ? __kasan_check_read+0x15/0x20
> [  157.977696]  ? mark_lock.part.0+0xf3/0x17a0
> [  157.977878]  ? __kasan_check_read+0x15/0x20
> [  157.978059]  lock_acquire+0x1ce/0x580
> [  157.978221]  ? touch_wq_lockdep_map+0x75/0x130
> [  157.978416]  ? register_lock_class+0xbf/0x10d0
> [  157.978610]  ? __pfx_lock_acquire+0x10/0x10
> [  157.978794]  ? __pfx_register_lock_class+0x10/0x10
> [  157.979000]  ? lockdep_init_map_type+0x2df/0x810
> [  157.979201]  ? lockdep_init_map_type+0x2df/0x810
> [  157.979403]  ? touch_wq_lockdep_map+0x75/0x130
> [  157.979598]  touch_wq_lockdep_map+0x8a/0x130
> [  157.979786]  ? touch_wq_lockdep_map+0x75/0x130
> [  157.979988]  __flush_workqueue+0xfd/0x1040
> [  157.980164]  ? __this_cpu_preempt_check+0x21/0x30
> [  157.980370]  ? lock_release+0x418/0x840
> [  157.980542]  ? __pfx___flush_workqueue+0x10/0x10
> [  157.980745]  ? __mutex_unlock_slowpath+0x16f/0x630
> [  157.980979]  ? xfs_log_force+0x1db/0xa30
> [  157.981191]  ? sync_filesystem+0x1e5/0x2a0
> [  157.981386]  xlog_cil_push_now.isra.0+0x6c/0x210
> [  157.981588]  xlog_cil_force_seq+0x1d4/0x790
> [  157.981775]  ? __pfx_xlog_cil_force_seq+0x10/0x10
> [  157.981982]  ? xfs_fs_sync_fs+0x1ed/0x3a0
> [  157.982157]  ? debug_smp_processor_id+0x20/0x30
> [  157.982358]  ? rcu_is_watching+0x19/0xc0
> [  157.982532]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  157.982767]  ? sync_filesystem+0x1e5/0x2a0
> [  157.982944]  xfs_log_force+0x1db/0xa30
> [  157.983109]  ? sync_filesystem+0x1e5/0x2a0
> [  157.983287]  ? sync_filesystem+0x1e5/0x2a0
> [  157.983464]  xfs_fs_sync_fs+0x1ed/0x3a0
> [  157.983632]  ? __pfx_xfs_fs_sync_fs+0x10/0x10
> [  157.983821]  sync_filesystem+0x1e5/0x2a0
> [  157.983990]  generic_shutdown_super+0x8c/0x520
> [  157.984183]  kill_block_super+0x45/0xa0
> [  157.984349]  xfs_kill_sb+0x1e/0x60
> [  157.984498]  deactivate_locked_super+0xcb/0x1c0
> [  157.984694]  deactivate_super+0xc0/0xe0
> [  157.984865]  cleanup_mnt+0x2fc/0x460
> [  157.985023]  __cleanup_mnt+0x1f/0x30
> [  157.985179]  task_work_run+0x19c/0x2b0
> [  157.985343]  ? __pfx_task_work_run+0x10/0x10
> [  157.985528]  ? __this_cpu_preempt_check+0x21/0x30
> [  157.985734]  ? syscall_exit_to_user_mode+0x109/0x200
> [  157.985951]  syscall_exit_to_user_mode+0x1ec/0x200
> [  157.986160]  do_syscall_64+0x79/0x140
> [  157.986322]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  157.986536] RIP: 0033:0x7fab3634e87b
> [  157.986692] Code: 0f 1e fa 48 89 fe 31 ff e9 72 08 00 00 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 71 b5 0a 00 f7 d8
> [  157.987430] RSP: 002b:00007ffc181e2598 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
> [  157.987742] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fab3634e87b
> [  157.988031] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc181e2640
> [  157.988321] RBP: 00007ffc181e3680 R08: 0000000000000000 R09: 00007ffc181e2430
> [  157.988611] R10: 00007fab363b13e0 R11: 0000000000000202 R12: 00007ffc181e37f8
> [  157.988761] XFS (loop7): Ending clean mount
> [  157.988901] R13: 0000000000403138 R14: 000000000040fe08 R15: 00007fab36460000
> [  157.989407]  </TASK>
> "
>
> I hope it's helpful.
>
> Thanks!
>
> ---
>
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
>
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>
> Best Regards,
> Thanks!

