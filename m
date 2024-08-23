Return-Path: <linux-kernel+bounces-298487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4285095C7FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3521F23170
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF51442F7;
	Fri, 23 Aug 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akL0SSKQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F13D552
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401488; cv=none; b=aRsFTUvDcZMh/MbP3oVxszjSZW4F7bwSiFszwhq3aSK4eRM4TUEUUnKXYtZ26ifw3CoYvhNhUCdxucBwyU85AmNlGFWGpd0ZBXSLPJma+oOxiT0wTRSD/lwBbarKxuLMtbHDnnYmYJzwOH6YiPJa2qT10/kFaglnc8zGk++18CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401488; c=relaxed/simple;
	bh=7gEhOXTRHZaE+9aqx6sV7SuHwRI3hywFQ4vGtE9lh4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDa0rNvxv0lS6aQ1NRApB81rDvavGXpZSqd2h0JEVqeswDOdx0l/VfQFaI0D+H6xnCIdxI7HIp3rG3ibvmEHtLK13IdAX9fJX/xvRfwrslPFDvube9Bkj+d+euRAY575cULbDoGwa5hRj7Y+i/8UB5nhiBu2yinwZwFy0/iKGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akL0SSKQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724401487; x=1755937487;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7gEhOXTRHZaE+9aqx6sV7SuHwRI3hywFQ4vGtE9lh4I=;
  b=akL0SSKQfhEfsdDw9pYy7csT46psDRnZjwRWLshkNjQFvX4rJF0hFwYP
   /z613/CR0ZPZOlk2U0+NIK6nXkbFYxoMugAi3sr9RTyQX5vaal41incyN
   gFxIuA9sCpnKShySJMv8ostRZQx42TUvUUZFmkEZsxSPD1Lo6xZiMhC4X
   WGLrJa3O3y+cvdcJvN9YyR+gkEhi0HsIeIgDQU+BrRzmeD/NZ6tSQMg/p
   yqdlOprzXgVw6Ufbzc9oCbLoV5PBMpxikez63clseb9YvENwa1za6LI90
   kMtIHiPpJS9Lb6KtMGiDfmY6/MvnZoEurOU3tKuXwK/AV3pCEu0gD3VqW
   g==;
X-CSE-ConnectionGUID: h0N8tTINQFuJjlW9MEyALg==
X-CSE-MsgGUID: OzPy8KwsSO6KwMw/1yXEjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33521806"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="33521806"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 01:24:46 -0700
X-CSE-ConnectionGUID: ockf3KIFQXGmYDq18RPupw==
X-CSE-MsgGUID: 9i6pdE+rT+q3tvF0dEwHvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="92522146"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 01:24:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yuesong Li <liyuesong@vivo.com>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 daniel@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, Yuesong Li <liyuesong@vivo.com>
Subject: Re: [PATCH v1] drm/i915/dp: Remove double assignment in
 intel_dp_compute_as_sdp()
In-Reply-To: <20240823023612.3027849-1-liyuesong@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240823023612.3027849-1-liyuesong@vivo.com>
Date: Fri, 23 Aug 2024 11:24:36 +0300
Message-ID: <87seuv3auz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 23 Aug 2024, Yuesong Li <liyuesong@vivo.com> wrote:
> cocci report a double assignment warning. 'as_sdp->duration_incr_ms'
> was assigned twice in intel_dp_compute_as_sdp().
>
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 6a0c7ae654f4..229c87be4402 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -2730,7 +2730,6 @@ static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
>  	as_sdp->sdp_type = DP_SDP_ADAPTIVE_SYNC;
>  	as_sdp->length = 0x9;
>  	as_sdp->duration_incr_ms = 0;
> -	as_sdp->duration_incr_ms = 0;
>  
>  	if (crtc_state->cmrr.enable) {
>  		as_sdp->mode = DP_AS_SDP_FAVT_TRR_REACHED;

-- 
Jani Nikula, Intel

