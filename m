Return-Path: <linux-kernel+bounces-284264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7832494FF19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8CA1F24D72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2B757E5;
	Tue, 13 Aug 2024 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5Yrv3FM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4A7347B;
	Tue, 13 Aug 2024 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723535512; cv=none; b=HNpBczevO/0AoDwSN28v4cBBRflPFYE4zvZ10RkmBDX5yy3DK3z8lJJNOG0yILJRaVxVa54aHgNp2SJ6BkJg11B7u4lRwI9enkOHI1dVPEp7Mvektwp73l9eGPj861I2NeIlwpRgpYXkT52/i3r5pBcPr706eafLOlzinsvYbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723535512; c=relaxed/simple;
	bh=qG6R67PuNzLOMoFZrmQVHHjW2nl7BE98fXcqz2qXGt4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mxl1nsjAUJRpP8qB5prFPNclSuRBSat/Y/mu4YmPzq4ULCfeUSxNV9GtxtXTu5zSFiZoHRoMSEUJvn/4Y8rr3VnCmdouVtViBVUPuL+GS6G2H4Q3iLGKxESyd74zKuPm+fao5J/ybljHZw5CZyl3YtvvtLtKQUCeX5jNJZpr91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5Yrv3FM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723535511; x=1755071511;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=qG6R67PuNzLOMoFZrmQVHHjW2nl7BE98fXcqz2qXGt4=;
  b=C5Yrv3FMgMOGW5umeQ1sNjlGt9t//ZnjOTGeKaugpy1JJI0UR/MC55MG
   woXv0iqs9NBLLOgmXO7tQEJkg8EfEmW9WgawhlBqRbTbOv7fbCzsIPVoI
   1NybwSI/E1x0YVNuTKmoq5K0NigcAaCwZcsjGaCJyZAiDC9DpJ5Reed7v
   OS9Mgwt1GnH0m0524sBUX3hOOTq7wtZZMGgsudXfQncUsG9nrF5h8a67b
   j4FU8TzeIi4oR2KxxHAcVax2jLz44P+5drS+pd45pyVJCXuUFS0AgpfFy
   BETDKU1sL+sNXSA2CxzJBDtxpoYmMtHUBqo1MHiFPlirsRRlLe8luEi6Y
   Q==;
X-CSE-ConnectionGUID: OG0e0XKxQ/uiA+TTb1GCFQ==
X-CSE-MsgGUID: zk+2cVNPRKG/Q48M0QMm4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21538519"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21538519"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:51:50 -0700
X-CSE-ConnectionGUID: cCSlt7ccQAuBTbX1v5tAaA==
X-CSE-MsgGUID: gZz/dOTTR2SNF2ez0bNDXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58657473"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:51:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 13 Aug 2024 10:51:43 +0300 (EEST)
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Do not present separate
 package-die domain
In-Reply-To: <d21c069438cc9c314e29fe9b75a97cf15ab6e087.camel@linux.intel.com>
Message-ID: <3982985e-d8c1-7307-7187-aae438d9b75e@linux.intel.com>
References: <20240731185756.1853197-1-srinivas.pandruvada@linux.intel.com>  <cd7cc6b8-4993-937b-072b-8fbc1e309a4d@linux.intel.com> <d21c069438cc9c314e29fe9b75a97cf15ab6e087.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-806437562-1723534995=:963"
Content-ID: <8b3c0406-69ad-40eb-459e-c30612cb7799@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-806437562-1723534995=:963
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <755bd14e-122f-9313-ea0e-0af5279aa9b2@linux.intel.com>

On Mon, 12 Aug 2024, srinivas pandruvada wrote:
> On Mon, 2024-08-12 at 14:16 +0300, Ilpo J=E4rvinen wrote:
> > On Wed, 31 Jul 2024, Srinivas Pandruvada wrote:
> >=20
> > > The scope of uncore control is per power domain in a package and
> > > die.
> > > A package-die can have multiple power domains on some processors.
> > > In this
> > > case package-die domain (root domain) aggregates all information
> > > from
> > > power domains in it.
> > >=20
> > > On some processors, CPUID enumerates the die number same as power
> > > domain
> > > ID. In this case there is one to one relationship between package-
> > > die and
> > > power domain ID. There is no use of aggregating information from
> > > all
> > > power domain IDs as the information will be duplicate and
> > > confusing. In
> > > this case do not create separate package-die domain.
> >=20
> > Hi Srinivas,
> >=20
> > I got confused by this changelog because its order is quite
> > illogical.
> >=20
> > First paragraph talks about case A. When you say "all information"=20
> > is "aggregated", I immediately make the assumption that the
> > aggregated=20
> > information is what is wanted because, well, you normally want "all=20
> > information" and nothing else is being told here.
> >=20
> > Second paragraph starts to talk about case B and then suddenly
> > switches to=20
> > talk what should have been done in case A (that aggregated
> > information is=20
> > useless/confusing).
> >=20
> Is this any better:
>=20
> "
> The scope of uncore control is per power domain in a package and die
> with TPMI.
>=20
> There are two types of processor configurations possible:
> 1. A compute die is not enumerated in CPUID. In this case there is only
> one die in a package. In this case there will be multiple power domains
> in a single die.
> 2. A power domain in a package is enumerated as a compute die in CPUID.
> So there is one to one relationship between a die and power domain.

So there are multiple dies in a package and one to one relationship=20
between a die and power domain.

?

>=20
> To allow die level controls, the current implementation creates a root
> domain and aggregates all information from power domains in it. This
> is well suited for configuration 1 above.
>=20
> But when newer processors use configuration 2 above, this will present
> redundant information, So no use of aggregating. In this case do not
> create separate root domain.
> "

Yes, it is now clearer. A minor suggestion above to better map with the=20
code (explicitly stating the condition that matches to the check done
by the code).

--=20
 i.
--8323328-806437562-1723534995=:963--

