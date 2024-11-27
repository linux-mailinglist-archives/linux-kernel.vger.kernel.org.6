Return-Path: <linux-kernel+bounces-423288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F619DA56F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B941669E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6C194C75;
	Wed, 27 Nov 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTd9X5jc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEF194A70;
	Wed, 27 Nov 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701997; cv=none; b=M4iBw06SNWqlaThJ8VLfEy8SFV3abLRJyKJBcHgPxg3JYw4pRkIKNIr53Zi8ecGrOxevXkd8zlYvPyP8mzI5AqL3cx/uUKDGkZCudDsc0lq01u2sv4aVDFrWlBPMx/3zPCBP+950aAfnPDxlcmpYiSigscNWvnFRPg7aZxfxTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701997; c=relaxed/simple;
	bh=wOEVUARAN4xHgNi2ik1vL5uRyf0dpqZmW9fuS6mSV8Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xa/3iAdORymGW7dyzeJb9zUM0hmEX06QGbILvYyqZ9VSrTpWbRI6bpE6BCrpLvPS3oQ8BCMe5FTHo/HS/SL9AZqTepqSj93WvF/0+9MIO8+mQIUIJobLxSEhEazmUYr02K8xRcIGiu0iV14JQ4JWMdXDxV2LR0etJBAqPO54u7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTd9X5jc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732701995; x=1764237995;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wOEVUARAN4xHgNi2ik1vL5uRyf0dpqZmW9fuS6mSV8Y=;
  b=DTd9X5jc7pBsKRwY08mpG9FVjfgDhtCyXBfKot79acitEDzrpLcHQ2iB
   siMOHQNZuFabXgqVkqIMy9Ds8ydoJz9B0ZYvJwZ3F3pU9iWGDjt9aV2yZ
   PEg8pGtpqBATCWxRnH3k+c0v3tNfSGw8Z1vzntFYNntvrS/GY8sENyuxC
   NHcmWgwKLz2PMwz19EonGrRP5obN7IdhAauFy+b6+CsXjWxbmfenoAgeo
   SLTEZ77d/4/ZOM6341ZEjIJx5kslUQOzlqGnDquKUEnKv1L4U1GhopNGF
   T0wlEK+aD4Osyv8eP2zBYJ8E3TGjyrAfeyP3KZyNvKXFp4MR6gTA4UDC0
   g==;
X-CSE-ConnectionGUID: BRMIhgnDRZK9tH7t+PjfeA==
X-CSE-MsgGUID: oAk11A6FRSWlsCP0R7BgQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32847987"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="32847987"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:06:34 -0800
X-CSE-ConnectionGUID: 3AjYCm1aTcmJEyv49QaA0g==
X-CSE-MsgGUID: ofl/BayLQRmnIj07uCkNXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="91989410"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:06:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 27 Nov 2024 12:06:28 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] platform/x86: acer-wmi: Rename
 ACER_CAP_FAN_SPEED_READ
In-Reply-To: <20241124171426.29203-3-W_Armin@gmx.de>
Message-ID: <f711c1b0-7208-3d22-1ff9-399c7478125c@linux.intel.com>
References: <20241124171426.29203-1-W_Armin@gmx.de> <20241124171426.29203-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 24 Nov 2024, Armin Wolf wrote:

> Rename ACER_CAP_FAN_SPEED_READ to ACER_CAP_HWMON to prepare for
> upcomming changes in the hwmon handling code.

upcoming

-- 
 i.

> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 5cff538ee67f..dd57787466b9 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -246,7 +246,7 @@ struct hotkey_function_type_aa {
>  #define ACER_CAP_TURBO_LED		BIT(8)
>  #define ACER_CAP_TURBO_FAN		BIT(9)
>  #define ACER_CAP_PLATFORM_PROFILE	BIT(10)
> -#define ACER_CAP_FAN_SPEED_READ		BIT(11)
> +#define ACER_CAP_HWMON			BIT(11)
> 
>  /*
>   * Interface type flags
> @@ -358,7 +358,7 @@ static void __init set_quirks(void)
> 
>  	if (quirks->predator_v4)
>  		interface->capability |= ACER_CAP_PLATFORM_PROFILE |
> -					 ACER_CAP_FAN_SPEED_READ;
> +					 ACER_CAP_HWMON;
>  }
> 
>  static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -2551,7 +2551,7 @@ static int acer_platform_probe(struct platform_device *device)
>  			goto error_platform_profile;
>  	}
> 
> -	if (has_cap(ACER_CAP_FAN_SPEED_READ)) {
> +	if (has_cap(ACER_CAP_HWMON)) {
>  		err = acer_wmi_hwmon_init();
>  		if (err)
>  			goto error_hwmon;
> --
> 2.39.5
> 

