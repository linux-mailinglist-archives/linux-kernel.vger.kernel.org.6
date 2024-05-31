Return-Path: <linux-kernel+bounces-196906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D40F8D6356
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D065F1F26007
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084915B96C;
	Fri, 31 May 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSFGw6fv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461A7440B;
	Fri, 31 May 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163150; cv=none; b=Ty4+FRfwXHiM4QdPv7JqK2bgvx28NG5kOyS0GKunRnpT1W+3itP4XxG/DRo/GShrycqClOlTdLKhKgvV1jYiiYr2bsyQSyx+mss1LFtuIVF0M86w09UP+XKMVWbjpOT95B+eY15Zc+TjOfaXN3ANgFbcdzOGAb/VbBAiCsZE0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163150; c=relaxed/simple;
	bh=9gZJXbrNp53XH1tm/tfVN47+bsrWNqX6VZfq28fc84g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GfMrQJ46t7MzbLR2rAq3Cx3E1ViINs2Sbg56PUc6hISCMDu8j2aAbKtwuPOzFYEMoywQC4NgYGtv9drN1cz+ZPVm54qU3icziAJcXKa9aMCQDHRF+FZ+boo3PUthnNiKctUS7c3kmUozXWXVo7AMmGJ16y62qR2gw/hHXb2NXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSFGw6fv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717163149; x=1748699149;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9gZJXbrNp53XH1tm/tfVN47+bsrWNqX6VZfq28fc84g=;
  b=aSFGw6fvgXKcJ+sQkDaLPZsT0Z0RMiNI4Jy8Oa8bwUBnl5h9ag2W/Qg6
   CCDKTiV8yehkTfgvnww86tj7QeOOVacs9F346Ux7/oNMyFLf2TNHP9vk4
   H/uxqBvz7cYnu9CTqqIcw/G+n8l7be1PRedd7LFm+tGoMk1Da6ulKXVfK
   QGLXqW/FBckBezoC4JyhJHe7hOFW6iGD1LTlPjLwTKmr3bzTe/Ul2/IiZ
   BGgE3V5SKJTdaE/ujT47dMhDA51SPT+QewxhdeCXod2PKqG/7YwscYQ6M
   vue3l/ZTVLPvKoLw5tk9CSTlH2QuAIu6EEpFp96LxLaX/SeOgjaWUUfH3
   g==;
X-CSE-ConnectionGUID: sw/bAfg8TH2AJJywbllXuw==
X-CSE-MsgGUID: S0GtkbglTUy54LniU+9jag==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31236754"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="31236754"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:45:48 -0700
X-CSE-ConnectionGUID: KpfUPfexT76CRNRR1nJMsQ==
X-CSE-MsgGUID: X8UH6gdKTKikusRUfBslYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="41088309"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:45:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 31 May 2024 16:45:42 +0300 (EEST)
To: Tero Kristo <tero.kristo@linux.intel.com>
cc: srinivas.pandruvada@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/6] platform/x86/intel: TPMI domain id and CPU
 mapping
In-Reply-To: <20240528073457.497816-1-tero.kristo@linux.intel.com>
Message-ID: <e56885a4-3344-b9f9-92d5-33c9af00636d@linux.intel.com>
References: <8646d7dbeb507ce28b6ddca1222ee3c9892d61cc.camel@linux.intel.com> <20240528073457.497816-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1178766688-1717163142=:8458"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1178766688-1717163142=:8458
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 May 2024, Tero Kristo wrote:

> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
> Each TPMI power domain includes a group of CPUs. Several power
> management settings in this case applicable to a group of CPUs.
> There can be several power domains in a CPU package. So, provide
> interfaces for:
> - Get power domain id for a Linux CPU
> - Get mask of Linux CPUs in a power domain
>=20
> Hardware Punit uses different CPU numbering, which is not based on
> APIC (Advanced Programmable Interrupt Controller) CPU numbering.
> The Linux CPU numbering is based on APIC CPU numbering. Some PM features
> like Intel Speed Select, the CPU core mask provided by the hardware is
> based on the Punit CPU numbering. To use the core mask, this mask
> needs to be converted to a Linux CPUs mask. So, provide interfaces for:
> - Convert to a Linux CPU number from a Punit CPU number
> - Convert to a Punit CPU number from a Linux CPU number
>=20
> On each CPU online, MSR 0x54 is used to read the mapping and stores in
> a per cpu array. Create a hash for faster searching of a Linux CPU number
> from a Punit CPU number.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> [tero.kristo: minor updates]
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
> v2:
>   * changed to use X86_MATCH_VFM() instead of X86_MATCH_INTEL_FAM6_MODEL(=
)

I've applied this v2 + the other patches from v1 series now to review-ilpo=
=20
branch.

For the record, I removed "All rights reserved." lines from the patches=20
while applying. I asking first (privately) a permission from Tero whether=
=20
it's okay with him I remove those lines.

--=20
 i.

--8323328-1178766688-1717163142=:8458--

