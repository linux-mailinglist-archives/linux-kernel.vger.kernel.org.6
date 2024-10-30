Return-Path: <linux-kernel+bounces-388656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC69B62AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86E5282EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B41EF940;
	Wed, 30 Oct 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFXbMVrT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1071E766D;
	Wed, 30 Oct 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290233; cv=none; b=W065c/ZAmt/LwWLV6jinHDVglRm0XWeQlfjSLVCik972B0ZXLw0YOiJ1ATDmHuRIPTOhFu9bGnyJm/Bi6JAvgC77jN1QnJuIOwyIDEwIDoyScqnTxddT/JJy+XbzlnGroE7OAoCJRhwv4V4+O7S+9C+rH9p/go1gqHPSZ4rmnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290233; c=relaxed/simple;
	bh=J90Knq2vkxThNDfGyiYkzgDBEmcGA7xt+HiZQBfdF2g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Pd7/Kvv3lRJ/ZPqRw3u4hkYoDtd7ow2h8m/Y64V2UTLJnMAe+DLsGwHU9QAAe1+4SfX5W5nXJu9tN0iH3DKls2jBO2eXd6/U+RkxWyV5Ndv0wf1KgNqLoh+mycMdNkHg6aHWGnjiucY5cqNCXkxZt46as277Xlffe6uTZbUgUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFXbMVrT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730290231; x=1761826231;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J90Knq2vkxThNDfGyiYkzgDBEmcGA7xt+HiZQBfdF2g=;
  b=FFXbMVrT2PJ5QPRRlU0EiyyiPudatvdQDPBBSUU4LT+7ZC3UZ7lbfyX6
   /RMNsVQ8YghnQVDgxXbPychKvK/gCSDY63BvuDiG7s04hGHmU98CdGFU5
   TcP+TYME2wefTsnwYuv6uPMyrAENeNUufUQ1qdAyBSYAw14lEZUX1z88c
   E1znunct0roch3xOid0cFWF6gwOgNiHSmH+U8ZbtL5dg0NlgwMTukkxyW
   Y6Vy1caUvgFN4FalaPlBCQegYbtIhh6eC2jl3RnrN4YzQIIhljmzcYOp7
   7jSOXz0VRGfaYamuJoZEsctjCHlwqFeDtwKvKjIk3J1s89gThYhrVu47C
   w==;
X-CSE-ConnectionGUID: 9HlH+KG3RB+zAaUAznBoIg==
X-CSE-MsgGUID: PY7dYC5fRMac5pWp5jInFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29946288"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29946288"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 05:10:31 -0700
X-CSE-ConnectionGUID: AauN64zXSqaKg/ENYz9JyA==
X-CSE-MsgGUID: z1IyyvHDT+KLged4yNi9nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87439824"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.22])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 05:10:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:10:24 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v11 0/5] Dell AWCC platform_profile support
In-Reply-To: <20241030000904.7205-2-kuurtb@gmail.com>
Message-ID: <f972eabf-58b5-3b0b-ea5f-930894ac840b@linux.intel.com>
References: <20241030000904.7205-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 29 Oct 2024, Kurt Borja wrote:

> This patch adds platform_profile support for Dell devices which implement
> WMAX thermal interface, that are meant to be controlled by Alienware Command
> Center (AWCC). These devices may include newer Alienware M-Series, Alienware
> X-Series and Dell's G-Series.
> 
> Tested on an Alienware x15 R1.
> ---
> v11:
>  - Minor changes on patch 4/5
> v10:
>  - `thermal` and `gmode` quirks are now manually selected because some
>    models with the WMAX interface don't have the necessary thermal
>    methods.
>  - Added force_platform_profile and force_gmode patch for a better user
>    experience
> v9:
>  - Minor changes on patch 3/4
> v8:
>  - Aesthetic and readibility fixes on patch 3/4
>  - Better commit message for patch 3/4
> v7:
>  - Platform profile implementation refactored in order to efficently
>    autodetect available thermal profiles
>  - Added GameShiftStatus method to documentation
>  - Implemented GameShiftStatus switch for devices that support it 
> v6:
>  - Removed quirk thermal_ustt.
>  - Now quirk thermal can take canonical thermal profile _tables_ defined
>    in enum WMAX_THERMAL_TABLES
>  - Added autodetect_thermal_profile
>  - Proper removal of thermal profile
> v5:
>  - Better commit messages
>  - insize renamed to in_size in alienware_wmax_command() to match other
>    arguments.
>  - Kudos in documentation now at the end of the file
> v4:
>  - Fixed indentation on previous code
>  - Removed unnecessary (acpi_size) and (u32 *) casts
>  - Return -EIO on ACPI_FAILURE
>  - Appropiate prefixes given to macros
>  - 0xFFFFFFFF named WMAX_FAILURE_CODE
>  - Added support for a new set of thermal codes. Old ones now have USTT
>    in their names
>  - A new quirk has been added to differantiate between the two sets.
>    thermal and thermal_ustt are mutually exclusive
>  - Added documentation for WMAX interface
> v3:
>  - Removed extra empty line
>  - 0x0B named WMAX_ARG_GET_CURRENT_PROF
>  - Removed casts to the same type on functions added in this patch
>  - Thermal profile to WMAX argument is now an static function and makes
>    use of in-built kernel macros
>  - Platform profile is now removed only if it was created first
>  - create_platform_profile is now create_thermal_profile to avoid
>    confusion
>  - profile_get and profile_set functions renamed too to match the above
> v2:
>  - Moved functionality to alienware-wmi driver
>  - Added thermal and gmode quirks to add support based on dmi match
>  - Performance profile is now GMODE for devices that support it
>  - alienware_wmax_command now is insize agnostic to support new thermal
>    methods
> 
> Kurt Borja (5):
>   alienware-wmi: fixed indentation and clean up
>   alienware-wmi: alienware_wmax_command() is now input size agnostic
>   alienware-wmi: added platform profile support
>   alienware-wmi: added force module parameters
>   alienware-wmi: WMAX interface documentation
> 
>  Documentation/wmi/devices/alienware-wmi.rst | 388 ++++++++++++++++
>  MAINTAINERS                                 |   1 +
>  drivers/platform/x86/dell/Kconfig           |   1 +
>  drivers/platform/x86/dell/alienware-wmi.c   | 477 ++++++++++++++++----
>  4 files changed, 791 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/wmi/devices/alienware-wmi.rst

Huge thanks to you both Kurt and Armin for all the work done to improve 
this series! :-)

I've applied this series to the review-ilpo branch now.

-- 
 i.


