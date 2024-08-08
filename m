Return-Path: <linux-kernel+bounces-279428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8384694BD34
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4081B28C948
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51F618C33A;
	Thu,  8 Aug 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tydtybzz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CB1487C1;
	Thu,  8 Aug 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119376; cv=none; b=Z3fE1zWymF4YZUPb7ugCfecjj1HqA7vA+CngWrwCoooSWuQjjEL0ITL6GWG067vnfno0veAfe4E1SdaY4IeqZjrjTxw8S8UcP8kJJA0YWLevscuel608hU6r4i+XQySegHgV+dUKBuMQyd33HKzWXjlRj5rstMfg19E9tbtZe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119376; c=relaxed/simple;
	bh=I120d9Ek+PytD5jYM9eoJoL/nqLmfFNwxfWNHzPOVvs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Vh4t4sFwd3MSWyHHAIJMJFWGPRANrttqWuN0hnOWWzCxBSTHyRWWAdMv6XMDyvVoYH4R91us4ZtBn+kyfD3rfaztAaDiTpmVnu0mYYxOmgksZBd/VTG5hkLOW66Q7J5WMwgaWIi8LSLAZjHuJtOehMEsiUEKt5p4nZIuGUyo0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tydtybzz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723119375; x=1754655375;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I120d9Ek+PytD5jYM9eoJoL/nqLmfFNwxfWNHzPOVvs=;
  b=Tydtybzz5QUI6t+0BtDb3p2bkQPlrKUZezMflkmXyPgccPcMjqXgYCXu
   Vv8iY/Oo4NKsdn5N/6Cxb0EtFd7OVz1y1XD7oYaTPosUh88GMreaNCodW
   Zg07nLr2owigLLdeEoupM+Lo5wQTgADs41/cbuhNpVJy6foHUIWpCLx/F
   ojLiOuSoXwXh/iZGpjspcrlthQh52QDxrUkQNoAI8W091ZPnMW/19fPrG
   98kk7UXruyqtjBRFfAIL+l0fwJmJIg9ua8YvLUJanyLW6bV9ETSkJ6r2e
   2TwhSGeH0kjgvTeNGwdN82IPcnoO8wia5fUUv8sDRaw7CeuWBZPhwmmWt
   A==;
X-CSE-ConnectionGUID: o5g3djHUSvuq4NAu3G5Cqw==
X-CSE-MsgGUID: LkgpF9PVQVGkSBl/ZcIleA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="25032264"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="25032264"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:16:14 -0700
X-CSE-ConnectionGUID: oZoE6a/MTCS04Al3ZPa5rQ==
X-CSE-MsgGUID: x/Kk7BDzSKuAmjjJYNGVsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57161642"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.125.108.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:16:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Aug 2024 15:16:06 +0300 (EEST)
To: Gergo Koteles <soyer@irl.hu>, Hans de Goede <hdegoede@redhat.com>
cc: Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] platform/x86: ideapad-laptop: add a mutex to
 synchronize VPC commands
In-Reply-To: <4eab134fc9b9a50c4f870f4d46ddc1415d5df465.camel@irl.hu>
Message-ID: <256410ac-35e0-2f2f-3dcd-14b4b5c4c500@linux.intel.com>
References: <cover.1721898747.git.soyer@irl.hu>  <f26782fa1194ad11ed5d9ba121a804e59b58b026.1721898747.git.soyer@irl.hu>  <29153152-79de-c637-eede-0b36ce4b5222@linux.intel.com> <4eab134fc9b9a50c4f870f4d46ddc1415d5df465.camel@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-890764578-1723119366=:1044"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-890764578-1723119366=:1044
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 30 Jul 2024, Gergo Koteles wrote:
> On Tue, 2024-07-30 at 16:37 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 25 Jul 2024, Gergo Koteles wrote:
> >=20
> > > Calling VPC commands consists of several VPCW and VPCR ACPI calls.
> > > These calls and their results can get mixed up if they are called
> > > simultaneously from different threads, like acpi notify handler,
> > > sysfs, debugfs, notification chain.
> > >=20
> > > Add a mutex to synchronize VPC commands.
> > >=20
> > > Signed-off-by: Gergo Koteles <soyer@irl.hu>
> >=20
> > What commit does this fix? I was going to add a Fixes tag myself while=
=20
> > applying this but wasn't sure if it should be the ACPI concurrency comm=
it=20
> > e2ffcda16290 or the change introducing lenovo-ymc driver?
> >=20
>=20
> YMC triggering works in 6.7, but not reliably in 6.8. So I assume the
> culprit is e2ffcda16290.
>
> But in theory debugfs, sysfs, acpi notify handler can race with each
> other in the same way for 10+ years. Technically, probably not.

Okay, I decided to put both commits then as the ACPI thing made it much=20
worse so it's proper to assign some "blame" to it for the additional=20
problems it caused ;-). I also wrote an additional paragraph about it
into the commit message.

> > Also, I'd prefer to not take the move patch (PATCH 3/4) now so I could=
=20
> > take this through fixes branch since it causes a real issue if I rememb=
er=20
> > the earlier discussions right? Do you think there's any issue if I take=
=20
> > only patches 1, 2, and 4? They seemed to apply without conflicts when I=
=20
> > tried to apply the entire series and then cherrypicked the last patch=
=20
> > dropping the third patch.
> >=20
>=20
> Yes, this is a real issue.
>=20
> You can skip the third patch. The series compiles and works fine
> without it.
>=20
> > The code movement patch could go through for-next fixes branch is then=
=20
> > merged into it (or after one kernel cycle).
> >=20
> >=20
>=20
> Fine.

I've taken patches 1, 2, and 4 into review-ilpo and will propagate them=20
into fixes branch once LKP has build tested the branch.

Thanks for the patches!


As mentioned patch 3 should go to for-next which is handled by Hans in=20
this cycle. It requires merging the fixes branch (or the fixes PR tag)=20
into for-next once the other commits have migrated into fixes. I'll=20
reassign patch 3 to Hans in patchwork once I've tagged the PR to Linus.

--=20
 i.
--8323328-890764578-1723119366=:1044--

