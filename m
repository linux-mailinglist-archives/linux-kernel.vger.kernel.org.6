Return-Path: <linux-kernel+bounces-371849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797FA9A414A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348D21F23E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C421EE03F;
	Fri, 18 Oct 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2snsFpd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA313AD39;
	Fri, 18 Oct 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262192; cv=none; b=exIgDkuBht6Z0Z19kCZ0pOWdSgmwcVZADJwRLemBKMtZ8b+Hn9xbMp58UHurj+SLlM2ltaXmsNDpzF/eDMiA1QtnPZhuRX7EhMmomNzSGZGDuMbfjj8fH4RF2erklnPoLweEJuaTGwz7dnxucblrg79CJQ30k2UgNOfnNfoXDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262192; c=relaxed/simple;
	bh=KHeVlAjHh485gIfHkzixI0Qf+VDa3OXP0pl1l9vqZMA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rL2IGdGMS53U1O5AHZVfzRXXMtPyPKee1oLzrBqZWFK3qqWHvsiCnhE+TsnfWjCobbGCZO0cQ4hsxI5eYuV7CGAZZW54AaNjoAj0tMeQuHdgEJYXx3D0Oz70pzB/EAou/ZqumvzL7y+VaKujCR1zOz9WVE8U/h7YXa60NgRS1sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2snsFpd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729262190; x=1760798190;
  h=message-id:subject:from:reply-to:to:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KHeVlAjHh485gIfHkzixI0Qf+VDa3OXP0pl1l9vqZMA=;
  b=H2snsFpdoILozX//rBocCfjS9HD3VyDg8DZ+tTKlgx1GM0qh1EtsZRrH
   1ZXNjhtoM1GIqaf40fU9BRx0MOorS1T6q3FVVBjGm6DOjmfb98RLYvL7y
   WGL+UQ3XGHf2kOgh8vuRs3XDlJoscvP7b23YJ9BkuuomyqeIglV3js2yn
   BDEyODOP2WmPLyk+bLxuk9rULLd531wsobDpMvHVv+matEnbPmDeN/9KF
   kgQ38uQsrlnnveeNoDlQQMaKftU/1fe/ZKwswBpy1obEbwb2FWKBkId7d
   tHAygWZSXzXhVHjG6yOP8mZMdBvNrQHMqwjPURPTWJp3aWIROI6ukGO4O
   Q==;
X-CSE-ConnectionGUID: +vI9t3r8Qair6dsqLu3ffg==
X-CSE-MsgGUID: gxR654caSfmqF13x3cc9AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28953297"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28953297"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:36:30 -0700
X-CSE-ConnectionGUID: 93p0DlwqQECQ4Je7TNvj6Q==
X-CSE-MsgGUID: A7z/v8f7T9SK5gFnwIxB7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79691822"
Received: from cmdeoliv-mobl.amr.corp.intel.com ([10.125.109.150])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:36:30 -0700
Message-ID: <9d72833eb5d89f5f88cb3d40a909411eabba0e2a.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86/intel/pmc: Remove unnecessary ioremap
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 18 Oct 2024 07:36:29 -0700
In-Reply-To: <20241018030357.3580487-2-david.e.box@linux.intel.com>
References: <20241018030357.3580487-1-david.e.box@linux.intel.com>
	 <20241018030357.3580487-2-david.e.box@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 20:03 -0700, David E. Box wrote:
> pmc_get_pmc() unnecessarily calls ioremap to access memory that is alread=
y
> available through a variable passed in as an argument. Replace the
> redundant ioremap call with direct use of the provided variable, and remo=
ve
> the ioremap and iounmap calls.

Woke up to a test failure on this one. I'll drop in V2 or modify after chec=
king
what I missed.

David

>=20
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> =C2=A0drivers/platform/x86/intel/pmc/core_ssram.c | 6 ------
> =C2=A01 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c
> b/drivers/platform/x86/intel/pmc/core_ssram.c
> index 70e03bd53740..d293e6e166e1 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -171,13 +171,7 @@ pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, =
void
> __iomem *ssram)
> =C2=A0	u32 dvsec_offset;
> =C2=A0	u32 table, hdr;
> =C2=A0
> -	ssram =3D ioremap(ssram_base, SSRAM_HDR_SIZE);
> -	if (!ssram)
> -		return;
> -
> =C2=A0	dvsec_offset =3D readl(ssram + SSRAM_DVSEC_OFFSET);
> -	iounmap(ssram);
> -
> =C2=A0	dvsec =3D ioremap(ssram_base + dvsec_offset, SSRAM_DVSEC_SIZE);
> =C2=A0	if (!dvsec)
> =C2=A0		return;


