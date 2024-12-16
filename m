Return-Path: <linux-kernel+bounces-448202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3249F3CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3883168C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551021D54C0;
	Mon, 16 Dec 2024 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmj3uwnA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6111D4169;
	Mon, 16 Dec 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385093; cv=none; b=S5CUiykITKlzPiJs1au1VJDGHx/x4410k+o3+tj4KBcLSbjDo6BwHY3AQwTBjqW/65NTVJYDfKo7ZXFQWUPPBER8UTF+KTXO23W7ng4vSK7+dUEoa6Q9YdbbxxdWtQVzZkJbUYqlfp9xwOWkNRna2ZJpjlPwM35olfeODiB/37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385093; c=relaxed/simple;
	bh=S//aHnmiwlKpC4zrf5ah0OGezbmqK23xUtM2DZ/uTMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7qxsfIAMFk1U0s/Ji8UhuWNsBXNtXGG//0H7OAf4OIutFxOeQ1KjZu6Fo0RQZ5Mq0eQpbs4FxtMxFtb5AzblJlq01VC5uobguDZMwwj9tvD3l2EoHTTgPbTxh3R3F6Ff8Tm3IoxMm7+/Ax54DuSpW+MfvgiSjQT1GRkngQb/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lmj3uwnA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eQZ4movVBV5OyxGyGtrXDRWuzYuGglmPmc94RPaLDPs=; b=lmj3uwnAWCk4GZUBwCltac1hMA
	og8Vhfg9PCVHyRLXmi8twh6OrPtnpDmcHtaBdsOdeitDDdO8KtsQb5llfs349+cHcUOMic7nY2vHH
	b9xKN4iCcOScmgcCSZW2k6NA0kX2oqkFoLNnG6yyVfn2riHTyz1LRNlDkfo1KnrU+0EtTd844hgHg
	nTD8qMKd4GnWTtB+mS35JVSXXo37bZcHWg5Py0W82dZK2P6nRtt7Qxbp92dCVPWVwBTHDcONx423M
	28WizP5SJf8hugS7lKKMDr69gTnKKxAEYctS72derFFDaM1homYXNa7fuc6db9KipwUifzPpo/7Ud
	4/mtuNFA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNImo-00000002IRi-1ITN;
	Mon, 16 Dec 2024 21:37:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEE0130031E; Mon, 16 Dec 2024 22:37:53 +0100 (CET)
Date: Mon, 16 Dec 2024 22:37:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, lokeshgidra@google.com, minchan@google.com,
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, klarasmodin@gmail.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 10/16] mm: replace vm_lock and detached flag with a
 reference count
Message-ID: <20241216213753.GD9803@noisy.programming.kicks-ass.net>
References: <20241216192419.2970941-1-surenb@google.com>
 <20241216192419.2970941-11-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216192419.2970941-11-surenb@google.com>

On Mon, Dec 16, 2024 at 11:24:13AM -0800, Suren Baghdasaryan wrote:
> +static inline void vma_refcount_put(struct vm_area_struct *vma)
> +{
> +	int refcnt;
> +
> +	if (!__refcount_dec_and_test(&vma->vm_refcnt, &refcnt)) {
> +		rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> +
> +		if (refcnt & VMA_STATE_LOCKED)
> +			rcuwait_wake_up(&vma->vm_mm->vma_writer_wait);
> +	}
> +}
> +
>  /*
>   * Try to read-lock a vma. The function is allowed to occasionally yield false
>   * locked result to avoid performance overhead, in which case we fall back to
> @@ -710,6 +728,8 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
>   */
>  static inline bool vma_start_read(struct vm_area_struct *vma)
>  {
> +	int oldcnt;
> +
>  	/*
>  	 * Check before locking. A race might cause false locked result.
>  	 * We can use READ_ONCE() for the mm_lock_seq here, and don't need
> @@ -720,13 +740,20 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
>  		return false;
>  
> +
> +	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> +	/* Limit at VMA_STATE_LOCKED - 2 to leave one count for a writer */
> +	if (unlikely(!__refcount_inc_not_zero_limited(&vma->vm_refcnt, &oldcnt,
> +						      VMA_STATE_LOCKED - 2))) {
> +		rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
>  		return false;
> +	}
> +	lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
>  
>  	/*
> +	 * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
>  	 * False unlocked result is impossible because we modify and check
> +	 * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lock_seq
>  	 * modification invalidates all existing locks.
>  	 *
>  	 * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
> @@ -734,10 +761,12 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	 * after it has been unlocked.
>  	 * This pairs with RELEASE semantics in vma_end_write_all().
>  	 */
> +	if (oldcnt & VMA_STATE_LOCKED ||
> +	    unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
> +		vma_refcount_put(vma);

Suppose we have detach race with a concurrent RCU lookup like:

					vma = mas_lookup();

	vma_start_write();
	mas_detach();
					vma_start_read()
					rwsem_acquire_read()
					inc // success
	vma_mark_detach();
	dec_and_test // assumes 1->0
		     // is actually 2->1

					if (vm_lock_seq == vma->vm_mm_mm_lock_seq) // true
					  vma_refcount_put
					    dec_and_test() // 1->0
					      *NO* rwsem_release()



>  		return false;
>  	}
> +
>  	return true;
>  }

