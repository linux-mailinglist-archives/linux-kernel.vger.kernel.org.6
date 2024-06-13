Return-Path: <linux-kernel+bounces-212884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A249067C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B9F1C227AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A54140386;
	Thu, 13 Jun 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bd8/+7lD"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F078E13E04A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268648; cv=none; b=KyPqaKdHAGRj+JwzBvVhWZfM24GTT/UVOmGJVDT1AQiTzpH/iyWdDFNl6jWsLeRTPozrxepT4QodMcwjF4CttP1r7IEE8IiWvywuEXEHC7yg0WmkidvHlaLOGH4vg9eWcHRdPuSv2aHC+jGMNxSLxCSmyWh9ql91v7IEqwNzLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268648; c=relaxed/simple;
	bh=vGjpnmrPC+QP/k6kxF0jRLsKiEXE0wG2htjfoZ2yq2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ElhmneDtnC5BDj8nkuaUXMHweXvK7CyHy+K2UvemFe/Z4pUYvcqzXtut1WOIFTEnlMqZ7vpzv3PmBUuOQmHwsi9arc9hyXm6ObTVT+cvvYjoLBK3mWESiSKoVFOlqpy3Q/s/6wI2HnyrOYTgWeG9gojQOnE4oQiYzLIcdCngp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bd8/+7lD; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8oMcG015265;
	Thu, 13 Jun 2024 03:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718268622;
	bh=39EYWY7+nUf4nZ2MOh8ZDienfKEg5Se8HY2Tilf3GX8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Bd8/+7lD2OifN2hDM8Tj4cZeCorKA8kkTo905N6atrcelrGMmUCuXueH0OE2t5TuK
	 tzzZmJmv2sYmEqtyhR5sU11Y+KYRrvJUEmZ0qdvG53KtVVgnQVF8/Ft4x/6cV3rFzM
	 lHlPPVovdt3qJXkIVds4LTw1Jn1j445RJvunwrlM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8oMOv092927
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:50:22 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:50:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:50:22 -0500
Received: from [10.249.129.248] ([10.249.129.248])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8ntew089041;
	Thu, 13 Jun 2024 03:50:16 -0500
Message-ID: <bb081ec4-9c1a-4318-82c9-687751f05774@ti.com>
Date: Thu, 13 Jun 2024 14:20:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm/bridge: sii902x: Support atomic bridge APIs
Content-Language: en-US
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
 <20240613083805.439337-3-j-choudhary@ti.com>
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240613083805.439337-3-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 13-Jun-24 14:08, Jayesh Choudhary wrote:
> Change exisitig enable() and disable() bridge hooks to their atomic
> counterparts as the former hooks are deprecated.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 6a6055a4ccf9..00a8c469f553 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -322,7 +322,8 @@ static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs =
>  	.get_modes = sii902x_get_modes,
>  };
>  
> -static void sii902x_bridge_disable(struct drm_bridge *bridge)
> +static void sii902x_bridge_atomic_disable(struct drm_bridge *bridge,
> +					  struct drm_bridge_state *old_bridge_state)
>  {
>  	struct sii902x *sii902x = bridge_to_sii902x(bridge);
>  
> @@ -335,7 +336,8 @@ static void sii902x_bridge_disable(struct drm_bridge *bridge)
>  	mutex_unlock(&sii902x->mutex);
>  }
>  
> -static void sii902x_bridge_enable(struct drm_bridge *bridge)
> +static void sii902x_bridge_atomic_enable(struct drm_bridge *bridge,
> +					 struct drm_bridge_state *old_bridge_state)
>  {
>  	struct sii902x *sii902x = bridge_to_sii902x(bridge);
>  
> @@ -520,8 +522,8 @@ sii902x_bridge_mode_valid(struct drm_bridge *bridge,
>  static const struct drm_bridge_funcs sii902x_bridge_funcs = {
>  	.attach = sii902x_bridge_attach,
>  	.mode_set = sii902x_bridge_mode_set,
> -	.disable = sii902x_bridge_disable,
> -	.enable = sii902x_bridge_enable,
> +	.atomic_disable = sii902x_bridge_atomic_disable,
> +	.atomic_enable = sii902x_bridge_atomic_enable,
>  	.detect = sii902x_bridge_detect,
>  	.edid_read = sii902x_bridge_edid_read,
>  	.atomic_reset = drm_atomic_helper_bridge_reset,

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

-- 
Regards
Aradhya

