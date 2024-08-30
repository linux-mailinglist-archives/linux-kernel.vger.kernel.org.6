Return-Path: <linux-kernel+bounces-308727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB889660F0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74081F2628F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082E190074;
	Fri, 30 Aug 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+/zi/bN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9D17BB1E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018230; cv=none; b=jvWP3Gcyy1/52g8oUtvIsIBUMyBnsRQ2H7AltthCGCmE3IhlXvHXQavJqvaXmkQpTUQ7JnUNL+RNRen80ASgUk2c24XVNH6BrpQAHvuKuO4Ljl0iStYoIi4RN6m09x0/RyxsqyYOp6YpIMDbm7qiH2tUtw6Gh4jnb3af3ph2si4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018230; c=relaxed/simple;
	bh=BppDBUfTxk7hWt6OENvRKCxA8Lzq/CkTXkRuPUHlw7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKtW9RO2NogjvUQOAjV+CsOAvKbzOQFBuDrXj88+GOxdRJ25DbII21Vd+gUmQnM1unFyRobBj2esPsA19bp6pY13msmzsfwXOevU7vkwvqQqBFDwdLnS+8bNCpMLV6Kek9kp7Be8nMZmg4QoQFilwmXDPzVv7IId2OtWJMTTWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+/zi/bN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725018228; x=1756554228;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=BppDBUfTxk7hWt6OENvRKCxA8Lzq/CkTXkRuPUHlw7E=;
  b=B+/zi/bNkL5Su7jB+zZdOjdQGHdnWY7vspgOErRBExhHGxaMRza8d3+9
   8P0gy/EbDbKPGeRSKvvO2yWqKCuCOVOjv+Q1YcppcQqdXI8ZdXtm1/bZL
   Y4SC9bBJq4s5SWLDus2tZDifrkbwRsHB6x+O3u1CQbsSJmXmQ9W50K/Dv
   8zpwt9SI/bAnAd4vhOmzaLh2m11NerqLRTW+keL/tpEQNtP4BZU2sGmrG
   T9OB5EvKZojOrn+73YuAMPcE/5Gz2xRA+SHlSbrS0lzLzRznet4DLQnmp
   5Fj9Lf90PwtGEfSafrzzfoKOU1/DvELhXfTEfg37tnvT4HmTF8WHaW09V
   w==;
X-CSE-ConnectionGUID: O/WNRapbReSB3KI9IwzCWQ==
X-CSE-MsgGUID: HfAABdJjSWeXJ4BOQL9R9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="13296238"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="13296238"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:43:47 -0700
X-CSE-ConnectionGUID: Nd6cmudnRs2lB8s4qvSSvA==
X-CSE-MsgGUID: 5e+k6uwvTqaU/YndVIIKxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64373925"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.88])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:43:44 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm/mm: Mark drm_mm_interval_tree*() functions
 with __maybe_unused
In-Reply-To: <20240829154640.1120050-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240829154640.1120050-1-andriy.shevchenko@linux.intel.com>
Date: Fri, 30 Aug 2024 14:43:38 +0300
Message-ID: <87ttf2utg5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 29 Aug 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> The INTERVAL_TREE_DEFINE() uncoditionally provides a bunch of helper
> functions which in some cases may be not used. This, in particular,
> prevents kernel builds with `make W=1` and CONFIG_WERROR=y:
>
> .../drm/drm_mm.c:152:1: error: unused function 'drm_mm_interval_tree_insert' [-Werror,-Wunused-function]
>   152 | INTERVAL_TREE_DEFINE(struct drm_mm_node, rb,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   153 |                      u64, __subtree_last,
>       |                      ~~~~~~~~~~~~~~~~~~~~
>   154 |                      START, LAST, static inline, drm_mm_interval_tree)
>       |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fix this by marking drm_mm_interval_tree*() functions with __maybe_unused.
>
> Fixes: 202b52b7fbf7 ("drm: Track drm_mm nodes with an interval tree")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As discussed in [1], the key combo is W=1 and Clang, which enables
detection for unused static inlines.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


BR,
Jani.


[1] https://lore.kernel.org/r/20240829155950.1141978-1-andriy.shevchenko@linux.intel.com


> ---
>  drivers/gpu/drm/drm_mm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
> index 5ace481c1901..1ed68d3cd80b 100644
> --- a/drivers/gpu/drm/drm_mm.c
> +++ b/drivers/gpu/drm/drm_mm.c
> @@ -151,7 +151,7 @@ static void show_leaks(struct drm_mm *mm) { }
>  
>  INTERVAL_TREE_DEFINE(struct drm_mm_node, rb,
>  		     u64, __subtree_last,
> -		     START, LAST, static inline, drm_mm_interval_tree)
> +		     START, LAST, static inline __maybe_unused, drm_mm_interval_tree)
>  
>  struct drm_mm_node *
>  __drm_mm_interval_first(const struct drm_mm *mm, u64 start, u64 last)

-- 
Jani Nikula, Intel

