Return-Path: <linux-kernel+bounces-334396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4097D6B4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC421F24D45
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB89517BB1C;
	Fri, 20 Sep 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPehk5ga"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2414B940;
	Fri, 20 Sep 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841697; cv=none; b=lzWO9nKwmX74iZCG/yrW7+iCSzMLgMCImXKTvI0LCSpAhqw3B0VDDWyNOLY1toaiXdpZW5ziXarErgRtTkXqk0TwuOWM4RI1a85AJZDKZ8ttEFxSGqmiQkP1lEQ64jZtCLJhPB4IZdSDEX36PIQSUsw6w4hjbzYUQABBeSQGYfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841697; c=relaxed/simple;
	bh=MQmmWSsT3J9MJcR2XPRfcwDZpikJkA3VFgrFGmwyo7E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bsNv1kVOYq+MZ5PlcpMEdkY7tXsvPtnuhoKz9piWnwxC806Njqy57Aj2j1mpPaWiKK7AbICIWGWo78KhExWcioCFI3kyUfgQOGaqAyN7bCUD3qzmioLLLbXTErmF8arc88GFbSkMHN0OdQmaXiERwFz3tN0OSdGEU+2uijXUBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPehk5ga; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726841695; x=1758377695;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MQmmWSsT3J9MJcR2XPRfcwDZpikJkA3VFgrFGmwyo7E=;
  b=TPehk5gaAStlCHt8xQIscTGJ98rBnP3Lum2M/eYhMe+wN5B8s8D7jjOt
   sp+7Xwh33LvxWKutHkvUYSTNVbpkW4MaIo23getSvmPijV4sHFU7LYddD
   K7xTHhpAzbKkcCHWkIXl4PjvgScKkE21QWIGhXAgyjq0tw55g89fGjR2L
   M5dNq3HOj9i+h8VIW5XqgrYNkO8U0jkZ0p9NWYj6e6Tiqi8ijYOJ/f4K4
   Rebb/MsvPwdPOX7xXV1I/nIAhaeX/6kuvwH3I+UkY4hH9jJsU9OJjwTLC
   AyHGnjRvrmkYz+2ii5ZHxxJmJMO2/OsUpxPYZa0qbnxQpkw3yb8wfl1k5
   g==;
X-CSE-ConnectionGUID: oM1P0VAIRee8kisLgvpVWg==
X-CSE-MsgGUID: r9u1GuYCT0e318Fgns3ewQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36979791"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="36979791"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:14:51 -0700
X-CSE-ConnectionGUID: nERXMEoxRzyS4gcUFACGAw==
X-CSE-MsgGUID: EAeMWWO+RHOZgmSjH2Ln/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75087976"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:14:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Sep 2024 17:14:42 +0300 (EEST)
To: WangYuli <wangyuli@uniontech.com>
cc: david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    tzimmermann@suse.de, lee.jones@linaro.org, lee@kernel.org, 
    guanwentao@uniontech.com, zhanjun@uniontech.com
Subject: Re: [PATCH v2] platform/x86/intel/pmt: Correct the typo
 'ACCCESS_LOCAL'
In-Reply-To: <CE6FFCA273A3A016+20240920140901.30524-1-wangyuli@uniontech.com>
Message-ID: <10db0939-a273-7a84-dcc9-c9b70ff7cc64@linux.intel.com>
References: <CE6FFCA273A3A016+20240920140901.30524-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-304841897-1726841682=:956"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-304841897-1726841682=:956
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 20 Sep 2024, WangYuli wrote:

> There is a spelling mistake of 'ACCCESS_LOCAL' which should be
> 'ACCESS_LOCAL'.
>=20
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Did I actually suggest the change this patch makes somewhere? I recall=20
noting the typo at one point myself but I don't remember telling anyone=20
about it.

Reviewing your patch does not itself count as a reason for adding=20
Suggested-by (unless the entire approach used in the patch is changed=20
because of a reviewer comment which is not the case here).

--=20
 i.

> Link: https://lore.kernel.org/all/26b8f38f-ff32-81fb-bbe5-aa141239427e@li=
nux.intel.com/
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/platform/x86/intel/pmt/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x8=
6/intel/pmt/class.c
> index c04bb7f97a4d..7680474c4f96 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -207,7 +207,7 @@ static int intel_pmt_populate_entry(struct intel_pmt_=
entry *entry,
>  =09=09/*
>  =09=09 * Some hardware use a different calculation for the base address
>  =09=09 * when access_type =3D=3D ACCESS_LOCAL. On the these systems
> -=09=09 * ACCCESS_LOCAL refers to an address in the same BAR as the
> +=09=09 * ACCESS_LOCAL refers to an address in the same BAR as the
>  =09=09 * header but at a fixed offset. But as the header address was
>  =09=09 * supplied to the driver, we don't know which BAR it was in.
>  =09=09 * So search for the bar whose range includes the header address.
>=20

--8323328-304841897-1726841682=:956--

