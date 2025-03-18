Return-Path: <linux-kernel+bounces-566631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F5A67A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC5916A9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B3212D84;
	Tue, 18 Mar 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQZwKIaN"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B0212B17
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318168; cv=none; b=sIcUv4QyVNkx8fehUUmDsyycupx/3wH7AYkpm4qJQUJ1MebkT54j8d3+Brt8vM2tno1SY/Gz8WpZpGg7SMTxQIiA2njmZO8GsmocRsXtnX89tN50ukUqmZNtY+xacWOxRYoipaavwlr+X/KHRQUJw/LoGaUxQ3f+xpgUXz38cr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318168; c=relaxed/simple;
	bh=hqRLaDNKogUaRmHf/2iO107dAumC350vozHUmTiqcdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b126RseP1VDujDtPEy7ww4ON8p1dZcxjQrNeVBINyonNzySp60Q0K8GyOCOACVK2mOudiOxsIOFoH78x3dnM1bfyLHoUYUFhXLfru9mtzzquqcrp+2H0hoGWqHVGk3QIYT25BMmX4aCX3Tx256+4b+GpajdRdfyM4HowBuK1xVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQZwKIaN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224019ad9edso67162175ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742318166; x=1742922966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv88hBBxZboXJONdl4LSqe3F+xHiocOTgQ4YrefHaSc=;
        b=GQZwKIaN/LGY0cXRCxQ/f1oN/0WrCeSKu79Wx2VbL/JQG9Ir+9i4wlUe+ICE51PrXE
         oj80kpFSy3Gh7LTPvcOitBAlCReE7Day8RZHrU34wn/8vYJzPXnR9ASPl0okYjUSNhR6
         W6ByWQPj/cZloMYP8YlPcEsHfHTxBo7YR0/8pfaV1bUevpDrk5ZGBt2t5mXrwx/InJr3
         CgQoiFiJyuofAJ6lcRB0TbfaPWsZ1kugfSOC8g60HwI7xrLlLNeU73czPU+rwcHySh7M
         2jgmFIAjHfw56YFDH5R3V+rmTAM7wDCisZz0+1Qi+TWGs6O90LO3vKMxbut9z6VA4kWe
         5t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742318166; x=1742922966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fv88hBBxZboXJONdl4LSqe3F+xHiocOTgQ4YrefHaSc=;
        b=rtOJ0W4otUEqDfG+JrS0X4ZLQxVNBR8fCEUJGuYXdkx0JTe2EXMZcDv7q/fJyxRyZw
         gF3rRg0hqb+gilE2KF82e7RBAW6EaZgkfKgYazVdvyTZgr3/ea3bMBSaIZBPfHHKo0fM
         0KhVQyrHAPOr8TBqRkkYC89rpqH2N5qxxZyzkg6qUV81T2XN2mUEkn0HhMXtkB0c7clt
         H17jZCbfK9zROvFYKEefqN0N5O/zqOLybM1QaACm+yZ4hkBb5oVQbCFsSI6dQiEHG4Ax
         6k4Y3Fz/A2f4qMy/IkdIiOG2mOplPzRVGv3nlLLojjoZwdaYqAhb1w/d4TOjmKugd8PH
         mdLA==
X-Forwarded-Encrypted: i=1; AJvYcCXjgR7i75LOiiaQ2aPUJGdMi130684EZMCcEYbg7Y/GAIS2gPc5JDPnskPysBGTuNxUEWmqquSkSXOJ8fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJWvV8Sp56T+QRocvWAhwNX2vGenfZhoV0T+DhUWkNBLWg3Z3
	Rp3HgPuEI4/Z/SZ7ivaalE9N0xlFYiB+O3XTbwY9vAU935Irondk
X-Gm-Gg: ASbGnctHUvArJSSNZhllYWIxbTD+HKzILd+O5dVOTQviJ2xvmj8VkEf6goy9yP5vknQ
	+tghOSRWm8b2MjSs4KSMUIoHMtk0P7MyerDxyMPgoH6y99yBjXeVcWRkefT2hDzl45sDlZ2OdBF
	DvTvwHlHxdcn9LYBR0CLlcnqYVxaR797phea77zC3Ykw2pjzTJcflFOH8faOGHs4nVVDdKsZTjU
	uDJFxWakA5K189lvrHea+22l63VY2gp8OblAOdvOgfXy7eSAkiFbJkBr5ee5VS3SoOSoEsA+ebJ
	utXYRBBUYoWLFLVDSBOhNDpg3v5vRiCBkxe4HuYDHhK+uTaiT3LsQElpLffwKzBDSsxm
X-Google-Smtp-Source: AGHT+IEiuxfM7CMCU8uN8rrGdd6ky409oPSqP147XRFz3wH1huV0wzqx/w2kjY4U0AMw0iZ6RBeVxQ==
X-Received: by 2002:a17:903:2287:b0:21f:52e:939e with SMTP id d9443c01a7336-2262c580c48mr65250955ad.28.1742318165591;
        Tue, 18 Mar 2025 10:16:05 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbca45sm97083145ad.166.2025.03.18.10.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 10:16:05 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:16:01 -0400
From: Yury Norov <yury.norov@gmail.com>
To: mailhol.vincent@wanadoo.fr
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
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
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v6 4/7] drm/i915: Convert REG_GENMASK*() to fixed-width
 GENMASK_U*()
Message-ID: <Z9mqUZX4H-CzqbW4@thinkpad>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-4-f59315e73c29@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308-fixed-type-genmasks-v6-4-f59315e73c29@wanadoo.fr>

On Sat, Mar 08, 2025 at 01:48:51AM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Now that include/linux/bits.h implements fixed-width GENMASK_U*(), use
> them to implement the i915/xe specific macros. Converting each driver
> to use the generic macros are left for later, when/if other
> driver-specific macros are also generalized.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Changelog:
> 
>   v5 -> v6:
> 
>     - No changes.
> 
>   v4 -> v5:
> 
>     - Add braket to macro names in patch description,
>       e.g. 'REG_GENMASK*' -> 'REG_GENMASK*()'
> 
>   v3 -> v4:
> 
>     - Remove the prefixes in macro parameters,
>       e.g. 'REG_GENMASK(__high, __low)' -> 'REG_GENMASK(high, low)'
> ---
>  drivers/gpu/drm/i915/i915_reg_defs.h | 108 ++++-------------------------------
>  1 file changed, 11 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_reg_defs.h b/drivers/gpu/drm/i915/i915_reg_defs.h
> index e251bcc0c89f5710125bc70f07851b2cb978c89c..39e5ed9511174b8757b9201bff735fa362651b34 100644
> --- a/drivers/gpu/drm/i915/i915_reg_defs.h
> +++ b/drivers/gpu/drm/i915/i915_reg_defs.h
> @@ -9,76 +9,19 @@
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  
> -/**
> - * REG_BIT() - Prepare a u32 bit value
> - * @__n: 0-based bit number
> - *
> - * Local wrapper for BIT() to force u32, with compile time checks.
> - *
> - * @return: Value with bit @__n set.
> +/*
> + * Wrappers over the generic BIT_* and GENMASK_* implementations,
> + * for compatibility reasons with previous implementation
>   */
> -#define REG_BIT(__n)							\
> -	((u32)(BIT(__n) +						\
> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&		\
> -				 ((__n) < 0 || (__n) > 31))))
> +#define REG_GENMASK(high, low)		GENMASK_U32(high, low)
> +#define REG_GENMASK64(high, low)	GENMASK_U64(high, low)
> +#define REG_GENMASK16(high, low)	GENMASK_U16(high, low)
> +#define REG_GENMASK8(high, low)		GENMASK_U8(high, low)

Nit. Maybe just

 #define REG_GENMASK		GENMASK_U32

