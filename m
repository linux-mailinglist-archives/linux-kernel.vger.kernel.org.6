Return-Path: <linux-kernel+bounces-548568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D71A5468C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0738E1896773
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9566E20A5DF;
	Thu,  6 Mar 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4e5ZlIV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603D20A5DC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253924; cv=none; b=gZ/1O9jqQaq3/JSAoBjqpHYmubFSVrkkHE7lsXhtUOm3cDQmsIG/e7YMqc+/Sw82RL/DTBERbfyN3+hmgdB9+TJX5elF4rH1M2dN/J1Pyrsu7QzDwikW4YhTFXEM0XW5nZRqhzo5pHIihovEneLdPkyEzJ+xyy4zTTUDpwdBTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253924; c=relaxed/simple;
	bh=yg9a4ShFg0RQ9AlyyGbnp+mN7hb0Beorgdfbkp4r/8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nawQbvd3BWOSaV+MzsiK3q36pDilpXuSY9WTvo+0YH31K6qNfx3WFHnN2t7Ls9kksoW3Ol6jGdVRsg/YT4JuyPtpTYjgnG2wA9wtDmQ+CKm865ahRFiINvLxM4Ylzm88EP1X/45LbyoBVVVdq0gkggY0oX2A7H8OdU2Jwx7YhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4e5ZlIV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741253921; x=1772789921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yg9a4ShFg0RQ9AlyyGbnp+mN7hb0Beorgdfbkp4r/8c=;
  b=E4e5ZlIV+8cKpQL2CZMIF0TYDeARL2lj9rSAEXOt60s5UCNzYIqXLOHm
   /A5MLRxoxMBqXR07UwDy69jQN2crtf7U+cdFvmfQUXL4S/Mchur8eNEJ+
   DMTxeM62rOjixOjXvtOAY5EB0y+tsrIAWpufRtxYDluIMtKw18AYrHEF4
   7ND35WI8pHlCiXQD/6J2R9bShkxSluf0KB8rd1qbwBXjnO7xEis+moy5C
   OqzjePsZxrtBKykb1xgMoN2xV8Rqr+8lNYJnZyxe0s3qnQgPvl8Uo+6jY
   keP/gnAUQ1KSiYj1d+WsVvpRZQ8j78zT2ExfducIQfvTFN0R+20UbzepZ
   Q==;
X-CSE-ConnectionGUID: KD1sAu8FQnuR7Ov+rP58oA==
X-CSE-MsgGUID: NslsdFYrR0eSPV77spVHrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53238518"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="53238518"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:38:40 -0800
X-CSE-ConnectionGUID: ENgsSW8kRxCB4vdXYvN8gg==
X-CSE-MsgGUID: cqvygY7dRT+BGoKLY2VSrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118781449"
Received: from dprybysh-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:38:34 -0800
Date: Thu, 6 Mar 2025 10:38:31 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: =?iso-8859-15?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <asbjorn@asbjorn.st>
Cc: intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jouni =?iso-8859-15?Q?H=F6gander?= <jouni.hogander@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: implement vmap/vunmap GEM object functions
Message-ID: <Z8ltF3n4n6iwDfxr@ashyti-mobl2.lan>
References: <20240629182513.78026-1-asbjorn@asbjorn.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240629182513.78026-1-asbjorn@asbjorn.st>

Hi Asbjorn,

On Sat, Jun 29, 2024 at 06:25:06PM +0000, Asbjørn Sloth Tønnesen wrote:
> Implement i915_gem_vmap_object() and i915_gem_vunmap_object(),
> based on i915_gem_dmabuf_vmap() and i915_gem_dmabuf_vunmap().
> 
> This enables a drm_client to use drm_client_buffer_vmap() and
> drm_client_buffer_vunmap() on hardware using the i915 driver.
> 
> Tested with a currently out of tree pixelflut drm_client[1] on:
> - Lenovo ThinkCentre M720q (CoffeeLake-S GT2 / Intel UHD Graphics 630)
> - Dell Wyse N06D - 3030 LT (ValleyView on Intel Celeron N2807 SOC)

do you mind sharing the tests?

> [1] XDP->DRM pixelflut: https://labitat.dk/wiki/Pixelflut-XDR
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <asbjorn@asbjorn.st>

thanks, reviewed and merged to drm-intel-gt-next.

Andi

