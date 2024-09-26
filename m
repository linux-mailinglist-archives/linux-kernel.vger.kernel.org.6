Return-Path: <linux-kernel+bounces-340745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A518E987754
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78521C2291E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2900B15ADAB;
	Thu, 26 Sep 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE6LfrsQ"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0115A4B0
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367015; cv=none; b=en5OplXQWXaTiVtsMOR8QOcm+t3T7uuIQfQwtAnYi6+i5EvBeYxh+NJzShYlbrQ56OWir7AR0AaVORxQX5lBXtp3qGuT+24tWru7IM7TqdvMas0XzhrgGE7rPx7aNdTH4LHn8WY2dUV23HyEbm7wiZk/vCPofsXo5Q7stXo7kKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367015; c=relaxed/simple;
	bh=9ppUXlQStz/pVBs4wA1v93gcurIcZpsmK1CpKcYPpas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuqJ5QYtWGn0d9MZzdpdRvOVyk2bKZOK5y7g4BtUyEw4D2CkyOF7w/D/uDdzZ00G5n+FEHnlDRMtOocT0Sa1g022IsFp5bGNt1hI0OikFglzZowrO8JmWUR3w903YnUZq8yY6Zrdu1Z2siqiNApeJi2VKM5XXwNslDRHkGuzSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GE6LfrsQ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb2f272f8bso8765566d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727367012; x=1727971812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBIdWGdOThYriGRAkgCF3gYUdSYRggQHa7ZNg5N9A8M=;
        b=GE6LfrsQnln/L4PUin87wKQyriRvj5W6uHEXfKrbYEdgDe7l3/MjlBmTVjJPsiBXE0
         jY6XMGF1QXPpibChjfeFMHcATl3Z6YvoheASaY6X3r6Lv4SKRnSdrUZbu63DnSuRgZJy
         2ilQvLeX1sPCkG94UwA8/K/C/VKdIk9j0xb9V+/G5q/ElOrkckKNTOvPtF1xCsjKhMYd
         2qQxMUKCQCx8A0d/MHupmx0eDTOenabaANLq4OFUQUb3wpbkcU5smcEEiOST8YAfHdMf
         COKC9dgxzIj8y6NULQwp6plMCbPpbrdj3TvAcQsOR58GjoH9gNWYUPfQdIHkMKqEwkdv
         tyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367012; x=1727971812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBIdWGdOThYriGRAkgCF3gYUdSYRggQHa7ZNg5N9A8M=;
        b=Ai8dIszL611zP17sVrbbvENb8Kpi8C9uBO8t4aS47JgJXzDSRLq4Jma+WXTV1Ot0vU
         ChzHSPtFkqiTCuLKU9AyY5vtPExf0J4DEfBJnC9DUDz46zOnlsnXmaAKlWeeqvCMTDGH
         AyK0KvOc3VI5lFZHFTFIk/EY7S3Vnm3sat/gb7n2fnG3qzyAACqVIMYpAGAmazTuaAMu
         EgNhiIkWcAXUuRz3KhmlyA9H2muXar51OURft5u5rc4AaDm2SLgu/wjjxDQaHXmxXQnL
         clbLB/uHaGnC9gTJ3Npwriyxa2n/HKjKLxVY1D+8NaspMokK5lg+5gtDIHMGjpvmcFXz
         kjoA==
X-Forwarded-Encrypted: i=1; AJvYcCWBSFsXb3yDwk9g4RxBlW7wNlAJ1PbOaawFyhbDqYuEnZNTA273b/YP8DvAltWLxPV7J5KwI2xfSSxqrNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9M3WnsW9tXUn3pj2SP0pooqwvJUghpjWQXB891RuxH7cc804u
	D3zit46g5XKzgbwkuCX6Tbq6gudYurwrOfO3q4FEEf8MpLe284xk
X-Google-Smtp-Source: AGHT+IGYvRvGVK1f59J9V+iEiuzZEgVT+k9OGL6CCe0OR8mKUbCw5TToYTzweTLzwJWHi67SVDDWsw==
X-Received: by 2002:a05:6214:44a1:b0:6bf:7d3c:a64d with SMTP id 6a1803df08f44-6cb3b684717mr2363906d6.32.1727367012290;
        Thu, 26 Sep 2024 09:10:12 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b61362asm637286d6.35.2024.09.26.09.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:10:11 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 45640120006A;
	Thu, 26 Sep 2024 12:10:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 26 Sep 2024 12:10:11 -0400
X-ME-Sender: <xms:Y4f1ZjIPBuqpTFgUe8aZOLDYAL0EYNC94yYYk3Q7wXMjSQ49ezHC8w>
    <xme:Y4f1ZnKASbwZhVVkE0iM82jBL9JjrW6L9wXWek3_BDTjeCBSN9ugLHc6Xwwzfk0YV
    59CShe_W0HF3bgo0A>
X-ME-Received: <xmr:Y4f1Zrt0KnG9t_WtxPHG1IrKGso93iFxlq9iBPoLnHCeaeqwumrN5zOenfWLjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegufihmfidvsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohep
    phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehkvghnth
    drohhvvghrshhtrhgvvghtsehlihhnuhigrdguvghvpdhrtghpthhtoheprghrnhgusegr
    rhhnuggsrdguvgdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidrug
    gv
X-ME-Proxy: <xmx:Y4f1ZsYhO1-V-ueFuVldaH7VXwUIefiTX9RUZiphdskK7ZeEPElZaw>
    <xmx:Y4f1ZqYJUb8gEK3GmpF9VQEEDkN0MjTNZhT5Yt9EIOTu5rCSLhErTQ>
    <xmx:Y4f1ZgDcGp4h7aJ3xh50FZ7B14qJWVugFAMoGWJJz4oWq-_29Hs8LQ>
    <xmx:Y4f1ZoY9tbVw57pL2iSw1BQLHnkZ3x6N7tnyb3kHSFZtdDpB4lViQg>
    <xmx:Y4f1ZupiqieBJGpCWQKVU4f70cFYyXsZX3diGnogEsJSq2c6yrazm5aA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 12:10:10 -0400 (EDT)
Date: Thu, 26 Sep 2024 09:09:24 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lockdep: add lockdep_cleanup_dead_cpu()
Message-ID: <ZvWHNLdMCeWwEQZ7@boqun-archlinux>
References: <f7bd2b3b999051bb3ef4be34526a9262008285f5.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7bd2b3b999051bb3ef4be34526a9262008285f5.camel@infradead.org>

On Thu, Sep 26, 2024 at 04:17:37PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Add a function to check that an offline CPU has left the tracing
> infrastructure in a sane state.
> 
> Commit 9bb69ba4c177 ("ACPI: processor_idle: use raw_safe_halt() in
> acpi_idle_play_dead()") fixed an issue where the acpi_idle_play_dead()
> function called safe_halt() instead of raw_safe_halt(), which had the
> side-effect of setting the hardirqs_enabled flag for the offline CPU.
> 
> On x86 this triggered warnings from lockdep_assert_irqs_disabled() when
> the CPU was brought back online again later. These warnings were too
> early for the exception to be handled correctly.
> 
> So lockdep turned a perfectly harmless bug into a system crash with a
> triple-fault.
> 

I won't call this a "perfectly harmless bug", safe_halt() also contains
tracepoints, which are not supposed to work in offline path IIUC, for
example, you may incorrectly use RCU when RCU is not watching, that
could mean reading garbage memory (surely it won't crash the system, but
I hope I never need to debug such a system ;-)).

Otherwise this patch looks good to me. Thanks!

Regards,
Boqun

> Add lockdep_cleanup_dead_cpu() to check for this kind of failure mode,
> print the events leading up to it, and correct it so that the CPU can
> come online again correctly. Re-introducing the original bug now merely
> results in this warning instead:
> 
> [   61.556652] smpboot: CPU 1 is now offline
> [   61.556769] CPU 1 left hardirqs enabled!
> [   61.556915] irq event stamp: 128149
> [   61.556965] hardirqs last  enabled at (128149): [<ffffffff81720a36>] acpi_idle_play_dead+0x46/0x70
> [   61.557055] hardirqs last disabled at (128148): [<ffffffff81124d50>] do_idle+0x90/0xe0
> [   61.557117] softirqs last  enabled at (128078): [<ffffffff81cec74c>] __do_softirq+0x31c/0x423
> [   61.557199] softirqs last disabled at (128065): [<ffffffff810baae1>] __irq_exit_rcu+0x91/0x100
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  v2: Update commit message to reflect the fact that the original bug
>      fix is now merged as commit 9bb69ba4c177.
> 
> 
>  include/linux/irqflags.h |  6 ++++++
>  kernel/cpu.c             |  1 +
>  kernel/locking/lockdep.c | 24 ++++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 3f003d5fde53..57b074e0cfbb 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -18,6 +18,8 @@
>  #include <asm/irqflags.h>
>  #include <asm/percpu.h>
>  
> +struct task_struct;
> +
>  /* Currently lockdep_softirqs_on/off is used only by lockdep */
>  #ifdef CONFIG_PROVE_LOCKING
>    extern void lockdep_softirqs_on(unsigned long ip);
> @@ -25,12 +27,16 @@
>    extern void lockdep_hardirqs_on_prepare(void);
>    extern void lockdep_hardirqs_on(unsigned long ip);
>    extern void lockdep_hardirqs_off(unsigned long ip);
> +  extern void lockdep_cleanup_dead_cpu(unsigned int cpu,
> +				       struct task_struct *idle);
>  #else
>    static inline void lockdep_softirqs_on(unsigned long ip) { }
>    static inline void lockdep_softirqs_off(unsigned long ip) { }
>    static inline void lockdep_hardirqs_on_prepare(void) { }
>    static inline void lockdep_hardirqs_on(unsigned long ip) { }
>    static inline void lockdep_hardirqs_off(unsigned long ip) { }
> +  static inline void lockdep_cleanup_dead_cpu(unsigned int cpu,
> +					      struct task_struct *idle) {}
>  #endif
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index d293d52a3e00..c4aaf73dec9e 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1338,6 +1338,7 @@ static int takedown_cpu(unsigned int cpu)
>  
>  	cpuhp_bp_sync_dead(cpu);
>  
> +	lockdep_cleanup_dead_cpu(cpu, idle_thread_get(cpu));
>  	tick_cleanup_dead_cpu(cpu);
>  
>  	/*
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 7963deac33c3..42b07c3b8862 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4583,6 +4583,30 @@ void lockdep_softirqs_off(unsigned long ip)
>  		debug_atomic_inc(redundant_softirqs_off);
>  }
>  
> +/**
> + * lockdep_cleanup_dead_cpu - Ensure CPU lockdep state is cleanly stopped
> + *
> + * @cpu: index of offlined CPU
> + * @idle: task pointer for offlined CPU's idle thread
> + *
> + * Invoked after the CPU is dead. Ensures that the tracing infrastructure
> + * is left in a suitable state for the CPU to be subsequently brought
> + * online again.
> + */
> +void lockdep_cleanup_dead_cpu(unsigned int cpu, struct task_struct *idle)
> +{
> +	if (unlikely(!debug_locks))
> +		return;
> +
> +	if (unlikely(per_cpu(hardirqs_enabled, cpu))) {
> +		pr_warn("CPU %u left hardirqs enabled!", cpu);
> +		if (idle)
> +			print_irqtrace_events(idle);
> +		/* Clean it up for when the CPU comes online again. */
> +		per_cpu(hardirqs_enabled, cpu) = 0;
> +	}
> +}
> +
>  static int
>  mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
>  {
> -- 
> 2.44.0
> 
> 



