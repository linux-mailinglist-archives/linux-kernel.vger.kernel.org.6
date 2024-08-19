Return-Path: <linux-kernel+bounces-291677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B426956570
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EACF1C218FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F0915990C;
	Mon, 19 Aug 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YazMikRt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0A157A67
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055695; cv=none; b=klATKeRPMPYr7+WLWtXKxDvEmpy6gjaXnBph1cryNP6Wl1uSbMcciJuiCkJHJSsNXAI27yD8zKh//5uTcqGRlwXMoBSLDlzS3oHLNB/DxGf+futFWEtzI4MW02iWTtVBzns0Gboj0+A1vVUXh4ZL9o6gjXbsQ6q5/tBz7sNbBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055695; c=relaxed/simple;
	bh=FdmMdPYIoj7W27+BO4QGSsXKhs9rzS4dHO+SdICw1cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YJD5MKRXW9eUGbdJTxUmS+7wT52lv0NuKPU0Lkaq2DaGU9NfS43ZJ1YCA1+Bsa4PvfY6mPrg3ZAgWcF/zEzZyNgNE7+yR1b9JaoWohw+aim3tV8RmPtTHvmcR9SWBsopWSw6UOQzW+Bd4XjdrRbNIBy12y91RIKG8kAKV08clLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YazMikRt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724055694; x=1755591694;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=FdmMdPYIoj7W27+BO4QGSsXKhs9rzS4dHO+SdICw1cw=;
  b=YazMikRtzglRCWK/V9J7tQSsDKo222wvPhkqGbJe2lDU7OuGJjX3wsn+
   tuhAYUecgCkBGINu5rrNuKNQVsQ/b70fX09R+aYA+2++OYTi92dWT40Fx
   A6P2w/G1sjm9oakqb/HFdWg6DOhOvFH6wRJjQPgPswk08CJtLpZ+tl6C3
   QfKaoQ3lqoaSChO3G9jErLIidJkqmvDohPzpKRQuZ+bLCYOjsSfBHdZyh
   5oRG92dNYBNPGu1b+jHiKEiRpGNh+GQT5giAO0uzIJi4RL2chFeZzvsf/
   Hrk5WYQUy0kSFz4TlCoCJVm7kHJV6Gu9hCqsPgvyQGveQkOYSkFQdAMQS
   A==;
X-CSE-ConnectionGUID: 4cGyuw4YTHirK0Kjxw/unQ==
X-CSE-MsgGUID: /I34+W6bTz+h+T6jkWKNkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="26047206"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="26047206"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:21:32 -0700
X-CSE-ConnectionGUID: VPQE/p4eTreE2cdmfee3Ow==
X-CSE-MsgGUID: tBYwa13lSh2fj5S0e+5eUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60454687"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.70])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:21:25 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Xinhui Pan
 <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, jinzh <jinzh@github.amd.com>, Aric Cyr
 <Aric.Cyr@amd.com>, Alan Liu <HaoPing.Liu@amd.com>, Tony Cheng
 <Tony.Cheng@amd.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 03/12] drm/edid: constify argument of drm_edid_is_valid()
In-Reply-To: <20240818-amdgpu-drm_edid-v1-3-aea66c1f7cf4@weissschuh.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
 <20240818-amdgpu-drm_edid-v1-3-aea66c1f7cf4@weissschuh.net>
Date: Mon, 19 Aug 2024 11:21:21 +0300
Message-ID: <877ccc7wji.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Aug 2024, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:
> drm_edid_is_valid() does not modify its argument, so mark it as const.

That's not true.

BR,
Jani.

>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/gpu/drm/drm_edid.c | 2 +-
>  include/drm/drm_edid.h     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index f68a41eeb1fa..69fb11741abd 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2034,7 +2034,7 @@ EXPORT_SYMBOL(drm_edid_block_valid);
>   *
>   * Return: True if the EDID data is valid, false otherwise.
>   */
> -bool drm_edid_is_valid(struct edid *edid)
> +bool drm_edid_is_valid(const struct edid *edid)
>  {
>  	int i;
>=20=20
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 6bdfa254a1c1..a5b377c4a342 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -442,7 +442,7 @@ int drm_add_modes_noedid(struct drm_connector *connec=
tor,
>  int drm_edid_header_is_valid(const void *edid);
>  bool drm_edid_block_valid(u8 *raw_edid, int block, bool print_bad_edid,
>  			  bool *edid_corrupt);
> -bool drm_edid_is_valid(struct edid *edid);
> +bool drm_edid_is_valid(const struct edid *edid);
>  void drm_edid_get_monitor_name(const struct edid *edid, char *name,
>  			       int buflen);
>  struct drm_display_mode *drm_mode_find_dmt(struct drm_device *dev,

--=20
Jani Nikula, Intel

