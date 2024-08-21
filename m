Return-Path: <linux-kernel+bounces-295501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE8B959BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB21F22A22
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842B6175D5F;
	Wed, 21 Aug 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6mOy0Iz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C81531C1;
	Wed, 21 Aug 2024 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243611; cv=none; b=d5vF8WETzjh9b6Sgr+Sl8q95PpPvWywC3DZLIg2GiuiRC//Wsx3fGxITxNRt82cMJDEaaC7mdy4vKV7zQftNeneQ8/xeBsgOBHoDHtmzpJlUfgOh8/kg/JFuhVQJlsmaRTgkckBN/ChYVI4PPUym+GmJjHFvDXHY3d9QxirDnxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243611; c=relaxed/simple;
	bh=hMAfE4Mvtcd5ET79hcKgW6u+1u5ZmeBbuFtoZqUj0dM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I8fwxOsf8wxb97mHwHRzDOJ4l2hTVuKlbq0ftnNVb6c0YPqbNuPXPGGauit62+F2IC70WuxLlq2sCdl3qhwx0BJKEGcbV4wNW7jJmrQEBfznN3DAgrVwSpKgtbp+uva+OXys6wG39yGKpNzN1QkvUntpUx7jBmFhHWuZ6yi0BUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6mOy0Iz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724243611; x=1755779611;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hMAfE4Mvtcd5ET79hcKgW6u+1u5ZmeBbuFtoZqUj0dM=;
  b=F6mOy0IzjaK7WDCh6ZKS/UHRGItqdgCvwFdrtcUwromXhFwGP8A2Cvhp
   x2MH2M4JIyY3X4r9I8PBjYK3x3maDcuXYtykE4m5eqKMJrHeb2YTq0SSk
   hiqe7aUBmuvXaBH8BndqyKx9vGU5wU1bPvRucS+FaThvvsCcrZ/Rz7WCy
   hZbhPchoA657blzqQYCJh12o+V/KbWELPN7KM1yoYvoSXMF+ffg8zBde7
   NAj0BVe8R+VzTJMd3LkQhkEx3IRh1J0xWGdwKgfyJRKajXggwQfZYSd7b
   c81jXv44JMzttoGXkyeCf5QdWOLZwxL9MR1aMJ3xzAQ9U71ZhKsOSkja1
   g==;
X-CSE-ConnectionGUID: Xhjaz9rYRgifbYXkuFv0UA==
X-CSE-MsgGUID: kqe68YzLROmPKIak/tQy7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="40058595"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="40058595"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:33:30 -0700
X-CSE-ConnectionGUID: VyMruX/VQHO/0dlqvnfAYw==
X-CSE-MsgGUID: uWgx089eQ6qN6IlCox75Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61050388"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:33:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Aug 2024 15:33:23 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v1 4/4] platform/x86: int3472: Use str_high_low()
In-Reply-To: <20240821122233.3761645-5-andriy.shevchenko@linux.intel.com>
Message-ID: <5b38a2d2-4cad-e34a-899a-6dad4e26346a@linux.intel.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com> <20240821122233.3761645-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1771321182-1724243603=:5260"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1771321182-1724243603=:5260
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Aug 2024, Andy Shevchenko wrote:

> Use str_high_low() rather than open coding.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel/int3472/discrete.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/plat=
form/x86/intel/int3472/discrete.c
> index 96a9673a0165..b5f6f71bb1dd 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/overflow.h>
>  #include <linux/platform_device.h>
> +#include <linux/string_choices.h>
>  #include <linux/uuid.h>
> =20
>  #include "common.h"
> @@ -230,7 +231,7 @@ static int skl_int3472_handle_gpio_resources(struct a=
cpi_resource *ares,
> =20
>  =09dev_dbg(int3472->dev, "%s %s pin %d active-%s\n", func,
>  =09=09agpio->resource_source.string_ptr, agpio->pin_table[0],
> -=09=09(polarity =3D=3D GPIO_ACTIVE_HIGH) ? "high" : "low");
> +=09=09str_high_low(polarity =3D=3D GPIO_ACTIVE_HIGH));
> =20
>  =09switch (type) {
>  =09case INT3472_GPIO_TYPE_RESET:
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1771321182-1724243603=:5260--

