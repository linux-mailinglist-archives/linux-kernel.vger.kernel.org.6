Return-Path: <linux-kernel+bounces-299758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C66BA95D9BD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CBF1F24A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105B71C86EE;
	Fri, 23 Aug 2024 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAB3ZG/v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F71448ED
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455941; cv=none; b=GN/OVKH0XrBwVLABZHKxfjQUAKC1iz2XM410Tel0oGGGvTvU17HMiuJPfkC1n8ikuI02UzAKlM7B2wVlo43RHVauObTb5X71O2Fb6zBnB8JyuMyC+2bXSXAd4FPSUCCDq2+aEU+BqRLSgE2VWw381QZalHdAnTDH5f+8b/r3AJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455941; c=relaxed/simple;
	bh=QE6tOL6lECwZKber38VSosgwzqzqRhMJZ2xKrVtB2VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBQkxmDSpKjoRCw6oRWkINuloUTB398hDra+Lg5jPc+nVCTZDB//JCOixzx1hTwIiUYL3yzmh7MA5sIcSpvLS136Ndtx1+XtixIJXPiP7gD3juK/cb9WesZC9v1zijsBiL1NEPgD5+ZcAd1wKKH+CVepXocMXbmm7be6wIqOZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAB3ZG/v; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455940; x=1755991940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QE6tOL6lECwZKber38VSosgwzqzqRhMJZ2xKrVtB2VA=;
  b=aAB3ZG/v0q2GK2CKKOMM6AUkRP38E7CQ914SWbQvIVW/fZVCCLvONgSB
   5bU3bU759JsqnWghjNC6FxIuKixOIqII57dbwdTBaYwFUNr7UsnigtbCV
   ndYoATNU2wp98TTPc5137zMFV87RuxrB7MfeVWKe0FCuIygerQaQL+fxI
   mKgBLg44bPD+xfQPFTO0QUV6lnGXFOeIM4nDE0ypCTZ+hu98kDqhHnJMc
   BNNlhJGveIpCRDF3hx3nBn4bvcB85c/Gh7vP5/1y1BYHGFxDqcyTlY1jh
   h3GZWidycvOD4o3IzxWqVs4w7P+Z4VOy1GSA+pmYqPWI8StxGFGZ9SvhA
   A==;
X-CSE-ConnectionGUID: UTSde5iYSIaOnP+jCqsMNQ==
X-CSE-MsgGUID: ui6T3g8wTzy7C/HRMCZJuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="22921167"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="22921167"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:32:19 -0700
X-CSE-ConnectionGUID: zAqVGhdPRYqF1K9RMoqgUg==
X-CSE-MsgGUID: BjivJ/TpRm6wJxYFjpQODA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="66867863"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO intel.com) ([10.245.246.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:32:14 -0700
Date: Sat, 24 Aug 2024 01:32:10 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Shekhar Chauhan <shekhar.chauhan@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3] drm/i915/gt: Use kmemdup_array instead of kmemdup for
 multiple allocation
Message-ID: <Zskb-gt8gmridvM9@ashyti-mobl2.lan>
References: <20240821024145.3775302-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821024145.3775302-1-yujiaoliang@vivo.com>

Hi Yu,

On Wed, Aug 21, 2024 at 10:41:27AM +0800, Yu Jiaoliang wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> v2:
> - Change subject
> - Leave one blank line between the commit log and the tag section
> - Fix code alignment issue
> 
> v3:
> - Fix code alignment
> - Apply the patch on a clean drm-tip
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

merged to drm-intel-gt-next.

Thanks,
Andi

