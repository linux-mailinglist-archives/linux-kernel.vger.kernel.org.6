Return-Path: <linux-kernel+bounces-302838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0907960407
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27F7B2319B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF5019342E;
	Tue, 27 Aug 2024 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHCAFyG7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4EE188A07;
	Tue, 27 Aug 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746117; cv=none; b=IN8uHWpTV+h0gdq+uCJK2Fuha3drEok/5AiRhSR+LAvQ01wgXJGoqCogiZgic3TXhnCdDJ3vkw4/S/yuHRJJzdaOUPTjKR64VI9whDxs5mhS4ZmzucbIcCtJN2dxeipk1rZDqr/GVfWjtexxZ7nmZpk9yu4PhcnadEJ5qLteHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746117; c=relaxed/simple;
	bh=6QyNSCtVne8j2Iv8bb4KJ2Se3bHEjzVc7h5UcZ3sZpc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QfrN2bX/cG82fhXnbqCLoVIu64hON1W2RqVUO8REybkqNPPJ4kAiyTyIKzodjnafvVWNXH0iMYmC1NrskDLDPAnQUyqRvdBhX9ozz6OpAwMiPI7jN/S+MunJOrLboxvaOEFt6VYliyp1SimINliwxKM11GVzFzulVt0fD8B2mWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHCAFyG7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724746115; x=1756282115;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=6QyNSCtVne8j2Iv8bb4KJ2Se3bHEjzVc7h5UcZ3sZpc=;
  b=NHCAFyG7NlnCIAK5vUJMZt50uIgLCjbNgau6sGE3cSPag5P5PNpD4z51
   WVHz7DZIaiQFZGBiMyZChZZfVju/6hTMlvunYEf9gDz8ABo7GkAyQWEdN
   GMTksu9wkoXxfC6MdM46ULKGKV/BsdPSUucWWJJZTVhdAEptqikWWuxsr
   MYOqz2o+yR1CeI4H58XTh4mFIjfGnzrpJngX3CeKnalNesPfzd8TrtgG9
   /dTpmU55mLet3SbDohpWCbLdYIAbw2ifhEBC6+iwKBe0IyRYUlazBIfc0
   EabSlX4+lZwTl/ALG0g9NOM+vcnrUpr1fCeBn1oGDeQqlzO/wIlZdGe0X
   w==;
X-CSE-ConnectionGUID: q//FtXr/RiyNSn7VePSLdQ==
X-CSE-MsgGUID: bZuimOooTGKmN5VyrH/fqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="27087975"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="27087975"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:08:20 -0700
X-CSE-ConnectionGUID: GzeZjBpCRrqx8slZSUbgFA==
X-CSE-MsgGUID: afjchFm3Txyf2XBTI7/BRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62771546"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.17])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:08:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Aug 2024 11:08:14 +0300 (EEST)
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Tero Kristo <tero.kristo@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] Documentation: admin-guide: pm: Add efficiency vs.
 latency tradeoff to uncore documentation
In-Reply-To: <4d6adc49f295ad1dec26cd1a67ec3997686db4a9.camel@linux.intel.com>
Message-ID: <1b93f71a-8a36-f95e-86b9-2b8f330847ff@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com>  <20240821131321.824326-2-tero.kristo@linux.intel.com>  <dabdc81e-d743-6402-f87a-dee2d6b906b8@linux.intel.com> <4d6adc49f295ad1dec26cd1a67ec3997686db4a9.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2022932102-1724743224=:1032"
Content-ID: <ee1b46c7-296b-e2bc-62fc-4699f5a41fae@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2022932102-1724743224=:1032
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <cfaee1d8-f5e0-3686-663f-cad5d0ab3dbe@linux.intel.com>

On Mon, 26 Aug 2024, srinivas pandruvada wrote:

> On Fri, 2024-08-23 at 15:28 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 21 Aug 2024, Tero Kristo wrote:
> >=20
> > > Added documentation about the functionality of efficiency vs.
> > > latency tradeoff
> > > control in intel Xeon processors, and how this is configured via
> > > sysfs.
> > >=20
> > > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > > ---
> > > =C2=A0.../pm/intel_uncore_frequency_scaling.rst=C2=A0=C2=A0=C2=A0=C2=
=A0 | 51
> > > +++++++++++++++++++
> > > =C2=A01 file changed, 51 insertions(+)
> > >=20
> > > diff --git a/Documentation/admin-
> > > guide/pm/intel_uncore_frequency_scaling.rst b/Documentation/admin-
> > > guide/pm/intel_uncore_frequency_scaling.rst
> > > index 5ab3440e6cee..fb83aa2b744e 100644
> > > --- a/Documentation/admin-
> > > guide/pm/intel_uncore_frequency_scaling.rst
> > > +++ b/Documentation/admin-
> > > guide/pm/intel_uncore_frequency_scaling.rst
> > > @@ -113,3 +113,54 @@ to apply at each uncore* level.
> > > =C2=A0
> > > =C2=A0Support for "current_freq_khz" is available only at each fabric
> > > cluster
> > > =C2=A0level (i.e., in uncore* directory).
> > > +
> > > +Efficiency vs. Latency Tradeoff
> >=20
> > Does this section even cover the "tradeoff" part in its body? Why not
> > call=20
> > it directly "Control" after ELC?
> >=20
> > > +-------------------------------
> > > +
> > > +In the realm of high-performance computing, particularly with Xeon
> > > +processors, managing uncore frequency is an important aspect of
> > > system
> > > +optimization. Traditionally, the uncore frequency is ramped up
> > > rapidly
> > > +in high load scenarios. While this strategy achieves low latency,
> > > which
> > > +is crucial for time-sensitive computations, it does not
> > > necessarily yield
> > > +the best performance per watt, =E2=80=94a key metric for energy effi=
ciency
> > > and
> > > +operational cost savings.
> >=20
> > This entire paragraph feels more prose or history book than
> > documentation=20
> > text. I'd suggest using something that goes more directly into the
> > point
> > about what ELC brings to the table (I suppose the goal is
> > "performance=20
> > per watt" optimization, even that goal is only implied by the current
> > text, not explicitly stated as the goal here).
> >=20
>=20
> What about this?
>=20
> Traditionally, the uncore frequency is ramped up to reach the maximum=20
> possible level based on parameters like EPB (Energy perf Bias) and
> other system power management settings programmed by BIOS.  While this
> strategy achieves low latency for latency sensitive applications, it
> does not necessarily yield the best performance per watt.=20

This again starts with a wrong foot. Don't use words like "traditionally",
"in the past", "historically", "is added", etc. that refer to past time
in documentation text at all. The premise with documentation for feature x=
=20
is that the feature x exists. After these patches have been accepted, the=
=20
reality is that ELC exists and time before does not matter so we don't=20
encumber documentation text with that era that has become irrelevant.

You might occasionally have to mention what is not possible without ELC=20
in case it's still possible to run stuff without ELC but don't put time=20
references to it. However, it's not something you should start with in
the documentation text.

> The Efficiency Latency Control (ELC) feature is added to improve

"is added to improve" -> "improves"

> performance per watt. With this feature hardware power management
> algorithms optimize trade-off between latency and power consumption.
> But for some latency sensitive workloads further tuning can be done
> from OS to get desired performance.

I'd just start with this paragraph. It goes straight into the point and=20
is good in that it tries to summarize what ELC tries to achieve.

> The hardware monitors the average CPU utilization across all cores

hardware or ELC-capable HW?

> in a power domain at regular intervals and decides a uncore frequency.=20

This kind of feels something that belongs to the first paragraph if it's=20
about ELC. (I'm left slightly unsure if ELC refers only to those controls=
=20
mentioned below, or if it is the automatic uncore freq control plus the=20
manual controls. I assume it's the latter because of "with this feature=20
hardware power management algorithms optimize" sentence.)

> While this may result in the best performance per watt, workload may be
> expecting higher performance at the expense of power. Consider an
> application that intermittently wakes up to perform memory reads on an
> otherwise idle system. In such cases, if hardware lowers uncore
> frequency, then there may be delay in ramp up of frequency to meet
> target performance.=20
>
> The ELC control defines some parameters which can be changed from OS.
> If the average CPU utilization is below a user defined threshold
> (elc_low_threshold_percent attribute below), the user defined uncore
> frequency floor frequency will be used (elc_floor_freq_khz attribute=20
> below) instead of hardware calculated minimum.=20
>
> Similarly in high load scenario where the CPU utilization goes above=20
> the high threshold value (elc_high_threshold_percent attribute below)=20
> instead of jumping to maximum uncore frequency, uncore frequency is=20
> increased in 100MHz steps until the power limit is reached.
>
> Attributes for efficiency latency control:=20
> ..=20
> ..=20

There were a few spaces at the end if lines, those should be removed.

--=20
 i.
--8323328-2022932102-1724743224=:1032--

