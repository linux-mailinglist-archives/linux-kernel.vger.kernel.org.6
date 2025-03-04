Return-Path: <linux-kernel+bounces-544566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217C6A4E2A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F1A19C4157
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4027EC7C;
	Tue,  4 Mar 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4DSAFHw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6E27E1B0;
	Tue,  4 Mar 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100577; cv=none; b=KedSOe9hEr2nOGrjfKWF1fZcONjIabTwdsAcS0TnqrAC9UUSbRTTXJr/dj8gz3f6us/6d8Cs827coMf+O+0MDbfMOzLFAOCKunBS47jzjyzFhFZZzZClZzOSc6Dr9Qz0MFe5+zLt4VLErZ7H4UzEnVgJguDq1tEhsLAyt6J5bMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100577; c=relaxed/simple;
	bh=3qgC9xL3LGsrpBPDjFVjF6jeBO5A0jHAMJCZZjVjOVc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rHO5iiroRRvxqNXK+7+hXJPrrnYJEK7j6+Cc+bs/ONXDPiY79iHjngTeDs5QdscEfEIQXX6Wt6SONc3WaB7amB4778l1QODsw6XnFN4qDtDOPUvnjd+CVlJjbga3iNANK0fF/MFNKGsYxEX4B++n/y3dEtNFqYSI2Mbf05sZOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4DSAFHw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741100576; x=1772636576;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3qgC9xL3LGsrpBPDjFVjF6jeBO5A0jHAMJCZZjVjOVc=;
  b=c4DSAFHwiCXXn1Gbot9nPb7hp2xVwmdtLnaTp0cqEId0fkXFILWzaDPH
   qM2jkEWJI/mp5z5Z8fMQRNZGjCvUn137W5T7I88v7FrFG1Ks9//4ExhDS
   Tcb1C8CMbBJsX+s2zbZQJGvWplA970xIq//6elM6KtLMWpVdZD0rOIj74
   nU3IsVmOk8SgQmzUscgMLPPVrqbg5Jkp4n4HHEF8Ad7Qvn9sHma2QuAhZ
   CNaH0l0nocm6c1GgBoMYs4WNNcyonF+DmWsVoQzTRsoJ3bYdpFS9Pm216
   Rl/2ZF77/dDOxbfhX5fCrPMQxbv6veg3O1b9e4/yrhp1ZEEV4vmTPcWRf
   g==;
X-CSE-ConnectionGUID: wGmXT7AOTJ2a2Fj4md7+Sw==
X-CSE-MsgGUID: H5w/wx/LQu29fvqJ777+3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42148301"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42148301"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:02:55 -0800
X-CSE-ConnectionGUID: CoNAUJPRSKe4HchEmuL5QA==
X-CSE-MsgGUID: ODL7vkAqS42IsBZIMVm/iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118907715"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:02:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Mar 2025 17:02:49 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, Dell.Client.Kernel@dell.com, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] platform/x86: alienware-wmi-wmax: Refactor
 is_awcc_thermal_mode()
In-Reply-To: <20250225222500.23535-3-kuurtb@gmail.com>
Message-ID: <2f8f3818-f1ba-c7b8-f3e5-148436b930f6@linux.intel.com>
References: <20250225222500.23535-1-kuurtb@gmail.com> <20250225222500.23535-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Feb 2025, Kurt Borja wrote:

> Refactor is_awcc_thermal_mode() to use FIELD_GET() instead of bitwise
> operations. Drop the check for BIT(8) sensor flag and rename it to
> is_awcc_thermal_profile_id().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  .../platform/x86/dell/alienware-wmi-wmax.c    | 31 ++++++++++---------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> index ed70e12d73d7..7f0aa88221d6 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -34,7 +34,7 @@
>  #define AWCC_FAILURE_CODE			0xFFFFFFFF
>  #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
>  #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
> -#define AWCC_SENSOR_ID_MASK			BIT(8)
> +#define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
>  
>  static bool force_platform_profile;
>  module_param_unsafe(force_platform_profile, bool, 0);
> @@ -168,8 +168,8 @@ enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
>  };
>  
>  enum AWCC_THERMAL_TABLES {
> -	AWCC_THERMAL_TABLE_LEGACY		= 0x90,
> -	AWCC_THERMAL_TABLE_USTT			= 0xA0,
> +	AWCC_THERMAL_TABLE_LEGACY		= 0x9,
> +	AWCC_THERMAL_TABLE_USTT			= 0xA,
>  };
>  
>  enum awcc_thermal_profile {
> @@ -445,20 +445,18 @@ const struct attribute_group wmax_deepsleep_attribute_group = {
>   * Thermal Profile control
>   *  - Provides thermal profile control through the Platform Profile API
>   */
> -static bool is_awcc_thermal_mode(u32 code)
> +static bool is_awcc_thermal_profile_id(u8 code)
>  {
> -	if (code & AWCC_SENSOR_ID_MASK)
> -		return false;
> +	u8 table = FIELD_GET(AWCC_THERMAL_TABLE_MASK, code);
> +	u8 mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, code);
>  
> -	if ((code & AWCC_THERMAL_MODE_MASK) >= AWCC_PROFILE_LAST)
> +	if (mode >= AWCC_PROFILE_LAST)
>  		return false;
>  
> -	if ((code & AWCC_THERMAL_TABLE_MASK) == AWCC_THERMAL_TABLE_LEGACY &&
> -	    (code & AWCC_THERMAL_MODE_MASK) >= AWCC_PROFILE_LEGACY_QUIET)
> +	if (table == AWCC_THERMAL_TABLE_LEGACY && mode >= AWCC_PROFILE_LEGACY_QUIET)
>  		return true;
>  
> -	if ((code & AWCC_THERMAL_TABLE_MASK) == AWCC_THERMAL_TABLE_USTT &&
> -	    (code & AWCC_THERMAL_MODE_MASK) <= AWCC_PROFILE_USTT_LOW_POWER)
> +	if (table == AWCC_THERMAL_TABLE_USTT && mode <= AWCC_PROFILE_USTT_LOW_POWER)
>  		return true;
>  
>  	return false;
> @@ -548,7 +546,7 @@ static int awcc_platform_profile_get(struct device *dev,
>  		return 0;
>  	}
>  
> -	if (!is_awcc_thermal_mode(out_data))
> +	if (!is_awcc_thermal_profile_id(out_data))
>  		return -ENODATA;
>  
>  	out_data &= AWCC_THERMAL_MODE_MASK;
> @@ -597,6 +595,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
>  	u32 first_mode;
>  	u32 out_data;
>  	int ret;
> +	u8 id;
>  
>  	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
>  				       0, (u32 *) &sys_desc);
> @@ -615,12 +614,14 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
>  		if (ret == -EBADRQC)
>  			break;
>  
> -		if (!is_awcc_thermal_mode(out_data))
> +		/* Some IDs have a BIT(8) flag that should be ignored */

I find the place of this comment odd. If you want to keep it, it should be 
next to the GENMASK() as in this place I'm trying to find the code that 
implements what you commented but its nowhere near here.

> +		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
> +		if (!is_awcc_thermal_profile_id(id))
>  			continue;
>  
> -		mode = out_data & AWCC_THERMAL_MODE_MASK;
> +		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
>  		profile = awcc_mode_to_platform_profile[mode];
> -		priv->supported_thermal_profiles[profile] = out_data;
> +		priv->supported_thermal_profiles[profile] = id;
>  
>  		set_bit(profile, choices);
>  	}
> 

-- 
 i.


