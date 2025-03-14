Return-Path: <linux-kernel+bounces-560945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72606A60B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C003AA2FD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B8199920;
	Fri, 14 Mar 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="chq/MjDm"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A47FEAD7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940734; cv=none; b=o8pRlNBqE1SeA8W9xGZ2wF6AVW95wh2BXreW+pQoKB/soNR0T1nyFos7XlhX52B1F/Ff9rlpvEjeOlpuISOUfRyBNvNRICOPVfdYLYgqJ50rwr1jktbuMtERNnB2y7D0YQliir8jIRNMARsaLcEv/Nb+a46JZfFxvP6fF6mI3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940734; c=relaxed/simple;
	bh=y24J/kCYXbdEatcZBlA0Z55YnWy3JNX0aXHHLJDUa0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0R/Hz0T5sczp4a/8jSMmsBg3XUn1iYer0ZlnLq6K+Cziuue/73jAijcCeZ5OVnOFJwA6TIE7L0G6XiKvCeihBqTqGSTHLgSzMF29ZkwCRm6pMhm9cSNABBNJp0z5fAqTgQnYAndz2DgDBgF0i3G1QQRLJComcH3Tbz6uz3Xem4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=chq/MjDm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z7pgffBCJ64s8SUSy2F4lOeJncQvjpMHvfcMDHpHISU=; b=chq/MjDmPZbcwvng7KEQEyltYs
	0B/7QZ/AuEbZazc6aejMs4WhONAtLYkvgXCXuH5ALxsMlWtynUkdr2HaJB9aUrNeSUoYFPeIdbhlr
	uzkt+wPPkAw1rq5490pS1vaEkbUaciXRmH07/+pUUmrB29kNWL6j5289WSiZhOtMobAe3m7NRCL47
	/TE2fkspHx0ucgkwpu3frb0PkLvSEiy/7UzUP/093VjRlnJKsRBksFii7xWrxy1XkReF25xHYfyx7
	rkb75+XNocsjpXyjidaxpsddigYobR4rKD8a385m+9wZ21BfHvtG0tY+qr/KQ+PuZ6HqiTghpTqAo
	XzA3fcvg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt0MC-00000002rQb-1DsY;
	Fri, 14 Mar 2025 08:25:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFAFE300599; Fri, 14 Mar 2025 09:25:27 +0100 (CET)
Date: Fri, 14 Mar 2025 09:25:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
	fbarrat@linux.ibm.com, ajd@linux.ibm.com, mahesh@linux.ibm.com,
	oohall@gmail.com, hbathini@linux.ibm.com, dhowells@redhat.com,
	haren@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] powerpc: book3s: vas: use lock guard for mutex
Message-ID: <20250314082527.GU5880@noisy.programming.kicks-ass.net>
References: <20250314054544.1998928-1-sshegde@linux.ibm.com>
 <20250314054544.1998928-5-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314054544.1998928-5-sshegde@linux.ibm.com>

On Fri, Mar 14, 2025 at 11:15:42AM +0530, Shrikanth Hegde wrote:
> use guard(mutex) for scope based resource management of mutex.
> This would make the code simpler and easier to maintain.
> 
> More details on lock guards can be found at
> https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u
> 
> There is also an example of using scoped_guard. 
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/platforms/book3s/vas-api.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
> index 0b6365d85d11..eb1a97271afb 100644
> --- a/arch/powerpc/platforms/book3s/vas-api.c
> +++ b/arch/powerpc/platforms/book3s/vas-api.c
> @@ -425,7 +425,7 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
>  		return VM_FAULT_SIGBUS;
>  	}
>  
> -	mutex_lock(&txwin->task_ref.mmap_mutex);
> +	guard(mutex)(&txwin->task_ref.mmap_mutex);
>  	/*
>  	 * The window may be inactive due to lost credit (Ex: core
>  	 * removal with DLPAR). If the window is active again when
> @@ -437,11 +437,9 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
>  		if (paste_addr) {
>  			fault = vmf_insert_pfn(vma, vma->vm_start,
>  					(paste_addr >> PAGE_SHIFT));
> -			mutex_unlock(&txwin->task_ref.mmap_mutex);
>  			return fault;
>  		}
>  	}
> -	mutex_unlock(&txwin->task_ref.mmap_mutex);

I had to open up this file to check, but this seems incorrect since you
now also run do_fail_paste() with the lock held, where previously you
did not.


>  	/*
>  	 * Received this fault due to closing the actual window.

