Return-Path: <linux-kernel+bounces-354660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D8C9940A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8664B252A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8692E206967;
	Tue,  8 Oct 2024 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nF32kqlP"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A620607F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372310; cv=none; b=jBk2dMUv79hoL88sL5GACp5ItGAhLdKBDQEj/1gWJ1S40kSm0RH8DyPm0561G+VIr614Zi9iAKTyeU1cb2r3gzNkQFMD/zI1z8gbD4Lm2f+T3/3qFz11C/hshWfCvNInL7Sj7Ke5/f5ovz1V8oIXHNcdwC9dxECDfPsSSfRX6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372310; c=relaxed/simple;
	bh=dQrPibP+7L6SLFDyd4VzqD43IY6BT7dbsyfsq+AE6ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCWQ5pQYKFH/cbyv+jMa/B6D60ccpfSMgHQW1hMzCorA9F1XuHpnp6mGG0cUJvZ4mpEG99nXtFVl1scriEnw/f/kCDyaIVd07X9n/mqMtPSHcePcj9Bevx4W9Hgw26iW0cv7lz3gPxhaqilR2bpxPWkTx3mVHgQ4ufnr49ZQ5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nF32kqlP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=peqKieM5fVCLy4Db0Grs9YzrvovudXSYe1GPeAJBBws=; b=nF32kqlPPUD3IbqP8nnqsROt4I
	slJ2QBvL7JxG0tYfF0GML66UoKXER+UjxKkfl1IYKPQ9Vti/uKKXS7qSXKOwEL/S4tBIkRMzTMaLv
	MPzC9OS4LyngjlN43YLu5WOHqTajen/PSR/zMqzVpbtmNIz2Exuc5j08JcnUl6oTKp41v6tUZrVHd
	sHXODHCMOPoTI1RPsX1EVHJACHBb/w5Gjl3RUZ1DMxeONPePVfmVy0NKnNOGVACE1eHi6qMJsJx6m
	Ix4TsAY9m0wPlD81eN0mWmfWCTht2JyHd780fB//CXhOjR8tKTpaVMFYNw44owFQHGQ7RRbJnskJ3
	Fnjb8ksA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4ad-00000004YeZ-2qDw;
	Tue, 08 Oct 2024 07:25:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98165300599; Tue,  8 Oct 2024 09:25:02 +0200 (CEST)
Date: Tue, 8 Oct 2024 09:25:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bp@alien8.de, david.kaplan@amd.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC][PATCH 2/2] x86: Clean up default rethunk warning
Message-ID: <20241008072502.GC14587@noisy.programming.kicks-ass.net>
References: <20241007083210.043925135@infradead.org>
 <20241007083844.119369498@infradead.org>
 <20241007173345.yokak3mlnqpsuxty@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007173345.yokak3mlnqpsuxty@treble>

On Mon, Oct 07, 2024 at 10:33:45AM -0700, Josh Poimboeuf wrote:
> On Mon, Oct 07, 2024 at 10:32:12AM +0200, Peter Zijlstra wrote:
> > Replace the funny __warn_thunk thing with a more regular
> > WARN_ON_ONCE(), and simplify the ifdeffery.
> > 
> > Notably this avoids RET from having recursive RETs (once from the
> > thunk and once from the C function) -- recursive RET makes my head
> > hurt for no good reason.
> 
> This could use an explanation for why the ifdefs can be removed and why
> the alternative can be removed.

The alternative is in the WARN_ONCE now.

> > +#define WARN_ONCE							\
> > +	1: ALTERNATIVE "", "ud2", X86_FEATURE_ALWAYS ;			\
> > +	ASM_BUGTABLE_FLAGS(1b, 0, 0, BUGFLAG_WARNING | BUGFLAG_ONCE) ;	\
> > +	REACHABLE
> 
> Can we not use __FILE__ and __LINE__ here?  

Because for asm, __FILE__ is spelled like:

#ifdef CONFIG_DEBUG_BUGVERBOSE
.pushsection .rodata.str1.1, "aMS",@progbits,1
.LC0:
	.string __FILE__
.popsection
#endif
	1: ALTERNATIVE "", "ud2", X86_FEATURE_ALWAYS
	ASM_BUGTABLE_FLAGS(1b, LC0b, __LINE__, BUGFLAG_WARNING | BUGFLAG_ONCE)
	REACHABLE

And I didn't feel the whole thing was worth the trouble, if NULL bug
will only print the symbol name and that should be clear enough.

> Also why not put this in asm/bug.h?

Because the ALTERNATIVE..

> >  SYM_CODE_START(__x86_return_thunk)
> >  	UNWIND_HINT_FUNC
> >  	ANNOTATE_NOENDBR
> > -#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
> > -    defined(CONFIG_MITIGATION_SRSO) || \
> > -    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
> > -	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
> > -		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
> > -#else
> > +
> > +#ifdef CONFIG_X86_64
> > +	WARN_ONCE
> > +#endif
> 
> Isn't this return thunk used before apply_returns()?  How does that not
> trigger the warning?

You missed the ALTERNATIVE I squirreled away in the WARN thing :-)

