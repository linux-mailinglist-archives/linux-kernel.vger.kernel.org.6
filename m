Return-Path: <linux-kernel+bounces-212883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DEA9067D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A37B2392A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C155113F453;
	Thu, 13 Jun 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EOkUcu5s"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7AD13E038
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268647; cv=none; b=EW6DZJtDBv4CTFqXoE5H9+rPNH5DTH6Ew5hqr7jaQDP9w65ilCvV0i490hC8gNOV9P8TDU8G4CHpa6Og8hYuItRbVUKMKjopkRNXzd5C/goUcpE/33AATyncs3wO8GJ9sClwx8GOKbutO9TZ20NqkaMq0wSkdrpZCt0Q5HhjF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268647; c=relaxed/simple;
	bh=VU63zLxtCiRNcx7dqJKj6X/dpp7ISGiDAgbicqwpctc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PLNh32dkQZYlWRbgDSUQ3MQuJJRTdLt8esHKCa/rVz3SheeqmOFYcKoNivvbKNIkdKRqvsLCgUtLUF/0/M80beBdKslRwAMtc/hqxWpZijGP/i7SdDdHx6rwFa+8C+7tBNPQH+AejaIDYIVdnvbBQNqNejQjmehIm7K7g9MOzfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EOkUcu5s; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8o1hh105500;
	Thu, 13 Jun 2024 03:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718268602;
	bh=ChnWdPKf1jQd19t1eqZ7k3wiY14doCijOomIL3s14so=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EOkUcu5styHyvyFqFQqR2OcbE3Y5NdJIC0j1iVs8FCfbxfJHffXa9v81svRHuPjkt
	 14/OMi4lZV9cbm+BJyHpFGKxymrCF+u8njSDkiFZ0TVhka4u/gz2d/Nzddk09avLaO
	 W7JI53ZYcNIdJn9gvPi8zJfkGG6rbA6QMf+RtmVc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8o1FQ076207
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:50:01 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:50:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:50:01 -0500
Received: from [10.249.129.248] ([10.249.129.248])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8ntev089041;
	Thu, 13 Jun 2024 03:49:56 -0500
Message-ID: <5aaf6d52-eaea-4de9-a53e-a6b61cbef35d@ti.com>
Date: Thu, 13 Jun 2024 14:19:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/bridge: sii902x: Fix mode_valid hook
To: Jayesh Choudhary <j-choudhary@ti.com>, <linux-kernel@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <sui.jingfeng@linux.dev>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <mripard@kernel.org>, <sam@ravnborg.org>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>
References: <20240613083805.439337-1-j-choudhary@ti.com>
 <20240613083805.439337-2-j-choudhary@ti.com>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240613083805.439337-2-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jayesh,

Thanks for the patches!

On 13-Jun-24 14:08, Jayesh Choudhary wrote:
> Currently, mode_valid is defined only in drm_connector_helper_funcs.
> When the bridge is attached with the 'DRM_BRIDGE_ATTACH_NO_CONNECTOR'
> flag, the connector is not initialized, and so is the mode_valid
> hook under connector helper funcs.
> It also returns MODE_OK for all modes without actually checking the
> modes.
> So move the mode_valid hook to drm_bridge_funcs with proper clock
> checks for maximum and minimum pixel clock supported by the bridge.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 2fbeda9025bf..6a6055a4ccf9 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -163,6 +163,14 @@
>  
>  #define SII902X_AUDIO_PORT_INDEX		3
>  
> +/*
> + * The maximum resolution supported by the HDMI bridge is 1080p@60Hz
> + * and 1920x1200 requiring a pixel clock of 165MHz and the minimum
> + * resolution supported is 480p@60Hz requiring a pixel clock of 25MHz
> + */
> +#define SII902X_MIN_PIXEL_CLOCK_KHZ		25000
> +#define SII902X_MAX_PIXEL_CLOCK_KHZ		165000
> +
>  struct sii902x {
>  	struct i2c_client *i2c;
>  	struct regmap *regmap;
> @@ -310,17 +318,8 @@ static int sii902x_get_modes(struct drm_connector *connector)
>  	return num;
>  }
>  
> -static enum drm_mode_status sii902x_mode_valid(struct drm_connector *connector,
> -					       struct drm_display_mode *mode)
> -{
> -	/* TODO: check mode */
> -
> -	return MODE_OK;
> -}
> -
>  static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs = {
>  	.get_modes = sii902x_get_modes,
> -	.mode_valid = sii902x_mode_valid,
>  };
>  
>  static void sii902x_bridge_disable(struct drm_bridge *bridge)
> @@ -504,6 +503,20 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
>  	return 0;
>  }
>  
> +static enum drm_mode_status
> +sii902x_bridge_mode_valid(struct drm_bridge *bridge,
> +			  const struct drm_display_info *info,
> +			  const struct drm_display_mode *mode)
> +{
> +	if (mode->clock < SII902X_MIN_PIXEL_CLOCK_KHZ)
> +		return MODE_CLOCK_LOW;
> +
> +	if (mode->clock > SII902X_MAX_PIXEL_CLOCK_KHZ)
> +		return MODE_CLOCK_HIGH;
> +
> +	return MODE_OK;
> +}
> +
>  static const struct drm_bridge_funcs sii902x_bridge_funcs = {
>  	.attach = sii902x_bridge_attach,
>  	.mode_set = sii902x_bridge_mode_set,
> @@ -516,6 +529,7 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>  	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
>  	.atomic_check = sii902x_bridge_atomic_check,
> +	.mode_valid = sii902x_bridge_mode_valid,
>  };
>  
>  static int sii902x_mute(struct sii902x *sii902x, bool mute)

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

-- 
Regards
Aradhya

