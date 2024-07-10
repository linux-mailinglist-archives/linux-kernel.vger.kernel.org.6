Return-Path: <linux-kernel+bounces-247529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C3692D0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B2F28991B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B2019048C;
	Wed, 10 Jul 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZcX9lg6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B281718FDDD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611525; cv=none; b=Eh3idSN7mShESR5jNdi+YiFkk/Y7vsucB6+G/SPn2RxdRc63P7S0Afinc8QAILOaqKPYqaxrXcbVwwbsxpNyjMUUFFlTjjwG7ErOpbUK5zlWcjWGY79hJ8KxrQntFKC6IuSsu7dJMbyFGllg95CIc8Vfq1XVKc6wPRiSNB5zGFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611525; c=relaxed/simple;
	bh=PCQvDnX2bhe1pCmu3mB/ovER9ZpvXqvbBRYqScZ2liM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltRtftOA9m3NEA9f5GbLpkSXsRSQQxGcLdaIRGjAYIrwlyhO9RR7zLPNLPqK4pB2Pzzr3EDT5SE85hCIFHfVIMs9XuNJ7cc5UH+OL1HC68kJzB/Q9qZL/Mv/URxBkPl4AGCM5W3e6eHKuPDyko2MJww/Rw1IWsQp6JIlYT4jFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZcX9lg6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720611524; x=1752147524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PCQvDnX2bhe1pCmu3mB/ovER9ZpvXqvbBRYqScZ2liM=;
  b=cZcX9lg6PGM0avAnTiHx0fczij4qiA4bvww2socWcZbuntP9QgAZsh+V
   fZnPGHI7AloYgMYQxUmoO62vq3F2Ym87kyn8Z4p3pVY5HiJXxLNV24I+z
   z41rtpJgVvY8rEaXri5MynMSrimDRPioiLQdLgScnSs6bBIZPmqf8fjO4
   lvROmPx/lkVlTZiMuLUlOAXBY4OodoC6RPTfitLfUKdRFO9PSO2RlbWH+
   7QyabyTysMZ/gkWxtRskoV0/XOZd59976lj8ZVwpITlzYXh5CzwRQOU9W
   hwbn9s5LQeC7llxHjaTo/wuw8F0xYyehZWYEgr5i7dsa7mHspVhwVMEN1
   A==;
X-CSE-ConnectionGUID: 6NiSgQ2lSX6mSUlJ6A7hpg==
X-CSE-MsgGUID: 1JK/ddNVRvaBNljbi3j7AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21689624"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="21689624"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 04:38:43 -0700
X-CSE-ConnectionGUID: tONXe3SRSGa5RO1tJjqqSQ==
X-CSE-MsgGUID: 9ZYTMnmuTJSCj8yEenubjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48170737"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 10 Jul 2024 04:38:39 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 10 Jul 2024 14:38:38 +0300
Date: Wed, 10 Jul 2024 14:38:38 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Explicitly cast divisor to fix Coccinelle
 warning
Message-ID: <Zo5yvk69FB-jEgd8@intel.com>
References: <20240710074650.419902-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710074650.419902-2-thorsten.blum@toblux.com>
X-Patchwork-Hint: comment

On Wed, Jul 10, 2024 at 09:46:51AM +0200, Thorsten Blum wrote:
> As the comment explains, the if check ensures that the divisor oa_period
> is a u32. Explicitly cast oa_period to u32 to remove the following
> Coccinelle/coccicheck warning reported by do_div.cocci:
> 
>   WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  drivers/gpu/drm/i915/i915_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 0b1cd4c7a525..24722e758aaf 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -4103,7 +4103,7 @@ static int read_properties_unlocked(struct i915_perf *perf,
>  			 */
>  			if (oa_period <= NSEC_PER_SEC) {
>  				u64 tmp = NSEC_PER_SEC;
> -				do_div(tmp, oa_period);
> +				do_div(tmp, (u32)oa_period);

Why is this code even using do_div() when it doesn't need the
remainder?

>  				oa_freq_hz = tmp;
>  			} else
>  				oa_freq_hz = 0;
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel

