Return-Path: <linux-kernel+bounces-417319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C649D5271
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DA5283D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F6A1BBBC1;
	Thu, 21 Nov 2024 18:22:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110A15ADB4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213342; cv=none; b=TgOFGJjpQsasFlnFZYqpyw2qGbgQzxzSp6Ly1dFUhhYUVzDeI0sI4KBu4nkMwzgC3GURLhE/gejbt5TfB8xUaGB1X5CtaFB43wyLjf8P9lBRaWz74rYZcmHiRVyP2U9O2GvlFPMo6hnYvpJL6O8hG7sIDiuNDm/a3pZSaw5gNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213342; c=relaxed/simple;
	bh=1No8SHUmAfFuttYIbYYUsZGvP/azcRLeVJ8jMxx/h+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ/V6oeQIZoO7e7qZmd5CXGFbp0QZ2tDh+ffYg0jNP4Pb6kPrP+fXLOaU9QLn5h3UJ98ByOdSWNkfKVyIdDzOqDeOD4oJmT8517LvBBQOpAD6OWorJ4YSpdwOSLs8b6VnhLSNBGRgMxW93t0lYeNSJ3Nf1PIfiBsNxKSZyJBihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9344C4CECC;
	Thu, 21 Nov 2024 18:22:20 +0000 (UTC)
Date: Thu, 21 Nov 2024 18:22:17 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6.13-rc1] arm64: mte: set VM_MTE_ALLOWED for hugetlbfs
 at correct place
Message-ID: <Zz96WefRxFL0FMRq@arm.com>
References: <20241119200914.1145249-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119200914.1145249-1-yang@os.amperecomputing.com>

On Tue, Nov 19, 2024 at 12:09:14PM -0800, Yang Shi wrote:
> The commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> behaviour") moved vm flags validation before fop->mmap for file
> mappings.  But when commit 25c17c4b55de ("hugetlb: arm64: add mte support")
> was rebased on top of it, the hugetlbfs part was missed.  Mmapping
> hugetlbfs file may not have MAP_HUGETLB set.
> 
> Fixes: 25c17c4b55de ("hugetlb: arm64: add mte support")
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

Since 5de195060b2e went into -rc7 and my arm64 tree was based on -rc1, I
did not test this combination. The patch looks fine, so:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

So I either merge it via the arm64 tree at -rc1 or Linus picks it up and
applies it directly during the merging window. Both options are fine,
it's not essential that MTE + hugetlbfs works at -rc1. Adding Linus and
Andrew in case they have any preference (and leaving the patch in place
below).

Thanks,

Catalin

> ---
>  arch/arm64/include/asm/mman.h | 3 ++-
>  fs/hugetlbfs/inode.c          | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 1d53022fc7e1..21df8bbd2668 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -7,6 +7,7 @@
>  #ifndef BUILD_VDSO
>  #include <linux/compiler.h>
>  #include <linux/fs.h>
> +#include <linux/hugetlb.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/types.h>
>  
> @@ -44,7 +45,7 @@ static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
>  	if (system_supports_mte()) {
>  		if (flags & (MAP_ANONYMOUS | MAP_HUGETLB))
>  			return VM_MTE_ALLOWED;
> -		if (shmem_file(file))
> +		if (shmem_file(file) || is_file_hugepages(file))
>  			return VM_MTE_ALLOWED;
>  	}
>  
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 1bbf783b244a..2dea122e5b93 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -113,7 +113,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	 * way when do_mmap unwinds (may be important on powerpc
>  	 * and ia64).
>  	 */
> -	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
> +	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
>  	vma->vm_ops = &hugetlb_vm_ops;
>  
>  	ret = seal_check_write(info->seals, vma);
> -- 

