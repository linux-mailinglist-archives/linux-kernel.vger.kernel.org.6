Return-Path: <linux-kernel+bounces-353053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74579927B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DABC282985
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9FA18C035;
	Mon,  7 Oct 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BylnmSAq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA476165F08;
	Mon,  7 Oct 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291607; cv=none; b=uDi1Gg25HKnWEif+GhCxDFcX0JmkQPZYJcy8gDEJAx//qp72HhWE2UJvXBDXFx5e5b3HmUcX7IZaJo7OoHYxtIyUZzjbAZPjZezwxD0BsBDaT6mB2YQ/axGsZ33ZxrgJPaZYX6G9PH0fWz16ns6mzRdUcUPaTZ3RJxQ7qq1zkF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291607; c=relaxed/simple;
	bh=TiLH4OZHLfVWkrP2QO8v315zKzHQ45bw+FiCgkZKOvk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FX102DBbIFp1TZeTeoQ9RwaqK6Qwa3VCHBNP7yzef6igY9voZ7kohOrraDoIfLldgCEBj4Jm1znNgqhQeVcbpe0TYY0JvrFAxy1q9csMcIgFjvKypnpSOHB2yVRgSKOiaCDXPytC34PyIzcik5T4sCv30XmzYpmnDzjS7DGHBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BylnmSAq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728291605; x=1759827605;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TiLH4OZHLfVWkrP2QO8v315zKzHQ45bw+FiCgkZKOvk=;
  b=BylnmSAqaWcXuvU9UNWSPIcfM7wZFdazDV8m5qOakGfKXswZwlkMn3uJ
   QPikZ5PD47qzGgF2Yaemd8Z2SeS3XtMhsFO8TzTCro6GYLwLFVe79yr4y
   vxjtoSdxYRoI1COvxHtmlSU/YnA7yxcYQvA8TVIZE7t+lqLddHI5mQa/i
   m/akVmHXaU8XJA2jLPZy8U5RG7NFXdOxTg0uXBNTIBx7cyuWRMLF9oK4F
   V1qbIWE01S0Z8oP2Imx/IbawXTE/KHg/O7U9TW1U4zysRTkiTg5l1EdBZ
   OZiP1WlTK89scWzm9lW0X+7weRXjnNb1jfVu2T7hMCVpuZoFbcXcxMu/1
   w==;
X-CSE-ConnectionGUID: tIlot/jOS++p0oyqY4hNNg==
X-CSE-MsgGUID: Z/MGCFPPRpajaV8tBXvd9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="31132164"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="31132164"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 02:00:05 -0700
X-CSE-ConnectionGUID: QjF29zriTWu2bCsYRCuLIg==
X-CSE-MsgGUID: fDEqOZHiScikYmFP8QoHhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75381135"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 02:00:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 7 Oct 2024 11:59:59 +0300 (EEST)
To: Crag Wang <crag0715@gmail.com>
cc: mario.limonciello@amd.com, Prasanth Ksr <prasanth.ksr@dell.com>, 
    Hans de Goede <hdegoede@redhat.com>, crag.wang@dell.com, 
    Crag Wang <crag_wang@dell.com>, Dell.Client.Kernel@dell.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 1/1] platform/x86: dell-sysman: add support for alienware
 products
In-Reply-To: <20241004152826.93992-1-crag_wang@dell.com>
Message-ID: <69e68ff4-da24-d4b0-498a-3be95b557a5a@linux.intel.com>
References: <20241004152826.93992-1-crag_wang@dell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-58572318-1728291599=:959"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-58572318-1728291599=:959
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 4 Oct 2024, Crag Wang wrote:

> Alienware supports firmware-attributes and has its own OEM string.
>=20
> Signed-off-by: Crag Wang <crag_wang@dell.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers=
/platform/x86/dell/dell-wmi-sysman/sysman.c
> index 9def7983d7d6..40ddc6eb7562 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -521,6 +521,7 @@ static int __init sysman_init(void)
>  =09int ret =3D 0;
> =20
>  =09if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> +=09    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
>  =09    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) =
{
>  =09=09pr_err("Unable to run on non-Dell system\n");
>  =09=09return -ENODEV;
>=20
--8323328-58572318-1728291599=:959--

