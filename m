Return-Path: <linux-kernel+bounces-439900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2309EB5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4D281B90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4B71B6D0D;
	Tue, 10 Dec 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fu2xMOst";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aY5Ek/Ug"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523523DEA7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846882; cv=none; b=NxtCbMghFVH4KHDrGGOX1DsABqfixIZBlSc7E5+4ZBI4JmBrpkjFYY8U6ptsJ0WJCPcjWGgb6l+s5jYmXQCbAr3WrKXY0mapECX7UCmfcK2Cp1se4NY5ZmQGRD5s4M3VmX+fYEmpIQ3o7RcEWLDFTkQlNa3qrO7JqxvodP7UDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846882; c=relaxed/simple;
	bh=nGvyVJuYH9+fcN7xa+anNdS7yWyjPlhnKDr3QlZshwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N/Zg7p8GYuvgT1d8rn54xrUzFCgqp6IjowVZFoyFonrcrV5nrDbfYa/Wn/R6t1gi1jnVx0sP8b4uh5cbCcU54UUvh35oPceADOmn3EPne1mfLZZEl89+3XUnNyKmQetcCsPuLllLR7h/Be4w0g1aTv6kqFaPfxjUvCJc7wdncWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fu2xMOst; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aY5Ek/Ug; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733846878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bE7IXpJA5hJHsq8aQLolOyoeGuZXWcnHnnjJ6t3jR+A=;
	b=Fu2xMOstG6thuj2sknsEuaore0PPn6/aSK1jyxsZ7mdDkbRqgH/iiexnJP4DHSXb6NtaZy
	Tn0RJONS1+pcdltntuFKD537gL8xk0UeWx3xVZLZwREroD7LW5c9Rj5uFwCUdKPC9V5vZi
	z0oFkLzbAKgvyR9WM2qhzxUdO3M6uVRPfO1lkF3XSVq68mQ50+0UbGXVfmV15tG+mpBUiH
	BOAmlQMSv4De6lpLOAdnX3jRCTk/xMAB9P3YrU3q3m1KR9yqMLQNoGbA5N3b9QpXBRl0rw
	DVHgCbsfnZTR9yWqhpaiGesTTy/d5EKGnmrWzcR5wTo6ZkXLQZEyrIfkglC/DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733846878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bE7IXpJA5hJHsq8aQLolOyoeGuZXWcnHnnjJ6t3jR+A=;
	b=aY5Ek/UgxNeApe5XgLRAl0UQt/2+Wp2cmrO2paxIw3/4qwWp1dhTVDbZrJQJ8gadhN7TcJ
	k3+cBSg7umZPlyDg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 03/11] futex: Allow automatic allocation of process
 wide futex hash.
In-Reply-To: <20241203164335.1125381-4-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-4-bigeasy@linutronix.de>
Date: Tue, 10 Dec 2024 17:07:58 +0100
Message-ID: <87cyhzcyht.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 17:42, Sebastian Andrzej Siewior wrote:
> +static bool need_futex_hash_allocate_default(u64 clone_flags)
> +{
> +	if ((clone_flags & (CLONE_THREAD | CLONE_VM)) != (CLONE_THREAD | CLONE_VM))
> +		return false;
> +	if (!thread_group_empty(current))
> +		return false;
> +	if (current->mm->futex_hash_bucket)
> +		return false;

If you add an accessor like:

        if (mm_get_futex_hash_bucket(current->mm))

then you can either #ifdef the futex muck in mm_struct or make it

struct mm_futex_hash_bucket {
#ifdef CONFIG_FUTEX
	unsigned int			futex_hash_mask;
	struct futex_hash_bucket	*futex_hash_bucket;
#endif
};

and avoid the #ifdeffery in mm_struct itself because the empty struct
occupies zero space.

The accessor and the other helpers allow the the compiler to optimize
all of it out for CONFIG_FUTEX=n.

Thanks,

        tglx



