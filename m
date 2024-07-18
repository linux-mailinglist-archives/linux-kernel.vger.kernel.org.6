Return-Path: <linux-kernel+bounces-256142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B89349A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7800285489
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0458577F12;
	Thu, 18 Jul 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4vqdXBo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D5259C;
	Thu, 18 Jul 2024 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290628; cv=none; b=TR9NW7JLNLSkkTyxiI1wzhNPZxjXEoj5J/PFWAym0HUUZcFYQizwFNIq/0J/wGX5svT1MEPL06YUX3E8w6Z3OpjT5v1LwtgtQ9KNLTA24gMHfwwyAsYxHpEyeUvFOvk0XT+iT+zjb9hzv56wJis910hSBxAlybsnlH+cEU70tfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290628; c=relaxed/simple;
	bh=9KFE5vKKAi4vMxtGZ6yrl34SdkCq8Fi7gdAzW1B0lNs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i3BOS/6Iro6dcA+iUyWsXGxFDRqB35DCs1FnxDany3Og279cePgpW6CMsDVjqU4r7/YhGGpCRslCJLezRYUUzKRBgbCMmZA9XrmwGq3+hsvmYXKnU8gWezgTc8U/gZ3V6LL+vAhGjEFMQFGCp37oAjWW84nZVrIdQlLV21GtHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4vqdXBo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721290627; x=1752826627;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9KFE5vKKAi4vMxtGZ6yrl34SdkCq8Fi7gdAzW1B0lNs=;
  b=e4vqdXBoatuYnFVwjQ/Mb5CRCkTIQn16h9LnkGTR9na590BP1wSEu+dK
   4XZFLEGpw206Jj1kfk66435AkZc3S5Vl8F1BYP7dlOPgIiRGTNxAEOG/n
   qftIK+CggcV8TDm4XvuFGe2sgYzaFdhNi5JiiTCQ7Isl9wSpyWW9/ok2f
   PZ3MHTB5Ot5/vX3mPCzTxRTWyt8eouGHzNzLKTtt7HriOhnflcToNNjvR
   LR+KinG7xVw821vDFl3reZ2bjLqlgk2NHunsVutUIN773FasItlJRe1c8
   PRm9MFia19N8xbio9OIER67MLamaRDqn807r2JKc+/c0ptm+LbmohKtT8
   Q==;
X-CSE-ConnectionGUID: zDJbiy3qR36+N7pm6lPx5Q==
X-CSE-MsgGUID: uO4kgsZVQJqZbjn/h1ja+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18979919"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="18979919"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:17:06 -0700
X-CSE-ConnectionGUID: gJG4lUe0TqW6/zsJOe1hkw==
X-CSE-MsgGUID: +55knUx/Tpej6Ottc4hk/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="55815889"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.139])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:17:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Jul 2024 11:17:01 +0300 (EEST)
To: Hans de Goede <hdegoede@redhat.com>
cc: Gergo Koteles <soyer@irl.hu>, Ike Panhc <ike.pan@canonical.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] platform/x86: ideapad-laptop: add a mutex to
 synchronize VPC commands
In-Reply-To: <53b247e1-62cf-4289-8ad6-2138a1757e06@redhat.com>
Message-ID: <5f593905-b829-03bd-7a6a-160dea55ed46@linux.intel.com>
References: <cover.1721258854.git.soyer@irl.hu> <70d3957b315815085cdd8cb04b002cdb4a372ddc.1721258854.git.soyer@irl.hu> <06e44cdc-b984-23ea-2d89-b4489bce2c27@linux.intel.com> <53b247e1-62cf-4289-8ad6-2138a1757e06@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-692716757-1721290621=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-692716757-1721290621=:1055
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Jul 2024, Hans de Goede wrote:

> Hi,
>=20
> On 7/18/24 10:06 AM, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 18 Jul 2024, Gergo Koteles wrote:
> >=20
> >> Calling VPC commands consists of several VPCW and VPCR ACPI calls.
> >> These calls and their results can get mixed up if they are called
> >> simultaneously from different threads, like acpi notify handler,
> >> sysfs, debugfs, notification chain.
> >>
> >> Add a mutex to synchronize VPC commands.
> >>
> >> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> >> ---
> >=20
> >> @@ -2027,6 +2053,8 @@ static int ideapad_acpi_add(struct platform_devi=
ce *pdev)
> >>  =09priv->adev =3D adev;
> >>  =09priv->platform_device =3D pdev;
> >> =20
> >> +=09mutex_init(&priv->vpc_mutex);
> >> +
> >>  =09ideapad_check_features(priv);
> >> =20
> >>  =09err =3D ideapad_sysfs_init(priv);
> >=20
> > mutex_destroy() missing from rollback and ideapad_acpi_remove().
>=20
> Right, note the easiest way to fix this is to use the new devm_mutex_init=
()
> instead of plain mutex_init() that will also take care of destroying the =
mutex
> on any exit-on-error cases from probe().

Right, of course. I though one existed but it seems I tried to grep for=20
dev_mutex_init() while searching for it... :-/

--=20
 i.

--8323328-692716757-1721290621=:1055--

