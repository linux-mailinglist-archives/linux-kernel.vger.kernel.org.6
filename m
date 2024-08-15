Return-Path: <linux-kernel+bounces-288257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F4E9537FC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F0282BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B661B151D;
	Thu, 15 Aug 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb1Fu4G9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE01714CF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738275; cv=none; b=RtGmU46SPgWl6HCdEQRVdO44fBVacw/V0F5GeuN3ZEjtO/gjrqIBDS/eTw2nuSxhLwp7URamB0FsJQmqk50IDonWFwWDWsoEfaEn8mHQVWNyld4/VOpIuUJE46LwkR07Cbrq7h6xWBF5q3efYJHgh3nokYaKdJkPnMoW6rH5A34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738275; c=relaxed/simple;
	bh=EwQBFH3Odji7F4BMgxRMe8whlfBJWuNj02UrxJV4gSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/D6O4/ULQcQa/1uwrpcIFK0STNhUvWTu2yX4ZBWLf2Z7LyuxTPHOFckx7CMlHqzm+aVWeCEzaKtm39kR86yYN3xeQCUsgrDl6ehJ6c/A9JrJIRjv+Lp49yA2OgtChsUd/TTS7kSZ6iKXG0HPgIZ/NL2xsEUJznNJ1t+ctb/U5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb1Fu4G9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EC0C32786;
	Thu, 15 Aug 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723738274;
	bh=EwQBFH3Odji7F4BMgxRMe8whlfBJWuNj02UrxJV4gSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kb1Fu4G9Vz/cLudLOAORH4ek54ZXjCIcTjJ3VZa51OlSwVs7zK7+Az6l2NZs9LXUa
	 L/5J3nVLJiS8p8Ok4mIDDqXAYMCQIV05klFSQJg8UW8MVgTQfKekWiMLoIEhleIbCm
	 oX1lNUCFS5CfNDdbQmTO1uq9GXl4um5tzJF1ucqGqouz6G6Q4iFIyUddfpPsPZ/s9D
	 gZn7cokWSAsZk511Iak+3PUUh/2rf3lpcaZcJTooYsZgWVz9jnoXjOOFytVggJNSzn
	 2Or8LNNLb7mRMevwoljGRK2mVj/qvxu4+kBvm6zl0yjgs8/k3uJQyWHvHwj93G3p1m
	 Z5vst+/FqO+8Q==
Date: Thu, 15 Aug 2024 09:11:14 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alistair Popple <apopple@nvidia.com>, x86@kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	max8rr8@gmail.com, linux-kernel@vger.kernel.org,
	jhubbard@nvidia.com, Andrew Morton <akpm@linuxfoundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org
Subject: Re: x86/kaslr: Expose and use the end of the physical memory address
 space
Message-ID: <202408150911.25D8591@keescook>
References: <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx>
 <87o75y428z.fsf@nvdebian.thelocal>
 <87ikw6rrau.ffs@tglx>
 <87frr9swmw.ffs@tglx>
 <87bk1x42vk.fsf@nvdebian.thelocal>
 <87sev8rfyx.ffs@tglx>
 <87le10p3ak.ffs@tglx>
 <87ed6soy3z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed6soy3z.ffs@tglx>

On Wed, Aug 14, 2024 at 12:29:36AM +0200, Thomas Gleixner wrote:
> iounmap() on x86 occasionally fails to unmap because the provided valid
> ioremap address is not below high_memory. It turned out that this
> happens due to KASLR.
> 
> KASLR uses the full address space between PAGE_OFFSET and vaddr_end to
> randomize the starting points of the direct map, vmalloc and vmemmap
> regions.  It thereby limits the size of the direct map by using the
> installed memory size plus an extra configurable margin for hot-plug
> memory.  This limitation is done to gain more randomization space
> because otherwise only the holes between the direct map, vmalloc,
> vmemmap and vaddr_end would be usable for randomizing.
> 
> The limited direct map size is not exposed to the rest of the kernel, so
> the memory hot-plug and resource management related code paths still
> operate under the assumption that the available address space can be
> determined with MAX_PHYSMEM_BITS.
> 
> request_free_mem_region() allocates from (1 << MAX_PHYSMEM_BITS) - 1
> downwards.  That means the first allocation happens past the end of the
> direct map and if unlucky this address is in the vmalloc space, which
> causes high_memory to become greater than VMALLOC_START and consequently
> causes iounmap() to fail for valid ioremap addresses.
> 
> MAX_PHYSMEM_BITS cannot be changed for that because the randomization
> does not align with address bit boundaries and there are other places
> which actually require to know the maximum number of address bits.  All
> remaining usage sites of MAX_PHYSMEM_BITS have been analyzed and found
> to be correct.
> 
> Cure this by exposing the end of the direct map via PHYSMEM_END and use
> that for the memory hot-plug and resource management related places
> instead of relying on MAX_PHYSMEM_BITS. In the KASLR case PHYSMEM_END
> maps to a variable which is initialized by the KASLR initialization and
> otherwise it is based on MAX_PHYSMEM_BITS as before.
> 
> To prevent future hickups add a check into add_pages() to catch callers
> trying to add memory above PHYSMEM_END.
> 
> Fixes: 0483e1fa6e09 ("x86/mm: Implement ASLR for kernel memory regions")
> Reported-by: Max Ramanouski <max8rr8@gmail.com>
> Reported-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Nice fix; thanks!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

