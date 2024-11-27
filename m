Return-Path: <linux-kernel+bounces-423339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D17389DA605
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9622818F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CAF198850;
	Wed, 27 Nov 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFViMWtt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA066145B0F;
	Wed, 27 Nov 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704135; cv=none; b=tdaoxTNIQcSFumW7eFcp0OAOnhH0jG7Gy15tjf/dmN3dK9u60e2A3OOdp5xGhZp7eZQT/FPcmhLc8nDRdMojuWxLd4fKMEQDnNcR7juy51N5Bx0qK1QGSi8vu50lCeJUuDtF9u/flnkO3G98j/zRim4gGqzGY6UTWxBTCma3dmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704135; c=relaxed/simple;
	bh=wZ6Pd1q6VEtjcLUGO6tUqjQCpl+eVGwavhOR34BrIc8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=msXaqNWc/CmeGoQVn5RQrc1RUenQU7cpIYzi1xbtXGSHVBjBmaTggc6QOw2A+8fahZEqppuG4xiLTa+nBiSf9vRQwsFkusLgiFG7WZpS+LPtLMZvMOP+ySKWISrqWzV7/sC2wQnGppAFHNQKzAW62uLLAMUJuZHsM8gqi6nzBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFViMWtt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732704134; x=1764240134;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wZ6Pd1q6VEtjcLUGO6tUqjQCpl+eVGwavhOR34BrIc8=;
  b=AFViMWtt42YzscdXX3s/6vDfUYO8AaZ1++1NZMxuCTGeXPYdKJbDrdnW
   B8387wbpnNobYtXMcRZiR4gRqWhjzTmCLYcHnlTnP2wegvLfVSqvY9Ss/
   I3XKA2E6GvH71u5goNmRdw5jKaxo15NR3uuXlz1sl+d7ux1nrRhnbormV
   N/gUEXXYMHzupqxVpOAuyKWYJR292dB/j7EfKjEyjji3e/WBll7PYP8Vr
   THQphZXv9PRrBTy0lWMw0D7ObDTpI0OYMqFwOiXHWhYuti7FCVu69nXH0
   vy9BnKFQmxDRhPgcOVCQWJmGMpIKix9l/Vuf4fHElg7Sizm/sVk9QG6C9
   w==;
X-CSE-ConnectionGUID: iyzmZ6DoSy6KlAXMEP+gtw==
X-CSE-MsgGUID: PpaKluT9QWyJ4wRknOkLKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36567877"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="36567877"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:42:14 -0800
X-CSE-ConnectionGUID: AHGA/AwhS3eSWRRIg5uRXA==
X-CSE-MsgGUID: DuSUhu83SByPM/nwBlWFTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="129417696"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:42:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 27 Nov 2024 12:42:07 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] platform/x86: acer-wmi: Improve error handling
 when reading AC status
In-Reply-To: <20241124171426.29203-5-W_Armin@gmx.de>
Message-ID: <de578b41-b301-0d50-7ef4-a00c31c6c9bf@linux.intel.com>
References: <20241124171426.29203-1-W_Armin@gmx.de> <20241124171426.29203-5-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 24 Nov 2024, Armin Wolf wrote:

> If a call to ACER_WMID_GET_GAMING_SYS_INFO_METHODID fails, the lower
> 8 bits will be non-zero. Use WMID_gaming_get_sys_info() to check for
> this when reading the AC status.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 7b549920eba7..6964fea84fa1 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1951,12 +1951,9 @@ static int acer_thermal_profile_change(void)
>  			return err;
> 
>  		/* Check power source */
> -		status = WMI_gaming_execute_u64(
> -			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
> -			ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS, &on_AC);
> -
> -		if (ACPI_FAILURE(status))
> -			return -EIO;
> +		err = WMID_gaming_get_sys_info(ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS, &on_AC);
> +		if (err < 0)
> +			return err;
> 
>  		switch (current_tp) {
>  		case ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO:
> --
> 2.39.5
> 

I'd add WMID_gaming_get_sys_info() in this change and reorder the series
so that this comes before the fan/temp/hwmon changes.

-- 
 i.


