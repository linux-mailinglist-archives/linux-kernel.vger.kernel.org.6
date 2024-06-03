Return-Path: <linux-kernel+bounces-198975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF358D7FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B7CB247F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F382D6C;
	Mon,  3 Jun 2024 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7iReV3H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25681AC7;
	Mon,  3 Jun 2024 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410568; cv=none; b=nuQ8gTwR2QB7BKRG2LCbFQHMsJcjEo84JSZrlhR6aTjLjF4M+7wH27bSDhASZNjBi7kmxGmECXAoPHm+vs9bv6IgQn5NZ+hMJhaSGhpEbD5CfdElFAA6tuZ7p1Lsb+IRWC9JBzPrAkzslI4F85Bebaf7k5a81SKVsfyabAGsKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410568; c=relaxed/simple;
	bh=lmQSpG866RDUv94ehHXXWcKpiRDbWNJ6TkCY2XcYrz4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qn8LVS/ASoKDpjYHZcTNLGOCCcQWuhYTzp81U8mjGfWl8mxdQlpJD0rCimjOJ7R+WG4otxu4iDaBpimM9rS05KAAMVzHbsseJIzVpJEOAeVa5/BOJu5NHDzRXEAW1ZH1f/aXWAmYRJO5E3MNNzIgBk0/UMai6+NUWcws2bvGhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7iReV3H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717410566; x=1748946566;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lmQSpG866RDUv94ehHXXWcKpiRDbWNJ6TkCY2XcYrz4=;
  b=a7iReV3HpR5Cwcp+Mn8WQ/JxpyehFkWiuiPy6EgQV6wWAUbkp+RzF4P2
   HKQ4IhQILqbz0JCr8nORelKweq/lAUTUCKfWT0/1ma2ZXXFIn42JOg9v8
   j08SPXkH+pMue+pMjkSY0XWiTEtpEg8w37izzCtKE5Jl4RUZoxKg0MiYt
   hUR/+xNeG42zDZhGEPe5NpdKB9VeWZcg/fp6ZOnSVhNj7HHzUVNCZbxKu
   QNIuAt92Fc2jUh7LBczeotRBBQUQczjBDkk22W/TiXt3f6NdToc3CfHtb
   bWygao+TFLmfa7fBvWZ0iFugSM3Yuh28KwS8jCb8yD7dIg5nSilF00qlj
   A==;
X-CSE-ConnectionGUID: KQ2J0k6DQeGs0LrjKMUZxw==
X-CSE-MsgGUID: M5fOQSlKS2++yGNo5Pz0cQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13734665"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="13734665"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 03:29:26 -0700
X-CSE-ConnectionGUID: WWKN+cppSTKCP5Fiaz05fA==
X-CSE-MsgGUID: Vv5gi2rOSESSThHm3aYwLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="68003982"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.161])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 03:29:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Jun 2024 13:29:21 +0300 (EEST)
To: Luke Jones <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: add support for vivobook
 fan profiles
In-Reply-To: <aee09e9f-6269-43ef-b509-a9a7b5e1752f@app.fastmail.com>
Message-ID: <f126562f-54c8-de58-3f98-7375c129f66a@linux.intel.com>
References: <20240421194320.48258-1-mohamed.ghanmi@supcom.tn> <20240421194320.48258-2-mohamed.ghanmi@supcom.tn> <de8fcb82-3e08-41e6-b099-75df27c6df23@redhat.com> <aee09e9f-6269-43ef-b509-a9a7b5e1752f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2015242583-1717410561=:1529"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2015242583-1717410561=:1529
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 3 Jun 2024, Luke Jones wrote:
> On Mon, 29 Apr 2024, at 10:20 PM, Hans de Goede wrote:
> > On 4/21/24 9:43 PM, Mohamed Ghanmi wrote:
> > > Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> > > to adjust power limits.
> > >=20
> > > These fan profiles have a different device id than the ROG series
> > > and different order. This reorders the existing modes and adds a new
> > > full speed mode available on these laptops.
> > >=20
> > > As part of keeping the patch clean the throttle_thermal_policy_availa=
ble
> > > boolean stored in the driver struct is removed and
> > > throttle_thermal_policy_dev is used in place (as on init it is zeroed=
).
> > >=20
> > > Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/platform/x86/asus-wmi.c            | 93 ++++++++++++--------=
--
> > >  include/linux/platform_data/x86/asus-wmi.h |  1 +
> > >  2 files changed, 51 insertions(+), 43 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/a=
sus-wmi.c
> > > index 3c61d75a3..1f54596ca 100644
> > > --- a/drivers/platform/x86/asus-wmi.c
> > > +++ b/drivers/platform/x86/asus-wmi.c

> > > @@ -3747,7 +3753,10 @@ static ssize_t throttle_thermal_policy_store(s=
truct device *dev,
> > >  return count;
> > >  }
> > > =20
> > > -// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> > > +/*
> > > + * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> > > + * Throttle thermal policy vivobook : 0 - default, 1 - silent, 2 - o=
verboost, 3 - fullspeed
> > > + */
> >=20
> > throttle_thermal_policy_write() always expects normal (non vivobook) va=
lues and
> > then translates those to vivo values, so this comment is not correct.
> >=20
> > The only difference is that vivobook also has fullspeed, but the way us=
erspace
> > sees it 1/2 or silent/overspeed are not swapped, since the swapping is =
taking
> > care of in throttle_thermal_policy_write().
> >=20
> > Also the new fullspeed is not exported through the platform_profile int=
erface,
> > for setting values this is somewhat ok, but fullspeed can be set throug=
h
> > sysfs, and this will then cause asus_wmi_platform_profile_get() to fail
> > with -EINVAL, so this need to be fixed. Either map fullspeed to
> > PLATFORM_PROFILE_PERFORMANCE in asus_wmi_platform_profile_get(), or add
> > a new platform_profile value for this.
> >
>=20
> I would much prefer if "fullspeed" was not included at all unless it was=
=20
> an individual setting. It very rarely contributes anything good to the=20
> driver, and most certainly won't be of value in the platform_profile.
>=20
> Otherwise, what is the status on this?=20

Hi,

I was expecting an update that addresses Hans' review comment.

Luke, are you arguing that his comment is not valid and v3 is fine?

(In any case, I've summoned v3 back from archive into active patches in=20
patchwork so this doesn't get forgotten if v4 is not needed).

--=20
 i.
--8323328-2015242583-1717410561=:1529--

