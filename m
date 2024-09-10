Return-Path: <linux-kernel+bounces-322486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1D97298D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049BF1F25335
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9491171088;
	Tue, 10 Sep 2024 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAmVfXXt"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF81CD2A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949852; cv=none; b=ecRK8xJKh7FhA5F4XepLaQrTNA/qRJUQh+DCroZioYO28vbRU3ndUu6LGpius9HtjFgZV7oOiL/xVCgBM67R70jHmBLyYBq8EFjdUJV3bARvn8GmSNvxpEzKsbB7eC2MA7Ib/1OzTJhtPlJ0nMwE073jitti1uasx9/ANQTH0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949852; c=relaxed/simple;
	bh=8TUhyosW1mn6dhs0vzSHjHcv5R7Ozezk7pxxBzixU3I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q7LZVEo0Jp8g1zD++7tx8Xdkie1qHaFXJyYektjPzn54zcPHaB7WFCbKFR1n0mBNfuQw7QqW9zvfAoZh5v1LIndY4x84ER+zcu+UK+aD4/J1UxfLTITfEf+OBXnnHfHVg9yWuMPgU2tcuq23+iHPzr7AQu+PlWkl7wm6MVCPaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAmVfXXt; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-502aeeb791eso2122876e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725949849; x=1726554649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D29wqIU/MqdK42Hyv0CohOkSOr39XuSIDBy4dPZxDgM=;
        b=YAmVfXXtnMJ5zJwcH0vFeFtgcYRfm52h6Uu7LYJ1zKL1bUpK+fpJWq1EIsbihghjto
         ZecUw5GFnvsP3RUCmU7TeEVMRTjrSpOt2QAD1rcSfcfPv1QFaBI7DcOpwdE2FJUzePPB
         nE5PO5iNv1nrdX1LSeHVCRrui+MAOC1MtwFHKa+x+11lSIZaxl0QDZfPk7CNBNm3Vdun
         6wTtxNad4SDx7gfIrQ+kzALJF0JR3u9uZp8KaegxpUrUrRnJhjDgGTQaV+R2azNlJ828
         Cz6dFMGL6d/nk5jKVjdG7QQCtsxYVfUnyQ3sJ4QAkIQbKmvwt0vgChRYvYExrtoKcOqv
         OzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725949849; x=1726554649;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D29wqIU/MqdK42Hyv0CohOkSOr39XuSIDBy4dPZxDgM=;
        b=dIol489tR2JCELh+fc8Y/BcOHjEMK2OF4Z+Kt9Jo9rOTLuwrYygeyQQkueOmk8lsoI
         K3OqRR3Uun+HHfnNlWYKXsA9O5VUNPmoewN0JB55GkBo93qy1tyE3pvicPsESQ4X/Z/H
         8tflIPKgjDdlT/f+2P6tXZaDqN5azm3irZ+dlL5MjF2NwMLnsoqZoM9znORSwY29vjRl
         VTwwfQoZt+TmlENPpk4ElXL06Jd79K4+d1X7Gx+tKheQT3cLaboIR12OM3fLZrtDWlLN
         e9aOov6V6x/Xl2gyC58MDZEg0c67p+J2oA/yfUL2kaXztuBh0uVx4hSuuj4RkXOKzVde
         9hUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY+4UP7dQulrtq1aMqc+q+CWSjpRbDFI3UGo4t2Ct9Zsjo0MhDnS+JcKh0D6Gv5UQ7k92eCCtu9fH8u08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75Syc47PJpGlD8dtn9CQ3vOHiv3mc8cro1qaXRYaykQqSU6Ks
	lyt/CGEXAWBgidsQOzyEn/lWdlo7gpumiTo/qcdJH1kEmqO/c0hnZLzgUzK9Jx4ko992JaVbBpA
	anv2LfJcPFW57qVd1t7zu5sNK/xpo/liK97u3/g==
X-Google-Smtp-Source: AGHT+IHcoWPZAPvlRorBhaWeYrWRcW8qT1wMakYMB+0xfz8JrsHlT0IMluZivW9XBmwtLaDIWY+MTbQx0inPfUk4M6c=
X-Received: by 2002:a05:6122:31a6:b0:501:1aec:d2c4 with SMTP id
 71dfb90a1353d-502f72e194amr1582561e0c.2.1725949849112; Mon, 09 Sep 2024
 23:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 10 Sep 2024 12:00:37 +0530
Message-ID: <CA+G9fYvarKEPN3u1Ogw2pcw4h6r3OMzg+5qJpYkAXRunAEF_0Q@mail.gmail.com>
Subject: next-20240905: WARNING: at arch/arm64/include/asm/pkeys.h:40 do_mmap
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
	lkft-triage@lists.linaro.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, joey.gouly@arm.com, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Aishwarya TCV <aishwarya.tcv@arm.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following kernel warning noticed while running the LTP test case
LTP syscalls mlock03 ( mmap03 ) on
  - Arm DUT Juno-r2
  - Qcomm DUT Dragonboard-410c

running Linux next-20240905, next-20240906 and next-20240909 kernel.

First seen on next-20240905
  Good: next-20240904
  BAD:  next-20240905..next-20240909

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Warning log:
----------
[    0.000000] Linux version 6.11.0-rc6-next-20240905
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU
ld (GNU Binutils for Debian) 2.43) #1 SMP PREEMPT @1725536306
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: ARM Juno development board (r2)
..
mlock03.c:58: TINFO: mlock [aaaaddae1000,aaaaddafd000]
mlock03.c:62: TINFO: munlock [aaaaddae1000,aaaaddafd000]
[  795.850426] ------------[ cut here ]------------
[  795.857261] WARNING: CPU: 5 PID: 101577 at
arch/arm64/include/asm/pkeys.h:40 do_mmap
(arch/arm64/include/asm/pkeys.h:40 (discriminator 1) mm/mmap.c:338
(discriminator 1))
[  795.868833] Modules linked in: tun overlay btrfs blake2b_generic
libcrc32c xor xor_neon raid6_pq zstd_compress panfrost tda998x
onboard_usb_dev drm_shmem_helper hdlcd crct10dif_ce cec gpu_sched
drm_dma_helper drm_kms_helper fuse drm backlight dm_mod ip_tables
x_tables
[  795.895379] CPU: 5 UID: 0 PID: 101577 Comm: mmap03 Not tainted
6.11.0-rc6-next-20240905 #1
[  795.906430] Hardware name: ARM Juno development board (r2) (DT)
[  795.915135] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  795.924881] pc : do_mmap (arch/arm64/include/asm/pkeys.h:40
(discriminator 1) mm/mmap.c:338 (discriminator 1))
[  795.931236] lr : vm_mmap_pgoff (mm/util.c:588)
[  795.938113] sp : ffff80008ba0bc90
[  795.944206] x29: ffff80008ba0bc90 x28: 0000000000000001 x27: ffff0008329cf800
[  795.954128] x26: ffff0008329cf800 x25: ffff000822140cc0 x24: 0000000000000000
[  795.964050] x23: ffff80008ba0bd20 x22: 0000000000000004 x21: 0000000000000000
[  795.973972] x20: 0000000000000001 x19: 0000000000001000 x18: 0000000000000000
[  795.983895] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  795.993817] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  796.003739] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80008032e2c4
[  796.013661] x8 : ffff000827e64c00 x7 : ffff80008ba0bd20 x6 : 0000000000000000
[  796.023583] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000004
[  796.033505] x2 : 0000000000001000 x1 : 0000000000000011 x0 : 000000000000fffa
[  796.043428] Call trace:
[  796.048651] do_mmap (arch/arm64/include/asm/pkeys.h:40
(discriminator 1) mm/mmap.c:338 (discriminator 1))
[  796.054658] vm_mmap_pgoff (mm/util.c:588)
[  796.061187] ksys_mmap_pgoff (mm/mmap.c:542)
[  796.067980] __arm64_sys_mmap (arch/arm64/kernel/sys.c:21)
[  796.074597] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:54)
[  796.081213] el0_svc_common.constprop.0
(include/linux/thread_info.h:127 (discriminator 2)
arch/arm64/kernel/syscall.c:140 (discriminator 2))
[  796.088699] do_el0_svc (arch/arm64/kernel/syscall.c:152)
[  796.094879] el0_svc (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:165 (discriminator 1)
arch/arm64/kernel/entry-common.c:178 (discriminator 1)
arch/arm64/kernel/entry-common.c:713 (discriminator 1))
[  796.100799] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
[  796.108024] el0t_64_sync (arch/arm64/kernel/entry.S:598)
[  796.114467] ---[ end trace 0000000000000000 ]---

boot Log links,
--------
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240905/testrun/25069344/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-archarmincludeasmpkeysh-do_mmap/log
  - https://lkft.validation.linaro.org/scheduler/job/7842087#L21916
  - https://lkft.validation.linaro.org/scheduler/job/7847924#L23191

Test results history:
----------
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240909/testrun/25081195/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-archarmincludeasmpkeysh-do_mmap/history/

metadata:
----
  git describe: next-20240905
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: ad40aff1edffeccc412cde93894196dca7bc739e
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2leMFe4WompPEOUNN7ODxtTMCxf/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2leMFe4WompPEOUNN7ODxtTMCxf/
  toolchain: gcc-13

Steps to reproduce:
---------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2leMISlsoJqQdTCCzBmuVwKHq9m/reproducer
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2leMISlsoJqQdTCCzBmuVwKHq9m/tux_plan

--
Linaro LKFT
https://lkft.linaro.org

