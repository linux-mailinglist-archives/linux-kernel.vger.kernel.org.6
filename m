Return-Path: <linux-kernel+bounces-545641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3FA4EF85
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC46188FBBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2A1FC10E;
	Tue,  4 Mar 2025 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EkAsh/L4"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350F1B414F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124737; cv=none; b=ZdFEoSRHFeyb3ppAUXBx4pm00R4QB/k9fQc1rZD0DmOAiJ9XcR46NKvXafUa7iqhGMFST4UcJuxpjsGuJC3+PMpx10TyCY0/DQUsw2X2xUEjNodbSRuI2PlqlKlDoYUt7FY+dVncyRHMo0WMPxnrJqY3CW/frQH6FaBZCk34+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124737; c=relaxed/simple;
	bh=ObACXnh8z88m19Qq0lGjoOpxh4g/zt2+qYSG5pH6cyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFW5TYjk8ea7Np9uMVFpmLHracB/ybJ+1Xrrz3c0fiMYrz8ckwqIHxnR28OIdoa6SSfgxvzZTToREvzmKEhH5FHrIvh4FiyCDjexhohQagolsGVOv6ao6zUGTpAmjdfzTohBGVK5vMdr0NNWCrmc5YvR5RTDIE5v1l+uOSs4sUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EkAsh/L4; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 4 Mar 2025 21:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741124732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qs/wzcpT9hBhaXD05toVZbE5lL3id+EHNVqnHRGisc4=;
	b=EkAsh/L45UrrJYiJTuPWsbyfA0iB5HPWPr3bLIIBzT9eUfEbbSluIOboqQ0/UkKYY70PZb
	RWBTwRxGTqbmhrrdx7KN0zdylzPd+RPxbB85TBXAWd72ufxV+6GOh0jsTn9rSCSU1EfMzI
	wXvl7/v28o3P9hooxKTBNWX9TCCE4RI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mm/mremap: initial refactor of move_vma()
Message-ID: <Z8d0d9N26JBGwi8N@google.com>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <b4e64684d6ac753d5a66c0da0da5f4b94d033859.1740911247.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e64684d6ac753d5a66c0da0da5f4b94d033859.1740911247.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 03, 2025 at 11:08:34AM +0000, Lorenzo Stoakes wrote:
> Update move_vma() to use the threaded VRM object, de-duplicate code and
> separate into smaller functions to aid readability and debug-ability.
> 
> This in turn allows further simplification of expand_vma() as we can simply
> thread VRM through the function.
> 
> We also take the opportunity to abstract the account charging page count
> into the VRM in order that we can correctly thread this through the
> operation.
> 
> We additionally do the same for tracking mm statistics - exec_vm, stack_vm,
> data_vm, and locked_vm.
> 
> As part of this change, we slightly modify when locked pages statistics are
> counted for in mm_struct statistics. However this should cause no issues,
> as there is no chance of underflow, nor will any rlimit failures occur as a
> result.
> 
> This is an intermediate step before a further refactoring of move_vma() in
> order to aid review.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
[..]
> +/*
> + * Perform checks  before attempting to write a VMA prior to it being
> + * moved.
> + */
> +static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
> +				   unsigned long *vm_flags_ptr)
> +{
> +	unsigned long err;

I am getting a warning on mm-unstable because 'err' is sometimes used
uninitialized, I think here:

        if (vma->vm_ops && vma->vm_ops->may_split) {
                if (vma->vm_start != old_addr)
                        err = vma->vm_ops->may_split(vma, old_addr);
                if (!err && vma->vm_end != old_addr + old_len)
                        err = vma->vm_ops->may_split(vma, old_addr + old_len);
                if (err)
                        return err;
        }

> +	struct vm_area_struct *vma = vrm->vma;
> +	unsigned long old_addr = vrm->addr;
> +	unsigned long old_len = vrm->old_len;
>  
>  	/*
>  	 * We'd prefer to avoid failure later on in do_munmap:
>  	 * which may split one vma into three before unmapping.
>  	 */
> -	if (mm->map_count >= sysctl_max_map_count - 3)
> +	if (current->mm->map_count >= sysctl_max_map_count - 3)
>  		return -ENOMEM;
>  
> -	if (unlikely(flags & MREMAP_DONTUNMAP))
> -		to_account = new_len;
> -
>  	if (vma->vm_ops && vma->vm_ops->may_split) {
>  		if (vma->vm_start != old_addr)
>  			err = vma->vm_ops->may_split(vma, old_addr);
[..]

