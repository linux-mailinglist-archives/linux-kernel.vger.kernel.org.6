Return-Path: <linux-kernel+bounces-537555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40946A48D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B7717020D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368EF1586C8;
	Fri, 28 Feb 2025 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qrfg1Ew/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA1522F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702686; cv=none; b=EHMNn3XgsjNbOMer0xLcTujKabOqWdEzgcNgA76SHaE6jylAgD72NFNaPV2ckOQNVaGnUMZd9Y3XUlh5ye9QTKIXI6oSisY7OXoGCVNuAGVSg7igDt/3t3vtcHOpP5pKI0Nrxx4QH00ystZQdYF7Bk/CiOaLMlU8Keew+dgt//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702686; c=relaxed/simple;
	bh=0ZRivjjF1G3YtWZXwfdr4wG5BFuEN3wxUJ5Nc9dqWhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDjUeRKAAGa6nw8BnduFa3D83c8i85bWKhuJ33D3sUE7bw6OcdwDF8Y4O0R0TkxmpF3h+xmH8hqEvib7G+dtOGE6tQhV4NVNy96wXOrA11WkdRNsVRo0ZSCPr+1Yjcr9hArLrNg87lSXmlV+omii6QWCQOLmD9h7B3ffahX0qnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qrfg1Ew/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740702685; x=1772238685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0ZRivjjF1G3YtWZXwfdr4wG5BFuEN3wxUJ5Nc9dqWhc=;
  b=Qrfg1Ew/31FV8AJhv4mJUj7hwp+Gq2VfbR9u9x+HelEibFN+QsZw49FA
   l4iC+53vNY71p3q9xxXP5dVA93jX7iqAJSpYaLggf5bnSzLgJiNeZYCfZ
   y8KnpbdD5unnIn2M9pfDtM5tqiKwcoUI/olT7hZKFiDgWF8b0S/QPKBmd
   mFfY2UF36HtAYYVOk1mSo2Mmwozr6SJlIs05ChbtyucxWUpMC/xx+5k25
   Cb+sT/hpd/uSUUtieS3KzFlu99yJezuHvMt2FmREk2L28A33WiHpLdOTa
   6Kl9LPG3In+v9OE9WrtmoIEEe5z8do8xkzWrdLhbvoMFIaSzHpmKi3/yP
   A==;
X-CSE-ConnectionGUID: 4X5TGyyGSB+61WiBbepuMg==
X-CSE-MsgGUID: P5MMLH1xTp+ld2kwfuhdOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41747897"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41747897"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 16:31:23 -0800
X-CSE-ConnectionGUID: u74nw6ZKTFS/KL4yrvFLvg==
X-CSE-MsgGUID: USILXBKxTU+7MgUiae2X0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117709471"
Received: from jgarnacx-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.170])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 16:31:24 -0800
Date: Thu, 27 Feb 2025 16:31:17 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Simplify and make CALL_NOSPEC consistent
Message-ID: <20250228003117.q6f2f5a7ndt2o226@desk>
References: <20250226-call-nospec-v1-1-4dde04a5c7a7@linux.intel.com>
 <497a3694-cb0d-4678-9622-d9443bf8a40d@citrix.com>
 <20250227184133.lxm43awa2jgdpl4q@desk>
 <15253834-fb89-408f-8269-65413ad29f7a@citrix.com>
 <20250227231342.jh67quujcd3tgmft@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227231342.jh67quujcd3tgmft@desk>

On Thu, Feb 27, 2025 at 03:13:48PM -0800, Pawan Gupta wrote:
> On Thu, Feb 27, 2025 at 06:57:37PM +0000, Andrew Cooper wrote:
> > On 27/02/2025 6:41 pm, Pawan Gupta wrote:
> > > On Thu, Feb 27, 2025 at 12:49:48AM +0000, Andrew Cooper wrote:
> > >> On 26/02/2025 9:03 pm, Pawan Gupta wrote:
> > >>> @@ -420,20 +420,28 @@ static inline void call_depth_return_thunk(void) {}
> > >>>  
> > >>>  #ifdef CONFIG_X86_64
> > >>>  
> > >>> +/*
> > >>> + * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
> > >>> + * to the retpoline thunk with a CS prefix when the register requires
> > >>> + * a REX prefix byte to encode. Also see apply_retpolines().
> > >>> + */
> > >> Technically, both comments aren't quite accurate.  __CS_PREFIX() emits a
> > >> conditional CS prefix in a manner compatible with
> > >> -mindirect-branch-cs-prefix, not the full 5/6 byte jmp/call.
> > > You are right, I will update the comment, and also the ASSEMBLY version
> > > where this comment came from:
> > >
> > >   /*
> > >    * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
> > >    * to the retpoline thunk with a CS prefix when the register requires
> > >    * a REX prefix byte to encode. Also see apply_retpolines().
> > >    */
> > >   .macro __CS_PREFIX reg:req
> > >           .irp rs,r8,r9,r10,r11,r12,r13,r14,r15
> > >           .ifc \reg,\rs
> > >           .byte 0x2e
> > >           .endif
> > >           .endr
> > >   .endm
> > >
> > >>> +#define __CS_PREFIX(reg)				\
> > >>> +	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15;		\
> > >>> +	.ifc \\rs, \reg;				\
> > >> Why are these escaped differently?  Given they're all \r of some form or
> > >> another, I guess something is going wonky with __stringify(), but its
> > >> still weird for them to be different.
> > >>
> > >> Do you have a fully pre-processed source to hand to see how CALL_NOSPEC
> > >> ends up?
> > > Below is the pre-processed source for test_cc() generated with "make arch/x86/kvm/emulate.i".
> > >
> > > - This is with double backslash in ".ifc \\rs, \reg":
> > >
> > > 	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15; .ifc \\rs, \%V[thunk_target]; .byte 0x2e; .endif; .endr;" "call __x86_indirect_thunk_%V[thunk_target]\n"
> > >                                                                                   ^
> > > 	This ends up emitting the CS prefix byte correctly:
> > >
> > > 	2e e8 51 c9 32 01       cs call ffffffff824289e0
> > >
> > > - This is with single backslash in ".ifc \\rs, \reg":
> > >
> > > 	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15; .ifc \rs, \%V[thunk_target]; .byte 0x2e; .endif; .endr;" "c      all __x86_indirect_thunk_%V[thunk_target]\n"
> > >                                                                                   ^
> > > 	This version does not emit the CS prefix byte:
> > >
> > > 	e8 52 c9 32 01          call   ffffffff824289e0
> > >
> > > I tried looking in gcc inline assembly documentation but could not find
> > > anything that would explain this. :(
> > 
> > It's because it's about plain C strings.
> > 
> > \r (from \rs) is Carriage Return (ASCII 0x0d).
> 
> Ah, right.
> 
> > After AS's macro expansion, \reg becomes \% which is not a valid escape
> > character, so the \ gets left intact.
> > 
> > \reg should become \\reg or you'll probably get a compiler complaining
> > eventually.
> 
> Using \\ for reg like this:
> 
>  .ifc \\rs, \\reg
> 
> is not emitting the CS prefix. I am trying to wrap my head around the
> magic.

Getting rid of one layer of macro makes it less magical:

#define __CS_PREFIX(reg)				\
            ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15\n"	\
            ".ifc \\rs," reg "\n"                       \
            ".byte 0x2e\n"                              \
            ".endif\n"                                  \
            ".endr\n"

#define CALL_NOSPEC    __CS_PREFIX("%V[thunk_target]")  \
                        "call __x86_indirect_thunk_%V[thunk_target]\n"
#else
#define CALL_NOSPEC    "call *%[thunk_target]\n"
#endif

Preprocessor output is as expected, and this emits the CS prefix correctly:

	".ifc \\rs, %V[thunk_target]"

Full version:

	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15\n" ".ifc \\rs," "%V[thunk_target]" "\n" ".byte 0x2e\n" ".endif\n" ".endr\n" "call __x86_indirect_thunk_%V[thunk_target]\n"
	: "=a"(rc), "+r" (current_stack_pointer) : [thunk_target]"r"(fop), [flags]"r"(flags));

