Return-Path: <linux-kernel+bounces-301699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC495F443
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3041C21C57
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BA018D656;
	Mon, 26 Aug 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvqvL8RS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B1188915;
	Mon, 26 Aug 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683560; cv=none; b=FBAKXAhBEr+yfpc6s5RI4vlVBsgmhyfkty0pq0qsgv2RRb86NQg56GicS5V8yKKSHlAPj/wcvH57vJU0dT5PVQzh9qndELnvb8u94bvODhlspMkhHUoveBLgQzllSD2y4fLr/HOHBoq7tPkqeR3xB97xpR7qSeXbotNNmqYm+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683560; c=relaxed/simple;
	bh=L724sWBvEBY2f8kM6QeXbVVGkAsZPpZV3UWQXCdeVgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNA4vGUh9LxruqCZ5pzaLGhrqCf/YYdYvByfJbWOMGWU/BNCHNXDQfohc2OJUmA+LfSaE6BziC27zxRsng1jYkCglbniiJYZSce1+NtCGFO0HVD/hnsfF9bQNF68W4bnEUXjVtUyC3gP5pxrQbjMWp0nhzXy+E+hf6pYqkkjanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvqvL8RS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724683559; x=1756219559;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=L724sWBvEBY2f8kM6QeXbVVGkAsZPpZV3UWQXCdeVgU=;
  b=kvqvL8RSCdQeuho0iY28cfj6SwwFMT/LLEqKA7lmcQU+wCmRDptenRTn
   oGVHtwbj3TiQnuGIGLpkGGwOkWkeNqWEM+u55w5wnskQQ3oee6o1135O9
   6BXiRq4ejujVCa7oGiD1NvdAl+4DLW/BKdn0ep7bs8ils2m6cJp90xNG/
   SZedAEoECDwLgihxhaVV4Ss69kraUOPEbxa67r5LiA/EPuws+EI8ysw1X
   LmT+ySmrS6uprpLxCvrgWEIlBn+BUp+BueXPBt8M3gyxVPLAELE+amlbI
   f66WtPW+W26ghvduuT6UQQ1umFpGL96JZZNZjgPBg/+mnj9AhvBrTX+JL
   g==;
X-CSE-ConnectionGUID: VE5LLSRES6Wn7utGZQ/+eg==
X-CSE-MsgGUID: 7HtxHuAYTOSGCk8vMjIiCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="22978363"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="22978363"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 07:45:48 -0700
X-CSE-ConnectionGUID: T94s5+IoTqWF69h48HLq8Q==
X-CSE-MsgGUID: 53eip0lZQGahzw72gkxrTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="67461099"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO [10.124.222.227]) ([10.124.222.227])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 07:45:47 -0700
Message-ID: <4d6adc49f295ad1dec26cd1a67ec3997686db4a9.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] Documentation: admin-guide: pm: Add efficiency vs.
 latency tradeoff to uncore documentation
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Tero
	Kristo <tero.kristo@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org,  LKML <linux-kernel@vger.kernel.org>
Date: Mon, 26 Aug 2024 10:45:40 -0400
In-Reply-To: <dabdc81e-d743-6402-f87a-dee2d6b906b8@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com>
	 <20240821131321.824326-2-tero.kristo@linux.intel.com>
	 <dabdc81e-d743-6402-f87a-dee2d6b906b8@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-23 at 15:28 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 21 Aug 2024, Tero Kristo wrote:
>=20
> > Added documentation about the functionality of efficiency vs.
> > latency tradeoff
> > control in intel Xeon processors, and how this is configured via
> > sysfs.
> >=20
> > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > ---
> > =C2=A0.../pm/intel_uncore_frequency_scaling.rst=C2=A0=C2=A0=C2=A0=C2=A0=
 | 51
> > +++++++++++++++++++
> > =C2=A01 file changed, 51 insertions(+)
> >=20
> > diff --git a/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst b/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst
> > index 5ab3440e6cee..fb83aa2b744e 100644
> > --- a/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst
> > +++ b/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst
> > @@ -113,3 +113,54 @@ to apply at each uncore* level.
> > =C2=A0
> > =C2=A0Support for "current_freq_khz" is available only at each fabric
> > cluster
> > =C2=A0level (i.e., in uncore* directory).
> > +
> > +Efficiency vs. Latency Tradeoff
>=20
> Does this section even cover the "tradeoff" part in its body? Why not
> call=20
> it directly "Control" after ELC?
>=20
> > +-------------------------------
> > +
> > +In the realm of high-performance computing, particularly with Xeon
> > +processors, managing uncore frequency is an important aspect of
> > system
> > +optimization. Traditionally, the uncore frequency is ramped up
> > rapidly
> > +in high load scenarios. While this strategy achieves low latency,
> > which
> > +is crucial for time-sensitive computations, it does not
> > necessarily yield
> > +the best performance per watt, =E2=80=94a key metric for energy effici=
ency
> > and
> > +operational cost savings.
>=20
> This entire paragraph feels more prose or history book than
> documentation=20
> text. I'd suggest using something that goes more directly into the
> point
> about what ELC brings to the table (I suppose the goal is
> "performance=20
> per watt" optimization, even that goal is only implied by the current
> text, not explicitly stated as the goal here).
>=20

What about this?

Traditionally, the uncore frequency is ramped up to reach the maximum=20
possible level based on parameters like EPB (Energy perf Bias) and
other system power management settings programmed by BIOS.  While this
strategy achieves low latency for latency sensitive applications, it
does not necessarily yield the best performance per watt.=20

The Efficiency Latency Control (ELC) feature is added to improve
performance per watt. With this feature hardware power management
algorithms optimize trade-off between latency and power consumption.
But for some latency sensitive workloads further tuning can be done
from OS to get desired performance.

The hardware monitors the average CPU utilization across all cores
in a power domain at regular intervals and decides a uncore frequency.=20
While this may result in the best performance per watt, workload may be
expecting higher performance at the expense of power. Consider an
application that intermittently wakes up to perform memory reads on an
otherwise idle system. In such cases, if hardware lowers uncore
frequency, then there may be delay in ramp up of frequency to meet
target performance.=20

The ELC control defines some parameters which can be changed from OS.
If the average CPU utilization is below a user defined threshold
(elc_low_threshold_percent attribute below), the user defined uncore
frequency floor frequency will be used (elc_floor_freq_khz attribute=20
below) instead of hardware calculated minimum.=20

Similarly in high load scenario where the CPU utilization goes above=20
the high threshold value (elc_high_threshold_percent attribute below)=20
instead of jumping to maximum uncore frequency, uncore frequency is=20
increased in 100MHz steps until the power limit is reached.

Attributes for efficiency latency control:=20
..=20
..=20

Thanks,
Srinivas

