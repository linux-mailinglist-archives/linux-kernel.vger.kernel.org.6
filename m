Return-Path: <linux-kernel+bounces-423342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD2C9DA60C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09581645B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29076198851;
	Wed, 27 Nov 2024 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nm7/1J07"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E62192D79;
	Wed, 27 Nov 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704269; cv=none; b=fek/SQmI2jcRx7fsIKSzb8Q8/R1ybEpS0xEXMYsXlCT6Zsk7E/HH+HXqY1vivmTxf/lCVZ7la5W0VnqRiY0oaZfc6N7VBL3NWr8jPj452YyUl3eeWUdr+0CI+x21w6aKck418CJ4GTNdw/wSsEy1XaiO0T0LPy18yF7hW9pJmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704269; c=relaxed/simple;
	bh=RCfwYift9o4l7+Ap7MyKfuhE6hST1jIqGbg9B38+Km8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=odJ5yRqSImHF8YxzTiopkks0ZdbDpTcoA+Noii5nhAUVxxiyDtO0lCBWPkHxZwDF2P/CmEOmmXZeljjPNeDzsoSsXI3hanv0e4EL/7dGsG1CJZu+xi15EUAhkznrauwS73ZYSBkeIFcRFwyF3V7bZ6l9O5k8i8vJw+opsmtqSr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nm7/1J07; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732704268; x=1764240268;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RCfwYift9o4l7+Ap7MyKfuhE6hST1jIqGbg9B38+Km8=;
  b=nm7/1J07/SoCRygh7GJHZM7cTzzXKXo5jAWGu+po3F0m2pLbj86YIAhI
   F5/fTO23lWEb1U67RqwfgfvraMnxJVKiM6Pct/KBNeNFLbGbdSQtEa4mn
   2qM17wonKC/9AHDD5sGx8SIpzxzBocc9QHIjSLUugrf2WT+bS8TcrHoEy
   kCk3O3lD+DkM1qrbKXLsMkGGC6QOV0rN4z/S6XFbpUmLT1j4wUzWYxKb7
   1XI84V6xS3N7udzrbYf29USF1gTLVR/BsmhwkNPWxB3pDWHjjdcUBp3aL
   RxV2gWZha0EDZzYZ0OZWYlD7a1Lm/1CePd0/mf86qR/+GswtNzkn2xYj3
   g==;
X-CSE-ConnectionGUID: 9uUscNC5QCuZ2X2fn1PkmA==
X-CSE-MsgGUID: VhCdTy/ARbG9giwz2Czxag==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="33056610"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="33056610"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:44:28 -0800
X-CSE-ConnectionGUID: 33rGevD8QHCjWRsg4i6JcA==
X-CSE-MsgGUID: 7bEWvnWTTOGluCJP5tnM0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="91994498"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:44:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 27 Nov 2024 12:44:22 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/5] platform/x86: acer-wmi: Ignore AC events
In-Reply-To: <20241124171426.29203-6-W_Armin@gmx.de>
Message-ID: <9ea81e1d-572f-5c01-93ad-64af84973899@linux.intel.com>
References: <20241124171426.29203-1-W_Armin@gmx.de> <20241124171426.29203-6-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1642322309-1732704262=:931"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1642322309-1732704262=:931
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 24 Nov 2024, Armin Wolf wrote:

> On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
> AC connect/disconnect. Ignore those events to avoid spamming the
> kernel log with error messages.
>=20
> Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
> Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3=
b8-120c8e7afec8@gmail.com
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
>  drivers/platform/x86/acer-wmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-=
wmi.c
> index 6964fea84fa1..73243090242d 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -97,6 +97,7 @@ enum acer_wmi_event_ids {
>  =09WMID_HOTKEY_EVENT =3D 0x1,
>  =09WMID_ACCEL_OR_KBD_DOCK_EVENT =3D 0x5,
>  =09WMID_GAMING_TURBO_KEY_EVENT =3D 0x7,
> +=09WMID_AC_EVENT =3D 0x8,
>  };
>=20
>  enum acer_wmi_predator_v4_sys_info_command {
> @@ -2302,6 +2303,9 @@ static void acer_wmi_notify(union acpi_object *obj,=
 void *context)
>  =09=09if (return_value.key_num =3D=3D 0x5 && has_cap(ACER_CAP_PLATFORM_P=
ROFILE))
>  =09=09=09acer_thermal_profile_change();
>  =09=09break;
> +=09case WMID_AC_EVENT:
> +=09=09/* We ignore AC events here */
> +=09=09break;
>  =09default:
>  =09=09pr_warn("Unknown function number - %d - %d\n",
>  =09=09=09return_value.function, return_value.key_num);
> --
> 2.39.5
>=20

--8323328-1642322309-1732704262=:931--

