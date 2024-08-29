Return-Path: <linux-kernel+bounces-306496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2181963FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA5528268C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811F18CC19;
	Thu, 29 Aug 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiQOUwcA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5518D65D;
	Thu, 29 Aug 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923161; cv=none; b=EbH/tTgfKf+mcguAMdnzv7rvDwlBFvyDqv5rB2bfr1rdgJg2n/BsS4cey/f+C3LD1+Cru3tWBZdOOf2UNOmSLPsAdxgZO5EWFHVMDhvebDskxP+ZYfnyAiRtjeba28dPMiOoEoh2dzs484REnrGxCQMNTm3UThFNSFNgBQpaqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923161; c=relaxed/simple;
	bh=tDQ+pcdvyOHFVZp+IKdv/jP5uGeKzI1qWJ/cb4iqJLY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ip0dVUQzMu5Fkri5AZXdjWD7V8CYP2IVyxF5/KlePCyDclR5jmkBL42v31nwZAEGY2iSgRwfQJBBnvIjfntlCUG1FjTlhSZS4/uAbupv1WRg4/5G1b5Y65raqa+5zWlz3D7lV3W4aEwOYrSwdiJA5s3Yex2rCls9aYkigbC7cdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiQOUwcA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724923159; x=1756459159;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tDQ+pcdvyOHFVZp+IKdv/jP5uGeKzI1qWJ/cb4iqJLY=;
  b=DiQOUwcASgqAyIc61j0uPTXVl1l1J0Y/qkVs1DSJ1PlPn3/izY1TZlf7
   kDGHONUruZmm254Z0Gk4YPmkC7G6ljfPXW14CsbuS88kQy2YITQR/Gfyl
   xz5LinzgqlcyUhmM84zB2FBEqzQ9bCtk+AlDWUFnnrg1fKAbOb3RgRRnC
   yCGSZnsXN8191BsUVEm4v0l2NeQj7ipzxiRXnO0pG47g7HoTFhQ4ftuIf
   Ox7bwuV+hnYpPcG4ti/WT4mcZ0OreYenBDx++P7Leu7WdJE4JU4BoxYbM
   IeCVCWi6TqzdI6ArSC4FezOvu/sZ9ryjNPU8Tw17YfeA4mIyZOMplPmh1
   w==;
X-CSE-ConnectionGUID: HtSDaDNUQtqqm8QCnLwYHw==
X-CSE-MsgGUID: 5RNAA4oKQTWvMUFZQqt04w==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="27378144"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="27378144"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:18:51 -0700
X-CSE-ConnectionGUID: JYj9OFH1TPyVQ0j0O36uRA==
X-CSE-MsgGUID: s13OWi+oQ7m5eETGx5hHCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="86731441"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:18:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 12:18:45 +0300 (EEST)
To: Tero Kristo <tero.kristo@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, srinivas.pandruvada@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] Documentation: admin-guide: pm: Add efficiency
 vs. latency tradeoff to uncore documentation
In-Reply-To: <20240828153657.1296410-2-tero.kristo@linux.intel.com>
Message-ID: <d4939d77-8fab-f4b6-f1f7-4af05951d3eb@linux.intel.com>
References: <20240828153657.1296410-1-tero.kristo@linux.intel.com> <20240828153657.1296410-2-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2058753919-1724923125=:1289"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2058753919-1724923125=:1289
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Aug 2024, Tero Kristo wrote:

> Added documentation about the functionality of efficiency vs. latency tra=
deoff
> control in intel Xeon processors, and how this is configured via sysfs.
>=20
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
> v2:
>   * Largely re-wrote the documentation
>=20
>  .../pm/intel_uncore_frequency_scaling.rst     | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.=
rst b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
> index 5ab3440e6cee..26ded32b06f5 100644
> --- a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
> +++ b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
> @@ -113,3 +113,62 @@ to apply at each uncore* level.
> =20
>  Support for "current_freq_khz" is available only at each fabric cluster
>  level (i.e., in uncore* directory).
> +
> +Efficiency vs. Latency Tradeoff
> +-------------------------------
> +
> +The Efficiency Latency Control (ELC) feature improves performance
> +per watt. With this feature hardware power management algorithms
> +optimize trade-off between latency and power consumption. For some
> +latency sensitive workloads further tuning can be done by SW to
> +get desired performance.
> +
> +The hardware monitors the average CPU utilization across all cores
> +in a power domain at regular intervals and decides an uncore frequency.
> +While this may result in the best performance per watt, workload may be
> +expecting higher performance at the expense of power. Consider an
> +application that intermittently wakes up to perform memory reads on an
> +otherwise idle system. In such cases, if hardware lowers uncore
> +frequency, then there may be delay in ramp up of frequency to meet
> +target performance.
> +
> +The ELC control defines some parameters which can be changed from SW.
> +If the average CPU utilization is below a user defined threshold
> +(elc_low_threshold_percent attribute below), the user defined uncore
> +frequency floor frequency will be used (elc_floor_freq_khz attribute

Consider the following simplification:

"the user defined uncore frequency floor frequency" ->
"the user-defined uncore floor frequency"

I think it tells the same even without that first "frequency".

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> +below) instead of hardware calculated minimum.
> +
> +Similarly in high load scenario where the CPU utilization goes above
> +the high threshold value (elc_high_threshold_percent attribute below)
> +instead of jumping to maximum uncore frequency, frequency is increased
> +in 100MHz steps. This avoids consuming unnecessarily high power
> +immediately with CPU utilization spikes.
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

--8323328-2058753919-1724923125=:1289--

