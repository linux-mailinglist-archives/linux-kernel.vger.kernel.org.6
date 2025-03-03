Return-Path: <linux-kernel+bounces-542616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A5A4CBA1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C7B18938A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E1B22CBE2;
	Mon,  3 Mar 2025 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHYR8bWA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626033F6;
	Mon,  3 Mar 2025 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028993; cv=none; b=aewLHxbFl4GHWJYZGzov6U/Y7E2n4vNzq2UGdQs0bVqdApQ8o3bjG6f8+mqnWHTVa+KyIu5WW9ba2qQoIoqcu0+v77Ohi7OqB/ykWNWB7xstDLWJmkC6pX2hgeuVrZhytLmKQLGk3/cz9qPHNWgkESK2RAITwnwXKUCph4+cgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028993; c=relaxed/simple;
	bh=GRkTGlXTl9EsGkbV++PQV+IY4wEzGFdbTYXI3amD37Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxyueTBl0/r1lQAyEXSt4TwGDviKwslbPxYm+AsN7131Sb6QI1rej8v+o5ES0RO6Yr74mVxD6tBBo0H+LxPKsv27e19XKOmRs6fTKNHxDgoaP1mpPd+QK1y0p/KUGup0SJv2Akai7UTklEGMaEXGG+p7GRy8prrKqJ5uf/MLVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHYR8bWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBF9C4CED6;
	Mon,  3 Mar 2025 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741028993;
	bh=GRkTGlXTl9EsGkbV++PQV+IY4wEzGFdbTYXI3amD37Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHYR8bWAZC6eLKSKGjUIFCeSYu41CF6ijSSVCVrBbVcAkFUXrrBDvkiVmjD02ThS7
	 taahy85hooUcalCU7bDTOnnwKEyERYxdiYYlPOWteD/lNpBPQpZvPP+62eQfZlLO7B
	 XChINU6Mq8XGH0AYC62OF0NtA6frGRPph9mqOWEBC/F1OSOyBx84JhgVOjJqNyhx0W
	 5FHC9VXAAIzzwdUdUTxnOpUB2zV9YOa2I+SBf/7Aau2hT6/EE/0f/gJY7n4HQxLYT8
	 2wrDYsUrk2IwUwEtKE+tl0z7HUkvNR+MRXOZK+12f9c3lFcZP6u6MWQ7KepR3I+Opo
	 e+2lOtZgf4rqQ==
Date: Mon, 3 Mar 2025 11:09:50 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:x86/core 16/17] vmlinux.o: warning: objtool: do_jit+0x276:
 relocation to !ENDBR: .noinstr.text+0x6a60
Message-ID: <202503031109.2D9F1CD@keescook>
References: <202503030704.H9KFysNS-lkp@intel.com>
 <20250303092459.GI5880@noisy.programming.kicks-ass.net>
 <202503030910.55EBC9A76@keescook>
 <20250303185748.GC15322@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303185748.GC15322@noisy.programming.kicks-ass.net>

On Mon, Mar 03, 2025 at 07:57:48PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 03, 2025 at 09:11:54AM -0800, Kees Cook wrote:
> > On Mon, Mar 03, 2025 at 10:24:59AM +0100, Peter Zijlstra wrote:
> 
> > > > >> vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60
> 
> > Just for my own curiosity, how did you track this down? (The
> > relationship between cfi_bhi and do_jit is not immediately obvious to
> > me. Or rather, what was needing DCE?)
> 
> If you build dfebe7362f6f461d771cdb9ac2c5172a4721f064 (tip/x86/core^2 so
> as to not have the fix) and build a FINEIBT=y kernel with clang-19 (so
> as not to have support for kcfi-ariry) then:
> 
> $ ./scripts/objdump-func tmp-build/vmlinux.o do_jit
> ...
> 0267    6a2a7:  48 c1 e9 20             shr    $0x20,%rcx
> 026b    6a2ab:  0f 85 16 39 00 00       jne    6dbc7 <do_jit+0x3b87>
> 0271    6a2b1:  48 8b 44 24 20          mov    0x20(%rsp),%rax
> 0276    6a2b6:  48 c7 c1 00 00 00 00    mov    $0x0,%rcx        6a2b9: R_X86_64_32S     __bhi_args+0x20
> 027d    6a2bd:  c6 43 0b e8             movb   $0xe8,0xb(%rbx)
> 0281    6a2c1:  48 83 c0 10             add    $0x10,%rax
> 0285    6a2c5:  29 c1                   sub    %eax,%ecx
> 0287    6a2c7:  89 4b 0c                mov    %ecx,0xc(%rbx)
> ...
> 
> 
> So the reference is to __bhi_args[1], this is the result of
> emit_fineibt(.arity=1).
> 
> Anyway, the point is that for FINEIBT_BHI=n the __bhi_args[]
> array is 'empty' and the +0x20 thing points into random.
> 
> What needs DCE is the whole if (cfi_bhi) branch in emit_fineibt(),
> making that whole __bhi_args[] reference go away.

AH! Yes, that does stand out. :) Thanks!

-- 
Kees Cook

