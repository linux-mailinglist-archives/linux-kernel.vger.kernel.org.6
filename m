Return-Path: <linux-kernel+bounces-276567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6C9495BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494BAB25D82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46183B1AC;
	Tue,  6 Aug 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDxCyeNw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48083184D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960863; cv=none; b=cPyeBB08uzMncw4qSKQ3esp8C8vwbHnjwWjEsX/qThJUDBwkHngrZt57hBTRqon8ASQNKBsuQCB2STligc0BdtqlxR8hIDGiBepj3q4QLcTbVl0Zucfsr9A+GoKdTIAHYpTl5YLBeT2bDbtUKkcJeUJsde2Lslvg1qP42fuHhFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960863; c=relaxed/simple;
	bh=mn4bAaKh4OzlNcns15U7R+92M15go6dKF/m0kZ4fJcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ddzdmo6pnURs3Ukrbbsl17igJDwP04QqEiyL1lJQ/5/ySuoFlesfvi7gC6lB3QEpXc8suGxiOZ72xfvbDeRXDrM0ZKzbfKzX5QcyTe1Gk95X1JhlFdNB3+mnKDXpppXlDhA4jbUmdzUR0bAVVAbFkrlWYrI7uhy/8KwPlHspD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDxCyeNw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722960863; x=1754496863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mn4bAaKh4OzlNcns15U7R+92M15go6dKF/m0kZ4fJcQ=;
  b=fDxCyeNwLxWttJZskGiiMaQrV9SfwoRQCRDFVSs+f+Ndv0gItRnFbseB
   U0X0lfHtXL+NoHUjwNDifaqhETY+lItzfXM6jYWoPiRzhBQPxVxMCB8iu
   ToJVk/bbreV4tSeO7AJ91O/t7+P+nnQl5GpFytmu02wsBbu1WJILJqjke
   sEDnBhsROJegHqRJnLcmfDscdMJjUpWPA+8fFtSmv4tW4ryYLkDR1WyUo
   OTEgZ/yTh0hiKa0s3+cNQ5IvCzDvVBwYbxhrdPW1uqmKeCRxVb7ofmekU
   rmp7X9jV8TDTZBhFItK0S/bNnxv1K7AdZ+jxT1t9JqEj8OX/CTwAmCV3p
   w==;
X-CSE-ConnectionGUID: kQ5HRAVnTM+nD7Iwn2QGJQ==
X-CSE-MsgGUID: +3t1KOpjQm2XtLxc3PAeqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31566797"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31566797"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 09:14:22 -0700
X-CSE-ConnectionGUID: L+AMiGrRR3SsWknUUVXQcw==
X-CSE-MsgGUID: F8dxAd+vQJ+Qrr/0i/YGwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="87215097"
Received: from johunt-mobl9.ger.corp.intel.com (HELO intel.com) ([10.245.244.131])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 09:14:15 -0700
Date: Tue, 6 Aug 2024 17:14:07 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: David Gow <david@davidgow.net>
Cc: Christian =?iso-8859-15?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
	Thomas =?iso-8859-15?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Gow <david@ingeniumdigital.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Ville =?iso-8859-15?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/i915: Fix ttm small BAR placement handling
Message-ID: <ZrJLz9rZLsZh1nWo@ashyti-mobl2.lan>
References: <20240804091851.122186-1-david@davidgow.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804091851.122186-1-david@davidgow.net>

Hi David,

thanks for the patches and thanks Justin for debugging the issue.

I reviewed and merged it into drm-intel-gt-next.

Thanks,
Andi

On Sun, Aug 04, 2024 at 05:18:46PM +0800, David Gow wrote:
> From: David Gow <david@ingeniumdigital.com>
> 
> As described in [1], there have been a couple of regressions in the TTM
> placement handling for i915, which adversely affect DG2 systems with
> small BAR.  In particular, performance become very poor when eviction
> from the mappable BAR memory is required, as suboptimal placements can
> be preferred, leading to thrashing. This often leads to hangs of >10s,
> during which even the compositor is unusable.
> 
> These regressions were largely introduced during the flag rework in
> commit a78a8da51b36 ("drm/ttm: replace busy placement with flags v6").
> 
> The first patch has already been sent out[2]. I'm resending it as part
> of this series which fixes both known regressions.
> 
> Thanks to Justin Brewer for bisecting the issue.
> 
> Cheers,
> -- David
> 
> [1]: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11255
> [2]: https://lore.kernel.org/dri-devel/20240722074540.15295-1-david@davidgow.net/
> 
> ---
> 
> David Gow (2):
>   drm/i915: Allow evicting to use the requested placement
>   drm/i915: Attempt to get pages without eviction first
> 
>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> -- 
> 2.46.0

