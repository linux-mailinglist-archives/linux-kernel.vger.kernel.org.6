Return-Path: <linux-kernel+bounces-303450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6061960C35
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2281F21D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C421C4621;
	Tue, 27 Aug 2024 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y460HW05"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DA1C4607;
	Tue, 27 Aug 2024 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765680; cv=none; b=KLG6TrBWLSUVSAWi5PRMiFo2JiZQq4Ga95E0vaMWlpszK1Xm2ddURss4kX1IZvcxpP57Q7K3ng0MzP4yBat1evJkaIUhBr/jmOj6OeQ0KHEGYunaijsMHkZadsNci43uenCBCC75qU26GYGf+YS2FjDppSxSUtH0uyVElQbPZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765680; c=relaxed/simple;
	bh=0Ti4uEyQ2I50MDalNEldb+1diVigldzU50iZRu2XaRc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X8HAZEXkOXfOrEaU2ybPW5xXBqbVgmMJtTXV8+yHc9yYawQmLy0msVGwz2l+FEgeSYGVXpBtN7XX2xqx3TL183h4haTNobQcCMxveqdfZE/4+QiSDHGdulYX8/BGXA4dxPW6A4IZBj0uUwd4Ps7LQW2PdRYL9LlpZubfkp4mSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y460HW05; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724765679; x=1756301679;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=0Ti4uEyQ2I50MDalNEldb+1diVigldzU50iZRu2XaRc=;
  b=Y460HW05urgLc58sdaUb/sem9OPiVNIQrIBotAgtWfTx6XCLysqGlR3T
   1f3n9YltTKN5LyZdA45v/AUbjly2H5jFBjzPWqCBlsnesnxSHB9WwkQKR
   s7A6r8ALYMS3NCYIkoUK8hF2hp8Na0wr2uqo+MxQ+8hZZq1RcZqAgmKG6
   8FqDzZmX6tfMjEIhhDMTwwGNYbZxO+s1II8XMnimsqs810kZUb4JkD/kA
   LuyQOX4n+jOCiRsOwouGQ29xRPfnnz91polc0rctBrtuw+x6CPsLnaZ0D
   ZO3Vrw+mmPH0+GUrHUDgDanLWz6VGcmkkHnUAyIGYpCrXyj6/5LnjptTr
   A==;
X-CSE-ConnectionGUID: 5r3J07lNQvS4rGfLXEdIAA==
X-CSE-MsgGUID: 2sryGk1QS3WlQWAezVk3wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="27039481"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="27039481"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:34:38 -0700
X-CSE-ConnectionGUID: wAuaROIJRciiS4KJn6ef0w==
X-CSE-MsgGUID: iO9iqxTwTvi6QeStW1YrqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63581868"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.17])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:34:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Aug 2024 16:34:32 +0300 (EEST)
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Tero Kristo <tero.kristo@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] Documentation: admin-guide: pm: Add efficiency vs.
 latency tradeoff to uncore documentation
In-Reply-To: <8719e7653b2f859c46966986dc81cc589a6d78ca.camel@linux.intel.com>
Message-ID: <4fc760c8-c96c-65e3-1984-d1703a364d05@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com>  <20240821131321.824326-2-tero.kristo@linux.intel.com>  <dabdc81e-d743-6402-f87a-dee2d6b906b8@linux.intel.com>  <4d6adc49f295ad1dec26cd1a67ec3997686db4a9.camel@linux.intel.com> 
 <1b93f71a-8a36-f95e-86b9-2b8f330847ff@linux.intel.com> <8719e7653b2f859c46966986dc81cc589a6d78ca.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-147178893-1724761709=:1032"
Content-ID: <84e87109-ece5-8d3b-adee-03765a695973@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-147178893-1724761709=:1032
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <ed2ae428-6131-2dbb-97ba-592401259e85@linux.intel.com>

On Tue, 27 Aug 2024, srinivas pandruvada wrote:
> On Tue, 2024-08-27 at 11:08 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 26 Aug 2024, srinivas pandruvada wrote:
> >=20
> > > On Fri, 2024-08-23 at 15:28 +0300, Ilpo J=C3=A4rvinen wrote:
> > > > On Wed, 21 Aug 2024, Tero Kristo wrote:
> > > >=20
> > > > > Added documentation about the functionality of efficiency vs.
> > > > > latency tradeoff
> > > > > control in intel Xeon processors, and how this is configured
> > > > > via
> > > > > sysfs.
> > > > >=20
> > > > > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > > > > ---
> > > > > =C2=A0.../pm/intel_uncore_frequency_scaling.rst=C2=A0=C2=A0=C2=A0=
=C2=A0 | 51
> > > > > +++++++++++++++++++=E2=81=A0Ayoub,=C2=A0Hatim=C2=A0This seems tha=
t when on AC
> > > > > mode, Windows don't care about PC10. Is this correct? It seems
> > > > > that with EPB=3D6 we can
> > > > > =C2=A01 file changed, 51 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/admin-
> > > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > > b/Documentation/admin-
> > > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > > index 5ab3440e6cee..fb83aa2b744e 100644
> > > > > --- a/Documentation/admin-
> > > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > > +++ b/Documentation/admin-
> > > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > > @@ -113,3 +113,54 @@ to apply at each uncore* level.
> > > > > =C2=A0
> > > > > =C2=A0Support for "current_freq_khz" is available only at each
> > > > > fabric
> > > > > cluster
> > > > > =C2=A0level (i.e., in uncore* directory).
> > > > > +
> > > > > +Efficiency vs. Latency Tradeoff
> > > >=20
> > > > Does this section even cover the "tradeoff" part in its body? Why
> > > > not
> > > > call=20
> > > > it directly "Control" after ELC?
> > > >=20
> > > > > +-------------------------------
> > > > > +
> > > > > +In the realm of high-performance computing, particularly with
> > > > > Xeon
> > > > > +processors, managing uncore frequency is an important aspect
> > > > > of
> > > > > system
> > > > > +optimization. Traditionally, the uncore frequency is ramped up
> > > > > rapidly
> > > > > +in high load scenarios. While this strategy achieves low
> > > > > latency,
> > > > > which
> > > > > +is crucial for time-sensitive computations, it does not
> > > > > necessarily yield
> > > > > +the best performance per watt, =E2=80=94a key metric for energy
> > > > > efficiency
> > > > > and
> > > > > +operational cost savings.
> > > >=20
> > > > This entire paragraph feels more prose or history book than
> > > > documentation=20
> > > > text. I'd suggest using something that goes more directly into
> > > > the
> > > > point
> > > > about what ELC brings to the table (I suppose the goal is
> > > > "performance=20
> > > > per watt" optimization, even that goal is only implied by the
> > > > current
> > > > text, not explicitly stated as the goal here).
> > > >=20
> > >=20
> > > What about this?
> > >=20
> > > Traditionally, the uncore frequency is ramped up to reach the
> > > maximum=20
> > > possible level based on parameters like EPB (Energy perf Bias) and
> > > other system power management settings programmed by BIOS.=C2=A0 Whil=
e
> > > this
> > > strategy achieves low latency for latency sensitive applications,
> > > it
> > > does not necessarily yield the best performance per watt.=20
> >=20
> > This again starts with a wrong foot. Don't use words like
> > "traditionally",
> > "in the past", "historically", "is added", etc. that refer to past
> > time
> > in documentation text at all. The premise with documentation for
> > feature x=20
> > is that the feature x exists. After these patches have been accepted,
> > the=20
> > reality is that ELC exists and time before does not matter so we
> > don't=20
> > encumber documentation text with that era that has become irrelevant.
> >=20
> While the choice of words are not correct, for me background is
> important on why a feature is implemented.
> Here even after ELC is implemented, majority of generations will still
> not have this feature. Uncore is not just supported on TPMI systems.

I don't doubt there are plenty of systems without it, but you're=20
supposed to document ELC, not non-ELC systems under this section.

If the system does not have ELC, this section has zero relevance for
the admin. (And it's a job for marketting people, not for Linux=20
documentation, to convince people they need this new and shiny
thing. :-))

Thus, the base assumption in this section is that ELC is supported and=20
usable.

> > You might occasionally have to mention what is not possible without
> > ELC=20
> > in case it's still possible to run stuff without ELC but don't put
> > time=20
> > references to it. However, it's not something you should start with
> > in
> > the documentation text.
> >=20
> > > The Efficiency Latency Control (ELC) feature is added to improve
> >=20
> > "is added to improve" -> "improves"
> Fine.
>=20
> >=20
> > > performance per watt. With this feature hardware power management
> > > algorithms optimize trade-off between latency and power
> > > consumption.
> > > But for some latency sensitive workloads further tuning can be done
> > > from OS to get desired performance.
> >=20
> > I'd just start with this paragraph. It goes straight into the point
> > and=20
> > is good in that it tries to summarize what ELC tries to achieve.
>
> There are so many features we have which improves perf/watt.

I think you make an issue out of a non-issue if you think it's problem to=
=20
state feature A improves performance if there are also features B and C=20
that improve it.

> Why ELC is special needs some background.

"special"? I didn't get that impression at all. I'm far from convinced ELC=
=20
is "special" or needs to be presented as such.

> > > The hardware monitors the average CPU utilization across all cores
> >=20
> > hardware or ELC-capable HW?
> Hardware. hardware always does this.

So do I read you right, this is nothing ELC-specific? So all ELC does is=20
adds those tunables (limits/overrides)?

> > > in a power domain at regular intervals and decides a uncore
> > > frequency.=20
> >=20
> > This kind of feels something that belongs to the first paragraph if
> > it's=20
> > about ELC. (I'm left slightly unsure if ELC refers only to those
> > controls=20
> > mentioned below, or if it is the automatic uncore freq control plus
> > the=20
> > manual controls. I assume it's the latter because of "with this
> > feature=20
> > hardware power management algorithms optimize" sentence.)
>
> It is later. Hardware doesn't do a PM feature depending only on OS.

I was specifically talking about what "ELC" is but you downgraded wording=
=20
back to "hardware" in your reply. So I have to repeat myself, what ELC=20
consists of? Are these non-OS dependent features (that "hardware always=20
does") part of ELC or not (for the avoidance of potential=20
misunderstandings, this is assuming no ELC tunables added by this series=20
are touched by the admin)?

Obviously, when one of the tunables is touched, it impacts the allowed
operating region of the autonomous algorithm (ELC tunables acting as=20
what look like "overrides").

> > > While this may result in the best performance per watt, workload
> > > may be
> > > expecting higher performance at the expense of power. Consider an
> > > application that intermittently wakes up to perform memory reads on
> > > an
> > > otherwise idle system. In such cases, if hardware lowers uncore
> > > frequency, then there may be delay in ramp up of frequency to meet
> > > target performance.=20
> > >=20
> > > The ELC control defines some parameters which can be changed from
> > > OS.
> > > If the average CPU utilization is below a user defined threshold
> > > (elc_low_threshold_percent attribute below), the user defined
> > > uncore
> > > frequency floor frequency will be used (elc_floor_freq_khz
> > > attribute=20
> > > below) instead of hardware calculated minimum.=20
> > >=20
> > > Similarly in high load scenario where the CPU utilization goes
> > > above=20
> > > the high threshold value (elc_high_threshold_percent attribute
> > > below)=20
> > > instead of jumping to maximum uncore frequency, uncore frequency is
> > > increased in 100MHz steps until the power limit is reached.
> > >=20
> > > Attributes for efficiency latency control:=20
> > > ..=20
> > > ..=20
> >=20
> > There were a few spaces at the end if lines, those should be removed.
> Yes in the patch.
>=20
> Thanks,
> Srinivas
>=20
> >=20
>=20

--=20
 i.
--8323328-147178893-1724761709=:1032--

