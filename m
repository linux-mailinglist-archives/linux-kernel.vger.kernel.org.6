Return-Path: <linux-kernel+bounces-197187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20008D6735
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC7928D7D5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA58179951;
	Fri, 31 May 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AO8JJnSN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47302135B;
	Fri, 31 May 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174036; cv=none; b=HADCIWRJ1rLh1eWV7GFC9/TsIwQ71B+33ANYzD7FEe6X5hJuOQ++0/rPbZsHQsdv+zlI70nAbI0TbhDh26Xgs3qETTAgcFQfIEBX+ndWJFVThZcLF5NYMv3UclQ60/j1l5Jpo8a6hgngqExJPYium7+6iA4tK/a7NlCdM/S+ezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174036; c=relaxed/simple;
	bh=2SgEjOmuNFBLLe0+7SAyTs4SGWcjz9Pq67jh9WJ2Fts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HlagHx1ztqAnarSpW5YeB2XfBbNTv62CAu9tfm/vpt6t4bIPePnsiRFBekcN6hKHJ6/vMabwvQIg34U9bap8ooY3AE1uEazH0GMecqDYQTA19mxqaw9gPkgwGoSX/sQasoS2ZTUdzdkhOnaw+MY5y/GJLuVG2JFwUmZK0niqi2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AO8JJnSN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717174035; x=1748710035;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2SgEjOmuNFBLLe0+7SAyTs4SGWcjz9Pq67jh9WJ2Fts=;
  b=AO8JJnSNh0fRZIFgWRMPugHIFT/4Mv7xfwOdN+vFTsY+X7xl+jifm5K/
   yYVZ+QfeHVADG0uRbpAW5vmMaZnAvz6TiS15mVAzjqUeyNwYNzh+bMSVU
   +lE36bh4ohXotjWUHrloax+SLjG6E5meh0PG2dpaHc+ys02qnTldsTdU8
   VH5fLjAcrZ17aoPkHUSsqawZdw5HL0tlRJ1NzFduP1jSfvntdS/C/1mqw
   N/nyJfeWiSwV0o9JkGFQEys4wFLZhhsKiExps5JfOHXPO3DGvwNg92ky+
   JgqMVMqMXpWHdeKVqSnR/IcuM/AA1/ozeBgqF5EbEF0XQX5SpI7dyvMHi
   A==;
X-CSE-ConnectionGUID: SC9SZymLSNuqO08Shf/Q5A==
X-CSE-MsgGUID: iXkBcWBGSV6XpTZIjMOXmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="24358154"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24358154"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:47:14 -0700
X-CSE-ConnectionGUID: cCaAQX5DSi6Q4UTMRDa0tw==
X-CSE-MsgGUID: 6hS50wyWTPSehV0W41e76w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="67060896"
Received: from lfiedoro-mobl.ger.corp.intel.com ([10.245.246.178])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:47:12 -0700
Message-ID: <e2ff917300939bb017b8f587a66a93022f3d1eeb.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/6] platform/x86/intel: TPMI domain id and CPU
 mapping
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: srinivas.pandruvada@linux.intel.com, Hans de Goede
 <hdegoede@redhat.com>,  platform-driver-x86@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Date: Fri, 31 May 2024 19:47:08 +0300
In-Reply-To: <e56885a4-3344-b9f9-92d5-33c9af00636d@linux.intel.com>
References: <8646d7dbeb507ce28b6ddca1222ee3c9892d61cc.camel@linux.intel.com>
	 <20240528073457.497816-1-tero.kristo@linux.intel.com>
	 <e56885a4-3344-b9f9-92d5-33c9af00636d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 16:45 +0300, Ilpo J=C3=A4rvinen wrote:
> On Tue, 28 May 2024, Tero Kristo wrote:
>=20
> > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >=20
> > Each TPMI power domain includes a group of CPUs. Several power
> > management settings in this case applicable to a group of CPUs.
> > There can be several power domains in a CPU package. So, provide
> > interfaces for:
> > - Get power domain id for a Linux CPU
> > - Get mask of Linux CPUs in a power domain
> >=20
> > Hardware Punit uses different CPU numbering, which is not based on
> > APIC (Advanced Programmable Interrupt Controller) CPU numbering.
> > The Linux CPU numbering is based on APIC CPU numbering. Some PM
> > features
> > like Intel Speed Select, the CPU core mask provided by the hardware
> > is
> > based on the Punit CPU numbering. To use the core mask, this mask
> > needs to be converted to a Linux CPUs mask. So, provide interfaces
> > for:
> > - Convert to a Linux CPU number from a Punit CPU number
> > - Convert to a Punit CPU number from a Linux CPU number
> >=20
> > On each CPU online, MSR 0x54 is used to read the mapping and stores
> > in
> > a per cpu array. Create a hash for faster searching of a Linux CPU
> > number
> > from a Punit CPU number.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > [tero.kristo: minor updates]
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > ---
> > v2:
> > =C2=A0 * changed to use X86_MATCH_VFM() instead of
> > X86_MATCH_INTEL_FAM6_MODEL()
>=20
> I've applied this v2 + the other patches from v1 series now to
> review-ilpo=20
> branch.
>=20
> For the record, I removed "All rights reserved." lines from the
> patches=20
> while applying. I asking first (privately) a permission from Tero
> whether=20
> it's okay with him I remove those lines.
>=20

Thanks Ilpo!

-Tero

