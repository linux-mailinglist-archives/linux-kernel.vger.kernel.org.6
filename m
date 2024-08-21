Return-Path: <linux-kernel+bounces-295499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E7D959BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E971F22034
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56DE16631D;
	Wed, 21 Aug 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kz2eLZ/W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC01D12E1;
	Wed, 21 Aug 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243574; cv=none; b=L62EDcYIitDkX2sUFhYOrNcHCeGdpa23Lhcyp3QHVlkS2BKX+iDlBxzhjtkHzBvgMQRcQ6CwyV8ThOjdC4BVDt7sqlpYHCC/AduEVs03bt/k4erQbbSUhVWx+dw8Xgy1he/tWweniZKybosXAsHMAhrSIygZ06utEPGYi7tSpQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243574; c=relaxed/simple;
	bh=g5ppXx3w3lCYbf79TpTzQ1tpU+x1e4MTDFfIBPeqJB0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xj1YugfGdyKbMg8K2kK9Mr51StZrSRLhE2JcDL7kAVT7xESj4zemLZkpPdf+SK6LcNBjy8pB+deNepoHoYasuQGGPUVdlj5oreQ9s09mWGfVkfI3n5cU8l5Taq9PIjiZZyFpEfrqlZT5JXiGIXAudP6sVn9BcEkI/tqWW/jxUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kz2eLZ/W; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724243573; x=1755779573;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=g5ppXx3w3lCYbf79TpTzQ1tpU+x1e4MTDFfIBPeqJB0=;
  b=kz2eLZ/WjTV+bfmTplutY2/owjeSLTdxT4aPk01Mu13gV9Oytwdsrvro
   I0CF9GgxCaXmk1BXSpmvRMi63j2+uhDqHD2C3cwrb4UvxGSFsy82xMylt
   B0ltmsJ0sp/Pjusz09EXVPXFcp5lTeSqRJZaa+HzNZkXfYiYN10XqGi5A
   HUkRLQkt+90bOYW8bFxczKTMg28RyE4JY98nULq4uKZH0oWW3NM99Ciyj
   GwIcHZOgLvQZB9F5eD1nlS3uoeuVA62HUhs/EG5g1X2blVhxtHMA6/xNy
   eu9baCcLQIO8kPTUFFOUjsdnHwTEjP2fyumJiQAMRWKQRCw2GwF5baIi0
   g==;
X-CSE-ConnectionGUID: 6MxuQSXxRkydzv6HdzJgCA==
X-CSE-MsgGUID: YAcJtretQnCC0NKB5hZ44g==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="40058544"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="40058544"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:32:52 -0700
X-CSE-ConnectionGUID: jq473xsaR5yS2KaGpZyCyQ==
X-CSE-MsgGUID: HSX5fmquQMmw0rzvv1CYBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="91820575"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:32:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Aug 2024 15:32:46 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Alex Hung <alexhung@gmail.com>
Subject: Re: [PATCH v1 1/1] platform/x86: intel-hid: Use string_choices API
 instead of ternary operator
In-Reply-To: <20240821120458.3702655-1-andriy.shevchenko@linux.intel.com>
Message-ID: <b4dd5422-092a-7f21-0e3e-834a1a77140a@linux.intel.com>
References: <20240821120458.3702655-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1824163292-1724243566=:5260"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1824163292-1724243566=:5260
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Aug 2024, Andy Shevchenko wrote:

> Use modern string_choices API instead of manually determining the
> output using ternary operator.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel/hid.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/inte=
l/hid.c
> index 10cd65497cc1..445e7a59beb4 100644
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/string_choices.h>
>  #include <linux/suspend.h>
>  #include "../dual_accel_detect.h"
> =20
> @@ -331,10 +332,8 @@ static int intel_hid_set_enable(struct device *devic=
e, bool enable)
>  =09acpi_handle handle =3D ACPI_HANDLE(device);
> =20
>  =09/* Enable|disable features - power button is always enabled */
> -=09if (!intel_hid_execute_method(handle, INTEL_HID_DSM_HDSM_FN,
> -=09=09=09=09      enable)) {
> -=09=09dev_warn(device, "failed to %sable hotkeys\n",
> -=09=09=09 enable ? "en" : "dis");
> +=09if (!intel_hid_execute_method(handle, INTEL_HID_DSM_HDSM_FN, enable))=
 {
> +=09=09dev_warn(device, "failed to %s hotkeys\n", str_enable_disable(enab=
le));
>  =09=09return -EIO;
>  =09}
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1824163292-1724243566=:5260--

