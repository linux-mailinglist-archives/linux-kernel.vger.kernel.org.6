Return-Path: <linux-kernel+bounces-345733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004A598BA8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325631C231DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24A11BF338;
	Tue,  1 Oct 2024 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i4Q7P/T0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3881BF337
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780607; cv=none; b=gmbeCAuLPC+cxwW8D9wbDgqHX6crES3Z1092XAOkX3IvaM07jnrj6u7arExJ6SG5YsnfQDAX53p56qekQQFW05to13CUI7Yi7maA5UHZZ+7bWF7YCFUaDDiViN0cn7Gf8k/p2sKMytwu7dZnzQVVVkKkruaOnBakUmhxwKW3RgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780607; c=relaxed/simple;
	bh=N17mucv/C6Kv+u+zER+VAPZtZMJSTluTxzJt3GWfBSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTW0hm0aPVDDpff1IpItt88rANRiq2TTy9UeVVEvk67gOOc0gLDEoo7s2rgbKmDern/MfdvvmqFuqQcJn6UMDRrlOdiuYrQ2cqF5gvI2cPyYgjOYrwvVbyEEAl9aX0pC0sSwfF7cp0CmpCNl439ZkA6+lAFM0WHGI2KWJPiucUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i4Q7P/T0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nJNEOALcHIiGx1Sn7Q8nUuHQjmsy2GLe0tScvgkmPX0=; b=i4Q7P/T0d5cQIDeNrznYMk4e7e
	m4Nf9O4OGGLzP8Hob66efrrzy008lKrquC1pifwtlW08V0zqqMHcH5wWCZrgFMbxz4LkFe4LAnbDC
	+RCMEaSB+X3lJFbnaOMr9mDvDWuKzfMx1aIsfBdMOBPw83+c5n7te9u84YdZkzL9r1MFXxahLCnsk
	LuvAciqKHDVFhmaRMDXI4bj/ARfhm4IY2fiOZvcWxjbbinIERq+kXtWxsZ3ROBkBV0a04pnH90IHf
	M5MUvKdhdmzcP08WMYoFRIxoGsAWDymXGnTB5Bj01W2WPPA9tDyBh26XrWTatPeLbAGmQs7lMrhSe
	p3aLsHVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svaes-00000002D7q-3nE2;
	Tue, 01 Oct 2024 11:03:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 866F530057A; Tue,  1 Oct 2024 13:03:10 +0200 (CEST)
Date: Tue, 1 Oct 2024 13:03:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 13/14] x86: BHI stubs
Message-ID: <20241001110310.GM5594@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble>
 <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>
 <20240930223848.ulipiky3uw52ej56@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930223848.ulipiky3uw52ej56@treble>

On Mon, Sep 30, 2024 at 03:38:48PM -0700, Josh Poimboeuf wrote:
> On Mon, Sep 30, 2024 at 11:23:38PM +0100, Andrew Cooper wrote:
> > On 30/09/2024 10:30 pm, Josh Poimboeuf wrote:
> > > On Fri, Sep 27, 2024 at 09:49:09PM +0200, Peter Zijlstra wrote:
> > >> +SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
> > >> +	UNWIND_HINT_FUNC
> > >> +	cmovne %r10, %rdi
> > > IIUC, this works because if the "jz" in the CFI preamble mispredicts to
> > > the __bhi_args_* code, "cmovne" will zero out the speculative value of
> > > rdi.
> > >
> > > Why use %r10 instead of a literal $0?  Also how do you know %r10 is 0?
> > 
> > There's no encoding for CMOVcc which takes an $imm.
> 
> Ah.
> 
> > %r10 is guaranteed zero after the FineIBT prologue
> 
> If the "jz" in the FineIBT prologue mispredicts, isn't %r10 non-zero by
> definition?

Since I just wrote the comment...

 * FineIBT-BHI:
 *
 * __cfi_foo:
 *   endbr64
 *   subl 0x12345678, %r10d
 *   jz   foo-1
 *   ud2
 * foo-1:
 *   call __bhi_args_XXX
 * foo+4:
 *   ... code here ...
 *   ret
 *
 * direct caller:
 *   call foo+4
 *
 * indirect caller:
 *   lea foo(%rip), %r11
 *   ...
 *   movl $0x12345678, %r10d
 *   subl $16, %r11
 *   nop4
 *   call *%r11

And lets take a random bhi function:

+       .align 16
+SYM_INNER_LABEL(__bhi_args_0_1, SYM_L_LOCAL)
+       UNWIND_HINT_FUNC
+       cmovne %r10, %rdi
+       cmovne %r10, %rsi
+       ANNOTATE_UNRET_SAFE
+       ret
+       int3

So the case you worry about is SUBL does *not* result in 0, but we
speculate JZ true and end up in CALL, and do CMOVne.

Since we speculated Z, we must then also not do the CMOV, so the value
of R10 is irrelevant, it will not be used. The thing however is that
CMOV will unconditionally put a store dependency on the target register
(RDI, RSI in the above sequence) and as such any further speculative
code trying to use those registers will stall.

> > , but I don't see
> > anything in patch 11 which makes this true in the !FineIBT case.
> 
> I thought this code is only used by FineIBT?

Right, so I do have me a patch that adds it to regular KCFI as well, but
I dropped it for now, since I don't have a strong rationale for it and
it requires yet more compiler tinkering.

