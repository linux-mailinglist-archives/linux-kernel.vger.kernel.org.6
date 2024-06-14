Return-Path: <linux-kernel+bounces-215190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E46908F72
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6F02869BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166A16C878;
	Fri, 14 Jun 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QogjhcQZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC2383
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380703; cv=none; b=KM0A5NFn36zvoBW/ALN6qJO9smNdMEm7R80gBAq4krEhVrLWGIyQYZU+Ky4yc2ahoXKtP2crN6FyEBCNbSM1wZomdm9PJK+PNbDSdFodg1u/bmjIZDjEcQe1PD/3Xpn8ltLt0cR445FnWrN6iFMjQvQGlCRwqxKd1ejQLdb7M/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380703; c=relaxed/simple;
	bh=P5ZZeYq1Hcarnjg1zUZDHvQhJDrcePSdv/b05UC94wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYpCwbNN4uFqvQ2WOA0lDRheU9OdlsVlOz5EqVBVsc640cgR97fsBf45StRI2adVCIrQQqda6H8PScl36WP+VL1sIQwaDdQ/CxwybDdPBDena9Wrcbl+CC0cYQJwd8FJZO0mHb+MnQCeK0dv98EACN6sFk9bmySdJo9jeZgoRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QogjhcQZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1338B40E0184;
	Fri, 14 Jun 2024 15:58:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4hcUFizNbnIE; Fri, 14 Jun 2024 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718380696; bh=kExfgvDa0XNhn/Wyl8YL68c+5vjLVXtGlJyAV4u3X9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QogjhcQZarJ54cy6XEFvO4wXaTf5oumhjbPfnulvt8fjiAgQFSlC2Zd93Dan1vj+r
	 H3jKc7x0re18A3SxY0+lfywnIEdFeHn33Leu7+oz4IejuP2GFWK7M9t+619dzPAcBn
	 giPcgY/ScONmcFVZv1N2hNjywJ3oVB6UoRDiIogkS+JELalzxE2q6eaR3T9J1HMEjW
	 Kef/tzQj9GeYsO8of/GSQFoAkzMBOZn0C/q9zyENZpvr9Kr4+mwQO7fUq1kHQDwFpt
	 GqhSAr+qug2GV/M+KNb40Jy0XTI96D9l3eVH7POTVPnBUBIHAeu8HDbS/U69qDCzr+
	 j2sTtJgOEnbBnbfd+cCRG4tQSxixKOE1q00tdvUpFBqzoGuqd3ePOuch0nxNhuC1lb
	 qk1WGTEmgySpBvzFEro4j3vxjx1iYKJe397pN0sSQPWNUwAxpIWxmFHn9Y+5eEyDl6
	 Z1JfO+MRbkSNFGHvpNuOMklCv0WXqq0RTWJMjhPH0DyAn0ZPxMMtaWx/c8WgUheIwE
	 nFOZyfgjl7NnfNJ36+dGzBsfSugR+3j8Rd8AMNASdcl2lyRParaTeQY4cIPCo7tykL
	 6lBL6/GKN4D7LfiSRX1+TrEmgQq1WPTORPzsJb/osiGH5+cU8uaAo0IHjo+T7IGW+A
	 GZ9HAN9KksNun1WZ5JfieaL8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C278B40E00C9;
	Fri, 14 Jun 2024 15:58:09 +0000 (UTC)
Date: Fri, 14 Jun 2024 17:58:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: kernel test robot <lkp@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:x86/alternatives 14/14] arch/x86/kvm/kvm.o: warning:
 objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
Message-ID: <20240614155804.GBZmxojDwTJig1ENBl@fat_crate.local>
References: <202406141648.jO9qNGLa-lkp@intel.com>
 <20240614152228.GAZmxgNPmozj7UzRdV@fat_crate.local>
 <ZmxjOxhPy67QOh5Q@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmxjOxhPy67QOh5Q@google.com>

On Fri, Jun 14, 2024 at 08:35:23AM -0700, Sean Christopherson wrote:
> That function does create a stack frame, just without using FRAME_BEGIN/END so
> it's not dependent on using frame pointers.  Ironically, the intent is to try and
> placate objtool.

Sneaky.

> IIUC, this warning just stared showing up with the alternatives changes?

Yeah, perhaps the other one triggered this one too but it wasn't in the 0day
report. The two warnings I reproduced here are:

arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0x2eb: call without frame pointer save/setup

and the other one is caused by the alternatives missing ASM_CALL_CONSTRAINT %rsp
handing into the inline asm.

> Does CALL_NOSPEC generate different code now?

Hm, so I've been staring at this for a long time today and maybe I've veered off
into the weeds already ... :-\

So we use the asm variant of that CALL_NOSPEC thing:

.globl vmx_do_interrupt_irqoff ; .balign 16, 0x90;; ; vmx_do_interrupt_irqoff: endbr64
 VMX_DO_EVENT_IRQOFF CALL_NOSPEC rdi
.type vmx_do_interrupt_irqoff STT_FUNC ; .set .L__sym_size_vmx_do_interrupt_irqoff, .-vmx_do_interrupt_irqoff ; .size vmx_do_interrupt_irqoff, .L__sym_size_vmx_do_interrupt_irqoff

with

.macro CALL_NOSPEC reg:req

 __CS_PREFIX \reg
 call __x86_indirect_thunk_\reg

.endm

so the end-result is, what, this perhaps?

ffffffff81070e20 <vmx_do_interrupt_irqoff>:
ffffffff81070e20:       f3 0f 1e fa             endbr64
ffffffff81070e24:       55                      push   %rbp
ffffffff81070e25:       48 89 e5                mov    %rsp,%rbp

<--- new stack frame

ffffffff81070e28:       48 83 e4 f0             and    $0xfffffffffffffff0,%rsp
ffffffff81070e2c:       6a 18                   push   $0x18
ffffffff81070e2e:       55                      push   %rbp
ffffffff81070e2f:       9c                      pushf
ffffffff81070e30:       6a 10                   push   $0x10

push things on the stack...

ffffffff81070e32:       e8 09 67 60 00          call   ffffffff81677540 <__x86_indirect_thunk_rdi>
ffffffff81070e37:       48 89 ec                mov    %rbp,%rsp
ffffffff81070e3a:       5d                      pop    %rbp

restore stack.

ffffffff81070e3b:       e9 30 68 60 00          jmp    ffffffff81677670 <__x86_return_thunk>

So that function has a proper stack frame.

Why doesn't objtool recognize that?

I betcha it is something with that has_valid_stack_frame() from

                        if (opts.stackval && func && !is_special_call(insn) &&
                            !has_valid_stack_frame(&state)) {
                                WARN_INSN(insn, "call without frame pointer save/setup");
                                return 1;
                        }

the objtool check. And I see "cfi" there and my brain says "nope". :)

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

