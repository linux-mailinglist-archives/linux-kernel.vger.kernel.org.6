Return-Path: <linux-kernel+bounces-199236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B628D8438
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD928739D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848F912FF87;
	Mon,  3 Jun 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESftPgcR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F612DD8A;
	Mon,  3 Jun 2024 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422070; cv=none; b=bna4rhpjOY0Xxmaie7c0hRz0arZySf36MDU6qzBeWmXw5Cxd0ZeFbKNaVSjHuxL/TQotRf7W+ss3mPiOvX16Dzy6sBAeYd3dtDfTu1l7hXm0PFnrx1U15pk2WTmOCriskGVaWogvdocC0O1y2SSKWBqfAEYThZJb/fJTzfML0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422070; c=relaxed/simple;
	bh=Ha1Vb6zLDIgl3FT1iTLBIO/NlIPS2ToAgX6Msao0hhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPTw9LZEEqY6LSq+6mtfwi63i9NdVNpdC+WkyNGX/zi81XvURL16KnwU0T3Lw1FflLWC4Pu/CHTjFVmykqlywkNUVJNj8XhrmNbb1ov5519TJB09Y7wdVd57BgjyrE4VsTjoSLmLrNzYSJOfzSDLb6wl1zqSHji+yxDnKNGEtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESftPgcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E95C32781;
	Mon,  3 Jun 2024 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422069;
	bh=Ha1Vb6zLDIgl3FT1iTLBIO/NlIPS2ToAgX6Msao0hhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESftPgcRwAW263OfIBCOhYLZOuMreNuvfXqqXkvt6Cmf7vzo5PeOYZ6DoRRNP3JZ/
	 lyssP0SZncpQ3xya77ugCf4jlN8PPSxFKMqvywN23AcgXS4MgFIt3AFzpnqHG4mj1C
	 qfrjFZKJql+XdFwMAueRJ+8ZVDQa7J+DnJOZ6tD1EH+tLJyZ7R38rmczDS421jq+c/
	 PWNGF2/EOyVowAxI+Y9wWYMJkq7H0TD+iI17mH1o9U/MOfm2TP6nvmVx6wUKyY2wBp
	 WlwNjnjt9JamFdbyy2R0Vk4kEIQnx47+nuTqhjSjYBgTkYWPrN2VD6hbTNUPEJW2Uj
	 jqsetzuLS3xPQ==
Date: Mon, 3 Jun 2024 16:39:10 +0300
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
Message-ID: <Zl3HfiQ6oHdTdOdA@kernel.org>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>

On Mon, Jun 03, 2024 at 08:06:56AM -0500, Kalra, Ashish wrote:
> On 6/3/2024 3:56 AM, Borislav Petkov wrote
> 
> > > EFI memory map and due to early allocation it uses memblock allocation.
> > > 
> > > Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> > > in case of a kexec-ed kernel boot.
> > > 
> > > This function kexec_enter_virtual_mode() installs the new EFI memory map by
> > > calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
> > > in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
> > > 
> > > Subsequently, when memblock is freed later in boot flow, this remapped
> > > efi_memmap will have random corruption (similar to a use-after-free scenario).
> > > 
> > > The corrupted EFI memory map is then passed to the next kexec-ed kernel
> > > which causes a panic when trying to use the corrupted EFI memory map.
> > This sounds fishy: memblock allocated memory is not freed later in the
> > boot - it remains reserved. Only free memory is freed from memblock to
> > the buddy allocator.
> > 
> > Or is the problem that memblock-allocated memory cannot be memremapped
> > because *raisins*?
> 
> This is what seems to be happening:
> 
> efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
> EFI memory map and due to early allocation it uses memblock allocation.
> 
> And later efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> in case of a kexec-ed kernel boot.
> 
> This function kexec_enter_virtual_mode() installs the new EFI memory map by
> calling efi_memmap_init_late() which does memremap() on memblock-allocated memory.

Does the issue happen only with SNP?

I didn't really dig, but my theory would be that it has something to do
with arch_memremap_can_ram_remap() in arch/x86/mm/ioremap.c
 
> Thanks, Ashish

-- 
Sincerely yours,
Mike.

