Return-Path: <linux-kernel+bounces-291722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C355B9565E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA99283896
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107515B55D;
	Mon, 19 Aug 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADrQA+xJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1B15B149
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057146; cv=none; b=CFWujjPCNC0zO58tLNe0Z1h04mY1WDmICdyb8G/2XFUHOjYAXsuNrOXUg4bCZljFGPlEIEDMMNwrcXAZ1eYgFPsONG+cwhkcNvCOY0skPdjslKy9mzFYye3GxadxjlVAqR2NPIVKHe5S0krGkUMFP7pyyj1TZ2LZMXiI/aOnasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057146; c=relaxed/simple;
	bh=BwO9G9DSxzsNbJAx83jRWAZlxWASmFoV86cMBGMNnX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GplFfx8mg1JHhN8Rt8aXVhT7RYJC5wDZzJVq8odU4d3/yNTnBi3l3I0hWFwsIu0abQSBRoUdHsVySW13DgE2NP/38+vMyNiQhW1jq6mjhHUw3OdHeewPkqjMAMWrWFiy4SgrL8y2vgF6pLOW2TxkLlH9ZnJgZWwuze8H1RjudaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADrQA+xJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724057145; x=1755593145;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=BwO9G9DSxzsNbJAx83jRWAZlxWASmFoV86cMBGMNnX8=;
  b=ADrQA+xJcDdptM/WgSWkFM60z4YCNnXPZCndAi1pILND+l4TXAdfQIJ9
   Yrob4YlDOmNxeySq1c9ldX+ADx8IejECWxVqEtLzdrFjVGJ+t3VQWMopD
   u3d+Yc1+3MU0yzd+E2a+5pwkECs1Vpnx7hr0bLVDjVR2/8RTs4fQl95HA
   x96wWD6heXdb2FsgnGkVuRF0z34nA2JdLmcDmuOSxfSCqSCdeh4LQRZtr
   o7uIUss9qmSLrfSTZbRAKYTCYXQKz0C1QDKHT5E0pnSOuAuz3iWkHG3TY
   PzPFyBmzAYA4glPSn7b8NBLSTDFtXEcl9pkkmqdY23dTSEvNUe/GvPzPF
   Q==;
X-CSE-ConnectionGUID: oB7QIaQ0SMOgoC7tkeaLEA==
X-CSE-MsgGUID: Ozz40xm0QO+9JWeYIWQwJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22451304"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22451304"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:45:44 -0700
X-CSE-ConnectionGUID: K2j25Us7SbStyTFdemgwLg==
X-CSE-MsgGUID: iw+RIGyQTc+pBwxsD/u7rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60358532"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.70])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:45:37 -0700
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
Subject: Re: [PATCH 10/12] drm/edid: add a helper to compare two EDIDs
In-Reply-To: <20240818-amdgpu-drm_edid-v1-10-aea66c1f7cf4@weissschuh.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
 <20240818-amdgpu-drm_edid-v1-10-aea66c1f7cf4@weissschuh.net>
Date: Mon, 19 Aug 2024 11:45:34 +0300
Message-ID: <871q2k7vf5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Aug 2024, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:
> As struct drm_edid is opaque, drivers can't directly memcmp() the
> contained data. Add a helper to provide this functionality.

I'm not sure why drivers would need to compare EDIDs.

The only user was added in commit eb815442e840 ("drm/amd/display: don't
create new dc_sink if nothing changed at detection") with absolutely no
explanation why.

Other drivers use connector->epoch_counter to see if the EDID or status
changed.


BR,
Jani.


>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/gpu/drm/drm_edid.c | 18 ++++++++++++++++++
>  include/drm/drm_edid.h     |  1 +
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 69fb11741abd..c2493c983a64 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -1840,6 +1840,24 @@ static bool drm_edid_eq(const struct drm_edid *drm=
_edid,
>  	return true;
>  }
>=20=20
> +/**
> + * drm_edid_equal - compare two EDID
> + * @drm_edid_a: First EDID data
> + * @drm_edid_b: Second EDID data
> + *
> + * Compare two EDIDs for equality (including extensions)
> + *
> + * Return: True if the EDIDs are equal, false otherwise.
> + */
> +bool drm_edid_equal(const struct drm_edid *drm_edid_a, const struct drm_=
edid *drm_edid_b)
> +{
> +	if (!drm_edid_b)
> +		return !drm_edid_a;
> +
> +	return drm_edid_eq(drm_edid_a, drm_edid_b->edid, drm_edid_b->size);
> +}
> +EXPORT_SYMBOL(drm_edid_equal);
> +
>  enum edid_block_status {
>  	EDID_BLOCK_OK =3D 0,
>  	EDID_BLOCK_READ_FAIL,
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index a5b377c4a342..35b40a9d3350 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -456,6 +456,7 @@ drm_display_mode_from_cea_vic(struct drm_device *dev,
>  const struct drm_edid *drm_edid_alloc(const void *edid, size_t size);
>  const struct drm_edid *drm_edid_dup(const struct drm_edid *drm_edid);
>  void drm_edid_free(const struct drm_edid *drm_edid);
> +bool drm_edid_equal(const struct drm_edid *drm_edid_a, const struct drm_=
edid *drm_edid_b);
>  bool drm_edid_valid(const struct drm_edid *drm_edid);
>  const struct edid *drm_edid_raw(const struct drm_edid *drm_edid);
>  const struct drm_edid *drm_edid_read(struct drm_connector *connector);

--=20
Jani Nikula, Intel

