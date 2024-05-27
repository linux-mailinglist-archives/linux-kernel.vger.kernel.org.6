Return-Path: <linux-kernel+bounces-190434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD88CFE2C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D011C2127F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584513B2A4;
	Mon, 27 May 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1d/0CU5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CCB79E1;
	Mon, 27 May 2024 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806037; cv=none; b=PbCRzYcAF1A+eytYv8if5cH4VQx/lnkrfhkHRh0QhFRx02kzl00VVqxvrIR1wIyNui633R6AwQsn6v1oACCtHb55BBcTZJhKrqAGzNRpagcke2/rO5rUrqto90KsNfjvQrHb0eXfdtv0DkhRL9bfAQ84cVHjcjmqwvYjXvcGgsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806037; c=relaxed/simple;
	bh=kh7zExYsU5NSwXABQCpfwbxqjGDH1gafzF+5b2SbwQE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oMASn0EEWFDzS6fUN8Hu+AsPfQxJ56/4C217/VljAX8DprMIVZ3bGakKFcfSdIwc30JtLy2dTfvv5SCrN7ksjUSq1ngrSh1GYN96HMTnRZuamRaceQDZVajfklXe+FN/ngfs8mqOyHRPa399L5zdg8OmYxgrXCdGYnX0QRan0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1d/0CU5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716806036; x=1748342036;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kh7zExYsU5NSwXABQCpfwbxqjGDH1gafzF+5b2SbwQE=;
  b=M1d/0CU5Jl1WDFFNgOggf/l1eR/LazbvBpCbHKrnhwoOBeBf0N3yWZO3
   a4k1edQsywF5ygQUd7wJfFyAzlDu4kdf/dcVGBEaNXEgw5O4Hdcei2HBZ
   9d6SLJdQi2EbDfNDkhfw+QwLhklRfofxW9/IptI/gYuxugn/RrNwf29ZU
   CpIYF+nxNOeTvMzExp2jc1hM2r68BLZc3p6CEPanQTtzxHX6It8UKzGv4
   8gC9N9ccCmxzY8tuw/c1M7lVQ/0WhC6vk4FAYw5JXdbLWjvrGdjmVkc3h
   98HUbmUKYTudwGQT8swFEYQkeNj+mm7yxfBHnSK114C/+DLk7JKH45m8D
   w==;
X-CSE-ConnectionGUID: 3+35JX/UStu7lRHCpVePqA==
X-CSE-MsgGUID: zIA2NkDwQeixMUACzOez3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13239124"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13239124"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:33:55 -0700
X-CSE-ConnectionGUID: SExCQypaS/y8JBy/H0Ut8w==
X-CSE-MsgGUID: N+FtcBA1RaetMv4BazM3MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39154551"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.138])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:33:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 May 2024 13:33:49 +0300 (EEST)
To: Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] Documentation/ABI: Add document for Mellanox PMC
 driver
In-Reply-To: <d8f86ffc4a8a93f13a278ac9c95e0f95b4dd3fb9.1716205838.git.shravankr@nvidia.com>
Message-ID: <23406905-4c1a-5fb3-1bb4-8a3475536977@linux.intel.com>
References: <cover.1716205838.git.shravankr@nvidia.com> <d8f86ffc4a8a93f13a278ac9c95e0f95b4dd3fb9.1716205838.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 May 2024, Shravan Kumar Ramani wrote:

> The sysfs interface is created for programming and monitoring the

This patch is not creating interface. I suggest you change the wording to:

"Document the sysfs interface for ...

> performance counters in various HW blocks of Mellanox BlueField-1,
> BlueField-2 and BlueField-3.
> 
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> ---
>  .../ABI/testing/sysfs-platform-mellanox-pmc   | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-pmc
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
> new file mode 100644
> index 000000000000..47094024dbeb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
> @@ -0,0 +1,49 @@
> +HID           Driver         Description
> +MLNXBFD0      mlxbf-pmc      Performance counters (BlueField-1)
> +MLNXBFD1      mlxbf-pmc      Performance counters (BlueField-2)
> +MLNXBFD2      mlxbf-pmc      Performance counters (BlueField-3)
> +
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/event_list
> +Date:		Dec 2020
> +KernelVersion:	5.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		List of events supported by the counters in the specific block.
> +		It is used to extract the event number or ID associated with
> +		each event.
> +
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/event<N>
> +Date:		Dec 2020
> +KernelVersion:	5.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		Event monitored by corresponding counter. This is used to
> +		program or read back the event that should be or is currently
> +		being monitored by counter<N>.
> +
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/counter<N>
> +Date:		Dec 2020
> +KernelVersion:	5.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		Counter value of the event being monitored. This is used to
> +		read the counter value of the event which was programmed using
> +		event<N>. This is also used to clear or reset the counter value.

Please document how to clear/reset it in more concrete terms (I didn't 
check the code but my guess would one writes zero there to reset the 
counter?).

> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/enable
> +Date:		Dec 2020
> +KernelVersion:	5.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		Start or stop counters. This is used to start the counters
> +		for monitoring the programmed events and also to stop the
> +		counters after the desired duration.
> +
> +What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/<reg>
> +Date:		Dec 2020
> +KernelVersion:	5.10
> +Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
> +Description:
> +		Value of register. This is used to read or reset the registers
> +		where various performance statistics are counted for each block.

Ditto for the reset part.

-- 
 i.


