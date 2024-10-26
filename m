Return-Path: <linux-kernel+bounces-382896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54209B149D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338A0283684
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8968415FD16;
	Sat, 26 Oct 2024 04:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPbPdLd8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33C70839;
	Sat, 26 Oct 2024 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729916596; cv=none; b=MHXjgWoUpKjsJ18mqwXJHMfGRvHzOg4G6Rh74+CvtonyuM5Bq/aC0cakKgo1IC8HUfsCn1nGq/3P2vBXQek+ja+eLoKwyawR8qdZ4q43DH/IjOH/tk8dt5fW3FJRZRGU6FfwR5dVPeeVpc9tanIYy2bPjCTzJwUHX3ja5e+UhQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729916596; c=relaxed/simple;
	bh=X21TLeYhcXvW58llg52+J1SUg3VKOChJ9BmpKkQqgig=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iG2dd7vD2Wf7By0KPBB2jPE6tfdb6w37UhAPmOFwgtoeJGpuq3AZna5o+mRuDXZYHx0RNzw6y3h1wRw6yQmooVg/1c/X1mgF9twUOo8b978+e8YLRcWqUU9cCs3PHiy2l3nLY+EA5AESkrGUshKkUzCF/lwWG0beiGSHakTHdHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPbPdLd8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729916594; x=1761452594;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=X21TLeYhcXvW58llg52+J1SUg3VKOChJ9BmpKkQqgig=;
  b=QPbPdLd8ZbKUzDmna2d8vU/utyJoKs4ZAbR21nbi5jX6HqJ456a153LU
   pSY3ySfv0NFngaIe3DJUoUQFMI1dJ7hkUJtwqoiBF1rHkwhrSrY8Fhkdl
   B95YxBmJsieP8i5bCJm7CCI14mJePMob3a3PuUeIthgLddj8VqEjnbL+m
   ZsqqARKfbpUdNAHgJeQTe2YeX+yxAn3nlaENQ4Vdjphh+K6Qii1Nivn6J
   0SfKlv3kMNC8rJAPP+rWxRw57JsUXMWen/rdtQLYHlcZv4KZIlxHkRvn8
   geSZZASF4TC2mtg8ljOJpmlQA+mTJ70rM4n5g69/kp1PkdWVniPJVi8g3
   w==;
X-CSE-ConnectionGUID: mjF4X6CrT7C8XvOtFrNrhw==
X-CSE-MsgGUID: z/AqL/N2Rtmkp+iwfzLivQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29809882"
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="29809882"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 21:23:13 -0700
X-CSE-ConnectionGUID: BKJpeE/TSCK0oOAYDr9vMg==
X-CSE-MsgGUID: a1WlinRTTz2fxdeZcHDSzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="86219176"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 21:23:14 -0700
Message-ID: <e93008e918a807096ebf8b204b1c2750593f7d8e.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Fix thermal profile
 initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>, corentin.chary@gmail.com, luke@ljones.dev, 
	mohamed.ghanmi@supcom.tn
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 Michael@phoronix.com,  casey.g.bowman@intel.com,
 platform-driver-x86@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2024 21:23:12 -0700
In-Reply-To: <20241025191514.15032-2-W_Armin@gmx.de>
References: <20241025191514.15032-1-W_Armin@gmx.de>
	 <20241025191514.15032-2-W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 21:15 +0200, Armin Wolf wrote:
> When support for vivobook fan profiles was added, the initial
> call to throttle_thermal_policy_set_default() was removed, which
> however is necessary for full initialization.
>=20
> Fix this by calling throttle_thermal_policy_set_default() again
> when setting up the platform profile.
>=20
> Fixes: bcbfcebda2cb ("platform/x86: asus-wmi: add support for
> vivobook fan profiles")
> Reported-by: Michael Larabel <Michael@phoronix.com>

For Michael to understand how this patch is related:

When Michael did test on 6.11 based kernel, there was no platform
profile support for the new Asus laptop. So the default boot Whisper
mode was active all the time.
My AIPT patch addressed that issue using FANL method.

But for 6.12 cycle, Mohamed added VIVO profile, which will also work
with the new laptop with AIPT even though the names of the profiles
don't match with the AIPT modes. But that patch removed the setting of
default policy in hardware to AIPT "standard" or 0 for VIVO default. So
mode was still whisper.

So this patch will address that.

Thanks,
Srinivas




> Closes: https://www.phoronix.com/review/lunar-lake-xe2/5
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> =C2=A0drivers/platform/x86/asus-wmi.c | 10 ++++++++++
> =C2=A01 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/platform/x86/asus-wmi.c
> b/drivers/platform/x86/asus-wmi.c
> index 2ccc23b259d3..ab9342a01a48 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3908,6 +3908,16 @@ static int platform_profile_setup(struct
> asus_wmi *asus)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!asus->throttle_therm=
al_policy_dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We need to set the default =
thermal profile during probe or
> otherwise
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the system will often remai=
n in silent mode, causing low
> performance.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D throttle_thermal_polic=
y_set_default(asus);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0pr_warn("Failed to set default thermal profile\n");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return err;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_info(dev, "Using thro=
ttle_thermal_policy for
> platform_profile support\n");
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0asus->platform_profile_ha=
ndler.profile_get =3D
> asus_wmi_platform_profile_get;
> --
> 2.39.5
>=20


