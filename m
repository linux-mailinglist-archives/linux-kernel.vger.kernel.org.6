Return-Path: <linux-kernel+bounces-567177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBBBA682E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4353BFA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDC42248B5;
	Wed, 19 Mar 2025 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgF+96mY"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275425760
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348826; cv=none; b=APhqWWy/+7LYGoIVcW7FNTQuoEVyHZ3hakNojrJ1xPsW2+NRKxkY8WlffgH3FOerzKbAAylBDlE6WHHi4ZLpVP9RF78dns9aijxGm0okNlgnrjyupf+tTBgyJt8ITokF1BgnP2cv23xpqftXa28fF0OA9Oo4rirS3kBV8DA/QXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348826; c=relaxed/simple;
	bh=WUn+uqBtiQdBXSN/byr8oh9OXjUezkQDIMTRjfxyawI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/nUJGYKCKcPIi5QlatTKQPN58/mXOn3RjRj4KTBVzmLexUaDuIhXNAPj8tmXCHPkAtJjugIAt0pcEwk7gmGgO9AJnNqGFWSpCrJMpOoNDcD8dLLxDIGgiqPPXwi7caIQC7R8MOwk38XPRwC48upY+Ex4t+vDac/tSV4NY92NNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgF+96mY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240b4de12bso28241365ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742348821; x=1742953621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQazujB/9yd1yOfFaq3YxlrN7+iuxbijBpN0gJtM4vU=;
        b=HgF+96mYYV/6hi3xvC9ie/oKhNOCqHz1ptmN4nwAUm1P/WqDVDUUz6DXpXk/SurvIE
         zdgr0ePdgAySlvB9kzcVxnJOJDmqrqxbRpxJbIVq7yGWuZhYirOs0DuRKlR6vMVPGs49
         90kPYOq/AL4p5HE3a4mrZlLSdOORagRlxYvHmvrCpJtaEIAYiSGly39FtnTW0/jjVv4i
         oJuw+VblPAOADWhMnkr9s2SbSJVAHmatHfyYCkW5lpJp4wDxKYikmzwFpct9svn050Pi
         tuilXAymEUUS+pmmS1tRLg88Gel8kMJrb6TlEfuiNq301VMDAnX5eqEqsk1iL8dOCKo2
         Iyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348821; x=1742953621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQazujB/9yd1yOfFaq3YxlrN7+iuxbijBpN0gJtM4vU=;
        b=KcIswH47vvVElkKmh8t75OizJ6h0EDyYEPp8aUT6xP2prmCDHCANMZJml0AiTAIGgM
         W2fHiDGniy5bKWGZ0O0707hULerOxtGbYEf9RttZga+MKpQTTLNwrF1++rqZRQLXd2u8
         fjlGE6+P3omUWZZKyQMZlLIB5z5REsfwf6mWs7adRr2e0d/W7NnBU4J0Ztfw3sjflkXX
         Vo6lCpd2jgFanSo2kxSbLXQL4awgfko3XiQQNRQ7II3b/uZuhqJKRkMbWG1BFNYMRIQf
         lC7pmYB7d3+NBZVG6G+2awKRik5RqAB0xfgXbwydcO61ZUs+KM3ooZgQXIsdoQygVIW1
         Qx9A==
X-Forwarded-Encrypted: i=1; AJvYcCUl1bAvP4A9H0t9RdVuKIA6Scy/VA+mTb8LHY6x8yh+pKM1QkWSt8XZbMLaQjPCZIqOVvRMdcGaeiHPAJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gF5GAgasc3rbT91ENEpyv1/649m9i+fLfer9RokoI8qWpLaL
	cCBlF9Ht3jM9sj9yC5q/pPEXB/dkkX4Z7aVd4UvZeAho8bkSy5RR
X-Gm-Gg: ASbGncs3IJNkP1UbhUAhlU52fHmtaO8yMN2gLdE1nsPk3BgMdGNdsEVgglHNuLSLscz
	vHz7SayrTbGuPtCbjymKDlPVgiGfOA7Jnx5Aj+o7yrrHu2WKATQTBRiN6aoeAwMBTHFKbwjo2PU
	Ove2fWZInpROhZcjOlOzoNVfvwnlSK2Yw7DFa/sht67mlgzZVgcYRhtKlNdIc4zIurzcBHtLYHq
	T/CL4pBInHSYn9Pi/6TJZwmJaTTUfEp7jgKB2SxuxAx0Hy6dwEIjYHhf34PcSdpjHOmfO+HmFck
	qLVo6Qi3GsUqrQ3QDvpMRFVRqunMuTuPjRNfp9mnmFr8uIHjhN4q5QFCFS5ojhHOKm5I
X-Google-Smtp-Source: AGHT+IF0XB8fhv1p95uLw69R18eSu0Lwf8G2N3t1RKmk5WXiiexOrAeRINEjNr/ltlJBTDEzGkPmkg==
X-Received: by 2002:a17:902:e803:b0:21f:74ec:1ff0 with SMTP id d9443c01a7336-22649a67f76mr13801815ad.32.1742348821049;
        Tue, 18 Mar 2025 18:47:01 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888486sm101601915ad.11.2025.03.18.18.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 18:47:00 -0700 (PDT)
Date: Tue, 18 Mar 2025 21:46:58 -0400
From: Yury Norov <yury.norov@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 3/8] bits: introduce fixed-type genmasks
Message-ID: <Z9oiEkQEcHhA0a80@thinkpad>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>
 <Z8hsRJvpjYoqh9RG@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8hsRJvpjYoqh9RG@thinkpad>

+ Catalin Marinas, ARM maillist

Hi Catalin and everyone,

Anshuman Khandual asked me to merge GENMASK_U128() saying it's
important for ARM to stabilize API. While it's a dead code, I
accepted his patch as he promised to add users shortly.

Now it's more than half a year since that. There's no users,
and no feedback from Anshuman.

Can you please tell if you still need the macro? I don't want to
undercut your development, but if you don't need 128-bit genmasks
there's no reason to have a dead code in the uapi.

Thanks,
Yury

On Wed, Mar 05, 2025 at 10:22:47AM -0500, Yury Norov wrote:
> + Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Anshuman,
> 
> I merged your GENMASK_U128() because you said it's important for your
> projects, and that it will get used in the kernel soon.
> 
> Now it's in the kernel for more than 6 month, but no users were added.
> Can you clarify if you still need it, and if so why it's not used?
> 
> As you see, people add another fixed-types GENMASK() macros, and their
> implementation differ from GENMASK_U128().
> 
> My second concern is that __GENMASK_U128() is declared in uapi, while
> the general understanding for other fixed-type genmasks is that they
> are not exported to users. Do you need this macro to be exported to
> userspace? Can you show how and where it is used there?
> 
> Thanks,
> Yury
> 
> 
> On Wed, Mar 05, 2025 at 10:00:15PM +0900, Vincent Mailhol via B4 Relay wrote:
> > From: Yury Norov <yury.norov@gmail.com>
> > 
> > Add __GENMASK_t() which generalizes __GENMASK() to support different
> > types, and implement fixed-types versions of GENMASK() based on it.
> > The fixed-type version allows more strict checks to the min/max values
> > accepted, which is useful for defining registers like implemented by
> > i915 and xe drivers with their REG_GENMASK*() macros.
> > 
> > The strict checks rely on shift-count-overflow compiler check to fail
> > the build if a number outside of the range allowed is passed.
> > Example:
> > 
> > 	#define FOO_MASK GENMASK_U32(33, 4)
> > 
> > will generate a warning like:
> > 
> > 	../include/linux/bits.h:41:31: error: left shift count >= width of type [-Werror=shift-count-overflow]
> > 	   41 |          (((t)~0ULL - ((t)(1) << (l)) + 1) & \
> > 	      |                               ^~
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > Changelog:
> > 
> >   v3 -> v4:
> > 
> >     - The v3 is one year old. Meanwhile people started using
> >       __GENMASK() directly. So instead of generalizing __GENMASK() to
> >       support different types, add a new GENMASK_t().
> > 
> >     - replace ~0ULL by ~_ULL(0). Otherwise, __GENMASK_t() would fail
> >       in asm code.
> > 
> >     - Make GENMASK_U8() and GENMASK_U16() return an unsigned int. In
> >       v3, due to the integer promotion rules, these were returning a
> >       signed integer. By casting these to unsigned int, at least the
> >       signedness is kept.
> > ---
> >  include/linux/bitops.h |  1 -
> >  include/linux/bits.h   | 33 +++++++++++++++++++++++++++++----
> >  2 files changed, 29 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index c1cb53cf2f0f8662ed3e324578f74330e63f935d..9be2d50da09a417966b3d11c84092bb2f4cd0bef 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -8,7 +8,6 @@
> >  
> >  #include <uapi/linux/kernel.h>
> >  
> > -#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
> >  #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
> >  #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
> >  #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 5f68980a1b98d771426872c74d7b5c0f79e5e802..f202e46d2f4b7899c16d975120f3fa3ae41556ae 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -12,6 +12,7 @@
> >  #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
> >  #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
> >  #define BITS_PER_BYTE		8
> > +#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
> >  
> >  /*
> >   * Create a contiguous bitmask starting at bit position @l and ending at
> > @@ -25,14 +26,38 @@
> >  
> >  #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
> >  
> > -#define GENMASK(h, l) \
> > -	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > -#define GENMASK_ULL(h, l) \
> > -	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> > +/*
> > + * Generate a mask for the specified type @t. Additional checks are made to
> > + * guarantee the value returned fits in that type, relying on
> > + * shift-count-overflow compiler check to detect incompatible arguments.
> > + * For example, all these create build errors or warnings:
> > + *
> > + * - GENMASK(15, 20): wrong argument order
> > + * - GENMASK(72, 15): doesn't fit unsigned long
> > + * - GENMASK_U32(33, 15): doesn't fit in a u32
> > + */
> > +#define GENMASK_t(t, h, l)				\
> > +	(GENMASK_INPUT_CHECK(h, l) +			\
> > +	 (((t)~ULL(0) - ((t)1 << (l)) + 1) &		\
> > +	  ((t)~ULL(0) >> (BITS_PER_TYPE(t) - 1 - (h)))))
> > +
> > +#define GENMASK(h, l) GENMASK_t(unsigned long,  h, l)
> > +#define GENMASK_ULL(h, l) GENMASK_t(unsigned long long, h, l)
> >  
> >  /*
> >   * Missing asm support
> >   *
> > + * __GENMASK_U*() depends on BITS_PER_TYPE() which would not work in the asm
> > + * code as BITS_PER_TYPE() relies on sizeof(), something not available in
> > + * asm. Nethertheless, the concept of fixed width integers is a C thing which
> > + * does not apply to assembly code.
> > + */
> > +#define GENMASK_U8(h, l) ((unsigned int)GENMASK_t(u8,  h, l))
> > +#define GENMASK_U16(h, l) ((unsigned int)GENMASK_t(u16, h, l))
> > +#define GENMASK_U32(h, l) GENMASK_t(u32, h, l)
> > +#define GENMASK_U64(h, l) GENMASK_t(u64, h, l)
> > +
> > +/*
> >   * __GENMASK_U128() depends on _BIT128() which would not work
> >   * in the asm code, as it shifts an 'unsigned __int128' data
> >   * type instead of direct representation of 128 bit constants
> > 
> > -- 
> > 2.45.3
> > 

