Return-Path: <linux-kernel+bounces-387163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C768E9B4CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EAF9B23911
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD4318E379;
	Tue, 29 Oct 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWxgH49T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F1E18FDC5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214264; cv=none; b=oBC0/QJ7TdbNIHYRQfnvKFBLYy3HX3lme1GaO53aY2Jae/6WRUuknAErwpyAENvLzqPGLgSNKoKDOLqLbOsREw5IiDnvtSSVScfb0OGUb2Atr6i/fvcAxFPi9ePK/kChgTumT6Bd75DOeqWEfrvuVaFT2O3ci4WG8Wq22xcKLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214264; c=relaxed/simple;
	bh=uddvdTox04MIWonx0E3ByyVvSTs1E5KQlk5kFqUH7w0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PH84khUBZyicfV2hPTuoSs+8NDh0KNbkFCbyotK2gGczGyb2rEjQ4v8lhaxedj8itwmPVmm55tjMVRaN4dy3z4qy6Maqyw2T2GlSkkM6QivlC5FLtM5iX1lhYIkZ7sWmrJOdglsjh2cP8eG4UOKCvcdzUIxhLq4cttxkAKxYkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWxgH49T; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730214263; x=1761750263;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=uddvdTox04MIWonx0E3ByyVvSTs1E5KQlk5kFqUH7w0=;
  b=UWxgH49TnyeLrsUaDyu8oBiUlY9gMpv2z2VrQS4KA1H0wkUNpZdEggb7
   aqVilsV8PDQhhrsAwCUksCpzPEPgxRGa1oxmBRhs0sPfmBT6IdwN6OYde
   TiRLol4FUa4l19VccJANRsfgdbuJCdHXNjGBk6yOxeiXX5IINGoUWv6jC
   Tt8mkuaJ/QYeP5xp1/Jus2SmFs2mWzQ8Yd+T/Gj4RwPtQtXCQMq/vq4Vd
   yV82vi8/MBFMrbLBSLfVz21VtWcur8xop3suMjwCf0sbIe5I8+q2Ih8OY
   hzgP1fnUEPooFB5OeTbH/N9b70dYTV8A3QCXzoF1TuWusx677L/gA/an9
   w==;
X-CSE-ConnectionGUID: 90vv8q+DQvS5a+6WU8drdQ==
X-CSE-MsgGUID: SPnfXnlNQ+eToxMXkw48fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33560875"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33560875"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:04:22 -0700
X-CSE-ConnectionGUID: kWMp17m5RpK/5FD8uSf/nw==
X-CSE-MsgGUID: W9TreV/fTmCFq25ypiU3OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86599493"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:04:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 17:04:14 +0200 (EET)
To: Borislav Petkov <bp@alien8.de>
cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Yazen Ghannam <yazen.ghannam@amd.com>, 
    Suma Hegde <suma.hegde@amd.com>, 
    Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/amd/hsmp: fix compile-testing without
 CONFiG_AMD_NB
In-Reply-To: <20241029141157.GGZyDtLf8vdjuOORGI@fat_crate.local>
Message-ID: <5b340dde-461f-dc6f-217a-c170b913ee63@linux.intel.com>
References: <20241029092329.3857004-1-arnd@kernel.org> <20241029103316.GBZyC57KGSxyPie3Qu@fat_crate.local> <3a5360a4-e5c7-4c97-ab15-778d73f5b5a6@app.fastmail.com> <20241029110641.GFZyDBwa2o1a13Bt-T@fat_crate.local> <df0cb5c7-71ef-03ab-b0f5-7c95a4065ed4@linux.intel.com>
 <20241029141157.GGZyDtLf8vdjuOORGI@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1533313508-1730211769=:951"
Content-ID: <1d3f7ffa-aea0-746f-102d-82fe90f4c575@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1533313508-1730211769=:951
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7f3a66df-817b-b49f-cc98-631ed75c7ef4@linux.intel.com>

On Tue, 29 Oct 2024, Borislav Petkov wrote:
> On Tue, Oct 29, 2024 at 02:40:00PM +0200, Ilpo J=E4rvinen wrote:
> > I'm unfortunately left a bit unsure what exactly is your suggestion her=
e,=20
> > so could you please elaborate?
>=20
> My suggestion is, I send it to Linus now so it appears in 6.12-rc6 and th=
us
> the build error is gone in every other tree.
>=20
> > (I'm assuming the big amd_nb series will go through the x86 tree.)
>=20
> Yeah, eventually. Not now but see above: if the fix appears in mainline n=
ow,
> no problems.
>=20
> Right?

Yes, I'm fine with you sending it to Linus in this cycle. Thanks.

--=20
 i.
--8323328-1533313508-1730211769=:951--

