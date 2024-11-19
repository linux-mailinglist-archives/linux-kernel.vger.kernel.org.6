Return-Path: <linux-kernel+bounces-414598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627F9D2ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC1B1F2477F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F741D04BB;
	Tue, 19 Nov 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkEUl9Mu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2913AA35;
	Tue, 19 Nov 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033363; cv=none; b=hhJnikJpv4jNbE3Sojmu8sLkHLt5m/v8/BXqGO1569RXRdLTzlS8cC9ve3WPl/N9I4Ad+qRUZt68ocREO/EPJSXqWDGGHYsOaaGCedSKsgVC0qbmOiKaxlKWJstdvXk1mJhqML1npGIMbszPbhnAPggE1p36GGVOLa1hXoSYPVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033363; c=relaxed/simple;
	bh=Q90ZRu85HoHqaLtjiKeNB0uD20LZL3CANLfe7NwUgFg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XlegiYZeOg1BdGH/9SBgOEm+tPnCPDrLBDw8iiL4lz/ag3GSRuRnpzfeg+vDN8ktEnapKimGIFuSfKQWjof2PPWzppXBeV9E/5roHFHnWAJ9iWIGZEyiGaHqKCd9Uau4yqyAkzWqZWtinSGdSJiwYV1kkV8esRF2Bq2KFGrNIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkEUl9Mu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732033362; x=1763569362;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q90ZRu85HoHqaLtjiKeNB0uD20LZL3CANLfe7NwUgFg=;
  b=hkEUl9Muh/nkXZ4wtfPcSwPSDKMAU8u2+8VdTZ5msmoISGxK0LnwoRps
   fl9geidsQDvjhQx6e8WSkll2cKpe9EPKDFgUVmi+GWkEja16Pz0IbDkEs
   jH4VcrbL27xzXrH0xGvfNhUKb3QBdtJDYjEROTYpwJU0/g7D9DmwzUGPq
   nh10hgYuvj3oe9N2Que9fzGXHafoRrLHh5qQUM2o4ePu64hQUGiP3JLFE
   D3f3tQQWbBTPrW+96srdAISZNR6TqQj5LyEb71wnAU80Ks0dT3Ol1PXNd
   0BO1ojKAaBErvSHLpZ7f/D3EicQ8Ss8gCVDTdPqrgNZoB1fJqs+inKPD5
   A==;
X-CSE-ConnectionGUID: bo9RlC39QDOBgkMgChCG+w==
X-CSE-MsgGUID: CwYo5PvvSvCcO4gMV2p9Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32103327"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32103327"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 08:22:39 -0800
X-CSE-ConnectionGUID: iD6M6vKrTFyT37gEcsjCbw==
X-CSE-MsgGUID: +4Hle7NiRYajuA/GqSSXSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89415584"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 08:22:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 Nov 2024 18:22:34 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Markus Elfring <Markus.Elfring@web.de>, 
    platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
    LKML <linux-kernel@vger.kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 4/5] alienware-wmi: Fix module init error handling
In-Reply-To: <tuqhdoqturo2yjqcxgood3xagjloctouuxc4unqwdy3uqnvjau@xqqgw6jb7ztv>
Message-ID: <31712d24-e1ae-0928-a7ab-a1f7116844ff@linux.intel.com>
References: <20241119043523.25650-1-kuurtb@gmail.com> <940b49da-cbca-42d4-9a80-501465bc8cbe@web.de> <tuqhdoqturo2yjqcxgood3xagjloctouuxc4unqwdy3uqnvjau@xqqgw6jb7ztv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1838324427-1732033354=:1015"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1838324427-1732033354=:1015
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 19 Nov 2024, Kurt Borja wrote:

> On Tue, Nov 19, 2024 at 03:55:08PM +0100, Markus Elfring wrote:
> > > Propagate led_classdev_register return value in case of error.
> > > Call led_classdev_unregister in case sysfs_create_group fails.
> > >
> > > If alienware_zone_init fails, alienware_zone_exit should not be calle=
d
> > > because the latter unregisters/removes the led class and the sysfs
> > > group, which may not be registered/created if the former failed
> > > prematurely.
> >=20
> > How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D an=
d =E2=80=9CCc=E2=80=9D) accordingly?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.12#n145
>=20
> Sure! I will on v2.
>=20
> This might be kind of obvious but, if I add the Fixes tag, do I have to
> make the patch over that commit, over stable trees or leave it as is?

Hi Kurt,

You do it normally on top of pdx86 fixes branch. In this case because of=20
the on-going merge window, you'll have for-next patch to enter there=20
before your fix will get merged after -rc1.

Don't worry about stable at this point too much, other than try to have
the fixes patches as early as possible in your series to avoid conflicts=20
with the other patches within your own patch series.

--=20
 i.

--8323328-1838324427-1732033354=:1015--

