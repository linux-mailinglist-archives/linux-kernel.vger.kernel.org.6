Return-Path: <linux-kernel+bounces-437545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931FD9E94C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC652810AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A67227597;
	Mon,  9 Dec 2024 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ltz06UNx"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85F217F46
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748512; cv=none; b=KY/mpnrbU2Ol3+H0kXZcqDsfnsAeN132CawHAOXc6rOJEjEpU6q/cWa5IPbXwbs0jRedCD/IHllppgNkfaayr99VYfcfx3ZFwYmUcBEdLWV9J+6qs9gI2lbCmwbLSmPgbhYEJDq9Lf/SzVewucrlrATQ4tW/xLjBI2p3tgU2a3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748512; c=relaxed/simple;
	bh=AAbm8rurLMNB8ZYzrFbKM71MdPs6ieWZggaIgeLR92E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1M/u1bIjiaaldCWx4ODD+JV0Bsc2gCWBCDG4H2jgTK+D1TDEXsigY9fI+39HXg1+Cul7m2eZBAd76hi9w0kQgInbq8/06+pab6lRKxSwEvDs4AIupjxzMW+Jz6aQHKmcpzhkkzlkHwZ2Av0Ok3jwByHxOuHYo3kBIYuD7eZHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ltz06UNx; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <48b36c0e-86bb-b181-4d9b-7ed50d70426f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733748506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXxidD4iSY8ftb0yQgZPq4gv3Nvvmfw92Sv/xmJV+Qw=;
	b=Ltz06UNxJYgB3lEYj762/WulhbvHuGqo7dytq+ygtJyPljqV/5tiF01m+uUaxqarnSxA7S
	Pi0hTAI/kU3h+dFxq9Utnhm2hzc/S3ptuVBWVJv4VYr2je8ENOnVaRW70WXvMDqwYQGBGf
	ntQfWQ+kNsXsYFnGpowCVgfqv4oYdJw=
Date: Mon, 9 Dec 2024 20:47:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BISECTED: 'alloc_tag: populate memory for module tags as needed'
 crashes on boot.
To: Suren Baghdasaryan <surenb@google.com>,
 Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1ba0cc57-e2ed-caa2-1241-aa5615bee01f@candelatech.com>
 <CAJuCfpGk6kyAAEUakMTNvJWmo98Gfbrk22+yZNEwO0eMbRc1Og@mail.gmail.com>
 <dcec571e-4f84-b12b-b931-4dbfb3f8bd98@candelatech.com>
 <CAJuCfpEwmTXkMHRdY0USwPFoWcC3d3j6r=6SRV39uP3KG6b5iA@mail.gmail.com>
 <CAJuCfpGUey5wAmL1Cgi2d-RQ=b0cqWXbo3HxvD-bomodg+GJrw@mail.gmail.com>
 <eca69b03-9b89-af2a-d1b0-38f76675b165@candelatech.com>
 <CAJuCfpE=bOOW=dAWCFjzkCDw3LpyoZtcgLPcequ3wsuFn8-t4A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpE=bOOW=dAWCFjzkCDw3LpyoZtcgLPcequ3wsuFn8-t4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Suren


On 12/7/24 09:27, Suren Baghdasaryan wrote:
> On Fri, Dec 6, 2024 at 4:50 PM Ben Greear <greearb@candelatech.com> wrote:
>> On 12/6/24 16:15, Suren Baghdasaryan wrote:
>>> On Fri, Dec 6, 2024 at 2:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>> On Fri, Dec 6, 2024 at 2:43 PM Ben Greear <greearb@candelatech.com> wrote:
>>>>> On 12/6/24 14:03, Suren Baghdasaryan wrote:
>>>>>> On Fri, Dec 6, 2024 at 1:50 PM Ben Greear <greearb@candelatech.com> wrote:
>>>>>>> Hello Suren,
>>>>>>>
>>>>>>> My system crashes on bootup, and I bisected to this commit.
>>>>>>>
>>>>>>> 0f9b685626daa2f8e19a9788625c9b624c223e45 is the first bad commit
>>>>>>> commit 0f9b685626daa2f8e19a9788625c9b624c223e45
>>>>>>> Author: Suren Baghdasaryan <surenb@google.com>
>>>>>>> Date:   Wed Oct 23 10:07:57 2024 -0700
>>>>>>>
>>>>>>>         alloc_tag: populate memory for module tags as needed
>>>>>>>
>>>>>>>         The memory reserved for module tags does not need to be backed by physical
>>>>>>>         pages until there are tags to store there.  Change the way we reserve this
>>>>>>>         memory to allocate only virtual area for the tags and populate it with
>>>>>>>         physical pages as needed when we load a module.
>>>>>>>
>>>>>>> The crash looks like this:
>>>>>>>
>>>>>>> BUG: unable to handle page fault for address: fffffbfff4041000
>>>>>>> #PF: supervisor read access in kernel mode
>>>>>>> #PF: error_code(0x0000) - not-present page
>>>>>>> PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb38067 PTE 0
>>>>>>> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
>>>>>>> CPU: 0 UID: 0 PID: 319 Comm: systemd-udevd Not tainted 6.12.0-rc6+ #21
>>>>>>> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
>>>>>>> RIP: 0010:kasan_check_range+0xa5/0x190
>>>>>>> Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
>>>>>>> RSP: 0018:ffff88812c26f980 EFLAGS: 00010206
>>>>>>> RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814ec29b
>>>>>>> [  OK  DX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffffa0208000
>>>>>>> 0m] Finished BP: fffffbfff4041000 R08: 0000000000000001 R09: fffffbfff404101d
>>>>>>> ;1;39msystemd-udR10: ffffffffa02080ef R11: 0000000000000003 R12: ffffffffa0208000
>>>>>>> ev-trig…e R13: ffffc90000dac7c8 R14: ffffc90000dac7e8 R15: dffffc0000000000
>>>>>>> - Coldplug All uFS:  00007fe869216b40(0000) GS:ffff88841da00000(0000) knlGS:0000000000000000
>>>>>>> dev Devices.
>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> CR2: fffffbfff4041000 CR3: 0000000121e86002 CR4: 00000000003706f0
>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>> Call Trace:
>>>>>>>      <TASK>
>>>>>>> [  OK  ? __die+0x1f/0x60
>>>>>>> 0m] Reached targ ? page_fault_oops+0x258/0x910
>>>>>>> et sysi ? dump_pagetable+0x690/0x690
>>>>>>> nit.target - ? search_bpf_extables+0x22/0x250
>>>>>>>      System Initiali ? trace_page_fault_kernel+0x120/0x120
>>>>>>> zation.
>>>>>>>      ? search_bpf_extables+0x164/0x250
>>>>>>>      ? kasan_check_range+0xa5/0x190
>>>>>>>      ? fixup_exception+0x4d/0xc70
>>>>>>>      ? exc_page_fault+0xe1/0xf0
>>>>>>> [  OK  ? asm_exc_page_fault+0x22/0x30
>>>>>>> 0m] Reached targ ? load_module+0x3d7b/0x7560
>>>>>>> et netw ? kasan_check_range+0xa5/0x190
>>>>>>> ork.target - __asan_memcpy+0x38/0x60
>>>>>>>      Network.
>>>>>>>      load_module+0x3d7b/0x7560
>>>>>>>      ? module_frob_arch_sections+0x30/0x30
>>>>>>>      ? lockdep_lock+0xbe/0x1b0
>>>>>>>      ? rw_verify_area+0x18d/0x5e0
>>>>>>>      ? kernel_read_file+0x246/0x870
>>>>>>>      ? __x64_sys_fspick+0x290/0x290
>>>>>>>      ? init_module_from_file+0xd1/0x130
>>>>>>>      init_module_from_file+0xd1/0x130
>>>>>>>      ? __ia32_sys_init_module+0xa0/0xa0
>>>>>>>      ? lock_acquire+0x2d/0xb0
>>>>>>>      ? idempotent_init_module+0x116/0x790
>>>>>>>      ? do_raw_spin_unlock+0x54/0x220
>>>>>>>      idempotent_init_module+0x226/0x790
>>>>>>>      ? init_module_from_file+0x130/0x130
>>>>>>>      ? vm_mmap_pgoff+0x203/0x2e0
>>>>>>>      __x64_sys_finit_module+0xba/0x130
>>>>>>>      do_syscall_64+0x69/0x160
>>>>>>>      entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>>>> RIP: 0033:0x7fe869de327d
>>>>>>> Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
>>>>>>> RSP: 002b:00007ffe34a828d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>>>>>>> RAX: ffffffffffffffda RBX: 0000557fa8f3f3f0 RCX: 00007fe869de327d
>>>>>>> RDX: 0000000000000000 RSI: 00007fe869f4943c RDI: 0000000000000006
>>>>>>> RBP: 00007fe869f4943c R08: 0000000000000000 R09: 0000000000000000
>>>>>>> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
>>>>>>> R13: 0000557fa8f3f030 R14: 0000000000000000 R15: 0000557fa8f3d110
>>>>>>>      </TASK>
>>>>>>> Modules linked in:
>>>>>>> CR2: fffffbfff4041000
>>>>>>> ---[ end trace 0000000000000000 ]---
>>>>>>>
>>>>>>> I suspect you only hit this with an unlucky amount of debugging enabled.  The kernel config I used
>>>>>>> is found here:
>>>>>>>
>>>>>>> http://www.candelatech.com/downloads/cfg-kasan-crash-regression.config
>>>>>>>
>>>>>>> I will be happy to test fixes.
>>>>>> Hi Ben,
>>>>>> Thanks for reporting the issue. Do you have these recent fixes in your tree:
>>>>>>
>>>>>> https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.com/
>>>>>> https://lore.kernel.org/all/20241205170528.81000-1-hao.ge@linux.dev/
>>>>>>
>>>>>> If not, couple you please apply them and see if the issue is still happening?
>>>>>> Thanks,
>>>>>> Suren.
>>>>> Hello Suren,
>>>>>
>>>>> Thanks for the quick response.  The first patch is already in latest Linus tree,
>>> Hmm. Could you please double-check which tree you are using? I don't
>>> see the first patch
>>> (https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.com/)
>>> in Linus' tree. Maybe you are using linux-next?
>> Sorry, you are correct.  I must have mangled something when trying to apply
>> the patch and I didn't look hard enough when patch said changes were already applied.
>>
>> I can re-test this next week...and for reference, kernel boots fine when you disable
>> KASAN and other debugging.
> Thanks! Please retest with this patch and let me know if you are still
> having issues.
> Suren.

Indeed, this is a bug that still exists in another context, namely when 
CONFIG_KASAN_VMALLOC is not enabled.

We may need to look into this scenario next.

Thanks

Best Regards

Hao

>> Thanks,
>> Ben
>>
>>
>> --
>> Ben Greear <greearb@candelatech.com>
>> Candela Technologies Inc  http://www.candelatech.com
>>
>>

