Return-Path: <linux-kernel+bounces-298866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD295CC5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17CD1C21811
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4160185B4B;
	Fri, 23 Aug 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e62ZF5T1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E8185954;
	Fri, 23 Aug 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416099; cv=none; b=DBGOSk5rLfxk9/bJiKRJmZJWtoqfwC2/cSMP9Zl6QsvAo6WS6qV9LgFdbTMcA/FsWMucgqprVhkSy/q+kjvZGC1sNsmkvS6oAKRAN40y/YAsLKfn4USk5DSO5Mpv4X7GdN2dAz+aw/GphslfYdsPog01JrfB3LNvmgfRllPGiRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416099; c=relaxed/simple;
	bh=tbPSjcRXyyHSc6osHTksRXqjP80geuvCMKoYxn0fHgc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oyGilkS/YOlMQQBxV643bUt0Da1OQ7zrRQ4H5TdR/JaH3ZEW32798rYkkj7DFkbhjoPoGatpOfkoQORYahIbaN4nNa3+1XBmusgcx6Pws4xjgL6cx8tjH4gwT5rXSW4E+AZuvm7S9l/PknmGzveJGFwqUN8aptduw8Ecv6ILtNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e62ZF5T1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724416097; x=1755952097;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tbPSjcRXyyHSc6osHTksRXqjP80geuvCMKoYxn0fHgc=;
  b=e62ZF5T11sFAV1O8IbmRmOCus+8W+xXAsIcAB+PcZcuzPPscxX4kAOyW
   GGXXqbCmciOm6BBz4ZMI07aeK+LSvQ7zQhU/Yto2LU6MhM6NC4OfeF/Cf
   X6/B+XwP4aFtzNYaSBa9XJOaYdJmvRpTZblOSlZ8rC2AOAZbiqRljBASy
   jD6jpRX65lghCixDc8YHL0p6j47MK5VEPDKBFVylVClfitVkqhCVhnZGH
   59MJdWktpoYfvyW63t6F88WeSoseAa+vZks+KnS6UiGPcVpEK1gAppgjN
   UJABCfa6uBYQS75jSZs/OB7Mol6kA7HmlgLuWE+OfG4/Sp8VZRCsGkncV
   w==;
X-CSE-ConnectionGUID: /1L6h/B6QFSvhaI6ODvxpQ==
X-CSE-MsgGUID: qkapkDnDRhG+ad6Esqv48Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33504413"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="33504413"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:28:16 -0700
X-CSE-ConnectionGUID: abEu6HtoQIGEFNWJsRFfnA==
X-CSE-MsgGUID: RLjjoL7DRsWFeRlozvZWmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61641908"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.2])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:28:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Aug 2024 15:28:10 +0300 (EEST)
To: Tero Kristo <tero.kristo@linux.intel.com>
cc: srinivas.pandruvada@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] Documentation: admin-guide: pm: Add efficiency vs.
 latency tradeoff to uncore documentation
In-Reply-To: <20240821131321.824326-2-tero.kristo@linux.intel.com>
Message-ID: <dabdc81e-d743-6402-f87a-dee2d6b906b8@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com> <20240821131321.824326-2-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1221077555-1724416090=:2230"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1221077555-1724416090=:2230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Aug 2024, Tero Kristo wrote:

> Added documentation about the functionality of efficiency vs. latency tra=
deoff
> control in intel Xeon processors, and how this is configured via sysfs.
>=20
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  .../pm/intel_uncore_frequency_scaling.rst     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.=
rst b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
> index 5ab3440e6cee..fb83aa2b744e 100644
> --- a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
> +++ b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
> @@ -113,3 +113,54 @@ to apply at each uncore* level.
> =20
>  Support for "current_freq_khz" is available only at each fabric cluster
>  level (i.e., in uncore* directory).
> +
> +Efficiency vs. Latency Tradeoff

Does this section even cover the "tradeoff" part in its body? Why not call=
=20
it directly "Control" after ELC?

> +-------------------------------
> +
> +In the realm of high-performance computing, particularly with Xeon
> +processors, managing uncore frequency is an important aspect of system
> +optimization. Traditionally, the uncore frequency is ramped up rapidly
> +in high load scenarios. While this strategy achieves low latency, which
> +is crucial for time-sensitive computations, it does not necessarily yiel=
d
> +the best performance per watt, =E2=80=94a key metric for energy efficien=
cy and
> +operational cost savings.

This entire paragraph feels more prose or history book than documentation=
=20
text. I'd suggest using something that goes more directly into the point
about what ELC brings to the table (I suppose the goal is "performance=20
per watt" optimization, even that goal is only implied by the current=20
text, not explicitly stated as the goal here).

--=20
 i.

> +The Efficiency vs. Latency Control (ELC) feature allows user to influenc=
e
> +the uncore frequency scaling algorithm. Hardware monitors the average CP=
U
> +utilization across all cores at regular intervals. If the average CPU
> +utilization is below a user defined threshold (elc_low_threshold_percent=
),
> +the user defined uncore frequency floor frequency will be used
> +(elc_floor_freq_khz), minimizing latency. Similarly in high load scenari=
o
> +where the CPU utilization goes above the high threshold value
> +(elc_high_threshold_percent) instead of jumping to maximum uncore
> +frequency, uncore frequency is increased in 100MHz steps until the power
> +limit is reached.
> +
> +Attributes for efficiency latency control:
> +
> +``elc_floor_freq_khz``
> +=09This attribute is used to get/set the efficiency latency floor freque=
ncy.
> +=09If this variable is lower than the 'min_freq_khz', it is ignored by
> +=09the firmware.
> +
> +``elc_low_threshold_percent``
> +=09This attribute is used to get/set the efficiency latency control low
> +=09threshold. This attribute is in percentages of CPU utilization.
> +
> +``elc_high_threshold_percent``
> +=09This attribute is used to get/set the efficiency latency control high
> +=09threshold. This attribute is in percentages of CPU utilization.
> +
> +``elc_high_threshold_enable``
> +=09This attribute is used to enable/disable the efficiency latency contr=
ol
> +=09high threshold. Write '1' to enable, '0' to disable.
> +
> +Example system configuration below, which does following:
> +  * when CPU utilization is less than 10%: sets uncore frequency to 800M=
Hz
> +  * when CPU utilization is higher than 95%: increases uncore frequency =
in
> +    100MHz steps, until power limit is reached
> +
> +  elc_floor_freq_khz:800000
> +  elc_high_threshold_percent:95
> +  elc_high_threshold_enable:1
> +  elc_low_threshold_percent:10
>=20
--8323328-1221077555-1724416090=:2230--

