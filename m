Return-Path: <linux-kernel+bounces-447264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2B49F2FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87FE7A1700
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B557204096;
	Mon, 16 Dec 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMacY/PD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721820012C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349669; cv=none; b=KPhiAdphF+BNLWdxv6E6e3uWHS2mTOX45D6W6lMl6CLO4jPQE/+O+teqDA99su80xTYj37stvnCdobFF1ovaDfdkuDVnDm4OCPvur+GzPe97wZS6xkIkDppZvJc1F1A/oR+avkHe6Wb9mX2fKoLOuNgZ0odl86NEpGMNGKqRAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349669; c=relaxed/simple;
	bh=b/jnVnpWxsgsujPLPcohF02Om3SRNnOQCq/3TSfEFrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HinKj6DWt53oLKkL7tu39+0MLADeEycLk12z/o6h76dQfPucSbmzd+Pc70zzrwKjM9DBMPU/LZPnqKeC6K8v2gD572YQLO2ptk5rs0MLCz+Y3mamD36Pruv0oOj5Z3daZVpTAcqM4z1uwn6Qqv9wbZ22I5dtYb1UOiueKifMKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMacY/PD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734349667; x=1765885667;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=b/jnVnpWxsgsujPLPcohF02Om3SRNnOQCq/3TSfEFrg=;
  b=hMacY/PDMGImbV80bGQ35VpGevSR6FdkGGwvQKAUZInpLWEkI0hn2d7+
   Hw58P3UYYk6uN3f98egRzycMF0IGp8rrmDOy28w74PP22tKZ42FwDjIi7
   2ib/wt9WfJY+qT+5Q1xp3Ptfk7JnGnD892LhOx9emSRc6hqiuXJ+T22mx
   9XF1YAvzrr6siZnzNgwmpXMwTwN1/Xnm0zdmSyzKCpidduVsSB7JXJSFw
   Ha4FgRHY8W7kfqhLp0ZG6pWhsaIIkDO4ObeOoLzZrVgtMZLMbOSGovx/Z
   mbXjAQLHrgCX0F5DI424tMZju40jUlYgt1aOIweWXB2rzk/8T3DoECsHx
   A==;
X-CSE-ConnectionGUID: FGepXKmITWmrAfsobqAhmg==
X-CSE-MsgGUID: yUqZDV7MQf63Qu+ofBx4lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="52144724"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="52144724"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 03:47:47 -0800
X-CSE-ConnectionGUID: ibVkrFHNQ56/atLPvsZSZg==
X-CSE-MsgGUID: dFEPEd+kTEamIvmrKVQJlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="102046463"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.245])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 03:47:40 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Maarten
 Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Qiang Yu <yuq825@gmail.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Alex
 Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, Harry
 Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo
 Siqueira <Rodrigo.Siqueira@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lima@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Subject: Re: [PATCH 1/5] drm/sysfs: Constify 'struct bin_attribute'
In-Reply-To: <20241216-sysfs-const-bin_attr-drm-v1-1-210f2b36b9bf@weissschuh.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
 <20241216-sysfs-const-bin_attr-drm-v1-1-210f2b36b9bf@weissschuh.net>
Date: Mon, 16 Dec 2024 13:47:37 +0200
Message-ID: <87r067svc6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Dec 2024, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_sysfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index fb3bbb6adcd16f3f325a2ae8e35f41851c00b272..60c1f26edb6fad23153c32a29=
fd3be02700fc938 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -261,7 +261,7 @@ static ssize_t enabled_show(struct device *device,
>  }
>=20=20
>  static ssize_t edid_show(struct file *filp, struct kobject *kobj,
> -			 struct bin_attribute *attr, char *buf, loff_t off,
> +			 const struct bin_attribute *attr, char *buf, loff_t off,
>  			 size_t count)
>  {
>  	struct device *connector_dev =3D kobj_to_dev(kobj);
> @@ -315,21 +315,21 @@ static struct attribute *connector_dev_attrs[] =3D {
>  	NULL
>  };
>=20=20
> -static struct bin_attribute edid_attr =3D {
> +static const struct bin_attribute edid_attr =3D {
>  	.attr.name =3D "edid",
>  	.attr.mode =3D 0444,
>  	.size =3D 0,
> -	.read =3D edid_show,
> +	.read_new =3D edid_show,
>  };
>=20=20
> -static struct bin_attribute *connector_bin_attrs[] =3D {
> +static const struct bin_attribute *const connector_bin_attrs[] =3D {
>  	&edid_attr,
>  	NULL
>  };
>=20=20
>  static const struct attribute_group connector_dev_group =3D {
>  	.attrs =3D connector_dev_attrs,
> -	.bin_attrs =3D connector_bin_attrs,
> +	.bin_attrs_new =3D connector_bin_attrs,
>  };
>=20=20
>  static const struct attribute_group *connector_dev_groups[] =3D {

--=20
Jani Nikula, Intel

