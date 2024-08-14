Return-Path: <linux-kernel+bounces-286252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9F19518AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238101F239B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C616B1AD9F6;
	Wed, 14 Aug 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NuMSZVJH"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA91AD9DE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631232; cv=none; b=N9CLH7hfi4ClfPnxdDhJTQVyoy1+JxOE60MXd/AFxk4t2087iGdz7+tHTC3M7upmnSfKYnsBDdAqIXJsmzEWG3QNvFuitT+9U60VCbSw0lkVzSN1km8ki4lAuHzRklAj862F2cZNzmJZqQcazq1K63AGAM8lawK/Smrmgi7+spY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631232; c=relaxed/simple;
	bh=NFd//9rvuW/5AfMJD4NStL+5w9YGT8NLe7gO4v888AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m34bfPqvHtHohfDoVWaK6Mk6aTu9VPV1WNv13VqvL3ZihQczdnAKggBbY7PxO+wFCST6IVvqT/dWk6H+yC822RQ0vHv8lEXBa1POpcqCGriqbYNbGx2k4XQfX5G20n6lNoaznU4nQ8YB+r6Khb2oJHae8avD4bppxW13EeGpAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NuMSZVJH; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f2c8e99c0fso2237352e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723631228; x=1724236028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qZiDUHoYgeH6Nw5eD9esliOomFOFpX11zNwcrK4A4zE=;
        b=NuMSZVJHVBu6UTtESIEaFSI/SN5etMexxZcMf40LD+lMSu/BhdJKa8ZCT0nEkg4kQ4
         2IZexoYPnNSKabANq2dUYOgCHDQLaCxOtOw5ZVSBu67p1cxq+OtTx8UJv9oCuAizI+Yu
         YI7tdn/DNmuKP4AAfyOMlUb0Qth0HzSzjrS1lIdJ0gcWgDx4ga9K1xex4W3uLy8mY5nJ
         9lrMhv3EN4v6yd/poLic7B2jnTtY/9LlrQo89gif6nu44bF63S4d1BG1aBMMz9NmgcPZ
         R8F2B3OD0T1VVk8z26YLe8anNGnRt8ojqD3GN3RP1FdMeiLDEvTMx3d9Z+yPStkGXueS
         iXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631228; x=1724236028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZiDUHoYgeH6Nw5eD9esliOomFOFpX11zNwcrK4A4zE=;
        b=SgN6Esu/MlUvftmX4xS8cD5RWqYy0twrFecHR4+2ffl5t56p1ufyUoeo3p7v27Fyk7
         d7CfJGbZEt+PgJzYvSXrQrUICFlXTkwf1BUfIszvcU+WbmOBJQ9fpuYOdXLT57iAwKYk
         SYQ6dJk4Za/tdh8E7PnwaQw51Mji+izNDkYRNCa4fLuea3PTmjtquXspcjtJ+Obva3Hq
         rfQVdeAmF43MJgheNnCLg73kFCZ3fZ4n0zVDuecVRret3c7R5U/76af5JSlcAh/d2zkx
         glHXaCbrQwpMlJpeWl41coPSfzOK53P5dGPMT2U2N9pMmylwj17/iQau9hnKI5yVnRcn
         tWYA==
X-Gm-Message-State: AOJu0YzLmcKvLMgyhkNVJ2/GHq1UTimzYw1debJwf7zIZd0pMk5rs4db
	ZPd592SYi5WED9Pzz54/avSKHBRkpWYDIbqHiQ4atmfAFkvf8qAI51R+zyCXZ23sKgAYG8cjSLo
	vbL97qz3VtlyeALWYTv8qdvNcrFEX7lJ7Ryr5pPsq1NoovfTOqHQ=
X-Google-Smtp-Source: AGHT+IEZQLTPuqAIwcCEYngNT/EgYitRatZi9G4a93T/n23io4rsnyUMn72jWYsiRKonY0tY7n6Y3HLh4JhGEgdrY3w=
X-Received: by 2002:a05:6122:3c8f:b0:4f5:261a:bdae with SMTP id
 71dfb90a1353d-4fad2358458mr3129650e0c.14.1723631228257; Wed, 14 Aug 2024
 03:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuD4-qKAX9nDS-3cy+HwGbyJ6WoD7bZ_QL0J__A++P9aA@mail.gmail.com>
In-Reply-To: <CA+G9fYuD4-qKAX9nDS-3cy+HwGbyJ6WoD7bZ_QL0J__A++P9aA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 14 Aug 2024 15:56:56 +0530
Message-ID: <CA+G9fYuYfNA7NZDHpq2K24CsUn21LAb8vn38=JTz=54bsdSd9g@mail.gmail.com>
Subject: Re: next: x86_64: ahci 0000:00:1f.2: probe with driver ahci failed
 with error -12
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Christoph Hellwig <hch@lst.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Matthew Brost <matthew.brost@intel.com>, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 15:15, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The qemu-x86_64 boot failed with today's Linux next-20240814 tag due to
> following crash.
>
> The catch here is the crash seen on both x86_64 device and qemu-x86_64
> but x86_64 device is able to boot successfully.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Boot log:
> ---
> [    0.000000] Linux version 6.11.0-rc3-next-20240814
> (tuxmake@tuxmake) (x86_64-linux-gnu-gcc (Debian 13.3.0-1) 13.3.0, GNU
> ld (GNU Binutils for Debian) 2.42.50.20240625) #1 SMP PREEMPT_DYNAMIC
> @1723614704
> ...
> <6>[    2.479915] scsi host0: ahci
> <4>[    2.484371] sysfs: cannot create duplicate filename
> '/devices/virtual/workqueue/scsi_tmf_-1073661392'

Anders bisected to the following first commit and reverted this commit
and qemu-x86_64 boot successful now.

# first bad commit: [b188c57af2b5c17a1e8f71a0358f330446a4f788]
      workqueue: Split alloc_workqueue into internal function and lockdep init

original report link:
https://lore.kernel.org/all/CA+G9fYuD4-qKAX9nDS-3cy+HwGbyJ6WoD7bZ_QL0J__A++P9aA@mail.gmail.com/

> <4>[    2.486170] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.11.0-rc3-next-20240814 #1
> <4>[    2.486709] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> <4>[    2.486709] Call Trace:
> <4>[    2.486709]  <TASK>
> <4>[    2.486709]  dump_stack_lvl+0x96/0xb0
> <4>[    2.486709]  dump_stack+0x14/0x20
> <4>[    2.486709]  sysfs_warn_dup+0x5f/0x80
> <4>[    2.486709]  sysfs_create_dir_ns+0xd0/0xf0
> <4>[    2.486709]  kobject_add_internal+0xa8/0x2e0
> <4>[    2.486709]  kobject_add+0x97/0x100
> <4>[    2.486709]  ? get_device_parent+0x109/0x1d0
> <4>[    2.486709]  device_add+0xe4/0x880
> <4>[    2.486709]  ? hrtimer_init+0x2b/0x80
> <4>[    2.486709]  device_register+0x1e/0x30
> <4>[    2.486709]  workqueue_sysfs_register+0x91/0x140
> <4>[    2.486709]  __alloc_workqueue+0x664/0x800
> <4>[    2.486709]  ? trace_preempt_on+0x1e/0x70
> <4>[    2.486709]  ? __kthread_create_on_node+0x108/0x170
> <4>[    2.486709]  alloc_workqueue+0x5a/0x80
> <4>[    2.486709]  ? __kthread_create_on_node+0x108/0x170
> <4>[    2.486709]  scsi_host_alloc+0x365/0x470
> <4>[    2.486709]  ata_scsi_add_hosts+0xc2/0x130
> <4>[    2.486709]  ata_host_register+0xb5/0x260
> <4>[    2.486709]  ata_host_activate+0xe9/0x140
> <4>[    2.486709]  ahci_host_activate+0x16a/0x190
> <4>[    2.486709]  ahci_init_one+0xe0f/0x1080
> <4>[    2.486709]  ? trace_preempt_on+0x1e/0x70
> <4>[    2.486709]  local_pci_probe+0x48/0xa0
> <4>[    2.486709]  pci_device_probe+0xc6/0x1f0
> <4>[    2.486709]  really_probe+0xcc/0x3b0
> <4>[    2.486709]  __driver_probe_device+0x7d/0x160
> <4>[    2.486709]  driver_probe_device+0x24/0xa0
> <4>[    2.486709]  __driver_attach+0xdd/0x1d0
> <4>[    2.486709]  ? __pfx___driver_attach+0x10/0x10
> <4>[    2.486709]  bus_for_each_dev+0x91/0xe0
> <4>[    2.486709]  driver_attach+0x22/0x30
> <4>[    2.486709]  bus_add_driver+0x118/0x240
> <4>[    2.486709]  driver_register+0x62/0x120
> <4>[    2.486709]  ? __pfx_ahci_pci_driver_init+0x10/0x10
> <4>[    2.486709]  __pci_register_driver+0x62/0x70
> <4>[    2.486709]  ahci_pci_driver_init+0x22/0x30
> <4>[    2.486709]  do_one_initcall+0x62/0x250
> <4>[    2.486709]  kernel_init_freeable+0x1ba/0x310
> <4>[    2.486709]  ? __pfx_kernel_init+0x10/0x10
> <4>[    2.486709]  kernel_init+0x1e/0x1d0
> <4>[    2.486709]  ret_from_fork+0x41/0x60
> <4>[    2.486709]  ? __pfx_kernel_init+0x10/0x10
> <4>[    2.486709]  ret_from_fork_asm+0x1a/0x30
> <4>[    2.486709]  </TASK>
> <3>[    2.508109] kobject: kobject_add_internal failed for
> scsi_tmf_-1073661392 with -EEXIST, don't try to register things with
> the same name in the same directory.
> <4>[    2.519098] scsi host1: failed to create tmf workq
> <6>[    2.524520] kworker/R-scsi_ (56) used greatest stack depth:
> 15464 bytes left
> <6>[    2.528402] scsi_eh_1 (55) used greatest stack depth: 14872 bytes left
> <3>[    2.540312] ahci 0000:00:1f.2: probe with driver ahci failed
> with error -12
>
> Full dmesg log:
> -----------
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240814/testrun/24850492/suite/boot/test/gcc-13-lkftconfig-rcutorture/log
>
> Reproduce script:
> ---
>  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2kdXPeyCZIUn4AYH0UrByWXzepD/reproducer
>  - Qemu version: 8.2.4
>
> Boot command: /usr/bin/qemu-system-x86_64 -cpu Nehalem -machine q35
> -nographic -nic none -m 4G -monitor none -no-reboot -smp 2 -kernel
> kernel/bzImage -append \"console=ttyS0,115200 rootwait root=/dev/sda
> debug verbose console_msg_format=syslog systemd.log_level=warning rw
> earlycon\" -drive file=rootfs.ext4,if=ide,format=raw"
>
> Build link:
> ------
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2kdXMb8C1EcMoXxMdKTWd4TB8Ef/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2kdXMb8C1EcMoXxMdKTWd4TB8Ef/config
>
> metadata:
> ---
>   git_ref: master
>   git_describe: next-20240814
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   kernel_version: 6.11.0-rc3
>   arch: x86
>   device: qemu-x86_64
>
> Please let me know if you need more information.
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh

