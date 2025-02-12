Return-Path: <linux-kernel+bounces-511723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C784A32EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D911884B47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA725E45C;
	Wed, 12 Feb 2025 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKZsHCyD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D330134A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385395; cv=none; b=OMe+HC2z7W4q841OxmwUgfX1ipbx/w/7pwrvxcLVzLCFunaqDA0QHpfRLxrTwk1Upe54YKgo9vR9mcMK4L1G2lzhTZe3OcnuZh0Q6tRWOs8dfGWXcQ9gsBSdpuvdfKFUarROoVFx9DzZCSeiWNM6zXiAkFtH9hGcgWoDDggb+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385395; c=relaxed/simple;
	bh=bEPv55xc3XTF0FNQ4AaWefsWnD6aSPneMP+IqwUX2zI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g1LzN4X8XiG4K4XZyy6/y8MhSKxCEKyA48oFdv+WuEbfnwKLuPWSaVnQVzsZRGPb5ywXpWySkUoguWdEH+vQQni/l4snSizighjsWvSL8r9400xvxKJQZafqQAcXBSv2XcqsgrD61Pj4VKsk5HutInXKFu8bIOdNpvR+johy6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKZsHCyD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739385391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7fVp9zppI3bI0g0vwRL9terzxgX7YoplD0xoRaADDM=;
	b=DKZsHCyDeh3IYJwMVJ08xFSHle8Ut8gzhFts7Wm/dz6XWq9YA9EqGq+vdXzLPizgZ8pJPI
	mggOCKAuivFqHUx6HSwnoP68CdWJOhS4rf3nRAd3xJYrIFKdS+GzpW43ZtRzM5P7d9eYdV
	5mqEB8N3DQHjXfowekFyxO8CaC/Efl4=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-ow_e6cgfPhuPu6c2y5sfSg-1; Wed, 12 Feb 2025 13:36:29 -0500
X-MC-Unique: ow_e6cgfPhuPu6c2y5sfSg-1
X-Mimecast-MFC-AGG-ID: ow_e6cgfPhuPu6c2y5sfSg
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2b8ee57227bso70331fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739385388; x=1739990188;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7fVp9zppI3bI0g0vwRL9terzxgX7YoplD0xoRaADDM=;
        b=GW66PdlS+apo65yJlR/ET/v6ICF8cNhMO6KXF2d52W6kXfxJrjLEpI79cqoAewLee8
         kKtxrvPjA9kKkXpvUyYroJohmCCyEiVTwzlsXvvzM+li40W9mmYa2Li16vzVGJaLuvk4
         BDESDiP5lEq1VosvspPmRk0xKkVq98ft4+skiivlmsgxcgrfv+Csm6EKaYpboSTxHVa/
         EoIu0tRCbLqTzD2ICowOdqPC/osiC2bInJnZh0fhLMh+XnIyI4MnHvXqXDuWDeLuB7GW
         lfAVem78v5/S0JbB6/pUynfFbNUHmrWCjQdPI/Ls5bGFfHpSI4GRjeMi7g07wgLuC1AF
         em4w==
X-Forwarded-Encrypted: i=1; AJvYcCW3pEdRVb9W45IYrPS/FOKuRxJuYjk2KwsK6YcM0M3l7gq9cXBo650PqlnTBetOTJ9R1SnU0DgbUu87FOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgdMtdRMefyF7S0l0f6p6ahFneoGPYD/QBGxfRBIlZYq1VKn8
	OeZkw60MCH2oJwT7sDkSo9AGwx2gBBtWC2Z8LD0mKmKrYaHB41SbdBUnuS15iCm+zvvQAPnE4gx
	8c9CuayHVM1s75SuD8C9xnajGxdNBUshaL1tUB+QaB/cN9IZdJZ2tU3Z2LDnUBQ==
X-Gm-Gg: ASbGncu0OWGEIOIW3KKwlseKZ6tsX5v70TXDSgR2ljCdw+/7UHpOsmPTumeSUpeDyjJ
	SzcXGgFPF1duFu6H3sH2NxIKHflXXUc15rSm9tn23cEt5Cor/8eYZER/Vk8Lgl867un4+pjh8N9
	ilz/TL65QY4MsfMagIK4QC7fQm9UOLLUgr0TKFge0gpk1Rr1Ubfr5W2LT5Cth/NAgjcGZMdw3ny
	aqxZitQhkhcmIzN2OZ3aT4nddSqwq2522ty0b8o5bKteDoTW2IbxC/ieRfR12sKiKScH4eW+YaX
	dcDpemqTdVA+WNyHF3qoH+MNRDzNclrHWXEsFVw3y2sPaY8j
X-Received: by 2002:a05:6870:7009:b0:29e:354e:5fdb with SMTP id 586e51a60fabf-2b8d68b1267mr2488924fac.37.1739385388549;
        Wed, 12 Feb 2025 10:36:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE62c0RhcTm/8jQQkLf+fKf+Cppt9mn7un+BlGRptraCj424EN1hLfXGxoIlKFX7hvl8Cedfw==
X-Received: by 2002:a05:6870:7009:b0:29e:354e:5fdb with SMTP id 586e51a60fabf-2b8d68b1267mr2488912fac.37.1739385388204;
        Wed, 12 Feb 2025 10:36:28 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b854f77c92sm4418051fac.30.2025.02.12.10.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 10:36:27 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dc5ba5b0-eddb-4b8c-9752-b1e76462cdc8@redhat.com>
Date: Wed, 12 Feb 2025 13:36:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
To: Boqun Feng <boqun.feng@gmail.com>, Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
References: <20250127013127.3913153-1-longman@redhat.com>
 <3e45144d-d147-4431-91be-63d0817fa2ce@redhat.com> <Z6w1cvz29NkMZh9b@Mac.home>
 <5f518ef0-2dbc-4d14-82ce-ad310a780598@redhat.com> <Z6zOlw2moxw0OAsZ@Mac.home>
 <efbe0c96-2bc6-4520-a90d-57e273f9f613@redhat.com> <Z6zVxtOdiH7GbVH0@Mac.home>
Content-Language: en-US
In-Reply-To: <Z6zVxtOdiH7GbVH0@Mac.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/25 12:09 PM, Boqun Feng wrote:
> On Wed, Feb 12, 2025 at 11:45:31AM -0500, Waiman Long wrote:
>> On 2/12/25 11:38 AM, Boqun Feng wrote:
>>> On Wed, Feb 12, 2025 at 09:10:25AM -0500, Waiman Long wrote:
>>>> On 2/12/25 12:45 AM, Boqun Feng wrote:
>>>>> On Tue, Feb 11, 2025 at 09:18:56PM -0500, Waiman Long wrote:
>>>>>> On 1/26/25 8:31 PM, Waiman Long wrote:
>>>>>>> A circular lock dependency splat has been seen involving down_trylock().
>>>>>>>
>>>>>>> [ 4011.795602] ======================================================
>>>>>>> [ 4011.795603] WARNING: possible circular locking dependency detected
>>>>>>> [ 4011.795607] 6.12.0-41.el10.s390x+debug
>>>>>>> [ 4011.795612] ------------------------------------------------------
>>>>>>> [ 4011.795613] dd/32479 is trying to acquire lock:
>>>>>>> [ 4011.795617] 0015a20accd0d4f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x26/0x90
>>>>>>> [ 4011.795636]
>>>>>>> [ 4011.795636] but task is already holding lock:
>>>>>>> [ 4011.795637] 000000017e461698 (&zone->lock){-.-.}-{2:2}, at: rmqueue_bulk+0xac/0x8f0
>>>>>>>
>>>>>>>       the existing dependency chain (in reverse order) is:
>>>>>>>       -> #4 (&zone->lock){-.-.}-{2:2}:
>>>>>>>       -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
>>>>>>>       -> #2 (&rq->__lock){-.-.}-{2:2}:
>>>>>>>       -> #1 (&p->pi_lock){-.-.}-{2:2}:
>>>>>>>       -> #0 ((console_sem).lock){-.-.}-{2:2}:
>>>>>>>
>>>>>>> The console_sem -> pi_lock dependency is due to calling try_to_wake_up()
>>>>>>> while holding the console.sem raw_spinlock. This dependency can be broken
>>>>>>> by using wake_q to do the wakeup instead of calling try_to_wake_up()
>>>>>>> under the console_sem lock. This will also make the semaphore's
>>>>>>> raw_spinlock become a terminal lock without taking any further locks
>>>>>>> underneath it.
>>>>>>>
>>>>>>> The hrtimer_bases.lock is a raw_spinlock while zone->lock is a
>>>>>>> spinlock. The hrtimer_bases.lock -> zone->lock dependency happens via
>>>>>>> the debug_objects_fill_pool() helper function in the debugobjects code.
>>>>>>>
>>>>>>> [ 4011.795646] -> #4 (&zone->lock){-.-.}-{2:2}:
>>>>>>> [ 4011.795650]        __lock_acquire+0xe86/0x1cc0
>>>>>>> [ 4011.795655]        lock_acquire.part.0+0x258/0x630
>>>>>>> [ 4011.795657]        lock_acquire+0xb8/0xe0
>>>>>>> [ 4011.795659]        _raw_spin_lock_irqsave+0xb4/0x120
>>>>>>> [ 4011.795663]        rmqueue_bulk+0xac/0x8f0
>>>>>>> [ 4011.795665]        __rmqueue_pcplist+0x580/0x830
>>>>>>> [ 4011.795667]        rmqueue_pcplist+0xfc/0x470
>>>>>>> [ 4011.795669]        rmqueue.isra.0+0xdec/0x11b0
>>>>>>> [ 4011.795671]        get_page_from_freelist+0x2ee/0xeb0
>>>>>>> [ 4011.795673]        __alloc_pages_noprof+0x2c2/0x520
>>>>>>> [ 4011.795676]        alloc_pages_mpol_noprof+0x1fc/0x4d0
>>>>>>> [ 4011.795681]        alloc_pages_noprof+0x8c/0xe0
>>>>>>> [ 4011.795684]        allocate_slab+0x320/0x460
>>>>>>> [ 4011.795686]        ___slab_alloc+0xa58/0x12b0
>>>>>>> [ 4011.795688]        __slab_alloc.isra.0+0x42/0x60
>>>>>>> [ 4011.795690]        kmem_cache_alloc_noprof+0x304/0x350
>>>>>>> [ 4011.795692]        fill_pool+0xf6/0x450
>>>>>>> [ 4011.795697]        debug_object_activate+0xfe/0x360
>>>>>>> [ 4011.795700]        enqueue_hrtimer+0x34/0x190
>>>>>>> [ 4011.795703]        __run_hrtimer+0x3c8/0x4c0
>>>>>>> [ 4011.795705]        __hrtimer_run_queues+0x1b2/0x260
>>>>>>> [ 4011.795707]        hrtimer_interrupt+0x316/0x760
>>>>>>> [ 4011.795709]        do_IRQ+0x9a/0xe0
>>>>>>> [ 4011.795712]        do_irq_async+0xf6/0x160
>>>>>>>
>>>>>>> Normally raw_spinlock to spinlock dependency is not legit
>>>>>>> and will be warned if PROVE_RAW_LOCK_NESTING is enabled,
>>>>>>> but debug_objects_fill_pool() is an exception as it explicitly
>>>>>>> allows this dependency for non-PREEMPT_RT kernel without causing
>>>>>>> PROVE_RAW_LOCK_NESTING lockdep splat. As a result, this dependency is
>>>>>>> legit and not a bug.
>>>>>>>
>>>>>>> Anyway, semaphore is the only locking primitive left that is still
>>>>>>> using try_to_wake_up() to do wakeup inside critical section, all the
>>>>>>> other locking primitives had been migrated to use wake_q to do wakeup
>>>>>>> outside of the critical section. It is also possible that there are
>>>>>>> other circular locking dependencies involving printk/console_sem or
>>>>>>> other existing/new semaphores lurking somewhere which may show up in
>>>>>>> the future. Let just do the migration now to wake_q to avoid headache
>>>>>>> like this.
>>>>>> I can also add the following as another instance where deadlock can happen.
>>>>>>
>>>>>> Reported-by:syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
>>>>>>
>>>>> FWIW, I already queued in my lockdep-for-tip branch, will send it in a
>>>>> PR to Peter in one or two weeks (in case he hasn't taken it before
>>>>> then).
>>>>>
>>>>> BTW, do we need a "Fixes" tag for stable kernels?
>>>> After some more thought, I realize that this patch doesn't really fix the
>>>> circular lock dependency problem, it just remove console_sem.lock from it.
>>>> The problem is that printk() can be called in any context. To really solve
>>>> the problem, we will need some kind of deferred wakeup using workqueue, for
>>>> instance. As printing to the console is inherently slow, adding some more
>>> Hmm... but your patch does remove the dependency console_sem.lock ->
>>> pi_lock, right? So it does fix the circular lock dependency problem. Or
>>> do you mean that it doesn't fix all the deadlocks that may cause by
>>> printk()?
>> Right, it doesn't  fix all the deadlocks that may be caused by printk().
>> Similar circular lock dependency splat will still happen. It will start with
>> pi_lock instead of console_sem.lock and will have one less lock in the
>> circular list. It is caused by waking up process within the printk()
>> context. That is why I think the proper solution is to have a deferred
>> wakeup. It will be specific to the printk() use cases.
>>
> Sounds good. Then I will take this patch, because 1) it fixes an issue
> (although partially) and 2) the fix is toward the right direction (i.e.
> avoiding wakeup inside critical section). Thanks!

This patch does fix some deadlock cases. The process wakeup will happen 
in console_unlock(). Its comment says that "console_unlock(); may be 
called from any context". So there may still be other deadlock cases 
hidden somewhere.

Cheers,
Longman



