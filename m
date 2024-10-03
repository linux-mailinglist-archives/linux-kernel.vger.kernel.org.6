Return-Path: <linux-kernel+bounces-348990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A781E98EEFC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF301C2254F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49F199929;
	Thu,  3 Oct 2024 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IoLUyXcW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B63199244
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957869; cv=none; b=oLJXq+fpZoOzF1vCuOSbwvnG1SCV2lB/Q4JOeWbCJZYzHssPSHW0adXH6Ig8gMxG4zkxAjy8PIj+j7Kb6rQ5oqTRx67B1kzk6UN0bcCzq9JyuOWIKVyWL8nksO9nYgGTbI7dcINuWrvFk6BnXBx5BOE/mygu63vjh1G0rUThpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957869; c=relaxed/simple;
	bh=b3FoOgUnNZVQK5E2QYN90sz8zuv9UsgCd3jrPtoK2S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDU9sMuQnPL62acAFgVnl2XIemPg81kSMQXilSoJ0SrMl5kOqBGU+tdWMz7jPUtSdS722/GX3RDAynbtbXoKNDA5uCuatTPBeeDGA2PBbAvVg7P2p+AMWK5d7s9U0kjqnZLGit6bie6F3fORlOKbNT0+nGQH61RnGi/pNniPTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IoLUyXcW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QzyFy5mUB9ts1Cf6RytnX8t4yjoMdX5w3KtZ50eccBw=; b=IoLUyXcW5P89NN1lVJMASeP7/J
	ompMuQ9QAmkNpJD4x+PBdqNda4FJGM74rf7Rro42XGUZjog9KsMa7EdDHZsX5j2nb1zzDLT36oZeX
	Q4J3hbdG5C2v1a3MIP6CT1SWOxWcR5a/4VgTqy+sfQ100s4z3wal04iP0FmUn1gdnl6iO5Y6/0of7
	JW5N7pBXqBdgGnegmSDIOG+MQxoNA5PJJIj1bqEf5IhmVjigfOnGQnJZ+IVMg+zVWexeaSNw+i9An
	L4xgcGlpkJGaSogt4NGJoFwGne+ZVS3JNF+n7U0FgHl3/GgB82NCU084Yug3j/sPWPOWS6gw1Hch5
	oul0nL+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swKm3-00000007mrx-2eqe;
	Thu, 03 Oct 2024 12:17:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D523130083E; Thu,  3 Oct 2024 14:17:39 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:17:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 13/14] x86: BHI stubs
Message-ID: <20241003121739.GB17263@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble>
 <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>
 <20240930223848.ulipiky3uw52ej56@treble>
 <20241001110310.GM5594@noisy.programming.kicks-ass.net>
 <a7912ce1-131e-4b30-bed4-2576441c6212@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7912ce1-131e-4b30-bed4-2576441c6212@citrix.com>

On Tue, Oct 01, 2024 at 12:20:02PM +0100, Andrew Cooper wrote:
> On 01/10/2024 12:03 pm, Peter Zijlstra wrote:
> > On Mon, Sep 30, 2024 at 03:38:48PM -0700, Josh Poimboeuf wrote:
> >> On Mon, Sep 30, 2024 at 11:23:38PM +0100, Andrew Cooper wrote:
> >>> On 30/09/2024 10:30 pm, Josh Poimboeuf wrote:
> >>>> On Fri, Sep 27, 2024 at 09:49:09PM +0200, Peter Zijlstra wrote:
> >>>>> +SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
> >>>>> +	UNWIND_HINT_FUNC
> >>>>> +	cmovne %r10, %rdi
> >>>> IIUC, this works because if the "jz" in the CFI preamble mispredicts to
> >>>> the __bhi_args_* code, "cmovne" will zero out the speculative value of
> >>>> rdi.
> >>>>
> >>>> Why use %r10 instead of a literal $0?  Also how do you know %r10 is 0?
> >>> There's no encoding for CMOVcc which takes an $imm.
> >> Ah.
> >>
> >>> %r10 is guaranteed zero after the FineIBT prologue
> >> If the "jz" in the FineIBT prologue mispredicts, isn't %r10 non-zero by
> >> definition?
> > Since I just wrote the comment...
> >
> >  * FineIBT-BHI:
> >  *
> >  * __cfi_foo:
> >  *   endbr64
> >  *   subl 0x12345678, %r10d
> >  *   jz   foo-1
> >  *   ud2
> >  * foo-1:
> >  *   call __bhi_args_XXX
> >  * foo+4:
> >  *   ... code here ...
> >  *   ret
> >  *
> >  * direct caller:
> >  *   call foo+4
> >  *
> >  * indirect caller:
> >  *   lea foo(%rip), %r11
> >  *   ...
> >  *   movl $0x12345678, %r10d
> >  *   subl $16, %r11
> 
> A compiler would normally spell this:
> 
>     lea foo-16(%rip), %r11

Yeah, but the original lea is outside of the code we control, the kcfi
caller section we're rewriting gets to have %r11 as is.

> >  *   nop4
> >  *   call *%r11
> >
> > And lets take a random bhi function:
> >
> > +       .align 16
> > +SYM_INNER_LABEL(__bhi_args_0_1, SYM_L_LOCAL)
> > +       UNWIND_HINT_FUNC
> > +       cmovne %r10, %rdi
> > +       cmovne %r10, %rsi
> > +       ANNOTATE_UNRET_SAFE
> > +       ret
> > +       int3
> >
> > So the case you worry about is SUBL does *not* result in 0, but we
> > speculate JZ true and end up in CALL, and do CMOVne.
> >
> > Since we speculated Z, we must then also not do the CMOV, so the value
> > of R10 is irrelevant, it will not be used. The thing however is that
> > CMOV will unconditionally put a store dependency on the target register
> > (RDI, RSI in the above sequence) and as such any further speculative
> > code trying to use those registers will stall.
> 
> How does that help?
> 
> The write dependency doesn't stop a dependent load from executing in the
> shadow of a mispredicted branch.

I've been given to understand CMOVcc will kill any further speculation
using the target register. So by 'poisoning' all argument registers that
are involved with loads, we avoid any such load from happening during
speculation.



