Return-Path: <linux-kernel+bounces-306925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B667964590
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9C1B22890
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0223194C86;
	Thu, 29 Aug 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGBVjYcx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325A1B0104
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936015; cv=none; b=iEHZdQ1D3C1c/4wuL+e4CN0PCpbk1i+ATJjADhxartG/WK7eCdWSCV63j0auLg9DePyJhEQ4uqWP2pucBgYapCbNsNqdoT5oysP4sY80Ggz6s5+d5BSqffS0eKTvgmEeP3a8d8xyADMag9nnu6eKDYJ4ureaGuRsyfgeBf6uhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936015; c=relaxed/simple;
	bh=qrqmV6CyoUDLVfC3UlKtWXvGRaqXV5KVfgaCVVUhLK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnSbOjTNIhG7T1/V1GPiqd1g9izwGLoQlJ0Ji47K9FU0vZX8aVSSmjfvioVR9O2ha4Q4zcET1mH2yWCRXyBXJIqAizAPz/E13vHT7RMM7T1CDJTqdjakUXOpb/IdtxoH3tXofr4QL/G0qLYNOj9Aov4ggRSkCth3arb1vTNbNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGBVjYcx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724936014; x=1756472014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qrqmV6CyoUDLVfC3UlKtWXvGRaqXV5KVfgaCVVUhLK4=;
  b=EGBVjYcxPRbi6a/hq76w2soFZtGNnMBdtCIUQ9Da1TaVRXRZD2MukiuD
   4mZC/UuD06ydIpz+4ZPgnKWWSESy1rOJ80gEZZAHSSCPbD4K8CckJ4Wk5
   56m7g9buKK6r6AlQLzs48ZjRJP37vo6NPimnyO6PnIYaxzAUzfSs5eMQb
   ThfAx7u2IokXG0ji2vcuqzsLnMA3TxxwZbsuDYZaRFgfITO4Q+2BE4XbB
   W52v1YrA9JvhvQXSudHIfDCRxS85Gyq2F74Xa6fOGjm0cwgFD6zVcxM15
   /EwoyQmbHXCNW/POAzFt3b41P7KVqxgWLj1RRGJni3lyK8vmKrgf6rf46
   w==;
X-CSE-ConnectionGUID: MgbkAezmSE6D41k5+PTX3w==
X-CSE-MsgGUID: VtmFsVrORRCVHqcDz/COrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27398216"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="27398216"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:53:33 -0700
X-CSE-ConnectionGUID: hLLW62PQS2+oCWGQlqTo9A==
X-CSE-MsgGUID: N3xPQi9bQe+xGN2C2XLBiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="94298336"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 29 Aug 2024 05:53:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4C616170; Thu, 29 Aug 2024 15:53:29 +0300 (EEST)
Date: Thu, 29 Aug 2024 15:53:29 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec with CONFIG_EISA
Message-ID: <gnxxp3bzk7cc5eidwvqvqb5hz2ojgjdadujpthweufxms2gjsc@ibcbkjst3pzf>
References: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.2408240952080.30766@angie.orcam.me.uk>
 <g3tswlyhrnuzfqf2upq6h23manyrzhnxttnay66nycy2moi4es@5n4oblzpzcjc>
 <c2ef105b-c42c-e0f4-6bf3-761dafc8e92e@amd.com>
 <02949473-328f-4dae-b778-d939dc9bba6c@amd.com>
 <npjx2z3adipvsxngnsoj6hsgk7rxta6ojdomm4tcd42maakuuz@rij273zia5ek>
 <e13df309-457a-41fa-9406-22476f9f4e72@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13df309-457a-41fa-9406-22476f9f4e72@amd.com>

On Wed, Aug 28, 2024 at 02:43:23PM -0500, Kalra, Ashish wrote:
> Hello Kirill,
> 
> On 8/28/2024 1:21 AM, Kirill A. Shutemov wrote:
> > On Tue, Aug 27, 2024 at 05:15:56PM -0500, Kalra, Ashish wrote:
> >> Hello Kirill,
> >>
> >> On 8/26/2024 10:52 AM, Tom Lendacky wrote:
> >>> On 8/26/24 07:25, Kirill A. Shutemov wrote:
> >>>> On Sat, Aug 24, 2024 at 11:29:39PM +0100, Maciej W. Rozycki wrote:
> >>>>> On Thu, 22 Aug 2024, Kirill A. Shutemov wrote:
> >>>>>
> >>>>>> This issue causes real problems:
> >>>>>>
> >>>>>> 1. If the kernel is compiled with EISA support, it will attempt to probe
> >>>>>>    EISA by reading 4 bytes from the 0x0FFFD9 address (see eisa_bus_probe()).
> >>>>>>    The kernel treats this read as MMIO and accesses this memory via
> >>>>>>    shared mapping as we do for MMIO.
> >>>>>>
> >>>>>>    KVM converts memory to shared upon such access.
> >>>>>>
> >>>>>> 2. The same memory range (0xF0000-0x100000) is scanned to look for the MP
> >>>>>>    table (see mpparse_find_mptable()). However, this is not MMIO and it
> >>>>>>    is accessed via private mapping.
> >>>>>>
> >>>>>>    This will cause a crash if the memory is not private.
> >>>>>>
> >>>>>> During normal boot, the kernel scans for SMP information before probing
> >>>>>> for EISA, and it boots fine. However, the memory becomes shared and causes
> >>>>>> issues on kexec when the second kernel attempts to scan for SMP information.
> >>>>>  ISTM that `eisa_bus_probe' has to be updated to `memremap' analogously to 
> >>>>> `mpparse_find_mptable', complementing changes such as commit f7750a795687 
> >>>>> ("x86, mpparse, x86/acpi, x86/PCI, x86/dmi, SFI: Use memremap() for RAM 
> >>>>> mappings") or commit 5997efb96756 ("x86/boot: Use memremap() to map the 
> >>>>> MPF and MPC data").  Both just access BIOS memory.
> >>>>>
> >>>>>  Can you please try and verify if my proposed change at: 
> >>>>> <https://lore.kernel.org/r/alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk> 
> >>>>> has fixed the problem for you?
> >>>> I like the direction your patch took. I hate sprinkling
> >>>> X86_FEATURE_TDX_GUEST checks over the kernel.
> >>>>
> >>>> Unfortunately, it is not enough to fix the issue. memremap() in this case
> >>>> will still boil down to ioremap() that would set shared bit:
> >>>>
> >>>> memremap()
> >>>>   arch_memremap_wb()
> >>>>     ioremap_cache()
> >>>>       __ioremap_caller(.encrytped = false)
> >>>>
> >>>> I think arch_memremap_wb() should be mapped ioremap_encrypted() in x86
> >>>> case. See the patch below.
> >>>>
> >>>> It seems to be working fine on TDX, but I am not sure about SEV.
> >>>>
> >>>> Tom, any comments?
> >>> I haven't dug through the code that thoroughly, but I don't think making
> >>> arch_memremap_wb() be ioremap_encrypted() will work for SME, where some
> >>> data, e.g. setup data, is unencrypted and needs to be mapped shared.
> >>>
> >>> Let me add @Ashish to the thread and have him investigate this since he
> >>> has been working on the kexec support under SNP. Can someone provide the
> >>> specific kernel options that need to be in place?
> >> As Tom asked for, please provide the specific kernel options to test
> >> with this configuration.
> > It is not about testing a specific configuration. The question is if it
> > safe for memremap() to map all WB memory as encrypted by default.
> >
> > Looks like it is safe for TDX, but I am not sure about SME/SEV.
> 
> For SEV it may make sense, but for SME we don't want memremap() to map
> all WB memory as encrypted by default.

Could you elaborate why?

I mean if it is specific memory ranges that can be identified as such we
could make exception for them.

> >
> > Maybe we want a specific flag to make memremap() map WB memory as
> > decrypted/shared. Make everything encrypted by default seems like a sane
> > default.
> 
> What are MEMREMAP_ENC, MEMREMAP_DEC flags being used for currently ?

Good question.

I see zero use of MEMREMAP_ENC in the kernel. And MEMREMAP_DEC only used
for setup data which I believe AMD thing.

If it is the only memory that must be decrypted, I guess we can make it
work with encrypted by default.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

