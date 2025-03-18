Return-Path: <linux-kernel+bounces-565878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D348A6706D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C26E1890643
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1498207667;
	Tue, 18 Mar 2025 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTtzRoY/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7A19F424
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291752; cv=none; b=EB+iLLwtQ3chaJ9mgpTwLuQCk9fXUlocj34FC8N9XVu416vZm7Kfk/3xpH6kDXwDHfY19gCriqW48McOGGn1LFt55AAq+070LnODoLJLOwGWngW+cYlqlchdEId9JSG6E/RLCWKidUQxnAwQq5ZiFcOZGJHl/QqFA1uepdMIekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291752; c=relaxed/simple;
	bh=6Ci7Z6r/V5Qzb/u0ILeh9lEk9VCs8fS5/6fHRjx7i2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0L9gxKjiySBR0xTUdNwfU4+imgecHAaYarIAyFFcMo2dzmjxkDZ9x/r0zmRaR2Rj+6AtOjhkQyx7c58iM6S/rhrTDStjEnODPcBYeH5i9+HPqWjV/RTIq6hGUCkguKmEJ6oE7ZRHpAqBs8deExWZoqpsnY+0k+OAOSJZEHQpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTtzRoY/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742291751; x=1773827751;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6Ci7Z6r/V5Qzb/u0ILeh9lEk9VCs8fS5/6fHRjx7i2U=;
  b=KTtzRoY/YWN4/dkRGl1dYJsDJjcSxYgn3GeTy/3vnkDdfird3oOYSFI8
   3MgOyTWCRoq59v9udse6Z1flW/YlWxa/Iy9z264jZu4P6ei407Al+5EAG
   GtNnUE/a35zx8R6TzJ4MHgsuhp4LSvVBMoaY3BLrAG3ZPodlIUOpv7IXZ
   YjhRhLdOk+eg8Bl7bOQRc2G2JXm2grZ/6PgJNZxgABTT/3t6r6ca6X+MS
   0lk075lzgdd/9OpdD2zXgBs9gdgMphdGUpNYsN4SghAEWkNKjPzyrGtva
   AUjaHr1ZxiI/vh29t6u6wY2bGaFYu/u0Ns/9SxQu1r8MO4NxODwPfhPio
   w==;
X-CSE-ConnectionGUID: KaUlYQDZRc6vO4dMgJC/1g==
X-CSE-MsgGUID: L0pAcaLGRP24zvPLiUUmvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43612640"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43612640"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 02:55:50 -0700
X-CSE-ConnectionGUID: +kz5MCcjShOb8mQXn/wNPg==
X-CSE-MsgGUID: bhhdt0rdS0iIjYaLOa/7Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="145392992"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.165])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 02:55:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yongbang Shi <shiyongbang@huawei.com>, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, lidongming5@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, shenjian15@huawei.com,
 shaojijie@huawei.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 drm-dp 5/9] drm/hisilicon/hibmc: Getting connector
 info and EDID by using AUX channel
In-Reply-To: <20250310040138.2025715-6-shiyongbang@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250310040138.2025715-1-shiyongbang@huawei.com>
 <20250310040138.2025715-6-shiyongbang@huawei.com>
Date: Tue, 18 Mar 2025 11:55:40 +0200
Message-ID: <87o6xyd5nn.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 10 Mar 2025, Yongbang Shi <shiyongbang@huawei.com> wrote:
> @@ -15,11 +15,17 @@
>  
>  static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
>  {
> +	struct hibmc_dp *dp = to_hibmc_dp(connector);
> +	const struct drm_edid *drm_edid;
>  	int count;
>  
> -	count = drm_add_modes_noedid(connector, connector->dev->mode_config.max_width,
> -				     connector->dev->mode_config.max_height);
> -	drm_set_preferred_mode(connector, 1024, 768); // temporary implementation
> +	drm_edid = drm_edid_read_ddc(connector, &dp->aux.ddc);

drm_edid_read() should cover this if connector->ddc is set properly...

> @@ -103,8 +125,8 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>  
>  	drm_encoder_helper_add(encoder, &hibmc_dp_encoder_helper_funcs);
>  
> -	ret = drm_connector_init(dev, connector, &hibmc_dp_conn_funcs,
> -				 DRM_MODE_CONNECTOR_DisplayPort);
> +	ret = drm_connector_init_with_ddc(dev, connector, &hibmc_dp_conn_funcs,
> +					  DRM_MODE_CONNECTOR_DisplayPort, &dp->aux.ddc);

...which you seem to do here.

BR,
Jani.


-- 
Jani Nikula, Intel

