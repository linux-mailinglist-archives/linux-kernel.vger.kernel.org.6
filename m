Return-Path: <linux-kernel+bounces-388639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AFF9B6268
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B6F1C20C95
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCCC1E7C22;
	Wed, 30 Oct 2024 12:00:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89051E7C11
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289620; cv=none; b=Nu5UEq2Hn6L7eENGiKp1XHrJAJoWurEU/DUuJSbiPSvl98wfsMRlLOpMpkBT+aZlfr6ms6203hrivatRjqs4PKfPy9omCX2p8rid0JRFkBSP9F8mfa5YuOwP4lNhd2mGsmUNCjMn67JXB6ozj75Vq/p0GsQCHCz0gKOPsHFi4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289620; c=relaxed/simple;
	bh=aOVRAC8R1qXRCSp/+qZGxavDrOBiH8hXf0EABOYA3lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iheQGXmr4m56eaITBFhsMrtEowPIKxKYpe7usqSLxGKQpon7YYDjVIeeqrrUo2fnYnZm7OYYKPyzaEfA+wsidVMrWaflV4LiyiYpG8g+Hn7KhfSOC/wSMr97ibzpiUYmKFf7Dtx3iI2tD1UG0I57SpafpbYs/JPWxQfmMC+gmZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3683C4CEE3;
	Wed, 30 Oct 2024 12:00:14 +0000 (UTC)
Date: Wed, 30 Oct 2024 12:00:12 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
Message-ID: <ZyIfzELjiqrDMhk_@arm.com>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
X-TUID: 0+WlLMvWRpmU

On Tue, Oct 29, 2024 at 06:11:47PM +0000, Lorenzo Stoakes wrote:
> Currently MTE is permitted in two circumstances (desiring to use MTE having
> been specified by the VM_MTE flag) - where MAP_ANONYMOUS is specified, as
> checked by arch_calc_vm_flag_bits() and actualised by setting the
> VM_MTE_ALLOWED flag, or if the file backing the mapping is shmem, in which
> case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap hook is activated
> in mmap_region().
> 
> The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also set
> is the arm64 implementation of arch_validate_flags().
> 
> Unfortunately, we intend to refactor mmap_region() to perform this check
> earlier, meaning that in the case of a shmem backing we will not have
> invoked shmem_mmap() yet, causing the mapping to fail spuriously.
> 
> It is inappropriate to set this architecture-specific flag in general mm
> code anyway, so a sensible resolution of this issue is to instead move the
> check somewhere else.
> 
> We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
> the arch_calc_vm_flag_bits() call.
> 
> This is an appropriate place to do this as we already check for the
> MAP_ANONYMOUS case here, and the shmem file case is simply a variant of the
> same idea - we permit RAM-backed memory.
> 
> This requires a modification to the arch_calc_vm_flag_bits() signature to
> pass in a pointer to the struct file associated with the mapping, however
> this is not too egregious as this is only used by two architectures anyway
> - arm64 and parisc.
> 
> So this patch performs this adjustment and removes the unnecessary
> assignment of VM_MTE_ALLOWED in shmem_mmap().
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks for respinning this. FTR,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

> @@ -151,13 +152,13 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
>   * Combine the mmap "flags" argument into "vm_flags" used internally.
>   */
>  static inline unsigned long
> -calc_vm_flag_bits(unsigned long flags)
> +calc_vm_flag_bits(struct file *file, unsigned long flags)
>  {
>  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
>  	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
> -	       arch_calc_vm_flag_bits(flags);
> +		arch_calc_vm_flag_bits(file, flags);

Nitpick (but please ignore, Andrew picked them up already): one space
alignment off.

-- 
Catalin

