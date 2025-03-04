Return-Path: <linux-kernel+bounces-544765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9899A4E4F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94C44219D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B442286286;
	Tue,  4 Mar 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzrW23ku"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF685259C86;
	Tue,  4 Mar 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102858; cv=none; b=TpH2aaLU7uT5ihTqK0XwCoG70W+WStB88HkrQ0LF6tUZocwanTglOzA/s8H4W18M/wzBdjm1JpgPMz1rvxOWhVNZreKwfDzArSgaYJcHjzETdLDgBwWnmgAApu2mTX6DJL/Crvp59GBAABnNpv04RqgZlq15ih0lcGZ417QRV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102858; c=relaxed/simple;
	bh=wIZ7AI2LpT6vomx8Vo1iusRU/dg+HFOUiIaIu1UXauU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AePvCwBfg2TvY1ApXBRawlnvKV734UZGj8sMR0oEPdElosUcSFTzeIEYSEKzjWiIv6R4nLDVchCH4iqweHT3DSnYNZal+mXy19IKggl/0IIIDSAqCl0Uq0ErqakILDYOpsLzAmnLoU3npxlQtWG3cWZUUnJNul2hxUyK2CmMmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzrW23ku; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741102857; x=1772638857;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wIZ7AI2LpT6vomx8Vo1iusRU/dg+HFOUiIaIu1UXauU=;
  b=lzrW23kuS+SFstxPDFpdu51nXd8zHgImU9A2In/DPBMVoU7gMOndEPOJ
   R3p5YN4xewhksiqLQ64tAI6DMa3/vJWNM9z3RSm3AOzARkjeH642X2p34
   ulI4TfOE/u2hicDB5DOwdKOjP1x1L2x5g7UE1KcKsudT5CMV8LjVBRcxU
   gMPelWn6hX7lTJI8HBn/BQbaOg+4o9i5Sca+oxcOxbt8NMBegH4Wz3vYw
   45m3kR6vEv9IyzfET9c93P4/HN5pT8/YUXTxibTK9qvJ/eT2nb/zhbudu
   +DHIs7w3dJdECGNWhbQJfu7DpoUU6wr5yWIZbh79Rngh/MIMXMUUThC7k
   Q==;
X-CSE-ConnectionGUID: 2x4F/4sYQk+12gybB+2hfw==
X-CSE-MsgGUID: RIzWff+GQLy4eIr0CoNgxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52664104"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="52664104"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:40:56 -0800
X-CSE-ConnectionGUID: gkHLXgWLTleh3xSEQK+s7A==
X-CSE-MsgGUID: W34DiZweSQmxcHy35CB3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118131539"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:40:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Mar 2025 17:40:50 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, Dell.Client.Kernel@dell.com, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/10] platform/x86: alienware-wmi-wmax: Improve
 platform profile probe
In-Reply-To: <20250225222500.23535-6-kuurtb@gmail.com>
Message-ID: <6f61f7dc-d5b8-7d61-c200-9c2c1ff2be7c@linux.intel.com>
References: <20250225222500.23535-1-kuurtb@gmail.com> <20250225222500.23535-6-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Feb 2025, Kurt Borja wrote:

> Get and store the AWCC system description in alienware_awcc_setup()
> instead of awcc_platform_profile_probe() and add a check for integer
> overflows to avoid misbehaviors.
> 
> While at it, replace set_bit() with it's non-atomic version __set_bit()
> because `choices` belong to this thread only.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  .../platform/x86/dell/alienware-wmi-wmax.c    | 61 ++++++++++++++-----
>  1 file changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> index 4a8335d90b5d..965b427f8f0a 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -37,6 +37,9 @@
>  #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
>  #define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
>  
> +/* Arbitrary limit based on supported models */
> +#define AWCC_MAX_RES_COUNT			16
> +
>  static bool force_platform_profile;
>  module_param_unsafe(force_platform_profile, bool, 0);
>  MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal profiles without checking if WMI thermal backend is available");
> @@ -211,6 +214,17 @@ struct wmax_u32_args {
>  
>  struct awcc_priv {
>  	struct wmi_device *wdev;
> +	union {
> +		u32 system_description;
> +		struct {
> +			u8 fan_count;
> +			u8 temp_count;
> +			u8 unknown_count;
> +			u8 profile_count;
> +		} __packed;
> +		u8 res_count[4];
> +	} __packed;

I don't like it how __packed is now creeping its way into priv structure 
too. It doesn't even seem useful in this case as all those are naturally 
aligned and take 4 bytes, AFAICT. Why did you add it?

> +
>  	struct device *ppdev;
>  	u8 supported_profiles[PLATFORM_PROFILE_LAST];
>  };
> @@ -614,38 +628,41 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
>  	enum platform_profile_option profile;
>  	struct awcc_priv *priv = drvdata;
>  	enum awcc_thermal_profile mode;
> -	u8 sys_desc[4];
> -	u32 first_mode;
> +	u8 id, offset = 0;
>  	u32 out_data;
>  	int ret;
> -	u8 id;
>  
> -	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
> -				       0, (u32 *) &sys_desc);
> -	if (ret < 0)
> -		return ret;
> -
> -	first_mode = sys_desc[0] + sys_desc[1];
> -
> -	for (u32 i = 0; i < sys_desc[3]; i++) {
> -		ret = awcc_op_get_resource_id(priv->wdev, i + first_mode, &out_data);
> +	/*
> +	 * Thermal profile IDs are listed last at offset
> +	 *	fan_count + temp_count + unknown_count
> +	 */
> +	for (unsigned int i = 0; i < ARRAY_SIZE(priv->res_count) - 1; i++)
> +		offset += priv->res_count[i];
>  
> +	for (unsigned int i = 0; i < priv->profile_count; i++) {
> +		ret = awcc_op_get_resource_id(priv->wdev, i + offset, &out_data);
>  		if (ret == -EIO)
>  			return ret;
>  
> +		/*
> +		 * Some devices report an incorrect number of thermal profiles
> +		 * so the resource ID list may end prematurely
> +		 */
>  		if (ret == -EBADRQC)
>  			break;
>  
>  		/* Some IDs have a BIT(8) flag that should be ignored */
>  		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
> -		if (!is_awcc_thermal_profile_id(id))
> +		if (!is_awcc_thermal_profile_id(id)) {
> +			dev_dbg(&priv->wdev->dev, "Unmapped thermal profile ID 0x%02x\n", id);
>  			continue;
> +		}
>  
>  		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
>  		profile = awcc_mode_to_platform_profile[mode];
>  		priv->supported_profiles[profile] = id;
>  
> -		set_bit(profile, choices);
> +		__set_bit(profile, choices);
>  	}
>  
>  	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
> @@ -655,7 +672,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
>  		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
>  			AWCC_THERMAL_MODE_GMODE;
>  
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>  	}
>  
>  	return 0;
> @@ -686,6 +703,20 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	ret = awcc_thermal_information(wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
> +				       0, &priv->system_description);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Sanity check */
> +	for (unsigned int i = 0; i < ARRAY_SIZE(priv->res_count); i++) {
> +		if (priv->res_count[i] > AWCC_MAX_RES_COUNT) {
> +			dev_err(&wdev->dev, "Malformed system description: 0x%08x\n",
> +				priv->system_description);
> +			return -ENXIO;
> +		}
> +	}
> +
>  	priv->wdev = wdev;
>  	dev_set_drvdata(&wdev->dev, priv);
>  
> 

-- 
 i.


