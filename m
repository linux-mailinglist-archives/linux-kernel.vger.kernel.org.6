Return-Path: <linux-kernel+bounces-576833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECEEA714E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D54A7A2EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377F11BE871;
	Wed, 26 Mar 2025 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTBQoaK+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC01AD41F;
	Wed, 26 Mar 2025 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985104; cv=none; b=aDIA1sUCrmDgG3/7k2K1iqnpNG/S0PBtVgOoes6SX1n33VlAEGCP/0Dl8Uk1RE59uSabLno9pAAIEUoJWUfdXvS7YkYGeQZhLyIxP6QrPkkfI9FOULF8Zj6P7LVrVjnU9YrufdU8NMXmxosLLZ3Opbv5cgxM/9dkcRY6ie2jXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985104; c=relaxed/simple;
	bh=WpmkBSaRc4tlBpXMtG82vVZRmhKM2sn9mTn38tQwoyY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LQCcdybarD8W1/zDVe4HhMeKXmh/O5/bLvAkiOLCMhA9aQSNUuQiJy+QLLzHl09WLI1Z+1QNbkWY96xd+0eSoYlOQe3vV/fMaLuAukL/jfIoHnoFTdgXdoP2odqPv/oOCfqhRt+RqUbQ9Dv3jhPDVmJAsFYg0+T336ChKKAqk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTBQoaK+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742985103; x=1774521103;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WpmkBSaRc4tlBpXMtG82vVZRmhKM2sn9mTn38tQwoyY=;
  b=RTBQoaK+A9qe+3JdL9HFDH+Yg54zEK4FzHsjuMWXR8a895rl8eTYs8S2
   w5HpJTRZla5LBTu4guPjLho12Dhk00L62FZy80q2/9HUKhJrAORCU40/g
   BjTT/kxXfXKMoUAMr0E2iaPtbyXdyynPpECbZGP18rZkTlIu19Z/Fs6S8
   gJ2qB8qGYIGQeCgpSt6oefMfLfMvT3XyJgQF7EwUkXTIWOUFB62iyGIyW
   UNd/zqxLI2V8qq01Q48tobbuJDQeUH34dnKFROPIUih2TuoRnv5xBijRp
   YQUJLlpC0chHXSARE0ek2rlD2PN/CsdLMjObA/W0AhcnFn9rt0lu6VyZP
   g==;
X-CSE-ConnectionGUID: LHboulYFR7Kr0fPHUb9gsg==
X-CSE-MsgGUID: sSaKdfJFRnqWmsnpTq9fpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="47917869"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="47917869"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 03:31:42 -0700
X-CSE-ConnectionGUID: yJPuqd61SCKyq5yUwbEnhg==
X-CSE-MsgGUID: dZdpunqOQsiEzzPwcwIHVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="124635419"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.5])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 03:31:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Mar 2025 12:31:36 +0200 (EET)
To: =?ISO-8859-15?Q?Ga=A8per_Nemgar?= <gasper.nemgar@gmail.com>
cc: ikepanhc@gmail.com, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] Added support for a some new buttons in ideapad-laptop
 driver
In-Reply-To: <20250326091632.23644-1-gasper.nemgar@gmail.com>
Message-ID: <9e149a4a-60b9-5524-81e8-9addf0fcf9aa@linux.intel.com>
References: <20250326091632.23644-1-gasper.nemgar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-184841007-1742985096=:942"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-184841007-1742985096=:942
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 26 Mar 2025, Ga=C5=A1per Nemgar wrote:

Hi,

Please add the driver/file specific prefix to shortlog (in Subject). You=20
can use git log --oneline file
=2E..to see what prefixes people have used before you.

> Added entries to unsuported wmi codes in ideapad_keymap[]
> and one check in wmi_nofify() in order to get wmi code 0x13d to trigger p=
latform_profile_cycle() but only if dytc exists.
>=20
> Signed-off-by: Ga=C5=A1per Nemgar <gasper.nemgar@gmail.com>"
> ---

Please also properly version the patches when sending them again, vX in=20
subject and with a changelog underneath this --- line. You can find=20
plenty of examples about the changelog from the ML archives.

Thanks.

--=20
 i.


>  drivers/platform/x86/ideapad-laptop.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86=
/ideapad-laptop.c
> index 30bd366d7..cd8c38dc8 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1308,6 +1308,16 @@ static const struct key_entry ideapad_keymap[] =3D=
 {
>  =09/* Specific to some newer models */
>  =09{ KE_KEY,=090x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
>  =09{ KE_KEY,=090x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
> +=09/* Star- (User Asignable Key) */
> +=09{ KE_KEY,=090x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
> +=09/* Eye */
> +=09{ KE_KEY,=090x45 | IDEAPAD_WMI_KEY, { KEY_PROG3 } },
> +=09/* Performance toggle also Fn+Q */
> +=09{ KE_KEY,=090x3d | IDEAPAD_WMI_KEY, { KEY_PROG4 } },
> +=09/* shift + prtsc */
> +=09{ KE_KEY,   0x2d | IDEAPAD_WMI_KEY, { KEY_CUT } },
> +=09{ KE_KEY,   0x29 | IDEAPAD_WMI_KEY, { KEY_TOUCHPAD_TOGGLE } },
> +=09{ KE_KEY,   0x2a | IDEAPAD_WMI_KEY, { KEY_ROOT_MENU } },
> =20
>  =09{ KE_END },
>  };
> @@ -2094,6 +2104,14 @@ static void ideapad_wmi_notify(struct wmi_device *=
wdev, union acpi_object *data)
>  =09=09dev_dbg(&wdev->dev, "WMI fn-key event: 0x%llx\n",
>  =09=09=09data->integer.value);
> =20
> +=09=09/* performance button triggered by  ...  */
> +=09=09if (data->integer.value =3D=3D 0x3d) {
> +=09=09=09if (priv->dytc) {
> +=09=09=09=09platform_profile_cycle();
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09}
> +
>  =09=09/* 0x02 FnLock, 0x03 Esc */
>  =09=09if (data->integer.value =3D=3D 0x02 || data->integer.value =3D=3D =
0x03)
>  =09=09=09ideapad_fn_lock_led_notify(priv, data->integer.value =3D=3D 0x0=
2);
>=20
--8323328-184841007-1742985096=:942--

