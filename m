Return-Path: <linux-kernel+bounces-386284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89FE9B4181
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD72B1C2145B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C671FF7A8;
	Tue, 29 Oct 2024 04:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xuXQGIIP"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7BFC0B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730175085; cv=none; b=tV2yz+NJ7bR6bH7j5GUBEzq9LugqgRyb9Q7tcSKWrxbbBmz+94nwFH34Yv9rsAB+lkm2BVKbRy/LmabdsHsbPDhSzM1L72QrPJI+z7L6dqxppI23CTPXUKCOWySv33wEEovu5V8Z61GvZor/XTitTa5Z87n1ESFgu0OhFHf7DKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730175085; c=relaxed/simple;
	bh=529W7VNks+B05G3MTaxORjcx3fS+jUYPlPca7CFLnrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8e0FtjWHn5sw6U6JHa18Vvrs0kLK48V9PrHzeNIi15bOzJgm5Cy5W2V3V+oPoTTLeCUeR/4VIpQQXq1pcw3/tCMcxcfAKDfdCqWcWgH6zArSeQ0vlUSLZhmhvm2Ha2vnxDU1eWMBsNXLT6IspHM9kMGAxi+FDPCpjTcJnDZgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xuXQGIIP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so3829260b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730175082; x=1730779882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfzW/XABIinOqwCPgFOuZcFxYdYSqcnrSwvREDZ46EU=;
        b=xuXQGIIPt8zmU9nPhjKDq1Hk29YqYs1deNDleZjVpAfaZ3abdLgi9TeybwG/1AKt/f
         5Nw8iyBPcuFCXG9TPW5k5buqhX98cahEWB9pYJvySG4d8fEWi1MziaCZtJcG9emn3GxV
         HCiiiqRtjK35iwPQIpBic77h9gj88xVasMmvmhdYN39UTxRLu3BgdtENOgu0FdGQxZlf
         v5obKAisjlGsGK1vqJGXQw4mNZ1uviyDzoamhah59GEGi2sXaok4pqOUyrMzsa05GTHz
         WGnxta17oUaqrcve0h0WBxz6h3HrTM019Z7CFg2pPrvkQOVnLKLn3PxJgL3NopoLcyWL
         bAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730175082; x=1730779882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfzW/XABIinOqwCPgFOuZcFxYdYSqcnrSwvREDZ46EU=;
        b=t7Tg+GdIMIJf80u61Z6iRldkHFWGZYqBUNuAfgnQ3GxPcmTu4PW79yAQF0BawC/a3s
         f2fdRmtMuTv3jZk5TuZ1lWPPSLsQst/36/vODF80veJXhVrcuY3lr3IQJATQec+hkDcC
         yeflANlshocxVDLzH1Xgm7MN2gPWIKa/ZZX22AKO966INQUUdnul0k/kSyoj8NUODcDL
         M8sMCsQ+xck4o4r5ZJ5CZ3hZNqIx/B9DBe3gzM0PtHjqlCGVgZZb2Mo9ocO5V2zVc6S2
         XJynbbzo8t7Wt9sqvQxJ1l9Q5xbyqwLEC/05GwVc3k+U7C1Ix2MbraXG+V9lt4ONRgH/
         sr2A==
X-Forwarded-Encrypted: i=1; AJvYcCVLxEKvZdHTMZxV+8J4JDzlLF8S4EZzbXqYwq2aqCwNqvbMsj/wsKKFEvVlLzt3SJyFr2zxAuvOTAgNeHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+6H1uTeRUG8xxE9Na+AmPIo6h8EHOn3hja5JcLujd1x30BYs
	LBeeR1PIrHuLUh8ARLLiTWCgnfQ8+6rPVZBE0N7aZpJ7TCOD9TPfXov80jezKug=
X-Google-Smtp-Source: AGHT+IGAj5JqIqR2Wtuz8giftudmpTFBTn4ufvaBw9vxzlmR5/XQUx0Ya49mrGfKy63tDpKaoKDAQA==
X-Received: by 2002:a05:6a20:9f8c:b0:1d9:20cf:2c24 with SMTP id adf61e73a8af0-1d9a8473c4amr15531541637.29.1730175082502;
        Mon, 28 Oct 2024 21:11:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b649sm6613415b3a.138.2024.10.28.21.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 21:11:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t5dZe-007Cse-2m;
	Tue, 29 Oct 2024 15:11:18 +1100
Date: Tue, 29 Oct 2024 15:11:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: tj@kernel.org, jiangshanlai@gmail.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com, jack@suse.cz,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: workqueue lockup debug
Message-ID: <ZyBgZr94Y9+xey4b@dread.disaster.area>
References: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>

On Thu, Oct 24, 2024 at 04:49:40PM +0100, John Garry wrote:
> Hi workqueue and scheduler maintainers,
> 
> As reported in https://lore.kernel.org/linux-fsdevel/df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com/T/#m506b9edb1340cdddd87c6d14d20222ca8d7e8796,
> I am experiencing a workqueue lockup for v6.12-rcX.
> 
> At the point it occurs, the system becomes unresponsive and I cannot bring
> it back to life.
> 
> Enabling /proc/sys/kernel/softlockup_all_cpu_backtrace does not give
> anything extra in the way of debug. All I get is something like this:
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 24 15:34:02 ...
>  kernel:watchdog: BUG: soft lockup - CPU#29 stuck for 22s! [mysqld:14352]
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 24 15:34:02 ...
>  kernel:BUG: workqueue lockup - pool cpus=4 node=0 flags=0x0 nice=0 stuck
> for 30s!
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 24 15:34:02 ...
>  kernel:BUG: workqueue lockup - pool cpus=31 node=0 flags=0x0 nice=0 stuck
> for 49s!
> ^C
> 
> Can you advise on a robust method to get some debug from this system?
> 
> Maybe this is a scheduler issue, as Dave mentioned in that same thread.

I just got a new hit on the scheduler issue on 6.12-rc5:

[  172.477662] ------------[ cut here ]------------
[  172.480660] se->on_rq
[  172.480682] WARNING: CPU: 3 PID: 728318 at kernel/sched/fair.c:5629 pick_task_fair+0xb6/0x1b0
[  172.487172] Modules linked in:
[  172.488911] CPU: 3 UID: 0 PID: 728318 Comm: 291 Not tainted 6.12.0-rc5-dgc+ #273
[  172.492022] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  172.496029] RIP: 0010:pick_task_fair+0xb6/0x1b0
[  172.497978] Code: 40 f3 f3 03 01 74 2a 41 80 7f 50 00 74 96 f6 05 31 f3 f3 03 01 75 8d c6 05 28 f3 f3 03 01 48 c7 c7 41 26 e4 82 e8 7a d7 fa ff <0f> 0b e9 73 ff ff ff c6 05 0d f3 f3 03 01 48 c7 c7 2f 26 e4 82 e8
[  172.505868] RSP: 0018:ffffc9002ec83d60 EFLAGS: 00010046
[  172.508111] RAX: bdcdd05ee831a400 RBX: 0000000000000000 RCX: 0000000000000027
[  172.511139] RDX: 0000000000000000 RSI: 00000000ffdfffff RDI: ffff88881fadc9c8
[  172.514326] RBP: ffffc9002ec83d88 R08: 00000000001fffff R09: ffff88a018a00000
[  172.517804] R10: 00000000005ffffd R11: 0000000000000004 R12: ffff888122b58c00
[  172.520788] R13: ffff88881faf0140 R14: ffff88881faf00c0 R15: ffff88819e8cd180
[  172.523748] FS:  0000000000000000(0000) GS:ffff88881fac0000(0000) knlGS:0000000000000000
[  172.527167] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  172.529571] CR2: 00007f378e8866fc CR3: 000000104daae000 CR4: 0000000000350ef0
[  172.532601] Call Trace:
[  172.533666]  <TASK>
[  172.534557]  ? show_regs+0x5e/0x70
[  172.535993]  ? __warn+0xd0/0x1d0
[  172.537430]  ? pick_task_fair+0xb6/0x1b0
[  172.539062]  ? report_bug+0x145/0x1f0
[  172.540619]  ? handle_bug+0x67/0x90
[  172.542060]  ? exc_invalid_op+0x1b/0x50
[  172.543854]  ? asm_exc_invalid_op+0x1b/0x20
[  172.545688]  ? pick_task_fair+0xb6/0x1b0
[  172.547353]  pick_next_task_fair+0x27/0x330
[  172.549090]  __schedule+0x2ad/0xb10
[  172.550460]  do_task_dead+0x43/0x50
[  172.551743]  do_exit+0x836/0xab0
[  172.552950]  do_group_exit+0x8f/0x90
[  172.554274]  __x64_sys_exit_group+0x17/0x20
[  172.555808]  x64_sys_call+0x2ed3/0x2ee0
[  172.557210]  do_syscall_64+0x68/0x130
[  172.558531]  ? exc_page_fault+0x62/0xc0
[  172.559907]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  172.561739] RIP: 0033:0x7f378e74b3c5
[  172.563036] Code: Unable to access opcode bytes at 0x7f378e74b39b.
[  172.565278] RSP: 002b:00007ffd21861488 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
[  172.568001] RAX: ffffffffffffffda RBX: 00007f378e857fa8 RCX: 00007f378e74b3c5
[  172.570589] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
[  172.573182] RBP: 0000000000000000 R08: 00007ffd21861428 R09: 00007ffd218613af
[  172.575758] R10: 00007ffd21861320 R11: 0000000000000206 R12: 00007f378e856680
[  172.578356] R13: 00007f378e8b9f40 R14: 0000000000000001 R15: 00007f378e857fc0
[  172.580941]  </TASK>

There was nothing particularly obvious that caused it. It's a 64p
VM, running a heavy concurrent fstests workload that takes about 20
minutes to complete. There are a bit over 8000 tasks reported, most
of them kernel threads. The load is consuming about 50 CPUs, 40GB of
RAM, sustaining ~3GB/s of IO to/from disk across about 130 block
devices and the scheduler is context switching around 800,000 times
a second.

I have no idea how to reproduce this on demand - it randomly shows
up in about 1 in every 10 test runs and all the tests running at
that point in time report failure because they all detect this
warning in dmesg.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

