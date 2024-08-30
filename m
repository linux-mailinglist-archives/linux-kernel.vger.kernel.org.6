Return-Path: <linux-kernel+bounces-308181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F17B965854
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1171F239F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1F61586D0;
	Fri, 30 Aug 2024 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUfM1FRg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4215C157E62;
	Fri, 30 Aug 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002602; cv=none; b=R+8OrtS7cb4yY/rHC/iFqKmS6evZUcUtyeLZ1zeOwYvvc7fArk8m/3ThTLHQpBsiBSgqO6NVG55ROmmrzs9vQr7Fk58Cx/krJCZPb5N+/ReZr3XGUR6zuOkvNPAtyvu66WNb8wUrfMsgeUarRqyf5mSe70qpts4jrjYGLzd20GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002602; c=relaxed/simple;
	bh=m3trNO6/3kv8H1Kr3Ab5sIjnjpe5smg507X/97d8Jmo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mPK6Bb5EasJzI9k6O+ecteN+f2HgZmUsfRdweOn1jgdlGNAErNmByicSanjjxUtG65W881qk6rEGWGP36119hxaCFg8lOHm1LjapHyoGFqDUoxdIlvuGWPZ5hUqfNFZc6T0ZlgZfYZ1m2PV+j/UkdjDC/yUdBzRSRyhnXtqOcZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUfM1FRg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725002600; x=1756538600;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=m3trNO6/3kv8H1Kr3Ab5sIjnjpe5smg507X/97d8Jmo=;
  b=NUfM1FRgTO+F3YJIfhCfQPELQmed7Fp4m5iHvkgUx/NF6uDZJtNsbulA
   S8CzkFafl73+IVy9oqxmGOos3RYDyJ00VQ6+CWuIggaVuOz7M4ogoojCy
   ag6gXTBvRNu8jpK9zMCmybh1OocLNaDXsqw2RGz/nKIxVsZoZEf8zCV3y
   10wqH/YUBnv2V3OKbgZmmB/g60s7PAUMt74jLdOnv5+fdMEv9E+v0rIYh
   zs3GT13TWOXjSTvGBxjib74ggGk7x15ocSn2WtGijRKyvcz468q9z4Xhl
   phzNv6dIDSN+1mcDzeVuceshBmONOU6es/S0Pu3XMO8L9Q6lqAHG7GZqK
   w==;
X-CSE-ConnectionGUID: ue7BmVaTS8G2F+46vLocdw==
X-CSE-MsgGUID: 9TraXmw0SZOs1OvcAnth2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23798152"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23798152"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 00:23:19 -0700
X-CSE-ConnectionGUID: OXPr2tI7QS6Z8ItWecAdTQ==
X-CSE-MsgGUID: JqUH1ECNRfe9RA4dP49n2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="68481018"
Received: from mwiniars-desk2.ger.corp.intel.com ([10.245.246.70])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 00:23:17 -0700
Message-ID: <71e6475c99e193c4ae6e5d45b72b528cdf5f3f62.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] Documentation: admin-guide: pm: Add efficiency
 vs. latency tradeoff to uncore documentation
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 srinivas.pandruvada@linux.intel.com,  platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Date: Fri, 30 Aug 2024 10:23:14 +0300
In-Reply-To: <e1d7028e69cb226acf30ed5c316e5fea20546bc4.camel@linux.intel.com>
References: <20240828153657.1296410-1-tero.kristo@linux.intel.com>
	 <20240828153657.1296410-2-tero.kristo@linux.intel.com>
	 <d4939d77-8fab-f4b6-f1f7-4af05951d3eb@linux.intel.com>
	 <e1d7028e69cb226acf30ed5c316e5fea20546bc4.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

   1. On Thu, 2024-08-29 at 14:39 +0300, Tero Kristo wrote:
> On Thu, 2024-08-29 at 12:18 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 28 Aug 2024, Tero Kristo wrote:
> >=20
> > > Added documentation about the functionality of efficiency vs.
> > > latency tradeoff
> > > control in intel Xeon processors, and how this is configured via
> > > sysfs.
> > >=20
> > > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > > ---
> > > v2:
> > > =C2=A0 * Largely re-wrote the documentation
> > >=20
> > > =C2=A0.../pm/intel_uncore_frequency_scaling.rst=C2=A0=C2=A0=C2=A0=C2=
=A0 | 59
> > > +++++++++++++++++++
> > > =C2=A01 file changed, 59 insertions(+)
> > >=20
> > > diff --git a/Documentation/admin-
> > > guide/pm/intel_uncore_frequency_scaling.rst
> > > b/Documentation/admin-
> > > guide/pm/intel_uncore_frequency_scaling.rst
> > > index 5ab3440e6cee..26ded32b06f5 100644
> > > --- a/Documentation/admin-
> > > guide/pm/intel_uncore_frequency_scaling.rst
> > > +++ b/Documentation/admin-
> > > guide/pm/intel_uncore_frequency_scaling.rst
> > > @@ -113,3 +113,62 @@ to apply at each uncore* level.
> > > =C2=A0
> > > =C2=A0Support for "current_freq_khz" is available only at each fabric
> > > cluster
> > > =C2=A0level (i.e., in uncore* directory).
> > > +
> > > +Efficiency vs. Latency Tradeoff
> > > +-------------------------------
> > > +
> > > +The Efficiency Latency Control (ELC) feature improves
> > > performance
> > > +per watt. With this feature hardware power management algorithms
> > > +optimize trade-off between latency and power consumption. For
> > > some
> > > +latency sensitive workloads further tuning can be done by SW to
> > > +get desired performance.
> > > +
> > > +The hardware monitors the average CPU utilization across all
> > > cores
> > > +in a power domain at regular intervals and decides an uncore
> > > frequency.
> > > +While this may result in the best performance per watt, workload
> > > may be
> > > +expecting higher performance at the expense of power. Consider
> > > an
> > > +application that intermittently wakes up to perform memory reads
> > > on an
> > > +otherwise idle system. In such cases, if hardware lowers uncore
> > > +frequency, then there may be delay in ramp up of frequency to
> > > meet
> > > +target performance.
> > > +
> > > +The ELC control defines some parameters which can be changed
> > > from
> > > SW.
> > > +If the average CPU utilization is below a user defined threshold
> > > +(elc_low_threshold_percent attribute below), the user defined
> > > uncore
> > > +frequency floor frequency will be used (elc_floor_freq_khz
> > > attribute
> >=20
> > Consider the following simplification:
> >=20
> > "the user defined uncore frequency floor frequency" ->
> > "the user-defined uncore floor frequency"
> >=20
> > I think it tells the same even without that first "frequency".
> >=20
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
>=20
> Yeah, it looks kind of silly. I think that's just a typo from my
> side,
> thanks for catching.

Do you want me to send a new version of this patch or do you fix it
locally? Rest of the patches don't seem to need any changes atm.

-Tero


