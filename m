Return-Path: <linux-kernel+bounces-378045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E5D9ACA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02921C20F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6861AC43A;
	Wed, 23 Oct 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5SWrEH2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FE1ABEC2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688034; cv=none; b=O69a+/l7qbgyezryDTt5VZ6pP1HYEgAsYXnXagigj2h7F+yLeB1lUU82ZOSEvZmu4YUoZlE9RoDzywPhYMUU//rZfkJB/6DQVzY8KnsuH3f/xzAbbaXe9UcfmR8mqOcP1BEVz6Peekhj41jTZDvxOb1VVo9cx9SmpqDg2cLOHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688034; c=relaxed/simple;
	bh=s/ijLkvgmNSIDW3lP3xx7kywtJiOOd1nWwIXo6qDPpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kXWo1udymkMb/wD/+S16ahP3qtoQAqdSQDnCfA2VP/Wq1P99DZSP+KWhM3DDH2dnAWUK5gFogN9jl1w8E2tfIiDUnf5sWoqfeBgW69exPD5umYBKDgVhhrdUctOUVELom+XgX1fM2e+RULPidwVABtZXm467+sD3ZOl9PcAANeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5SWrEH2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729688032; x=1761224032;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=s/ijLkvgmNSIDW3lP3xx7kywtJiOOd1nWwIXo6qDPpU=;
  b=f5SWrEH2Y1Y3XwqBtWiKZSo9ksjH17JI0pYI+uHHmDXzbAyWhUpDX69P
   JyIIHvuOC/Ov+N6P/h/FvroRcUGupCre4qNmhBcmJOcdG1XFoSAPcD+fO
   Iy/tOmnDTlxmiyOSCW0p307xJMG7ZFC2UqfD0Y5UR7W7b2SNW7gfXFMh1
   Ndi6KIRSp6xGkMk0vDC94ULfu+LXVkecjWsKwvTmpQ3K3SHE6TCafOl4k
   2mbGyFIMRrE6XZLu5XomGdT/U/vf42BAgibqoI7yviLdtQeMgM7WGaw2S
   RyOhEwtOqkP08Ldd5XOn01vHt7aysEas/Lay0UNbMs45U7IdYwbvqqBjk
   g==;
X-CSE-ConnectionGUID: yX8ogtc4SQaRkp1NdHIfWw==
X-CSE-MsgGUID: VIguMflaSZyVEuYIBeyYWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39820799"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39820799"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:53:52 -0700
X-CSE-ConnectionGUID: FTXxJjn7SVSm7c7cxdb7qg==
X-CSE-MsgGUID: 3LglOoHNTba2rgHa1ro+ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="79859858"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.84])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:53:48 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Uros Bizjak <ubizjak@gmail.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/i915/active: Use try_cmpxchg() in active_fence_cb()
In-Reply-To: <20241003084533.871524-1-ubizjak@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241003084533.871524-1-ubizjak@gmail.com>
Date: Wed, 23 Oct 2024 15:53:46 +0300
Message-ID: <87ttd3t1yd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 03 Oct 2024, Uros Bizjak <ubizjak@gmail.com> wrote:
> Replace this pattern in active_fence_cb():
>
>     cmpxchg(*ptr, old, new) == old
>
> ... with the simpler and faster:
>
>     try_cmpxchg(*ptr, &old, new)
>
> The x86 CMPXCHG instruction returns success in the ZF flag,
> so this change saves a compare after the CMPXCHG.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>

Pushed to drm-intel-next, thanks for the patch.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/i915_active.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
> index 5ec293011d99..35319228bc51 100644
> --- a/drivers/gpu/drm/i915/i915_active.c
> +++ b/drivers/gpu/drm/i915/i915_active.c
> @@ -212,7 +212,7 @@ active_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
>  	struct i915_active_fence *active =
>  		container_of(cb, typeof(*active), cb);
>  
> -	return cmpxchg(__active_fence_slot(active), fence, NULL) == fence;
> +	return try_cmpxchg(__active_fence_slot(active), &fence, NULL);
>  }
>  
>  static void

-- 
Jani Nikula, Intel

