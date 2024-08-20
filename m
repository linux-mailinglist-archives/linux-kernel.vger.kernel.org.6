Return-Path: <linux-kernel+bounces-293825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA064958567
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D7D1C21622
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A218E054;
	Tue, 20 Aug 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkveCWKD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6818E023;
	Tue, 20 Aug 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152008; cv=none; b=YQPjbNKG41Ja0iOB0vrmqBDu7xk5X0IaYk4kEdMgj/XixI1BYYHBWxH5C5ITRbSxSq+rR8EC/NGBO+P6NJGrhpvIvcupkW9UepNuMwwkJugzX3btRdvIEfiT0evtSjAwE8dLPsCnWNLeV7+bnWw+D2iCqRdPCr6vpl7my40gWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152008; c=relaxed/simple;
	bh=cN/m+npz49OSR1TK9HWa73pXGttS28mLDstG0D4haLQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mAb9x46CzEzgvLIl8cpW1ynWDDaCj+C+QS2UCsVRK4v6vMulZTeLY6lUqOn6vTWzORSw1Czubn9EXexvqIWroURbVIf6yoBFEf3OH9Wd8HccOT6acDRrwVp1DBEwo536Lp4Dd5fIdF5IYgzOgxSYVMEdFnwgmAdPYF7kpHJha+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkveCWKD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724152007; x=1755688007;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cN/m+npz49OSR1TK9HWa73pXGttS28mLDstG0D4haLQ=;
  b=FkveCWKDgGJIaEtP8wOk5Jm/xpCbXX09G5mjhD+VjF/TyDye3utxFf9T
   xulX+1PHtcSXkrkeFB+Vc8RH9zsqDDdL/TJ7FlDqwMFnDSgpivc9yHUtn
   Xw/S+H8GELhhb1CQDIU2wOiFnzdF4HjoBbpRiIf32uuSNIPvbeK25TcH2
   JcdzULrvtGSTkh5PbXKn6FjNqjjPGLgCv/jyywcmVWJ8/q2u+mWZ5bWQ4
   EjvyNcR3fyInluXe7oGDCcqIuJZSfBhTYxYw2+t1vb4/GD4pk9250BCoB
   cwWYqgke9JRb0ZhXQnUnLkuZ5PU4r1RhiRkzCEez8zkaz9w9RKK3rffu/
   g==;
X-CSE-ConnectionGUID: 9+6GtJDNS5O+jsPvMqz55w==
X-CSE-MsgGUID: z7JKxxmBS3SiXeGEGXjQEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33015031"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="33015031"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:06:46 -0700
X-CSE-ConnectionGUID: MWb+YgfcSwuG9fr7uIG+KQ==
X-CSE-MsgGUID: ni0EtVvEQtiXzILuNw5GAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="61453162"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:06:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Aug 2024 14:06:40 +0300 (EEST)
To: Xi Huang <xuiagnh@gmail.com>
cc: jeremy@system76.com, productdev@system76.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: system76: Reducing redundant conditional
 judgments in system76_add()
In-Reply-To: <20240820090239.17771-1-xuiagnh@gmail.com>
Message-ID: <079a7474-0255-f486-9847-97d67c2e44d2@linux.intel.com>
References: <20240820090239.17771-1-xuiagnh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1334768247-1724152000=:1119"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1334768247-1724152000=:1119
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 Aug 2024, Xi Huang wrote:

> In case of an error, goto jumps to the =E2=80=9Cerror=E2=80=9D label,
> where the if (data->has_open_ec) check is redundant in most cases.
> Since the conditions for most goto statements have already
> been satisfied by if (data->has_open_ec),the code has been modified to
> improve execution speed.

And why would the error rollback path need to be improved in execution=20
speed? In any case, this change is going to below the noise level when it=
=20
comes to a measurable impact.

I'm sorry but I don't think this change is useful.

--=20
 i.

> Signed-off-by: Xi Huang <xuiagnh@gmail.com>
> ---
>  drivers/platform/x86/system76_acpi.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/=
system76_acpi.c
> index 3da753b3d..05b4bf18f 100644
> --- a/drivers/platform/x86/system76_acpi.c
> +++ b/drivers/platform/x86/system76_acpi.c
> @@ -757,33 +757,34 @@ static int system76_add(struct acpi_device *acpi_de=
v)
> =20
>  =09err =3D input_register_device(data->input);
>  =09if (err)
> -=09=09goto error;
> +=09=09if (data->has_open_ec)
> +=09=09=09goto free_error;
> +=09=09else
> +=09=09=09return err;
> =20
>  =09if (data->has_open_ec) {
>  =09=09err =3D system76_get_object(data, "NFAN", &data->nfan);
>  =09=09if (err)
> -=09=09=09goto error;
> +=09=09=09goto free_error;
> =20
>  =09=09err =3D system76_get_object(data, "NTMP", &data->ntmp);
>  =09=09if (err)
> -=09=09=09goto error;
> +=09=09=09goto free_error;
> =20
>  =09=09data->therm =3D devm_hwmon_device_register_with_info(&acpi_dev->de=
v,
>  =09=09=09"system76_acpi", data, &thermal_chip_info, NULL);
>  =09=09err =3D PTR_ERR_OR_ZERO(data->therm);
>  =09=09if (err)
> -=09=09=09goto error;
> +=09=09=09goto free_error;
> =20
>  =09=09system76_battery_init();
>  =09}
> =20
>  =09return 0;
> =20
> -error:
> -=09if (data->has_open_ec) {
> -=09=09kfree(data->ntmp);
> -=09=09kfree(data->nfan);
> -=09}
> +free_error:
> +=09kfree(data->ntmp);
> +=09kfree(data->nfan);
>  =09return err;
>  }
> =20
>=20
--8323328-1334768247-1724152000=:1119--

