Return-Path: <linux-kernel+bounces-573837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3792A6DD00
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE34F1884A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4605F25F98B;
	Mon, 24 Mar 2025 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGLL7mum"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899225D523
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826537; cv=none; b=EOEtT7DN9YI2IXCdX9tThdBjM9FXHk11zq6y62o6mGi8jTiVnta006XGJGt8/AKOC/pNIAY62Yh1qG1g5N3S9mPE4qHKZcAEKOhGeqdqbVbYHUnh1w3xBgE7Ira0FhJ3xI+7nin3nmED/yFRdb1Wgqs2uBNHzdq3APq+utHbbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826537; c=relaxed/simple;
	bh=xIV+VontEaxIuXjgWsTGF4PDGY0JgtsuKVWNmf4EsTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmbOL97O5Sn14wcfbvfisT5yjnWoCQvfTcSHggqYT96183A0r6QkAkh05wya0ScT4mWlKjJSNH7B2Z9WemwH/yeGbm+UaLWQkGhoJytAsCqzGTSvGhPzdth2feECG9Fn1TqdGFkVzIZ9llIOKXUUhxJpW+KS8iQ/wf/LXOcE3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGLL7mum; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso5736877a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742826535; x=1743431335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V2tZCtADdnCqZ2h+Fe0T2ycKUuwyHWNo6ZRayizrM04=;
        b=lGLL7mumqPAOztoHANks3RfnbZPewDzgShvaaGaUmYEYGuw158L3h0/8dA97Mbt6u/
         p1RSSUKgL9kIQ0qKfgNTbs5DneMzP0wikvLFyDyfDOI6kceM5mA0k82IYqULy2n/n4EZ
         nLFnvJXtq8fLHjeJW7Tu/oTrAEOuM5+qPZjFGQQ0cURVYB4Q+JktKNV/iACjzIG3Dreg
         yryczh/n/W/M7SCdPA8CLV9Uz7+DFHwHnEq35PWMKaIbRIeqdJaeqE1sKWhPf/yN/W64
         zv86M2gidAAobq8SwpaJqt8Nw5VtPqLHDkdIDurdtaEJO25AeLGahWBB2AJrBBY/5F5y
         RLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826535; x=1743431335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2tZCtADdnCqZ2h+Fe0T2ycKUuwyHWNo6ZRayizrM04=;
        b=X+EBCIRFrDPZdrB6GEhTlHhvR97EK0W49ZbMWGRCpG7K5fl2oj65AFzFccqvzPFlIm
         5W+0XFo4nbUtNM2Cmx6M24KvjV9XlUmCMaJldMHUhVpqzwwpHEiOpG6VRmtFJdgCTAkc
         KPnJPaJSjf6CYtDZx45nrq/cWiORA33IJwGbexU+GWRALrmhlh61QLNzRbqZUD9l6gTf
         Rjk6lfMOs+gTJKCImbKYaxg/6j4QQDdjP6eBO8fplRCLgBviDza2Dpx5mR+bFkIa1JdF
         GLCNE+nGqsfBT3DcqXMhvOWWI2oU4iS9FXfJ5VD+znbiWL7fg+V+D8VD+X/RgSbRHITQ
         T3PA==
X-Forwarded-Encrypted: i=1; AJvYcCXk46QxoOQaYtHlUcrHVCd9mH+wtD/ek4EeNrpu9PBu1rPzP9tZCBW2tGo0FAeyjO5jQMSBRT99FRQUW6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJwVc+gTqQSDahnj9eQpKA+SUrJOGEfQZNYgCdb6s4t7t9mbK
	zmqLpSJQ6mpKXzxIaqwv+QhsivCdYxL5QmS8KDHBCLrbOM5wLeQg
X-Gm-Gg: ASbGnctO/GlWb5m5hit+MevM3Vfm/PdpdxduvZ+SzwCfl2znhBibQz+znDgwhUze8sg
	KqYLxdlWWbsz5rlxoU/Xagy4/w8S8Nds/97M/YY5vaRQ0HDtlRgenGugU+HbodhKH1Oct+4ArZT
	Ozv/B02JA7cN72hRJHCZIeUoOqDKLuVSJHZLpUyj0qztWfHIkH8qcptS3zzJL+di4JpRwUbdB1I
	j4+FtDuGzQHHVAgF8TkKCjvcv5q3bC/qxrqG3uB11zQQe4LPbxphvdj3T8E7g0Mfy75mVCy3+fS
	o/cekvJJZRo4E6cR8Y9g06+9eaKfR4mpuZLp6zDoo46BzM0BI2otYA3YBuROwzsATkiD
X-Google-Smtp-Source: AGHT+IEc4zJRCtjm7tZQ2FP3G0nb3Bl9s88O1GkgJaZqI9g47C7voyfXZhOp0FPfkrGdzxg9VNj4rQ==
X-Received: by 2002:a17:90b:2707:b0:2ff:6488:e01c with SMTP id 98e67ed59e1d1-3030fefe3e4mr21894157a91.29.1742826535022;
        Mon, 24 Mar 2025 07:28:55 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f613968sm8195911a91.28.2025.03.24.07.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:28:54 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:28:52 -0400
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
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v7 0/5] bits: Fixed-type GENMASK_U*() and BIT_U*()
Message-ID: <Z-FsJPA1aq7KyTlm@thinkpad>
References: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>

On Sat, Mar 22, 2025 at 06:23:11PM +0900, Vincent Mailhol via B4 Relay wrote:
> Introduce some fixed width variant of the GENMASK() and the BIT()
> macros in bits.h. Note that the main goal is not to get the correct
> type, but rather to enforce more checks at compile time. For example:

You say this, and then typecast both BIT and GENMASK. This may confuse
readers. Maybe add few words about promotion rules in C standard, or
just drop this note entirely? Doesn't require new submission, of
course.

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
> long and long long variants seems sufficient.
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
>   Total: Before=22723481, After=22723481, chg +0.00%
> 
> (done with GCC 12.4.1 on an x86_64 defconfig)
> 
> --
> 2.43.0
> 
> ---
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
> Vincent Mailhol (2):
>       bits: introduce fixed-type GENMASK_U*()
>       test_bits: add tests for BIT_U*()
> 
>  drivers/gpu/drm/i915/i915_reg_defs.h | 108 ++++-------------------------------
>  include/linux/bitops.h               |   1 -
>  include/linux/bits.h                 |  57 +++++++++++++++++-
>  lib/test_bits.c                      |  30 ++++++++++
>  4 files changed, 96 insertions(+), 100 deletions(-)
> ---
> base-commit: e3f42c436d7e0cb432935fe3ae275dd8d9b60f71
> change-id: 20250228-fixed-type-genmasks-8d1a555f34e8
> 
> Best regards,
> -- 
> Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 

