Return-Path: <linux-kernel+bounces-577044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22413A717A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F2B174C76
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BAB1EB5E6;
	Wed, 26 Mar 2025 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgVp9m8E"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05331A0BDB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996267; cv=none; b=XXvNnNYz5fQvUU0foEVldLcYsKKEvaShDisL18WQHDkJ+lJ6Ig6+k9hhB7VxHoZBip0mNnUVH/7RnSDYgmfW6gHY8W9Q9Q1t7jBCttQfOII7w+YdWKFxVZnNP/OB0zJKr2isZbFJjrk8Qq26h5/9Puq3d6EVUVUNojQKjnQtU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996267; c=relaxed/simple;
	bh=xDLr6HsxBJ/nrlhzR6o+R0BRVDeFn+daB3Ysnih1qCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whv8GM7F0L+DkU5FWZLPcheg4eX9EmgBNuuNGllA9bD8MH7s6C8yrrso1I17jcLyXHjKEuCFmDD+EX32m7dhqiOLVMgML9dwFdRp+OphqmzZGP+4qFRx2dJVl5iocG+oJuJgdNtttuOfdf4zvAi7jsHF4PDuDjzErd9lC/2krYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgVp9m8E; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-700b17551cdso64205157b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742996264; x=1743601064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2DpJ6VRMzKkbiSjucX4k613JgndFFXaW28hmKcfLsmU=;
        b=MgVp9m8E3FVYjGTJIw6RIVke/HNXAEK0SSpzQxz8VmcTmpA2jVMIRzBM0fdM9t5nBY
         jzP4E8faHZkApttd2edA4e4vdVTcT8RIdEaPvFRWDWfRkGByJ06N9CtH/wxWv8hJXFlc
         LtC5oTN8c+BRF+ATPPGRvkipiDjiaFU9ol2u1Xu6u3xQvPrWjJ7SuKgbDQlxwdIAyppf
         Z2ZR4NklSdrgVkjaHNK4CYQgrFaxTRJrkjXEm68rD7qAW2S0hpOuJy0+JmzXOxDoV9n7
         zC1nm/k3W88BZYlP4WAQ1FnYJCLmotF5EgJcL4Is5r1Ivv54hFluPMUvwUUvsswmMlBq
         ni+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742996264; x=1743601064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DpJ6VRMzKkbiSjucX4k613JgndFFXaW28hmKcfLsmU=;
        b=l4x18gVKaswqNGnXZc11LoTvzgj7bWwxi02fKqzHX7p1foUu6gpyU8dp/hQlgA9GO1
         fWXXMCREKgg1TlP3ids2LlS7UK+iHcU7kbNz4a9i4l/p19FlVzaBi9fJp3zy9a6m4u8z
         5JFwqmQ8820OAgm+vU6cjVzFNSOo4gk3+Eq0Ku8xYcdk2ndeY5ibvHbvsRC33s+TtdJA
         maC/Ywddr8naGXRI/nITaAf9HY4TKbA1AZba+LAxJJYhHgGnOS1zkjAbQPEgAW6gUE6L
         3zagTTA59+M6oi/poB9t7pXWyD6KZlW5D5qgdYXBBye5+uD1NzXq45NTiTdJPkrWsTai
         JkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyt8ZBxLmGBetv5TvKa70FUk/rdON/MNNmqGo3WG0SBZtqS91J8iQKl9h5zEn0e0pk6MRj1rRe92h994Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvrWQSQQhbCkLBuZX91vxEamM+UJaWdScfenA5lZ/mWZamIPjY
	DtmZtkUszAQM18o1rKkl+TMsVQn1Hi6NXOjt8mIsxoo7TknteI9YwbybregL
X-Gm-Gg: ASbGnctZapx6FnutMxd0mSaryzDpFLZWZ26Li/NYVPRNszXfhwPLEJerAD8C4fJYlZa
	Key2eVRMLcnnL5wiN5V1ENQQBURFVN5Bu9I0z9Vb493asiBmuOq3yNvGYSlh0uO7r6GWqbevpvN
	7Vt4yRtYeEOukH064mzxMOQygygbTGIKWZJIEqXH8oP/dU/IbYsVoTrwGra4hQxerku7C7PWI7o
	zZvp+9oShta0gKQtv+07gjul0oVYOaiSHCAissJMFdpwsUoM92vFAjv6wu3Pt+0c9Q9OfCoqw5k
	jzmwJJl5CDX0sbIeP/3df1Ddk5gGgDn9Olka/0GHJkDpyOsqJ+cde5svI0QWVvIlGTBITEzxwY1
	AXAlJ
X-Google-Smtp-Source: AGHT+IGvirXrX547Pzmc+Y0plNP5+DHUQkHLaMvaNmdW4WCslAICEC1hYvTBWFyg2u5oqxcINUQj5w==
X-Received: by 2002:a05:690c:4507:b0:6f9:a3c6:b2e4 with SMTP id 00721157ae682-700bad19157mr281523847b3.37.1742996263675;
        Wed, 26 Mar 2025 06:37:43 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba88d538sm25142977b3.99.2025.03.26.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 06:37:43 -0700 (PDT)
Date: Wed, 26 Mar 2025 09:37:42 -0400
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v8 0/6] bits: Fixed-type GENMASK_U*() and BIT_U*()
Message-ID: <Z-QDHmrA9G0Erp85@thinkpad>
References: <20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr>

On Wed, Mar 26, 2025 at 12:59:55AM +0900, Vincent Mailhol via B4 Relay wrote:
> Introduce some fixed width variant of the GENMASK() and the BIT()
> macros in bits.h. For example:
> 
>   GENMASK_U16(16, 0)
> 
> will raise a build bug.
> 
> This series is a continuation of:
> 
>   https://lore.kernel.org/intel-xe/20240208074521.577076-1-lucas.demarchi@intel.com
> 
> from Lucas De Marchi. Above series is one year old. I really think
> that this was a good idea and I do not want this series to die. So I
> am volunteering to revive it.
> 
> Meanwhile, many changes occurred in bits.h. The most significant
> change is that __GENMASK() was moved to the uapi headers. For this
> reason, a new GENMASK_TYPE() is introduced instead and the uapi
> __GENMASK() is left untouched.
> 
> Finally, I do not think it makes sense to expose the fixed width
> variants to the asm. The fixed width integers type are a C concept. So
> the GENMASK_U*() are only visible to the non-asm code. For asm, the
> long and long long variants seem sufficient.
> 
> This series does not modify the actual GENMASK(), GENMASK_ULL() and
> GENMASK_U128(). A consolidation of the existing genmasks will be
> proposed later on in a separate series.
> 
> As requested, here are the bloat-o-meter stats:
> 
>   $ ./scripts/bloat-o-meter vmlinux_before.o vmlinux_after.o 
>   add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
>   Function                                     old     new   delta
>   Total: Before=22781662, After=22781662, chg +0.00%
> 
> (done with GCC 12.4.1 on an x86_64_defconfig)

Applied, thanks!

> 
> --
> 2.43.0
> 
> ---
> Changes from v7:
> 
>   - Meanwhile, in commit db6fe4d61ece ("lib: Move KUnit tests into
>     tests/ subdirectory"), lib/test_bits.c was moved to
>     lib/tests/test_bits.c. Rebase onto Linus's master branch so that
>     this change is reflected.
> 
>   - Remove the note in the cover letter on the return type, instead
>     add an explanation in patch "bits: introduce fixed-type
>     GENMASK_U*()".
> 
>   - s/shift-count-overflow/-Wshift-count-overflow/g
> 
>   - Link to v7: https://lore.kernel.org/r/20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr
> 
> Changes from v6:
> 
>   - Split the series in two: this series leave any existing GENMASK*()
>     unmodified. The consolidation will be done in a separate series.
> 
>   - Collect some Reviewed-by tag.
> 
>   - Address miscellaneous nitpick on the code comments and the line
>     wrapping (details in each patch).
> 
>   - Link to v6: https://lore.kernel.org/r/20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr
> 
> Changes from v5:
> 
>   - Update the cover letter message. I was still refering to
>     GENMASK_t() instead of GENMASK_TYPE().
> 
>   - Add a comment in the cover letter to explain that a common
>     GENMASK_TYPE() for C and asm wouldn't allow to generate the u128
>     variant.
> 
>   - Restore the comment saying that BUILD_BUG_ON() is not available in
>     asm code.
> 
>   - Add a FIXME message to highlight the absence of the asm GENMASK*()
>     unit tests.
> 
>   - Use git's histogram diff algorithm
> 
>   - Link to v5: https://lore.kernel.org/r/20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr
> 
> Changes from v4:
> 
>   - Rebase on https://github.com/norov/linux/tree/bitmap-for-next
> 
>   - Rename GENMASK_t() to GENMASK_TYPE()
> 
>   - First patch of v4 (the typo fix 'init128' -> 'int128') is removed
>     because it was resent separately in:
>     https://lore.kernel.org/all/20250305-fix_init128_typo-v1-1-cbe5b8e54e7d@wanadoo.fr
> 
>   - Replace the (t)~ULL(0) by type_max(t). This way, GENMASK_TYPE()
>     can now be used to generate GENMASK_U128().
> 
>   - Get rid of the unsigned int cast for the U8 and U16 variants.
> 
>   - Add the BIT_TYPE() helper macro.
> 
>   - Link to v4: https://lore.kernel.org/r/20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr
> 
> Changes from v3:
> 
>   - Rebase on v6.14-rc5
> 
>   - Fix a typo in GENMASK_U128() comment.
> 
>   - Split the asm and non-asm definition of 
> 
>   - Replace ~0ULL by ~ULL(0)
> 
>   - Since v3, __GENMASK() was moved to the uapi and people started
>     using directly. Introduce GENMASK_t() instead.
> 
>   - Link to v3: https://lore.kernel.org/intel-xe/20240208074521.577076-1-lucas.demarchi@intel.com
> 
> Changes from v2:
> 
>   - Document both in commit message and code about the strict type
>     checking and give examples how it´d break with invalid params.
> 
>   - Link to v2: https://lore.kernel.org/intel-xe/20240124050205.3646390-1-lucas.demarchi@intel.com
> 
> Link to v1: https://lore.kernel.org/intel-xe/20230509051403.2748545-1-lucas.demarchi@intel.com
> 
> ---
> Lucas De Marchi (3):
>       bits: introduce fixed-type BIT_U*()
>       drm/i915: Convert REG_GENMASK*() to fixed-width GENMASK_U*()
>       test_bits: add tests for GENMASK_U*()
> 
> Vincent Mailhol (3):
>       bits: add comments and newlines to #if, #else and #endif directives
>       bits: introduce fixed-type GENMASK_U*()
>       test_bits: add tests for BIT_U*()
> 
>  drivers/gpu/drm/i915/i915_reg_defs.h | 108 ++++-------------------------------
>  include/linux/bitops.h               |   1 -
>  include/linux/bits.h                 |  57 +++++++++++++++++-
>  lib/tests/test_bits.c                |  30 ++++++++++
>  4 files changed, 96 insertions(+), 100 deletions(-)
> ---
> base-commit: 2df0c02dab829dd89360d98a8a1abaa026ef5798
> change-id: 20250228-fixed-type-genmasks-8d1a555f34e8
> 
> Best regards,
> -- 
> Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 

