Return-Path: <linux-kernel+bounces-376092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE949A9FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EACDB217FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B41619AA46;
	Tue, 22 Oct 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZH+mEtuK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD92198842
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592825; cv=none; b=r1GX9ct9yKIjHUnSOZOyR9is4x89OJqjc+YEEVVLlMNGmETgLZKAIRMGz8+5XjqNwvNy+HnEjVahq94pM4AxStcWJyLpoBm3o/d4jq+PbsyLvolq0DwLSlgN9mNdBNinh9rcQR1SyheYaUBnqIXmIYkyAqi28Ms9g9wy/jW5Ksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592825; c=relaxed/simple;
	bh=9FZ5ssmarZf/O4MWtFd4ckA+07hvM1UbBGqTaa/fvBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eVU9SBwkRuDf6MW670EyEy2HwVGe6p3CQ+z8oVo/HcO6QLVGC1pLhOrJ/8cPMidiLJl6b+8+W+S0FHKAzNgsqHIq59nDW3eur/SZqPXPdey7Fu2G6ZU4193kRmVRJSmsZar3KBCarMtswmSgnpPBJ8Y783JeELUsCoiJoVXMveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZH+mEtuK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729592823; x=1761128823;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9FZ5ssmarZf/O4MWtFd4ckA+07hvM1UbBGqTaa/fvBs=;
  b=ZH+mEtuKXzDBMsy0wtOOG+CjIv0jp3M3LCwOD3EYHEp8yNEmgcvkMxSs
   rAYhxEKttAnXI8JZOp59s1BsEmQaJCmRNgrppkG0TVVfEt7rZD7a+d32S
   aLKlefBhSGzO6MEmCsQ90kKDTv2khzf5meLgDySPpesvYaj0Z6VV1xM3J
   t9c4X46KLdWoU9SeFUz9UbpYTenj/PboPnP1jWTaLUdk7SVCYSrtjnm31
   5di7BmF0fZ3OAeThKCcwknAXxloCGXhLA7TlGUrxE3y4IPvjqgxTBAhmv
   c2d4DEoOVkUcCaSorRpHosQ0r2/3LVb5nEh+Vy1O9CgFpdiJATVnUFRaB
   g==;
X-CSE-ConnectionGUID: FMKNZZmfSFizXViJRrHB3g==
X-CSE-MsgGUID: bjqzW8+aSpCumv0Z/yOl+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29058706"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29058706"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 03:27:00 -0700
X-CSE-ConnectionGUID: 0k/is+bsTY62TWjhwvxgjA==
X-CSE-MsgGUID: KtQALvB5QYadkpzzJFYzCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79895298"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.4])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 03:26:56 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: R Sundar <prosunofficial@gmail.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imre.deak@intel.com
Cc: R Sundar <prosunofficial@gmail.com>, kernel test robot <lkp@intel.com>,
 Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH linux-next] drm/i915/ddi: use string choice helpers
In-Reply-To: <20241007173300.83902-1-prosunofficial@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241007173300.83902-1-prosunofficial@gmail.com>
Date: Tue, 22 Oct 2024 13:26:53 +0300
Message-ID: <87o73cv3f6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 07 Oct 2024, R Sundar <prosunofficial@gmail.com> wrote:
> Use str_enabled_disabled string helpers for better readability and to
> fix cocci warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202410071601.TFpXoqgW-lkp@intel.com/
> Signed-off-by: R Sundar <prosunofficial@gmail.com>

Pushed to drm-intel-next, thanks for the patch.

BR,
Jani.

> ---
>
> Reported in linux repo:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> cocci warnings: (new ones prefixed by >>)
>>> drivers/gpu/drm/i915/display/intel_ddi.c:2225:7-13: opportunity for str_enabled_disabled(enable)
>
> vim +2225 drivers/gpu/drm/i915/display/intel_ddi.c
>
> compile tested only.
>
>  drivers/gpu/drm/i915/display/intel_ddi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> index fe1ded6707f9..ff4c633c8546 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -2236,7 +2236,7 @@ static void intel_dp_sink_set_fec_ready(struct intel_dp *intel_dp,
>  	if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_FEC_CONFIGURATION,
>  			       enable ? DP_FEC_READY : 0) <= 0)
>  		drm_dbg_kms(display->drm, "Failed to set FEC_READY to %s in the sink\n",
> -			    enable ? "enabled" : "disabled");
> +			    str_enabled_disabled(enable));
>  
>  	if (enable &&
>  	    drm_dp_dpcd_writeb(&intel_dp->aux, DP_FEC_STATUS,

-- 
Jani Nikula, Intel

