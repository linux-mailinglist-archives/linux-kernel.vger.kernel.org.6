Return-Path: <linux-kernel+bounces-544727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E3A4E61A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7C2880A45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601627BF97;
	Tue,  4 Mar 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNJliLkf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A627BF81;
	Tue,  4 Mar 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102415; cv=none; b=BGrA9sYWCfjonY51cPmZzuu4ZlEh43yQuRUv8OO54vTYo5E2/xyU9jCUZWsnUe4Y76GiLqv7yIwkgxBAZmt9+JFg6xJci+guLlzWMHXjXNBAE0LP1GLgEOMd1hS+Z6INMf6+i4H2x6fehogTkC3eXFTikVJi1Fq1Jopn+RTqnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102415; c=relaxed/simple;
	bh=cxYGbUkB0Yoz6qWbFJi8QO9m0UONprohdcSKnp399Yc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fSPlVXuL949Lt56lqb0UNQY+GAhxXn3XJSCAJrAizwv/Kbd7e1o3IxW3t3OX2U/em5AEy38A8KqC/ACCgxHTe4Pu/E79Wo4sz8wHBxIZh4b8VG0PKHLC3/4FidARdfEd32dImfhxRm3K8JemPhWiK08dt19svrIqJlf5k744pTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNJliLkf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741102414; x=1772638414;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cxYGbUkB0Yoz6qWbFJi8QO9m0UONprohdcSKnp399Yc=;
  b=iNJliLkfh+2GZhyKeuwcd6WWF9b2ET7N2Q0A6KSHKdbnwR4B2vqnfOb1
   6y1uUSfsiSDd1dA6dEUtXshwomtAupuqw5rA+zxU+PzBNtE0UXRzuvIgy
   ancmpaqzs/OHlAvVWUoSeVx8AhkUk9TosjN0skZtyNnZqci8tDCfNVzUP
   9dIhLwuonrHu/SyxkjAT3oD4P/VdQxdiKoPLPIcxCjLwIGgAmBUtr3FM3
   YLWA1TqVhYtwzd0UtR60BpU5IyyyxykG0kObJ0l/ipc2aHNLStemzyyf3
   YIFOhEBXn/wVfda4Q1cq4D6sCVNAUcyE6tpIkVfG2t1vIxi7kEEimB25S
   Q==;
X-CSE-ConnectionGUID: Pfvh9izUSeq7OKSm4pS6eg==
X-CSE-MsgGUID: 7ca2OBeWS9ic9Y40kPpopA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53429551"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="53429551"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:33:30 -0800
X-CSE-ConnectionGUID: nUA5FecfRbafr5jpttdATg==
X-CSE-MsgGUID: ojR8XYzuQaSwbmd5zaSYpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="119086996"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:33:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Mar 2025 17:33:23 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, Dell.Client.Kernel@dell.com, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] platform/x86: alienware-wmi-wmax: Modify
 supported_thermal_profiles[]
In-Reply-To: <20250225222500.23535-5-kuurtb@gmail.com>
Message-ID: <55b6fd60-c82a-32f5-4639-09472745dc87@linux.intel.com>
References: <20250225222500.23535-1-kuurtb@gmail.com> <20250225222500.23535-5-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1247101556-1741102403=:931"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1247101556-1741102403=:931
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 25 Feb 2025, Kurt Borja wrote:

> Rename supported_thermal_profiles[] -> supported_profiles[] and change
> it's type to u8 because it stores AWCC thermal IDs.
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/dell/alienware-wmi-wmax.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pla=
tform/x86/dell/alienware-wmi-wmax.c
> index 57897a0f4296..4a8335d90b5d 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -212,7 +212,7 @@ struct wmax_u32_args {
>  struct awcc_priv {
>  =09struct wmi_device *wdev;
>  =09struct device *ppdev;
> -=09enum awcc_thermal_profile supported_thermal_profiles[PLATFORM_PROFILE=
_LAST];
> +=09u8 supported_profiles[PLATFORM_PROFILE_LAST];
>  };
> =20
>  static const enum platform_profile_option awcc_mode_to_platform_profile[=
AWCC_PROFILE_LAST] =3D {
> @@ -606,7 +606,7 @@ static int awcc_platform_profile_set(struct device *d=
ev,
>  =09}
> =20
>  =09return awcc_thermal_control(priv->wdev,
> -=09=09=09=09    priv->supported_thermal_profiles[profile]);
> +=09=09=09=09    priv->supported_profiles[profile]);
>  }
> =20
>  static int awcc_platform_profile_probe(void *drvdata, unsigned long *cho=
ices)
> @@ -643,7 +643,7 @@ static int awcc_platform_profile_probe(void *drvdata,=
 unsigned long *choices)
> =20
>  =09=09mode =3D FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
>  =09=09profile =3D awcc_mode_to_platform_profile[mode];
> -=09=09priv->supported_thermal_profiles[profile] =3D id;
> +=09=09priv->supported_profiles[profile] =3D id;
> =20
>  =09=09set_bit(profile, choices);
>  =09}
> @@ -652,7 +652,7 @@ static int awcc_platform_profile_probe(void *drvdata,=
 unsigned long *choices)
>  =09=09return -ENODEV;
> =20
>  =09if (awcc->gmode) {
> -=09=09priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =3D
> +=09=09priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =3D
>  =09=09=09AWCC_THERMAL_MODE_GMODE;
> =20
>  =09=09set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1247101556-1741102403=:931--

