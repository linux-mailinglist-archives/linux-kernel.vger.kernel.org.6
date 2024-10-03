Return-Path: <linux-kernel+bounces-348836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB97C98EC67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A861F22BBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F7146D55;
	Thu,  3 Oct 2024 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPRf/DSG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1F1465AE;
	Thu,  3 Oct 2024 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948593; cv=none; b=rM04JyJAgzv86a0gNBYHyAaHeQWZ/D5y4DENa2IlTeVs1e+KHgOMUYjTQdAlClaL1g30Sp2rySDzN7bs6J+M7DZv9Fg5jTAo4zYj3WsSaoV5t/4RnZ3Tx9eGF1grjcTy8TlbYKIyMaY/dgKhxXOOJOCT8Lt9IoEcBJG7UVH2PnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948593; c=relaxed/simple;
	bh=kKheSpvNhKnnOCs4OPuTFoh9bYM2IVoqL5zJ0I4iiA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0/maka1qBx2+WTu84jAB/yycTWEnPVW+T9fIbH9/Bih41rpv4DB1JCZnXVMLhrYQAnQBskQoAg7OwyTqzHx7xBsu1hJZiiGBK0Vl4KQlG/MfVX0yxWubcOYACd02L1IR57Z8fSGpvwInSnN9w1kSn3fWQWTq4U/oVrxsAx9yc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPRf/DSG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727948592; x=1759484592;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kKheSpvNhKnnOCs4OPuTFoh9bYM2IVoqL5zJ0I4iiA0=;
  b=aPRf/DSGO+v6faCuEZe1nSqYQkPRjs4DbgBxYn9sFfZq78ZLG5vhEHNA
   uhZeuq1XRA2HCyMmN6fcnUihkAPhsxblCd4e8Yc3YUUX0OVVfHsTDoRPm
   VPA7R3RHn7lUDdfEMeGtkQbKho/tI9C6POAfXd1ein8XTCUwPmuGqWuLn
   fOqZrS3eGXRdMl2eBN84NzP3GM2AaJAhie+D1+yTiHblKjOLwdAtbmjfN
   RngT5P9gnHjZhSXh8FYA/B0OHuqGdBS7+8tT8wuvsXRKH7pcg36YNpKas
   ibNNQkJR4fTywPw+jSXz9lVROteAyARe5njS3kKAknj9Yin+cpB86MtOA
   A==;
X-CSE-ConnectionGUID: 6LQSsV2ESVuP5zF4cXg6VQ==
X-CSE-MsgGUID: q4pgPw6gSaykf3ioyKC7tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27004820"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="27004820"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:43:10 -0700
X-CSE-ConnectionGUID: O4wAEbQkTLmaeFPky2TQRA==
X-CSE-MsgGUID: PWK+fE28TIuwbifN1Tu/fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="79062025"
Received: from soc-5cg4213gc7.clients.intel.com (HELO [10.66.114.183]) ([10.66.114.183])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:43:05 -0700
Message-ID: <6523649b-9143-42d8-b301-a143088530b9@intel.com>
Date: Thu, 3 Oct 2024 15:13:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/bridge: sii902x: Provide data-lines property to
 input endpoint
To: Wadim Egorov <w.egorov@phytec.de>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, bbrezillon@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, upstream@lists.phytec.de
References: <20241003082006.2728617-1-w.egorov@phytec.de>
Content-Language: en-US
From: Aradhya Bhatia <aradhya.bhatia@intel.com>
In-Reply-To: <20241003082006.2728617-1-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Wadim,

Thanks for the patch.

Probably a nit, but the dt-binding patch should come before the driver
patch.

On 03-10-2024 13:50, Wadim Egorov wrote:
> Introduce a data-lines property to define the number of parallel RGB
> input pins connected to the transmitter. The input bus formats are updated
> accordingly. If the property is not specified, default to 24 data lines.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 7f91b0db161e..3565c3533597 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -180,6 +180,8 @@ struct sii902x {
>  	struct gpio_desc *reset_gpio;
>  	struct i2c_mux_core *i2cmux;
>  	bool sink_is_hdmi;
> +	u32 pd_lines; /* number of Parallel Port Input Data Lines */
> +
>  	/*
>  	 * Mutex protects audio and video functions from interfering
>  	 * each other, by keeping their i2c command sequences atomic.
> @@ -477,6 +479,8 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>  						     u32 output_fmt,
>  						     unsigned int *num_input_fmts)
>  {
> +
> +	struct sii902x *sii902x = bridge_to_sii902x(bridge);
>  	u32 *input_fmts;
>  
>  	*num_input_fmts = 0;
> @@ -485,7 +489,19 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>  	if (!input_fmts)
>  		return NULL;
>  
> -	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
> +	switch (sii902x->pd_lines) {
> +	case 16:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB565_1X16;
> +		break;
> +	case 18:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X18;
> +		break;
> +	default:

For backward compatibility - in cases where the property is absent - you
have already defaulted sii902x->pd_lines to 24 below, which I think is
the right way.

So, the default case should be kept separately, as an error case -
which should then return back NULL / num_input_fmts = 0.

> +	case 24:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
> +	}
> +
>  	*num_input_fmts = 1;
>  
>  	return input_fmts;
> @@ -1167,6 +1183,15 @@ static int sii902x_probe(struct i2c_client *client)
>  		return PTR_ERR(sii902x->reset_gpio);
>  	}
>
> +	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
> +	if (endpoint) {
> +		ret = of_property_read_u32(endpoint, "data-lines", &sii902x->pd_lines);
> +		if (ret) {
> +			dev_dbg(dev, "Could not get data-lines, fallback to 24 data-lines\n");
> +			sii902x->pd_lines = 24;
> +		}
> +	}
> +
>  	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
>  	if (endpoint) {
>  		struct device_node *remote = of_graph_get_remote_port_parent(endpoint);

--
Regards
Aradhya


