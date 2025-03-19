Return-Path: <linux-kernel+bounces-568070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7411A68DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DF33B46F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6583596B;
	Wed, 19 Mar 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm+M2dUB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D592561DC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390760; cv=none; b=i1jNZ5gtf6GF/fPCrFZSbTOpFRrmjcM58JrfpGUEumf50BL+SCVPUOzws+j238us96wLExImLHNHSdgG7ta7rl7sowUeS7IrNYxpEM1CsAzFW8/4cmI26/mI9oEnCQ/ugOL6f/tTRMA0rkHFUAbDrqlS9DKwRzGLUhJubR0LUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390760; c=relaxed/simple;
	bh=nurajP56Gra0rBZyyB7PMebSTUQhaORaB/xeCqH9uSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty//tOVs2TUTTfYEkHqeFoUOvZifku+C/dxGaOHgrZvf3pLelVd2LQagx3iEhp1Ov5uD6v68JBadHHkmBtZh8kzGZp/uqWiT5RI8Z/6PlLSq5pfh9kwFWRu9IauB4wEo6kg7mqp3ZFxx+2RMa32uLXb3g0iIJd1hGNUxF4WpviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm+M2dUB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-226185948ffso65702505ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742390759; x=1742995559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nV8V6naseGogksjahvS3uLXhTv8c4v5cDCu9vdP9cg=;
        b=Hm+M2dUB0UGGpE2T49bXH7Vp/nMghHlXpwCUo79ToNoe8WED84yC7s46YhKDD9SFnk
         OFxSeMQQKeAi5AeeIlfsd6Zn4vvqno3dUi9IUs4tKYOjWui1gZFjsqORVKmhrtpBT4iG
         zxY/52ZTyi/g8T0NDNTtpKZqSj+t2t8tJe4e0XTqFoepdQPtNoOkoDyig9BaCzlP2QzC
         lZVDpOkkIJWOB5czcPZMiYXPXVmb1Zri5K/kdREW6MF2A0InEFPW3rBZOpoCzdrfmYfE
         wdCwh8LL2WThbBKI8Xc857GUdaBkEU3qXjLiC93dZ84W8y9qn77s2Jo3eZB7ZJio7QD0
         bfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390759; x=1742995559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nV8V6naseGogksjahvS3uLXhTv8c4v5cDCu9vdP9cg=;
        b=BIxMOr8mlnY6QU7k4DgoiKvlh+yOJNg68lIwUimqCS+Cmah5sx3gpl1m2VuLMPlN0e
         qadQ8WWJw+K36zGTAxljnE8gztOSkmwv5yvvweM8lvI9kduzeFe4dRpeIO18pixw1vhW
         F5ZGE/t1A7YOrXZcfAsi5kRUA4Ofxi3dkxS+O22+w1v54CiuteA+jkaxL8bGolTkJ67O
         JdLaDwM6+nF1TAKFSXKByp8iwYiR+TlE1npu+dnc3UELnUaw7iBfnI5kJ2aKGFfDQdSG
         tCg79+G/Ol0hWSn0agfxGFY6KbmHr2iQURW/k27gMwW5KG7sH4elDCIm8ieUdbd/AfHB
         tpKA==
X-Forwarded-Encrypted: i=1; AJvYcCWXxrM1czlxQjOrWzZEEzCVsdjrDlG//Gz9oDiAkp4nv2xiXhbGX9ca2FgLZzWgQmQ88d9zOk8iSM7Lq7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHfP+lVuuWSa7IG/tLdDp/Gh4chOxiDbyO5Q+3RUP1nWpxA7JE
	meCXGw+kTvlOBTwteEkIq7Uf9UQf6PtIB+s6hQtgp2eL8TsQ2rlr
X-Gm-Gg: ASbGncuP7LTHRoAhl4MlbwWUujhX5Emd+s04vWQoXxci86ZY8PWQcWj2JHN4wdZMRBC
	nYXms+TNBIUCUemhesmJru4ow3Q/ArmbydiVSe2fb48H/7Euf6s7Hu9VI45RjS8+UZuhgpbTgZL
	qhqAjKRR4swhAbOaRkTkcfukt1ctOOTVFwhOqEtNQd8v2LenSgkFszIThZ1+Egd6iZAJNdRTk+e
	L6zFVXTDRgjuxNj6gnzgt6Wfor55KWHjTkbzqzdy5ov/7G/YurjXCvDGOlWML9yLM2dgTohmcHd
	Ir2/82IRl8wn4ybp4dTwk9cKTgt9lYBNn9QFEX1cn37EouID7NLulr7yWpoU5mLeFyAd
X-Google-Smtp-Source: AGHT+IFV2ihVKDX+XILsEqqrYfSi5Q031FRnJSnqfNW/LjeoWGfZnrGB6aQNMBwZdy8dsB7j8Hx6PQ==
X-Received: by 2002:a05:6a20:2d0c:b0:1f0:e706:1370 with SMTP id adf61e73a8af0-1fbed7f0e92mr5249359637.35.1742390758515;
        Wed, 19 Mar 2025 06:25:58 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115293f6sm11928000b3a.14.2025.03.19.06.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 06:25:57 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:25:56 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 4/7] drm/i915: Convert REG_GENMASK*() to fixed-width
 GENMASK_U*()
Message-ID: <Z9rF5JFcEW2DOtcr@thinkpad>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-4-f59315e73c29@wanadoo.fr>
 <Z9mqUZX4H-CzqbW4@thinkpad>
 <87ldt2c6lz.fsf@intel.com>
 <f6885fdb-4361-428c-b6dd-54cd2ac7904d@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6885fdb-4361-428c-b6dd-54cd2ac7904d@wanadoo.fr>

On Wed, Mar 19, 2025 at 01:37:32PM +0900, Vincent Mailhol wrote:
> On 19/03/2025 at 07:32, Jani Nikula wrote:
> > On Tue, 18 Mar 2025, Yury Norov <yury.norov@gmail.com> wrote:
> >> On Sat, Mar 08, 2025 at 01:48:51AM +0900, Vincent Mailhol via B4 Relay wrote:
> >>> From: Lucas De Marchi <lucas.demarchi@intel.com>
> >>>
> >>> Now that include/linux/bits.h implements fixed-width GENMASK_U*(), use
> >>> them to implement the i915/xe specific macros. Converting each driver
> >>> to use the generic macros are left for later, when/if other
> >>> driver-specific macros are also generalized.
> >>>
> >>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> >>> Acked-by: Jani Nikula <jani.nikula@intel.com>
> >>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>> ---
> >>> Changelog:
> >>>
> >>>   v5 -> v6:
> >>>
> >>>     - No changes.
> >>>
> >>>   v4 -> v5:
> >>>
> >>>     - Add braket to macro names in patch description,
> >>>       e.g. 'REG_GENMASK*' -> 'REG_GENMASK*()'
> >>>
> >>>   v3 -> v4:
> >>>
> >>>     - Remove the prefixes in macro parameters,
> >>>       e.g. 'REG_GENMASK(__high, __low)' -> 'REG_GENMASK(high, low)'
> >>> ---
> >>>  drivers/gpu/drm/i915/i915_reg_defs.h | 108 ++++-------------------------------
> >>>  1 file changed, 11 insertions(+), 97 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/i915/i915_reg_defs.h b/drivers/gpu/drm/i915/i915_reg_defs.h
> >>> index e251bcc0c89f5710125bc70f07851b2cb978c89c..39e5ed9511174b8757b9201bff735fa362651b34 100644
> >>> --- a/drivers/gpu/drm/i915/i915_reg_defs.h
> >>> +++ b/drivers/gpu/drm/i915/i915_reg_defs.h
> >>> @@ -9,76 +9,19 @@
> >>>  #include <linux/bitfield.h>
> >>>  #include <linux/bits.h>
> >>>  
> >>> -/**
> >>> - * REG_BIT() - Prepare a u32 bit value
> >>> - * @__n: 0-based bit number
> >>> - *
> >>> - * Local wrapper for BIT() to force u32, with compile time checks.
> >>> - *
> >>> - * @return: Value with bit @__n set.
> >>> +/*
> >>> + * Wrappers over the generic BIT_* and GENMASK_* implementations,
> >>> + * for compatibility reasons with previous implementation
> >>>   */
> >>> -#define REG_BIT(__n)							\
> >>> -	((u32)(BIT(__n) +						\
> >>> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&		\
> >>> -				 ((__n) < 0 || (__n) > 31))))
> >>> +#define REG_GENMASK(high, low)		GENMASK_U32(high, low)
> >>> +#define REG_GENMASK64(high, low)	GENMASK_U64(high, low)
> >>> +#define REG_GENMASK16(high, low)	GENMASK_U16(high, low)
> >>> +#define REG_GENMASK8(high, low)		GENMASK_U8(high, low)
> >>
> >> Nit. Maybe just
> >>
> >>  #define REG_GENMASK		GENMASK_U32
> > 
> > Please just keep it as it is for clarity.
> 
> I also prefer when the argument is clearly displayed. It shows at first
> glance that this is a function-like macro and reminds of the correct
> order of the argument without having to look at the definitions in
> bits.h. It also allows for people to grep "#define REG_GENMASK(" in
> order to find the macro definition.
> 
> To be honest, I don't have a strong opinion either, but because Jani
> also prefers it this way, I will keep as-is.

Please go with the original version. It was just a minor nitpick.

