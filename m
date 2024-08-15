Return-Path: <linux-kernel+bounces-287361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8D952701
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99081F229A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A2EDF42;
	Thu, 15 Aug 2024 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/DnNENI"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C428F62
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682068; cv=none; b=iQZV4qpO/iwsWe8PxXLbzlg3aofjPPtLqPRUtnXBSm8NRstAtBnjvDPbmo+wv+hkyqTRIRvAeBWhZbUud6cn+zD2MAXzaJBnhY3D5+lNAquEYKXsidrYnTrkSU2YKtSEojK3QlhPXyFuHvbgtdIoRy2RPOMsUkiIATbcnHfFjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682068; c=relaxed/simple;
	bh=VytSzQob+eJH5p5v4nuk6Tb4UlSJyQPTWnXVa9f7qHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF8IhsPs9wxlGtUdGOwBDOsteUaRTmN42zPUZozrF/oVgJnKEDPfwc6deRJax+C8xntXbsPuUvtRYEaY6GCiXW1vZrlPSlSHxD/14FG7OnlbzxqIq55QjkpGLuGJRjN1F20hSaT1t2CrSfKxLoTZRoXaHiqRLyuGH3o8svFS4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/DnNENI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-429c4a4c6a8so2188245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723682065; x=1724286865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYBBp8MdgJpDzmzKWf0FPivxU2t9lT+77YiFk2ooOxQ=;
        b=L/DnNENIwaF87Q16E+4ti1rRZRBLBj/NtyLCSvf3wRwKsCQIuaF0RKswlLv4akfjyq
         fEwf2xvvFR153BkVL8IOcQsFDDCHOU/TUH6DE6mlRuLrDPT2iQKickRVIKoLJBC+b+kK
         yOTHQHOUlJQ2TqVA9nrgja8/8uJv4jQNnX9pVj4bnDVqd8ELFAsKTocZVPrKOoMg60XL
         LxbJqIRjrtYFOXtOFSHK+YbnrGhZs7Sva53dYbMyxghXlJHiZ6kOP8JiUpJ2ckMuR9D8
         WxyIHnBqNq6Gn9a0PUlr989sRK5KdbVNZVdqjEgMep1B7GgDtMwkZFQTtB51DggmXfDZ
         35Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723682065; x=1724286865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYBBp8MdgJpDzmzKWf0FPivxU2t9lT+77YiFk2ooOxQ=;
        b=JHDgMpv38szfIAw8yoG740Km1Y/VCh6ywk77T1Fx14sNQcsoqAT1U9ZoWf2IsTUYNc
         JUvgraWfCKKL4FapqLpTJRPnegF2OaixHHHcByzJhhbFjU8X32dkru9GLH6qzcrgqJFn
         ccBgK7IkTkHtEa9CG463SbzUgUFpekDFxB+vaiZlUy3JRtPMWNV92EG2iRPV3PoPHD3O
         oGP39scFyuN1rGSNRVIoZxtBN1xd/SmnJi6fhY3/5a/X/25dAMpWS/8UsacyDgel5GTI
         Uw+ZXIipROIazu2e00VQTXgArKCCMQvFVofyJH+n5PDvAQ7CdhAUNDEMvvtbzTeFvFyl
         h03Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEyICKWOMRY4me8ZdLzX332i9ehUTJLyQ4wYLEWmCHozy/EiRT856vDYImyuJvTGR9bMsh1DT+s6Wo7YxeNYZxwRCtoVlSMrPyajs5
X-Gm-Message-State: AOJu0Yy6A+7OoaEBAmUcmh2ygE4FHIpQQ6p0ERTJevMEaOjkwuHAVaJ3
	yeOeZUjTHSPfxlPKboUQaT3XSFA0xD6Kw4DOpdZHOgXAR4kXYWGD1fnulQ==
X-Google-Smtp-Source: AGHT+IElhjGJFHAjb3pDkCKnDLfu6WM/NR0TgZhQutcTk8dyPGJvZ5qmOb2PW6YXLSFWnrJpHzgUMA==
X-Received: by 2002:a05:600c:4f45:b0:428:2502:75b5 with SMTP id 5b1f17b1804b1-429dd238160mr26205455e9.11.1723682064361;
        Wed, 14 Aug 2024 17:34:24 -0700 (PDT)
Received: from andrea ([151.76.20.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19670sm33932685e9.9.2024.08.14.17.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:34:23 -0700 (PDT)
Date: Thu, 15 Aug 2024 02:34:19 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Eagerly flush in flush_icache_deferred()
Message-ID: <Zr1NC7GBQHfqqplf@andrea>
References: <20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com>
 <20240813-fix_fencei_optimization-v1-2-2aadc2cdde95@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-fix_fencei_optimization-v1-2-2aadc2cdde95@rivosinc.com>

> <---- Thread 1 starts running here on CPU1
> 
> <---- Thread 2 starts running here with same mm
> 
> T2: prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI_ON, PR_RISCV_SCOPE_PER_PROCESS);
> T2: <-- kernel sets current->mm->context.force_icache_flush to true

Mmh, TBH, I'm not sure how this patch is supposed to fix the race in
question:

For once, AFAIU, the operation

T2: cpumask_setall(&current->mm->context.icache_stale_mask)

(on CPU2?) you've added with this patch...


> T2: <modification of instructions>
> T2: fence.i
> 
> T1: fence.i (to synchronize with other thread, has some logic to
>              determine when to do this)
> T1: <-- thread 1 is preempted
> T1: <-- thread 1 is placed onto CPU3 and starts context switch sequence
> T1 (kernel): flush_icache_deferred() -> skips flush because switch_to_should_flush_icache() returns true

... does _not_ ensure that T1: flush_icache_deferred() on CPU3 will
observe/read from that operation: IOW,

T1: cpumask_test_and_clear_cpu(cpu, &mm->context.icache_stale_mask)

may still evaluate to FALSE, thus preventing the FENCE.I execution.

Moreover, AFAIU, ...


> 				     -> thread has migrated and task->mm->context.force_icache_flush is true
> 
> T2: prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI_OFF, PR_RISCV_SCOPE_PER_PROCESS);

... moving the operation(s)

T2: set_icache_stale_mask()
	T2: cpumask_setall(&current->mm->context.icache_stale_mask)

before the following operation...  (per patch #1)


> T2 (kernel): kernel sets current->mm->context.force_icache_flush = false
> 
> T1 (kernel): switch_to() calls switch_to_should_flush_icache() which now
> 	     returns false because task->mm->context.force_icache_flush
> 	     is false due to the other thread emitting
> 	     PR_RISCV_CTX_SW_FENCEI_OFF.

... does not ensure that T1: switch_to_should_flush_icache() on CPU3
will observe

T1: cpumask_test_cpu(<cpu3>, &task->mm->context.icache_stale_mask) == true

in fact, T1 may evaluate the latter expression to FALSE while still
being able to observe the "later" operation, i.e.

T1: task->mm->context.force_icache_flush == false


Perhaps a simplified but useful way to look at such scenarios is as
follows:

  - CPUs are just like nodes of a distributed system, and

  - store are like messages to be exchanged (by the memory subsystem)
    between CPUs: without some (explicit) synchronization/constraints,
    messages originating from a given CPU can propagate/be visible to
    other CPUs at any time and in any order.


IAC, can you elaborate on the solution proposed here (maybe by adding
some inline comments), keeping the above considerations in mind? what
am I missing?


> T1 (back in userspace): Instruction cache was never flushed on context
> 			switch to CPU3, and thus may execute incorrect
> 			instructions.

Mmh, flushing the I$ (or, as meant here, executing a FENCE.I) seems
to be only half of the solution: IIUC, we'd like to ensure that the
store operation

T2: <modification of instructions>

originated from CPU2 is _visible_ to CPU3 by the time that FENCE.I
instruction is executed, cf.

[from Zifencei - emphasis mine]

A FENCE.I instruction ensures that a subsequent instruction fetch on
a RISC-V hart will see any previous data stores _already visible_ to
the same RISC-V hart.


IOW (but assuming code is in coherent main memory), imagine that the
(putative) FENCE.I on CPU3 is replaced by some

T1: LOAD reg,0(insts_addr)

question is: would such a load be guaranteed to observe the store

T2: <modification of instructions>  #  STORE new_insts,0(insts_addr)

originated from CPU2? can you elaborate?

  Andrea

