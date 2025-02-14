Return-Path: <linux-kernel+bounces-515282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9938FA362DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A32C169E19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E412676CF;
	Fri, 14 Feb 2025 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzcL6YNx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27F263F3C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549941; cv=none; b=aQCs3et/MLnHHVpML6l6I4yJhgHYghh+yOxa8IHjxSWxjRCAWpiJ+g2mMOuLmnL9vPNQzKl667LBHEZb9Q0ig92qIL1z/1huagU7S2hWfkxWv4zOGKUr0qmplNHqjqjgvtHhGxkGqfwJqNDYZWLCcZkfZtYmjl7aeZtjgLljYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549941; c=relaxed/simple;
	bh=PJ1bRqF7Lrw4p29Kqd51IkmA8dbzaE0+GBlOo09TkHY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CZfHsjX39102i3HXPcN9bSzYsnSqd5B7UQqdxZwMf73YB/wTgJuwxZGO6EZ2Ztwj5zm4NBYsN3F0bvXNqwu1D2Vi7rvQ/aiQnRH/EiwqBS4C98QrSwQ68y0BjIm+72ouZ4/HtI6jkRWLwWHGMpiLjK/UE3oMSaDSg6JiqDYHsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzcL6YNx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739549937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aG8Kjzwld+BC+gKborzD0wPyk1VseyZvEiHws+jsBUM=;
	b=AzcL6YNxfeU1DgGzKZdBcNTQt8j+JxE+GTo+Lsr/36isFkAvgILHHJuevsXYvEQWn0jv+c
	jddXr9bjCVE6+CQiv/z71GPFwxgCIe8nKL/kH6LjBU/uJlp6fVKUhFhMCOyzQUdFSWD5G7
	xjNm6ypWaYNAOoQw4Gg6doKb8dLGzlA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-O8TDzKxiMlqJKQMlmlyNeQ-1; Fri, 14 Feb 2025 11:18:56 -0500
X-MC-Unique: O8TDzKxiMlqJKQMlmlyNeQ-1
X-Mimecast-MFC-AGG-ID: O8TDzKxiMlqJKQMlmlyNeQ_1739549936
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e65a429164so49331926d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739549936; x=1740154736;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG8Kjzwld+BC+gKborzD0wPyk1VseyZvEiHws+jsBUM=;
        b=UuKXqRcmy6UZ/tCxuCLE4wBUJFSjxsQXiSAWz8QAp40dtSvZ7zUBs4qxMpK39AQb/V
         BE9MVqVk73nSetmgcv2+qLJKSwJedY+c13ya0ORR6B0YdaH/2go9QqMXvOAkC/NKNCeK
         2uUcNSEsk48AJ9dmuvHAAthfzWIZwO2IbPxyHFjEcaNTSCRXeuf+MkGuqo59TQUomzS6
         8ytQQlOCoo1xhHeoe3f8uAHhNT+6GOjYmtkzFnZsTGRYcKipndMV17dIja01WxToJaMZ
         9SIs4AnuREBsWVvD72CYVCSFt7Or321asYvOruvbZ/HmKRjUpavgbi7gkpISFondL5OS
         KTwA==
X-Forwarded-Encrypted: i=1; AJvYcCVx8kX+6AG36fRW9K4A+Cuxq7J9LgFiVwsvUWR0wFZzNjMi6JCWwdauVytXDjdPdXU/pWjpkKaN1jmkMiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwVSs1eTWiweFFSOua9Z7O7VmBZ1Q3rOGH6j6oukOqoX1aTfE
	Oj7wA3+JTj+Sd5ckPDlXW6hKYlD8I+1ntSlsTUGFgXRtA126bqpjlxfzk8fT4p2J7IOHNvw25s3
	Pf4MgoK3RzFvJtrfNgK4rn6XGbYs2NHHxgojKpPdFkqUpHnDqaCbxbjSLIao/TQ==
X-Gm-Gg: ASbGnctbFxX3wpBPdu9EcPavo1V/0dBv9KN4Mkl3wwuiYQv6vkwBtk0sYpbUA5h3FkW
	j3Wj7XqJgDqg+3jHLhC6IO/+RbCVd/kyJ0clJxrA0bzMZC1rguaoULTmA7+6Rsbwem/+Qz0ycJF
	lB3IMZV0jRzvOVF1SGyqo/vDJd6IEEE2LGJmN4mM90soaSmWW/CidZvEZxmPda5eEqwUu1045Xv
	d6VJypzAbY/IYnh9Yl2T6eZIkJglEd9O9liYiZkGJGCx+dqA0que10oxeXP/76RPhulWZhbD9tt
	YU5N8Y/Ij9br4N7HDztnblpR0ys/qM3AzO299YbRI7MJDKVB
X-Received: by 2002:ad4:5be2:0:b0:6e4:41a0:3bdb with SMTP id 6a1803df08f44-6e46ed88629mr171075136d6.26.1739549935611;
        Fri, 14 Feb 2025 08:18:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbpxV8Tr8oN7zdl+mjmuxuFCnRhoBeIlPPcWJXgoj4K2vmSOLJNAeBaBCN1rrWyAQgZLk3og==
X-Received: by 2002:ad4:5be2:0:b0:6e4:41a0:3bdb with SMTP id 6a1803df08f44-6e46ed88629mr171074406d6.26.1739549934937;
        Fri, 14 Feb 2025 08:18:54 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f46a8sm22145466d6.82.2025.02.14.08.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 08:18:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f2f006e8-3987-4aa2-b4f5-114b4e869e86@redhat.com>
Date: Fri, 14 Feb 2025 11:18:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] locking/lockdep: Add kasan_check_byte() check in
 lock_acquire()
To: Marco Elver <elver@google.com>, Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
References: <20250213200228.1993588-1-longman@redhat.com>
 <20250213200228.1993588-5-longman@redhat.com>
 <CANpmjNM-uN81Aje1GE9zgUW-Q=w_2gPQ28giO7N2nmbRM521kA@mail.gmail.com>
 <3d069c26-4971-415a-9751-a28d207feb43@redhat.com>
 <CANpmjNNLn9=UA+cai=rL+6zsEQyppf6-4_YL4GAFi+dLt+4oSA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANpmjNNLn9=UA+cai=rL+6zsEQyppf6-4_YL4GAFi+dLt+4oSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/14/25 9:44 AM, Marco Elver wrote:
> On Fri, 14 Feb 2025 at 15:09, Waiman Long <llong@redhat.com> wrote:
>> On 2/14/25 5:44 AM, Marco Elver wrote:
>>> On Thu, 13 Feb 2025 at 21:02, Waiman Long <longman@redhat.com> wrote:
>>>> KASAN instrumentation of lockdep has been disabled as we don't need
>>>> KASAN to check the validity of lockdep internal data structures and
>>>> incur unnecessary performance overhead. However, the lockdep_map pointer
>>>> passed in externally may not be valid (e.g. use-after-free) and we run
>>>> the risk of using garbage data resulting in false lockdep reports. Add
>>>> kasan_check_byte() call in lock_acquire() for non kernel core data
>>>> object to catch invalid lockdep_map and abort lockdep processing if
>>>> input data isn't valid.
>>>>
>>>> Suggested-by: Marco Elver <elver@google.com>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> Reviewed-by: Marco Elver <elver@google.com>
>>>
>>> but double-check if the below can be simplified.
>>>
>>>> ---
>>>>    kernel/locking/lock_events_list.h |  1 +
>>>>    kernel/locking/lockdep.c          | 14 ++++++++++++++
>>>>    2 files changed, 15 insertions(+)
>>>>
>>>> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
>>>> index 9ef9850aeebe..bed59b2195c7 100644
>>>> --- a/kernel/locking/lock_events_list.h
>>>> +++ b/kernel/locking/lock_events_list.h
>>>> @@ -95,3 +95,4 @@ LOCK_EVENT(rtmutex_deadlock)  /* # of rt_mutex_handle_deadlock()'s    */
>>>>    LOCK_EVENT(lockdep_acquire)
>>>>    LOCK_EVENT(lockdep_lock)
>>>>    LOCK_EVENT(lockdep_nocheck)
>>>> +LOCK_EVENT(lockdep_kasan_fail)
>>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>>> index 8436f017c74d..98dd0455d4be 100644
>>>> --- a/kernel/locking/lockdep.c
>>>> +++ b/kernel/locking/lockdep.c
>>>> @@ -57,6 +57,7 @@
>>>>    #include <linux/lockdep.h>
>>>>    #include <linux/context_tracking.h>
>>>>    #include <linux/console.h>
>>>> +#include <linux/kasan.h>
>>>>
>>>>    #include <asm/sections.h>
>>>>
>>>> @@ -5830,6 +5831,19 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>>>>           if (!debug_locks)
>>>>                   return;
>>>>
>>>> +       /*
>>>> +        * As KASAN instrumentation is disabled and lock_acquire() is usually
>>>> +        * the first lockdep call when a task tries to acquire a lock, add
>>>> +        * kasan_check_byte() here to check for use-after-free of non kernel
>>>> +        * core lockdep_map data to avoid referencing garbage data.
>>>> +        */
>>>> +       if (unlikely(IS_ENABLED(CONFIG_KASAN) &&
>>> This is not needed - kasan_check_byte() will always return true if
>>> KASAN is disabled or not compiled in.
>> I added this check because of the is_kernel_core_data() call.
>>>> +                    !is_kernel_core_data((unsigned long)lock) &&
>>> Why use !is_kernel_core_data()? Is it to improve performance?
>> Not exactly. In my testing, just using kasan_check_byte() doesn't quite
>> work out. It seems to return false positive in some cases causing
>> lockdep splat. I didn't look into exactly why this happens and I added
>> the is_kernel_core_data() call to work around that.
> Globals should have their shadow memory unpoisoned by default, so
> that's definitely odd.
>
> Out of curiosity, do you have such a false positive splat? Wondering
> which data it's accessing. Maybe that'll tell us more about what's
> wrong.

The kasan_check_byte() failure happens very early in the boot cycle. 
There is no KASAN report, but the API returns false. I inserted a 
WARN_ON(1) to dump out the stack.

[    0.000046] ------------[ cut here ]------------
[    0.000047] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5817 
lock_acquire.part.0+0x22c/0x280
[    0.000057] Modules linked in:
[    0.000062] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 
6.12.0-el10-test+ #15
[    0.000066] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 
Gen10, BIOS U34 01/16/2025
[    0.000068] RIP: 0010:lock_acquire.part.0+0x22c/0x280
[    0.000073] Code: 69 d1 04 85 c0 0f 85 fc fe ff ff 65 48 8b 3d 2b d8 
c1 75 b9 0a 00 00 00 ba 08 00 00 00 4c 89 ee e8 19 e3 ff ff e9 dd fe ff 
ff <0f>
0b 65 48 ff 05 ca 5f c0 75 e9 ce fe ff ff 4c 89 14 24 e8 bc f8
[    0.000076] RSP: 0000:ffffffff8e407c98 EFLAGS: 00010046 ORIG_RAX: 
0000000000000000
[    0.000079] RAX: 0000000000000000 RBX: ffffffff8e54fe70 RCX: 
0000000000000000
[    0.000081] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
ffffffff8e407c40
[    0.000083] RBP: 0000000000000000 R08: 0000000000000001 R09: 
0000000000000000
[    0.000084] R10: ffffffff8a43af29 R11: 00000000002087cc R12: 
0000000000000001
[    0.000087] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[    0.000088] FS:  0000000000000000(0000) GS:ffffffff8fb88000(0000) 
knlGS:0000000000000000
[    0.000090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000093] CR2: ffff888000000413 CR3: 0000001fc96e0000 CR4: 
00000000000000f0
[    0.000095] Call Trace:
[    0.000096]  <TASK>
[    0.000101]  ? show_trace_log_lvl+0x1b0/0x2f0
[    0.000105]  ? show_trace_log_lvl+0x1b0/0x2f0
[    0.000119]  ? lock_acquire.part.0+0x22c/0x280
[    0.000124]  ? __warn.cold+0x5b/0xe5
[    0.000133]  ? lock_acquire.part.0+0x22c/0x280
[    0.000138]  ? report_bug+0x1f0/0x390
[    0.000146]  ? early_fixup_exception+0x145/0x230
[    0.000154]  ? early_idt_handler_common+0x2f/0x3a
[    0.000164]  ? request_resource+0x29/0x2b0
[    0.000172]  ? lock_acquire.part.0+0x22c/0x280
[    0.000177]  ? lock_acquire.part.0+0x3f/0x280
[    0.000182]  ? rcu_is_watching+0x15/0xb0
[    0.000187]  ? __pfx___might_resched+0x10/0x10
[    0.000192]  ? lock_acquire+0x120/0x170
[    0.000195]  ? request_resource+0x29/0x2b0
[    0.000201]  ? rt_write_lock+0x7d/0x110
[    0.000208]  ? request_resource+0x29/0x2b0
[    0.000211]  ? request_resource+0x29/0x2b0
[    0.000217]  ? probe_roms+0x150/0x370
[    0.000222]  ? __pfx_probe_roms+0x10/0x10
[    0.000226]  ? __lock_release.isra.0+0x120/0x2c0
[    0.000231]  ? setup_arch+0x92d/0x1180
[    0.000238]  ? setup_arch+0x95c/0x1180
[    0.000243]  ? __pfx_setup_arch+0x10/0x10
[    0.000246]  ? _printk+0xcc/0x102
[    0.000254]  ? __pfx__printk+0x10/0x10
[    0.000259]  ? cgroup_init_early+0x26a/0x290
[    0.000268]  ? cgroup_init_early+0x26a/0x290
[    0.000271]  ? cgroup_init_early+0x1af/0x290
[    0.000279]  ? start_kernel+0x68/0x3b0
[    0.000285]  ? x86_64_start_reservations+0x24/0x30
[    0.000288]  ? x86_64_start_kernel+0x9c/0xa0
[    0.000292]  ? common_startup_64+0x13e/0x141
[    0.000309]  </TASK>
[    0.000311] irq event stamp: 0
[    0.000312] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.000316] hardirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.000318] softirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.000320] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.000322] ---[ end trace 0000000000000000 ]---
[    0.000331] ------------[ cut here ]------------
[    0.000332] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5817 
lock_acquire.part.0+0x22c/0x280
[    0.000336] Modules linked in:
[    0.000339] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G        
W         -------  ---  6.12.0-el10-test+ #15
[    0.000343] Tainted: [W]=WARN
[    0.000345] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 
Gen10, BIOS U34 01/16/2025
[    0.000346] RIP: 0010:lock_acquire.part.0+0x22c/0x280
[    0.000350] Code: 69 d1 04 85 c0 0f 85 fc fe ff ff 65 48 8b 3d 2b d8 
c1 75 b9 0a 00 00 00 ba 08 00 00 00 4c 89 ee e8 19 e3 ff ff e9 dd fe ff 
ff <0f>
0b 65 48 ff 05 ca 5f c0 75 e9 ce fe ff ff 4c 89 14 24 e8 bc f8
[    0.000352] RSP: 0000:ffffffff8e407c20 EFLAGS: 00010046 ORIG_RAX: 
0000000000000000
[    0.000354] RAX: 0000000000000000 RBX: ffffffff8e54fe20 RCX: 
0000000000000000
[    0.000356] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
ffffffff8e407bc8
[    0.000357] RBP: 0000000000000000 R08: 0000000000000001 R09: 
0000000000000000
[    0.000359] R10: ffffffff8ccf84d2 R11: 00000000002087cc R12: 
0000000000000001
[    0.000360] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[    0.000362] FS:  0000000000000000(0000) GS:ffffffff8fb88000(0000) 
knlGS:0000000000000000
[    0.000364] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000365] CR2: ffff888000000413 CR3: 0000001fc96e0000 CR4: 
00000000000000f0
[    0.000367] Call Trace:
[    0.000368]  <TASK>
[    0.000369]  ? show_trace_log_lvl+0x1b0/0x2f0
[    0.000373]  ? show_trace_log_lvl+0x1b0/0x2f0
[    0.000386]  ? lock_acquire.part.0+0x22c/0x280
[    0.000391]  ? __warn.cold+0x5b/0xe5
[    0.000396]  ? lock_acquire.part.0+0x22c/0x280
[    0.000400]  ? report_bug+0x1f0/0x390
[    0.000407]  ? early_fixup_exception+0x145/0x230
[    0.000412]  ? early_idt_handler_common+0x2f/0x3a
[    0.000419]  ? rwbase_write_lock.constprop.0.isra.0+0x22/0x5f0
[    0.000427]  ? lock_acquire.part.0+0x22c/0x280
[    0.000434]  ? rcu_is_watching+0x15/0xb0
[    0.000438]  ? lock_acquire+0x120/0x170
[    0.000441]  ? rwbase_write_lock.constprop.0.isra.0+0x22/0x5f0
[    0.000448]  ? _raw_spin_lock_irqsave+0x46/0x90
[    0.000451]  ? rwbase_write_lock.constprop.0.isra.0+0x22/0x5f0
[    0.000456]  ? rwbase_write_lock.constprop.0.isra.0+0x22/0x5f0
[    0.000459]  ? lock_acquire+0x120/0x170
[    0.000462]  ? request_resource+0x29/0x2b0
[    0.000468]  ? rt_write_lock+0x85/0x110
[    0.000471]  ? request_resource+0x29/0x2b0
[    0.000475]  ? request_resource+0x29/0x2b0
[    0.000480]  ? probe_roms+0x150/0x370
[    0.000484]  ? __pfx_probe_roms+0x10/0x10
[    0.000488]  ? __lock_release.isra.0+0x120/0x2c0
[    0.000493]  ? setup_arch+0x92d/0x1180
[    0.000500]  ? setup_arch+0x95c/0x1180
[    0.000505]  ? __pfx_setup_arch+0x10/0x10
[    0.000508]  ? _printk+0xcc/0x102
[    0.000513]  ? __pfx__printk+0x10/0x10
[    0.000517]  ? cgroup_init_early+0x26a/0x290
[    0.000525]  ? cgroup_init_early+0x26a/0x290
[    0.000528]  ? cgroup_init_early+0x1af/0x290
[    0.000535]  ? start_kernel+0x68/0x3b0
[    0.000539]  ? x86_64_start_reservations+0x24/0x30
[    0.000543]  ? x86_64_start_kernel+0x9c/0xa0
[    0.000547]  ? common_startup_64+0x13e/0x141
[    0.000561]  </TASK>
[    0.000562] irq event stamp: 0
[    0.000563] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.000565] hardirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.000567] softirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.000569] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.000571] ---[ end trace 0000000000000000 ]---

Cheers,
Longman


