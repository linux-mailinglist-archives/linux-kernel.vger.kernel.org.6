Return-Path: <linux-kernel+bounces-571407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C67EA6BCC5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D76D1899AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6419CCFA;
	Fri, 21 Mar 2025 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUq3IjCk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B1189906;
	Fri, 21 Mar 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566633; cv=none; b=XQy7Pz/EWCCzKd5XItjoYhQptcr4TOkSkdkzfzh0oumCJOawkH4GbfkZeHcCjwLuqQHF/8w6bceGz8kEGQ+7tfetJIs/bgTf6PRbHGw9/a/0pv65JswkM7PI05ISBVMjJsR7FF2npxfu1C/Jq+EpzG6fFChYcYBc55tvgFYW6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566633; c=relaxed/simple;
	bh=K9Y4DhHbfsF2dkYkvlD3D3IR3y9yChvy7gWg7lxoN0A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AihQlmaTrzOg/q2zFw+QlW3vmH2bKV9ojG6FVQCu+9wYJWuHMiOYkIeNfPABG5nDi5AJAkkdK/eUVncrvZJQNjP1/JklTrn/eUhq4ii2/ndoWffwE9asw/p2OxQR7/lXKWOxndLoOi2rfCiuJFNBVyrYZbgcG1De3hU7wJM2ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUq3IjCk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742566632; x=1774102632;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=K9Y4DhHbfsF2dkYkvlD3D3IR3y9yChvy7gWg7lxoN0A=;
  b=cUq3IjCkUJUjUpjuhSPsJ4rhwYRX/AMNwYdxdYEzO6D2VupeZBdH17j7
   3bQTM3pfw5JMBaZXQqNBhw1QFl/FGOoBHUSZZgv8Ux6JN3ci1SAFvEy2m
   S4oYRfNkk7e0B0lvoj4hAfLJf7Ty7hpmz09rDL83TzydAre1kGfiyAgQm
   7z4DeO7O2wdFNvu55DInOfqq+m3grKi6NLA5lH3cwKDZCZFCGi57dhXyZ
   5yRx9NfvznrPDXoeDAeR2+I6GhbEhpFCWMSwc0dRfHTiJQu88zFf1EWFQ
   UX+J1kzJjApIJ77d2XuUWsfZbTO7gCaNPvX2rhs9ClbFYWbsrwNU8Y/2s
   g==;
X-CSE-ConnectionGUID: r11J6rSmQdy3BqA2mM+YXA==
X-CSE-MsgGUID: OMnD5GkzTKKC92cWQ2JWVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43959363"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43959363"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:17:12 -0700
X-CSE-ConnectionGUID: 9LrzWAQUR+W4n1p/pfql7Q==
X-CSE-MsgGUID: Egv072G8S9atgrThItC1mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="128464535"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:17:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Mar 2025 16:17:06 +0200 (EET)
To: =?ISO-8859-15?Q?Ga=A8per_Nemgar?= <gasper.nemgar@gmail.com>
cc: ikepanhc@gmail.com, Hans de Goede <hdegoede@redhat.com>, 
    ilpo.jarvinen@linux.intel.com, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] Added support for a some new buttons in ideapad-laptop
 driver Added entries to unsuported wmi codes in ideapad_keymap[] and one
 check in wmi_nofify in order to get wmi code 0x13d to trigger
 platform_profile_cycle
In-Reply-To: <20250321083003.84661-1-gasper.nemgar@gmail.com>
Message-ID: <ce934c71-2220-c8f9-ff3a-5633360a8935@linux.intel.com>
References: <20250321083003.84661-1-gasper.nemgar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-733904177-1742566626=:931"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-733904177-1742566626=:931
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 21 Mar 2025, Ga=C5=A1per Nemgar wrote:

Hi Gasper,

Thanks for the patch. I think the changelog text got messed up during send=
=20
as it should here, not in the subject.

Also please change "Added support" to "Add support", add the correct=20
prefix into the shortlog (the line in Subject), and add parenthesis after=
=20
functions in the description.

--=20
 i.

> Signed-off-by: Ga=C5=A1per Nemgar <gasper.nemgar@gmail.com>"
> ---
>  drivers/platform/x86/ideapad-laptop.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86=
/ideapad-laptop.c
> index 30bd366d7..a03377d87 100644
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
> +=09{ KE_KEY,=090x45 | IDEAPAD_WMI_KEY, { KEY_BRIGHTNESS_CYCLE } },
> +=09/* Performance toggle also Fn+Q */
> +=09{ KE_KEY,=090x3d | IDEAPAD_WMI_KEY, { KEY_PROG4 } },
> +=09/* shift + prtsc */
> +=09{ KE_KEY,   0x2d | IDEAPAD_WMI_KEY, { KEY_CUT } },
> +=09{ KE_KEY,   0x29 | IDEAPAD_WMI_KEY, { KEY_TOUCHPAD_TOGGLE } },
> +=09{ KE_KEY,   0x2a | IDEAPAD_WMI_KEY, { KEY_ROOT_MENU } },
> =20
>  =09{ KE_END },
>  };
> @@ -2093,6 +2103,12 @@ static void ideapad_wmi_notify(struct wmi_device *=
wdev, union acpi_object *data)
> =20
>  =09=09dev_dbg(&wdev->dev, "WMI fn-key event: 0x%llx\n",
>  =09=09=09data->integer.value);
> +=09=09=09=09
> +=09=09/* performance button triggered by  ...  */
> +=09=09if ((data->integer.value | IDEAPAD_WMI_KEY) =3D=3D 0x13d ) {
> +=09=09=09platform_profile_cycle();
> +=09=09=09break;
> +=09=09}
> =20
>  =09=09/* 0x02 FnLock, 0x03 Esc */
>  =09=09if (data->integer.value =3D=3D 0x02 || data->integer.value =3D=3D =
0x03)
>=20

--8323328-733904177-1742566626=:931--

