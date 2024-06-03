Return-Path: <linux-kernel+bounces-199366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE2E8D8610
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F60282007
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009E130A46;
	Mon,  3 Jun 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHlX5b47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37A126F1F;
	Mon,  3 Jun 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428662; cv=none; b=r027nUcWBGcrIngpGDAViAhhBso13SiBWFgMe2JjsoPf5PTh6yidyuYkajjwsftEUuQkDkKveR45MARNyGSadC//C7+XeM0ssnwm8ZwJjodnnzsPXSaxPBMK4Vq8fvyHUOsbwS+jddEC/TcYOKPwQ7Qxfdx7JB0WfE+LmbS+svE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428662; c=relaxed/simple;
	bh=odR2yE0PrRaovS85NwYBENVHPZalKhxFjP3osPFtmGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPEhuZtmf5qH8xN3dpYKnzFc4nX5G/7o6022T5x1ewAgFEv3aO9t4y2UbUJDxWLoPVK5s/nSf6WmPbUiAD1DydI7StVR910ZySWnEt21wsJ/kIxRLbloqTmSllfEJhTgKbsXhHb3T36LJlbeUJ+aeXtyShYtpBQ762OjOcoY1qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHlX5b47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CFBC2BD10;
	Mon,  3 Jun 2024 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717428662;
	bh=odR2yE0PrRaovS85NwYBENVHPZalKhxFjP3osPFtmGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHlX5b47nBaH+NbFGZWsM5ISVowFzvmzrSp6y4oP/rXvG5yYP6L8HH2LG6uKupMz5
	 tXCTbOgWYebcYp+bv2SlxdC1QnUrmnM15cvJaB5TrIyeEeQa2b7jHgACz39soaomFg
	 czTkykzix1LIgAv4l04GRBPZZF/bISMNW6FumlIKXv4+q3MWD0/Aa16hh5Qq1QTrlc
	 GLd2HPiz+KJJTTvCq+LHa2KNUPmLzVuc1WNSDZwtcYPeRaWQIwHnNEeWy8vcIGMGwa
	 tggzcPBCL+1/NVikvspB//QMd31Jcf7dvIpxmL+QStiyrMo4rpj2BxxCUq8/bVf4C9
	 uvJRpjW0kmoDw==
Date: Mon, 3 Jun 2024 18:29:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
	hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <Zl3hPefvOwPv0Mjn@kernel.org>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>

On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
> On 6/3/2024 8:39 AM, Mike Rapoport wrote:
> 
> > On Mon, Jun 03, 2024 at 08:06:56AM -0500, Kalra, Ashish wrote:
> > > On 6/3/2024 3:56 AM, Borislav Petkov wrote
> > > 
> > > > > EFI memory map and due to early allocation it uses memblock allocation.
> > > > > 
> > > > > Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> > > > > in case of a kexec-ed kernel boot.
> > > > > 
> > > > > This function kexec_enter_virtual_mode() installs the new EFI memory map by
> > > > > calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
> > > > > in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
> > > > > 
> > > > > Subsequently, when memblock is freed later in boot flow, this remapped
> > > > > efi_memmap will have random corruption (similar to a use-after-free scenario).
> > > > > 
> > > > > The corrupted EFI memory map is then passed to the next kexec-ed kernel
> > > > > which causes a panic when trying to use the corrupted EFI memory map.
> > > > This sounds fishy: memblock allocated memory is not freed later in the
> > > > boot - it remains reserved. Only free memory is freed from memblock to
> > > > the buddy allocator.
> > > > 
> > > > Or is the problem that memblock-allocated memory cannot be memremapped
> > > > because *raisins*?
> > > This is what seems to be happening:
> > > 
> > > efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
> > > EFI memory map and due to early allocation it uses memblock allocation.
> > > 
> > > And later efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> > > in case of a kexec-ed kernel boot.
> > > 
> > > This function kexec_enter_virtual_mode() installs the new EFI memory map by
> > > calling efi_memmap_init_late() which does memremap() on memblock-allocated memory.
> > Does the issue happen only with SNP?
> 
> This is observed under SNP as efi_arch_mem_reserve() is only being called
> with SNP enabled and then efi_arch_mem_reserve() allocates EFI memory map
> using memblock.

I don't see how efi_arch_mem_reserve() is only called with SNP. What did I
miss?
 
> If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
> for kexec case), then for kexec boot, EFI memmap is memremapped in the same
> virtual address as the first kernel and not the allocated memblock address.

Maybe we should skip efi_arch_mem_reserve() for kexec case, but I think we
still need to understand what's causing memory corruption.

> Thanks, Ashish
> 
> > 
> > I didn't really dig, but my theory would be that it has something to do
> > with arch_memremap_can_ram_remap() in arch/x86/mm/ioremap.c
> > > Thanks, Ashish

-- 
Sincerely yours,
Mike.

