Return-Path: <linux-kernel+bounces-373850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA639A5DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C951C21464
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3A71E102C;
	Mon, 21 Oct 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o2JrKS/V"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EF1E1022
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497409; cv=none; b=XNFKOdPLDQgv5P+srdzttXj7hzwlKYwqhzWchFjWoKkloAt7fEuJasqSbfjXtw5XxuCHuCKus0RdJxPwF9XkLHLXbbI31PbIygjILweMKBdXfhxtbt30NY/s622xAROdxuVxR0M3EiMKnbtzFXYOVEK8sDkYVUQonwQyy4qzbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497409; c=relaxed/simple;
	bh=D4tf7xAfL9Kx0tW7kSDxr2Kpk6+LcteU+JQAkd5FRwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bqd7KwTL13RIuxqQ4L4mogi1AGn8bNGk1G74nYFO5Trt5WpmCGMmi6goK4P9VkGnwmtWjDWVkJD5/h8ZN9sIoVu0XtLckbBkIzhjQBZyg3zsx20lkrwqWeLqxSvvM4ypoWGWge2wOapWQXbCs9pf9i7og9HwDAZKI2+7AH+fKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o2JrKS/V; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729497408; x=1761033408;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D4tf7xAfL9Kx0tW7kSDxr2Kpk6+LcteU+JQAkd5FRwc=;
  b=o2JrKS/VUxrXB4gqLnDJjQrqpQeLxkVO3TMsgxiOvtNHOU0b1CxQjlGQ
   yehp3xvP2YHahdmtor6fbEmS8tnedWDbiwchh7xcDeTgTphZnobsItIXm
   jWHnhFipKN6FIAWAWbL1KDSjLUipWsoNo9xxtKUnhlZ5gi76lVl7WgOrS
   uU2qlpUL7Ij9FH7qjGk/NNBKr5XXFH4Ir43qUUCP3Y7ubJlNyXJnZ4I1B
   utyIkgkn0nd5lAyBlf6Wv2oY66bm8ig8Y1QHHuonsEFBE36xOJBiUrOhB
   58h3mZ7YdqlR7nqICOY5oh6wfMOGsbSusX7b5TxeDyaKQSRMVLrqX4bO6
   A==;
X-CSE-ConnectionGUID: myTjaD8mQ8OJ4PBrExTmXA==
X-CSE-MsgGUID: 9GEN55FtSKuxdMi6rMNDcw==
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="264363866"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 00:56:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 00:56:22 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 21 Oct 2024 00:56:20 -0700
Message-ID: <7106870f-6452-47b1-9251-ce2a69366fe7@microchip.com>
Date: Mon, 21 Oct 2024 09:56:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: atmel-hlcdc: fix atmel_xlcdc_plane_setup_scaler()
To: Manikandan Muralidharan <manikandan.m@microchip.com>, <sam@ravnborg.org>,
	<bbrezillon@kernel.org>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <Hari.PrasathGE@microchip.com>,
	<durai.manickamkr@microchip.com>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Cyrille Pitchen <cyrille.pitchen@microchip.com>
References: <20241014094942.325211-1-manikandan.m@microchip.com>
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20241014094942.325211-1-manikandan.m@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2024 at 11:49, Manikandan Muralidharan wrote:
> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> 
> On SoCs, like the SAM9X75, which embed the XLCDC ip, the registers that
> configure the unified scaling engine were not filled with proper values.
> 
> Indeed, for YCbCr formats, the VXSCFACT bitfield of the HEOCFG25
> register and the HXSCFACT bitfield of the HEOCFG27 register were
> incorrect.
> 
> For 4:2:0 formats, both vertical and horizontal factors for
> chroma chanels should be divided by 2 from the factors for the luma
> channel. Hence:
> 
> HEOCFG24.VXSYFACT = VFACTOR
> HEOCFG25.VSXCFACT = VFACTOR / 2
> HEOCFG26.HXSYFACT = HFACTOR
> HEOCFG27.HXSCFACT = HFACTOR / 2
> 
> However, for 4:2:2 formats, only the horizontal factor for chroma
> chanels should be divided by 2 from the factor for the luma channel;
> the vertical factor is the same for all the luma and chroma channels.
> Hence:
> 
> HEOCFG24.VXSYFACT = VFACTOR
> HEOCFG25.VXSCFACT = VFACTOR
> HEOCFG26.HXSYFACT = HFACTOR
> HEOCFG27.HXSCFACT = HFACTOR / 2
> 
> Fixes: d498771b0b83 ("drm: atmel_hlcdc: Add support for XLCDC using IP specific driver ops")
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>

Thanks Mani and Cyrille:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
  Nicolas

> ---
>   .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 27 ++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 4bcaf2cd7672..41c7351ae811 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -365,13 +365,34 @@ void atmel_xlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
>   				    xfactor);
>   
>   	/*
> -	 * With YCbCr 4:2:2 and YCbYcr 4:2:0 window resampling, configuration
> -	 * register LCDC_HEOCFG25.VXSCFACT and LCDC_HEOCFG27.HXSCFACT is half
> +	 * With YCbCr 4:2:0 window resampling, configuration register
> +	 * LCDC_HEOCFG25.VXSCFACT and LCDC_HEOCFG27.HXSCFACT values are half
>   	 * the value of yfactor and xfactor.
> +	 *
> +	 * On the other hand, with YCbCr 4:2:2 window resampling, only the
> +	 * configuration register LCDC_HEOCFG27.HXSCFACT value is half the value
> +	 * of the xfactor; the value of LCDC_HEOCFG25.VXSCFACT is yfactor (no
> +	 * division by 2).
>   	 */
> -	if (state->base.fb->format->format == DRM_FORMAT_YUV420) {
> +	switch (state->base.fb->format->format) {
> +	/* YCbCr 4:2:2 */
> +	case DRM_FORMAT_YUYV:
> +	case DRM_FORMAT_UYVY:
> +	case DRM_FORMAT_YVYU:
> +	case DRM_FORMAT_VYUY:
> +	case DRM_FORMAT_YUV422:
> +	case DRM_FORMAT_NV61:
> +		xfactor /= 2;
> +		break;
> +
> +	/* YCbCr 4:2:0 */
> +	case DRM_FORMAT_YUV420:
> +	case DRM_FORMAT_NV21:
>   		yfactor /= 2;
>   		xfactor /= 2;
> +		break;
> +	default:
> +		break;
>   	}
>   
>   	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 2,


