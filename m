Return-Path: <linux-kernel+bounces-308552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA02965EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8A7B26963
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577711B2EE8;
	Fri, 30 Aug 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jW5i64em"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6019046D;
	Fri, 30 Aug 2024 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012773; cv=none; b=hIctiQxOm/0cv7HvgTwZ7KND0tgDDXNc2KfSDFHE36hJNuDhBhE/P5xnivthasTfDYLluuVVE3/Tqi3WNt/6KUewIwMo18qG02kfNyiPci8EOsaw+TcTM0vnfZnW2dLy9uMKQYFhb6OwM3o1MV0iUSz2uwuEWh9RiPMLHxoEqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012773; c=relaxed/simple;
	bh=4VJPxcqs0Dl2EfOtnsV4SDBf+799gY5rOs23VbdSTOc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d1mx8slHlJGYwCOgPGrK5UA9rwkd9GylkjlKEA7YcE0/VALxZuH/De+nk8K36Tu94fgt5+V+TYXWOb6WGS15BPuZNQ6eLJn04augCe3K7aT1Nnv4fwjnEtfYjkxjov6JcWcgvUm21cJ8lfW5CPSLA5Qm5EbbGnzziAnm8mG7Rzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jW5i64em; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725012772; x=1756548772;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4VJPxcqs0Dl2EfOtnsV4SDBf+799gY5rOs23VbdSTOc=;
  b=jW5i64emxsSxmwKSRf2dOAY9zBVcQdCxS6748oCdQHD+OgJEIBiVjcLj
   I3Aliy86MlmCs4qMivvYn1IuPoHgDYBRAxdwvL6ydn9tWlLc2O715p2cH
   qAqHeYidDrWKG34t+A0YDUL/9pn7YK/BCjpEnGp4wuy/FruMp/lEnIngK
   kXyCwmhki9VECxDFLpdu71dGG1e2HB/dRxq/UwH+P74WijXX5GE8YZ3IX
   Go/CPFPC+/v0pAloM9MPHoMgXlgjwLRSCyvp+KwwXeh9T8gnAqRTTkLiD
   0Vwif8OCAVWK8f1o1esh3o0+b5+muxEk3LVrxJBIletED/VgOyau5bx5E
   A==;
X-CSE-ConnectionGUID: H1ZneO8vTo2xG+qrBMOMrg==
X-CSE-MsgGUID: bD+KwwTATlGVapjWqJleVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23813950"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23813950"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 03:12:51 -0700
X-CSE-ConnectionGUID: BGEJ1e/NSXWjf2VAoIiw1A==
X-CSE-MsgGUID: sXPLaFUWSLSvJBGmEvSlDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="63698385"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 03:12:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Aug 2024 13:12:44 +0300 (EEST)
To: Tero Kristo <tero.kristo@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>
cc: srinivas.pandruvada@linux.intel.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] Documentation: admin-guide: pm: Add efficiency
 vs. latency tradeoff to uncore documentation
In-Reply-To: <71e6475c99e193c4ae6e5d45b72b528cdf5f3f62.camel@linux.intel.com>
Message-ID: <858a908e-8218-3925-ea06-f3da256110e9@linux.intel.com>
References: <20240828153657.1296410-1-tero.kristo@linux.intel.com>  <20240828153657.1296410-2-tero.kristo@linux.intel.com>  <d4939d77-8fab-f4b6-f1f7-4af05951d3eb@linux.intel.com>  <e1d7028e69cb226acf30ed5c316e5fea20546bc4.camel@linux.intel.com>
 <71e6475c99e193c4ae6e5d45b72b528cdf5f3f62.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1240474059-1725012764=:1027"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1240474059-1725012764=:1027
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 30 Aug 2024, Tero Kristo wrote:

>    1. On Thu, 2024-08-29 at 14:39 +0300, Tero Kristo wrote:
> > On Thu, 2024-08-29 at 12:18 +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Wed, 28 Aug 2024, Tero Kristo wrote:
> > >=20
> > > > Added documentation about the functionality of efficiency vs.
> > > > latency tradeoff
> > > > control in intel Xeon processors, and how this is configured via
> > > > sysfs.
> > > >=20
> > > > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > > > ---
> > > > v2:
> > > > =C2=A0 * Largely re-wrote the documentation
> > > >=20
> > > > =C2=A0.../pm/intel_uncore_frequency_scaling.rst=C2=A0=C2=A0=C2=A0=
=C2=A0 | 59
> > > > +++++++++++++++++++
> > > > =C2=A01 file changed, 59 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/admin-
> > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > b/Documentation/admin-
> > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > index 5ab3440e6cee..26ded32b06f5 100644
> > > > --- a/Documentation/admin-
> > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > +++ b/Documentation/admin-
> > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > @@ -113,3 +113,62 @@ to apply at each uncore* level.
> > > > =C2=A0
> > > > =C2=A0Support for "current_freq_khz" is available only at each fabr=
ic
> > > > cluster
> > > > =C2=A0level (i.e., in uncore* directory).
> > > > +
> > > > +Efficiency vs. Latency Tradeoff
> > > > +-------------------------------
> > > > +
> > > > +The Efficiency Latency Control (ELC) feature improves
> > > > performance
> > > > +per watt. With this feature hardware power management algorithms
> > > > +optimize trade-off between latency and power consumption. For
> > > > some
> > > > +latency sensitive workloads further tuning can be done by SW to
> > > > +get desired performance.
> > > > +
> > > > +The hardware monitors the average CPU utilization across all
> > > > cores
> > > > +in a power domain at regular intervals and decides an uncore
> > > > frequency.
> > > > +While this may result in the best performance per watt, workload
> > > > may be
> > > > +expecting higher performance at the expense of power. Consider
> > > > an
> > > > +application that intermittently wakes up to perform memory reads
> > > > on an
> > > > +otherwise idle system. In such cases, if hardware lowers uncore
> > > > +frequency, then there may be delay in ramp up of frequency to
> > > > meet
> > > > +target performance.
> > > > +
> > > > +The ELC control defines some parameters which can be changed
> > > > from
> > > > SW.
> > > > +If the average CPU utilization is below a user defined threshold
> > > > +(elc_low_threshold_percent attribute below), the user defined
> > > > uncore
> > > > +frequency floor frequency will be used (elc_floor_freq_khz
> > > > attribute
> > >=20
> > > Consider the following simplification:
> > >=20
> > > "the user defined uncore frequency floor frequency" ->
> > > "the user-defined uncore floor frequency"
> > >=20
> > > I think it tells the same even without that first "frequency".
> > >=20
> > > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > >=20
> >=20
> > Yeah, it looks kind of silly. I think that's just a typo from my
> > side,
> > thanks for catching.
>=20
> Do you want me to send a new version of this patch or do you fix it
> locally? Rest of the patches don't seem to need any changes atm.

That's up to Hans but that looks trivial change so probably he can fix
that while applying.

Hans, v2 of this series seems ready to go (with the small change into
the documentation patch as discussed above).

--=20
 i.
--8323328-1240474059-1725012764=:1027--

