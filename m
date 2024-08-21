Return-Path: <linux-kernel+bounces-295279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C797959945
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7320AB25B30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621C1CDFAA;
	Wed, 21 Aug 2024 09:46:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77351C4ED2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233575; cv=none; b=uvtsYNlWpsGqaKAlMqjsb3mfV8MiAjfrvMvJ6J+b5nH11KifmZsXqn0WoGIRvcChU1KtNmJLy2Iwax9WRt/7+nmbRm7a2II9+YFDbYC8982ieQfD+1w1qJ58+SeVPeruCvWBlL3HQcwwqxK3v0se9Xeo9GgVoT7cuY8/R+MkCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233575; c=relaxed/simple;
	bh=6L36EUdCrEN3ywmrpasxmcnZrFIgBQWeGChQzyQa2IQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l4r10+yHAQnDl7vChRNn5Ce0kJVQnfQH/LA5b+qG4PU30/GROH/Rl8g4m2WnISHX3usbUict+Op+B9U7QchbTG+jbKS3pdaKBimhFMXhA/Ae+jeIatkxsJfZ8yNh3sZNrviw4OLE4ukrgzf2h+JUcgh+C2gs1da4owgDfm4/Was=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C19C3DA7;
	Wed, 21 Aug 2024 02:46:37 -0700 (PDT)
Received: from [10.57.48.161] (unknown [10.57.48.161])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A7833F66E;
	Wed, 21 Aug 2024 02:46:09 -0700 (PDT)
Message-ID: <717e6294-5c62-415c-bc8b-5da1d8ac3642@arm.com>
Date: Wed, 21 Aug 2024 10:46:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] Complete EEVDF
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <c6a673d4-ee16-4458-bf68-8f75d5062984@arm.com>
Content-Language: en-US
In-Reply-To: <c6a673d4-ee16-4458-bf68-8f75d5062984@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2024 17:43, Hongyan Xia wrote:
> Hi Peter,
> 
> On 27/07/2024 11:27, Peter Zijlstra wrote:
>> Hi all,
>>
>> So after much delay this is hopefully the final version of the EEVDF 
>> patches.
>> They've been sitting in my git tree for ever it seems, and people have 
>> been
>> testing it and sending fixes.
>>
>> I've spend the last two days testing and fixing cfs-bandwidth, and as far
>> as I know that was the very last issue holding it back.
>>
>> These patches apply on top of queue.git sched/dl-server, which I plan 
>> on merging
>> in tip/sched/core once -rc1 drops.
>>
>> I'm hoping to then merge all this (+- the DVFS clock patch) right 
>> before -rc2.
>>
>>
>> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
>>
>>   - split up the huge delay-dequeue patch
>>   - tested/fixed cfs-bandwidth
>>   - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
>>   - SCHED_BATCH is equivalent to RESPECT_SLICE
>>   - propagate min_slice up cgroups
>>   - CLOCK_THREAD_DVFS_ID
>>
> 
> The latest tip/sched/core at commit
> 
> aef6987d89544d63a47753cf3741cabff0b5574c
> 
> crashes very early on on my Juno r2 board (arm64). The trace is here:
> 
> [    0.049599] ------------[ cut here ]------------
> [    0.054279] kernel BUG at kernel/sched/deadline.c:63!
> [    0.059401] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT 
> SMP
> [    0.066285] Modules linked in:
> [    0.069382] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 
> 6.11.0-rc1-g55404cef33db #1070
> [    0.077855] Hardware name: ARM Juno development board (r2) (DT)
> [    0.083856] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [    0.090919] pc : enqueue_dl_entity+0x53c/0x540
> [    0.095434] lr : dl_server_start+0xb8/0x10c
> [    0.099679] sp : ffffffc081ca3c30
> [    0.103034] x29: ffffffc081ca3c40 x28: 0000000000000001 x27: 
> 0000000000000002
> [    0.110281] x26: 00000000000b71b0 x25: 0000000000000000 x24: 
> 0000000000000001
> [    0.117525] x23: ffffff897ef21140 x22: 0000000000000000 x21: 
> 0000000000000000
> [    0.124770] x20: ffffff897ef21040 x19: ffffff897ef219a8 x18: 
> ffffffc080d0ad00
> [    0.132015] x17: 000000000000002f x16: 0000000000000000 x15: 
> ffffffc081ca8000
> [    0.139260] x14: 00000000016ef200 x13: 00000000000e6667 x12: 
> 0000000000000001
> [    0.146505] x11: 000000003b9aca00 x10: 0000000002faf080 x9 : 
> 0000000000000030
> [    0.153749] x8 : 0000000000000071 x7 : 000000002cf93d25 x6 : 
> 000000002cf93d25
> [    0.160994] x5 : ffffffc081e04938 x4 : ffffffc081ca3d40 x3 : 
> 0000000000000001
> [    0.168238] x2 : 000000003b9aca00 x1 : 0000000000000001 x0 : 
> ffffff897ef21040
> [    0.175483] Call trace:
> [    0.177958]  enqueue_dl_entity+0x53c/0x540
> [    0.182117]  dl_server_start+0xb8/0x10c
> [    0.186010]  enqueue_task_fair+0x5c8/0x6ac
> [    0.190165]  enqueue_task+0x54/0x1e8
> [    0.193793]  wake_up_new_task+0x250/0x39c
> [    0.197862]  kernel_clone+0x140/0x2f0
> [    0.201578]  user_mode_thread+0x4c/0x58
> [    0.205468]  rest_init+0x24/0xd8
> [    0.208743]  start_kernel+0x2bc/0x2fc
> [    0.212460]  __primary_switched+0x80/0x88
> [    0.216535] Code: b85fc3a8 7100051f 54fff8e9 17ffffce (d4210000)
> [    0.222711] ---[ end trace 0000000000000000 ]---
> [    0.227391] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.234187] ---[ end Kernel panic - not syncing: Attempted to kill 
> the idle task! ]---
> 
> I'm not an expert in DL server so I have no idea where the problem could 
> be. If you know where to look off the top of your head then much better. 
> If not, I'll do some bi-section later.
> 

Okay, in case the trace I provided isn't clear enough, I traced the 
crash to a call chain like this:

dl_server_start()
	enqueue_dl_entity()
		update_stats_enqueue_dl()
			update_stats_enqueue_sleeper_dl()
				__schedstats_from_dl_se()
					dl_task_of() <---------- crash

If I undefine CONFIG_SCHEDSTATS, then it boots fine, and I wonder if 
this is the reason why other people are not seeing this. This is 
probably not EEVDF but DL refactoring related.

