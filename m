Return-Path: <linux-kernel+bounces-282698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A594E799
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BC41F23944
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEE815445E;
	Mon, 12 Aug 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLA4ni7C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFCF45C0B;
	Mon, 12 Aug 2024 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447075; cv=none; b=DoWoDDIKs1MaM0o3gmqcyVuA8czH6gKrxXtdUldie2vWjflQNrTCCfbqZ4W7K/GCngtohRz2E974mYFGboTdreyHVHwcgURnkKJ2D8Ro/OnCGnWxqIyiKKbLRBsgxx79dVwQcFUaWihp3QSg5EWUtdHUMkhgeU0vFYVNfkvJ3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447075; c=relaxed/simple;
	bh=RBFZ13Jlu3xi/HYtrOWhQNQ6rvqTzFKmMM4PC1OWUdQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Io2YVWq9e4yFWfgvh3GY1JAeqVf6BR6bBA/PzmehXHqW6bxz0KOWobj+XYAXq8D609CwOE1+3R7quLSClRGOS2roxisUovBBJeOH868GE4JWnpFSFgruvwSJ/+e1avyEofy8MJaHZ/zXzlwuql4J0mRWqJ4ipYxgUEqQvqsOJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLA4ni7C; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723447075; x=1754983075;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RBFZ13Jlu3xi/HYtrOWhQNQ6rvqTzFKmMM4PC1OWUdQ=;
  b=bLA4ni7CjmRaoaUJCY+1nqQbh+3j0GjRqROUjiKfY8dza/ti3xrq1YXU
   x3XM1QoAQA5hnYWoxJeGCMcqFPF5SNin4d61YQWCW1rJzP3/EULOk392a
   R5cSyuwTijwr9NihssBoY9MOntU6IerVqpSE/Bnip0zToeZiI9OSCOxtF
   efhdBVC3TknDKxjSH7XzbRDLWfo9D7ANezNk5hNUUSS+eAHvth3Jwhje2
   tqKoaIOZc0swVz3xfEaso2Bdh3yloIuk/8OLD+6GOxVCKOY0LWPRyCJSc
   NIdFGIdjsUA4Tkw/isDj+48tnuP52AaFhy/M7z4lApfyX0Tw7G2k7U6lX
   Q==;
X-CSE-ConnectionGUID: K4gbUppbRRaVAJFa7mLD7g==
X-CSE-MsgGUID: uRVrhkIgTESHgtPT/EHSvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21685538"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21685538"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:17:54 -0700
X-CSE-ConnectionGUID: 9mfSvlwDT7OdKoNE6UCeog==
X-CSE-MsgGUID: hDdSFnpoTryLXFOwaIkF1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58892978"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:17:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 10:17:48 +0300 (EEST)
To: Matthias Fetzer <kontakt@matthias-fetzer.de>
cc: hmh@hmh.eng.br, Hans de Goede <hdegoede@redhat.com>, 
    ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan
 support
In-Reply-To: <5a22f1ff-44e9-4e1a-bdbe-cc168f718693@matthias-fetzer.de>
Message-ID: <456fea75-b6d2-4150-86db-ce385e2860b1@linux.intel.com>
References: <20240714165054.2261305-1-kontakt@matthias-fetzer.de> <ee9624b2-5b24-9976-4746-c622fcba21a6@linux.intel.com> <5a22f1ff-44e9-4e1a-bdbe-cc168f718693@matthias-fetzer.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1821906680-1723447068=:1039"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1821906680-1723447068=:1039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 9 Aug 2024, Matthias Fetzer wrote:
>
> Thanks for the review!
>=20
> Am 08.08.24 um 15:14 schrieb Ilpo J=C3=A4rvinen:
> > On Sun, 14 Jul 2024, Matthias Fetzer wrote:
> >=20
> > > Fan control on the E531 is done using the ACPI methods FANG and
> > > FANW. The correct parameters and register values were found by
> > > analyzing EC firmware as well as DSDT. This has been tested on
> > > my Thinkpad Edge E531 (6885CTO, BIOS HEET52WW 1.33).
> > >=20
> > > Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>

> > > @@ -8157,6 +8213,7 @@ static int fan2_get_speed(unsigned int *speed)
> > >     static int fan_set_level(int level)
> > >   {
> > > +=09int rc;
> > >   =09if (!fan_control_allowed)
> > >   =09=09return -EPERM;
> > >   @@ -8206,6 +8263,36 @@ static int fan_set_level(int level)
> > >   =09=09=09tp_features.fan_ctrl_status_undef =3D 0;
> > >   =09=09break;
> > >   +=09case TPACPI_FAN_WR_ACPI_FANW:
> > > +=09=09if ((!(level & TP_EC_FAN_AUTO) &&
> > > +=09=09    ((level < 0) || (level > 7))) ||
> > > +=09=09    (level & TP_EC_FAN_FULLSPEED))
> > > +=09=09=09return -EINVAL;
> >=20
> > I'd split this into two to make it more readable:
> >=20
> > =09=09if (!(level & TP_EC_FAN_AUTO) && (level < 0 || level > 7))
> > =09=09=09return -EINVAL;
> > =09=09if (level & TP_EC_FAN_FULLSPEED)
> > =09=09=09return -EINVAL;
>=20
> This is much better, thanks.
>=20
> >=20
> > I'm not sure if -EINVAL is really the right code to return though in th=
ese
> > cases.
> >=20
>=20
> I thought that since those are invalid values/parameters the return code =
of
> -EINVAL
> would be a good choice. What do you suggest to use instead?

Actually, now that I look into it more carefully, forget what I said.
I think -EINVAL is correct to return in these cases because the input=20
value is invalid (I previously assumed something else based on the=20
define names).

--=20
 i.

--8323328-1821906680-1723447068=:1039--

