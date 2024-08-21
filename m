Return-Path: <linux-kernel+bounces-295514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95A959C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB828713E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060B192D89;
	Wed, 21 Aug 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGfoGyLL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591418DF7B;
	Wed, 21 Aug 2024 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243905; cv=none; b=SV7SRfkvCkVGutHNDA6eNwUpp0On7f530ChW2u1G6dYPmw32NFqldpb1Xbz9cmUQPQ82CUoyRzemmKx/hQcB5VfHJNsok0Ayr1AV2JHWCHJe4EyAVKFtO56l1Wt1WrHP4IEiEC6oPb1A4Kaj2dzf4EJ6ABd0hCLNwBpbUsAR6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243905; c=relaxed/simple;
	bh=6gJ5zaXYlZwZ657VdBITP3OgGdxedTJhrQygUotyKWk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KaQUrXg4NMEQ1c7mcU+GlWd1pqkZAt+M9/o+s2lyTEeUCn+s9WClYbCegWZfxJ6/9u2KilIJ+3BEKdnkSQSP1EChrRS71utkFGh/M7nt2hemvrWtYSt2rGJFxql82YqtyGhdzWLy/SlR4O2P4s5ZDc73Sfn4mEgs5gRtz8eruIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGfoGyLL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724243904; x=1755779904;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6gJ5zaXYlZwZ657VdBITP3OgGdxedTJhrQygUotyKWk=;
  b=YGfoGyLL3AUvu0IurGYhSbftRy9S6LckEQtM4i+18wmxFGtZjW0bnB4r
   QZJLZ3r1ziU73z0RFY0oyLd6XABGsQ/PEIhVzx4cXs1JkkD00H098fcrc
   iV0fneWZer2yf1i2uC2WxrKTEVYo5VrrDCBaQ93aHtUZBoe8CiOFr3oLV
   BqZKBvtbHSPfc/TtqzoMJRzNCSQy4AoVtOMC7WAX4i07wWVRBKhsl5Fw4
   rhkex2OK1R+mQaUbnZCbt/Y1Iz0ABL7n2xFH2GgLHzjT0jjxctkScvntd
   4mhB34TG0dg7YNgIcNIyuWP/6G5q6P76kW4emMOkHtQkUn1erujBx2Eb0
   Q==;
X-CSE-ConnectionGUID: G5YncYj3TB+a4lBGzVtlNg==
X-CSE-MsgGUID: 1DVT6u05RJ+rDXwcigY1Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33984288"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33984288"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:38:23 -0700
X-CSE-ConnectionGUID: 0F8Kvj6fRGGKFdik0tIgzA==
X-CSE-MsgGUID: fNaq+Iw1TLOmGgeBGE4jng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61616651"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:38:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Aug 2024 15:38:15 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v1 1/4] driver core: Ignore 0 in dev_err_probe()
In-Reply-To: <20240821122233.3761645-2-andriy.shevchenko@linux.intel.com>
Message-ID: <1dde296b-045e-d56a-1734-a1333a84060b@linux.intel.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com> <20240821122233.3761645-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-272445734-1724243895=:5260"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-272445734-1724243895=:5260
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Aug 2024, Andy Shevchenko wrote:

> In the similar way, ignore 0 error code (AKA "success") in
> dev_err_probe(). This helps to simplify a code such as
>=20
>   if (ret < 0)
>     return dev_err_probe(int3472->dev, ret, err_msg);
>=20
>   return ret;
>=20
> to
>=20
>   return dev_err_probe(int3472->dev, ret, err_msg);
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 6d3897492285..144cb8c201fb 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -5046,6 +5046,10 @@ int dev_err_probe(const struct device *dev, int er=
r, const char *fmt, ...)
>  =09=09 */
>  =09=09break;
> =20
> +=09case 0:
> +=09=09/* Success, no need to issue an error message */
> +=09=09break;
> +
>  =09default:
>  =09=09dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
>  =09=09break;
>=20

This seems generally useful,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

A nit, the code sequence that dev_err_probe() is documented to replace is=
=20
no longer matches with the behavior (the else would need if (err < 0)=20
added).=20

--=20
 i.

--8323328-272445734-1724243895=:5260--

