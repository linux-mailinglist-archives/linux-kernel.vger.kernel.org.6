Return-Path: <linux-kernel+bounces-249443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0092EBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8750A1F244BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66F16C689;
	Thu, 11 Jul 2024 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAujWE0O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C38158216;
	Thu, 11 Jul 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712369; cv=none; b=m6U4m9RscXj9WL/7qKAi2XMFEfB4de/qcyduS/UG7KMYBsofCsHd9QeV+TZhTi6jJRhjFZIajOzriN8vssKzco3S6rnPsirIkYQhu3yg4cbMWHX7tn23ZARp7BoMddrruO6damzNc7zsM/rUvlvdghLo9AYlziy5/ekaFm0KjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712369; c=relaxed/simple;
	bh=JsOIQ+6zlYnI+arPAwblx/IwNzjBpZDclYFvfLYVl1Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KU65j9ePpK7gWUCiRaIblDa5AGm+Zx/JKnWoeSc5WsDqeMFNcU8looZHv4YSM/NdC8Hhw2l2ly2Bge1z1cCJWAFhH/9Dj2L6bIZ1r9lgMYICjh6nYqYH481A25cW9jPxURWmqFtQdfhiP0EiY5wpCnpz6aZ/6aU/dGITr9xozRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAujWE0O; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720712368; x=1752248368;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=JsOIQ+6zlYnI+arPAwblx/IwNzjBpZDclYFvfLYVl1Y=;
  b=jAujWE0OCGePMk076vjig/GULVsR/I2OBSgwn04h/ThWgfJnWl/r5Hmu
   n6xCajMik4qAekCs5fEbvmcYXJrAqYlvLt5mGOacebk00O5BpB06PbpZu
   W3zYCEPACj333AwfIyOMnLTl4f/r5B6PGOu0aWzEsGUdAQrwIeqem95BK
   fLAQn08b3L+WnPNm+5P98jwK38OzgFgU6SqoZJie4RUcOK/ps75DWPftb
   UfxmYYtM7kL2H7XlIeoO0oG/zuu77y15bcIC+9Nmt63H6vXeccEc3XD2T
   JwaIHziK4mCqnYsvMQ7rdDHobw2wNA+WzH79sQUAktHaE3zRE+Ct+Emsi
   w==;
X-CSE-ConnectionGUID: Qg4C5T+MRYucpUdzJ8Xsag==
X-CSE-MsgGUID: OR52RI3US8CdHLUenFIR7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17811447"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="17811447"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 08:39:12 -0700
X-CSE-ConnectionGUID: 98E922hISKC526G5AUpT/Q==
X-CSE-MsgGUID: /31FAMwSQxGxHukG3rCx6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53192636"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 08:39:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 18:39:04 +0300 (EEST)
To: Nikita Travkin <nikita@trvn.ru>
cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform: arm64: EC_ACER_ASPIRE1 should depend on
 ARCH_QCOM
In-Reply-To: <315e6f5fa10cc779ca399f6aec203c32@trvn.ru>
Message-ID: <0b67cbcd-d16a-18e3-be8c-6003d381e99f@linux.intel.com>
References: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be> <f5f38709c01d369ed9e375ceb2a9a12986457a1a.1720707932.git.geert+renesas@glider.be> <315e6f5fa10cc779ca399f6aec203c32@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1879541874-1720712289=:6262"
Content-ID: <bdeb63b0-d7fa-d6d6-053d-a1d20e0beaf2@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1879541874-1720712289=:6262
Content-Type: text/plain; CHARSET=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c97652cc-4ad3-b6e9-e3a4-5b13bcd8477a@linux.intel.com>

On Thu, 11 Jul 2024, Nikita Travkin wrote:

> Geert Uytterhoeven =D0=C9=D3=C1=CC(=C1) 11.07.2024 19:30:
> > The Acer Aspire 1 Embedded Controller is only present on the Qualcomm
> > Snapdragon-based Acer Aspire 1 laptop.  Hence add a dependency on
> > ARCH_QCOM, to prevent asking the user about this driver when configurin=
g
> > a kernel without Qualcomm SoC support.
> >=20
>=20
> Oh yeah, you're right. Thanks for fixing this!
>=20
> Acked-by: Nikita Travkin <nikita@trvn.ru>
>=20
> We should probably do the same for the C630 driver as well...

Yes, Geert sent another patch for that already.

--=20
 i.

> > Fixes: 2b3efb7c515111ea ("platform: arm64: Add Acer Aspire 1 embedded c=
ontroller driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/platform/arm64/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kc=
onfig
> > index 8c103b3150d1d0a6..058a4baa216a83b8 100644
> > --- a/drivers/platform/arm64/Kconfig
> > +++ b/drivers/platform/arm64/Kconfig
> > @@ -18,6 +18,7 @@ if ARM64_PLATFORM_DEVICES
> > =20
> >  config EC_ACER_ASPIRE1
> >  =09tristate "Acer Aspire 1 Embedded Controller driver"
> > +=09depends on ARCH_QCOM || COMPILE_TEST
> >  =09depends on I2C
> >  =09depends on DRM
> >  =09depends on POWER_SUPPLY
>=20
--8323328-1879541874-1720712289=:6262--

