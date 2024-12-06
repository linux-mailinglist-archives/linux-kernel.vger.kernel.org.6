Return-Path: <linux-kernel+bounces-434712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEA49E6A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BCE16A0B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A21E1A3B;
	Fri,  6 Dec 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0vDd31tz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wuTVwGZo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1B1DC74A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477246; cv=none; b=UQo99s/F7H7Eey/sK/vNMGVH9sPZGAggczMXt4NZMFnyKRh7QWIkXzdIB7v0N4jgtBognSFdMFW9mOYU2NkORjGbjqIY1aIl8q8BX524aw8p96uZeyiOjEk/eUbYsEHqAdQCJVHE0hkKR7D3n/pxXr2XHbb6bM3VX/YWaU7UXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477246; c=relaxed/simple;
	bh=nPdXi1VDeaiylW6SG9NtA1F+A8XSZbYYFxscwJ5SIao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q6wX3xow6tbkN/skkKl2JBCe7OS38IQAIkFCYp1GGbB5BNLFVF6MwD6CxqATkppBBxb0ow26uO3C472CE5cplIgandI/ppzYKVwgPpKZtzoS/J6+JGuEfrFWdfZ6rJyYqQxlF25Nalc3o3NRFuMpypKXn2bMg1ud0ddemjPbj7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0vDd31tz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wuTVwGZo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733477243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6EzOXwr8ZXifI4qVbt3rD4Tmy8sdZ2bwXrr0HAhosU=;
	b=0vDd31tzqDWzWOL5mVjGrc5W2mh+VfLv5HmifAtO9f/rW9aOOiGo/dSc38Ve1x363AySVl
	m4ZAlLiAQL3R/0IOlZN7HJziqLBsFQ/sGZdHchSeLagLNiAAIW6QYWB8l6bm9K5eOgAPXt
	8tcQIgiIOV5sL9KX3+4XkvoDnhjOdQOba7fxjb0yuKd4AzXM86oItLTzmCZoiSirOFkN++
	Mj81YWuEl7MTiWDDBQ+R0eG03wSqmsEGubqFjQFTm7KgiqSSVq3YwYgfwtBwsBGEjtuu96
	UKD7MtqlFI+G8WZt62JxQ4vu1WF/tHnZHesMBoOzeZY6jQ08UUSQEKjDAubpWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733477243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6EzOXwr8ZXifI4qVbt3rD4Tmy8sdZ2bwXrr0HAhosU=;
	b=wuTVwGZoCu3SyIqij3bRVb4ZZlzBn0CRtr9BjD3C7zYAjaenkim85ouGtDYooG5ALfeuOQ
	zQIgAEKCdiVe1SDw==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 08/11] futex: Resize futex hash table based on number
 of threads.
In-Reply-To: <20241203164335.1125381-9-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-9-bigeasy@linutronix.de>
Date: Fri, 06 Dec 2024 10:27:21 +0100
Message-ID: <87frn1qhza.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 17:42, Sebastian Andrzej Siewior wrote:
>  int futex_hash_allocate_default(void)
>  {
> -	return futex_hash_allocate(0);
> +	unsigned int threads;
> +	unsigned int buckets;
> +	unsigned int current_buckets = 0;
> +	struct futex_hash_bucket_private *hb_p;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +
> +	if (!current->mm)
> +		return 0;
> +
> +	scoped_guard(rcu) {
> +		threads = get_nr_threads(current);
> +		hb_p = rcu_dereference(current->mm->futex_hash_bucket);
> +		if (hb_p) {
> +			if (hb_p->slots_invariant)
> +				return 0;
> +			current_buckets = hb_p->hash_mask + 1;
> +		}
> +	}
> +
> +	buckets = roundup_pow_of_two(4 * threads);
> +	buckets = max(buckets, 16);
> +	buckets = min(buckets, futex_default_max_buckets);
> +	if (current_buckets > buckets)

  >= ?

Thanks,

        tglx

