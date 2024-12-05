Return-Path: <linux-kernel+bounces-433060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844249E537B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69ADA18823AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3157F1DFD89;
	Thu,  5 Dec 2024 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZnEGPYG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD91DE2B1;
	Thu,  5 Dec 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397304; cv=none; b=DB9LnpGbxChYYqpA/eJs6Ct773CmykgFZcm9CgkQgNOG2c6YYGtFN7m2MD9SNr6ugLWughmSDKHJq+u6oAEi2MJBxAcqFZA2woSL4IdmceM2G5oIsBB1ZZTfQGOyw0IiaWf6OwGvv6Eh7VlpSqOSPGlLuCegUAGGmKDAmhDypd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397304; c=relaxed/simple;
	bh=iwPtqIFKQrkO4uV7+BcXry+PtsnSBBt1ZeiHjsWEiiM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BAxzT/Z0zMA1W8ZFQPIKkZHfEDp4POuI7fLqRkvKByIE4VHBVanbQXiAeKhk01RaPhC/9I0Q3O4cBUUNM57cgt7s3Uq5TRTs2g0LzLxQdcToT7uPlNMmqgfoR6QddL5sgv6qW83gz8WQGkhR/RD3H4/IzMcvZBQ2Qtl7DKDTGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZnEGPYG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733397303; x=1764933303;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iwPtqIFKQrkO4uV7+BcXry+PtsnSBBt1ZeiHjsWEiiM=;
  b=IZnEGPYGqHtCO5xB4kjDYWsq/ce3JljEABZFjXyIrIL1s75RtiYHSZAj
   tb2qfdcrCKV8xvFrAF8yBuEJtGH1TiMdYjvSWIWWW8vxnzspGOUpQsYQu
   RgZJ3pC5g5EA9aJ6BAgsGh1xnFxjSkJVStaSNda2UVeuLeF8+3NwnXFDB
   APv+Z9TA9+W/+Gh8UdhtDsidUXevjmspo0+uG5vwsF1Wn2d/p23bOwJxv
   5ky2A23hioMwNYnY8NjCm29vRXHMOTcC4QNXlZYAlEjrCFOhoR53oBS0Z
   YMBFwOv1OyF8fDCoLW4ucQnWEyKpKSSWgk4Zcz5h6Ld+3X+btiHCH5S0B
   Q==;
X-CSE-ConnectionGUID: sk42iPEiT8adj6sViZLojg==
X-CSE-MsgGUID: jPsxB5ayQL2G95zK1WRa+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37486918"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="37486918"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:14:58 -0800
X-CSE-ConnectionGUID: D/awZd2PTFOF5VKOEi4VFQ==
X-CSE-MsgGUID: VWvJcG38Qaex0J4Rom2IwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94542076"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:14:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 13:14:43 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
    platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [RFC PATCH 17/21] alienware-wmi: Drop thermal methods dependency
 on quirks
In-Reply-To: <20241205004609.2186681-2-kuurtb@gmail.com>
Message-ID: <ba1ed892-01e3-20fd-85ce-fae9ad10e96f@linux.intel.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com> <20241205004609.2186681-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Dec 2024, Kurt Borja wrote:

> Make the `gmode` condition on AWCC WMI devices part of the device's
> state container, and refactor "platform_profile" methods accordingly.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/alienware-wmi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index fa21a50d66bd..7137995d5983 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -407,6 +407,7 @@ struct awcc_priv {
>  	struct wmi_device *wdev;
>  	struct platform_profile_handler pp_handler;
>  	enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
> +	bool has_gmode;
>  };
>  
>  struct alienfx_priv {
> @@ -1044,7 +1045,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
>  
>  	priv = container_of(pprof, struct awcc_priv, pp_handler);
>  
> -	if (quirks->gmode) {
> +	if (priv->has_gmode) {
>  		u32 gmode_status;
>  		int ret;
>  
> @@ -1070,7 +1071,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
>  				    priv->supported_thermal_profiles[profile]);
>  }
>  
> -static int create_thermal_profile(struct wmi_device *wdev)
> +static int create_thermal_profile(struct wmi_device *wdev, bool has_gmode)
>  {
>  	struct awcc_priv *priv;
>  	u32 out_data;
> @@ -1115,7 +1116,8 @@ static int create_thermal_profile(struct wmi_device *wdev)
>  	if (bitmap_empty(priv->pp_handler.choices, PLATFORM_PROFILE_LAST))
>  		return -ENODEV;
>  
> -	if (quirks->gmode) {
> +	if (has_gmode) {
> +		priv->has_gmode = true;
>  		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
>  			WMAX_THERMAL_MODE_GMODE;
>  
> @@ -1130,8 +1132,7 @@ static int create_thermal_profile(struct wmi_device *wdev)
>  
>  static void remove_thermal_profile(void)
>  {
> -	if (quirks->thermal)
> -		platform_profile_remove();
> +	platform_profile_remove();

Did you intend to make this change in this patch?

I'm unable to confirm why the if () could now be removed and how it is 
related to other parts of this patch.

>  }
>  
>  /*
> @@ -1339,7 +1340,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
>  	};
>  
>  	if (quirks->thermal)
> -		ret = create_thermal_profile(wdev);
> +		ret = create_thermal_profile(wdev, quirks->gmode);
>  	else if (quirks->num_zones > 0)
>  		ret = alienfx_wmi_init(&pdata);
>  
> 

-- 
 i.


