Return-Path: <linux-kernel+bounces-301462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E6195F147
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26F4281F84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC9816E886;
	Mon, 26 Aug 2024 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVJQjZbO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA313BACE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675156; cv=none; b=Z3BdIwqBhldf0+Guj+P/2WXKi5ms25Fb+vA+956BDiXNWq10deI18SQGxi7C5O1qEo8+sDhSMBP08hLq8rpYhgsfDSzwWPJfcO6Eo9C+yrMBj5PvuQA0kWVF4xEN5fStWua0p6RwQyfNsZb2qIn69gBIkYAMMPSDC7AdwO8phqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675156; c=relaxed/simple;
	bh=aAvmIIu9S4mH8LgNYWTeHskenOGHX/ZF7fp1wO/m7WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kexfxKVvpvpMaYqKTrhPsISnfR82FSQThWkE7pRZhXe208Jx5iUXQUQ074iLi8yMdCQPNAoSk++txr+pVqtvzy/l1nMLNc759Fn9NFX7GkgLkrhRIDNXMnaNybK/2tB+yYEisFo4GATS2Ha1yGecS6kcTW1cz6ITlkUkWlV3Xrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVJQjZbO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724675155; x=1756211155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aAvmIIu9S4mH8LgNYWTeHskenOGHX/ZF7fp1wO/m7WQ=;
  b=kVJQjZbOmp6PesHvjZkGaijIgnEHLDz7EQqSvYcVL1ax3TzgBBS7qlyE
   IAVP3PkjCA+XATlUR07FpVg5Qh/70RihkZK05VrNH4quokFDPKv0c6sIj
   Ct6J4x1/k0Sps/wh00ggah/7vorq2bDvwqHLV7BI+gGF3AlmACQ0tt6Wg
   cjmLUz2n2u5Rq/MMRgl4Xvw/vCPkSIWso/qe2+CuLvV+f1Y93Sa3zwv42
   473GBwKsGix/OERBZYdCoV7A7EoH84Q3nXtHB0aOmrJ3wpHgeie/YQlMR
   HpvykX798dRkKwc4Ri2Il0YEJHIvgSrHHLD9PShHyFjWo5eX1qsa8DsmK
   g==;
X-CSE-ConnectionGUID: rAPM1al0SjmX0FhB7q42VA==
X-CSE-MsgGUID: 8pzh3I/qSUeAuLvis85n/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23269997"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23269997"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 05:25:32 -0700
X-CSE-ConnectionGUID: veD0fV51Sty0TQqL9jfkAA==
X-CSE-MsgGUID: zva2FJewRkiUVMwdr7YxHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62471808"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 26 Aug 2024 05:25:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C53B2502; Mon, 26 Aug 2024 15:25:27 +0300 (EEST)
Date: Mon, 26 Aug 2024 15:25:27 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	linux-kernel@vger.kernel.org, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec with CONFIG_EISA
Message-ID: <g3tswlyhrnuzfqf2upq6h23manyrzhnxttnay66nycy2moi4es@5n4oblzpzcjc>
References: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.2408240952080.30766@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2408240952080.30766@angie.orcam.me.uk>

On Sat, Aug 24, 2024 at 11:29:39PM +0100, Maciej W. Rozycki wrote:
> On Thu, 22 Aug 2024, Kirill A. Shutemov wrote:
> 
> > This issue causes real problems:
> > 
> > 1. If the kernel is compiled with EISA support, it will attempt to probe
> >    EISA by reading 4 bytes from the 0x0FFFD9 address (see eisa_bus_probe()).
> >    The kernel treats this read as MMIO and accesses this memory via
> >    shared mapping as we do for MMIO.
> > 
> >    KVM converts memory to shared upon such access.
> > 
> > 2. The same memory range (0xF0000-0x100000) is scanned to look for the MP
> >    table (see mpparse_find_mptable()). However, this is not MMIO and it
> >    is accessed via private mapping.
> > 
> >    This will cause a crash if the memory is not private.
> > 
> > During normal boot, the kernel scans for SMP information before probing
> > for EISA, and it boots fine. However, the memory becomes shared and causes
> > issues on kexec when the second kernel attempts to scan for SMP information.
> 
>  ISTM that `eisa_bus_probe' has to be updated to `memremap' analogously to 
> `mpparse_find_mptable', complementing changes such as commit f7750a795687 
> ("x86, mpparse, x86/acpi, x86/PCI, x86/dmi, SFI: Use memremap() for RAM 
> mappings") or commit 5997efb96756 ("x86/boot: Use memremap() to map the 
> MPF and MPC data").  Both just access BIOS memory.
> 
>  Can you please try and verify if my proposed change at: 
> <https://lore.kernel.org/r/alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk> 
> has fixed the problem for you?

I like the direction your patch took. I hate sprinkling
X86_FEATURE_TDX_GUEST checks over the kernel.

Unfortunately, it is not enough to fix the issue. memremap() in this case
will still boil down to ioremap() that would set shared bit:

memremap()
  arch_memremap_wb()
    ioremap_cache()
      __ioremap_caller(.encrytped = false)

I think arch_memremap_wb() should be mapped ioremap_encrypted() in x86
case. See the patch below.

It seems to be working fine on TDX, but I am not sure about SEV.

Tom, any comments?

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 1d60427379c9..ef79cbef1ef8 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -180,6 +180,8 @@ extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, un
 extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
 #define ioremap_encrypted ioremap_encrypted
 
+#define arch_memremap_wb ioremap_encrypted
+
 /**
  * ioremap     -   map bus memory into CPU space
  * @offset:    bus address of the memory
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

