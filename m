Return-Path: <linux-kernel+bounces-206429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8D39009A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41A31F23FEB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC281993B5;
	Fri,  7 Jun 2024 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuvSUH0v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96670190688;
	Fri,  7 Jun 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775596; cv=none; b=eBLmSQBF9BgA3n8hNHFnnsYGE0ubV+GPy9Z3cuWKXuOnH9iZt+S8jvweRhChjgPRlaEcrxM5BUPYP7kGvxjt3iv1UvZrTOYA4OxrKNDJ9gzLMTP4tHSxxP+oK36ufxfaBJOjkwuynQI65DKjeHbxusM4uQgbZDXzheP3pNTBH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775596; c=relaxed/simple;
	bh=oywe1mkIeynmHDRBwdvvmFRGJataxJ9ZGBEKiHkcpG4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VMiGEO+tSAX0fOVG+E8R/fKqW88Yd5nsP6QehaKw1TbNLQa0sbaAopUJZUnbAQQDQAeXlir6N+xd5r2kQjKAZqlwBf3oGhGJwHr+u796Pu4R7CiseAfBwNnldBqAnmPt4HgsIEuaSjdV4ctGE9KNa8W4+AlXNbPgjaZ4kIXVlgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuvSUH0v; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717775595; x=1749311595;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oywe1mkIeynmHDRBwdvvmFRGJataxJ9ZGBEKiHkcpG4=;
  b=IuvSUH0vu3zDaoY1xRztBVJ23C3AVS6dnJlD3WfULbT8yvrLKpruM1s7
   Ph6wDX1QVWBUloOq9CKga3k0flpElqVAvc1wc6vG0ZmTZdyYTJpTGM9An
   jdHMAz57zXbnh4LJzEjGiktiZ4Ew7XaxzZ5ngPS4wTZu7reIlhO4qndxM
   yrtOrzmzu+h+6cF5n1cQZy8MXgoFt+7CqOi4RYpas1Hy8O99L6LegdlC8
   ygef/t3OJJSJslPQ9MvXQPSubBr7UfsdLyY0STpUEzGEf7AzrOZYJxMyq
   GTNoibC02+xyh62YeMY67zm+LVwkgbZXG3oupTjrRj+OpzPUeFwy8mkDn
   w==;
X-CSE-ConnectionGUID: eOz7YVlLT/SkU+nZf9h5pg==
X-CSE-MsgGUID: G312jb67TCuxjvlRViVEkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="11966794"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="11966794"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 08:53:14 -0700
X-CSE-ConnectionGUID: 62bx5l5vTea9Pb1huVtfcw==
X-CSE-MsgGUID: ZIpJdotQSJC+DmhhXjVFQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="43301572"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 08:53:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Jun 2024 18:53:08 +0300 (EEST)
To: Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] Documentation/ABI: Add new sysfs fields to
 sysfs-platform-mellanox-pmc
In-Reply-To: <ef3f942c1d933ef757a0de84c2890d6779471239.1717755404.git.shravankr@nvidia.com>
Message-ID: <c7464064-d08b-ecdc-8e07-b621a466d967@linux.intel.com>
References: <cover.1717755404.git.shravankr@nvidia.com> <ef3f942c1d933ef757a0de84c2890d6779471239.1717755404.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Jun 2024, Shravan Kumar Ramani wrote:

> Document newly added "count_clock" and "use_odd_counter" sysfs entries
> for the Mellanox BlueField PMC driver.
> 
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> ---
>  .../ABI/testing/sysfs-platform-mellanox-pmc   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
> index 9f987c6410da..ee03d066c0d9 100644
> --- a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
> +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
> @@ -52,3 +52,26 @@ Description:
>  		Writing 0 to the sysfs will clear the counter, writing any other
>  		value is not allowed.
>  
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/count_clock
> +Date:		May 2024
> +KernelVersion:	6.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		Use a counter for counting cycles. This is used to repurpose/dedicate
> +		any of the counters in the block to counting cycles. Each counter is
> +		represented by a bit (bit 0 for counter0, bit1 for counter1 and so on)
> +		and setting the corresponding bit will reserve that specific counter
> +		for counting cycles and override the event<N> setting.
> +
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/use_odd_counter
> +Date:		May 2024
> +KernelVersion:	6.10

6.10 ship has already sailed.

> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		Form 64-bit counter using 2 32-bit counters. This is used to combine
> +		2 adjacent counters to form a single 64-bit counter. Each even counter
> +		is represented by a bit and setting the bit will join the corresponding
> +		even counter with the next (odd) counter. The full 64-bit value can be
> +		accessed using the same 2 counter<N> and counter<N+1> sysfs, with each
> +		of them holding the lower and upper 32 bits respectively.

Okay, thanks for updating this, it's much clearer now what the intent of 
each file is. One thing that is still unclear whether both bits are 
expected to be set in count_clock when use_odd_counter is used to combine 
two counters?

-- 
 i.


