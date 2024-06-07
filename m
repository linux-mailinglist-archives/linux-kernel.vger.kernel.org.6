Return-Path: <linux-kernel+bounces-206017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67B900364
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B8C1C22D54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4761194088;
	Fri,  7 Jun 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFc77jNe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648D19306C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763048; cv=none; b=mCSGEE7aU3Mgy5CPGUwSbsco6GFNIgC6yLI9L8jXrY0OKfKPQ0oMd/+tGNTZTD5SgMoUKHOmgWOIDLxgPfyNQbl7dyM14MQyCjXymahbW1t271bJWBYnkTpIKTQVWnFEDi9g/h40Gf3tdh3h457kDPR2P1TmuZPPOuXfPvzYF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763048; c=relaxed/simple;
	bh=T8125ejlFGHXH+zMyxlBEkin5nrHb/FzXg7E29LfCHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nWo9CPWrORhnBLfQ9wFcop7hC1Kkxee+X/hzv+4UdHaeguMOoUQVVkVOapJXfVl7Gc6YgteoT6cvUPQlkgcRHJwFrS2I7VVpgxregi7Wc2gn475O5sqSprWiu9BBLnXPh1EzQfavu/HrGHuGPRJm7JiB7zH/Xj1WWzGgiYoOUgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFc77jNe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717763047; x=1749299047;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=T8125ejlFGHXH+zMyxlBEkin5nrHb/FzXg7E29LfCHY=;
  b=NFc77jNedfTJ7zjGBpyUO3MR+YhbFRl2jdHmAnbOBPyO7uFZocz6KmGk
   Osqn7Bq27LNtPlvHxDsYsiXVNzl/oqnUfqmWgHDIrQBtSgzGg50OGhM4X
   /7OZgO5Fb1LVOJqXBlJFMd7/88E7kh+zhimmzCigSjNzKmHcU1M4KLPqm
   f36JelCvwJC2z2gLD2GDwcJm0uzK5agpdz2G5M61MJp1LAX8+gP5lc+11
   /poDbuHt1oaSnVMb9lB4dYU6SZBL+baG/B8AGF+diLD00zSQkmHm9F64p
   6LTCRtw5ZVTgPBejVC0at6zNtlppFdo25+Ls1UiefvTNzlD3Gfe4T4cB5
   Q==;
X-CSE-ConnectionGUID: Tr2EUFmoRVqcYALZjlI4Hw==
X-CSE-MsgGUID: k1iAtSnXSwCew6mFH3esLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="39880623"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="39880623"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:24:06 -0700
X-CSE-ConnectionGUID: kaNUbnJxRJaCm3Pc1ocK3Q==
X-CSE-MsgGUID: EKEwEkJISJ6eU4mp2Febkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38430882"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.72])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:24:04 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, airlied@gmail.com, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] drm: have config DRM_WERROR depend on !WERROR
In-Reply-To: <20240516083343.1375687-1-jani.nikula@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240516083343.1375687-1-jani.nikula@intel.com>
Date: Fri, 07 Jun 2024 15:24:01 +0300
Message-ID: <87o78dkkke.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 16 May 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> If WERROR is already enabled, there's no point in enabling DRM_WERROR or
> asking users about it.

Ping. Any comments? (Besides the one snark.)


BR,
Jani.

>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/r/CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com
> Fixes: f89632a9e5fa ("drm: Add CONFIG_DRM_WERROR")
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 026444eeb5c6..d0aa277fc3bf 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -450,6 +450,7 @@ config DRM_PRIVACY_SCREEN
>  config DRM_WERROR
>  	bool "Compile the drm subsystem with warnings as errors"
>  	depends on DRM && EXPERT
> +	depends on !WERROR
>  	default n
>  	help
>  	  A kernel build should not cause any compiler warnings, and this

-- 
Jani Nikula, Intel

