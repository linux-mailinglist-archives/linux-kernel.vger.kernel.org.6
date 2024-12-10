Return-Path: <linux-kernel+bounces-439845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1AA9EB4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32F118841B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078E21BB6A0;
	Tue, 10 Dec 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lXXCuK4K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vS+ewJHv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F411B86DC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844237; cv=none; b=CqmZNRRFTmAKdL4eKj7Ct0wlTo1hh/WSJA3LzlC+pXeAA15OvkpR2JNVJbAyOlF1pkVx44DLPbEqLdDz2c2jl88mnkJgl0pMHipEgL36aM2+hgoFZTzImIBNbsQhbdMnoDQ5FYbxRzVUZP0R53SapzTZ7h97k06lvcg2C076Jxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844237; c=relaxed/simple;
	bh=KX5AKvDde/B2XVVO74UfhHgRbDLLkLiu0nDJ7lx1FsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uU2WTh5xalE91s6fRHiCzFzg5SU8+WuvGajM2DEBHgNMR1usThkazMiWBm2PNkUldPtZx8cFu6e06X0RPg21jfRHbYhkWDZ4K+Cs0zEqAa7iK68wPvjfkOFV16d39LzzslZt+WR25p1AEdFYYda4V2HR6EtT+1ihqYkKhmHn3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lXXCuK4K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vS+ewJHv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733844233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yv8SE8D/M2bg4bKCu3XRi7T5xTfFnpuuizoNDLCXHEQ=;
	b=lXXCuK4KGfLKgRXCHYosr1lyGBGY4sx1qlAEqXGpYjtsurPmmz2Om6MiN9HbqLcLzPt5jZ
	jnK1vKHHTO2Fq8AEvVmpI8vmFwD2steSiSPUrFIeMD6EFfjUwIZ8NoqAUMk3FNyILlgpzY
	gnAqn1cytEIgt/QnORttqAv+femehJ9jLv9UYYa6mWr9ifD+8k7MPO1OqWqTcbjaQCZd6G
	PrkjgdsPgL5C3B4R6BwgIuA2PsqnZtjM2iMH56WTM1qreYC70oTkaBh/oFf07usmNwY2WL
	NS0YEU3HzvJfTmRPFgCRGUtV4/JeH86QWsWYbTzBffHSQ0OY3xlbU/wYfssFew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733844233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yv8SE8D/M2bg4bKCu3XRi7T5xTfFnpuuizoNDLCXHEQ=;
	b=vS+ewJHvzwWEIZm/PeCP8ZLi1iLQf940FMBqjq2jWWuinh4oG40N1wiKG2KxG3eY+kiGCh
	hztFf1yR0Hl6ZADQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 02/11] futex: Add basic infrastructure for local task
 local hash.
In-Reply-To: <20241203164335.1125381-3-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-3-bigeasy@linutronix.de>
Date: Tue, 10 Dec 2024 16:23:53 +0100
Message-ID: <87frmvd0ja.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 17:42, Sebastian Andrzej Siewior wrote:
>  long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
>  	      u32 __user *uaddr2, u32 val2, u32 val3);
> +int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
> +		     unsigned long arg4, unsigned long arg5);
> +int futex_hash_allocate_default(void);
> +void futex_hash_free(struct mm_struct *mm);
> +
> +static inline void futex_mm_init(struct mm_struct *mm)
> +{
> +	mm->futex_hash_bucket = NULL;
> +}
> +
>  #else
>  static inline void futex_init_task(struct task_struct *tsk) { }
>  static inline void futex_exit_recursive(struct task_struct *tsk) { }
> @@ -88,6 +98,18 @@ static inline long do_futex(u32 __user *uaddr, int op, u32 val,
>  {
>  	return -EINVAL;
>  }
> +static inline int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
> +				   unsigned long arg4, unsigned long arg5)
> +{
> +	return -EINVAL;
> +}
> +static inline int futex_hash_allocate_default(void)
> +{
> +	return 0;
> +}
> +static inline void futex_hash_free(struct mm_struct *mm) { }
> +static inline void futex_mm_init(struct mm_struct *mm) { }
> +
>  #endif
>  
>  #endif
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7361a8f3ab68e..b16b97ab8fb2a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -30,6 +30,7 @@
>  #define INIT_PASID	0
>  
>  struct address_space;
> +struct futex_hash_bucket;
>  struct mem_cgroup;
>  
>  /*
> @@ -902,6 +903,8 @@ struct mm_struct {
>  		int mm_lock_seq;
>  #endif
>  
> +		unsigned int			futex_hash_mask;
> +		struct futex_hash_bucket	*futex_hash_bucket;

So you provided stubs for the accessors/init functions etc. Shouldn't
this be #ifdef guarded too?

Thanks,

        tglx

