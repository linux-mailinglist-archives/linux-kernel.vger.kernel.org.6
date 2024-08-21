Return-Path: <linux-kernel+bounces-295517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38D5959C13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6E0287018
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667DA18E34B;
	Wed, 21 Aug 2024 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Adp1pz+m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505618B49E;
	Wed, 21 Aug 2024 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244097; cv=none; b=dLzTablmNfPXxMFyMZc5ihSPCwV1j8FM71B5QJv0h0IhwkroezqdFsQvvL0+eOU/vc1vNdLrix5M/c94PvdKIKqaczSEM4LI10t2vWQb1hodWZRXbUjA/1CfuxOwhYwFGmV85aA3zGojG5eX5Oajzwusr+Hmltda64UjpnpAOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244097; c=relaxed/simple;
	bh=vy6M3uVmcsZYVvpOO4vJQdjq8rdlXSQxH1BERLAZsbU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NduFNNfl6VC6hEactWcJ5y211xhC48I8xgTXNq2GC4LIzSc4pjXxGjfKS1hQWbuD5W7asgOq2Jy3zaeM//2tc2Pb9+f28QJV2Xe8VziSqx9ZcTPZI0RmV/WI2VStBUDu17G9XTc6LNyJPN1d5ZErfWQQLKGMaTxDnWllZijeCpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Adp1pz+m; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724244096; x=1755780096;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vy6M3uVmcsZYVvpOO4vJQdjq8rdlXSQxH1BERLAZsbU=;
  b=Adp1pz+mU5ouVSemHF5PQlwI2PJhBLkFzPdTZ9KwyYTFdd5sqBWsiWKq
   yYHY888xpRbVzrC3AuNKlXZgFTPYKC0D+2VrBkpjubREopDh++yKuc8Gl
   wvkbRYp03QxaazWYD38RKnaQF1Z/HivfdLRUxXOG4n8dglxFOZWqXb7Fw
   vPl2bd9rYN82UvNCu6e0l2yDXT+CowpMk7Ua6m86y39xLh6RITwl7pdoX
   EAJ4dw4Wj3W9Tv6z/UF987UcJeFg2sc8xr/V9gZ0Zowa7ZXrLSxm1+Nf5
   DHwz+aKeQLbgn6gzz0rC2qYnTS96WkZTMuNEWmcwYn8RZ+XQj28QBXJcr
   Q==;
X-CSE-ConnectionGUID: BV1MXDjfQnugLdvVVeG6Ug==
X-CSE-MsgGUID: 0xi51JmzRKaLapQrDxhgrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33168253"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33168253"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:41:35 -0700
X-CSE-ConnectionGUID: 4u/8F0sYRgSp6OqUprUGow==
X-CSE-MsgGUID: X8xJ/6ZZQLeL4MYenm8lKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84259059"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:41:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Aug 2024 15:41:30 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v1 3/4] platform/x86: int3472: Use GPIO_LOOKUP() macro
In-Reply-To: <20240821122233.3761645-4-andriy.shevchenko@linux.intel.com>
Message-ID: <c99b8ee1-dec1-689c-5f0c-dc45e6b984ae@linux.intel.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com> <20240821122233.3761645-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-843904164-1724244090=:5260"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-843904164-1724244090=:5260
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Aug 2024, Andy Shevchenko wrote:

> Use GPIO_LOOKUP() macro which provides a compound literal
> and can be used with dynamic data.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel/int3472/discrete.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/plat=
form/x86/intel/int3472/discrete.c
> index cd0743300d7f..96a9673a0165 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -69,11 +69,7 @@ static int skl_int3472_fill_gpiod_lookup(struct gpiod_=
lookup *table_entry,
>  =09if (!adev)
>  =09=09return -ENODEV;
> =20
> -=09table_entry->key =3D acpi_dev_name(adev);
> -=09table_entry->chip_hwnum =3D agpio->pin_table[0];
> -=09table_entry->con_id =3D func;
> -=09table_entry->idx =3D 0;
> -=09table_entry->flags =3D polarity;
> +=09*table_entry =3D GPIO_LOOKUP(acpi_dev_name(adev), agpio->pin_table[0]=
, func, polarity);
> =20
>  =09return 0;
>  }
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-843904164-1724244090=:5260--

