Return-Path: <linux-kernel+bounces-520753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4515EA3AEC5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558D11888860
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DF95A4D5;
	Wed, 19 Feb 2025 01:17:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A2208CA;
	Wed, 19 Feb 2025 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927857; cv=none; b=njFxVgRTXpGTEWEJTPAb3dxC5Fw88Slx1hVt4/lnybjMKWdKalTRWv6G0Ob1FGGyZqR0754dEtJmgkF9WSrKLFZwYQfZL3HtEfmqR3zmMqsqsNSmS9KpZp5j9Efca5lCBbtNHJy0MTGrfej1sykkqRaZwIOynouC5JAvNP9cdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927857; c=relaxed/simple;
	bh=aR/2VqVfOeqn48qHKxBJmPg0zx7e1qwGT596CwOzOeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REAPUZRcUZ/FffdlqyvprK07ju0AvgPcY1tciKeeQN4zaPs7fLL1WvKP98v0TBml8ASRIVfO5gsD0sD4kyxpLBYKtcsK6AV4sJU3q29iQcXgFOIkFvvl0lfFlED7n/IpuT3yMF7fiY+4ViNnuSRu/HGlPDSftlNR4WifEuwkot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AECAC4CEE2;
	Wed, 19 Feb 2025 01:17:36 +0000 (UTC)
Date: Tue, 18 Feb 2025 17:17:34 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: ERROR: modpost: "kmsan_handle_dma"
 [drivers/virtio/virtio_ring.ko] undefined!
Message-ID: <20250219011734.ig2sgadr7jmf7k7e@jpoimboe>
References: <202502150634.qjxwSeJR-lkp@intel.com>
 <20250218114857.oBuLvPYs@linutronix.de>
 <20250218132855.GE40464@noisy.programming.kicks-ass.net>
 <20250218164724.uxcwotv3wgc5y3id@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218164724.uxcwotv3wgc5y3id@jpoimboe>

On Tue, Feb 18, 2025 at 08:47:26AM -0800, Josh Poimboeuf wrote:
> On Tue, Feb 18, 2025 at 02:28:55PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 18, 2025 at 12:48:57PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2025-02-15 06:42:36 [+0800], kernel test robot wrote:
> > > > >> arch/x86/kvm/cpuid.o: warning: objtool: do_cpuid_func+0x2428: undefined stack state
> > > 
> > 
> > > From the assembly it seems to make sense:
> > > |   110ae:       49 89 e0                mov    %rsp,%r8
> > > stash for later
> > > |   110b1:       48 85 db                test   %rbx,%rbx
> > > |   110b4:       c7 00 00 00 00 00       movl   $0x0,(%rax)
> > > |   110ba:       45 89 7e 14             mov    %r15d,0x14(%r14)
> > > |   110be:       0f 85 40 01 00 00       jne    11204 <do_cpuid_func+0x22f4>
> > > …
> > > |   11204:       44 8b 74 24 38          mov    0x38(%rsp),%r14d
> > > |   11209:       44 89 f7                mov    %r14d,%edi
> > > |   1120c:       4d 89 c7                mov    %r8,%r15

[ Adding Masahiro for #1 ]

1)

Masahiro, one problem we've seen is that "make LLVM=1
arch/x86/kvm/cpuid.s" doesn't match the final compiled .o binary.  Is it
a problem with cmd_cc_s_c?  The original .config is here:

  https://lore.kernel.org/202502150634.qjxwSeJR-lkp@intel.com

If I manually run the original gcc command with -S, cpuid.s looks right.

2)

Peter, Sebastian, the objtool warning is caused by Clang interpreting
ASM_CALL_CONSTRAINT a little too literally.  It's stashing the stack
pointer and restoring it later to comply with the "+r" rsp constraint.
Which makes perfect sense, but is also 100% unexpected.

I "fixed" it with the below, but it's not a proper fix as
ASM_CALL_CONSTRAINT is still needed for CONFIG_UNWINDER_FRAME_POINTER.

So I think the options are:

  - Make objtool smarter

  - Improve ASM_CALL_CONSTRAINT somehow.  /me wonders if "memory"
    clobber has the same effect?

  - Drop support for x86-64 frame pointers altogether, along with
    ASM_CALL_CONSTRAINT.  Is there any reason to keep frame pointers
    around anymore for 64 bit?  AFAICT objtool is 100% mandatory for all
    configs, and ORC has proven to be solid.

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b04f436..7414f0c7cc0e 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -394,7 +394,7 @@ int paravirt_disable_iospace(void);
 		PVOP_TEST_NULL(op);					\
 		asm volatile(ALTERNATIVE(PARAVIRT_CALL, ALT_CALL_INSTR,	\
 				ALT_CALL_ALWAYS)			\
-			     : call_clbr, ASM_CALL_CONSTRAINT		\
+			     : call_clbr				\
 			     : paravirt_ptr(op),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
@@ -409,7 +409,7 @@ int paravirt_disable_iospace(void);
 		asm volatile(ALTERNATIVE_2(PARAVIRT_CALL,		\
 				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
 				 alt, cond)				\
-			     : call_clbr, ASM_CALL_CONSTRAINT		\
+			     : call_clbr				\
 			     : paravirt_ptr(op),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\

-- 
Josh

