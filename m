Return-Path: <linux-kernel+bounces-307323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E362C964BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01ED286E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565391B5312;
	Thu, 29 Aug 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwtMe1ZH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708E192B61
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949498; cv=none; b=GL07XwCvxW8MN/U4KW7yBbEMqBlr637HKjfLxmeDIzVNdZMzl2nfkwohCo3GZAHEaf/oCKUzW3qzPSKbOYua/NHLPRgjjnOPHE7unTjUkKDXOvKyrN0AIyR4/RBixiZyai/MZpexPU4MS60dX46C8O7iF+q25xMFH8wyATETZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949498; c=relaxed/simple;
	bh=8ECC19f7mP9IVu+SQ2hfFfUpwDcFE4fVvV0UmBQ8W7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MJkRKC4NY4oDcLSb4Y3Wu0Oe3Xs5yqHCH5OkKi/ZxFlG5ID4svSPzfNo2mVUfjwEsWv/bbzpR87vu3WJ4GF/VZyQL3FZitwWN2pMzw9a0+7pdj5y8/SoKWZ58GhMjJc9txb9W8Fm5WWaNyQBeI4I3l+T3L53eBsyzl00jKlrrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwtMe1ZH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724949497; x=1756485497;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8ECC19f7mP9IVu+SQ2hfFfUpwDcFE4fVvV0UmBQ8W7U=;
  b=bwtMe1ZH5iVH4HKUuGH9HfGekYtch1I/+AiMVm14heuAx3zU9bCCRVh3
   oY3Ge7n3kLe/cSPOtp8ts2LFXMxC4Ujy4orevceqH7WmHarn4ecqhsWzt
   UsCjNRGJCysj0AsyU0hikcWBYbENzjSibmpkHX7cMvPGp0r9gcMXVwTcY
   bpGuu2v+SMlv3DN31bvlBgPCBWuvwsGQ2KkwKAN6jXk4/RblUPkd+/e68
   UPlFVP+VuT1dsIpjuoRcQieNqngYoHq9Lpbg+oV6C16+CvWcOzNFTYfs7
   1qjnLpSSaRBB8omAvm6+DSTDHEbl7OcNblXtnc+c64TyRRPsvpbbtSH4j
   g==;
X-CSE-ConnectionGUID: Zk0ox8OyQq+3jf1d9nyaWQ==
X-CSE-MsgGUID: p/+MDSi7RDCQ/DJ0OfQXjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34173323"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34173323"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:38:16 -0700
X-CSE-ConnectionGUID: Ch6AQZiFSK6fqQtfOpDAEw==
X-CSE-MsgGUID: /RG5O2MmSzGvUkcQqX1yJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63593983"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.43])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:38:11 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/2] drm/i915/fence: A couple of build fixes
In-Reply-To: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
Date: Thu, 29 Aug 2024 19:38:08 +0300
Message-ID: <87cylrwahb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 29 Aug 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> With CONFIG_WERROR=y and `make W=1` build fails on my x86_64 machine.
> This is due to some unused functions. Hence these quick fixes.

Since when have we been getting the warnings for static inlines?

BR,
Jani.


>
> Andy Shevchenko (2):
>   drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
>   drm/i915/fence: Mark debug_fence_free() with __maybe_unused
>
>  drivers/gpu/drm/i915/i915_sw_fence.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

-- 
Jani Nikula, Intel

