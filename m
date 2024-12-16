Return-Path: <linux-kernel+bounces-447265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F09F2FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED6D1883253
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3A204096;
	Mon, 16 Dec 2024 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUVAurrk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8A2036FB
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349706; cv=none; b=Y0nkOxw39cH9O9V53AUi42mpFiepeL2IgWJCzjfuyY6oGUyuHh699IoMCeUXrA8gxsRS4x3ykp3BENmsEOAbcVjbPx8V1WyeGO4l/xFkl1fdnzHqiHXPmuiM4e7vjiSP60nF1EnKSkA01UbNzLgxJZEEGVqzBhHDkrIMsDZb6aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349706; c=relaxed/simple;
	bh=WccTDUXeXhePOUttIF4J+L90bqrAF5cuKGFhbSdR4fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d+gkg0xJdubOKbCyZCqcDx9n+TZGn2+pzGK4terscVCnS9XgrVOtKG84nqR5f4iV5bAS4ksKlIXjwOHbQ8AKPUVjPbxARzFH/Um9CxRQPPfe0RGUFg1skGDvQL5qycdbYEjpCTsIw2RJfET8MhSbI7l5V0svWjR5MU3+wuFvo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUVAurrk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734349704; x=1765885704;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=WccTDUXeXhePOUttIF4J+L90bqrAF5cuKGFhbSdR4fk=;
  b=FUVAurrkY9OYXY8VORWriKB+63DksBRFa+hint8HozChMhkqrWPlbsOZ
   ARa/Eu2uOLw9wJDVcCvRGqyTSMQ9KX5ucnRt7+BN+CxDjevN9b2NRp+ur
   T193siUXzrhQtH3VPoXkLeeVJpao05SCxAdWkQQrDTcmA9k1ZiYgEgVhH
   W6bhn9uPVV6CVl+THkvrBTinh4tLjzsWPaxw4I5w+TBp5ZHLOsMjBx8Ly
   SLi+2RREEH/vT6icZyMGvZ+z1/S83yrifccyqdQq7HhNcSyj10Ihbi73j
   lvNplfDmRksWfypFp6sD8VsRpelRGDsWM5F2YblkxoyPZHUDyK0WZSLIs
   A==;
X-CSE-ConnectionGUID: 448F8JxuTzqsyVTUBnTGuA==
X-CSE-MsgGUID: 5unlEB+ZQAq6bnv1BAdqVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="22314237"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="22314237"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 03:48:23 -0800
X-CSE-ConnectionGUID: yauVPYWOSeCqWubREGgkwA==
X-CSE-MsgGUID: WabXx/a6QmqXkbcTLhmGGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102157451"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.245])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 03:48:16 -0800
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
Subject: Re: [PATCH 3/5] drm/i915: Constify 'struct bin_attribute'
In-Reply-To: <20241216-sysfs-const-bin_attr-drm-v1-3-210f2b36b9bf@weissschuh.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
 <20241216-sysfs-const-bin_attr-drm-v1-3-210f2b36b9bf@weissschuh.net>
Date: Mon, 16 Dec 2024 13:48:13 +0200
Message-ID: <87o71bsvb6.fsf@intel.com>
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
>  drivers/gpu/drm/i915/i915_gpu_error.c |  8 ++++----
>  drivers/gpu/drm/i915/i915_sysfs.c     | 12 ++++++------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915=
/i915_gpu_error.c
> index 71c0daef19962660086b37fe55ca2d6b01f2bb9a..a4cb4e731bdd72201c91541fb=
86e827e96214a8b 100644
> --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> @@ -2491,7 +2491,7 @@ void i915_gpu_error_debugfs_register(struct drm_i91=
5_private *i915)
>  }
>=20=20
>  static ssize_t error_state_read(struct file *filp, struct kobject *kobj,
> -				struct bin_attribute *attr, char *buf,
> +				const struct bin_attribute *attr, char *buf,
>  				loff_t off, size_t count)
>  {
>=20=20
> @@ -2527,7 +2527,7 @@ static ssize_t error_state_read(struct file *filp, =
struct kobject *kobj,
>  }
>=20=20
>  static ssize_t error_state_write(struct file *file, struct kobject *kobj,
> -				 struct bin_attribute *attr, char *buf,
> +				 const struct bin_attribute *attr, char *buf,
>  				 loff_t off, size_t count)
>  {
>  	struct device *kdev =3D kobj_to_dev(kobj);
> @@ -2543,8 +2543,8 @@ static const struct bin_attribute error_state_attr =
=3D {
>  	.attr.name =3D "error",
>  	.attr.mode =3D S_IRUSR | S_IWUSR,
>  	.size =3D 0,
> -	.read =3D error_state_read,
> -	.write =3D error_state_write,
> +	.read_new =3D error_state_read,
> +	.write_new =3D error_state_write,
>  };
>=20=20
>  void i915_gpu_error_sysfs_setup(struct drm_i915_private *i915)
> diff --git a/drivers/gpu/drm/i915/i915_sysfs.c b/drivers/gpu/drm/i915/i91=
5_sysfs.c
> index 8775beab9cb8438c2e8abb0f9d8104dcba7c0df3..f936e8f1f12942287a5a7d6aa=
7db6ed3a4c28281 100644
> --- a/drivers/gpu/drm/i915/i915_sysfs.c
> +++ b/drivers/gpu/drm/i915/i915_sysfs.c
> @@ -60,7 +60,7 @@ static int l3_access_valid(struct drm_i915_private *i91=
5, loff_t offset)
>=20=20
>  static ssize_t
>  i915_l3_read(struct file *filp, struct kobject *kobj,
> -	     struct bin_attribute *attr, char *buf,
> +	     const struct bin_attribute *attr, char *buf,
>  	     loff_t offset, size_t count)
>  {
>  	struct device *kdev =3D kobj_to_dev(kobj);
> @@ -88,7 +88,7 @@ i915_l3_read(struct file *filp, struct kobject *kobj,
>=20=20
>  static ssize_t
>  i915_l3_write(struct file *filp, struct kobject *kobj,
> -	      struct bin_attribute *attr, char *buf,
> +	      const struct bin_attribute *attr, char *buf,
>  	      loff_t offset, size_t count)
>  {
>  	struct device *kdev =3D kobj_to_dev(kobj);
> @@ -140,8 +140,8 @@ i915_l3_write(struct file *filp, struct kobject *kobj,
>  static const struct bin_attribute dpf_attrs =3D {
>  	.attr =3D {.name =3D "l3_parity", .mode =3D (S_IRUSR | S_IWUSR)},
>  	.size =3D GEN7_L3LOG_SIZE,
> -	.read =3D i915_l3_read,
> -	.write =3D i915_l3_write,
> +	.read_new =3D i915_l3_read,
> +	.write_new =3D i915_l3_write,
>  	.mmap =3D NULL,
>  	.private =3D (void *)0
>  };
> @@ -149,8 +149,8 @@ static const struct bin_attribute dpf_attrs =3D {
>  static const struct bin_attribute dpf_attrs_1 =3D {
>  	.attr =3D {.name =3D "l3_parity_slice_1", .mode =3D (S_IRUSR | S_IWUSR)=
},
>  	.size =3D GEN7_L3LOG_SIZE,
> -	.read =3D i915_l3_read,
> -	.write =3D i915_l3_write,
> +	.read_new =3D i915_l3_read,
> +	.write_new =3D i915_l3_write,
>  	.mmap =3D NULL,
>  	.private =3D (void *)1
>  };

--=20
Jani Nikula, Intel

