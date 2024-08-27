Return-Path: <linux-kernel+bounces-303184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2CD9608B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E0A282355
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811541A00EE;
	Tue, 27 Aug 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jH4C9Nr/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB319EED8;
	Tue, 27 Aug 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758243; cv=none; b=iz5pU2tf/k4U3fJGrVGAdatKimb4dqPz8Ka+MmGrSghxwxLp4tL9Er1aMKjRxcOF26S/u5/ADxqOQwn/etGR8NSu+qVrmI+49gP6C1HtkruIt5yJ0mv0BI5vGBEgshYym51AMQaEXp+2EpbNKgq5UUGiXEbz8Ha0AcDov0EgBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758243; c=relaxed/simple;
	bh=98vxe8lKvwmQFrbVzGowoxh4vUjpPyeCTxGxI5JlJIk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u1rIvqHDJIKKQaTKutMRlt14I6kVglKWW0W+Or8t7W4OzXM2JCku+EU0UeXGeJOrxEKg3AZz8P1McmyLoCqn2qUl4OE2HE++V1zkhx2YnHM/QngsWD8OnxZWQA7R/GlOEmqzRZIy/THYwrNLfdSiWgQkFQSGMvk2tEIoT5OCBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jH4C9Nr/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724758242; x=1756294242;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=98vxe8lKvwmQFrbVzGowoxh4vUjpPyeCTxGxI5JlJIk=;
  b=jH4C9Nr/LWTiU5ia6AopkRgxnteHMCbiKBqHXx+4YShHlitWw/rrcZSd
   8dU0u4fGYkrceWDw4Vmxu/xCOYUlaYAJMBLJvpnlHoJ8zGkUK/cm8LtLB
   yEapGOfEVo9B6yj9vWhLEvNVoKhjhXx2hJ6Pg9x4aCh/vdvxgjUtjjFal
   eps5sM3Xy4hJIbZxQpco7AhM2/9vEp3Y6MPFmvPmHfsNhXgTcQKjZcikt
   3dBDRssUUSfHffyLEDoupsESgEqKU1JiCB6rupg7g00O7iHFNlxmQUpnu
   hSnP9RQWo3xYh8GekfnO0KseAQDpJeXzXCnz71milNjwa9XlYTU7LA/y5
   Q==;
X-CSE-ConnectionGUID: pWriJR+pSqSIw1+phh1d6Q==
X-CSE-MsgGUID: /NlNf+JtT6eYT+04lodHTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23408491"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23408491"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:30:41 -0700
X-CSE-ConnectionGUID: FaAxh9qXQYyvRWo1QT+f0w==
X-CSE-MsgGUID: gf6hzSrYTROQO7iBz3fivw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63343704"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.124.223.66]) ([10.124.223.66])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:30:38 -0700
Message-ID: <8719e7653b2f859c46966986dc81cc589a6d78ca.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] Documentation: admin-guide: pm: Add efficiency vs.
 latency tradeoff to uncore documentation
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Tero Kristo <tero.kristo@linux.intel.com>, Hans de Goede
	 <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, LKML
	 <linux-kernel@vger.kernel.org>
Date: Tue, 27 Aug 2024 07:30:36 -0400
In-Reply-To: <1b93f71a-8a36-f95e-86b9-2b8f330847ff@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com>
	 <20240821131321.824326-2-tero.kristo@linux.intel.com>
	 <dabdc81e-d743-6402-f87a-dee2d6b906b8@linux.intel.com>
	 <4d6adc49f295ad1dec26cd1a67ec3997686db4a9.camel@linux.intel.com>
	 <1b93f71a-8a36-f95e-86b9-2b8f330847ff@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 11:08 +0300, Ilpo J=C3=A4rvinen wrote:
> On Mon, 26 Aug 2024, srinivas pandruvada wrote:
>=20
> > On Fri, 2024-08-23 at 15:28 +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Wed, 21 Aug 2024, Tero Kristo wrote:
> > >=20
> > > > Added documentation about the functionality of efficiency vs.
> > > > latency tradeoff
> > > > control in intel Xeon processors, and how this is configured
> > > > via
> > > > sysfs.
> > > >=20
> > > > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > > > ---
> > > > =C2=A0.../pm/intel_uncore_frequency_scaling.rst=C2=A0=C2=A0=C2=A0=
=C2=A0 | 51
> > > > +++++++++++++++++++=E2=81=A0Ayoub,=C2=A0Hatim=C2=A0This seems that =
when on AC
> > > > mode, Windows don't care about PC10. Is this correct? It seems
> > > > that with EPB=3D6 we can
> > > > =C2=A01 file changed, 51 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/admin-
> > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > b/Documentation/admin-
> > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > index 5ab3440e6cee..fb83aa2b744e 100644
> > > > --- a/Documentation/admin-
> > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > +++ b/Documentation/admin-
> > > > guide/pm/intel_uncore_frequency_scaling.rst
> > > > @@ -113,3 +113,54 @@ to apply at each uncore* level.
> > > > =C2=A0
> > > > =C2=A0Support for "current_freq_khz" is available only at each
> > > > fabric
> > > > cluster
> > > > =C2=A0level (i.e., in uncore* directory).
> > > > +
> > > > +Efficiency vs. Latency Tradeoff
> > >=20
> > > Does this section even cover the "tradeoff" part in its body? Why
> > > not
> > > call=20
> > > it directly "Control" after ELC?
> > >=20
> > > > +-------------------------------
> > > > +
> > > > +In the realm of high-performance computing, particularly with
> > > > Xeon
> > > > +processors, managing uncore frequency is an important aspect
> > > > of
> > > > system
> > > > +optimization. Traditionally, the uncore frequency is ramped up
> > > > rapidly
> > > > +in high load scenarios. While this strategy achieves low
> > > > latency,
> > > > which
> > > > +is crucial for time-sensitive computations, it does not
> > > > necessarily yield
> > > > +the best performance per watt, =E2=80=94a key metric for energy
> > > > efficiency
> > > > and
> > > > +operational cost savings.
> > >=20
> > > This entire paragraph feels more prose or history book than
> > > documentation=20
> > > text. I'd suggest using something that goes more directly into
> > > the
> > > point
> > > about what ELC brings to the table (I suppose the goal is
> > > "performance=20
> > > per watt" optimization, even that goal is only implied by the
> > > current
> > > text, not explicitly stated as the goal here).
> > >=20
> >=20
> > What about this?
> >=20
> > Traditionally, the uncore frequency is ramped up to reach the
> > maximum=20
> > possible level based on parameters like EPB (Energy perf Bias) and
> > other system power management settings programmed by BIOS.=C2=A0 While
> > this
> > strategy achieves low latency for latency sensitive applications,
> > it
> > does not necessarily yield the best performance per watt.=20
>=20
> This again starts with a wrong foot. Don't use words like
> "traditionally",
> "in the past", "historically", "is added", etc. that refer to past
> time
> in documentation text at all. The premise with documentation for
> feature x=20
> is that the feature x exists. After these patches have been accepted,
> the=20
> reality is that ELC exists and time before does not matter so we
> don't=20
> encumber documentation text with that era that has become irrelevant.
>=20
While the choice of words are not correct, for me background is
important on why a feature is implemented.
Here even after ELC is implemented, majority of generations will still
not have this feature. Uncore is not just supported on TPMI systems.


> You might occasionally have to mention what is not possible without
> ELC=20
> in case it's still possible to run stuff without ELC but don't put
> time=20
> references to it. However, it's not something you should start with
> in
> the documentation text.
>=20
> > The Efficiency Latency Control (ELC) feature is added to improve
>=20
> "is added to improve" -> "improves"
Fine.

>=20
> > performance per watt. With this feature hardware power management
> > algorithms optimize trade-off between latency and power
> > consumption.
> > But for some latency sensitive workloads further tuning can be done
> > from OS to get desired performance.
>=20
> I'd just start with this paragraph. It goes straight into the point
> and=20
> is good in that it tries to summarize what ELC tries to achieve.
There are so many features we have which improves perf/watt. Why ELC is
special needs some background.

>=20
> > The hardware monitors the average CPU utilization across all cores
>=20
> hardware or ELC-capable HW?
Hardware. hardware always does this.

>=20
> > in a power domain at regular intervals and decides a uncore
> > frequency.=20
>=20
> This kind of feels something that belongs to the first paragraph if
> it's=20
> about ELC. (I'm left slightly unsure if ELC refers only to those
> controls=20
> mentioned below, or if it is the automatic uncore freq control plus
> the=20
> manual controls. I assume it's the latter because of "with this
> feature=20
> hardware power management algorithms optimize" sentence.)
It is later. Hardware doesn't do a PM feature depending only on OS.

>=20
> > While this may result in the best performance per watt, workload
> > may be
> > expecting higher performance at the expense of power. Consider an
> > application that intermittently wakes up to perform memory reads on
> > an
> > otherwise idle system. In such cases, if hardware lowers uncore
> > frequency, then there may be delay in ramp up of frequency to meet
> > target performance.=20
> >=20
> > The ELC control defines some parameters which can be changed from
> > OS.
> > If the average CPU utilization is below a user defined threshold
> > (elc_low_threshold_percent attribute below), the user defined
> > uncore
> > frequency floor frequency will be used (elc_floor_freq_khz
> > attribute=20
> > below) instead of hardware calculated minimum.=20
> >=20
> > Similarly in high load scenario where the CPU utilization goes
> > above=20
> > the high threshold value (elc_high_threshold_percent attribute
> > below)=20
> > instead of jumping to maximum uncore frequency, uncore frequency is
> > increased in 100MHz steps until the power limit is reached.
> >=20
> > Attributes for efficiency latency control:=20
> > ..=20
> > ..=20
>=20
> There were a few spaces at the end if lines, those should be removed.
Yes in the patch.

Thanks,
Srinivas

>=20


