Return-Path: <linux-kernel+bounces-219181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9828490CAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2831C20ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A833156C6F;
	Tue, 18 Jun 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dvbmmilm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092415688F;
	Tue, 18 Jun 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711943; cv=none; b=uT/4ZHTzI7GC0AN99ghp1aXjTyGY/WH/2ubFoMlp5nqj80hvMjQ3IFWiXc09POtWUT17xeiAPS78jH/+zD6AUpURVYkAQ1g/u0/ndRrsrt9TXjhJIPdlO2JtP2e365Sym5Ov/CZcqyHRraFwOKgNGmv2wuFU7oyNf9axeY/YDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711943; c=relaxed/simple;
	bh=PeQStbUscq8oKm2W8Tdn0/cT+IIXSaLj/fuD/VTRdN0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OExXOthS0o8JYoWnKSG8UzhQTZ451mDFAiXFjhkMADmoeHC/AWRGnBXreGWIhgw+O3E2+sJgo+exOMUwrji6p//mbC9kTtDku42VyBBECfQg+329hJ2ifcXnhgvqAal/WmR8inZFrUSzCsZcoizatc5NAj0Y2tHkfauvpIjsweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dvbmmilm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718711941; x=1750247941;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PeQStbUscq8oKm2W8Tdn0/cT+IIXSaLj/fuD/VTRdN0=;
  b=DvbmmilmbflD/nCa54LGQWP10xGx00eLxdf906mcizWBUW8veR1fyS1g
   +mZS/woJuvJt+6ObKsc4kTKN6lObW7FSAY08fJQTSovEOlLbiBRXGMOfd
   8XPIxtGanITGAhLbE49q2FcDY7hTwc+MVkEtnP87YYjcnoIogkusBfFPl
   90j/j22omGv+58Ng5dorGVZZbowZ0ugjtbAYFBDcUjX22TUvyII8SRBGQ
   qI+jwKemK/gXwjF50dQ8GtDm8zWDzib2sblYhyNBgntcdfqIr+YL+czjA
   NK1yj3BFmTwqH50xdYODKtdggyt3cNmn/lZurAxCIkNRyiYUryBrAsW2a
   A==;
X-CSE-ConnectionGUID: RWTA3JEpTCiebxhG70obzA==
X-CSE-MsgGUID: /y2cA7+TTyWk2TNbwJ6gDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15727539"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15727539"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:59:01 -0700
X-CSE-ConnectionGUID: /z9uheBwQuyd3nSf6XhO+A==
X-CSE-MsgGUID: cNtcuSBEQryH3bVbtDzW2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="64765533"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.7])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:58:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 18 Jun 2024 14:58:54 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: matan@svgalib.org, agathe@boutmy.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] platform/x86: lg-laptop: Use ACPI device handle when
 evaluating WMAB/WMBB
In-Reply-To: <20240606233540.9774-5-W_Armin@gmx.de>
Message-ID: <60dfc0ce-ff3c-afd4-46e8-c0458e2db8d1@linux.intel.com>
References: <20240606233540.9774-1-W_Armin@gmx.de> <20240606233540.9774-5-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1937100483-1718711934=:1400"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1937100483-1718711934=:1400
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 7 Jun 2024, Armin Wolf wrote:

> On the LG Gram 16Z90S, the WMAB and WMBB ACPI methods are not mapped
> under \XINI, but instead are mapped under \_SB.XINI.
>=20
> The reason for this is that the LGEX0820 ACPI device used by this
> driver is mapped at \_SB.XINI, so the ACPI methods where moved as well
> to appear below the LGEX0820 ACPI device.
>=20
> Fix this by using the ACPI handle from the ACPI device when evaluating
> both methods.
>=20
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218901
> Tested-by: Agathe Boutmy <agathe@boutmy.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

I remember looking this through earlier but it seems I never gave a tag=20
for it...

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1937100483-1718711934=:1400--

