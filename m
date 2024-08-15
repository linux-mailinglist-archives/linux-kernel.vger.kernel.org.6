Return-Path: <linux-kernel+bounces-288710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C85953DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D986B235B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0030115696E;
	Thu, 15 Aug 2024 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DOb19Z4L"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E26370
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763860; cv=none; b=Rtr+UmWI9q+czo32aRrU5rf1Sp7ldCosrhsc/QiU1pfbHqOXVdUIKVq+LtjPjFYDCRUsAsgblrU23b+aIfkdVk830ta8pA0D0xuh0dJLC2FxggHmnOInCMzI7YbKX+qpUTmghrgsfDQppYIPAwoymq+DtDvVRVEo3zPEWShnvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763860; c=relaxed/simple;
	bh=5oH/A4LAOUreJDTPJRwUL11bHjDDMcvoi4WjEbcL4kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDk0JYh6QfSaUDqzzihyTeMYxzioD4hipAu3Xafjg0GkJ08kuOn0CyrNmbjt3HkuGwcBhRpSrcxEZVfyUmuUEJUeAz201djz04NUYKP9UUP58vuo+dHTsr0KNlKKkJH1V0JtGSJbVYUPsgL4ZqW1yvdy5Q/Lxpoj23VV2B6FoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DOb19Z4L; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso1172423b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723763856; x=1724368656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ghkt9m/LIz/Pd2d6NsDv/D7jJIsY8Apg1elvUmSjLc=;
        b=DOb19Z4L/uoH/ky0bBEcP7DochCmpatdEYJ7EId+eaan75EwQgl9F5IjmOllejMwtr
         xVLVzmYyiAK1ubzitbhKMpnC27J9/72v1E+clO/H63jou1DqTyaSTzTMwJXI15h5wxdG
         iaw/9J/cMMNKd3oOfX5AfftCnyDaU1EbmIhmM+oTfopSjuJ0pHgydRk/jshDchiXbhNx
         DAbwW6DKhjEyb/IRYVumYqxPs+7hoYYGCS+Kvsdau5ZKneWRiNZ4ST+0X9drqvXFrfOU
         /ffeZLDvu1QDj83iHqh5/yUV+3DKfb7RuhAz0filtQtvZgNQq8uigRcFM+mtNaTNcJgD
         q2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723763856; x=1724368656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ghkt9m/LIz/Pd2d6NsDv/D7jJIsY8Apg1elvUmSjLc=;
        b=O5hLXGD0qabt70Kav2EHJ8rMImyLcCbE5NHI2AnKKoA1NGsqYMgwB1ZKDl5CJvvgcZ
         3s9nppWVM4CF3CgED8LmEYVmUxGNsGiA29G+9foYmQPp3Acw+SF4aq6Y9VBtLBZPsRIJ
         5nUsdXpMauBI77QD2nwIqE/2wQ2vhc84G2fbJYdvsCWjyM9+ui2e7GE6zifgyrrGdsk9
         tGOnGK2j8aaIl+1pBqDCoHq3AjqL+0VeakWS9u9q1A1IgAw9xKfsb+ZlXWgmp5C7allI
         K+MRRITbkNr8W6NjMlYcbz2KcL2wWbSrO9oArmosI9XN9P4db5LpBsEZHq8HVgZBvXQp
         35lg==
X-Forwarded-Encrypted: i=1; AJvYcCXalBdR32qKWN6pGvS85Kt76GP7qdlW0byMEK/7FKNJcjlvep0WaZn0t6L8hAUjIeFgamCpmeK28GcmCjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpldEUGsjM1ffXyDNRa1ZKQp8vErJSbeLMCeprVVwfOYJ4Q7E4
	i97NovZcEGuFBQD5XqICZdzaNimA4SMuKmho3QlwzXmr21oza0Qn95SGvjMo2dY=
X-Google-Smtp-Source: AGHT+IEbiS4cKfNLups+uIVORTTdJZsxR0nqvF5y+/KsWLZUQjbqc+uxmY8XOe/8UdRZkQH8ntUQcg==
X-Received: by 2002:a05:6a21:318b:b0:1c6:fb07:381e with SMTP id adf61e73a8af0-1c90506a9b2mr1469116637.44.1723763856168;
        Thu, 15 Aug 2024 16:17:36 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0756dsm1517187b3a.47.2024.08.15.16.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 16:17:35 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:17:33 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Eagerly flush in flush_icache_deferred()
Message-ID: <Zr6MjWLD5VQAQHAV@ghost>
References: <20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com>
 <20240813-fix_fencei_optimization-v1-2-2aadc2cdde95@rivosinc.com>
 <Zr1NC7GBQHfqqplf@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr1NC7GBQHfqqplf@andrea>

On Thu, Aug 15, 2024 at 02:34:19AM +0200, Andrea Parri wrote:
> > <---- Thread 1 starts running here on CPU1
> > 
> > <---- Thread 2 starts running here with same mm
> > 
> > T2: prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI_ON, PR_RISCV_SCOPE_PER_PROCESS);
> > T2: <-- kernel sets current->mm->context.force_icache_flush to true
> 
> Mmh, TBH, I'm not sure how this patch is supposed to fix the race in
> question:
> 
> For once, AFAIU, the operation
> 
> T2: cpumask_setall(&current->mm->context.icache_stale_mask)
> 
> (on CPU2?) you've added with this patch...
> 
> 
> > T2: <modification of instructions>
> > T2: fence.i
> > 
> > T1: fence.i (to synchronize with other thread, has some logic to
> >              determine when to do this)
> > T1: <-- thread 1 is preempted
> > T1: <-- thread 1 is placed onto CPU3 and starts context switch sequence
> > T1 (kernel): flush_icache_deferred() -> skips flush because switch_to_should_flush_icache() returns true
> 
> ... does _not_ ensure that T1: flush_icache_deferred() on CPU3 will
> observe/read from that operation: IOW,
> 
> T1: cpumask_test_and_clear_cpu(cpu, &mm->context.icache_stale_mask)
> 
> may still evaluate to FALSE, thus preventing the FENCE.I execution.
> 
> Moreover, AFAIU, ...
> 
> 
> > 				     -> thread has migrated and task->mm->context.force_icache_flush is true
> > 
> > T2: prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI_OFF, PR_RISCV_SCOPE_PER_PROCESS);
> 
> ... moving the operation(s)
> 
> T2: set_icache_stale_mask()
> 	T2: cpumask_setall(&current->mm->context.icache_stale_mask)
> 
> before the following operation...  (per patch #1)
> 
> 
> > T2 (kernel): kernel sets current->mm->context.force_icache_flush = false
> > 
> > T1 (kernel): switch_to() calls switch_to_should_flush_icache() which now
> > 	     returns false because task->mm->context.force_icache_flush
> > 	     is false due to the other thread emitting
> > 	     PR_RISCV_CTX_SW_FENCEI_OFF.
> 
> ... does not ensure that T1: switch_to_should_flush_icache() on CPU3
> will observe
> 
> T1: cpumask_test_cpu(<cpu3>, &task->mm->context.icache_stale_mask) == true
> 
> in fact, T1 may evaluate the latter expression to FALSE while still
> being able to observe the "later" operation, i.e.
> 
> T1: task->mm->context.force_icache_flush == false
> 
> 
> Perhaps a simplified but useful way to look at such scenarios is as
> follows:
> 
>   - CPUs are just like nodes of a distributed system, and
> 
>   - store are like messages to be exchanged (by the memory subsystem)
>     between CPUs: without some (explicit) synchronization/constraints,
>     messages originating from a given CPU can propagate/be visible to
>     other CPUs at any time and in any order.
> 
> 
> IAC, can you elaborate on the solution proposed here (maybe by adding
> some inline comments), keeping the above considerations in mind? what
> am I missing?

I should have added some memory barriers. I want to have the stores to
task->mm->context.force_icache_flush and
task->mm->context.icache_stale_mask in riscv_set_icache_flush_ctx() from
one hart to be visible by another hart that is observing the values in
flush_icache_deferred() and switch_to_should_flush_icache(). Then also
for the changes to those variables in flush_icache_deferred() and
switch_to_should_flush_icache() to be visible in future invocations of
those functions.

> 
> 
> > T1 (back in userspace): Instruction cache was never flushed on context
> > 			switch to CPU3, and thus may execute incorrect
> > 			instructions.
> 
> Mmh, flushing the I$ (or, as meant here, executing a FENCE.I) seems
> to be only half of the solution: IIUC, we'd like to ensure that the
> store operation
> 
> T2: <modification of instructions>
> 
> originated from CPU2 is _visible_ to CPU3 by the time that FENCE.I
> instruction is executed, cf.
> 
> [from Zifencei - emphasis mine]
> 
> A FENCE.I instruction ensures that a subsequent instruction fetch on
> a RISC-V hart will see any previous data stores _already visible_ to
> the same RISC-V hart.
>

Oh okay so we will need to do a memory barrier before the fence.i in the
userspace program. I don't believe a memory barrier will be necessary in
the kernel though while this prctl is active, will the kernel ensure
memory coherence upon migration?

> 
> IOW (but assuming code is in coherent main memory), imagine that the
> (putative) FENCE.I on CPU3 is replaced by some
> 
> T1: LOAD reg,0(insts_addr)
> 
> question is: would such a load be guaranteed to observe the store
> 
> T2: <modification of instructions>  #  STORE new_insts,0(insts_addr)
> 
> originated from CPU2? can you elaborate?

To give a broader overview, the usecase for the per-mm mode of the prctl
is to support JIT languages that generate code sequences on one hart and
execute the generated code on another hart. In this example, thread 2 is
generating the code sequences and thread 1 is executing them.

The goal here is for Linux to guarantee that CPU migration does not
cause thread 1 to not see the instructions generated by thread 2, if it
was able to see the generated instructions on the CPU it was migrating
from. To hold this guarantee, when thread 1 (or any thread that is in
the mm group) is migrated, its instruction cache is synchronized.
Ideally, it would contain exactly the same contents as it did on the
previous CPU, but instead it must rely on fence.i since that is the only
option.

The stipulation of "if it was able to see the generated instructions on
the CPU it was migration from" is there to say that the thread is
expected to emit fence.i as necessary to cover the case that migration
does not occur.

Another note is that with this prctl, fence.i is emitted by the kernel
whenever any thread in the mm group is migrated, however the described
usecase is that there is one producer of the instructions and one
consumer. An extension to this prctl could be to specify which threads
are consumers and which threads are producers and only flush the icache
when the consumers have migrated but that optimization has not yet be
written.

- Charlie

> 
>   Andrea

