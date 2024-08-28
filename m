Return-Path: <linux-kernel+bounces-304403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895FB961F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D49286104
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83015624D;
	Wed, 28 Aug 2024 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6nhmtDh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1B1E526
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826118; cv=none; b=jC75mhwElPclAU+/TwiqlZ08wqyV9epMhTDUJM5otGgTy4IZy57UNjdSigjEt+oXX9GFFPj/FVUnHeTH4sW0d6dUmeIEX6DAMzYcZWYzGIETXzX5pWQdD2jMPwqycjyh0urLb3vaNr7DGWX3RaUqmOuisU2c4Y/R7NBjUg0ARk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826118; c=relaxed/simple;
	bh=t7rlMS499Sw4ZQR3poFmgp5X8RgFno6WnKSZOJG3tV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUtVgaAofCtwfj8bFq23SPyRrPcKEOArwXjUEtchFEczJoqj5VduxatCLD8DxRv5xwzJq++5/JIbnUBVnpsNzVnaQhK74Ek574x2LfBgQEpNt55C85qhI28BEscZHVFWV1/kzboe6y7AOvrvBrspgJXvFnzfVWrnBymY834Ui8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6nhmtDh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724826117; x=1756362117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t7rlMS499Sw4ZQR3poFmgp5X8RgFno6WnKSZOJG3tV0=;
  b=n6nhmtDh91r7uDZAKFfdKoZ3NpDdsuoqEAgOKNHk+/n+kBWAqm3xSIsK
   ykVORcKIixylwIzLnruJ85FroF1HPWuryvjGZJbg0CAwMtDjV5HZUb5zE
   BpjZbvVLakjiz3ZN81+x1myWlYXLtEc6f0z0A7kI6FFnAhmHbz4t9sG9T
   +xUjyBaI+058eWKilYtfYp8Kp1MOQlQe5HwIbQdcawccwwOUH0OSh63zY
   J1FuX6dPTuEzw2ALJYO5w6xfAeXDX7r1LZUrjJLasHpmEiWyZ74J0jiIx
   tFdwZXyQtjJMs0Td+WgzOTxfBocXTrLOWl9eJ3SCMCpbYprjeBjclrmom
   Q==;
X-CSE-ConnectionGUID: 6muRqxzFTVma1Bzj2/MI1Q==
X-CSE-MsgGUID: fvbDpYSMTWqfjTJZtA8fTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23516324"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23516324"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 23:21:56 -0700
X-CSE-ConnectionGUID: WEJmQ8I/Tr6L526Rtfb1hg==
X-CSE-MsgGUID: DJ3PXCE9TCCUIxeicb0lCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63821436"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 27 Aug 2024 23:21:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 02B4B142; Wed, 28 Aug 2024 09:21:51 +0300 (EEST)
Date: Wed, 28 Aug 2024 09:21:51 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec with CONFIG_EISA
Message-ID: <npjx2z3adipvsxngnsoj6hsgk7rxta6ojdomm4tcd42maakuuz@rij273zia5ek>
References: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.2408240952080.30766@angie.orcam.me.uk>
 <g3tswlyhrnuzfqf2upq6h23manyrzhnxttnay66nycy2moi4es@5n4oblzpzcjc>
 <c2ef105b-c42c-e0f4-6bf3-761dafc8e92e@amd.com>
 <02949473-328f-4dae-b778-d939dc9bba6c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02949473-328f-4dae-b778-d939dc9bba6c@amd.com>

On Tue, Aug 27, 2024 at 05:15:56PM -0500, Kalra, Ashish wrote:
> Hello Kirill,
> 
> On 8/26/2024 10:52 AM, Tom Lendacky wrote:
> > On 8/26/24 07:25, Kirill A. Shutemov wrote:
> >> On Sat, Aug 24, 2024 at 11:29:39PM +0100, Maciej W. Rozycki wrote:
> >>> On Thu, 22 Aug 2024, Kirill A. Shutemov wrote:
> >>>
> >>>> This issue causes real problems:
> >>>>
> >>>> 1. If the kernel is compiled with EISA support, it will attempt to probe
> >>>>    EISA by reading 4 bytes from the 0x0FFFD9 address (see eisa_bus_probe()).
> >>>>    The kernel treats this read as MMIO and accesses this memory via
> >>>>    shared mapping as we do for MMIO.
> >>>>
> >>>>    KVM converts memory to shared upon such access.
> >>>>
> >>>> 2. The same memory range (0xF0000-0x100000) is scanned to look for the MP
> >>>>    table (see mpparse_find_mptable()). However, this is not MMIO and it
> >>>>    is accessed via private mapping.
> >>>>
> >>>>    This will cause a crash if the memory is not private.
> >>>>
> >>>> During normal boot, the kernel scans for SMP information before probing
> >>>> for EISA, and it boots fine. However, the memory becomes shared and causes
> >>>> issues on kexec when the second kernel attempts to scan for SMP information.
> >>>  ISTM that `eisa_bus_probe' has to be updated to `memremap' analogously to 
> >>> `mpparse_find_mptable', complementing changes such as commit f7750a795687 
> >>> ("x86, mpparse, x86/acpi, x86/PCI, x86/dmi, SFI: Use memremap() for RAM 
> >>> mappings") or commit 5997efb96756 ("x86/boot: Use memremap() to map the 
> >>> MPF and MPC data").  Both just access BIOS memory.
> >>>
> >>>  Can you please try and verify if my proposed change at: 
> >>> <https://lore.kernel.org/r/alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk> 
> >>> has fixed the problem for you?
> >> I like the direction your patch took. I hate sprinkling
> >> X86_FEATURE_TDX_GUEST checks over the kernel.
> >>
> >> Unfortunately, it is not enough to fix the issue. memremap() in this case
> >> will still boil down to ioremap() that would set shared bit:
> >>
> >> memremap()
> >>   arch_memremap_wb()
> >>     ioremap_cache()
> >>       __ioremap_caller(.encrytped = false)
> >>
> >> I think arch_memremap_wb() should be mapped ioremap_encrypted() in x86
> >> case. See the patch below.
> >>
> >> It seems to be working fine on TDX, but I am not sure about SEV.
> >>
> >> Tom, any comments?
> > I haven't dug through the code that thoroughly, but I don't think making
> > arch_memremap_wb() be ioremap_encrypted() will work for SME, where some
> > data, e.g. setup data, is unencrypted and needs to be mapped shared.
> >
> > Let me add @Ashish to the thread and have him investigate this since he
> > has been working on the kexec support under SNP. Can someone provide the
> > specific kernel options that need to be in place?
> 
> As Tom asked for, please provide the specific kernel options to test
> with this configuration.

It is not about testing a specific configuration. The question is if it
safe for memremap() to map all WB memory as encrypted by default.

Looks like it is safe for TDX, but I am not sure about SME/SEV.

Maybe we want a specific flag to make memremap() map WB memory as
decrypted/shared. Make everything encrypted by default seems like a sane
default.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

