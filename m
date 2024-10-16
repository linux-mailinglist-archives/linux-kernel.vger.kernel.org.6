Return-Path: <linux-kernel+bounces-368618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638EC9A1265
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0ED286149
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ED42139D1;
	Wed, 16 Oct 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s+AE5uFV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD818B481;
	Wed, 16 Oct 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106430; cv=none; b=SYQyiiaEWDYMRO+bu3b3+UU6r54trKY+CHOUSBcZ6jQWiAxVxRoppnlcxXeDIe1pY38O93exvSWH+yeGcUmzfvoHGbD+jUc3MyfZvf1yrmCRVud+e6gkKvICJ5OjTF0Xk6aTl5q7jtdYNizJ8tNfLOPD86MeHWHJDtIGvghoKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106430; c=relaxed/simple;
	bh=zy2vnCmqC5q8dP1XS7bM49+n95NVXsGGxJQUl+m54Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgcrNH1zK6Zjvfxq7k7LV0bpRIVAz5Nrro8pGiw9oW80EeTB+iZ1FHZBMztKnML/qgziDGvlXiZBnNeyZk8i+H21TtK73zQoKBKkSa8sR0eazBcaH8qiPsIwDTn7KsSydranQW8JZimvO7OpsQnwHnGlDk+WATzk/nzxC9foTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s+AE5uFV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r2FMoZv7GZi36tQ4QRe51XXDDSE6b5fb9oopiYGqumo=; b=s+AE5uFVm06tAz5ZjzacGLzCuJ
	7YUtR0tG2I+4egdsgithCbAgd3zsLGdV8yCaIEjKbeBgV87U71Ofh39b9aSu8hDRqf14HqKd1KZrE
	vmWv06vwCWlEgqjpQ+ZysBpfND0RsjWHsYjxoX2/jifAMK6emeUb3AsW0FZQDmp0/MKAGPRdjCnY5
	RmYUt/FDwOnzXNlD8SZxhtVXakkE+zrsYTk0T1kambUxLcvA2qKy2rZrvA8PGSBG4PhbxYIXWkMjV
	10fV2Vuop+Bhe86fVueT9fbwJpx3ofurJWTW93Llo69b3bU2QYK8Fp0OeyG1jG4ijS2kmShyFtPkn
	wvn5DgSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t19Z6-00000008naR-10Hi;
	Wed, 16 Oct 2024 19:20:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE99B300777; Wed, 16 Oct 2024 21:20:11 +0200 (CEST)
Date: Wed, 16 Oct 2024 21:20:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] x86/percpu: Cast -1 to argument type when
 comparing in percpu_add_op()
Message-ID: <20241016192011.GY17263@noisy.programming.kicks-ass.net>
References: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com>
 <f02e0624-ad4f-473c-b172-6dadea37f600@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02e0624-ad4f-473c-b172-6dadea37f600@intel.com>

On Wed, Oct 16, 2024 at 08:44:56AM -0700, Dave Hansen wrote:
> Andy,
> 
> The subject here is not very informative.  It explains the "what" of the
> patch, but not the "why".
> 
> A better subject might have been:
> 
> 	x86/percpu: Fix clang warning when dealing with unsigned types
> 
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -234,9 +234,10 @@ do {									\
> >   */
> >  #define percpu_add_op(size, qual, var, val)				\
> >  do {									\
> > -	const int pao_ID__ = (__builtin_constant_p(val) &&		\
> > -			      ((val) == 1 || (val) == -1)) ?		\
> > -				(int)(val) : 0;				\
> > +	const int pao_ID__ =						\
> > +		(__builtin_constant_p(val) &&				\
> > +			((val) == 1 ||					\
> > +			 (val) == (typeof(val))-1)) ? (int)(val) : 0;	\
> 
> This doesn't _look_ right.
> 
> Let's assume 'val' is a u8.  (u8)-1 is 255, right?  So casting the -1
> over to a u8 actually changed its value.  So the comparison that you
> added would actually trigger for 255:
> 
> 	(val) == (typeof(val))-1))
> 
> 	255 == (u8)-1
> 	255 == 255

Which is correct, no? Add of 255 to an u8 is the same as decrement one.

> That's not the end of the world because the pao_ID__ still ends up at
> 255 and the lower if() falls into the "add" bucket, but it isn't great
> for reading the macro.  It seems like it basically works on accident.

You're correct in that it does not achieve the desired result (in all
cases). But this is because (int)(val) will never turn into -1 when val
== 255.

> Wouldn't casting 'val' over to an int be shorter, more readable, not
> have that logical false match *and* line up with the cast later on in
> the expression?
> 
>         const int pao_ID__ = (__builtin_constant_p(val) &&
>                               ((val) == 1 || (int)(val) == -1)) ?
> 
>                                 (int)(val) : 0;
> 
> Other suggestions to make it more readable would be welcome.

This is very very wrong. No u8 value when cast to int will ever equal
-1. Notably (int)(u8)255 == 255.

> Since I'm making comments, I would have really appreciated some extra
> info here like why you are hitting this and nobody else is.  This is bog
> standard code that everybody compiles.  Is clang use _that_ unusual?  Or
> do most clang users just ignore all the warnings?  Or are you using a
> bleeding edge version of clang that spits out new warnings that other
> clang users aren't seeing?

The code as is, is wrong, I don't think we'll ever end up in the dec
case for 'short' unsigned types. Clang is just clever enough to realize
this and issues a warning.

Something like so might work:

	const int pao_ID__ = __builtin_constant_p(val) ?
				((typeof(var))(val) == 1 ? 1 :
				 ((typeof(var))(val) == (typeof(var))-1 ? -1 : 0 )) : 0;

This should get, assuming typeof(var) is u8, a dec for both 255 and -1.



