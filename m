Return-Path: <linux-kernel+bounces-449036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 242749F48D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261BF16C2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A01E1C30;
	Tue, 17 Dec 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AZ6Fs41b"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22531DDC3F;
	Tue, 17 Dec 2024 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431207; cv=none; b=aVCegFS1EDWe0R0G0f1VDURHovKiculA9KwxpDatT5Elfycha4/Z/J6iGZJugvq4xr8d8M+TLFYhVh2GjCfv0cI4p5pCFrsNpYR2JJa0wwGNXc42grETsaWPd+/dZnvizBTw9r3QyWNmBavnnXKs9pfQZEVfKfvbdU3QB9e7CsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431207; c=relaxed/simple;
	bh=t6EHpJJ3N22ysj1rCHjTXGLgL91+iSHDgQ2Nw+hd4gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lesi+8pECiCUe9jNPKuXZrGcIRnHFs7LhQSCsPfQLu2GQFIK6UGJBCRw8P0++cN6WQVMlR7qlHA5I2d255jhIsPpcakE2UEnTC7BYS9+AUddynX5KNh+o9MMJmrhEgtnx1BsF0KZ9LpEt8KgxHYXrvFo9b3DGnRR7h9ctExQ30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AZ6Fs41b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Uh7v+1Ghavjg8PPxZd2WpiQgCj1MEvkiKdyVIWx2Cg=; b=AZ6Fs41bhM6KjsmhgQn44RBBiZ
	vKmrZ5xFkd8OrbxRS5abw5SJ/1Yf0cV3g8KzbzgnmTMCBwdEcKYDX6CbUPqST/LETJsRMdojNxVE2
	70oiFrZlNtsdTNwc8EOZ4W5ishBxJrge+/BtytV0c7f0Z94IewLiA1mp1/xMZMfDD2D1TjiFL3ckY
	5GzGdQZKInGIQnWoVL2P8ico3GUBjOATYS3jPxKvSWPhGuiE53EkE0dd1HmIVa9YGTBFsMe6AK7xt
	ZsLaaPWMNlSf/kaDqTFBjSwiDp99RTqnD0KRhRrrkFuMTioqr1m/Qi+o8y7lm9fgsJAtkYx4/+91g
	eCiop3/A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUmT-00000006Jip-1v5t;
	Tue, 17 Dec 2024 10:26:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 50D1730015F; Tue, 17 Dec 2024 11:26:20 +0100 (CET)
Date: Tue, 17 Dec 2024 11:26:20 +0100
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
Subject: Re: [PATCH v6 13/16] mm: introduce vma_ensure_detached()
Message-ID: <20241217102620.GC11133@noisy.programming.kicks-ass.net>
References: <20241216192419.2970941-1-surenb@google.com>
 <20241216192419.2970941-14-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216192419.2970941-14-surenb@google.com>

On Mon, Dec 16, 2024 at 11:24:16AM -0800, Suren Baghdasaryan wrote:
> vma_start_read() can temporarily raise vm_refcnt of a write-locked and
> detached vma:
> 
> // vm_refcnt==1 (attached)
> vma_start_write()
>     vma->vm_lock_seq = mm->mm_lock_seq
> 
>                     vma_start_read()
>                        vm_refcnt++; // vm_refcnt==2
> 
> vma_mark_detached()
>     vm_refcnt--; // vm_refcnt==1
> 
> // vma is detached but vm_refcnt!=0 temporarily
> 
>                        if (vma->vm_lock_seq == mm->mm_lock_seq)
>                            vma_refcount_put()
>                                vm_refcnt--; // vm_refcnt==0
> 
> This is currently not a problem when freeing the vma because RCU grace
> period should pass before kmem_cache_free(vma) gets called and by that
> time vma_start_read() should be done and vm_refcnt is 0. However once
> we introduce possibility of vma reuse before RCU grace period is over,
> this will become a problem (reused vma might be in non-detached state).
> Introduce vma_ensure_detached() for the writer to wait for readers until
> they exit vma_start_read().

So aside from the lockdep problem (which I think is fixable), the normal
way to fix the above is to make dec_and_test() do the kmem_cache_free().

Then the last user does the free and everything just works.

