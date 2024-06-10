Return-Path: <linux-kernel+bounces-208687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDC3902820
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC3E281CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C60A148841;
	Mon, 10 Jun 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GIACEFCn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9913114BF87
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042283; cv=none; b=Pf1Om7gLJrS4PVwFLJ1lgvbUqY2ZIe6QZb84KBv9OT4GjEw27TnJh3w+JqLGeeRX/M3XGP9lwLjT5vYuKVS7rHX1VTpm4KqbQjeLAYAkCJ1At8b7Ww9NMfZxJXXzkjwi2I3h15ijFdD3+4d6Q4S5rILRj/fKlhzAZwZi8/lMRI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042283; c=relaxed/simple;
	bh=ZEE78fBW4oj/V++IoBCqlsA5SuhniLQAzUs8q7rHGFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6RHypdZN/KcNFfRX+UEnHuvy4E0skVYRePIsUIm13bz+FHH3ef4i0r/3rFp9NbgWLMA7C4N6jfh8kVlsc7W4LydDh/H8dWNFISb3v5sPEk4Fz/7FAdpypqDdaSobQ/btZJghjmz+aPkY5CrG08CjeH66IyCI+SQgjYEzoc45Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GIACEFCn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tzE9/qnr4um+VYO+527ypE8v0RW1c1pcyvH5D6izX7c=; b=GIACEFCn31GfIWfvsLmy+aurfg
	u54oICw6bSzxsjtoFFsgI4Y1wFVOIngoKAqiuXsLdZpnX1EaIRzS2CKjal3OHanvY7sJmHHJtQGUN
	SXAzFGHKuF8fhYthBm0SSuFNilkxt18+RkKSFtoO3UGLKkDlN2oRmvKaLhRXWu19wB0RmeOjjyR1P
	DPUxgS6vUKitcChuHYFfpdsMx0LloKBaNFEUwGEwvJc5DWJs/3MK16bcrBQ5OYYqcLJpbY2qvMwC7
	FRPnJqCPmLMnsugnn3BxW5UJQjlE+nJbeaDVUBkr+eKA7C/Gtpn7P3Q76jDm86CksEqld9Q/rStH8
	5EpGTq6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGjHI-00000009bYK-3rW4;
	Mon, 10 Jun 2024 17:57:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38CC2300439; Mon, 10 Jun 2024 19:57:56 +0200 (CEST)
Date: Mon, 10 Jun 2024 19:57:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sam Sun <samsun1006219@gmail.com>, x86@kernel.org,
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Subject: Re: [patch 2/4] jump_label: Fix concurrency issues in
 static_key_slow_dec()
Message-ID: <20240610175756.GU8774@noisy.programming.kicks-ass.net>
References: <87bk49xf15.ffs@tglx>
 <20240610124258.109097511@linutronix.de>
 <20240610124406.422897838@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610124406.422897838@linutronix.de>

On Mon, Jun 10, 2024 at 02:46:36PM +0200, Thomas Gleixner wrote:

> @@ -247,20 +247,25 @@ EXPORT_SYMBOL_GPL(static_key_disable);
>  
>  static bool static_key_slow_try_dec(struct static_key *key)
>  {
> +	int v;
>  
>  	/*
> +	 * Go into the slow path if key::enabled is less than or equal than
> +	 * one. One is valid to shut down the key, anything less than one
> +	 * is an imbalance, which is handled at the call site.
> +	 *
> +	 * That includes the special case of '-1' which is set in
> +	 * static_key_slow_inc_cpuslocked(), but that's harmless as it is
> +	 * fully serialized in the slow path below. By the time this task
> +	 * acquires the jump label lock the value is back to one and the
> +	 * retry under the lock must succeed.

Harmless yes, but it really should not happen to begin with. If this
happens it means someone wants to disable a key that is in the middle of
getting enabled for the first time.

I'm tempted to want a WARN here instead. Hmm?

>  	 */
> +	v = atomic_read(&key->enabled);
> +	do {
> +		if (v <= 1)
> +			return false;
> +	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
> +
>  	return true;
>  }

