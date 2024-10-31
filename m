Return-Path: <linux-kernel+bounces-390257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EC69B7796
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEF52820A7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADF61953B9;
	Thu, 31 Oct 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTDG52Ie"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D219341D;
	Thu, 31 Oct 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367272; cv=none; b=PzIe1fvXOi3JvJmt6C1nEj7NHwFEKKy811JgecmcTj6ZmiL/ZuZYrkbBqcKZ9eeE9hDIdm8ZuZN7ZuOc+z0+s6qPYG0tonyBbF4R79U1Yt2p8ob3gaitg/qd8N2I1wH5NvUtWNHEDKFB4O9X1cHA7zCKl0CaXg33njoUD+LB5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367272; c=relaxed/simple;
	bh=KzXWMDLRfMdfDQrOsNXAzug58/U0hAyF/zMB+BIyayM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eizd4dRPVmujpFrsvpxCWWBbohpyyVlxdBkRYQJJvbm8gqeD15R3uLgydsdNFC0rr5dRMPL/sbqzKAE1hhclXQS/l6aKdRTydpruK/o/lxTy0ZUsADJqMR4D0hKAlvE3CBEJ5Z7GbvOA6l6L/6QPfZ07H7EfXae+Ut2LYk7dsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTDG52Ie; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730367270; x=1761903270;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KzXWMDLRfMdfDQrOsNXAzug58/U0hAyF/zMB+BIyayM=;
  b=UTDG52IeGN14Fz0hvROkM/3u+lqB64rzRE8tglom//QYrKBPXi0+uVNZ
   5d8UYNzdWwbzx2XihQ7uqBT/n8bBuzNlPBNl55IWHLTiKPIYdwGZZMAGo
   dYUgRYnaJtVLgIcBaWUwsK7imLJl18GOBRAeBvBAPN5dVR1ypdMMEy8gd
   /zbgSmYxpcXuklQIPHGfyPgwMbgti1rSBbtgAeFsdxAE4QVU/zmli+9o8
   c1MZkf7YIQ/3TJQmG/j4dfRTCvpi14E9epjlRAHz9aPJyvwaNM9Z6NPv8
   amDp4sHwq2JeK3N5sRQ6J4FqszHjL1htZExzzDqYic7C8kf0SLHQr84O4
   g==;
X-CSE-ConnectionGUID: 0COvOGXkQ9C03vFP+ME1+w==
X-CSE-MsgGUID: ojgvXaFbROin84HqJGMWCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="32934983"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="32934983"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:34:29 -0700
X-CSE-ConnectionGUID: D8ENRO6FQTOyxff13KOEsw==
X-CSE-MsgGUID: SaWoexyeSkq5NR8DoyKrPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82501368"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:34:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 31 Oct 2024 11:34:24 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v11 0/5] Dell AWCC platform_profile support
In-Reply-To: <czxn66wpaigpyje3i3ruzcrj2j57gwlh3x2qfivoy6pnzafwj3@5jpsfs6kr7et>
Message-ID: <3823e202-7f21-02a9-267e-3cec6241a1af@linux.intel.com>
References: <20241030000904.7205-2-kuurtb@gmail.com> <f972eabf-58b5-3b0b-ea5f-930894ac840b@linux.intel.com> <2e9fb24e-9652-4087-963e-cbcf3b1f2c56@gmx.de> <czxn66wpaigpyje3i3ruzcrj2j57gwlh3x2qfivoy6pnzafwj3@5jpsfs6kr7et>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1948131612-1730367264=:939"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1948131612-1730367264=:939
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 30 Oct 2024, Kurt Borja wrote:

> On Wed, Oct 30, 2024 at 08:54:37PM +0100, Armin Wolf wrote:
> > Am 30.10.24 um 13:10 schrieb Ilpo J=E4rvinen:
> >=20
> > > On Tue, 29 Oct 2024, Kurt Borja wrote:
> > >=20
> > > > This patch adds platform_profile support for Dell devices which imp=
lement
> > > > WMAX thermal interface, that are meant to be controlled by Alienwar=
e Command
> > > > Center (AWCC). These devices may include newer Alienware M-Series, =
Alienware
> > > > X-Series and Dell's G-Series.
> > > >=20
> > > > Tested on an Alienware x15 R1.
> > > > ---
> > > > v11:
> > > >   - Minor changes on patch 4/5
> > > > v10:
> > > >   - `thermal` and `gmode` quirks are now manually selected because =
some
> > > >     models with the WMAX interface don't have the necessary thermal
> > > >     methods.
> > > >   - Added force_platform_profile and force_gmode patch for a better=
 user
> > > >     experience
> > > > v9:
> > > >   - Minor changes on patch 3/4
> > > > v8:
> > > >   - Aesthetic and readibility fixes on patch 3/4
> > > >   - Better commit message for patch 3/4
> > > > v7:
> > > >   - Platform profile implementation refactored in order to efficent=
ly
> > > >     autodetect available thermal profiles
> > > >   - Added GameShiftStatus method to documentation
> > > >   - Implemented GameShiftStatus switch for devices that support it
> > > > v6:
> > > >   - Removed quirk thermal_ustt.
> > > >   - Now quirk thermal can take canonical thermal profile _tables_ d=
efined
> > > >     in enum WMAX_THERMAL_TABLES
> > > >   - Added autodetect_thermal_profile
> > > >   - Proper removal of thermal profile
> > > > v5:
> > > >   - Better commit messages
> > > >   - insize renamed to in_size in alienware_wmax_command() to match =
other
> > > >     arguments.
> > > >   - Kudos in documentation now at the end of the file
> > > > v4:
> > > >   - Fixed indentation on previous code
> > > >   - Removed unnecessary (acpi_size) and (u32 *) casts
> > > >   - Return -EIO on ACPI_FAILURE
> > > >   - Appropiate prefixes given to macros
> > > >   - 0xFFFFFFFF named WMAX_FAILURE_CODE
> > > >   - Added support for a new set of thermal codes. Old ones now have=
 USTT
> > > >     in their names
> > > >   - A new quirk has been added to differantiate between the two set=
s.
> > > >     thermal and thermal_ustt are mutually exclusive
> > > >   - Added documentation for WMAX interface
> > > > v3:
> > > >   - Removed extra empty line
> > > >   - 0x0B named WMAX_ARG_GET_CURRENT_PROF
> > > >   - Removed casts to the same type on functions added in this patch
> > > >   - Thermal profile to WMAX argument is now an static function and =
makes
> > > >     use of in-built kernel macros
> > > >   - Platform profile is now removed only if it was created first
> > > >   - create_platform_profile is now create_thermal_profile to avoid
> > > >     confusion
> > > >   - profile_get and profile_set functions renamed too to match the =
above
> > > > v2:
> > > >   - Moved functionality to alienware-wmi driver
> > > >   - Added thermal and gmode quirks to add support based on dmi matc=
h
> > > >   - Performance profile is now GMODE for devices that support it
> > > >   - alienware_wmax_command now is insize agnostic to support new th=
ermal
> > > >     methods
> > > >=20
> > > > Kurt Borja (5):
> > > >    alienware-wmi: fixed indentation and clean up
> > > >    alienware-wmi: alienware_wmax_command() is now input size agnost=
ic
> > > >    alienware-wmi: added platform profile support
> > > >    alienware-wmi: added force module parameters
> > > >    alienware-wmi: WMAX interface documentation
> > > >=20
> > > >   Documentation/wmi/devices/alienware-wmi.rst | 388 +++++++++++++++=
+
> > > >   MAINTAINERS                                 |   1 +
> > > >   drivers/platform/x86/dell/Kconfig           |   1 +
> > > >   drivers/platform/x86/dell/alienware-wmi.c   | 477 +++++++++++++++=
+----
> > > >   4 files changed, 791 insertions(+), 76 deletions(-)
> > > >   create mode 100644 Documentation/wmi/devices/alienware-wmi.rst
> > > Huge thanks to you both Kurt and Armin for all the work done to impro=
ve
> > > this series! :-)
> > >=20
> > > I've applied this series to the review-ilpo branch now.
> >=20
> > Nice.
> >=20
> > Would it be possible to apply a small fixup to patch 4?
> > Because pr_warn("force_gmode requieres platform profile support") seems=
 to be missing a newline.
>=20
> Should I send a new patch with that fixup or v12?=20
>=20
> Kurt.

Neither. I took care of this for you inside review-ilpo branch. :-)

--=20
 i.

--8323328-1948131612-1730367264=:939--

