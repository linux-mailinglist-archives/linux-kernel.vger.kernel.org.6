Return-Path: <linux-kernel+bounces-318350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EF496EC35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A10286BAB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129CC14E2C2;
	Fri,  6 Sep 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXmBOoaq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20A3C463;
	Fri,  6 Sep 2024 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608408; cv=none; b=TvA6ixwqfvydo84rJb5fON6GZuvT/kmqU0muzpUMRGt8sTfndDdgXVH38oYVh07nz1iFhZXiavUKHvbEXZyzWHko1WHFaOMpC4QTNhvMGpwXLmvwDjVEumcGVOS8ptC7QhGPVaLTlEeldIS143zaDclh+1Db58D31p+ecO+TCSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608408; c=relaxed/simple;
	bh=XRj7NGZW9ZhDviw+QZyekfwrwgq2vlVeyFWNZY0nv+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnsOGsguTO/TyCMJrODuJnLrpF0f82JVnEj8qcPqWBT00slEDNlnVzXsZWSGcceh6i2ShQ5D7WLge+dLHhPl8mKuT+H07MEImfRL+eo8gGn5HRZeoR+0KrJw7Vluq9vTHNEis3Trv5dl4OxhvgJ31v1mieqFDcWkovC6gPGDJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXmBOoaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD7BC4CEC4;
	Fri,  6 Sep 2024 07:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725608408;
	bh=XRj7NGZW9ZhDviw+QZyekfwrwgq2vlVeyFWNZY0nv+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXmBOoaqmmI6oxnRAgvB1ZnM2hLSIMAtj9r0b2Kf7+45BFcDXYT79vjGl/WctqRLw
	 Jx2OFLh17ljbG9rYzEFa1ES0tfZc91NxEVS93tBDbPWz2i68LjLDl1Ucyb5j3/RfhQ
	 +DA6IeD5vYyczMDDEcah4CJj7zZ2D4BTDRRLJ2kjs/iaWGT3QwL8KkAQDgwwYGfRuq
	 4obMZMx+pcatQAcVp/78jFjZjxVmO9YfaxE4efyn59Eq9TRxiX3Ryv+2eV34rgT5yy
	 A0lrztG3klQ1Rt/A1O3gwm2okvXQr5UzlZbO7Dux4q06lZbnZYj8c3YckgljpxHX5t
	 LvLx8JM5x+guA==
Date: Fri, 6 Sep 2024 09:40:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Yao <markyao0591@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>, 
	Luis de Arquer <ldearquer@gmail.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
Message-ID: <3wy2aoowmh7asdymtjccuzprwfah5xornelawg5ulnzj7gyfes@www2cgfnpdsx>
References: <20240906-b4-rk3588-bridge-upstream-v6-0-a3128fb103eb@collabora.com>
 <20240906-b4-rk3588-bridge-upstream-v6-2-a3128fb103eb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906-b4-rk3588-bridge-upstream-v6-2-a3128fb103eb@collabora.com>

On Fri, Sep 06, 2024 at 04:17:41AM +0300, Cristian Ciocaltea wrote:
> Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1
> Quad-Pixel (QP) TX controller IP.
> 
> Since this is a new IP block, quite different from those used in the
> previous generations of Rockchip SoCs, add a dedicated binding file.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml       | 189 +++++++++++++++++++++
>  1 file changed, 189 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
> new file mode 100644
> index 000000000000..37467685621d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml

...

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 2

You can drop minItems.

> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: ref
> +      - const: hdp

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


