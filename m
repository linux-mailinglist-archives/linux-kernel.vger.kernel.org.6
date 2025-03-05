Return-Path: <linux-kernel+bounces-547655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B2FA50C0D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21B5170958
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F07925524D;
	Wed,  5 Mar 2025 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UStecEah"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AC254B0F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204593; cv=none; b=gfpLXmEro/Z9YujfwvNC9lew6q69ggmesE2l+McofalCmTqHDK0gGI0PZA+aemp0tCKCZD2okYo4LyhpRvee3BG0Fw3tpakkb8VuM6gX97ogkr2SMpjJG/Ka6b8VUT8TGo1RMrUktXAnM/3L6yRpKUgGCh2AATjTntTlxj/gJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204593; c=relaxed/simple;
	bh=Nep3tJL6BrXYlWy57IpJmK6SN0PTS1VBS3f+7sHN0vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quhHuFZ/6TXzzm0aQor21qdX9QeO7kWa2tKbs+5+ZeNG4L3WNuzydP1NVOWwuZJ8Wlo9FLMQpqTYXgDx8DC5drQlOdrA5XeewAObOAGwDl1aYKYDORhV16KxRZDEOE6lvRUYWW3kljOjlUKaa5BfDLND90iMrLQXWOGDQDZIT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UStecEah; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741204591; x=1772740591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Nep3tJL6BrXYlWy57IpJmK6SN0PTS1VBS3f+7sHN0vk=;
  b=UStecEahDItOXhQ0m1o2xGXwkv4bNGj3d5ykA5lUL1ge86u2mE5Th9sz
   1lozLBwKeHAgCoKtof2/tfOL7cJCMJAUh0gc3uMv6Gb2o8EnWPUqq7UUK
   vpK0MWTxhU7bZYLjUtDrTGrIcIWGWhKG9sj5ccHWr1y7wy2aSdWycLdCH
   +UMCG304TgznGLPg/Co3kzmf2m/+Iyf1a0RXdAq7PMcKpehgSmUzMaYrD
   FAgupFpwzODIMW10UHFUrqrGcSrw6XujCNbC4ioKono90sWQmLhZ+gHpS
   +K8QhEy/3K2C1GBV0s1BLIho7pBsTZCwMloq6Ppz3e5lLxZ0bYj6DEcFD
   A==;
X-CSE-ConnectionGUID: h14bIP8+TY23BwjFkY2QKg==
X-CSE-MsgGUID: cvBu22J2Qmu5ZtjiZXqm5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41436457"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="41436457"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 11:56:29 -0800
X-CSE-ConnectionGUID: tbTGq/2UTQGeJg4DZynofw==
X-CSE-MsgGUID: qATdZ/gJTF+UImwecUB0Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="118588878"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 11:56:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpuqs-0000000HVsA-3StD;
	Wed, 05 Mar 2025 21:56:22 +0200
Date: Wed, 5 Mar 2025 21:56:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 4/8] bits: introduce fixed-type BIT
Message-ID: <Z8isZodEqhZw5p7-@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-4-1873dcdf6723@wanadoo.fr>
 <Z8hgqOB5Ym-GGykS@smile.fi.intel.com>
 <d7f3150d-0167-44be-90b2-17f8a050687c@wanadoo.fr>
 <Z8hyNXVZxLzhEzNy@smile.fi.intel.com>
 <824dc1d1-14f0-433e-aa3f-679527b87077@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <824dc1d1-14f0-433e-aa3f-679527b87077@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 02:17:18AM +0900, Vincent Mailhol wrote:
> On 06/03/2025 at 00:48, Andy Shevchenko wrote:
> > On Wed, Mar 05, 2025 at 11:48:10PM +0900, Vincent Mailhol wrote:
> >> On 05/03/2025 at 23:33, Andy Shevchenko wrote:
> >>> On Wed, Mar 05, 2025 at 10:00:16PM +0900, Vincent Mailhol via B4 Relay wrote:

...

> >>>> +#define BIT_U8(b) (BIT_INPUT_CHECK(u8, b) + (unsigned int)BIT(b))
> >>>> +#define BIT_U16(b) (BIT_INPUT_CHECK(u16, b) + (unsigned int)BIT(b))
> >>>
> >>> Why not u8 and u16? This inconsistency needs to be well justified.
> >>
> >> Because of the C integer promotion rules, if casted to u8 or u16, the
> >> expression will immediately become a signed integer as soon as it is get
> >> used. For example, if casted to u8
> >>
> >>   BIT_U8(0) + BIT_U8(1)
> >>
> >> would be a signed integer. And that may surprise people.
> > 
> > Yes, but wouldn't be better to put it more explicitly like
> > 
> > #define BIT_U8(b)	(BIT_INPUT_CHECK(u8, b) + (u8)BIT(b) + 0 + UL(0)) // + ULL(0) ?
> 
> OK, the final result would be unsigned. But, I do not follow how this is
> more explicit.
> 
> Also, why doing:
> 
>   (u8)BIT(b) + 0 + UL(0)
> 
> and not just:
> 
>   (u8)BIT(b) + UL(0)
> 
> ?
> 
> What is that intermediary '+ 0' for?
> 
> I am sorry, but I am having a hard time understanding how casting to u8
> and then doing an addition with an unsigned long is more explicit than
> directly doing a cast to the desired type.

Reading this again, I think we don't need it at all. u8, aka unsigned char,
will be promoted to int, but it will be int with a value < 256, can't be signed
as far as I understand this correctly.

> As I mentioned in my answer to Yuri, I have a slight preference for the
> unsigned int cast, but I am OK to go back to the u8/u16 cast as it was
> in v3.

Which means that the simples uXX castings should suffice. In any case we need
test cases for that.

> However, I really do not see how that '+ 0 + UL(0)' would be an improvement.
> 
> > Also, BIT_Uxx() gives different type at the end, shouldn't they all be promoted
> > to unsigned long long at the end? Probably it won't work in real assembly.
> > Can you add test cases which are written in assembly? (Yes, I understand that it will
> > be architecture dependent, but still.)
> 
> No. I purposely guarded the definition of the BIT_Uxx() by a
> 
>   #if !defined(__ASSEMBLY__)
> 
> so that these are never visible in assembly. I actually put a comment to
> explain why the GENMASK_U*() are not available in assembly. I can copy
> paste the same comment to explain why why BIT_U*() are not made
> available either:
> 
>   /*
>    * Missing asm support
>    *
>    * BIT_U*() depends on BITS_PER_TYPE() which would not work in the asm
>    * code as BITS_PER_TYPE() relies on sizeof(), something not available
>    * in asm.  Nethertheless, the concept of fixed width integers is a C
>    * thing which does not apply to assembly code.
>    */
> 
> I really believe that it would be a mistake to make the GENMASK_U*() or
> the BIT_U*() available to assembly.

Ah, okay then!

> >> David also pointed this in the v3:
> >>
> >> https://lore.kernel.org/intel-xe/d42dc197a15649e69d459362849a37f2@AcuMS.aculab.com/
> >>
> >> and I agree with his comment.

Why unsigned char won't work?

> >> I explained this in the changelog below the --- cutter, but it is
> >> probably better to make the explanation more visible. I will add a
> >> comment in the code to explain this.
> >>
> >>>> +#define BIT_U32(b) (BIT_INPUT_CHECK(u32, b) + (u32)BIT(b))
> >>>> +#define BIT_U64(b) (BIT_INPUT_CHECK(u64, b) + (u64)BIT_ULL(b))

-- 
With Best Regards,
Andy Shevchenko



