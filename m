Return-Path: <linux-kernel+bounces-569195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B017A69FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1373B2D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01F61C5F2C;
	Thu, 20 Mar 2025 06:33:03 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54191D5AB8;
	Thu, 20 Mar 2025 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452383; cv=none; b=igZPIihCmIwkeSjYaOUYjPx5zfdyrYRwo2WWqed/qvC8+d/SSbk4HuUT7JfuHZxcQ8Ah6pefUQln5ZGhwfDBt7IbrPQvdp9lF7czuzFrxHk9PKSGRxIBYNfstsTZgXKG654T+PHhefvMpjjua847zSIWz+BjziFim73O58oCt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452383; c=relaxed/simple;
	bh=R4UZcRlLBQLWm63xV9WSZKABBX6Ec3jYR9cRX8nXuy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=lsCAxXGatPkr7N9dWJIr2yztdMPhAzVgLgL/srFX4JT8iLW83dmgDm3/aTu69cmMpFBMkRLOzV47buOkZNGtjBDLqRslipVxJvrQHyJJw/6yFsJQdt2epB7JveiBaEDnS2dYL6jY7Y06q0zg3FVFEcdV7LAhQPxtJdLHABffY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZJG3G2qQYz1d0Sn;
	Thu, 20 Mar 2025 14:32:42 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 025C51402CA;
	Thu, 20 Mar 2025 14:32:57 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 20 Mar
 2025 14:32:55 +0800
Message-ID: <59a1fa13-888e-4fe0-9de0-cd0e63c91265@huawei.com>
Date: Thu, 20 Mar 2025 14:32:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression found in memory stress test with stress-ng
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
References: <CAFv23QnqgTVoB-XRe5yNndRz4-Z_3y38+QpKRxQMeZ2xQTg=gw@mail.gmail.com>
 <180d8a88-52d9-4b83-83de-0184ed7cb4a5@huawei.com>
 <z6wlwwcbrmr3mcws6wmn5r6z45kosinvq6wyfq6hxfvcuxdjp5@ucjecgmhqp42>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
CC: <linux-block@vger.kernel.org>, <axboe@kernel.dk>, Christoph Hellwig
	<hch@infradead.org>, "Linux-Kernel@Vger. Kernel. Org"
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>, Dirk Su <dirk.su@canonical.com>,
	<jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <tursulin@ursulin.net>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <intel-gfx@lists.freedesktop.org>
In-Reply-To: <z6wlwwcbrmr3mcws6wmn5r6z45kosinvq6wyfq6hxfvcuxdjp5@ucjecgmhqp42>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/20 13:23, Chia-Lin Kao (AceLan) wrote:
> On Thu, Mar 20, 2025 at 11:52:20AM +0800, Baokun Li wrote:
>> On 2025/3/20 10:49, AceLan Kao wrote:
>>> Hi all,
>>>
>>> We have found a regression while doing a memory stress test using
>>> stress-ng with the following command
>>>      sudo stress-ng --aggressive --verify --timeout 300 --mmapmany 0
>>>
>>> This issue occurs on recent kernel versions, and we have found that
>>> the following commit leads to the issue
>>>      4e63aeb5d010 ("blk-wbt: don't throttle swap writes in direct reclaim")
>>>
>>> Before reverting the commit directly, I wonder if we can identify the
>>> issue and implement a solution quickly.
>>> Currently, I'm unable to provide logs, as the system becomes
>>> unresponsive during testing. If you have any idea to capture logs,
>>> please let me know, I'm willing to help.
>> Hi AceLan,
>>
>> I cannot reproduce this issue. The above command will trigger OOM.
>> Have you enabled panic_on_oom? (You can check by sysctl vm.panic_on_oom).
>> Or are there more kernel Oops reports in dmesg?
> Actually, there is no kernel panic during the testing.
> I tried using kernel magic key to trigger crash and this is what I
> got.
> It repeats the "Purging GPU memory" message over and over again.
>
> [ 3605.341706] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.

The messages are coming from i915_gem_shrinker_oom(), so it looks like
it's still an OOM issue. I'm just not sure why the OOM is happening so
often, like every 0.05 seconds.

I'm not familiar with gpu/drm/i915/gem, so I CCed the relevant maintainers
to see if they have any thoughts.

> [ 3605.346295] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.350815] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.355463] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.360105] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.364743] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.369426] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.374044] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.378467] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.382958] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.387534] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.392130] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> [ 3605.394571] [     C11] sysrq: Trigger a crash
> [ 3605.394575] [     C11] Kernel panic - not syncing: sysrq triggered crash
> [ 3605.394580] [     C11] CPU: 11 UID: 0 PID: 0 Comm: swapper/11 Kdump: loaded Not tainted 6.11.0-1016-oem #16-Ubuntu
> [ 3605.394586] [     C11] Hardware name: HP HP ZBook Fury 16 G11 Mobile Workstation PC/8CA7, BIOS W98 Ver. 01.01.12 11/25/2024
> [ 3605.394588] [     C11] Call Trace:
> [ 3605.394591] [     C11]  <IRQ>
> [ 3605.394596] [     C11]  dump_stack_lvl+0x27/0xa0
> [ 3605.394605] [     C11]  dump_stack+0x10/0x20
> [ 3605.394608] [     C11]  panic+0x352/0x3e0
> [ 3605.394613] [     C11]  sysrq_handle_crash+0x1a/0x20
> [ 3605.394618] [     C11]  __handle_sysrq+0xf0/0x290
> [ 3605.394623] [     C11]  sysrq_handle_keypress+0x2f4/0x550
> [ 3605.394627] [     C11]  sysrq_filter+0x45/0xa0
> [ 3605.394631] [     C11]  ? sched_balance_find_src_group+0x51/0x280
> [ 3605.394637] [     C11]  input_handle_events_filter+0x46/0xb0
> [ 3605.394643] [     C11]  input_pass_values+0x142/0x170
> [ 3605.394647] [     C11]  input_event_dispose+0x167/0x170
> [ 3605.394651] [     C11]  input_handle_event+0x41/0x80
> [ 3605.394656] [     C11]  input_event+0x51/0x80
> [ 3605.394659] [     C11]  atkbd_receive_byte+0x805/0x8f0
> [ 3605.394664] [     C11]  ps2_interrupt+0xb4/0x1b0
> [ 3605.394668] [     C11]  serio_interrupt+0x49/0xa0
> [ 3605.394673] [     C11]  i8042_interrupt+0x196/0x4c0
> [ 3605.394677] [     C11]  ? enqueue_hrtimer+0x4d/0xc0
> [ 3605.394682] [     C11]  ? ktime_get+0x3f/0xf0
> [ 3605.394686] [     C11]  ? lapic_next_deadline+0x2c/0x50
> [ 3605.394691] [     C11]  __handle_irq_event_percpu+0x4c/0x1b0
> [ 3605.394696] [     C11]  ? sched_clock_noinstr+0x9/0x10
> [ 3605.394700] [     C11]  handle_irq_event+0x39/0x80
> [ 3605.394706] [     C11]  handle_edge_irq+0x8c/0x250
> [ 3605.394710] [     C11]  __common_interrupt+0x4e/0x110
> [ 3605.394715] [     C11]  common_interrupt+0xb1/0xe0
> [ 3605.394718] [     C11]  </IRQ>
> [ 3605.394720] [     C11]  <TASK>
> [ 3605.394721] [     C11]  asm_common_interrupt+0x27/0x40
> [ 3605.394726] [     C11] RIP: 0010:poll_idle+0x4f/0xac
> [ 3605.394731] [     C11] Code: 00 00 65 4c 8b 3d a1 78 7b 63 f0 41 80 4f 02 20 49 8b 07 a8 08 75 32 4c 89 ef 48 89 de e8 d9 fe ff ff 49 89 c5 b8 c9 00 00 00 <49> 8b 17 83 e2 08 75 17 f3 90 83 e8 01 75 f1 e8 bd d1 ff ff 4c 29
> [ 3605.394735] [     C11] RSP: 0000:ffff9c57001f7dc8 EFLAGS: 00000206
> [ 3605.394740] [     C11] RAX: 000000000000003c RBX: ffffbc56ff59b618 RCX: 0000000000000000
> [ 3605.394743] [     C11] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [ 3605.394744] [     C11] RBP: ffff9c57001f7df0 R08: 0000000000000000 R09: 0000000000000000
> [ 3605.394747] [     C11] R10: 0000000000000000 R11: 0000000000000000 R12: 0000034772423b38
> [ 3605.394749] [     C11] R13: 000000000000f424 R14: 0000000000000000 R15: ffff912c8122a900
> [ 3605.394754] [     C11]  ? poll_idle+0x63/0xac
> [ 3605.394757] [     C11]  cpuidle_enter_state+0x8e/0x720
> [ 3605.394762] [     C11]  ? sysvec_apic_timer_interrupt+0x57/0xc0
> [ 3605.394766] [     C11]  cpuidle_enter+0x2e/0x50
> [ 3605.394771] [     C11]  call_cpuidle+0x22/0x60
> [ 3605.394775] [     C11]  cpuidle_idle_call+0x119/0x190
> [ 3605.394778] [     C11]  do_idle+0x82/0xe0
> [ 3605.394781] [     C11]  cpu_startup_entry+0x29/0x30
> [ 3605.394784] [     C11]  start_secondary+0x127/0x160
> [ 3605.394788] [     C11]  common_startup_64+0x13e/0x141
> [ 3605.394794] [     C11]  </TASK>
>
>>
>> Regards,
>> Baokun
>>> Best regards,
>>> AceLan Kao.
>>>


