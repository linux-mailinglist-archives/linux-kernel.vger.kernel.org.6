Return-Path: <linux-kernel+bounces-439621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D009EB1DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C2918899FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB261A9B52;
	Tue, 10 Dec 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npblBpuh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96C1E52D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837211; cv=none; b=I3UJ72xH6mG4Y01AmqpWLMohm40ch2BzLoWT0dskF7xOzWlwMF6tvNfVH24+yX6D17Aohy1XFkYW9ScDviN5fBNVK93ZUFsXICWKhal9NLoP3fwPm5i0y4GIkcAx0RKLBr7DgPrqVWD9zFryuGuhD8Xa6zotar2HqFpKuBx2bQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837211; c=relaxed/simple;
	bh=o3FwI02N8aqXF4xZIrONk/VReti3pvSzpyqhoYtREr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjcbuYK/z4/AnQN6hwXzWd/OTkEI3k1oLLb8e0MfwcQfEs2+gnrLeIpc8z+eCEhfjkxD330lP0D4cwQhDIolhVAK6lYfZ44dBI/+33+x0A8hDNEaa3KnzdFwv8Qo9qkpoyq17YaD4Atdb7jCqVN3HLrY5t1ljM4eLyhzL0cURdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npblBpuh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733837210; x=1765373210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o3FwI02N8aqXF4xZIrONk/VReti3pvSzpyqhoYtREr8=;
  b=npblBpuhKnIR/7+uGvgqMsOGLMB+JtoTEX0g4+pbUlgabdLvmp2xhU4T
   dE9DSTTXv4S+iQhy/MqazhG8l7RxC6FrPPUWU0ldX+2WvSXHGxJBw+hSX
   Yw3TiTIedAk05VToYAIKmia85i3FZnpXQ9M5qyjdnPgwe0bPOjUbcms1R
   5kNOiN/Ci9lwwioNNTfu7wudGxunVvWT2XdCFxDEedhkbG4pnkfTo3TGc
   en1cADLg+UjodBSVUuCbuqK3pbxQ3DeQ05+gYgvd4u7wLMmzmHZeAW0nr
   haXWCJmBkg4BnwK7f+cH/HHGZFTAAOmTuB7LaaxKumpNsr7Eh+RNW9WSq
   g==;
X-CSE-ConnectionGUID: E7ZsjQ8kRsmomZ2VShy9bA==
X-CSE-MsgGUID: v0T5+kqVR8eZLTMhah+HTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37864852"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="37864852"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 05:26:49 -0800
X-CSE-ConnectionGUID: tUiZTf8LRc6BazYMUocLhA==
X-CSE-MsgGUID: MAqDFBXxQs2A/WQFrE0SGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95750103"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 10 Dec 2024 05:26:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0FF4D26B; Tue, 10 Dec 2024 15:26:40 +0200 (EET)
Date: Tue, 10 Dec 2024 15:26:40 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Chan <ericchancf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kai Huang <kai.huang@intel.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Russell King <linux@armlinux.org.uk>, Samuel Holland <samuel.holland@sifive.com>, 
	Suren Baghdasaryan <surenb@google.com>, Yuntao Wang <ytcoode@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCHv2 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Message-ID: <bz3vlh3lri7yfckdkddopwhsgvkmizhw5q6ecomgeba7q22ufp@ntu2kugiho4o>
References: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
 <20241021105723.2707507-3-kirill.shutemov@linux.intel.com>
 <20241118164616.GAZztvWGs9cOV8t20_@fat_crate.local>
 <s4frmqwtuvclinuu7ttyzfpe7bj7hju5xgt6sxzy3gyt3prr62@rrgvhkv4lgwv>
 <20241121114952.GCZz8eYEVa3yubYQzO@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121114952.GCZz8eYEVa3yubYQzO@fat_crate.local>

On Thu, Nov 21, 2024 at 12:49:52PM +0100, Borislav Petkov wrote:
> On Tue, Nov 19, 2024 at 10:21:05AM +0200, Kirill A. Shutemov wrote:
> > Sure, we can workaround every place that touches such ranges.
> 
> Every place? Which every place? I thought this is only an EISA issue?

I looked at other places where we call memremap(MEMREMAP_WB) such as
acpi_wakeup_cpu(). We actually get encrypted/private mapping for this
callsite despite __ioremap_caller() being called encrypted == false.
This happens because of IORES_MAP_ENCRYPTED check in __ioremap_caller().

So we depend on the BIOS here. The EISA problem happens because the
target memory is in !IORES_MAP_ENCRYPTED memory.

It's hard to say if any other memremap(MEMREMAP_WB) would trigger the
issue. And what will happen after next BIOS update.

> Then clearly your changelogs need to expand considerably more what we're
> *really* addressing here.
> 
> > Or we can address problem at the root and make creating decrypted/shared
> > mappings explicit.
> 
> What is the problem? That KVM implicitly converts memory to shared? Why does
> KVM do that an can it be fixed not to?
> 
> Doesn't sound like the guest's problem.

Well, the problem is on the both sides.

VMM behaviour on such accesses is not specified in any spec. AFAIK all
current VMM implementations do this implicit conversion.

I think it has to be fixed. VMMs (not only KVM) should not silently
convert memory to shared. But VMMs cannot make memory access to go away.
The only option they have is to inject #VE instead indicating bogus
access. At this point it becomes a guest problem.

It will get fixed in VMMs naturally when TDX Connect gets enabled.
With a secure device assigned to a TD, VMM would loose the ability to
convert memory on its own. The guest would have to unlock the memory
first. This will make implicit conversion impossible.

But it also means guest should never initiate shared access without
explicit conversion. Otherwise #VE will crash it.

> Or maybe this needs a lot more explanation what we're fixing here.
> 
> > Such mappings have both functional (as we see here) and security
> > implications (VMM can manipulate the guest memory range). We should not
> > create decrypted mappings by default on legacy interfaces.
> 
> So we're getting closer.
> 
> The changes themselves are fine but your text is missing a lot about what
> we're fixing here. When I asked, I barely scratched the surface. So can we
> elaborate here pls?

What about this:

x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default

Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:

memremap(MEMREMAP_WB)
  arch_memremap_wb()
    ioremap_cache()
      __ioremap_caller(.encrytped = false)

In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
if the resulting mapping is encrypted or decrypted.

Creating a decrypted mapping without explicit request from the caller is
risky:

  - It can inadvertently expose the guest's data and compromise the
    guest.

  - Accessing private memory via shared/decrypted mapping on TDX will
    either trigger implicit conversion to shared or #VE (depending on
    VMM implementation).

    Implicit conversion is destructive: subsequent access to the same
    memory via private mapping will trigger a hard-to-debug #VE crash.

The kernel already provides a way to request decrypted mapping
explicitly via the MEMREMAP_DEC flag.

Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
default unless MEMREMAP_DEC is specified.

This change fixes the crash on kexec in TDX guests if CONFIG_EISA is
enabled.
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

