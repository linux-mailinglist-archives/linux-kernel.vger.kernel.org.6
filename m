Return-Path: <linux-kernel+bounces-199370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4B8D861A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B041F22809
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277EF130E4A;
	Mon,  3 Jun 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V78vWfJn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C012FF73;
	Mon,  3 Jun 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428793; cv=none; b=IKMCw81AEydc1sWBryQp9ftJhZd/y16HfO7sxqsoBYZFGBfYNg/sbeyK6pfyA7RW3b5sbmzgDh07GTE2sY4y2IsP1T5F0DJKe6OAjgdRYiGC6GtKTIk/93V/m1jRPZCUkoRiY9F/0dAAvmsBa/v34DfHZLwI6RTebzEXMhICIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428793; c=relaxed/simple;
	bh=OgWlnRG7yqy7Yvp/hofY3k+TP4mvTMnfi5TRon+rND4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZcNkKWNoz1PAwA+QVf0ArVHbuPuEX+9WLgaxH4i54iSlKy8a+90QNnxs40CAsysis5Kp2wJ0uqx64bYFMWQ6smrudRdf9Mk51ZwDm2IMtd+aH9FbFPC+29483ECTGTsD8DtxkYlvY2DbCWqX/RopUUNajeU5NPQ/ixTSkIJUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V78vWfJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E44C2BD10;
	Mon,  3 Jun 2024 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717428793;
	bh=OgWlnRG7yqy7Yvp/hofY3k+TP4mvTMnfi5TRon+rND4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V78vWfJnvZewwuSibFDHSbCkT7UuQxhh7H/3SePSqXD1IHensUS8575I57nhRRGNm
	 uDOgM18EICY1RU5BGasMfeKdxeRj3rrm2PDIut5kb5N6LTjgQt4lmtZpEoxnd4D/NG
	 DFR4YbrHY4UahiNnkq8kYpIUnqE0jLjoUVsHEudhor2/ijmq3hhwTvR/6TzD+CSeXk
	 70VXT93b0/xJnbu9pKur+08cmupOp+QAg40GAQgg9mAJ18lSAUQwwZQ5MgypDm/HJX
	 A3mtO4WABeasmB7CgPZkv6Qg4s3KxOUWiaz18mYJUJb7SAL8aYxu1BywfFZ6bIqfaX
	 CkQFqvbp/2bJA==
Date: Mon, 3 Jun 2024 18:31:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <Zl3hwYL2GDiyUfGo@kernel.org>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>

On Mon, Jun 03, 2024 at 04:46:39PM +0200, Borislav Petkov wrote:
> On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
> > If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
> > for kexec case), then for kexec boot, EFI memmap is memremapped in the same
> > virtual address as the first kernel and not the allocated memblock address.
> 
> Are you saying that we should simply do
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index fdf07dd6f459..410cb0743289 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -577,6 +577,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
>  	if (WARN_ON_ONCE(efi_enabled(EFI_PARAVIRT)))
>  		return;
>  
> +	if (kexec_in_progress)
> +		return;
> +
>  	if (!memblock_is_region_reserved(addr, size))
>  		memblock_reserve(addr, size);
>  
> and skip that whole call?

I think Ashish suggested rather 

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fdf07dd6f459..eccc10ab15a4 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -580,6 +580,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
 	if (!memblock_is_region_reserved(addr, size))
 		memblock_reserve(addr, size);
 
+	if (kexec_in_progress)
+		return;
+
 	/*
 	 * Some architectures (x86) reserve all boot services ranges
 	 * until efi_free_boot_services() because of buggy firmware
 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Sincerely yours,
Mike.

