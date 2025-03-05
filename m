Return-Path: <linux-kernel+bounces-547171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E4A503C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414483ABFE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7781324E014;
	Wed,  5 Mar 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIE1ljdQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C526AF3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189695; cv=none; b=idvlKGxFzOCVtY33QDiZCmSqhlKsXfsve5p7J+MJxExARFsWzLiLgvCOzrHRkDH8b3NjwnK8S22AHttO11jLQZ3+i1ki1ZufRlMfjBm/mb/pxuzMIDgr6PiZlpo/2jLOxnEgblsjGGUALhMlXSfBAo9Te5DwIeEQ6jlknBNdXwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189695; c=relaxed/simple;
	bh=PYXpyrvj59Rr+s6Viq0NdMfzWxntWWdSb5icZCvFr1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAGx8Q2mVoAeWsaHBrpw6KmcvfJFqXeieOK/W7DkGrHsOS55PUi9XSPmjM6vz4V1Vl/T1Lx8nGp5pbbfTejdmVFbyS2S6ni/4/bieLfsTk76CtDtDM3gVDL6CuiR3+rtlEfT9rSKj9bkAdCXORS5Id4l/qQAQOUy0sr6FYD7pFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIE1ljdQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741189694; x=1772725694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PYXpyrvj59Rr+s6Viq0NdMfzWxntWWdSb5icZCvFr1k=;
  b=WIE1ljdQ72ncI9+gdVL2VB2AB4dfzlDGIUpwYPdFre6BHzoHDo/lOLQu
   cQnHhZaOchOutjvEO9ykw6yjKCFYNCKq/Io0AprsPvB9YeS6uwlqNvkFB
   NUFKfl9hBJLGEu3KuqghdqvClGtvfcwEhRS+JrYivSpnJ9XEFFlTrz050
   MKXZtVCjiEqRIS9EnZMWWBCzDTi71+4Sd5QJb/z+pBpe4YF8wiCD44WAl
   UsXu8GMOyAvt9dkzELywaZGelkllOV8pfrR8un5yyXw0IBomhRd5B67lj
   joYeagSjWyWrmyDZ7+AAPsjQbgtOYJvkAjBOaT4ZBEmVTboCluO7TyfF1
   A==;
X-CSE-ConnectionGUID: P4uio14lQT6E3oSN2fUyzw==
X-CSE-MsgGUID: 04GC0HzQRP2vM9q7ZQ7n2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59703950"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="59703950"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:48:13 -0800
X-CSE-ConnectionGUID: pWMuf/kOQ0ynRaGTKOE2Rg==
X-CSE-MsgGUID: A6V0KezpQMaHNoqhGG1fQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118647762"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:48:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpqyb-0000000HSFo-2v5I;
	Wed, 05 Mar 2025 17:48:05 +0200
Date: Wed, 5 Mar 2025 17:48:05 +0200
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
Message-ID: <Z8hyNXVZxLzhEzNy@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-4-1873dcdf6723@wanadoo.fr>
 <Z8hgqOB5Ym-GGykS@smile.fi.intel.com>
 <d7f3150d-0167-44be-90b2-17f8a050687c@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f3150d-0167-44be-90b2-17f8a050687c@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 05, 2025 at 11:48:10PM +0900, Vincent Mailhol wrote:
> On 05/03/2025 at 23:33, Andy Shevchenko wrote:
> > On Wed, Mar 05, 2025 at 10:00:16PM +0900, Vincent Mailhol via B4 Relay wrote:

...

> >> +#define BIT_U8(b) (BIT_INPUT_CHECK(u8, b) + (unsigned int)BIT(b))
> >> +#define BIT_U16(b) (BIT_INPUT_CHECK(u16, b) + (unsigned int)BIT(b))
> > 
> > Why not u8 and u16? This inconsistency needs to be well justified.
> 
> Because of the C integer promotion rules, if casted to u8 or u16, the
> expression will immediately become a signed integer as soon as it is get
> used. For example, if casted to u8
> 
>   BIT_U8(0) + BIT_U8(1)
> 
> would be a signed integer. And that may surprise people.

Yes, but wouldn't be better to put it more explicitly like

#define BIT_U8(b)	(BIT_INPUT_CHECK(u8, b) + (u8)BIT(b) + 0 + UL(0)) // + ULL(0) ?

Also, BIT_Uxx() gives different type at the end, shouldn't they all be promoted
to unsigned long long at the end? Probably it won't work in real assembly.
Can you add test cases which are written in assembly? (Yes, I understand that it will
be architecture dependent, but still.)

> David also pointed this in the v3:
> 
> https://lore.kernel.org/intel-xe/d42dc197a15649e69d459362849a37f2@AcuMS.aculab.com/
> 
> and I agree with his comment.
> 
> I explained this in the changelog below the --- cutter, but it is
> probably better to make the explanation more visible. I will add a
> comment in the code to explain this.
> 
> >> +#define BIT_U32(b) (BIT_INPUT_CHECK(u32, b) + (u32)BIT(b))
> >> +#define BIT_U64(b) (BIT_INPUT_CHECK(u64, b) + (u64)BIT_ULL(b))

-- 
With Best Regards,
Andy Shevchenko



