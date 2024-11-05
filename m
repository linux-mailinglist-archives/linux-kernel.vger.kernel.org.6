Return-Path: <linux-kernel+bounces-396163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719579BC8CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A420C1C233CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F591CF5EE;
	Tue,  5 Nov 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j6wavOpN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F641CF296
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798029; cv=none; b=oD1LoVrkRm0Iq4T+j9Wex5rWxB5b4ycTBOe6iK7Xj8ruXCGQKY8SkW8sOz6O/ONkuAqKngLWEU8awndP3B3LIvfI9DHEzpT22LfuUAUECxBtr40O1Cj+hGCr8/Hm1rUJniBO8dx2Pp66pXeZXWu3VQvTH6mTm1I9NCvryAchMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798029; c=relaxed/simple;
	bh=/uktjdKUtDHXwRNkZ6JUfbvaEMdoGAzoPcHfpZtQQFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZmQqnfqB0hXQLzMV1ZWaisSPWQvo3cIDt3bj512R3sU7bxF0IPTLOphFaEGK2YbduiBCLOogs+e89DAG5fq8Zt1mKB45T5Hh4XsESpkNgpSWyn7pyip93b/0djDDouNHTrysF3zI7ZDwxcmuWa4PayPcJTM/K/nA/NxnxWN0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j6wavOpN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VM47Ewpc3p9HPFEpEOl521sbhCukpieT/LlFQiMY2IU=; b=j6wavOpN9FEWZsu7jdyW+YinXd
	HxVNxh7C8N5crOl301NpA/qmmqyBn9enM8KauHtM12AXOSiyKYxL70D38q6ADQu+PvwRzHG5Ox+90
	nTArQHlNtsIPIIhjUHG16TAhiJKg/nYdx1izz9RI14gd6WCAhMFPdEDeJ1XGy2JuitU0SwXN2XuBK
	Aurm1kjuR0aXK+PXvCQK4jhdZZi1AiXHGME2CAEXzwWeiR1mTEUMzot7IJ2sdeCP1n8r4lDD60Kdx
	gz07bZLfUZCf2R71FIY/4DgLCqXXq7jLOY0xFcwUDUWMeMyWhGj82dpaPh45eDFxLTjhbTr8wwYiO
	LxEprFoA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Fd9-00000002L2H-09J7;
	Tue, 05 Nov 2024 09:13:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D3FF930083E; Tue,  5 Nov 2024 10:13:42 +0100 (CET)
Date: Tue, 5 Nov 2024 10:13:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] kcsan, seqlock: Fix incorrect assumption in
 read_seqbegin()
Message-ID: <20241105091342.GA9767@noisy.programming.kicks-ass.net>
References: <20241104161910.780003-1-elver@google.com>
 <20241104161910.780003-6-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104161910.780003-6-elver@google.com>

On Mon, Nov 04, 2024 at 04:43:09PM +0100, Marco Elver wrote:
> During testing of the preceding changes, I noticed that in some cases,
> current->kcsan_ctx.in_flat_atomic remained true until task exit. This is
> obviously wrong, because _all_ accesses for the given task will be
> treated as atomic, resulting in false negatives i.e. missed data races.
> 
> Debugging led to fs/dcache.c, where we can see this usage of seqlock:
> 
> 	struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
> 	{
> 		struct dentry *dentry;
> 		unsigned seq;
> 
> 		do {
> 			seq = read_seqbegin(&rename_lock);
> 			dentry = __d_lookup(parent, name);
> 			if (dentry)
> 				break;
> 		} while (read_seqretry(&rename_lock, seq));
> 	[...]
> 
> As can be seen, read_seqretry() is never called if dentry != NULL;
> consequently, current->kcsan_ctx.in_flat_atomic will never be reset to
> false by read_seqretry().
> 
> Give up on the wrong assumption of "assume closing read_seqretry()", and
> rely on the already-present annotations in read_seqcount_begin/retry().
> 
> Fixes: 88ecd153be95 ("seqlock, kcsan: Add annotations for KCSAN")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * New patch.
> ---
>  include/linux/seqlock.h | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 45eee0e5dca0..5298765d6ca4 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -810,11 +810,7 @@ static __always_inline void write_seqcount_latch_end(seqcount_latch_t *s)
>   */
>  static inline unsigned read_seqbegin(const seqlock_t *sl)
>  {
> -	unsigned ret = read_seqcount_begin(&sl->seqcount);
> -
> -	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry() */
> -	kcsan_flat_atomic_begin();
> -	return ret;
> +	return read_seqcount_begin(&sl->seqcount);
>  }
>  
>  /**
> @@ -830,12 +826,6 @@ static inline unsigned read_seqbegin(const seqlock_t *sl)
>   */
>  static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
>  {
> -	/*
> -	 * Assume not nested: read_seqretry() may be called multiple times when
> -	 * completing read critical section.
> -	 */
> -	kcsan_flat_atomic_end();
> -
>  	return read_seqcount_retry(&sl->seqcount, start);
>  }

OK, so this takes us back to kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX)
and kcsan_atomic_next(0).

Which I suppose is safe, except it doesn't nest properly.

Anyway, these all look really nice, let me go queue them up.

Thanks!

