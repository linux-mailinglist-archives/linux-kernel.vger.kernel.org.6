Return-Path: <linux-kernel+bounces-542599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE7A4CB77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84F13AA772
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862322DFBA;
	Mon,  3 Mar 2025 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lB4je+E4"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B531E285A;
	Mon,  3 Mar 2025 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028274; cv=none; b=ReCbvYvApq4rdjoNwvQM83xBcYH078o/9U+4kMLsMJjWqzUje7R4YZra7j/KaaJjHedlSBam47SkUv/7BEiwqfj9Ec/0PZMPdqil5fsO+jbePwqnM0H8dN62pc0JuJ3yCGGsH+sBbRulLyuixmpDN5WSaENq2NpKpbvXALlC1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028274; c=relaxed/simple;
	bh=nz9b+KN8viu5jpXWs0v+jylV/As5vhmBBiGN/NrbvWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEBe9nqMkEw1FjiywRXZMxzVopqYfklpVgtHqf7oq7519Cvq4bGvy+RQLU8xyQqISqzQpX9NXirkMVmuD1wGVem8DEJVPefRMUkreDvFNPEHZt3f7jAj63du4jX0mVhUCjwRgNtD/luHL6WUk7+WlPccqjlgEwpMJtAwtNldpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lB4je+E4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UCGrrsnfzIXfRwPBNxtTjaF7Ywp+E+UDRp4J9GD91M0=; b=lB4je+E4i6PhlNF5eqqdT+yjXy
	gX68ODfch4QEdak/34F4Hfad1+LNEMFFcIFiUNcWYgFcDTseBRdLJy4WHoOFwLhVGcnTOPTcsfn7Q
	OIGILN+hCqO5rwrqCPzJiXuDHCk9aXDF9AQDPi2VK523RKBuBCHycJ/hnzP7/1bUHnyraoXSGfG0Y
	o0Jv82IuiVkdX+V0X9bB+fqh1we2+uwphgDW+w++vfj4XIQUgxAmWCTTj8qWwq+Qa39BA1zZZO0sN
	WcVjx3FiuEjuKX5V47d0kVd1rgB0tcKkbF3wTiXC3wyKV9IYeZ4qaDc72EY+T/GJifHZ2CoR7L9yx
	nxBldq8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpAz7-00000004bTL-14Tm;
	Mon, 03 Mar 2025 18:57:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F5B430049D; Mon,  3 Mar 2025 19:57:48 +0100 (CET)
Date: Mon, 3 Mar 2025 19:57:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:x86/core 16/17] vmlinux.o: warning: objtool: do_jit+0x276:
 relocation to !ENDBR: .noinstr.text+0x6a60
Message-ID: <20250303185748.GC15322@noisy.programming.kicks-ass.net>
References: <202503030704.H9KFysNS-lkp@intel.com>
 <20250303092459.GI5880@noisy.programming.kicks-ass.net>
 <202503030910.55EBC9A76@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503030910.55EBC9A76@keescook>

On Mon, Mar 03, 2025 at 09:11:54AM -0800, Kees Cook wrote:
> On Mon, Mar 03, 2025 at 10:24:59AM +0100, Peter Zijlstra wrote:

> > > >> vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60

> Just for my own curiosity, how did you track this down? (The
> relationship between cfi_bhi and do_jit is not immediately obvious to
> me. Or rather, what was needing DCE?)

If you build dfebe7362f6f461d771cdb9ac2c5172a4721f064 (tip/x86/core^2 so
as to not have the fix) and build a FINEIBT=y kernel with clang-19 (so
as not to have support for kcfi-ariry) then:

$ ./scripts/objdump-func tmp-build/vmlinux.o do_jit
...
0267    6a2a7:  48 c1 e9 20             shr    $0x20,%rcx
026b    6a2ab:  0f 85 16 39 00 00       jne    6dbc7 <do_jit+0x3b87>
0271    6a2b1:  48 8b 44 24 20          mov    0x20(%rsp),%rax
0276    6a2b6:  48 c7 c1 00 00 00 00    mov    $0x0,%rcx        6a2b9: R_X86_64_32S     __bhi_args+0x20
027d    6a2bd:  c6 43 0b e8             movb   $0xe8,0xb(%rbx)
0281    6a2c1:  48 83 c0 10             add    $0x10,%rax
0285    6a2c5:  29 c1                   sub    %eax,%ecx
0287    6a2c7:  89 4b 0c                mov    %ecx,0xc(%rbx)
...


So the reference is to __bhi_args[1], this is the result of
emit_fineibt(.arity=1).

Anyway, the point is that for FINEIBT_BHI=n the __bhi_args[]
array is 'empty' and the +0x20 thing points into random.

What needs DCE is the whole if (cfi_bhi) branch in emit_fineibt(),
making that whole __bhi_args[] reference go away.

