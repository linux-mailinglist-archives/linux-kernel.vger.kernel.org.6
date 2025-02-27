Return-Path: <linux-kernel+bounces-537482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C875BA48C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6882C188DCE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BD0272914;
	Thu, 27 Feb 2025 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e60UYRhq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3D2309A3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698031; cv=none; b=dzhCiwj0w0EaL6hHKtI1rIcJMfq0wIV3bPKBEit1FYBuTejRMKqsJBVYB8SVKUAKcvyuBlbkAjrutlXImuUBkeUMRR9+QM9anyi2PrZJE+GAyr7VstiaGRA1WFyW9LLTtFCQFoQ4Q2Vyb47xcaYQqeUhunQPFTZlz8faDY+J/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698031; c=relaxed/simple;
	bh=YxE5PbthybxzU4+96qEkLJpOorLgZO9Gyydc3c1Dw4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF70kBzNpF9XhYVlzwQ0cWl1CvlB4c4sAxVAuo75RWQPpppEs/M2LOO6t+z5hymb97id3D7HGQXK3CSSmr3S9rDLtym5Pd9WvMM1/rBaTy0HxnUamtql+fEaF7mxf8BPQOUKYRdKqnMVNLjMLqGpVsWkH98YKdd6iyQQTYdcm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e60UYRhq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740698029; x=1772234029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YxE5PbthybxzU4+96qEkLJpOorLgZO9Gyydc3c1Dw4k=;
  b=e60UYRhq+XeNC/z4ni4Ipp/8HtqYjA7JoAs6YloCIMGyDE/13IeqE9RI
   8WilKkQrmEOGuM6HiRofDv6r1GvMkRc27lbYrKNRaVsb2FKb05rsdEFZF
   DE/NYmt6GctqXNs/I6HsDCXhNUoha58KPaDCo17eV94HvJvogPqtoOBkI
   6EajSpFss0YCK0ed78udnncGnaNn3sMdZs/dDJ5Gi3NZfTpltig0WENAY
   ZI7/yt/7+WXpei9pjzmHX8/EaiXmzahOq6C/aAJ9gUO6n5TnCdsCj8uTW
   w7RBpvW1/kbSixXpoHYYQJl0dqiUcWqoCw9fFXKxfIG69aMJrszJrjd5v
   A==;
X-CSE-ConnectionGUID: m3/s/QsGS8e2C95QOWS4SA==
X-CSE-MsgGUID: CIcQ31wGRruv22UcHsAO8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52246811"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="52246811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:13:49 -0800
X-CSE-ConnectionGUID: TtVG0Xe0TKO6gnDOVb1pKQ==
X-CSE-MsgGUID: nGRSvO7vTByIbJgRhtJWQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="140391404"
Received: from jgarnacx-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.170])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:13:49 -0800
Date: Thu, 27 Feb 2025 15:13:42 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Simplify and make CALL_NOSPEC consistent
Message-ID: <20250227231342.jh67quujcd3tgmft@desk>
References: <20250226-call-nospec-v1-1-4dde04a5c7a7@linux.intel.com>
 <497a3694-cb0d-4678-9622-d9443bf8a40d@citrix.com>
 <20250227184133.lxm43awa2jgdpl4q@desk>
 <15253834-fb89-408f-8269-65413ad29f7a@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15253834-fb89-408f-8269-65413ad29f7a@citrix.com>

On Thu, Feb 27, 2025 at 06:57:37PM +0000, Andrew Cooper wrote:
> On 27/02/2025 6:41 pm, Pawan Gupta wrote:
> > On Thu, Feb 27, 2025 at 12:49:48AM +0000, Andrew Cooper wrote:
> >> On 26/02/2025 9:03 pm, Pawan Gupta wrote:
> >>> @@ -420,20 +420,28 @@ static inline void call_depth_return_thunk(void) {}
> >>>  
> >>>  #ifdef CONFIG_X86_64
> >>>  
> >>> +/*
> >>> + * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
> >>> + * to the retpoline thunk with a CS prefix when the register requires
> >>> + * a REX prefix byte to encode. Also see apply_retpolines().
> >>> + */
> >> Technically, both comments aren't quite accurate.  __CS_PREFIX() emits a
> >> conditional CS prefix in a manner compatible with
> >> -mindirect-branch-cs-prefix, not the full 5/6 byte jmp/call.
> > You are right, I will update the comment, and also the ASSEMBLY version
> > where this comment came from:
> >
> >   /*
> >    * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
> >    * to the retpoline thunk with a CS prefix when the register requires
> >    * a REX prefix byte to encode. Also see apply_retpolines().
> >    */
> >   .macro __CS_PREFIX reg:req
> >           .irp rs,r8,r9,r10,r11,r12,r13,r14,r15
> >           .ifc \reg,\rs
> >           .byte 0x2e
> >           .endif
> >           .endr
> >   .endm
> >
> >>> +#define __CS_PREFIX(reg)				\
> >>> +	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15;		\
> >>> +	.ifc \\rs, \reg;				\
> >> Why are these escaped differently?  Given they're all \r of some form or
> >> another, I guess something is going wonky with __stringify(), but its
> >> still weird for them to be different.
> >>
> >> Do you have a fully pre-processed source to hand to see how CALL_NOSPEC
> >> ends up?
> > Below is the pre-processed source for test_cc() generated with "make arch/x86/kvm/emulate.i".
> >
> > - This is with double backslash in ".ifc \\rs, \reg":
> >
> > 	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15; .ifc \\rs, \%V[thunk_target]; .byte 0x2e; .endif; .endr;" "call __x86_indirect_thunk_%V[thunk_target]\n"
> >                                                                                   ^
> > 	This ends up emitting the CS prefix byte correctly:
> >
> > 	2e e8 51 c9 32 01       cs call ffffffff824289e0
> >
> > - This is with single backslash in ".ifc \\rs, \reg":
> >
> > 	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15; .ifc \rs, \%V[thunk_target]; .byte 0x2e; .endif; .endr;" "c      all __x86_indirect_thunk_%V[thunk_target]\n"
> >                                                                                   ^
> > 	This version does not emit the CS prefix byte:
> >
> > 	e8 52 c9 32 01          call   ffffffff824289e0
> >
> > I tried looking in gcc inline assembly documentation but could not find
> > anything that would explain this. :(
> 
> It's because it's about plain C strings.
> 
> \r (from \rs) is Carriage Return (ASCII 0x0d).

Ah, right.

> After AS's macro expansion, \reg becomes \% which is not a valid escape
> character, so the \ gets left intact.
> 
> \reg should become \\reg or you'll probably get a compiler complaining
> eventually.

Using \\ for reg like this:

 .ifc \\rs, \\reg

is not emitting the CS prefix. I am trying to wrap my head around the
magic.

Below is the pre-processor output:

	asm("push %[flags]; popf; " ".irp rs,r8,rax,r9,r10,r11,r12,r13,r14,r15; .ifc \\rs, \\%V[thunk_target]; .byte 0x2e; .endif; .end      r;" "call __x86_indirect_thunk_%V[thunk_target]\n"
	: "=a"(rc), "+r" (current_stack_pointer) : [thunk_target]"r"(fop), [flags]"r"(flags));

