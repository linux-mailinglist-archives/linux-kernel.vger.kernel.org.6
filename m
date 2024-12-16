Return-Path: <linux-kernel+bounces-448178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD66D9F3C99
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91409188284C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D5F1D4600;
	Mon, 16 Dec 2024 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NfAQT7RC"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C4139CEF;
	Mon, 16 Dec 2024 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383768; cv=none; b=nrbVNk7Sm85ikU52572PaXYgtxaLqBuo33PvVVNQu47C/kTazE1YsNc7whob2FSTj0bcEKc9tihRtIX0OVgh9Q7uzloIga2hf2VMix096aCBxAmj/dkB9cAZDxo+L/QXggTvgkfdnohK8Q7GBhfeGh3gDVV1M236neVEE8ImFUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383768; c=relaxed/simple;
	bh=p7TYtotFYa4y5nQEwj4JJYabgdwgE9RHpPtpdDzCv0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMGpR8jgD9Oml56Fb6B3Qt90U/AlQ3u9ZmOzUnfvXbv6RSSfMAaznLmAApkw2DZbvO5lJBnIGHOkjD9kM92S3pCXPUsNqNfvQh3Lwwy6zsgFaK8dpGfSZmdrtdj8+KBhmXzHYTtbjay8hb0VFh7E6wHLSKqLXyvlhIEbMWlQEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NfAQT7RC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wqNYOv2fOBvrraLi79AJjU9ppSyLY79/galhJe9yCkU=; b=NfAQT7RC312eJHlSA9cGJJbM6k
	YMsJHVMYQwLfEH/fJ+uQdUatWWB2pmwhcnB+eAE3B3tKIZ5MgKTXOKwNo14ZOfnjRLxRh6HeW3SVX
	r9oQxU9hjAXWeElN2EwabOa6s+UP3IDHJaZUJNAJLYbk5BxeheDKWBDoJ61Nkp20o0/7d8uX1syvQ
	tQTSIbhKwrkEq8cpVtuR2nBFUwrZRrME7nIEa0eSNPImDgyJ8H43+Nq7QFe/jHNALSwcOn5hyMF9t
	MY1MG2pe+AIFxrl2ya7eVRongwJYDCEuLudwQ2fhpowZ4Hn8w5l5wTTY0xO0sPjIuF1pkzZPCEHpc
	9/G2u0Tw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNIQz-00000004wfB-1VYk;
	Mon, 16 Dec 2024 21:15:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A1DCF30031E; Mon, 16 Dec 2024 22:15:20 +0100 (CET)
Date: Mon, 16 Dec 2024 22:15:20 +0100
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
Message-ID: <20241216211520.GB9803@noisy.programming.kicks-ass.net>
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

FWIW, I find the whole VMA_STATE_{A,DE}TATCHED thing awkward. And
perhaps s/VMA_STATE_LOCKED/VMA_LOCK_OFFSET/ ?

Also, perhaps:

#define VMA_REF_LIMIT	(VMA_LOCK_OFFSET - 2)

> @@ -699,10 +700,27 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
>  #ifdef CONFIG_PER_VMA_LOCK
>  static inline void vma_lock_init(struct vm_area_struct *vma)
>  {
> -	init_rwsem(&vma->vm_lock.lock);
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	static struct lock_class_key lockdep_key;
> +
> +	lockdep_init_map(&vma->vmlock_dep_map, "vm_lock", &lockdep_key, 0);
> +#endif
> +	refcount_set(&vma->vm_refcnt, VMA_STATE_DETACHED);
>  	vma->vm_lock_seq = UINT_MAX;

Depending on how you do the actual allocation (GFP_ZERO) you might want
to avoid that vm_refcount store entirely.

Perhaps instead write: VM_WARN_ON(refcount_read(&vma->vm_refcnt));

> @@ -813,25 +849,42 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  
>  static inline void vma_assert_locked(struct vm_area_struct *vma)
>  {
> -	if (!rwsem_is_locked(&vma->vm_lock.lock))
> +	if (refcount_read(&vma->vm_refcnt) <= VMA_STATE_ATTACHED)
	if (is_vma_detached(vma))

>  		vma_assert_write_locked(vma);
>  }
>  
> -static inline void vma_mark_attached(struct vm_area_struct *vma)
> +/*
> + * WARNING: to avoid racing with vma_mark_attached(), should be called either
> + * under mmap_write_lock or when the object has been isolated under
> + * mmap_write_lock, ensuring no competing writers.
> + */
> +static inline bool is_vma_detached(struct vm_area_struct *vma)
>  {
> -	vma->detached = false;
> +	return refcount_read(&vma->vm_refcnt) == VMA_STATE_DETACHED;
	return !refcount_read(&vma->vm_refcnt);
>  }
>  
> -static inline void vma_mark_detached(struct vm_area_struct *vma)
> +static inline void vma_mark_attached(struct vm_area_struct *vma)
>  {
> -	/* When detaching vma should be write-locked */
>  	vma_assert_write_locked(vma);
> -	vma->detached = true;
> +
> +	if (is_vma_detached(vma))
> +		refcount_set(&vma->vm_refcnt, VMA_STATE_ATTACHED);

Urgh, so it would be really good to not call this at all them not 0.
I've not tried to untangle the mess, but this is really awkward. Surely
you don't add it to the mas multiple times either.

Also:

	refcount_set(&vma->vm_refcnt, 1);

is so much clearer.

That is, should this not live in vma_iter_store*(), right before
mas_store_gfp() ?

Also, ISTR having to set vm_lock_seq right before it?

>  }
>  
> -static inline bool is_vma_detached(struct vm_area_struct *vma)
> +static inline void vma_mark_detached(struct vm_area_struct *vma)
>  {
> -	return vma->detached;
> +	vma_assert_write_locked(vma);
> +
> +	if (is_vma_detached(vma))
> +		return;

Again, this just reads like confusion :/ Surely you don't have the same
with mas_detach?

> +
> +	/* We are the only writer, so no need to use vma_refcount_put(). */
> +	if (!refcount_dec_and_test(&vma->vm_refcnt)) {
> +		/*
> +		 * Reader must have temporarily raised vm_refcnt but it will
> +		 * drop it without using the vma since vma is write-locked.
> +		 */
> +	}
>  }

