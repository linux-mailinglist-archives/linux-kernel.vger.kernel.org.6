Return-Path: <linux-kernel+bounces-342463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433CB988F58
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6861C20D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925EB187FF2;
	Sat, 28 Sep 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V9/TuvD7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713B200DE
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727529145; cv=none; b=fd4Kbf5pfeh3SCAVl4SgRbqmnyoft6dvdxrlRmj3XEH0b1dwgmSaz8m4vLOtB2qAInhvMklkcVQpbI4tcMeKF/al2gKRYxVj9lx+C87fQMPmtz/956usQ7iX4T59SdqvxijyCChcDbXwV8Y44LTaE9tAfX2ks6rVxMyM4OxIxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727529145; c=relaxed/simple;
	bh=LxB+6ENofMvVW7sF6JWkRwnMhtRXn+7nkDBnSin6Foc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NALvhdrw4ChnV5f+ZQUh6zwMZU3kUDjoQCCOYMTuO7LsOrV8l3Z8+nFUtOhf9Bd2qrhRt/nSSWh4AkMD4KZq6vlMdE2PRrEl3LSUt/RBlqhsYaMoESWqogF4R2G1Sj6mxZDASHUnnG0fMUf1uIaYjISUrcDMUfmYhvfZLEEm8P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V9/TuvD7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K00OfJcg4vjq2Q+FA/ijt4TtwAiKRVW+BxeqZe6dDeQ=; b=V9/TuvD7+nIoN6IJHvAnu9NFRP
	bX2bvmSBuyilsuZzR0ryPZVezUAwDCRLR1iYZG1criJF0HEouWo6lSFFV2pT1MyqTG50Q1rPs+qHu
	AZz3D8f+9zjV5yN/3gFxpdgBBF7W4TTB7+00i/9bbQCOOp5rYQ7XStwlpwrAiKWA8bI00uT7o3KAU
	aehALwCdyZNOUUC0g8z47tBSO2kKwL0UWraQ+Ld2nNLlub48P/niGXHribqZNtNu4mcjP6qEStJnY
	zZtMcXGXzbegoMhYUmuBfc1GyOGOi2x78MOaB0zqhHRg6eMnnWuPgEyuB3E7jT1bL1LVQ5cv1ZzlJ
	HGNC5LCA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suXFA-0000000CK65-2pEx;
	Sat, 28 Sep 2024 13:12:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DE801300848; Sat, 28 Sep 2024 15:12:16 +0200 (CEST)
Date: Sat, 28 Sep 2024 15:12:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 09/14] x86/ibt: Implement IBT+
Message-ID: <20240928131216.GB19439@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.283644921@infradead.org>
 <20240928010733.dxds5myhn7efgrh2@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928010733.dxds5myhn7efgrh2@treble>

On Fri, Sep 27, 2024 at 06:07:33PM -0700, Josh Poimboeuf wrote:
> On Fri, Sep 27, 2024 at 09:49:05PM +0200, Peter Zijlstra wrote:
> > +static void *translate_call_dest(void *dest, bool call)
> > +{
> > +	if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH)) {
> > +		if (!call)
> > +			return dest;
> 
> A tail call is considered a call by virtue of the function name.  Change
> the "call" arg to "tail" to make it clearer.

Sure.

> > +++ b/scripts/Makefile.lib
> > @@ -269,6 +269,7 @@ objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HA
> >  objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
> >  objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --direct-call
> >  objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
> > +objtool-args-$(CONFIG_X86_KERNEL_IBT_PLUS)		+= --direct-call
> 
> Only add '--direct-call' once:
> 
> objtool-args-$(or $(CONFIG_MITIGATION_CALL_DEPTH_TRACKING),$(CONFIG_X86_KERNEL_IBT_PLUS)) += --direct-call

Heh. I don't do enough Makefile to ever remember how they work :/

> >  objtool-args-$(CONFIG_FINEIBT)				+= --cfi
> >  objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
> >  ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
> 
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -1455,7 +1455,7 @@ static void annotate_call_site(struct ob
> >  		return;
> >  	}
> >  
> > -	if (!insn->sec->init && !insn->_call_dest->embedded_insn) {
> > +	if (!insn->_call_dest->embedded_insn) {
> 
> Why did we have the 'init' check to start with?  Presumably init memory
> gets freed after the call dest patching so this is not a problem?

Ah, all this came from the calldepth tracking stuff. And we didn't care
about init code, that runs before userspace and so RSB overflows aren't
much of a problem.

But with this here thing, we very much also want to patch the init code
to not land on an ENDBR that will be turned into a UD1 during init :-)

