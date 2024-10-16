Return-Path: <linux-kernel+bounces-368550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055069A1139
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CD31F26CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01820F5C0;
	Wed, 16 Oct 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXPrpEvh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F518A6AA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101982; cv=none; b=c5wFbD3ZXAQX1Olb1jHmjGw4Mu/EabIxnmI7eWJQg8gdcckv+ti1Axl3ELMbYCcoDbDotVMRhczZc5VXQjtoMdsusG0iEsKyq7kGL5iU3VbTQb8FPAUg0gGByX/Kvn/EynVG9TMF7oGP1emr0+5/O3sdT3LWea5Udc7oyN59tNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101982; c=relaxed/simple;
	bh=w6TvOZ8DUKkyB3QMeexFvF0T7Chl1fSWJvxGf79kMr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSt778arcsL0d46lFMpK9IsekNPh9zf2rrGwiJKusTd9kZkGRdqcpWZ0Z3dZ9pud8OnK4ArQaX75IcVhtbN6TjcZpvAukDhYXq1PnqkV7mCocf0UB/z7d39W2qXSikk0uleEALEStCPUwCWOKaU98OdGT5byjBnLkTkZKB0SjmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXPrpEvh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729101981; x=1760637981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w6TvOZ8DUKkyB3QMeexFvF0T7Chl1fSWJvxGf79kMr0=;
  b=EXPrpEvhHXM5gGqkMZj8DRL5rhQS8Ra9tmFSOe8DR4tm84ViVsyNo/Vz
   bRiTpFw6rpZQq5Dl1CKbgfHP4YlOjHkPK5JDQiFjUJXefVk8HqRMem1Ni
   3tT4v9lD1liEot+rxvlvLIMm2tQWDuix/UUVRs09PNUro2i5CzNC/ng0G
   O9mwGxEMTnEOP0AT5p3T90nftTHpCeKRd29C1cO/N1ImojE2ypM2nk3JL
   tiwtRvKo7qaw19MvsoC2E0BzlACES0G0TkZ8rlrmdogrbBO1BDIE4OgYg
   EyzR+oib6JZZWYF31LTgcci51p4gD96wfoKjud+aVRty6TBh0ois5rgkI
   A==;
X-CSE-ConnectionGUID: /PZTN7RySAylUR2dzLj95w==
X-CSE-MsgGUID: tEA1ygWbTmemV9w04CacQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28451272"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28451272"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:06:20 -0700
X-CSE-ConnectionGUID: kcO4ws1BQNecWp2AlLE9KQ==
X-CSE-MsgGUID: p1h4AFT5TFy1O02nh+y4Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="83070346"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:06:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t18PV-00000003rcY-0FHZ;
	Wed, 16 Oct 2024 21:06:13 +0300
Date: Wed, 16 Oct 2024 21:06:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
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
Message-ID: <ZxAAlEyvxzWpwQQ0@smile.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 16, 2024 at 08:44:56AM -0700, Dave Hansen wrote:
> Andy,
> 
> The subject here is not very informative.  It explains the "what" of the
> patch, but not the "why".
> 
> A better subject might have been:
> 
> 	x86/percpu: Fix clang warning when dealing with unsigned types

Thanks, makes sense!

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

But if feels right if we really want to supply unsigned types here.
Maybe some more magic is needed (like in min() case).

> Let's assume 'val' is a u8.  (u8)-1 is 255, right?  So casting the -1
> over to a u8 actually changed its value.  So the comparison that you
> added would actually trigger for 255:
> 
> 	(val) == (typeof(val))-1))
> 
> 	255 == (u8)-1
> 	255 == 255
> 
> That's not the end of the world because the pao_ID__ still ends up at
> 255 and the lower if() falls into the "add" bucket, but it isn't great
> for reading the macro.  It seems like it basically works on accident.

> Wouldn't casting 'val' over to an int be shorter, more readable, not
> have that logical false match *and* line up with the cast later on in
> the expression?

Maybe more readable, but wouldn't it be theoretically buggy for u64?
I'm talking about the case when u64 == UINT_MAX, which will be true
in your case and false in mine.

>         const int pao_ID__ = (__builtin_constant_p(val) &&
>                               ((val) == 1 || (int)(val) == -1)) ?
> 
>                                 (int)(val) : 0;
> 
> Other suggestions to make it more readable would be welcome.
> 
> Since I'm making comments, I would have really appreciated some extra
> info here like why you are hitting this and nobody else is.  This is bog
> standard code that everybody compiles.  Is clang use _that_ unusual?

Why are you asking me about this? I don't know...

> Or do most clang users just ignore all the warnings?

Same here. I don't know...

Both Qs sounds rhetorical to me.

> Or are you using a bleeding edge version of clang that spits out new warnings
> that other clang users aren't seeing?

AFAICT It's *not* even close to the bleeding edge. It's standard Debian supply.

> Another nice thing would have been to say that this produces the exact
> same code with and without the patch.  Or that you had tested it in
> *some* way.

I have run percpu_test in both cases and also checked code with `bloat-o-meter`
and `cmp -b`. Everything is the same. I even added a test case for the above
mentioned situation.

> It took me a couple of minutes to convince myself that your
> version works and doesn't do something silly like a "dec" if you hand in
> val==255.

It took me much more to find the best solution that appears
not everyone likes :-)

P.S. And as Nick pointed out it's simple `make W=1`,
     what the additional information you wanna see here?
     Care to provide a template?

-- 
With Best Regards,
Andy Shevchenko



