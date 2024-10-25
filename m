Return-Path: <linux-kernel+bounces-381846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 278589B053C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86419B256C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73621FB89A;
	Fri, 25 Oct 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAWUfHFS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E41173F;
	Fri, 25 Oct 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865535; cv=none; b=op5o+lqrr9jTrRIGqx4hcEg/VQ8lqrwKzm1R5Enp/r2T3eD1pXGTbA3MlFc2SmB3KM1byV1/djNFsGIO9WCaYthvIt+I8gKHDud478gMsdgUEMkVsXgGXrTGpLBoYVdSuxhRwNrvPbh1h0Pjsyc+0F/QuIolsi8X3QRcQON3d2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865535; c=relaxed/simple;
	bh=bBUDfwxHOSTXWsEHAFL/6zzCQPfVbtVA7ZxbvpXXEwk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BgvugBrCYnJWf90W0Rv+9u+v++SdkLLynwJpxF3inI62Xg57GtssmE3cvV9GpMh1V5b5y+KCou3z7ke6vTDMlttgwa2EXTOEd8qYIOD0kEmGpx/Bhxm6eaQmQCZAS585ucJRMGNrEzFTx9JDTAIE9zyojbDlcXvv2clt1WNRM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAWUfHFS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729865533; x=1761401533;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bBUDfwxHOSTXWsEHAFL/6zzCQPfVbtVA7ZxbvpXXEwk=;
  b=jAWUfHFSIfQe0k3rXzfH7GcpG74mK2wpELxeLvJ65DMFDw88JgRPO3Oo
   mqq2urOueKkJE62rRRV5l4vlvy8D3HHn4Qex95c/O2y4zD24/yfHOUjsf
   y6VaAXpR0TC+hpZHmMDRyMG0FEzCtcGI17AckLsPGZI5RYziVwQ4eobt4
   J6jK2Ro3j1DUwH4aN0xh6guedZ70wPpevTLxe03D2jtD4+qNg4Ug5e+hK
   mIw/fvuf/SSyJDB/ve+Mkx9aX/4hMzkImnIlXBDmQ3RaxGbWQK5U7lbzc
   5q3UNn7jVnmlYx0ZqZB/4kz7haXMZhrk2dmSVzOSicwUgFzDMp6VkCNnW
   Q==;
X-CSE-ConnectionGUID: UJJT4O46QuGui8x5HUV51g==
X-CSE-MsgGUID: arP/pUK6SJ6iX1Ape0zmmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29480205"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29480205"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:12:12 -0700
X-CSE-ConnectionGUID: SQcDvA4yRQiXIkEs8NtlUw==
X-CSE-MsgGUID: 2NyAD6vBSgOk23QdvneC7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="85481009"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:12:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 17:12:05 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v8 2/4] alienware-wmi: alienware_wmax_command() is now
 input size agnostic
In-Reply-To: <20241025014108.5096-2-kuurtb@gmail.com>
Message-ID: <a727f802-9a8b-5e3c-d86f-63fbb7876cac@linux.intel.com>
References: <20241025013856.4729-2-kuurtb@gmail.com> <20241025014108.5096-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1519611876-1729865525=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1519611876-1729865525=:946
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Oct 2024, Kurt Borja wrote:

> alienware_wmax_command() now takes void * and size_t instead of struct
> wmax_basic_args to extend support to new WMAX methods. Also int *out_data
> was changed to u32 *out_data, because new interface specifies u32 as outp=
ut
> parameter and all previous callers would pass u32 * regardless.
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> v8:
>  - Unchanged
> v7:
>  - Unchanged
> v6:
>  - Unchanged
> ---
>  drivers/platform/x86/dell/alienware-wmi.c | 29 ++++++++++++-----------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform=
/x86/dell/alienware-wmi.c
> index 16a3fe9ac..b27f3b64c 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -500,15 +500,15 @@ static void alienware_zone_exit(struct platform_dev=
ice *dev)
>  =09kfree(zone_attrs);
>  }
> =20
> -static acpi_status alienware_wmax_command(struct wmax_basic_args *in_arg=
s,
> -=09=09=09=09=09  u32 command, int *out_data)
> +static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
> +=09=09=09=09=09  u32 command, u32 *out_data)
>  {
>  =09acpi_status status;
>  =09union acpi_object *obj;
>  =09struct acpi_buffer input;
>  =09struct acpi_buffer output;
> =20
> -=09input.length =3D sizeof(*in_args);
> +=09input.length =3D in_size;
>  =09input.pointer =3D in_args;
>  =09if (out_data) {
>  =09=09output.length =3D ACPI_ALLOCATE_BUFFER;
> @@ -541,8 +541,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
>  =09=09.arg =3D 0,
>  =09};
>  =09status =3D
> -=09    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> -=09=09=09=09   &out_data);
> +=09    alienware_wmax_command(&in_args, sizeof(in_args),
> +=09=09=09=09   WMAX_METHOD_HDMI_CABLE, &out_data);
>  =09if (ACPI_SUCCESS(status)) {
>  =09=09if (out_data =3D=3D 0)
>  =09=09=09return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -562,8 +562,8 @@ static ssize_t show_hdmi_source(struct device *dev,
>  =09=09.arg =3D 0,
>  =09};
>  =09status =3D
> -=09    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> -=09=09=09=09   &out_data);
> +=09    alienware_wmax_command(&in_args, sizeof(in_args),
> +=09=09=09=09   WMAX_METHOD_HDMI_STATUS, &out_data);
> =20
>  =09if (ACPI_SUCCESS(status)) {
>  =09=09if (out_data =3D=3D 1)
> @@ -589,7 +589,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
>  =09=09args.arg =3D 3;
>  =09pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
> =20
> -=09status =3D alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NUL=
L);
> +=09status =3D alienware_wmax_command(&args, sizeof(args),
> +=09=09=09=09=09WMAX_METHOD_HDMI_SOURCE, NULL);
> =20
>  =09if (ACPI_FAILURE(status))
>  =09=09pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
> @@ -642,8 +643,8 @@ static ssize_t show_amplifier_status(struct device *d=
ev,
>  =09=09.arg =3D 0,
>  =09};
>  =09status =3D
> -=09    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> -=09=09=09=09   &out_data);
> +=09    alienware_wmax_command(&in_args, sizeof(in_args),
> +=09=09=09=09   WMAX_METHOD_AMPLIFIER_CABLE, &out_data);
>  =09if (ACPI_SUCCESS(status)) {
>  =09=09if (out_data =3D=3D 0)
>  =09=09=09return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -694,8 +695,8 @@ static ssize_t show_deepsleep_status(struct device *d=
ev,
>  =09struct wmax_basic_args in_args =3D {
>  =09=09.arg =3D 0,
>  =09};
> -=09status =3D alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_ST=
ATUS,
> -=09=09=09=09=09&out_data);
> +=09status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +=09=09=09=09=09WMAX_METHOD_DEEP_SLEEP_STATUS, &out_data);
>  =09if (ACPI_SUCCESS(status)) {
>  =09=09if (out_data =3D=3D 0)
>  =09=09=09return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
> @@ -723,8 +724,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
>  =09=09args.arg =3D 2;
>  =09pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, bu=
f);
> =20
> -=09status =3D alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTR=
OL,
> -=09=09=09=09=09NULL);
> +=09status =3D alienware_wmax_command(&args, sizeof(args),
> +=09=09=09=09=09WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
> =20
>  =09if (ACPI_FAILURE(status))
>  =09=09pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
>=20
--8323328-1519611876-1729865525=:946--

