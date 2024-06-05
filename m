Return-Path: <linux-kernel+bounces-202200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CD78FC920
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8214B284B70
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895E19148D;
	Wed,  5 Jun 2024 10:30:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBEB372;
	Wed,  5 Jun 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583445; cv=none; b=iFcDdK0KsEYOIFGvGo8sPZodRCNouSeKXhc+0lwPlHTSAUYdtbJKNQKgiTnwzs7A7B6yGJ0LAgbP8U3ecfQZxuMQCsLStedi3KhFJEoTaT6AIuF09bkKR8C3i0OLQ8ueF/bw65Cd1xgiGARYSsV8MtX2Nf72MALNkmr9ok6ktyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583445; c=relaxed/simple;
	bh=u/HyFOjYb6/88R7uBNi+KKM05Pxe2XJ8tNcf8CYRkDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fATIQWWm6awNu5TiGf/R1MLrZPQQ3pcPVipfnOFP8sWCHnQJOya8XjP/D3b0KxTvkULZou5zDzS8BrGB56EztEjglyvqJ+GOfzjVvz0VIWgN2eRo5ImeZGBHTN5rvmfQo92p8i2jLH8WNNJfIlNxmBpPks8W4G9HObAdtTPE6xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60985339;
	Wed,  5 Jun 2024 03:31:07 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EBA3F792;
	Wed,  5 Jun 2024 03:30:41 -0700 (PDT)
Message-ID: <1b0c8c7e-2cf2-49a9-9120-3ced46f2df08@arm.com>
Date: Wed, 5 Jun 2024 11:30:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/7] coresight: tmc: Add support for reading crash data
To: Linu Cherian <lcherian@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Anil Kumar Reddy <areddy3@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>,
 suzuki.poulose@arm.com, mike.leach@linaro.org
References: <20240605081725.622953-1-lcherian@marvell.com>
 <20240605081725.622953-6-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240605081725.622953-6-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/06/2024 09:17, Linu Cherian wrote:
> * Introduce a new mode CS_MODE_READ_CRASHDATA for reading trace
>   captured in previous crash/watchdog reset.
> 
> * Add special device files for reading ETR/ETF crash data.
> 
> * User can read the crash data as below
> 
>   For example, for reading crash data from tmc_etf sink
> 
>   #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
> 

Hi Linu,

I think you are missing the removal of the new crash file when the
device is unloaded.

If you reload the module you get some errors:

  # rmmod coresight_tmc
  # modprobe coresight_tmc dyndbg=+p

  kobject: kobject_add_internal failed for crash_tmc_etf0 with -EEXIST,
    don't try to register things with the same name in the same
    directory.
  coresight tmc_etf0: Failed to setup user interface for crashdata
  sysfs: cannot create duplicate filename '/devices/virtual
   /misc/crash_tmc_etr0'

I'm not sure if it's related, but there are also some kasan errors at
the same time which I haven't seen before:

  BUG: KASAN: slab-use-after-free in strcmp+0x94/0xd0
  Read of size 1 at addr ffff00080b271be0 by task modprobe/570
  CPU: 2 PID: 570 Comm: modprobe Not tainted 6.9.0-rc4+ #71
  Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno
    Development Platform, BIOS EDK II Oct 19 2019
  Call trace:
   dump_backtrace+0x100/0x158
   show_stack+0x24/0x38
   dump_stack_lvl+0x3c/0x98
   print_report+0x178/0x508
   kasan_report+0xc0/0x120
   __asan_report_load1_noabort+0x20/0x30
   strcmp+0x94/0xd0
   cti_add_assoc_to_csdev+0x174/0x430 [coresight_cti]
   coresight_register+0x414/0x500 [coresight]
   __tmc_probe+0xd40/0x1340 [coresight_tmc]
   tmc_probe+0x60/0x98 [coresight_tmc]
   amba_probe+0x604/0x838
   really_probe+0x318/0x780
   __driver_probe_device+0x168/0x318
   driver_probe_device+0x78/0x2a0
   __driver_attach+0x22c/0x538
   bus_for_each_dev+0x1bc/0x1f0
   driver_attach+0x54/0x70
   bus_add_driver+0x2a8/0x4c0
   driver_register+0x168/0x2b8
   amba_driver_register+0x74/0x98
   coresight_init_driver+0x34/0xa8 [coresight]
   init_module+0x34/0xfb8 [coresight_tmc]
   do_one_initcall+0x1a0/0x8d0
   do_init_module+0x1f8/0x588
   load_module+0x3c20/0x44c0
   __arm64_sys_finit_module+0x3c8/0x638
   invoke_syscall+0x78/0x218
   el0_svc_common+0x160/0x1d8
   do_el0_svc+0x50/0x68
   el0_svc+0x4c/0xc0
   el0t_64_sync_handler+0x84/0x100
   el0t_64_sync+0x190/0x198

