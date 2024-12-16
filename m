Return-Path: <linux-kernel+bounces-448179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC63F9F3C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D341679FA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB211D31AE;
	Mon, 16 Dec 2024 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v7avsQ9R"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABE4437;
	Mon, 16 Dec 2024 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383813; cv=none; b=FfsdoyUcOjM/ZvglB3alkgUhsnqqlGh1PNFzO2jYkKQENCBxslZfVDsmQdQAwq+GtQ/Eo/iThqPlOqAXj4RMvFV5+wBfI9KG3MIntAOGLMwi5mxJ+hAKhXjdzxrwhdauB1k1ivmFbeo5PdI8VQeLx/2Huyw/UYxcdQ+m+BQDdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383813; c=relaxed/simple;
	bh=VkckERAarWFZIlrxbb81jRuss4GYws/T2h4m3iqPGa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqInOBto11iD92ezEE3v3Ar6CEactA/OSATTb+7hmem/4EU8czajybGLFeL3LS7tDoitsSzXLdrROJIxqjP94S2x6UGXBXB1exygoQ/fO4u+nd98rH9xE/iSHS5CzeCKF69nMcR0zS0zKJOPRaiqJrTyvI87jcV4PaBLJBQjLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v7avsQ9R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Trtl7E7Jonwq4B7a1CmBNlcuzf6xGG9ZkVRpNIjtrHc=; b=v7avsQ9RbthF/C6lTp4GcaHWLz
	zRLa7pQm4Pr2nGofLk3ai9vj1k9dd5gFTzHUMla7ujS3fOcqfKG/Mect60jPGAcCGMWXGQ6TJ1zox
	IrMbCXregR0n7M79ITg4E+cvP6QQp0X62i+A8+PtANDTIqyo77y4Vp85LP3jPrLXklXSZkuABDXGY
	tv9GQE6AeX2/qlr/W7nTyVmYHjWHQAD9qG6uuhrdxx44EQAT4xkXM0jxbjOKfeDgQC1YItZ0QIuSu
	fbrzZiFEluM8qjZZ1sNHLCpya29xIKlndw5Bs80e3kNhe36r6AwDRS2DLC4X72+VZ19FDMSORK5iO
	M5LqkDxA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNISC-00000002AGL-2Vbh;
	Mon, 16 Dec 2024 21:16:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CFA4C30031E; Mon, 16 Dec 2024 22:16:35 +0100 (CET)
Date: Mon, 16 Dec 2024 22:16:35 +0100
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
Subject: Re: [PATCH v6 11/16] mm: enforce vma to be in detached state before
 freeing
Message-ID: <20241216211635.GC9803@noisy.programming.kicks-ass.net>
References: <20241216192419.2970941-1-surenb@google.com>
 <20241216192419.2970941-12-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216192419.2970941-12-surenb@google.com>

On Mon, Dec 16, 2024 at 11:24:14AM -0800, Suren Baghdasaryan wrote:
> exit_mmap() frees vmas without detaching them. This will become a problem
> when we introduce vma reuse. Ensure that vmas are always detached before
> being freed.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  kernel/fork.c |  4 ++++
>  mm/vma.c      | 10 ++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 283909d082cb..f1ddfc7b3b48 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -473,6 +473,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  
>  void __vm_area_free(struct vm_area_struct *vma)
>  {
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* The vma should be detached while being destroyed. */
> +	VM_BUG_ON_VMA(!is_vma_detached(vma), vma);
> +#endif
>  	vma_numab_state_free(vma);
>  	free_anon_vma_name(vma);
>  	kmem_cache_free(vm_area_cachep, vma);
> diff --git a/mm/vma.c b/mm/vma.c
> index fbd7254517d6..0436a7d21e01 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -413,9 +413,15 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
>  	mpol_put(vma_policy(vma));
> -	if (unreachable)
> +	if (unreachable) {
> +#ifdef CONFIG_PER_VMA_LOCK
> +		if (!is_vma_detached(vma)) {
> +			vma_start_write(vma);
> +			vma_mark_detached(vma);
> +		}
> +#endif
>  		__vm_area_free(vma);

Again, can't you race with lockess RCU lookups?

