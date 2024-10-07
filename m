Return-Path: <linux-kernel+bounces-353676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E076A99310B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9EA1C22E26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A9D1D86DE;
	Mon,  7 Oct 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SU+oiI2m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3061D2B35
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314619; cv=none; b=ntxvzXhnlkvnnz+8WmQC7oGVkdJ2esDwx6daut45k1JY9OGMbbgPU2XldQdKSn4YmK5CCQgB7JLw6rrytjOvS4PedB4BMVOCXdOb0KqytWFf1OTJzICXPSe4Sc7PJ0Kk98Qna/VmKOQXhy9eGLBylHuTM+oTqL2We/fEsUZ3HNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314619; c=relaxed/simple;
	bh=Ye6PC8ZVKJtvcV0EK+E+eX5a0dJeN78SdSOa9Y/kGwE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eXuk72TqRI9uGGStrnU007lpBFJSZOiueQrx49iL5RrvPAP4oe6bikPShtsk7aEiWKLKhXxMSXz9r41KJdXFycrE1Z/aodEDnBw9lQ5b1HlS5EFe1WPHN+q9y1h0E2elsCh5nAaKlNcsYcp0yQynFf4SKeNh/uo/E2xN4RhBjCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SU+oiI2m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728314616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlni7hER8QYdkZQ9QEn+qZwCvcrXDQQ5/x1HH4HWeWs=;
	b=SU+oiI2mvz5rBf6b5AZ22EeH6/PbZOarO99+v/N1Wi0aWCPI9VJ332N7FCAPIFsyULPM9v
	VxVbKfLQI4jeIPBy/MrpRW7Jlhv8jt21AxmHk2+N12JCctIww7sbLxQg7dzfQi/qwg2csY
	Rf3DxbiACbaIJMS+lsXrEg9KUoUnYXw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-RcQwnCl3N5-PWrWPnWzigA-1; Mon, 07 Oct 2024 11:23:35 -0400
X-MC-Unique: RcQwnCl3N5-PWrWPnWzigA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e04cfa7178so4233805b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314614; x=1728919414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlni7hER8QYdkZQ9QEn+qZwCvcrXDQQ5/x1HH4HWeWs=;
        b=LZ3RjgFK0SMq2Wo92HZBASOLdWpKgm+FJYXevnAL+nqDC5+0X680StN9+WZ9SC9INO
         G0AjCYvqTVw0n8bb5qLRrtt9AtBidb4ffVaa9pXUVv/cYPIVSPEIGYbKpb2vZgkAUwBt
         7Wm09pe/Skuwt7pRV5X5Rj4AsgSqHUZl5+9kks9wOzIa2FymwrEfxCdJhwQYyBMHnKnX
         fa65MX7jKhRSwY8Ed4CDbiiJnNxjB1yf0ImYa1DfZrbWplECpwtAPddYubmLswN3SE28
         BHIJQcmGbi0zkAaev9wHNolmjWiFzj8mEEK1dxVBoRVklLKL4LDa+V+ycFU/uG0IN7iG
         P6wA==
X-Forwarded-Encrypted: i=1; AJvYcCVpeqcrAVYpZ1Dbff5/+t/fUKdRsT0AfGWULOhhKXUbv1il/Mn7SCAsoVkTYS3gJCXi3HQyMxFHVX5mJGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywja4TU3NZsj6dhJ93Zal0l/ELqiovI3ANXA656/aIEe4mRpfu8
	39P1UC1TcColFXCD1qFtk/UW4TBq5lfBGO1oejY9d7P5zyzdEuzWOq+PBp8+h5bIAeXy8MGksLz
	+ET4kOxQVxx7rmntIvxvdVKpntZLFj73Er1cPcifUogkvoXukC+qRIqW5zVKDJg==
X-Received: by 2002:a05:6358:5241:b0:1aa:c73d:5a8a with SMTP id e5c5f4694b2df-1c2b80d35a9mr285638855d.16.1728314614373;
        Mon, 07 Oct 2024 08:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNS53WH0HmjG8qAYHVfLFchc9wRLJrD3cIQg6csVsKEeSeFeBFMwFNoRk9ByGvZ19kUr9UhA==
X-Received: by 2002:a05:6358:5241:b0:1aa:c73d:5a8a with SMTP id e5c5f4694b2df-1c2b80d35a9mr285636355d.16.1728314614067;
        Mon, 07 Oct 2024 08:23:34 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7563736esm265415985a.67.2024.10.07.08.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 08:23:33 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <95365aa5-d039-4d09-8191-516ba01c9e5d@redhat.com>
Date: Mon, 7 Oct 2024 11:23:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/rtmutex: Always use trylock in rt_mutex_trylock()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Luis Goncalves <lgoncalv@redhat.com>,
 Chunyu Hu <chuhu@redhat.com>
References: <20240926151315.507905-1-longman@redhat.com>
 <20241002093745.GO5594@noisy.programming.kicks-ass.net>
 <7918987a-4b66-4191-aa52-798f9434352a@redhat.com>
 <20241007145037.GE4879@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20241007145037.GE4879@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/7/24 10:50 AM, Peter Zijlstra wrote:
> On Wed, Oct 02, 2024 at 01:54:16PM -0400, Waiman Long wrote:
>> On 10/2/24 05:37, Peter Zijlstra wrote:
>>> On Thu, Sep 26, 2024 at 11:13:15AM -0400, Waiman Long wrote:
>>>> One reason to use a trylock is to avoid a ABBA deadlock in case we need
>>>> to use a locking sequence that is not in the expected locking order. That
>>>> requires the use of trylock all the ways in the abnormal locking
>>>> sequence. Unfortunately, this is not the case for rt_mutex_trylock() as
>>>> it uses a raw_spin_lock_irqsave() to acquire the lock->wait_lock. That
>>>> will cause a lockdep splat like the following in a PREEMPT_RT kernel:
>>>>
>>>> [   63.695668] -> #0 (&lock->wait_lock){-...}-{2:2}:
>>>> [   63.695674]        check_prev_add+0x1bd/0x1310
>>>> [   63.695678]        validate_chain+0x6cf/0x7c0
>>>> [   63.695682]        __lock_acquire+0x879/0xf40
>>>> [   63.695686]        lock_acquire.part.0+0xfa/0x2d0
>>>> [   63.695690]        _raw_spin_lock_irqsave+0x46/0x90
>>>> [   63.695695]        rt_mutex_slowtrylock+0x3f/0xb0
>>>> [   63.695699]        rt_spin_trylock+0x13/0xc0
>>>> [   63.695702]        rmqueue_pcplist+0x5b/0x180
>>>> [   63.695705]        rmqueue+0xb01/0x1040
>>>> [   63.695708]        get_page_from_freelist+0x1d0/0xa00
>>>> [   63.695712]        __alloc_pages_noprof+0x19a/0x450
>>>> [   63.695716]        alloc_pages_mpol_noprof+0xaf/0x1e0
>>>> [   63.695721]        stack_depot_save_flags+0x4db/0x520
>>>> [   63.695727]        kasan_save_stack+0x3f/0x50
>>>> [   63.695731]        __kasan_record_aux_stack+0x8e/0xa0
>>>> [   63.695736]        task_work_add+0x1ad/0x240
>>>> [   63.695741]        sched_tick+0x1c7/0x500
>>>> [   63.695744]        update_process_times+0xf1/0x130
>>>> [   63.695750]        tick_nohz_handler+0xf7/0x230
>>>> [   63.695754]        __hrtimer_run_queues+0x13b/0x7b0
>>>> [   63.695758]        hrtimer_interrupt+0x1c2/0x350
>>>> [   63.695763]        __sysvec_apic_timer_interrupt+0xdb/0x340
>>>> [   63.695770]        sysvec_apic_timer_interrupt+0x9c/0xd0
>>>> [   63.695774]        asm_sysvec_apic_timer_interrupt+0x1a/0x20
>>>> [   63.695780]        __asan_load8+0x8/0xa0
>>>> [   63.695784]        mas_wr_end_piv+0x28/0x2c0
>>>> [   63.695789]        mas_preallocate+0x3a8/0x680
>>>> [   63.695793]        vma_shrink+0x180/0x3f0
>>>> [   63.695799]        shift_arg_pages+0x219/0x2c0
>>>> [   63.695804]        setup_arg_pages+0x343/0x5e0
>>>> [   63.695807]        load_elf_binary+0x5ac/0x15d0
>>>> [   63.695813]        search_binary_handler+0x125/0x370
>>>> [   63.695818]        exec_binprm+0xc9/0x3d0
>>>> [   63.695821]        bprm_execve+0x103/0x230
>>>> [   63.695824]        kernel_execve+0x187/0x1c0
>>>> [   63.695828]        call_usermodehelper_exec_async+0x145/0x1e0
>>>> [   63.695832]        ret_from_fork+0x31/0x60
>>>> [   63.695836]        ret_from_fork_asm+0x1a/0x30
>>>> [   63.695840]
>>>> [   63.695840] other info that might help us debug this:
>>>> [   63.695840]
>>>> [   63.695842] Chain exists of:
>>>> [   63.695842]   &lock->wait_lock --> &p->pi_lock --> &rq->__lock
>>>> [   63.695842]
>>>> [   63.695850]  Possible unsafe locking scenario:
>>>> [   63.695850]
>>>> [   63.695851]        CPU0                    CPU1
>>>> [   63.695852]        ----                    ----
>>>> [   63.695854]   lock(&rq->__lock);
>>>> [   63.695857]                                lock(&p->pi_lock);
>>>> [   63.695861]                                lock(&rq->__lock);
>>>> [   63.695864]   lock(&lock->wait_lock);
>>>> [   63.695868]
>>>> [   63.695868]  *** DEADLOCK ***
>>>>
>>>> Fix it by using raw_spin_trylock_irqsave() instead.
>>> That truncated lockdep report doesn't really explain anything. Please
>>> just transcribe the full lockdep report into something small and
>>> coherent.
>> I was trying to show where the offending call is coming from. I will send a
>> v2 with a condensed lockdep splat.
> No no no... explain the actual problem.
>
> Is the problem that:
>
> 	sched_tick()
> 	  task_tick_mm_cid()
> 	    task_work_add()
> 	      kasan_save_stack()
> 	        idiotic crap while holding rq->__lock ?
>
> Because afaict that is completely insane. And has nothing to do with
> rtmutex.
>
> We are not going to change rtmutex because instrumentation shit is shit.

Yes, it is because of KASAN that causes page allocation while holding 
the rq->__lock. Maybe we can blame KASAN for this. It is actually not a 
problem for non-PREEMPT_RT kernel because only trylock is being used. 
However, we don't use trylock all the way when rt_spin_trylock() is 
being used with PREEMPT_RT Kernel. This is certainly a problem that we 
need to fix as there may be other similar case not involving rq->__lock 
lurking somewhere.

Cheers,
Longman

>


