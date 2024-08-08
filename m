Return-Path: <linux-kernel+bounces-278716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A51594B3FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D60C1C21381
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA64646;
	Thu,  8 Aug 2024 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mqp6K595"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D9376
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075984; cv=none; b=mTK+jzKDQ3fATxYSjSOKE00/vPqRAgE6lBIsJXQ62QYST5U9lXLtFWXTWtsETcIPZZqW/Qb33aY1U/wCuM13iE40SmAuzKihp8NVeS7qyUJaMhB5cuEvnGKnPs29A+1lb4Du7cU/ehFylnuvK10zu/Wly8o8XTlroWbsG+2Nb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075984; c=relaxed/simple;
	bh=KLGC7VU7LlmH2ADsLTAQz65NnOT9hUCfF7S/ygvlLFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDjW5C7d9VfX5hU3x5VUP/TCi4VRzho9YUDqVx9+Sgi16H0hihRUfDekG0t2ykp35rQCi+Xl1waCBAof5etHZh5UtUTlzyePA2IfjyghH6xs32u7pgoA9fZaTAQHGgGHGgVRoKID9oDp03Ng0q4HtP2esSRIvQVi9K3cZKCVnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mqp6K595; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D625CC32781;
	Thu,  8 Aug 2024 00:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723075983;
	bh=KLGC7VU7LlmH2ADsLTAQz65NnOT9hUCfF7S/ygvlLFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mqp6K595nySnR/dJnmFf9Rlz0UOfVFwpxSbjNxVv5oE+CvYGw7/P9OSl3L32d1kym
	 JcDCzk768Sot6aSZGU6d5i9b4WhkBwg0ofEqQO8066mjJIFCKM7ZRrl26uMtgRpSle
	 1l2brOz1MMzmgChs7UBq7OTCaMyCAUV5w285vM+3wnsDXl6I+qmT+N986xrFYcYuWz
	 y7T7GglDAOGGidA1O42jhCzhG5m8MSa09Bk5yNadsW762NM0/8ciPTvymONVCjPz3X
	 FV4XdezDsy3hN3K2bSUusmpNW9c8qFNyJxP9rUCzjkwqRdJp17rkiLPpt/2F8Q1lPd
	 uUqTcIUDrZ7QA==
Date: Thu, 8 Aug 2024 01:12:58 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, daniel@ffwll.ch, 
	jonathan.cavitt@intel.com, andi.shyti@linux.intel.com, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/i915: Explicitly cast divisor and use div_u64()
Message-ID: <akqf5n7hzrfr2lvsiyxbnbznzydvplhyi2phaavb3e6ak6z5fp@okyjnsi5xgey>
References: <20240807202040.54796-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807202040.54796-2-thorsten.blum@toblux.com>

Hi Thorsten,

> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 025a79fe5920..6ff905d2b78f 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -4063,17 +4063,13 @@ static int read_properties_unlocked(struct i915_perf *perf,
>  			oa_period = oa_exponent_to_ns(perf, value);
>  
>  			/* This check is primarily to ensure that oa_period <=
> -			 * UINT32_MAX (before passing to do_div which only
> +			 * UINT32_MAX (before passing it to div_u64 which only
>  			 * accepts a u32 denominator), but we can also skip
>  			 * checking anything < 1Hz which implicitly can't be
>  			 * limited via an integer oa_max_sample_rate.
>  			 */
> -			if (oa_period <= NSEC_PER_SEC) {
> -				u64 tmp = NSEC_PER_SEC;
> -				do_div(tmp, oa_period);
> -				oa_freq_hz = tmp;
> -			} else
> -				oa_freq_hz = 0;
> +			oa_freq_hz = oa_period > NSEC_PER_SEC ? 0 :
> +				div_u64(NSEC_PER_SEC, (u32)oa_period);

Thanks for the follow up!

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi

