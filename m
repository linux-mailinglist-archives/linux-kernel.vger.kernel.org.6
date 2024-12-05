Return-Path: <linux-kernel+bounces-433157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1488A9E5493
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6206283979
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355C213249;
	Thu,  5 Dec 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GW5g08DJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA595212B33;
	Thu,  5 Dec 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399467; cv=none; b=ptIW79dH+q9hNBZwrAvImGMBfzNF11cS5ysioWe2NLIZseApYYVN9O9NFCgnEsHqJXkDcl8vEQyrIqMLg+hcSgbFK2vPNkK7auAw80zk6on2Ae11VjhMfqGn5Met1Uxn7wpVsB2S6sgfl+5OeZ7e34dVBnbs9Vt54L4a1iEjYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399467; c=relaxed/simple;
	bh=w9vlss7RTBIs9MOvD8aa6aZwtvGSaxV5zcY1OiUk4GE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CUI+7/sDv2ErbZadPTv63kSjD345SDh1WIWaEQs9XbGVmQ0H3ZYhulXKVhLoDaDN2M8QduKIxGLqVxZAh4H/GdR9iqH6i6kTY6cAymuO7cTgGKp2kQlaqs8wgaHqFzpYlyjkI5YV2vLsG6tFkt4c5VB2ZLeQA+MIQzIBlrwn78M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GW5g08DJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733399466; x=1764935466;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w9vlss7RTBIs9MOvD8aa6aZwtvGSaxV5zcY1OiUk4GE=;
  b=GW5g08DJ72R02tOO6FNP0kyYkha5gYWkEy62uGO2zCxoCmJXWpYGeLC2
   ICVbSbTvpZBus6MHUhFoh6lrSBFPX/DEZ52LkpTCA7ILz/Xa8wEPJHzB2
   psWlmcwdjVKhti5jRYZhPeuOkncDkL/7rkZZObcRLH1XUQhZtDzr66ZHr
   Eu54X1YqNlVms0Ny60RmBY3UPm4Oi7L/OlTDXllkRJoBYyAgDSMZYlfti
   b5Q+oRbXATTTu8JRf7X156gXnIq6subV2aAS9conoNCHVmv7L/jhj8QRB
   QGYYlMAf2IzrJV0lcElOAOny3EV0P0DTiapWHXRJSRCtlNkyKguLXD89O
   w==;
X-CSE-ConnectionGUID: je/dPIuQRcmDIjLkbB8Yvg==
X-CSE-MsgGUID: /3OcdXfoQ++EZ/gw/sDitQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33060637"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33060637"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:51:05 -0800
X-CSE-ConnectionGUID: bdhA3fSxQo+SY/Da7kwefA==
X-CSE-MsgGUID: p6K+89ywR66b8dNfmuFmBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94907867"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:50:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 13:50:53 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Alexis Belmonte <alexbelm48@gmail.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Matthew Schwartz <matthew.schwartz@linux.dev>, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v9 16/22] ACPI: platform_profile: Add concept of a "custom"
 profile
In-Reply-To: <20241202055031.8038-17-mario.limonciello@amd.com>
Message-ID: <5dd1fedf-fab5-df48-bf7c-6c4e48774602@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-17-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-401518071-1733399453=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-401518071-1733399453=:932
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 1 Dec 2024, Mario Limonciello wrote:

> When two profile handlers don't agree on the current profile it's ambiguo=
us
> what to show to the legacy sysfs interface.
>=20
> Add a "custom" profile string that userspace will be able to distinguish
> this situation when using the legacy sysfs interface.
>=20
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c  | 1 +
>  include/linux/platform_profile.h | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 40826876006b5..a9cd13c5fd39b 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -20,6 +20,7 @@ static const char * const profile_names[] =3D {
>  =09[PLATFORM_PROFILE_BALANCED] =3D "balanced",
>  =09[PLATFORM_PROFILE_BALANCED_PERFORMANCE] =3D "balanced-performance",
>  =09[PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
> +=09[PLATFORM_PROFILE_CUSTOM] =3D "custom",
>  };
>  static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
> =20
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_pr=
ofile.h
> index a888fd085c513..0682bb4c57e5d 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -23,6 +23,7 @@ enum platform_profile_option {
>  =09PLATFORM_PROFILE_BALANCED,
>  =09PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>  =09PLATFORM_PROFILE_PERFORMANCE,
> +=09PLATFORM_PROFILE_CUSTOM,
>  =09PLATFORM_PROFILE_LAST, /*must always be last */
>  };
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-401518071-1733399453=:932--

