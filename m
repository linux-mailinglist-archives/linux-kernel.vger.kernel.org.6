Return-Path: <linux-kernel+bounces-219082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E190C9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2EB1F227F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F93152793;
	Tue, 18 Jun 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RgfjsSlp"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D841534FD;
	Tue, 18 Jun 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707381; cv=none; b=H/mVBnlHvoRaTUA/Jv47l3CfGt0soN7SwKyLCL7A7ZVVkwV5HqJtocyRUO0DGWVVJ44MrX8Q4A9Erj5FfmIRFVnbRll1TYcAYTd+PfQoI6kAPuDCJzp5OLVt6qiAppvHt/kdr2kT71dvwcOIYtiECVGFbxsQKcMp9cNnSyASk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707381; c=relaxed/simple;
	bh=T8+aJf+zzo1cColHW0WRsyH6eiECwPFk62V/lKmBKD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIoHXtoZkyY8e1D/0/nFAlzVUXA2JHofErnASNitLifdXBs/Rx+ObSBhznTjxcdvXfL1/fNx7LqxhwPnOwCRRggnnFI8fpMMwIEGh4Jb2A39HSZKrNOaiXx+nd485SnC0rfBClgA8rhL+UjiNm6nlDmxdIWD+9udG8zD4vBliSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RgfjsSlp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ua1Erj2/pcE0GFTsxoNQXEMgOZ2VE6igL1t5H2C91Hk=; b=RgfjsSlpETRcWZA/qqUK7m5n1E
	gilTQ5tF9WOUP4KoAuPIUf9R+Mb8r37J81IipC3uvVeUcoiB84W9HgwNl9y7wWr5X5gfVo6dpUFR1
	VpQMxgd3Uy0EiK7pHREV0pxCUgdFzs4L5mfUjrrDDS9gXUSEZWoK/z0javvejLMQrQpX5cFb08IbD
	lgdiPVNtFCJyf3nI0HqVNwBJbuqpwF71qi6fkiFFXCdCvGQL0CdUq0FpA+sADWjy8m8RHRFthRfRv
	qrsjghielOnMMP/xHt3CYnJALXWjzW/Kw6BTMGJuX1WJbV/griB1WGSbhG1u4pWOCg2vsrPGIyylX
	niiO4Urw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJWIY-000000076zU-19CT;
	Tue, 18 Jun 2024 10:42:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 14F663001FD; Tue, 18 Jun 2024 12:42:35 +0200 (CEST)
Date: Tue, 18 Jun 2024 12:42:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <lkp@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:x86/alternatives 14/14] arch/x86/kvm/kvm.o: warning:
 objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
Message-ID: <20240618104234.GF31592@noisy.programming.kicks-ass.net>
References: <202406141648.jO9qNGLa-lkp@intel.com>
 <20240614152228.GAZmxgNPmozj7UzRdV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614152228.GAZmxgNPmozj7UzRdV@fat_crate.local>

On Fri, Jun 14, 2024 at 05:22:28PM +0200, Borislav Petkov wrote:
> On Fri, Jun 14, 2024 at 04:15:14PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
> > head:   f776e41fdcc4141876ef6f297318ab04c2382eb7
> > commit: f776e41fdcc4141876ef6f297318ab04c2382eb7 [14/14] x86/alternative: Replace the old macros
> > config: x86_64-buildonly-randconfig-r001-20211209 (https://download.01.org/0day-ci/archive/20240614/202406141648.jO9qNGLa-lkp@intel.com/config)
> > compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240614/202406141648.jO9qNGLa-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
> 
> That thing comes from:
> 
> SYM_FUNC_START(vmx_do_interrupt_irqoff)
>         VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
> SYM_FUNC_END(vmx_do_interrupt_irqoff)
> 
> at the end of arch/x86/kvm/vmx/vmenter.S.

You sure? Afaict the thing is:

$ OBJTOOL_ARGS="--verbose" make O=tmp-build/ arch/x86/kvm/
...
arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x29: (alt)
arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x0: <=== (sym)
0000 0000000000028220 <em_loop.part.0>:
0000    28220:  0f b6 47 61             movzbl 0x61(%rdi),%eax
0004    28224:  3c e2                   cmp    $0xe2,%al
0006    28226:  74 2c                   je     28254 <em_loop.part.0+0x34>
0008    28228:  48 8b 57 10             mov    0x10(%rdi),%rdx
000c    2822c:  83 f0 05                xor    $0x5,%eax
000f    2822f:  48 c1 e0 04             shl    $0x4,%rax
0013    28233:  25 f0 00 00 00          and    $0xf0,%eax
0018    28238:  81 e2 d5 08 00 00       and    $0x8d5,%edx
001e    2823e:  80 ce 02                or     $0x2,%dh
0021    28241:  48 05 00 00 00 00       add    $0x0,%rax        28243: R_X86_64_32S     em_setcc
0027    28247:  52                      push   %rdx
0028    28248:  9d                      popf
0029    28249:  ff d0                   call   *%rax
002b    2824b:  90                      nop
002c    2824c:  90                      nop
002d    2824d:  90                      nop
002e    2824e:  31 d2                   xor    %edx,%edx
0030    28250:  84 c0                   test   %al,%al
0032    28252:  74 1d                   je     28271 <em_loop.part.0+0x51>
0034    28254:  55                      push   %rbp
0035    28255:  48 63 b7 d0 00 00 00    movslq 0xd0(%rdi),%rsi
003c    2825c:  48 03 b7 90 00 00 00    add    0x90(%rdi),%rsi
0043    28263:  48 89 e5                mov    %rsp,%rbp
0046    28266:  e8 05 fe ff ff          call   28070 <assign_eip>
004b    2826b:  5d                      pop    %rbp
004c    2826c:  e9 00 00 00 00          jmp    28271 <em_loop.part.0+0x51>      2826d: R_X86_64_PLT32   __x86_return_thunk-0x4
0051    28271:  89 d0                   mov    %edx,%eax
0053    28273:  e9 00 00 00 00          jmp    28278 <em_loop.part.0+0x58>      28274: R_X86_64_PLT32   __x86_return_thunk-0x4
0058    28278:  0f 1f 84 00 00 00 00 00         nopl   0x0(%rax,%rax,1)

Which is in fact test_cc() from em_loop().

Now, that .config is a FRAME_POINTER build, and the fast-call thing
don't do frames, so it is right to complain. Big question is why it
didn't complain previously I suppose.

Also, notably, this patch:

  https://lkml.kernel.org/r/20231204093732.323101886@infradead.org

cures things.

Let me poke a little more...

