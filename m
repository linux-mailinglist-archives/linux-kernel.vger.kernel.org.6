Return-Path: <linux-kernel+bounces-448110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5059F3B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B41188065B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779501DF992;
	Mon, 16 Dec 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/weIBr3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233501D63C5;
	Mon, 16 Dec 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381771; cv=none; b=rvoyQvk2fjEJ6t5R0VmAkZ2Kkpt54lbEfRDCrlYYrzOlT0j7/xGdOIN30hH7eNxROX89HNED1DeK5yLdhGNpKDtNmYVqJqqGDlbKkWDsGf0AcXwzN88cT9JwEWYzzRi/S+oThqjfJol5zsnEwlLym/sywtMaJFv/iKxOuAxVXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381771; c=relaxed/simple;
	bh=Wsa0lsfUskZ+wFIP8wYuEeWySF76wctRdDLLa/6PduQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVRscJLTGmqFpAC0wDCmKN7Xq2WIKCnRnAxA/DqJY5cY6fz5GqH4frg1/J0SC3X9dn2oaFkUDheSGXuI8fzej3R6+oifdWyIj35vDrgT6oxLOM0LrObge7Qtd97UkXzq1hNRJErLx7uZsjL8GooYJ7IylOp434xlxx6OGqoXTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s/weIBr3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XwXXoIySC4SYlAQ92EhSQlV963XBica42YF53fB4Nfc=; b=s/weIBr3ZUWFhT1dOuOQrfM697
	EJRBQUsxO1C7C2jT8I47s1sgmmUkhiTjVx7KNRbQAFaAfQj3veI6XexdshyhN3yWkWeGXkhE7ayHt
	f21vxQqSbrR7oAXleQaXIIyjLJEOz9AwvaJZaoXaxUyAGeOw9Yo9aZlP+RKdUAzhhFerVaY97f+wr
	VfwtdrxtvqsjD7l9Ojt1J2ntkeg8CWWuI2BbECQx5zh0v7Go8gt5bWinHJEsadpAxvf7ZFGxJrbmn
	amgAgdvHF73Ir1CyCGPK3Cjd3TlAcNtQms+TGN7N5pEDSF20KunDgCmxukaHCyxFxTaIFfL8vQB7J
	IWZYbvXA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNHv8-00000001vcF-2fiq;
	Mon, 16 Dec 2024 20:42:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D82830031E; Mon, 16 Dec 2024 21:42:24 +0100 (CET)
Date: Mon, 16 Dec 2024 21:42:23 +0100
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
Message-ID: <20241216204223.GA9803@noisy.programming.kicks-ass.net>
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
> @@ -734,10 +761,12 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	 * after it has been unlocked.
>  	 * This pairs with RELEASE semantics in vma_end_write_all().
>  	 */
> +	if (oldcnt & VMA_STATE_LOCKED ||
> +	    unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {

You likely want that unlikely to cover both conditions :-)

> +		vma_refcount_put(vma);
>  		return false;
>  	}
> +
>  	return true;
>  }

